use Test::More tests => 6;
use strict;
use warnings;
use SOAP::WSDL::XSD::Typelib::Builtin::integer;
my $integer = SOAP::WSDL::XSD::Typelib::Builtin::integer->new();
is $integer->get_value(), undef;
$integer = SOAP::WSDL::XSD::Typelib::Builtin::integer->new({});
is $integer->get_value(), undef;
ok $integer = SOAP::WSDL::XSD::Typelib::Builtin::integer->new({ value => 127 });
is $integer * 1, 127, 'numerification';
is "$integer", "127", 'stringification';

ok $integer->isa('SOAP::WSDL::XSD::Typelib::Builtin::decimal'), 'inheritance';