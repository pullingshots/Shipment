use Test::More tests => 4;
use strict;
use warnings;
use SOAP::WSDL::XSD::Typelib::Builtin::QName;
my $obj = SOAP::WSDL::XSD::Typelib::Builtin::QName->new();
ok defined $obj;
ok $obj->set_value('wsdl:foo');
ok $obj = SOAP::WSDL::XSD::Typelib::Builtin::QName->new({ value => 'wsdl:foo' });

ok $obj->isa('SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType'), 'inheritance';