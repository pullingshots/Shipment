# perl usage:
use lib 't/lib';
use TAP::Harness;
use TAP::Formatter::HTML;
my $fmt = TAP::Formatter::HTML->new({
    verbosity => -2,
});

use File::Find::Rule;
my @tests =  sort { $a cmp $b } File::Find::Rule->file()
                              ->name( '*.t' )
                              ->in( 't/' );
local $ENV{TEST_VERBOSE} = 1;
my $harness = TAP::Harness->new(
{
    formatter => $fmt ,
    merge => 1,
    # verbosity => 1,
    lib => [ 't/lib', 'lib' ],
    switches => ($ARGV[0] eq '--cover')
        ? [ '-MDevel::Cover=-ignore,.,-select,^lib/.+,-coverage,statement,subroutine,condition,branch' ]
        : [],
});
$harness->runtests( @tests );
