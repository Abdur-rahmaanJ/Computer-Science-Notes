# Simple array constructs.
@fred = ("How", "are", "you", "today?");
print "\@fred contains (@fred).\n";

$mike = $fred[1];
print "$mike $fred[3]\n";

# The array name in a scalar context gives the size.
$fredsize = @fred;
print '@fred has ', "$fredsize elements.\n";

# The $#name gives the max subscript (size less one).
print "Max sub is $#fred\n";

