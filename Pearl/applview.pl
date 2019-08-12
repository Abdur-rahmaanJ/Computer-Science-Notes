#! /usr/bin/perl

use strict;

my $width = 400;
my $height = 200;
$#ARGV > -1 or die "Usage: $0 classname [ width [ height ] ]\n";	
if($#ARGV >= 1) { $width = $ARGV[1]; }
if($#ARGV >= 2) { $height = $ARGV[2]; }

my $clname = $ARGV[0];
if($clname !~ /\.class$/) { $clname = "$clname.class"; }

my $loc = $clname;

open(TMPHTML, ">.tmp.html") or die "Can't get temp file: $!";

print TMPHTML "<html>\n<title>$clname</title>\n";
print TMPHTML "<body>\n<h1>$clname</h1>\n";
print TMPHTML
     "<APPLET CODE=\"$loc\" WIDTH=$width HEIGHT=$height IGNORE=\"\">\n";
print TMPHTML "</applet></body></html>\n";
close TMPHTML;

system "appletviewer .tmp.html";
unlink ".tmp.html";
