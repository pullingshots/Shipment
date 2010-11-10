use Test::More tests => 5;
use strict;
use warnings;
use SOAP::WSDL::XSD::Typelib::Builtin::Name;
my $Name = SOAP::WSDL::XSD::Typelib::Builtin::Name->new();
is $Name->get_value(), undef;
$Name = SOAP::WSDL::XSD::Typelib::Builtin::Name->new({});
is $Name->get_value(), undef;
ok $Name = SOAP::WSDL::XSD::Typelib::Builtin::Name->new({ value => 'xsd:Test' });
is "$Name", "xsd:Test", 'stringification';

ok $Name->isa('SOAP::WSDL::XSD::Typelib::Builtin::normalizedString'), 'inheritance';