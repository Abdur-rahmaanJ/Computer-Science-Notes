use strict;

# This script prints out its environment varibles.  Under Unix, its output
# looks a lot like the results of the printenv command.
my @keys = keys(%ENV);
while(my $key = shift @keys) {
    print "$key=$ENV{$key}\n";
}
