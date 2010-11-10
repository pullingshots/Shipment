use Test::More tests => 5;
use strict;
use warnings;
use SOAP::WSDL::XSD::Typelib::Builtin::gMonthDay;
my $gMonthDay = SOAP::WSDL::XSD::Typelib::Builtin::gMonthDay->new();
ok defined $gMonthDay;
ok $gMonthDay->set_value('12-27');
ok $gMonthDay = SOAP::WSDL::XSD::Typelib::Builtin::gMonthDay->new({ value => '12-27' });
is "$gMonthDay", "12-27", 'stringification';

ok $gMonthDay->isa('SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType'), 'inheritance';