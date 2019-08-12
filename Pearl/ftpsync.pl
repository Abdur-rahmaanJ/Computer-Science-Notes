#!/usr/bin/perl
use Net::FTP;
use strict;
use Getopt::Long;

# Variables set in the control file.
#   sync=0|1|fn			-- Default of the -sync option.
#   host=hostname		-- Host to send to.
#   acct=acctname		-- Account name
#   pwd=password		-- Password to send.
#   cd=initdir			-- Initial directory.
#   
# The various control options cat be set with lines of the following
# form:
#   name = ...			Set the value.
#   name += ...			Add to the value.
# The value is a list of items, "strint" for a literal match, /str/ for a
# pattern match.  The available variables are:
#   send		Matched against local plain files, to transmit.
#   dontsend		Files maching send which should not be sent.
#   preserve		Matched against remote files, and
#			prevents deletion of remote files not present and sent.
#   descend		Matches local directory names to descend.
#   dontdescend		Local directories matched by descend, which should
#			not be descended.
#   presdir		Remote directories to preserve, even though not on
#			the descend list.

# Read the control file.  Info is placed into a hash given as a reference.
# Initial values are preserved for variables not mentioned, and for +=
# assignments.  The option required tells if the control file must exist.
# If required is false, and the file cannot be opened, the function simply
# returns w/o updating the hash.  If required and will not read, the function
# dies.  The contents of hasref define the legal variables, 
#   readctl($conn, fn, required, stringargsref, patargsref)
sub readctl {
    my $conn = shift @_;
    my $fn = shift @_;
    my $req = shift @_;
    my $strings = shift @_;
    my $pats = shift @_;

    if(!open(IN, $fn) && $req) {
	&expire($conn, "Cannot read $fn");
    }

    my $ln;
    while($ln = <IN> || shift @_) {
	# Parse the line and make sure the setting is legal.
	chomp $ln;
	$ln or next;
	$ln =~ /^([a-zA-Z]+)\s*(\=|\+\=)\s*(\S.*)?$/ or
	    &expire($conn, "$fn:$.: Cannot parse");
	my ($name, $sym, $data) = ($1, $2, $3);
	exists $strings->{$name} || exists $pats->{$name} or
	    &expire($conn, "$fn:$.: Unknown control variable $name.");
	if($sym eq '+=' && !exists $pats->{$name}) {
	    &expire($conn, "$fn:$.: Value $name cannot be extended.");
	}

	# Update the hash.
	if(exists $pats->{$name}) {
	    # Pattern.
	    if($sym eq '=') { $pats->{$name} = ''; }
	    while($data) {
		$pats->{$name} .= '|' if($pats->{$name});
		my $p;
		if($data =~ s|^/(.*?[^\\])/\s*||) {
		    # Just add a pattern to the list.
		    $p = $1;
		} elsif($data =~ s|^"(.*?[^\\])"\s*||) {
		    # A string specified.  Make a pattern for exact match.
		    $p = $1;
		    $p =~ s/([^a-zA-Z0-9])/\\$1/g;
		    $p = "^($p)\$";
		} else {
		    &expire($conn, "$fn:$.: Bad match item spec.");
		}

		# Check for syntax error in the pattern, then add it
		# to the whole match pattern.
		defined eval("'x' =~ /$p/") or
		    &expire($conn, "$fn:$.: Bad pattern $p");
		$pats->{$name} .= "($p)";
	    }
	} else {
	    # Just plain value.
	    $strings->{$name} = $data;
	}
	
    }

    close(IN);
}

# Options.
my $norun = 0;
my $rcfile = ".webserver";
my $csync = undef;
GetOptions("n|norun" => \$norun, "r|rmtdir|server=s" => \$rcfile, 
	   "s|sync:s" => \$csync);
$rcfile =~ /^\./ or $rcfile = ".$rcfile";

# Read the top-level command file.
my %strings = ( sync => 0, host => 0, acct => 0, pwd => 0, cd => '');
my %pats = ( send => "(\\.html\$)", preserve => "", descend => "(.)", 
	     presdir => "", dontsend => "", dontdescend => "" );
readctl(0, $rcfile, 1, \%strings, \%pats, @ARGV);
if(defined $csync) {
    # From command line.
    if($csync eq '') { $csync = 1; }
    $strings{"sync"} = $csync;
}
if($strings{"sync"} == 1) { $strings{"sync"} == 'syncfile'; }

#foreach my $n(keys %strings) { print "strings{$n} = $strings{$n}\n"; }
#print "\n";
#foreach my $n(keys %pats) { print "pats{$n} = $pats{$n}\n"; }
#print "\n";

# Time offset.
my $syncoff = 0;

# Close and maybe exit.
my $was_err = 0;
sub expire {
    my $conn = shift @_;
    my $msg = shift @_;
    my ($fatal) = (@_, 1);

    my $err = '';
    if($conn) {
	$err = $conn->message();
    }
    chomp $err;
    $err =~ s/\.\s*$//;
    $msg =~ s/\!\!/$err/;
    print "$msg.\n";
    if($fatal) {
	$conn->quit() if $conn;
	exit(2);
    } else {
	$was_err = 1;
    }
}

