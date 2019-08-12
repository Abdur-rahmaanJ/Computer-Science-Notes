#!/usr/bin/perl

use LWP;
use HTTP::Request::Common;
use HTML::TreeBuilder;
use strict;

@ARGV == 1 or die "Specify a single URL.\n";

# Basic objects.

# Return the tree of the URL.
sub tree_of {
    my $url = shift @_;
    my $tree = HTML::TreeBuilder->new;

    $url =~ s/^file\://;
    if($url =~ /^([a-z]+)\:/) {
	# Receive the remote data.
	my $ua = LWP::UserAgent->new(agent => "parsepage/1.0 libwww-perl");
	my $req = HTTP::Request->new(GET => $url);
	sub rcvdata {
	    my($data, $response, $protocol) = @_;
	    if($response->content_type() eq 'text/html') {
		$tree->parse($data);
	    } else {
		$tree->eof;
	    }
	}
	my $resp = $ua->request($req, \&rcvdata);

	if($resp->is_success) {
	    if($resp->content_type() ne 'text/html') {
		$resp->code(410);
		$resp->message("Not HMTL");
		return (0, $resp);
	    }
	    $tree->eof;
	    $tree->elementify();
	    return (1, $tree);
	} else {
	    return (0, $resp);
	}
    } elsif(-r $url) {
	$tree->parse_file($url);
	$tree->elementify();
	return (1, $tree);
    } else {
	return (0, HTTP::Response->new(404, "Cannot read $url"));
    }
}

# Print a string, with indent and wrap.
sub prstr {
    my $ind = shift @_;
    my $str = shift @_;
    my $newind = $ind;
    my $wid = 78 - $ind;
    my $newwid = $wid - 5;
    my $oldsp = ' ' x $ind;
    my $newsp = ' ' x ($ind + 5);
    my $sp = $oldsp;

    return if($str =~ /^\s*$/m);

    $str =~ s/^\s+//;
    while(length($str) > $wid) {
	$str =~ s/^(.{1,$wid})\s+// or 
	    $str =~ s/^(\S+)\s+// or last;
	print "$sp$1\n";
	$sp = $newsp;
	$wid = $newwid;
	#print "FRED: $wid ", length($str), "\n";
    }
    $str =~ s/\n\s*/\n$newsp/g;
    print "$sp$str\n";
}

# Print the node.
sub pnode {
    my $ind = shift @_;
    my $node = shift @_;

    if(ref $node) {
	prstr($ind, $node->starttag());
    } else {
	prstr($ind, HTML::Entities::encode($node));
    }
}

# Print the tree.
sub scan_tree {
    my $ind = shift @_;
    my $node = shift @_;

    pnode($ind, $node);
    if(ref $node) {
	foreach my $e($node->content_list()) {
	    scan_tree($ind + 2, $e);
	}
	if(!$HTML::Tagset::emptyElement{$node->tag()}) {
	    print (' ' x $ind);
	    print '</', $node->tag(), ">\n";
	}
    }
}

my ($succ, $tree) = tree_of($ARGV[0]);
if($succ) { scan_tree(0, $tree); }
else { die "GET $ARGV[0] failed: ", $tree->code, ": ", $tree->message, "\n";}
