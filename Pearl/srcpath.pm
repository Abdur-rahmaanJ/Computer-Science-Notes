#
# This module operates on the command search path.  Directories can be
# added to the path list, and the list can be searched.
package srcpath;
use strict;

# The path itself.  Data local to the package.
my $path;

#
# Initialize the path to current search path.  BEGIN is a special block of
# of code which is run when the module is loaded.  It initializes the path
# from the environment variable PATH, or from a default.
BEGIN {
    if(exists $ENV{"PATH"}) {
	# Copy the existing path and strip trailing /'s from components.
	$path = $ENV{"PATH"};
	$path =~ s|/:|:|g;
	$path =~ s|/$||;
    } else {
	$path = "/bin:/usr/bin:/usr/local/bin";
    }
}

#
# Return the current path.
sub the_path {
    return $path;
}

#
# Find the executable file on the path, and return the full path, or empty 
# string.
sub find_file {
    my($fn) = @_;

    my $pcom;
    foreach $pcom (split(/:/, $path)) {
	if(-x "$pcom/$fn") { return "$pcom/$fn"; }
    }

    return "";
}

#
# Add to the end of the path.
sub add_dir {
    my($dir) = @_;

    $dir =~ s|/$||;
    $path = "$path:$dir";
}

#
# Add the first to the path before the second.  If no match found, not added.
# Return success.
sub add_dir_before {
    my($dir, $beforethis) = @_;

    $dir =~ s|/$||;

    # This breaks up the path into the parts before and after what is
    # sought.  The :'s must be added to $path to make sure that the match
    # is exactly equal to one component, so then they must be added to the
    # the path to match at th ends.  
    my($before, $after) = split(/:$beforethis:/, ":$path:", 2);

    # See if the split worked.
    if($before ne ":$path:") {
	# Put it back together and clean up any exter :'s front and back.
	$path = "$before:$dir:$beforethis:$after";
	$path =~ s/^://;
	$path =~ s/:$//;

	return 1;
    }
    else {
	return 0;
    }
}

1;
