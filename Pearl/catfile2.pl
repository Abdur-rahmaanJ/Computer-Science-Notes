use strict;

#
# This script takes a list of file names, and opens and prints each one.
#
while(my $fn = shift @ARGV) {

    # Open the file.
    if(!open(INFILE, $fn)) {
	print STDERR "Cannot open $fn: $!\n";
	next;
    }

    # Copy it.
    while(my $l = <INFILE>) {
	print $l;
    }

    close INFILE;
}
