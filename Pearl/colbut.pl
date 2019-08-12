use Tk;
use strict;

my $main = new MainWindow;

# See if button was pressed
my $waspressed = 0;

# Instructions button.
my $lab = $main->Label(-text => "Choose the color\nof the exit button",
		       -background => "Yellow");

# The all important exit button.
my $alldone = $main->Button
    (-text => "Exit", -background => "#888888",
     -command => sub { 
	 if ($waspressed) { 
	     exit 0;
	 } else {
	     $lab->configure(-text => "SET THE BUTTON COLOR\nFIRST!!",
			     -foreground => 'Red');
	 }
     } );

# Three color bottons together.
my $buts = $main->Frame;
my $red = $buts->Button(-text => "Red", -background => "#ffaaaa",
		        -command => sub { 
			    $alldone->configure( -background => "Red");
			    $waspressed = 1; } );
my $green = $buts->Button(-text => "Green", -background => "#aaffaa",
			  -command => sub { 
			      $alldone->configure( -background => "Green");
			      $waspressed = 1; } );
my $blue = $buts->Button(-text => "Blue", -background => "#aaaaff",
			 -command => sub { 
			     $alldone->configure( -background => "Blue");
			     $waspressed = 1; } );

# Set top level window yellow.
$main->configure( -background => "Yellow");

# Pack it all together.  In Perl, you can only pack one at a time.
$red->pack(-side => "left");
$green->pack(-side => "left");
$blue->pack(-side => "left");
$lab->pack(-side => "top");
$buts->pack(-side => "top");
$alldone->pack(-side => "top");

MainLoop;
