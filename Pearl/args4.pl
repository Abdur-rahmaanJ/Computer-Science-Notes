# And, yet another way to print the command-line arguments.  This uses the
# shift operator, which removes the first member of the array and returns
# it.  After the loop is finished, the array is empty.
while($item = shift @ARGV) {
    print "$item\n";
}
print "[@ARGV]\n";
