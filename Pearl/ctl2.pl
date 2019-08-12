#
# Perl postfix conditionals (which are actually expression operators).
# They follow what they control and don't use { }.

use strict;

# Read some lines.
my $wasquit = 0;
print "ctl2> ";
while(my $line = <STDIN>) {
    chomp $line;
    print "Jones\n" if $line eq 'smith';

    # Quitting is here.
    if($line eq 'stop') {
	print "That's better.\n" if $wasquit;
	last;
    }
    if($line eq 'quit') {
	$wasquit = 1;
	print "You must say stop if you want to quit.\n";
    } else {
	$wasquit = 0;
    }

    print "$line to you!\n" if $line;

    print "ctl2> " unless $line eq 'sssh';
}

