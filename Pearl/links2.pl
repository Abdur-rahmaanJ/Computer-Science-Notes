#
# This is similar to links1.pl, but it takes a list of absolute URLs, downloads
# their contents, and attempts to print the URLs in absolute form.  Still will
# have trouble with anchors which are not all on the same line.  
#
# This won't work directly on Windows because it runs lynx to fetch the
# pages.
#

use strict;

#
# Scan a URL and print all the URL's it links to.
sub scan {
    my ($url) = @_;

    # URLs that denote directories are s'posed end with a /.  We really
    # need to talk to the server and read the response headers, but this 
    # sort of guess usually works.
    if($url !~ m|/$| && $url !~ m|\.htm(l?)$|) {
	$url .= '/';
    }

    # Do surgery on the url to extract certain parts.

    # Find the protocol://hostname part.
    $url =~ m@^([a-zA-Z]+\://[a-zA-Z\.]+)(/|$)@;
    my $prothost = $1;

    # Find the URL with the last component removed.
    my $stem = $url;
    $stem =~ s|/[^/]*$|/|;

    # This form of open runs the command and pipes its output to the
    # perl program through the file handle.  Reads from IN will return
    # a line of output from the lynx command.  This form the lynx command
    # simply fetchs the contents of a URL and prints its text to standard
    # output.  The -useragent option keeps remote sites from getting rid
    # of non-text-friendly code (which some do when you are using lynx),
    # and the 2>/dev/null is Unix shell notation which discards error messages.
    open(IN, "lynx -useragent=fred -source $url 2>/dev/null|") or return 0;

    # Go through each line in the file.
    while(<IN>) {
	# Repeatedly match URLs in the line.  Each one is removed by
	# replacing it with the empty string.  The loop body will execute
	# once for each match/replace, and prints the URL part of the
	# matched text.
	while(s/<\s*A\s+[^>]*HREF\s*\=\s*"([^"]+)"//i) {
	    my $ref = $1;

	    # Make the reference absolute.
	    if($ref =~ m|^[a-zA-Z]*\://|) {
		# Already absolute.
	    } elsif($ref =~ m|^/|) {
		# Relative to host.
		$ref = "$prothost$ref";
	    } else {
		# Relative to page location.
		$ref = "$stem$ref";
	    }

	    print "   $ref\n";
	}
    }

    close IN;
    return 1;
}

# 
# Process each command-line argument as a file.
while(my $fn = shift @ARGV) {
    print "$fn:\n";
    if(!scan($fn)) { print "[Download $fn failed: $!]\n"; }
}
