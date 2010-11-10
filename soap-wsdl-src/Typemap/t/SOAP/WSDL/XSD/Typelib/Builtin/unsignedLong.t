use Test::More tests => 6;
use strict;
use warnings;
use SOAP::WSDL::XSD::Typelib::Builtin::unsignedLong;
my $unsignedLong = SOAP::WSDL::XSD::Typelib::Builtin::unsignedLong->new();
ok defined $unsignedLong;
ok $unsignedLong->set_value('127');
ok $unsignedLong = SOAP::WSDL::XSD::Typelib::Builtin::unsignedLong->new({ value => 127 });
is $unsignedLong * 1, 127, 'numerification';
is "$unsignedLong", "127", 'stringification';

ok $unsignedLong->isa('SOAP::WSDL::XSD::Typelib::Builtin::nonNegativeInteger'), 'inheritance';