use Test::More tests => 4;
use strict;
use warnings;
use SOAP::WSDL::XSD::Typelib::Builtin::float;
my $float = SOAP::WSDL::XSD::Typelib::Builtin::float->new();
ok $float = SOAP::WSDL::XSD::Typelib::Builtin::float->new({ value => 127.23 });
is $float * 1, 127.23, 'numerification';
is "$float", "127.23", 'stringification';

ok $float->isa('SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType'), 'inheritance';

# TODO test range