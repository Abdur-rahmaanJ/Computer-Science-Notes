# This prints the arguments in the same way as args4, but it re-constructs
# the list.  (Of course, if you really needed the list again, you probably
# wouldn't print it this way, but it demonstrates the push operator.)
while($item = shift @ARGV) {
    print "$item\n";
    push @newargs, $item;
}
print "[@newargs]\n";
