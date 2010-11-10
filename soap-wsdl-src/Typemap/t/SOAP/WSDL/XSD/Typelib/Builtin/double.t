use Test::More tests => 4;
use strict;
use warnings;
use SOAP::WSDL::XSD::Typelib::Builtin::double;
my $double = SOAP::WSDL::XSD::Typelib::Builtin::double->new();

ok $double = SOAP::WSDL::XSD::Typelib::Builtin::double->new({ value => 127.23 });
is $double * 1, 127.23, 'numerification';
is "$double", "127.23", 'stringification';

ok $double->isa('SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType'), 'inheritance';

# TODO test range