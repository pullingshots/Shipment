use strict;
use warnings;
use Test::More tests => 4;

use SOAP::WSDL::Operation;
use_ok qw(SOAP::WSDL::PortType);

my $portType = SOAP::WSDL::PortType->new({
    operation => [
        SOAP::WSDL::Operation->new({
            name => 'foo',
            targetNamespace => 'bar',
        }),
        SOAP::WSDL::Operation->new({
            name => 'foo',
            targetNamespace => 'baz',
        }),
        SOAP::WSDL::Operation->new({
            name => 'foobar',
            targetNamespace => 'bar',
        }),
    ]
});


my $operation = $portType->find_operation('bar', 'foobar');
is $operation->get_name(), 'foobar', 'found operation';
$operation = $portType->find_operation('baz', 'foo');
is $operation->get_name(), 'foo', 'found operation';

$operation = $portType->find_operation('baz', 'foobar');
is $operation, undef, 'find_operation returns undef on unknown operation';