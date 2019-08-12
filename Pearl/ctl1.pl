use strict;

# Read some lines, concat them together (separated by a space), and print them.
# How exciting.  Stops when it reaches the indicated count, the
# end of file, or the line STOP!

# Read the number.
print "How many lines? ";
my $num = <STDIN>;
$num > 0 or die "Num must be positive.  You entered $num";

# Read in the strings.
my $accum = "";
my $sep = "";
while(my $line = <STDIN>) {
    chomp $line;
    if($line eq "STOP!") { last; }
    $accum = "$accum$sep$line";
    if(--$num == 0) { last; }
    $sep = " ";
}

# Print what we got.
print "$accum\n";

