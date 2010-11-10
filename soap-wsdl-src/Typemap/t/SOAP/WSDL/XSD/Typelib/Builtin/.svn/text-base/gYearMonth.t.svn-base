use Test::More tests => 5;
use strict;
use warnings;
use SOAP::WSDL::XSD::Typelib::Builtin::gYearMonth;
my $obj = SOAP::WSDL::XSD::Typelib::Builtin::gYearMonth->new();
ok defined $obj;
ok $obj->set_value('1271');
ok $obj = SOAP::WSDL::XSD::Typelib::Builtin::gYearMonth->new({ value => '1271-12' });
is "$obj", "1271-12", 'stringification';

ok $obj->isa('SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType'), 'inheritance';