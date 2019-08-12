#
# This module provides the same functionality as srcpath.pm, but it
# uses the object-oriented interface.  It is a bit more general, as the
# programmer can create multiple path objects.
package srcclass;
use strict;

sub create {
    my $path;

    # Initialize from the current path or a default.
    if(exists $ENV{"PATH"}) {
	$path = $ENV{"PATH"};
	$path =~ s|/:|:|g;
	$path =~ s|/$||;
    } else {
	$path = "/bin:/usr/bin:/usr/local/bin";
    }

    # The bless operation binds the reference to this class.
    return bless \$path;
}

#
# Get the current path.
sub the_path {
    my $self = shift @_;

    return $$self;
}

#
# Find the file on the path, and return the full path, or empty string.
sub find_file {
    my($self, $fn) = @_;

    my $pcom;
    foreach $pcom (split(/:/, $$self)) {
	if(-x "$pcom/$fn") { return "$pcom/$fn"; }
    }

    return "";
}

#
# Add to the end of the path.
sub add_dir {
    my($self, $dir) = @_;

    $dir =~ s|/$||;
    $$self = "$$self:$dir";
}

#
# Add the first to the path before the second.  If no match found, not added.
# Return success.
sub add_dir_before {
    my($self, $dir, $beforethis) = @_;

    $dir =~ s|/$||;

    my($before, $after) = split(/:$beforethis:/, ":$$self:", 2);
    if($before ne ":$$self:") {
	$$self = "$before:$dir:$beforethis:$after";
	$$self =~ s/^://;
	$$self =~ s/:$//;

	return 1;
    }
    else {
	return 0;
    }
}

1;
