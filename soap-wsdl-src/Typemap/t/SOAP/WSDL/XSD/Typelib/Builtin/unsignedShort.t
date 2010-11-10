use Test::More tests => 6;
use strict;
use warnings;
use SOAP::WSDL::XSD::Typelib::Builtin::unsignedShort;
my $unsignedShort = SOAP::WSDL::XSD::Typelib::Builtin::unsignedShort->new();
ok defined $unsignedShort;
ok $unsignedShort->set_value('127');
ok $unsignedShort = SOAP::WSDL::XSD::Typelib::Builtin::unsignedShort->new({ value => 127 });
is $unsignedShort * 1, 127, 'numerification';
is "$unsignedShort", "127", 'stringification';

ok $unsignedShort->isa('SOAP::WSDL::XSD::Typelib::Builtin::nonNegativeInteger'), 'inheritance';