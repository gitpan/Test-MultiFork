#!perl -I.

use Test::MultiFork;
use Time::HiRes qw(sleep);

FORK_a5:

my (undef, undef, $number) = procname;

print "1..$number";

lockcommon();
my $x = getcommon();
$x->{$number} = $$;
setcommon($x);
unlockcommon();

#print STDERR "# $number sleeps$$\n";
sleep(0.3 * ($number+1));
#print STDERR "# $number wakeup$$\n";

lockcommon();
$x = getcommon();
$x->{$number} = $$;
setcommon($x);
unlockcommon();

for my $i (1..$number) {
	print (exists $x->{$i} ? "ok $i\n" : "not ok $i\n");
}

