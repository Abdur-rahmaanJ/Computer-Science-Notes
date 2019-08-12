use Tk;
use strict;

my $main = new MainWindow;

my $b1 = $main->Button(-text => "Push Me", 
		       -command => sub { print "Outch!\n"; });
my $b2 = $main->Button(-text => "Exit", 
		       -command => sub { exit; });

$b1->pack;
$b2->pack;

MainLoop;
