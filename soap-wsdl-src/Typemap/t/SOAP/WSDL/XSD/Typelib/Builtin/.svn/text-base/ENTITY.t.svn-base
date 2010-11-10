use Test::More tests => 9;
use strict;
use warnings;
use SOAP::WSDL::XSD::Typelib::Builtin::ENTITY;
my $ENTITY = SOAP::WSDL::XSD::Typelib::Builtin::ENTITY->new();

is $ENTITY->get_value(), undef;
$ENTITY->set_value(127);
is "$ENTITY", "127", 'stringification';
ok $ENTITY = SOAP::WSDL::XSD::Typelib::Builtin::ENTITY->new({ value => 127 });
is "$ENTITY", "127", 'stringification';
undef $ENTITY;

$ENTITY = SOAP::WSDL::XSD::Typelib::Builtin::ENTITY->new({});
is $ENTITY->get_value(), undef;
ok $ENTITY = SOAP::WSDL::XSD::Typelib::Builtin::ENTITY->new({ value => 127 });
is "$ENTITY", "127", 'stringification';
is $ENTITY->get_value(), "127", 'stringification';
ok $ENTITY->isa('SOAP::WSDL::XSD::Typelib::Builtin::NCName'), 'inheritance';
