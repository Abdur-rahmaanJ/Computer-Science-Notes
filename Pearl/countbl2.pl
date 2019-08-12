#
# This reads each file on the command line, and for each counts the
# lines which are blank, and lines which are entirely perl-style
# comments (begin with # as the first non-blank character.)  It reports
# the figures for each one, and the totals.
#

use strict;

#
# Take the file name and return either (numblank, comment) or (-1, err) if
# the file could not be opened.
sub count {
    my ($fn) = @_;

    # Open the file; return any possible failure.
    open(IN, $fn) or return (-1, $!);

    # Counters to return.
    my $nblank = 0;
    my $ncomm = 0;

    # Read each line into the variable $line.
    while(my $line = <IN>) {
	if($line =~ /^\s*$/) { ++$nblank; }
	if($line =~ /^\s*\#/) { ++$ncomm; }
    }

    close IN;

    return ($nblank, $ncomm);
}

# Keep this for later.
my $nfiles = @ARGV;

# Keep totals
my $totbl = 0;
my $totcom = 0;

# Run through the command line args and process each one.
while(my $fn = shift @ARGV) {
    # Print the filename with padding to 20 positions.  Printf works
    # pretty much as in C, but there's less use for it in perl.  I'm using
    # it here to get the blank padding inserted by %20s.
    printf("%-20s", "$fn:");

    # Process the file, print the results.
    my ($blcount, $commcount) = count($fn);
    if($blcount < 0) {
	print "Not readable.\n";
    } else {
	print "$blcount blank lines, $commcount comments.\n";
	$totbl += $blcount;
	$totcom += $commcount;
    }
}

# Print toals, if there was more than one file.  The x operator makes
# repeated copies of a string, so " " x 11 prints eleven spaces.
if($nfiles > 1) {
    print "* TOTAL *", " " x 11, "$totbl blank lines, $totcom comments.\n";
}
