package Foo;
sub serialize {
    $_[2] = q{} if not defined $_[2];
    return "serialized $_[1] $_[2]" . join ' ', @{$_[3]->{ attributes } || [] } if $_[3];
}
package main;
use strict;
use warnings;
use Test::More tests => 16;

use_ok qw(SOAP::WSDL::XSD::Element);

my $element = SOAP::WSDL::XSD::Element->new();

is $element->first_simpleType(), undef;

$element->set_simpleType('Foo');
is $element->first_simpleType(), 'Foo';

is $element->serialize('Foobar', 'Bar', { namespace => {} } ), 'serialized Foobar Bar';
is $element->serialize('Foobar', undef, { namespace => {} } ), 'serialized Foobar ';

$element->set_simpleType( [ 'Foo', 'Bar' ]);
is $element->first_simpleType(), 'Foo';

is $element->first_complexType(), undef;

$element->set_complexType('Foo');
is $element->first_complexType(), 'Foo';

$element->set_complexType( [ 'Foo', 'Bar' ]);
is $element->first_complexType(), 'Foo';

$element->set_default('Foo');
is $element->serialize('Foobar', undef, { namespace => {} } ), 'serialized Foobar Foo';

$element->set_targetNamespace('urn:foobar');
is $element->serialize('Foobar', undef, { namespace => {}, qualify => 1 } ), 'serialized Foobar Foo xmlns="urn:foobar"';

$element->set_targetNamespace('urn:foobar');
is $element->serialize('Foobar', 'Bar', { namespace => {}, qualify => 1 } ), 'serialized Foobar Bar xmlns="urn:foobar"';


$element->set_name('Bar');
is $element->serialize(undef, undef, { namespace => {} } ), 'serialized Bar Foo';

$element->set_fixed('Foobar');
is $element->serialize(undef, undef, { namespace => {} } ), 'serialized Bar Foobar';

$element->set_abstract('1');
is $element->serialize('Bar', undef, { namespace => {} } ), 'serialized Bar Foobar';

eval { $element->serialize(undef, undef, { namespace => {} } ) };
like $@, qr{cannot \s serialize \s abstract}xms;
