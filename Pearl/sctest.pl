#
# Test srcclass.pm
use strict;
use srcclass;

my $path = srcclass->create;

print $path->the_path . "\n";

foreach my $fn (qw(ls bash cthru startx modprobe bogus zip javac)) {
    my $fullfn = $path->find_file($fn);
    print "$fn => $fullfn\n";
}

$path->add_dir("/some/bogus/place/");

$path->add_dir_before("/this/that/theother", "/usr/sbin");

print $path->the_path . "\n";