# Read the curr directory on the server, and return a pair of hash references.
# The first is to a hash giving the name and mod date of each ordinary file,
# and the second gives the directories, with value 1.
sub rmt_contents {
    my $conn = shift @_;
    my %files = ();
    my %dirs = ();
    my $nttime = '\d\d\-\d\d\-\d\d\s+\d\d\:\d\d[AP]M';

    my @names = $conn->dir();
    int($conn->code() / 100) == 2 or 
	expire($conn, "Remote list failed: !!");
    foreach my $l(@names) {
	chomp $l;
	my ($name, $isdir);
	if($l =~ /^[\-d]([\-r][\-w][\-xs]){2}[\-r][\-w][\-xt]\s/) {
	    # Smells like Unix (inoring specials, etc.)
	    my ($mode, $links, $uid, $gid, $size, $d1, $d2, $d3, $n) =
		split(/\s+/, $l, 9);
	    $name = $n;
	    $isdir = ($l =~ /^d/);
	} elsif($l =~ /^$nttime\s+(\<(DIR)\>\s+|\d+\s)(.*)$/) {
	    # Smells NT
	    $name = $3;
	    $isdir = ($2 eq 'DIR');
	} else {
	    # Can't figure it out, or its the wrong kind of thing.
	    next;
	}
	if($isdir) {
	    next if $name eq '.' || $name eq '..';
	    $dirs{"$name"} = 1;
	} else {
	    my $time = $conn->mdtm($name);
	    $files{"$name"} = $time + $syncoff;
	}
    }
    return (\%files, \%dirs);
}

# Read the curr local directory, and return a pair of references.
# The first is to a hash giving the name and mod dat of each ordinary file,
# and the second is to an array of directory names in the current directory.
# The function ignores any file starting with ., and obeys the send,
# dontsend, descend and dontdescend patterns.  That means that files which
# don't match send, or do match dontsend, are ignored.  Likewise directories
# not matchind descend or matching dontdescend are not reported.  
sub loc_contents {
    my $conn = shift @_; # Only for aborts.
    my $strref = shift @_;
    my $pref = shift @_;

    my %files = ();
    my %dirs = ();

    opendir(CD, '.') or expire($conn, "Directory open failed: $!");
    while(my $name = readdir(CD))
    {
	next if($name =~ /^\./);
	if(-f $name) {
	    if(!$pref->{"send"} || $name !~ /$pref->{"send"}/) { next; }
	    if($pref->{"dontsend"} && $name =~ /$pref->{"dontsend"}/) { 
		next; 
	    }
	    my ($dev,$ino,$mode,$nlink,$uid,$gid,$rdev,$size,$atime,$mtime)
		= stat($name);
	    $files{"$name"} = $mtime;
	} elsif(-d $name) {
	    if(!$pref->{"descend"} || $name !~ /$pref->{"descend"}/) { 
		next; 
	    }
	    if($pref->{"dontdescend"} && 
	       $name =~ /$pref->{"dontdescend"}/) { 
		next; 
	    }
	    $dirs{"$name"} = 1;
	}
    }
    closedir(CD);
    return (\%files, \%dirs);
}

# Delete all contents of the current remote directory, with the given name.
sub delrmt {
    my $conn = shift @_;
    my $name = shift @_;

    # Get the contents.
    my ($files, $dirs) = rmt_contents($conn);

    # Get rid of the files.
    foreach my $fi(keys %$files) {
	print "Deleting $name$fi.\n";
	if(!$norun) {
	    $conn->delete($fi) or
		expire($conn, "Delete $name$fi failed: !!", 0);
	}
    }

    # Get rid of the directories.
    foreach my $d(keys %$dirs) {
	$conn->cwd($d) or expire($conn, "cd $name$d failed: !!");
	delrmt($conn, "$name$d/");
	$conn->cdup() or expire($conn, "cd up failed: !!");
	print "Removing directory $name$d.\n";
	if(!$norun) {
	    $conn->rmdir($d) or expire($conn, "rmdir $name$d failed: !!", 0);
	}
    }
}

