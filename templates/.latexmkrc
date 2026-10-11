# Share the same package lookup when previewing templates from this directory.
use Cwd qw(abs_path);
use File::Basename qw(dirname);
use File::Spec;
my $config = File::Spec->catfile(dirname(abs_path(__FILE__)), '..', '.latexmkrc');
do $config or die "Cannot load repository latexmk configuration: $@ $!";
