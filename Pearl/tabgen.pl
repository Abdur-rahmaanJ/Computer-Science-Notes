#
# This generates a simple HTML table from a text file.  The file begins
# with zero or more lines with set options of the form option = value.
# The first line after the options contains just spaces and | which 
# defines the extent of each column.
#

use strict;

#
# Expand tabs at 8 stops per tab.
#
sub expand {
    my ($line) = @_;
    my ($left, $right);

    while($line =~ /\t/) {
	($left, $right) = split (/\t/, $line, 2);

	my($tabamt) = 8 - length($left) % 8;
	$line = $left . (" " x $tabamt) . $right;
    }

    return $line;
}

#
# Legal options and default values.
#
my %options = ( color => '#bb7777',
		title => '',
		colsep => 3 );

#
# Read the options line, then return the first non-option line.
#
sub read_opts {
    my($line);

    while($line = <STDIN>) {
	if($line !~ /=/) { return $line; }

	# Read and extract the option.
	my($name, $value) = split(/\s*=\s*/, $line, 2);
	$name =~ s/^\s*//;
	$value =~ s/\s*$//;

	# Check it
	if(! exists $options{$name}) {
	    print STDERR "Illegal option $name.\n";
	    exit 10;
	}

	# Set it.
	$options{$name} = $value;
    }
}

#
# Take the format line, and break it into an array of patterns to
# extract the data for a column.
sub first {
    # Get the first line, make sure it starts with |.  
    my($first) = @_;
    chomp $first;
    $first = expand($first);
    $first =~ s/^ /|/;

    my(@pats) = ();

    # Take successive leading |.... groups off the string.
    while($first =~ /^\|/) {
        $first =~ s/^(\|[^|]*)//;
	my($flength) = length($1);
	push @pats, ".{0,$flength}";
    }

    # Replace the last one to permit it to take the rest of the line.
    pop @pats;
    push @pats, ".*";

    return @pats;
}

# One-character translations made on the data.
my %trans = ( '\[' => '<b>', '\]' => '</b>',
	      '\{' => '<i>', '\}' => '</i>' );

#
# Scan the input, formatting each input line as an HTML
# table, breaking them into columns according to the line
# breaking format array sent as argument.
sub scan {
    while(my $line = <STDIN>) {
	chomp $line;
	$line = expand($line);

	print "<tr>";
	my $sep = "";
	foreach my $colpat (@_) {
	    print $sep;
	    $line =~ s/^($colpat)//;
	    my $colcont = $1;
	    $colcont =~ s/\s*$//;
	    foreach my $ch(keys %trans) {
		$colcont =~ s/(^|[^\\])$ch/$1$trans{$ch}/g;
		$colcont =~ s/\\($ch)/$1/g;
	    }
	    $colcont =~ s/\\(.)/./g;
	    print "<td>$colcont</td>";
	    if($line =~ /^\s*$/) { last; }
	    $sep = qq|<td width=$options{"colsep"}></td>|;
	}
	print "</tr>\n";
    }    
}

#
# Read the column def line, generate the header, copy the data,
# and close the table.

my $topline = read_opts;
my @pats = first($topline);

print "<html>\n";
if($options{"title"} ne "") { 
    print qq|<title>$options{"title"}</title>\n|; 
}
print qq|<body bgcolor="$options{"color"}">\n|;

print "<table>\n";
if($options{"title"} ne "") { 
    print qq|<center><h1>$options{"title"}</h1></center>\n|; }

scan(@pats);

print <<EOF;
</table>
</body>
</html>
EOF
