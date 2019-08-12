#
# Normally variables in perl need not be declared.  This can be
# changed with the following directive.
use strict;

# The my function declares the variable.
my $fred;
$fred = "I am Fred.";
print "$fred  Fred I am.\n";

# Declare and initialize.
my $qty = 57;
$qty = $qty + 10;
print "We have $qty on hand.\n";

my @joe = (1, $qty, 2*$qty, $qty*$qty);
print "$joe[0], $joe[1], $joe[2] and $joe[3]\n";

my %goombah;
$goombah{'a'} = 'anaconda';
$goombah{'b'} = 'barracuda';
$goombah{'c'} = 'carbuncle';
print "a is for $goombah{'a'}, b is for $goombah{'b'} and ",
    "c is for $goombah{'c'}.\n";
