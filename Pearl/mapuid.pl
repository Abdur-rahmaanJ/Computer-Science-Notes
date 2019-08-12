#
# This uses the Unix /etc/passwd file to map from a 
# userid to a numerical uid.  It accpets a list of
# userids on the command line, and maps each one.
#

use strict;

# The location of the password file.
my $pwd = "/etc/passwd";

#
# This function maps the indicated userid,
# and prints out the result.  The file
# itself is already opened with the global
# handle PWD
#
sub getuid {
    my ($userid) = @_;

    # Rewind the file, and read until 
    # the userid is found. 
    my($line);
    seek PWD, 0, 0;
    while($line = <PWD>) {
	# Split the line to get the fields we're interested in.
	my($puserid, $ppwd, $puid) = split(/:/, $line);

	# If we found it, print and return. 
	if($puserid eq $userid) {
	    print "UID for $userid is $puid.\n";
	    return;
	}
    }

    # If we got here, it didn't work.
    print "No such user $userid.\n";
}

# Open the passwd file and scan through
# the argument list.
open (PWD, $pwd) or die "Cannot open $pwd: $!.\n";

while(my $userid = shift @ARGV) {
    getuid($userid);
}

close PWD;
