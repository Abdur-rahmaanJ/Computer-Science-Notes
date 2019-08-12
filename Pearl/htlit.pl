#
# This translates a file, such a program or other text file, so that
# it can be displayed literally in HTML.  It brackets the code in
# the <pre> and </pre> tags, expands tabs, and translates the characters
# which HTML treats as special so they will be displayed literally.
#

use strict;

#
# Expand tabs at 8 stops per tab.
#
sub expand {
    my ($line) = @_;
    my ($left, $right);   # Parens needed so my applies to both.

    while($line =~ /\t/) {
	($left, $right) = split (/\t/, $line, 2);

	my($tabamt) = 8 - length($left) % 8;
	$line = $left . (" " x $tabamt) . $right;
    }

    return $line;
}

print "<pre>\n";

# Copy with changes.
while(my $line = <STDIN>) {
    chomp $line;

    $line = expand($line);

    $line =~ s/&/&amp;/g;
    $line =~ s/</&lt;/g;
    $line =~ s/>/&gt;/g;
    $line =~ s/"/&quot;/g;

    print "$line\n";
}

print "</pre>\n";
