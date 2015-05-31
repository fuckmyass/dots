#!/usr/bin/perl
use warnings;
use strict;

# dmenu_run.pl - run dmenu, showing most used results first.
#                use -r option to remove something from the database

# written by Rex Roof <dmenu@rexroof.com>  -  February 2013
#    released for free under the creative commons CC BY  license.
#         http://creativecommons.org/licenses/by/3.0
#
#   Install by copying to dmenu_run.pl in your path and chmod ugo+x
#   then replace your dmenu_run execution with dmenu_run.pl

# path to dmenu
my $DMENU_EXEC = "/usr/bin/dmenu -p 'Run that shit' -fn '-*-lemon-*-r-*-*-11-*-*-*-*-*-*-*' -h 20 -nb '#1d1f21' -nf '#c5c8c6' -sb '#335260' -sf '#c5c8c6' -l 15 -x 355 -y 242 -w 200";

use Storable qw(nstore retrieve);
use IPC::Open2;
use Getopt::Std;
$Getopt::Std::STANDARD_HELP_VERSION = 1;

my $STO = $ENV{HOME} . "/.dmenu_cache.sto";

# if we have a cache dir, use it.
my $CACHEDIR = $ENV{XDG_CACHE_HOME} || $ENV{HOME} . "/.cache";
if ( -d $CACHEDIR ) {
    $STO = "$CACHEDIR/dmenu_run.sto";
}

# process command line arguments
my %opts;
unless ( getopts( 'r:', \%opts ) ) {
   die HELP_MESSAGE();
}

# searching $PATH environment
my @dirs = split /:/, $ENV{PATH};
my $count_ref = {};
if ( -f $STO ) {
    $count_ref = retrieve($STO);
}
# store our last rebuild time in this special key
$count_ref->{'--last-rebuild'} = 1 unless ( $count_ref->{'--last-rebuild'} );

## this section checks each directory in our path, looking for modification
#    times since our last check
#
# the gap is the time since our check, in days
my $gap = ( ( $^T - $count_ref->{'--last-rebuild'} ) / 86400 );
foreach my $dir (@dirs) {
    next unless ( -d $dir );

    if ( ( -M $dir ) <= $gap ) {
        if ( opendir( my $dh, $dir ) ) {
        F: while ( my $f = readdir $dh ) {

                # only index executable files.
                next F unless ($f);
                next F unless ( -x "$dir/$f" );
                next F unless ( -f "$dir/$f" );

                $count_ref->{$f} = 1 unless ( $count_ref->{$f} );
            }

            # update our rebuild time
            $count_ref->{'--last-rebuild'} = time();
            nstore $count_ref, $STO;
        }
        else {
            warn "opendir on $dir failed. $!";
        }
    }
}

# if we have a cmd line argument to delete key
if ( exists $opts{r} ) {
   if ( $opts{r} ) {
    if ( $count_ref->{ $opts{r} } ) {
        delete $count_ref->{ $opts{r} };
    }
    nstore $count_ref, $STO;
   } else {
     HELP_MESSAGE();
   }
  exit;
}

# execute dmenu to prompt the user
my $pid = open2( my $fh_out, my $fh_in, "$DMENU_EXEC @ARGV" );
foreach  # run fancy_sort on our keys
    my $bit ( sort { fancy_sort( $a, $b, $count_ref ) } keys %{$count_ref} )
{

    next if ( $bit =~ m/^--/ );

    print $fh_in $bit;
    print $fh_in $/;
}
close($fh_in) or warn $!;

my $cmd = (<$fh_out>);
exit unless ($cmd);
chomp($cmd);
close($fh_out) or warn $!;

# make sure our dmenu process exits.
waitpid( $pid, 0 );

# store away our Storable file before we exec
$count_ref->{$cmd}++;
nstore $count_ref, $STO;

# execute our chosen command
exec($cmd);

# exit;

sub fancy_sort {
    my $a   = shift;
    my $b   = shift;
    my $ref = shift;

    # this sorts by execution count, then alphabetically
    return ( $ref->{$b} <=> $ref->{$a} || $a cmp $b );
}

sub HELP_MESSAGE {
   print "usage: $0 [-r key]\n\t removes key from dmenu application index\n";
   return;
}
sub VERSION_MESSAGE { return 1 };


#exe=`dmenu_path | dmenu -b -nb '#151617' -nf '#d8d8d8' -sb '#d8d8d8' -sf '#151617'` && eval "exec $exe"
