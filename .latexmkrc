# Resolve the shared package independently of the compiler's working directory.
use Cwd qw(abs_path);
use File::Basename qw(dirname);
use Config;

my $repo_root = dirname(abs_path(__FILE__));
# An empty final entry preserves the installed TeX distribution's search path.
$ENV{TEXINPUTS} = join($Config{path_sep}, $repo_root, "$repo_root/templates",
                      $ENV{TEXINPUTS} // '', '');
1;
