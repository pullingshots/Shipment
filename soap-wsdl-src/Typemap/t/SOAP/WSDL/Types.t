use strict;
use warnings;
use Test::More tests => 6;

use SOAP::WSDL::XSD::Attribute;

use SOAP::WSDL::XSD::Schema;
use_ok qw(SOAP::WSDL::Types);

my $types = SOAP::WSDL::Types->new();
$types->set_xmlns({
    foo => 'bar',
});

my $attr = SOAP::WSDL::XSD::Attribute->new({
    name => 'test',
    targetNamespace => 'bar'
});

my $schema = SOAP::WSDL::XSD::Schema->new();
$schema->push_attribute( $attr );

$types->push_schema(
    $schema
);

ok my $found_attr = $types->find_attribute('bar', 'test');
is $found_attr, $attr;

ok $types->find_attribute([ 'bar', 'test' ]);

ok ! $types->find_attribute('foo', 'test');

ok ! $types->find_element('foo', 'test');