# Synchronize.
sub sync {
    my $conn = shift @_;
    my $name = shift @_;
    my $fn = shift @_;
    my $strings = shift @_;
    my $pats = shift @_;

    # Get the contents.
    my ($rfiles, $rdirs) = rmt_contents($conn);
    my ($lfiles, $ldirs) = loc_contents($conn,$strings,$pats);

    #print "FRED $name:\n"; prfl($lfiles);
    #print "\n";
    #prfl($ldirs);
    #print "\n";

    # Go through the local files and put what needs putting.
    foreach my $lf(keys %$lfiles) {
	# See if it must be sent.
	if(!exists $rfiles->{$lf} || $rfiles->{$lf} < $lfiles->{$lf}) {
	    # Old or missing....
	    print "Sending $name$lf\n";
	    if(!$norun) {
		if(!-r $lf) {
		    expire($conn, "File $lf is not readable", 0);
		} else {
		    $conn->put($lf) or
			expire($conn, "Put $name$lf failed: !!", 0);
		}
	    }
	}
	delete $rfiles->{$lf};
    }

    # If there are any remote files left, delete them.
    foreach my $rf(keys %$rfiles) {
	next if ($pats->{"preserve"} && ($rf =~ /$pats->{"preserve"}/));
	print "Deleting $name$rf.\n";
	if(!$norun) {
	    $conn->delete($rf) or 
		expire($conn, "Delete $name$rf failed: !!", 0);
	}
    }

    # Recur on the local directory names.
    foreach my $ld(keys %$ldirs) {
	# Create if needed.
	if(!$rdirs->{$ld}) {
	    print "Creating $name$ld\n";
	    if($norun) {
		print "Sending $name$ld subtree.\n";
		next;
	    } else {
		if(!$conn->mkdir($ld)) {
		    expire($conn, "Create $name$ld failed: !!", 0); 
		    next;
		}
	    }
	}

	# Perform the recursion.
	$conn->cwd($ld) or expire($conn, "cd $name$ld failed: !!");
	chdir($ld) or expire($conn, "local cd $ld failed: $!");
	if(-r $fn) {
	    my %nstrings = %$strings;
	    my %npats = %$pats;
	    readctl($conn, $fn, 0, \%nstrings, \%npats);
	    sync($conn, "$name$ld/", $fn, \%nstrings, \%npats);
	} else {
	    sync($conn, "$name$ld/", $fn, $strings, $pats);
	}
	$conn->cdup() or expire($conn, "cd up failed: !!");
	chdir('..') or expire($conn, "local cd .. failed: $!");

	delete $rdirs->{$ld};
    }

    # Wipe remotes not matched locally.
    foreach my $rd(keys %$rdirs) {
	next if($pats->{"presdir"} && ($rd =~ /$pats->{"presdir"}/));
	$conn->cwd($rd) or expire($conn, "cd $name$rd failed: !!");
	delrmt($conn, "$name$rd/");
	$conn->cdup() or expire($conn, "cd up failed: !!");
	print "Removing directory $name$rd.\n";
	if(!$norun) {
	    $conn->rmdir($rd) or 
		expire($conn, "Removal of $name$rd failed: !!", 0);
	}
    }
}

# Print the file times map.
sub prfl {
    my $hr = shift @_;

    foreach my $k(sort keys %$hr) {
	my $mod = localtime($hr->{$k});
	print "$k->$mod\n";
    }
}

# Synchronize clocks.
sub clocksync {
    my $conn = shift @_;
    my $fn = shift @_;

    if(! -f $fn) {
	open(SF, ">$fn") or 
	    expire($conn, "Cannot create $fn for time sync option");
	close(SF);
    }
    -z $fn or
	expire($conn, "File $fn for time sync must be empty.");

    $conn->put($fn) or 
	expire($conn, "$fn send failed: !!");

    my $now_here = time();
    my $now_there = $conn->mdtm($fn) or
	expire($conn, "Cannot get $fn write time");

    #print "FRED: $now_here $now_there\n";
    #print "FRED: ", localtime($now_here), " ", localtime($now_there), "\n";

    $syncoff = $now_here - $now_there;
    $syncoff -= 5; # Be a bit conservative.

    #print "A: [$now_here] [$now_there] [$syncoff]\n";

    $conn->delete($fn);
    
    my $hrs = int($syncoff/3600);
    my $mins = int($syncoff/60) - $hrs*60;
    my $secs = $syncoff - $hrs*3600 - $mins*60;
    printf("Clock sync offset: %d:%02d:%02d\n", $hrs, $mins, $secs);
}

# Check for login info.
$strings{"host"} && $strings{"acct"} && $strings{"pwd"} or
    die "Hostname, account name, and password must be specified.\n";

# Do the communications.
my $conn = Net::FTP->new($strings{"host"}, Passive => 1) or
    die "Connect: $@\n";
$conn->login($strings{"acct"}, $strings{"pwd"}) or
    expire($conn, "Login as $strings{'acct'} failed: !!");
if($strings{"cd"}) {
    $conn->cwd($strings{"cd"}) or
	expire($conn, "Initial directory change failed: !!");
}
$conn->binary() or
    expire($conn, "Binary mode failed: !!");

# Optional clock synchronization step.
if($strings{"sync"}) { clocksync($conn, $strings{"sync"}); }

#my ($a, $b) = rmt_contents($conn);
#print "files:\n";
#prfl($a);
#print "dirs:\n";
#prfl($b);

# Now the real work.
sync($conn, '', $rcfile, \%strings, \%pats);

$conn->quit();

exit $was_err;
