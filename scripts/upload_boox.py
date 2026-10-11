#!/usr/bin/env python3
"""Upload committed PDFs changed since the last successful BOOX transfer."""

import json
import math
import os
from pathlib import Path, PurePosixPath
import shlex
import subprocess
import tempfile
from urllib.parse import urlsplit


CONFIG_KEYS = {
    "BOOX_UPLOAD_URL", "BOOX_REMOTE_DIR", "BOOX_PDF_DIR", "BOOX_STATE_FILE",
    "BOOX_CONNECT_TIMEOUT", "BOOX_UPLOAD_TIMEOUT",
}


def git(root, *args):
    return subprocess.check_output(["git", *args], cwd=root, stderr=subprocess.DEVNULL)


def load_config(root):
    """Read literal KEY=value assignments; exported environment takes precedence."""
    config = Path(os.environ.get("BOOX_ENV_FILE", root / ".env.boox"))
    if not config.is_absolute():
        config = root / config
    if not config.exists():
        return
    for line in config.read_text().splitlines():
        if not line.strip() or line.lstrip().startswith("#"):
            continue
        key, separator, value = line.partition("=")
        parts = shlex.split(value, comments=True)
        if not separator or key.strip() not in CONFIG_KEYS or len(parts) > 1:
            raise ValueError("Invalid BOOX configuration assignment")
        os.environ.setdefault(key.strip(), parts[0] if parts else "")


def timeout(name, default):
    value = float(os.environ.get(name, default))
    if not math.isfinite(value) or value <= 0:
        raise ValueError(f"{name} must be positive and finite")
    return value


def committed_pdfs(root, directory):
    revision = git(root, "rev-parse", "HEAD").decode().strip()
    pdfs = {}
    for entry in git(root, "ls-tree", "-rz", revision).split(b"\0"):
        if not entry:
            continue
        metadata, path = entry.split(b"\t", 1)
        mode, kind, oid = metadata.decode().split()
        path = os.fsdecode(path)
        if (mode in {"100644", "100755"} and kind == "blob"
                and path.startswith(directory + "/") and path.lower().endswith(".pdf")):
            pdfs[path] = oid
    # The device upload targets one existing directory; refuse name collisions.
    names = [PurePosixPath(path).name for path in pdfs]
    if len(names) != len(set(names)):
        raise ValueError("PDF filenames collide in the BOOX destination directory")
    if any("\r" in name or "\n" in name for name in names):
        raise ValueError("PDF filenames must not contain line breaks")
    return pdfs


def save_state(path, state):
    path.parent.mkdir(parents=True, exist_ok=True)
    temporary = None
    try:
        with tempfile.NamedTemporaryFile(mode="w", dir=path.parent, delete=False) as stream:
            temporary = Path(stream.name)
            json.dump(state, stream, indent=2)
            stream.write("\n")
        temporary.replace(path)
    finally:
        if temporary is not None:
            temporary.unlink(missing_ok=True)


def upload(root, path, oid, url, remote_dir, connect_timeout, upload_timeout):
    with tempfile.TemporaryDirectory(prefix="boox-upload-") as folder:
        pdf = Path(folder) / PurePosixPath(path).name
        content = git(root, "cat-file", "blob", oid)
        if not content.startswith(b"%PDF-"):
            raise ValueError("Committed file is not a PDF")
        pdf.write_bytes(content)
        # curl's form parser needs its own quoting, even without a shell.
        quoted_path = str(pdf).replace("\\", "\\\\").replace('"', '\\"')
        result = subprocess.run([
            "curl", "--disable", "--silent", "--show-error", "--fail",
            "--noproxy", "*", "--proto", "=http,https",
            "--connect-timeout", str(connect_timeout), "--max-time", str(upload_timeout),
            "--form-string", "dir=" + remote_dir, "--form-string", "sender=web",
            "--form", f'file=@"{quoted_path}";type=application/pdf', "--url", url,
        ], capture_output=True, timeout=upload_timeout + 2)
    if result.returncode:
        return False
    try:
        response = json.loads(result.stdout)
    except (ValueError, UnicodeError):
        return False
    return (isinstance(response, dict) and response.get("successful") is True
            and response.get("code") == 0)


def main():
    root = Path(git(None, "rev-parse", "--show-toplevel").decode().strip())
    load_config(root)
    url = os.environ.get("BOOX_UPLOAD_URL", "")
    if not url:
        return
    parsed_url = urlsplit(url)
    if (parsed_url.scheme not in {"http", "https"} or not parsed_url.hostname
            or parsed_url.username is not None or parsed_url.password is not None
            or parsed_url.fragment):
        raise ValueError("BOOX_UPLOAD_URL must be an HTTP(S) URL without credentials or fragment")
    remote_dir = os.environ.get("BOOX_REMOTE_DIR", "")
    if not remote_dir.startswith("/"):
        raise ValueError("BOOX_REMOTE_DIR must be an absolute device directory")
    directory = PurePosixPath(os.environ.get("BOOX_PDF_DIR", "output"))
    if directory.is_absolute() or ".." in directory.parts or str(directory) == ".":
        raise ValueError("BOOX_PDF_DIR must be a directory relative to the repository")
    pdfs = committed_pdfs(root, str(directory))
    destination = [url, remote_dir, str(directory)]
    state_file = Path(os.environ.get("BOOX_STATE_FILE") or
                      os.fsdecode(git(root, "rev-parse", "--git-path", "boox-upload.json")).strip())
    if not state_file.is_absolute():
        state_file = root / state_file
    state = json.loads(state_file.read_text()) if state_file.exists() else {}
    if not isinstance(state, dict):
        raise ValueError("Invalid BOOX upload state")
    uploaded = state.get("uploaded", {}) if state.get("destination") == destination else {}
    if not isinstance(uploaded, dict):
        raise ValueError("Invalid BOOX uploaded-file record")
    pending = [path for path, oid in pdfs.items() if uploaded.get(path) != oid]
    if not pending:
        return
    connect_timeout = timeout("BOOX_CONNECT_TIMEOUT", "1")
    upload_timeout = timeout("BOOX_UPLOAD_TIMEOUT", "15")
    uploaded = {path: oid for path, oid in uploaded.items() if path in pdfs}
    for path in sorted(pending, key=lambda path: PurePosixPath(path).name):
        if not upload(root, path, pdfs[path], url, remote_dir, connect_timeout, upload_timeout):
            print("BOOX: upload unavailable or rejected; pending PDFs kept for the next run.")
            return
        uploaded[path] = pdfs[path]
        save_state(state_file, {"destination": destination, "uploaded": uploaded})
        print(f"BOOX: uploaded {path}")


if __name__ == "__main__":
    try:
        main()
    except (OSError, ValueError, subprocess.SubprocessError) as error:
        # Uploads are optional. Do not leak response bodies, URLs, or credentials.
        detail = str(error) if isinstance(error, ValueError) else type(error).__name__
        print(f"BOOX: skipped ({detail}); pending PDFs kept for the next run.")
