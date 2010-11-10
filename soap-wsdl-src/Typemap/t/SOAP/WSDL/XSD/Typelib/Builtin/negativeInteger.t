use Test::More tests => 4;
use strict;
use warnings;
use SOAP::WSDL::XSD::Typelib::Builtin::negativeInteger;
my $negativeInteger = SOAP::WSDL::XSD::Typelib::Builtin::negativeInteger->new();
ok $negativeInteger = SOAP::WSDL::XSD::Typelib::Builtin::negativeInteger->new({ value => 127 });
is $negativeInteger * 1, 127, 'numerification';
is "$negativeInteger", "127", 'stringification';

ok $negativeInteger->isa('SOAP::WSDL::XSD::Typelib::Builtin::nonPositiveInteger'), 'inheritance';