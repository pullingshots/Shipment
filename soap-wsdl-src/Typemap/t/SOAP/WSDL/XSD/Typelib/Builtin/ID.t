use Test::More tests => 5;
use strict;
use warnings;
use SOAP::WSDL::XSD::Typelib::Builtin::ID;
my $ID = SOAP::WSDL::XSD::Typelib::Builtin::ID->new();
is $ID->get_value(), undef;
$ID = SOAP::WSDL::XSD::Typelib::Builtin::ID->new({});
is $ID->get_value(), undef;
ok $ID = SOAP::WSDL::XSD::Typelib::Builtin::ID->new({ value => 'Test' });
is "$ID", 'Test', 'stringification';

ok $ID->isa('SOAP::WSDL::XSD::Typelib::Builtin::NCName'), 'inheritance';