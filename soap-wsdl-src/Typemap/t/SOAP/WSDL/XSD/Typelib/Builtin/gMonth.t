use Test::More tests => 6;
use strict;
use warnings;
use SOAP::WSDL::XSD::Typelib::Builtin::gMonth;
my $obj = SOAP::WSDL::XSD::Typelib::Builtin::gMonth->new();
ok defined $obj;
ok $obj->set_value('12');
ok $obj = SOAP::WSDL::XSD::Typelib::Builtin::gMonth->new({ value => 12 });
is $obj * 1, 12, 'numerification';
is "$obj", "12", 'stringification';

ok $obj->isa('SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType'), 'inheritance';