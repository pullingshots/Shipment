use Test::More tests => 4;
use strict;
use warnings;
use SOAP::WSDL::XSD::Typelib::Builtin::nonPositiveInteger;
my $nonPositiveInteger = SOAP::WSDL::XSD::Typelib::Builtin::nonPositiveInteger->new();
ok $nonPositiveInteger = SOAP::WSDL::XSD::Typelib::Builtin::nonPositiveInteger->new({ value => 127 });
is $nonPositiveInteger * 1, 127, 'numerification';
is "$nonPositiveInteger", "127", 'stringification';

ok $nonPositiveInteger->isa('SOAP::WSDL::XSD::Typelib::Builtin::integer'), 'inheritance';