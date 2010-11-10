use Test::More tests => 6;
use strict;
use warnings;
use SOAP::WSDL::XSD::Typelib::Builtin::unsignedByte;
my $unsignedByte = SOAP::WSDL::XSD::Typelib::Builtin::unsignedByte->new();
ok defined $unsignedByte;
ok $unsignedByte->set_value('127');
ok $unsignedByte = SOAP::WSDL::XSD::Typelib::Builtin::unsignedByte->new({ value => 127 });
is $unsignedByte * 1, 127, 'numerification';
is "$unsignedByte", "127", 'stringification';

ok $unsignedByte->isa('SOAP::WSDL::XSD::Typelib::Builtin::nonNegativeInteger'), 'inheritance';