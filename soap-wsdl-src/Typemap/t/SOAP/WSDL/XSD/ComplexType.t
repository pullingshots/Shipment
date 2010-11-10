use strict;
use warnings;
use Test::More tests => 5; #qw(no_plan);

use_ok qw(SOAP::WSDL::XSD::ComplexType);

my $obj = SOAP::WSDL::XSD::ComplexType->new();
$obj->set_variety('extension');

eval { $obj->serialize('foo') };
like $@, qr{sorry, \s we \s just}xsm;

$obj->set_targetNamespace('bar');
ok $obj->set_abstract(1);
ok $obj->set_final(1);
eval {
    $obj->serialize(
        'foo', 'bar', { autotype => 1 , namespace => {} }
    )
};

like $@, qr{^No \s prefix \s found \s for \s namespace \s bar}x;