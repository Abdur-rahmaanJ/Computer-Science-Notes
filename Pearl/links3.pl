#
# This is a version of links2 which uses the $/ variable to change the
# unit which reading reads.  The $/ variable may contain any string, and
# it is used as the line separator.  We can set it to '<' to (usually)
# avoid breaking an HTML tag.  This will fail when 
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

    # The $/ variable determines what character separates lines.  We'll set
    # to '>' since we're more interested in tags than lines.  We save the old
    # value of $/ and restore it later.  Good practice, though it doesn't
    # actually matter in this program.
    my $oldsl = $/;
    $/ = '>';

    # Go through each unit in the file.  Note that each unit may contain
    # multiple lines, but cannot contain more than one HTML tag.  It may
    # split a tag if a > occurs inside a tag, which can happen only if the
    # > is inside quotes.
    my $ln;					  
    while($ln = <IN>) {
	# Throw away through the first < and spaces.
	$ln =~ s/^[^\<]*\<\s*//;

	# On the off chance that someone put a > in quotes, check for
	# balance.  The horrid pattern checks for a string containing an
	# odd number of quotes.  If we find one, we simply read another
	# unit, tack in on, and use perl redo to repeat the loop w/o
	# running the test (and clobbering $ln).  However, if you say
	# while(my $ln = <IN>) in the loop test, the redo loses the value
	# of $ln, because it gets reallocated.
	if($ln =~ /^[^"]*("[^"]*")*[^"]*"[^"]*$/) {
	    my $more = <IN> or last;
	    $ln .= $more;
	    redo;
	}

	# Extract the URL from the A tag.  This pattern is different
	# from the others since it also deals with > in quotes.  (Now,
	# how often will that happen?)
	$ln =~ s/^A\s+([^>]|"[^"]*")*HREF\s*\=\s*"([^"]+)"//i or next;
	my $ref = $2;

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

    close IN;
    $/ = $oldsl;
    return 1;
}

# 
# Process each command-line argument as a file.
while(my $fn = shift @ARGV) {
    print "$fn:\n";
    if(!scan($fn)) { print "[Download $fn failed: $!]\n"; }
}
