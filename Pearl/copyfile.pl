use strict;

#
# This script takes two file names, and copies the first one to the second.
#
if($#ARGV != 1) {
    print STDERR "You must specify exactly two arguments.\n";
    exit 4;
}

# If the output exists, confirm.  This uses two standard string functions,
# substring and lower-case.
if( -e $ARGV[1]) {
    print "Do you really want to overwrite $ARGV[1]? ";
    my $resp = <STDIN>;
    chomp $resp;
    if(lc(substr($resp, 0, 1)) ne 'y') { exit 0; }
}

# Open the files.
open(INFILE, $ARGV[0]) or die "Cannot open $ARGV[0]: $!.\n";
open(OUTFILE, ">$ARGV[1]") or die "Cannot write $ARGV[1]: $!.\n";

while(my $l = <INFILE>) {
    print OUTFILE $l;
}

close INFILE;
close OUTFILE;
