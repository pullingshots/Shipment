use Test::More tests => 6;
use strict;
use warnings;
use SOAP::WSDL::XSD::Typelib::Builtin::gYear;
my $obj = SOAP::WSDL::XSD::Typelib::Builtin::gYear->new();
ok defined $obj;
ok $obj->set_value('1271');
ok $obj = SOAP::WSDL::XSD::Typelib::Builtin::gYear->new({ value => 1271 });
is $obj * 1, 1271, 'numerification';
is "$obj", "1271", 'stringification';

ok $obj->isa('SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType'), 'inheritance';