#!/usr/bin/perl
#
# Takes the WWW name of a file and reports downloads recorded in the main
# Apache log file.
#

# Needed for the inet_aton function, a format conversion.
use Socket;

$one_client = 1;	# Report client only the first time.
$client_name = 1;	# Look up host names.
$infile = "/etc/httpd/logs/access_log";	# Read this log file
$prefix = 0;		# Match any page with the indicated prefix.
$one_ref = 0;		# Report each matched page only the first time.
$substring = 0;		# Target is a substring.
$exten = "";		# Extension.

while($arg = shift @ARGV) {
    if($arg !~ /^-/) { break; }

    if($arg eq "-a") { $one_client = 0; }
    elsif($arg eq "-n") { $client_name = 0; }
    elsif($arg eq "-p") { $prefix = 1; }
    elsif($arg eq "-r") { $one_ref = 1; }
    elsif($arg eq "-s") { $substring = 1; }
    elsif($arg eq "-t") { 
	($exten = shift @ARGV) && ($exten !~ /^-/) or die "No extension.\n";
	$exten =~ s/^\.//;
    }
    elsif($arg eq "-i") {
	($infile = shift @ARGV) && ($infile !~ /^-/) or die "No filename.\n";
    }
    elsif($arg =~ /^-/) { die "Bad flag $arg\n"; }
    else { last; }
}

# Get the file target, strip trailing /.
$target = $arg;
$target =~ s|/$||;

if($substring) {
    $target = ".*$target.*";
}
elsif($prefix) {
    $target = "$target.*";
}
if($exten) {
    $target .= ".*\\.$exten";
}
$target = '.*' unless $target;

# Open the file.
open(IN, $infile) or die "Cannot read $infile: $!.\n";

# Read the log file entries.
my $line;
while($line = <IN>) {
    chomp $line;

    # Attempt to match the line, and get the parts we want.
    if($line =~ m|^([0-9\.A-Za-z]+).*\[([0-9]+)/([A-Za-z]+)/([0-9]+)\:([0-9]+)\:([0-9]+)\:([0-9]+).*\]\s\"GET\s($target)(/?)\sHTTP|) {
	# Extract the fields.
	my ($client, $day, $mon, $year, $hh, $mm, $ss, $targ) =
	    ($1, $2, $3, $4, $5, $6, $7, $8);
	$hh =~ s/^0//;

	# Eliminate duplicate client or URL.
	if($one_client && exists $clients{$client}) { next; }
	if($one_ref) {
	    if(exists $refed{$target}) { next; }
	    $refed{$target} = 1;
	}

	# Fix the AM/PM.
	my $apm = "AM";
	if($hh == 0) {
	    $hh = 12;
	} elsif($hh == 12) {
	    $apm = "PM";
	} elsif($hh > 12) {
	    $apm = "PM";
	    $hh -= 12;
	}

	# Map the client IP address, if required.  Also caches results from
	# previous attempts, since it tends to be slow.
	my ($hname);
	if(exists $clients{$client}) {
	    $hname = $clients{$client};
	} else {
	    if($client_name) {
	        $hname = gethostbyaddr(inet_aton($client), AF_INET);
	        $clients{$client} = $hname;
	    } else {
	        $clients{$client} = undef;
	    }
	}
	if(defined $hname) {
	    $client = "$hname ($client)";
	}

	$outline = "$targ at $hh:$mm $apm $mon $day, $year to $client";
	if(length $outline > 79) {
	    $outline =~ s/^(.{1,78}\S)(\s.*)$/$1\n\t$2/;
	}
	print "$outline\n";
    }
}
