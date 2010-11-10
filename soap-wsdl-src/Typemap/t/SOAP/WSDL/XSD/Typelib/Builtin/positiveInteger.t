use Test::More tests => 4;
use strict;
use warnings;
use SOAP::WSDL::XSD::Typelib::Builtin::positiveInteger;
my $positiveInteger = SOAP::WSDL::XSD::Typelib::Builtin::positiveInteger->new();
ok $positiveInteger = SOAP::WSDL::XSD::Typelib::Builtin::positiveInteger->new({ value => 127 });
is $positiveInteger * 1, 127, 'numerification';
is "$positiveInteger", "127", 'stringification';

ok $positiveInteger->isa('SOAP::WSDL::XSD::Typelib::Builtin::nonNegativeInteger'), 'inheritance';