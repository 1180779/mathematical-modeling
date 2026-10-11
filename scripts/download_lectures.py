#!/usr/bin/env python3
"""Download the complete MIT 6.251J and UCLA ECE236B lecture sets."""

import argparse
from html.parser import HTMLParser
import os
from pathlib import Path
import re
import subprocess
import sys
import tempfile
from urllib.parse import urljoin, urlsplit


ROOT = Path(__file__).resolve().parents[1]
MIT = "https://ocw.mit.edu/courses/6-251j-introduction-to-mathematical-programming-fall-2009/"
UCLA = "https://www.seas.ucla.edu/~vandenbe/ee236b/"
MIT_NAMES = {
    5: "simplex", 6: "simplex-anticycling", 7: "simplex-initialization",
    8: "duality", 9: "dual-simplex", 10: "polyhedral-representation",
    12: "sensitivity",
}


class Links(HTMLParser):
    def __init__(self):
        super().__init__()
        self.hrefs = []

    def handle_starttag(self, tag, attrs):
        if tag == "a":
            self.hrefs.extend(value for key, value in attrs if key == "href" and value)


def links(html, page, prefix):
    parser = Links()
    parser.feed(html.decode("utf-8"))
    return list(dict.fromkeys(
        url for href in parser.hrefs
        if (url := urljoin(page, href)).startswith(prefix)
        and not urlsplit(url).query and not urlsplit(url).fragment
    ))


def fetch(url, target):
    subprocess.run([
        "curl", "--disable", "--fail", "--location", "--silent", "--show-error",
        "--proto", "=https", "--proto-redir", "=https",
        "--connect-timeout", "5", "--max-time", "30",
        "--retry", "2", "--retry-delay", "1", "--retry-max-time", "60",
        "--output", str(target), "--url", url,
    ], check=True, timeout=95)


def html_page(url):
    with tempfile.TemporaryDirectory(prefix="lecture-index-") as scratch:
        target = Path(scratch) / "index.html"
        fetch(url, target)
        return target.read_bytes()


def lecture_links(provider):
    if provider == "mit":
        page = MIT + "pages/lecture-notes/"
        resources = links(html_page(page), page, MIT + "resources/")
        if not resources:
            raise ValueError("MIT lecture index contains no resource links")
        for resource in resources:
            match = re.search(r"/mit6_251jf09_lec(\d+)/?$", urlsplit(resource).path)
            if not match:
                raise ValueError(f"Unexpected MIT lecture resource: {resource}")
            number = int(match[1])
            suffix = "-" + MIT_NAMES[number] if number in MIT_NAMES else ""
            yield resource, f"mit-6-251j-2009-lecture-{number:02d}{suffix}.pdf"
    else:
        pdfs = [url for url in links(html_page(UCLA), UCLA, UCLA + "lectures/")
                if urlsplit(url).path.lower().endswith(".pdf")]
        if not pdfs:
            raise ValueError("UCLA lecture index contains no PDF links")
        for url in pdfs:
            stem = Path(urlsplit(url).path).stem
            if not re.fullmatch(r"[a-z0-9-]+", stem):
                raise ValueError(f"Unexpected lecture filename: {stem}")
            year = 2023 if stem == "num-lin-alg" else 2026
            yield url, f"ece236b-{year}-{stem}.pdf"


def pdf_url(url):
    if urlsplit(url).path.lower().endswith(".pdf"):
        return url
    pdfs = [link for link in links(html_page(url), url, MIT)
            if urlsplit(link).path.lower().endswith(".pdf")]
    if len(pdfs) != 1:
        raise ValueError(f"Expected one lecture PDF at {url}")
    return pdfs[0]


def valid_pdf(path):
    if not path.is_file() or path.is_symlink():
        return False
    with path.open("rb") as stream:
        header = stream.read(5)
        stream.seek(max(0, path.stat().st_size - 1024))
        return header == b"%PDF-" and b"%%EOF" in stream.read()


def download(url, target):
    if target.is_symlink():
        raise ValueError(f"Refusing to replace a symlink: {target}")
    if valid_pdf(target):
        print(f"Already present: {target}", flush=True)
        return
    target.parent.mkdir(parents=True, exist_ok=True)
    with tempfile.NamedTemporaryFile(dir=target.parent, suffix=".part", delete=False) as stream:
        temporary = Path(stream.name)
    try:
        fetch(url, temporary)
        if not valid_pdf(temporary):
            raise ValueError(f"Response is not a complete PDF: {url}")
        temporary.replace(target)
        print(f"Downloaded: {target}", flush=True)
    finally:
        temporary.unlink(missing_ok=True)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--dest", type=Path,
                        default=os.environ.get("LECTURE_SOURCES_DIR") or ROOT.parent / "sources",
                        help="source directory (default: sibling sources/, or LECTURE_SOURCES_DIR)")
    parser.add_argument("--dry-run", action="store_true", help="fetch indexes and list files without downloading PDFs")
    args = parser.parse_args()
    destination = args.dest.expanduser().resolve()
    failures = 0
    for provider in ("mit", "ucla"):
        print(f"Reading {provider.upper()} lecture index…", flush=True)
        try:
            for url, name in lecture_links(provider):
                target = destination / provider / name
                try:
                    if not args.dry_run and valid_pdf(target):
                        print(f"Already present: {target}", flush=True)
                        continue
                    url = pdf_url(url)
                    print(f"{url}\n  -> {target}", flush=True)
                    if not args.dry_run:
                        download(url, target)
                except (OSError, ValueError, subprocess.SubprocessError) as error:
                    failures += 1
                    print(f"Failed: {name}: {error}", file=sys.stderr, flush=True)
        except (OSError, ValueError, subprocess.SubprocessError) as error:
            failures += 1
            print(f"Cannot read {provider.upper()} lecture index: {error}", file=sys.stderr, flush=True)
    if failures:
        print(f"{failures} failures; rerun to retry. Existing PDFs are kept.", file=sys.stderr)
    return int(bool(failures))


if __name__ == "__main__":
    sys.exit(main())
