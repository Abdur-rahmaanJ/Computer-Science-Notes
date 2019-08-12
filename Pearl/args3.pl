use strict;

# Here is yet another way to print out all the arguments.  The foreach
# command loops through the members of an array and assigns some variable
# to each one in turn.
foreach my $arg (@ARGV) {
    print "$arg\n";
}
print "[@ARGV]\n";
