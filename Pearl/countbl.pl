#
# This reads from the standard input and counts the number 
# lines which are blank, and lines which are entirely perl-style
# comments (begin with # as the first non-blank character.)  It reports
# these figures.
#

use strict;

# Counters to return.
my $nblank = 0;
my $ncomm = 0;

# Read each line into the variable $line.
while(my $line = <STDIN>) {
    if($line =~ /^\s*$/) { ++$nblank; }
    if($line =~ /^\s*\#/) { ++$ncomm; }
}

print "$nblank blank lines, $ncomm comments.\n";
