#
# Test the srcpath module.
use strict;
use srcpath;

print &srcpath::the_path . "\n";

foreach my $fn (qw(ls bash cthru startx modprobe bogus zip javac)) {
    my $fullfn = srcpath::find_file($fn);
    print "$fn => $fullfn\n";
}

srcpath::add_dir("/some/bogus/place/");

srcpath::add_dir_before("/this/that/theother", "/usr/sbin");

print &srcpath::the_path . "\n";
