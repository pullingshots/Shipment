use Test::More tests => 5;
use strict;
use warnings;
use SOAP::WSDL::XSD::Typelib::Builtin::duration;
my $obj = SOAP::WSDL::XSD::Typelib::Builtin::duration->new();
ok defined $obj;
ok $obj->set_value('27');
ok $obj = SOAP::WSDL::XSD::Typelib::Builtin::duration->new({ value => 'P1347Y'});

is "$obj", 'P1347Y', 'stringification';

ok $obj->isa('SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType'), 'inheritance';