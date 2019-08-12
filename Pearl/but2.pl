use Tk;
use strict;

my $main = new MainWindow;

my $b1 = $main->Button(-text => "Push Me", 
		       -command => sub { print "Outch!\n"; },
		       -background => "Blue", -foreground => "Yellow",
		       -activebackground => "Yellow", 
		       -activeforeground => "Blue",
		       -relief => 'sunken');

my $b2 = $main->Button(-text => "Exit", 
		       -command => sub { exit; },
		       -background => "#cc4444",
		       -activebackground => "#ff0000",
		       -relief => "ridge", -underline => 0);

$b1->pack;
$b2->pack;

MainLoop;
