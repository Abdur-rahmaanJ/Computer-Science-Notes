#!/usr/bin/perl

use LWP;
use HTTP::Request::Common;

# Print found names
sub prname {
    my ($hname, $dept, $email, $page) = @_;

    foreach $part ($hname, $dept, $email, $page) {
	$part =~ s/\&nbsp;/ /g;
	$part =~ s/^\s*//;
	$part =~ s/\s*$//;
    }

    # Some don't seem to have an entry for Department.  If this is all
    # blanks, the field will simply be missing.  Try to detect and
    # repair this situation.
    if($email !~ /\@/ && $dept =~ /\@/) {
	($dept, $email, $page) = ("[None]", $dept, $email);
    }

#    print "[$hname] [$dept] [$email] [$page]\n";
    $page =~ s/.+/ [has page]/;
    if($dept ne "[None]" && $dept ne "Student") { $dept = "fac/staff"; }
    printf "%-20s %-18s %-10s%s\n", $hname, $email, $dept, $page;
}

# $0 [ -m ] lastname firstname
$domail = 0;
if($ARGV[0] eq "-m") { $domail++; shift @ARGV; }
$lname = $fname = "";
$lname = shift @ARGV if @ARGV;
$fname = shift @ARGV if @ARGV;

$ua = LWP::UserAgent->new;

#$resp = $ua->request(POST 'http://www.mc.edu/servlets/EmailSearch',
$resp = $ua->request(POST 'http://www.mc.edu/base/EmailSearch',
			  [ 'first_name' => $fname, 'last_name' => $lname,
			    'submit' => "Search" ]);

if($resp->is_success) {
    my $text = $resp->content;

    # Hack off leading stuff.
    $text =~ s@^.*\>Webpage\<.*?/td\>@@si or
	die "Cannot parse response.\n";

    # Here's what we think a group of tags looks like.
    $uwht = "(?:\\s|\\&nbsp;)*";
    $taggrp = "$uwht\\<(?:[^<>]|\>$uwht\<)+\\>$uwht";

    # Find the names.
    $count = 0;

    while($text =~ s@^.*?\<tr\>(.*?)\</tr\>@@si) {
	$rowcont = $1;
	$rowcont =~ s@^$taggrp@@si;
	@row = split(/$taggrp/si, $rowcont);
	#print "[@row]\n";
	$#row == 3 || $#row == 2 or last;
	prname(@row);
	$lastemail = $row[2];

	++$count;
    }

    if($count == 0) { print "No match for $lname, $fname.\n"; }
    if($domail && $count == 1) {
	system "mail $lastemail";
    }
    
} else {
    die "HTTP Request failed.\n";
}
