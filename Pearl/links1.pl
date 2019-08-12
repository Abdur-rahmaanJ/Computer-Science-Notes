#
# Takes a list of file names and lists the URLS they link by A tags.
# May have trouble with anchors which are not all on the same line.
#

use strict;

#
# Scan a file and print all the URL's it links to.
sub scan {
    my ($fn) = @_;

    open(IN, $fn) or return 0;

    # Go through each line in the file.
    while(<IN>) {
	# Repeatedly match URLs in the line.  Each one is removed by
	# replacing it with the empty string.  The loop body will execute
	# once for each match/replace, and prints the URL part of the
	# matched text.
	while(s/<\s*A\s+[^>]*HREF\s*\=\s*"([^"]+)"//i) {
	    print "   $1\n";
	}
    }

    close IN;
    return 1;
}

# 
# Process each command-line argument as a file.
while(my $fn = shift @ARGV) {
    print "$fn:\n";
    if(!scan($fn)) { print "[Open $fn failed: $!]\n"; }
}
