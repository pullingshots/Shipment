use Test::More tests => 5;
use strict;
use warnings;
use SOAP::WSDL::XSD::Typelib::Builtin::token;
my $token = SOAP::WSDL::XSD::Typelib::Builtin::token->new();
is $token->get_value(), undef;
$token = SOAP::WSDL::XSD::Typelib::Builtin::token->new({});
is $token->get_value(), undef;
ok $token = SOAP::WSDL::XSD::Typelib::Builtin::token->new({ value => 127 });
is "$token", "127", 'stringification';

ok $token->isa('SOAP::WSDL::XSD::Typelib::Builtin::normalizedString'), 'inheritance';