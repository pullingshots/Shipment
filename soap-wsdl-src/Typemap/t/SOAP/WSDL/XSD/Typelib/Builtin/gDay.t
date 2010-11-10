use Test::More tests => 6;
use strict;
use warnings;
use SOAP::WSDL::XSD::Typelib::Builtin::gDay;
my $obj = SOAP::WSDL::XSD::Typelib::Builtin::gDay->new();
ok defined $obj;
ok $obj->set_value('27');
ok $obj = SOAP::WSDL::XSD::Typelib::Builtin::gDay->new({ value => 27 });
is $obj * 1, 27, 'numerification';
is "$obj", "27", 'stringification';

ok $obj->isa('SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType'), 'inheritance';