use Test::More tests => 4;
use strict;
use warnings;
use SOAP::WSDL::XSD::Typelib::Builtin::nonNegativeInteger;
my $nonNegativeInteger = SOAP::WSDL::XSD::Typelib::Builtin::nonNegativeInteger->new();
ok $nonNegativeInteger = SOAP::WSDL::XSD::Typelib::Builtin::nonNegativeInteger->new({ value => 127 });
is $nonNegativeInteger * 1, 127, 'numerification';
is "$nonNegativeInteger", "127", 'stringification';

ok $nonNegativeInteger->isa('SOAP::WSDL::XSD::Typelib::Builtin::integer'), 'inheritance';