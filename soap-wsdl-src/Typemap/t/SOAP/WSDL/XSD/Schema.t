use strict;
use warnings;
use Test::More tests => 4;
use SOAP::WSDL::XSD::Element;
use_ok qw(SOAP::WSDL::XSD::Schema);

my $obj = SOAP::WSDL::XSD::Schema->new({
    element => [
        SOAP::WSDL::XSD::Element->new({
            name => 'foo',
            xmlns => { '#default' => 'bar' },
			targetNamespace => 'bar'
        }),
        SOAP::WSDL::XSD::Element->new({
            name => 'foo',
            xmlns => { '#default' => 'baz' },
			targetNamespace => 'baz'
        }),
        SOAP::WSDL::XSD::Element->new({
            name => 'foobar',
            xmlns => { '#default' => 'bar' },
			targetNamespace => 'bar'
        }),
    ],
    targetNamespace => 'bar',
});


my $found= $obj->find_element('bar', 'foobar');
is $found->get_name(), 'foobar', 'found Element';
$found = $obj->find_element('baz', 'foo');
is $found->get_name(), 'foo', 'found Element';

$found = $obj->find_element('baz', 'foobar');
is $found, undef, 'find_Element returns undef on unknown Element';
