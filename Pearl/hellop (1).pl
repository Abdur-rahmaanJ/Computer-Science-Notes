#
# Highly advanced parameterized hello world program.
#
# Flags:
#    -m <msg>		Alternate message instead of "Hello, World!";
#    -n <n>		Repeat the message multiple times (default 1)
#    -i <n>		Indent the message <n> spaces (default 0).
#    -r			Print the message characters in reverse order.
#    -h			Print help and exit.
#

use strict;

# Enter default parameter values.
my %parms = ( "-m" => "Hello, World!", "-n" => 1, "-i" => 0 );

# Enter default flags (booleans)
my %flags = ( "-r" => "0", "-h" => 0 );

# Process flags.  Only those listed in a list are valid.
while(my $p = shift @ARGV) {
    exists $parms{$p} || exists $flags{$p} or die "Illegal parameter $p.\n";

    if(exists $parms{$p}) {
	$parms{$p} = shift @ARGV;
    } else {
	$flags{$p} = 1;
    }
}

# Obey help option.  The notation print <<ENDHELP; starts a "here document".
# All text up to the terminator ENDHELP is printed.  The terminator can
# be any string.
if($flags{"-h"}) {
    print <<ENDHELP;
*** $0: Advanced Technology Hello World! ***

The following parameters are available:
    -m <msg>		Alternate message instead of "Hello, World!";
    -n <n>		Repeat the message multiple times (default 1)
    -i <n>		Indent the message <n> spaces (default 0).
    -r			Print the message characters in reverse order.
    -h			Print help and exit.
ENDHELP

    exit 0;
}

# Obey the -r flag.  Reverse is a built-in.  If you feed it a list or array,
# it reverses the members.  If you send a string, it reverses the characters.
if($flags{"-r"}) {
    $parms{"-m"} = reverse($parms{"-m"});
}

# Loop to obey the -n flag.
for(my $n = 1; $n <= $parms{"-n"}; ++$n) {
    # Obey -i.  The x operator is used to repeat strings.
    print ' ' x $parms{'-i'};

    # Print the message.
    print $parms{'-m'}, "\n";
}
