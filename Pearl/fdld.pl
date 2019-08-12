#!/usr/bin/perl
use strict;
use Tk;
use Tk::Dialog;
use Net::FTP;

# Colors
my @PBG = (-background => '#E6E6FA');
my @ABG = (-activebackground => '#FFE6FA');
my @PFG = (-foreground => '#0000ff');
my @AFG = (-activeforeground => '#0000ff');
my @PCL = (@PBG, @PFG);
my @BG = (@PBG, @ABG);
my @FG = (@PFG, @AFG);
my @CL = (@BG, @FG);

# Description (font and color) of a title.
my @titdesc = (-font => ['Arial', 16, 'bold'], -foreground => '#228800');

my $main = new MainWindow(@PCL);
$main->title("FTP Download");

# Login information.
my ($host, $acct, $password);

# FTP connection.
my $conn;

# Boom msg.
sub ebox {
    my $msg = shift @_;
    $msg = $msg->message() if ref $msg;

    $main->messageBox(-type => 'OK', -icon => 'error', -message => $msg);
    return;
}

# Generate s label/entry pair for the login window.  These will be 
# appropriately gridded on row $row inside $par.  Text box has width
# $width and places its contents into the reference $ref.  If $ispwd,
# treat it as a password entry box.
sub genpair {
    my ($par, $row, $text, $ref, $width, $ispwd) = @_;

    my $tbut = $par->Label( -text => $text, @PCL);
    my $lab = $par->Entry(-background => 'white', 
			  # -activebackground => 'white',
			  -foreground => 'black', 
			  #-activeforeground => 'black',
			  -textvariable => $ref,
			  -width => $width);
    $lab->configure(-show => '*') if $ispwd;
    $tbut->grid(-row => $row, -column => 0, -sticky => 'nse');
    $lab->grid(-row => $row, -column => 1, -sticky => 'nsw');
}

# Terminate pgm.
sub term {
    $conn->quit if $conn;
    exit 0;
}

# Build the login window.
sub logscreen {
    my $parent = shift @_;

    my $row = 0;

    my $toplab = $parent->Label(-text => "FTP Server Login",
				-justify => 'center',
				@titdesc, @PBG);
    $toplab->grid(-row => $row++, -column => 0, 
		  -columnspan => 2, -sticky => 'news');
    genpair($parent, $row++, 'Host:', \$host, 25);
    my $bframe = $parent->Frame();
    $bframe->grid(-row => $row++, -column => 0, 
		  -columnspan => 2, -sticky => 'news');
    my $go = $bframe->Button(-text => 'Anon. Login', 
			     -command => [ \&do_login, 0, $parent, 1 ], 
			     @CL);
    $go->pack(-side => 'left', -expand => 'left', -fill => 'both');
    my $go = $bframe->Button(-text => 'User Login', 
			     -command => [ \&do_login, 0, $parent, 2 ], 
			     @CL);
    $go->pack(-side => 'left', -expand => 'left', -fill => 'both');

    genpair($parent, $row++, 'Login:', \$acct, 15);
    genpair($parent, $row++, 'Password:', \$password, 15, 1);


    my $stop = $parent->Button(-text => 'Exit', 
			       -command => \&term , @CL);
    $stop->grid(-row => $row++, -column => 0, -columnspan => 2, 
		-sticky => 'news');

    # CR same as pushing login.
    $parent->bind('<KeyPress-Return>', [ \&do_login, $parent, 3 ] );
}

# Log into the remote host.  If successful, start the directory loader.
# Modes are: 1: Anonymous, 2: User, 3: Return, which does anon if the
# user infor was not filled in, and user otw.
sub do_login {
    my ($discard, $par, $mode) = @_;

    # Adjust user data by mode.
    if($mode == 1 || ($mode == 3 && !$acct && !$password)) {
	$acct = 'anonymous';
	$password = 'anonymous' unless $password;
    }

    # Make sure we're all filled in.
    if(!$host || !$acct || !$password) {
	ebox("You must provide a host, user name and password.");
	return;
    }

    # Attempt to connect to the remote host.
    $conn = Net::FTP->new($host, Passive => 1, -debug => 1);
    if(!defined $conn) {
	ebox("FTP Connection to $host failed ($!).");
	return;
    }

    # Try the login.
    if(!$conn->login($acct, $password)) {
	ebox($conn);
	$conn->close();
	return;
    }
    $conn->binary();

    &load_dir();

    $par->destroy();

    #$conn->quit();
}

