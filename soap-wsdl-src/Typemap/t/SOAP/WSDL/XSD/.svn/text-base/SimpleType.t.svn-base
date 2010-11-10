use strict;
use warnings;
use Test::More tests => 12;

use_ok qw(SOAP::WSDL::XSD::SimpleType);

my $obj = SOAP::WSDL::XSD::SimpleType->new();

$obj->set_list({ LocalName => 'foo', Value => 'bar'},
    { LocalName => 'itemType', Value => 'xsd:int'} );
is $obj->get_flavor(), 'list';
is $obj->get_itemType(), 'xsd:int';

is $obj->serialize('Foo', ['Foo', 'Bar']), '<Foo>Foo Bar</Foo>';

$obj->set_union({ LocalName => 'foo', Value => 'bar'},
    { LocalName => 'memberTypes', Value => 'xsd:int'} );
is $obj->get_flavor(), 'union';
is $obj->get_base()->[0], 'xsd:int';

$obj->set_union({ LocalName => 'foo', Value => 'bar'},
    { LocalName => 'memberTypes', Value => 'xsd:int xsd:string'} );
is $obj->get_flavor(), 'union';
is $obj->get_base()->[1], 'xsd:string';

is $obj->serialize('Foo', 'Foobar'), '<Foo>Foobar</Foo>';

$obj->set_flavor('enumeration');
is $obj->serialize('Foo', 'Foobar'), '<Foo>Foobar</Foo>';

# TODO die on non-serializable content...
$obj->set_flavor('');
is $obj->serialize('Foo', 'Foobar'), '';

ok eval { $obj->set_restriction({ LocalName => 'bar'}, { LocalName => 'base', Value => 'string' }); 1; };