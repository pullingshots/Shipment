use Test::More tests => 6;
use strict;
use warnings;
use SOAP::WSDL::XSD::Typelib::Builtin::unsignedInt;
my $unsignedInt = SOAP::WSDL::XSD::Typelib::Builtin::unsignedInt->new();
ok defined $unsignedInt;
ok $unsignedInt->set_value('127');
ok $unsignedInt = SOAP::WSDL::XSD::Typelib::Builtin::unsignedInt->new({ value => 127 });
is $unsignedInt * 1, 127, 'numerification';
is "$unsignedInt", "127", 'stringification';

ok $unsignedInt->isa('SOAP::WSDL::XSD::Typelib::Builtin::nonNegativeInteger'), 'inheritance';