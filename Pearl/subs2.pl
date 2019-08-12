#
# Some more random examples of
# subroutines, using different features.
#

use strict;

#
# Some folks like to use shift to get the parmeters.
sub sent 
{
    my $subj = shift @_;
    my $verb = shift @_;
    my $adj = shift @_;
    my $obj = shift @_;

    print uc(substr($subj,0,1)), substr($subj,1), " $verb the $adj $obj.\n";
}

#
# The @_ array is special, because changing the parameters in it changes
# the arguments.
my $snakebreath;   # We can refer to this in changeme.
sub changeme 
{
    my $first = shift @_;
    $first = 'this';		# Does not change in caller.
    $_[0] = 'that';		# Does change in caller.
    $snakebreath = 77;		# Plain global ref.
}

sent('alex', 'stole', 'red', 'wagon');
sent('susan', 'ignored', 'awful', 'pun');

$snakebreath = 99;
my ($x, $y) = ('today', 'tomorrow');
print "\n$snakebreath $x $y\n";
changeme($x, $y);
print "$snakebreath $x $y\n";