# Create the main list box with scrollbar.
my $listarea;	# Where stuff goes.
my $statuslab;  # Status information is posted here.
sub main_list {
    my $par = shift @_;

    # Label at top.
    my $toplab = $par->Label(-text => "FTP Download Agent",
			     -justify => 'center', @titdesc, @PBG);
    $toplab->pack(-side => 'top', -fill => 'x');

    # Status label.
    $statuslab = $par->Label(-text => "Not Logged In",
			     -justify => 'center', @PCL);
    $statuslab->pack(-side => 'top', -fill => 'x');

    # Exit button
    my $exbut = $par->Button(-text => "Exit", -command => \&term, @CL);
    $exbut->pack(-side => 'bottom', -fill => 'x');

    # List area with scroll bar.  The list area is disabled since we
    # don't want the user to type into it.
    $listarea = $par->Text(-height => 10, -width => 40, 
			   -cursor => 'sb_left_arrow',
			   -state => 'disabled', @PCL);
    my $scr = $par->Scrollbar(-command => [ $listarea => 'yview' ], @PBG);
    $listarea->configure(-yscrollcommand => [ $scr => 'set' ]);
    $scr->pack(-side => 'right', -fill => 'y');
    $listarea->pack(-side => 'left');

    # Bind the system exit button to our exit.
    $main->protocol('WM_DELETE_WINDOW', \&term);
}

# Change the color of a tag for entering and leaving.  Unfortunately, there
# is no active color for tags in a text box.
sub recolor {
    my ($tw, $tag, $color) = @_;
    $tw->tagConfigure($tag, -foreground => $color);
    #print "FRED: $tw $tag $color\n";
}

# Do a CD and load the contents.  If there is no directory name, skip
# the CD.
sub load_dir
{
    my ($wid, $dir) = @_;

    #print "load_dir($dir)\n";

    # Change directory.
    if(@_) {
	if(!$conn->cwd($dir)) {
	    ebox($conn);
	    return;
	}
	$statuslab->configure(-text => "[Loading $dir]");
    } else {
	$statuslab->configure(-text => '[Loading Home Dir]');
    }
    $main->update();


    # Get the list of files.
    my @names = $conn->dir();
    if(!$conn->ok()) {
	ebox($conn);
	return;
    }

    my @files = ();
    my @dirs = ();
    my $sawdots = 0;
    while(my $n = shift @names) {
	# Split the lines (assume Unix format)
	chomp $n;

	# Real lines start with the perm bits.  And we don't want specials.
	next if $n !~ /^[\-d]([r\-][w\-][x\-]){3}/;

	# Extract the useful parts, toss the bones.
	my @parts = split(/\s+/, $n, 9);
	next if @parts < 9;
	my $fn = pop @parts;
	$sawdots = 1 if $fn eq '..';
	my $modes = shift @parts;
	if($modes =~ /^d/) {
	    push @dirs, $fn;
	} else {
	    push @files, $fn;
	}
    }

    # Add .. if not present, then sort the list.
    push @dirs, '..' unless $sawdots;
    @files = sort @files;
    @dirs = sort @dirs;

    # Fill in the text box.  We also bind lots of events to the file names
    # to make stuff happen when we move the mouse around.
    $listarea->configure(-state => 'normal');
    $listarea->delete('1.0','end');
    my $ct = 0;
    while(my $f = shift @dirs) {
	#print "Inserting dir: [$f]\n";
	$listarea->insert('end', "$f\n", "fn$ct");
	$listarea->tagConfigure("fn$ct", -foreground => '#4444ff');
	$listarea->tagBind("fn$ct", '<Button-1>', [ \&load_dir, $f ]);
    	$listarea->tagBind("fn$ct", '<Enter>', 
			   [ \&recolor, "fn$ct", '#000088' ]);
    	$listarea->tagBind("fn$ct", '<Leave>', 
			   [ \&recolor, "fn$ct", '#4444ff' ]);
	++$ct;
    }

    while(my $f = shift @files) {
	#print "Inserting file: [$f]\n";
	$listarea->insert('end', "$f\n", "fn$ct");
	$listarea->tagConfigure("fn$ct", -foreground => 'red');
	$listarea->tagBind("fn$ct", '<Button-1>', [ \&dld_file, $f ]);
    	$listarea->tagBind("fn$ct", '<Enter>', 
			   [ \&recolor, "fn$ct", '#880000' ]);
    	$listarea->tagBind("fn$ct", '<Leave>', [ \&recolor, "fn$ct", 'red' ]);
	++$ct;
    }
    $listarea->configure(-state => 'disabled');

    # Update the status label.
    my $loc = $conn->pwd();
    if(!$loc) {
	ebox($conn);
	$statuslab->configure(-text => '???');
    } else {
	$statuslab->configure(-text => $loc);
    }
}

# Downoad the file.
sub dld_file
{
    my ($wid, $fn) = @_;

    # Announce.
    $statuslab->configure(-text => "[Retrieving $fn]");
    $main->update();

    # Get the file.
    if(!$conn->get($fn)) {
	ebox($conn);
	return;
    }

    $statuslab->configure(-text => "Got $fn");
}

#logscreen($main);

# Create the main list with the list of files.
main_list($main);

# Demand a login.
my $logwin = $main->Toplevel(@PCL);
$logwin->title("FTP Login");
logscreen($logwin);

MainLoop;
