# Simple hash constructs
$fred{"with"} = "without";
$fred{"this"} = "that";
$fred{"mountain"} = "valley";
$fred{"left"} = "right";
print qq/$fred{"this"}\n/;
@keys = keys(%fred);
print "Keys are @keys\n";

# Initializer for %yard.
%yard = ( red => 'brick',
	  blue => 'sky',
	  green => 'grass',
	  yellow => 'dandelion' );
print "$yard{'blue'} $yard{'yellow'}\n";
