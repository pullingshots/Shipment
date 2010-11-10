use strict;
use warnings;
use Test::More tests => 4;

use SOAP::WSDL::PortType;
use_ok qw(SOAP::WSDL::Definitions);

my $obj = SOAP::WSDL::Definitions->new({
    portType => [
        SOAP::WSDL::PortType->new({
            name => 'foo',
            targetNamespace => 'bar',
        }),
        SOAP::WSDL::PortType->new({
            name => 'foo',
            targetNamespace => 'baz',
        }),
        SOAP::WSDL::PortType->new({
            name => 'foobar',
            targetNamespace => 'bar',
        }),
    ]
});


my $found= $obj->find_portType('bar', 'foobar');
is $found->get_name(), 'foobar', 'found PortType';
$found = $obj->find_portType('baz', 'foo');
is $found->get_name(), 'foo', 'found PortType';

$found = $obj->find_portType('baz', 'foobar');
is $found, undef, 'find_PortType returns undef on unknown PortType';