use strict;

# Here's another way to print all the command line arguments.  The perl
# for loop is much like the C for loop.
for(my $sub = 0; $sub <= $#ARGV; ++$sub) {
    print "$ARGV[$sub]\n";
}
print "[@ARGV]\n";
