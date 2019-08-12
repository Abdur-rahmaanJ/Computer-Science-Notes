#
# This script scans a list of C programs and
# tries to find if statements which do assignments.
# Specifically, it looks for any line which contains
# text of the form if(....), where if is the first
# non-blank thing on the line, and the (....) contains
# an = which is not part of ==, !=, <=, or >=.
# Each such line is listed with the file name and the
# line number.  This is not a perfect check, but it
# will do a decent job.
#

#
# This function analyzes one line to see if it it
# is suspicious.  If so, it prints it.  It also updates
# the global flag $badfound, and prints an extra message
# the first time a bad line is found.  It should be 
# called as
#    check_line (filename, line)
# where the filename is used only when a message is
# generated.  The $. line number is used also.
#

use strict;

my $badfound = 0;
sub check_line {
    my($fn, $line) = @_;

    # Check for that =.
    if($line =~ /^\s*if\s*\(.*[^!<>=]=([^=].*\)|\))/) {
	if(!$badfound) {
	    print("The following suspicious lines were found:\n");
	    $badfound = 1;
	}
	print "$fn:$.: $line\n";
    }
}

#
# This function opens and reads one file, and calls
# check_line to analyze each line.  Call it with the
# file name.
#
sub check_file {
    my($fn) = @_;

    if(!open(IN, $fn)) {
	print "Cannot read $fn.\n";
	return;
    }

    my($line);
    while($line = <IN>)
    {
	chomp $line;
	check_line($fn,$line);
    }

    close IN;
}

#
# Go through the argument list and check each file
#
while(my $fn = shift @ARGV) {
    check_file($fn);
}
if(!$badfound) { print "No suspicious lines were found.\n"; }
