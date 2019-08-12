use strict;

# This script simply prints its command line arguments, one per line.

my $sub = 0;
while($sub <= $#ARGV) {
    print "$ARGV[$sub]\n";
    ++$sub;
}
print "[@ARGV]\n";
