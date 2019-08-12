use strict;

# This script prints out its environment varibles in sorted order.
foreach my $key (sort keys(%ENV)) {
    print "$key=$ENV{$key}\n";
}
