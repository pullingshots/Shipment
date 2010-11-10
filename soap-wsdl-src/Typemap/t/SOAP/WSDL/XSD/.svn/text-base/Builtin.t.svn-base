use strict;
use warnings;
use Test::More tests => 2; #qw(no_plan);

use_ok qw(SOAP::WSDL::XSD::Builtin);

my $foo = SOAP::WSDL::XSD::Builtin->new();
$foo->set_targetNamespace('bar');

eval {
    $foo->serialize(
        'foo', 'bar', { autotype => 1 , namespace => {} }
    )
};

like $@, qr{^No \s prefix \s found \s for \s namespace \s bar}x;