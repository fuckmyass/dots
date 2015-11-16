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
#my $DMENU_EXEC = "/usr/local/bin/dmenu -p 'execute' -fn '-*-gohufont-medium-r-*-*-11-*-*-*-*-*-*-*' -h 20 -nb '#3B464C' -nf '#F2F1B9' -sb '#F99595' -sf '#3B464C' -l 0 -x 0 -y 0 -w 1366";
#my $DMENU_EXEC = "dmenu -i -h 350 -w 200 -y 45 -q -l 1 -o 100 -p '            execute' -fn 'wenquanyi zen hei mono-7:medium' -nb '#000000' -nf '#616161' -sb '#000000' -sf '#ffffff'";
my $DMENU_EXEC ="dmenu -i -h 766 -w 1366 -q -o .6 -p '                                     execute:' -fn 'sfns display-9:medium' -nb '#000000' -nf '#ffffff' -sb '#000000' -sf '#ffffff'";

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
