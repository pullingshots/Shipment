package Test::SOAP::WSDL::Tester;
use strict;
use warnings;
use Test::Class;
use base qw(Test::Class);

use File::Basename;
use File::Spec;

use Test::More;

use Scalar::Util qw(blessed);

our $HAS_TEST_WARN;

BEGIN {
    $HAS_TEST_WARN = eval { require Test::Warn; import Test::Warn; 1 };
}

sub has_test_warn {
    return $HAS_TEST_WARN;
}

# object accessors
sub set_object { $_[0]->{ object } = $_[1] }
sub get_object { return shift->{ object } };
# class accessors
sub set_class { $_[0]->{ class } = $_[1] }
sub get_class { return shift->{ class } };


sub startup :Test(startup => 1) {
    my $self = shift;
    my $class = ref $self;
    if ($class eq __PACKAGE__) {
        ok __PACKAGE__;
        return;
    };
    $class =~s{^Test::}{};
    $self->set_class( $class );
    use_ok $class;
}

sub t_url {
    my $path = File::Spec->rel2abs( dirname __FILE__ );
    my ($volume, $dir) = File::Spec->splitpath($path, 1);
    my @dir_from = File::Spec->splitdir($dir);
    unshift @dir_from, $volume if $volume;

    my $url = 'file://' . join '/', @dir_from[0..$#dir_from - 4];
    # die $url;
    return $url;

}

1;