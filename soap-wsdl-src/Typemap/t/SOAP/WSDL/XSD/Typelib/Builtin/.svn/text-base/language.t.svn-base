use Test::More tests => 5;
use strict;
use warnings;
use SOAP::WSDL::XSD::Typelib::Builtin::language;
my $Name = SOAP::WSDL::XSD::Typelib::Builtin::language->new();
is $Name->get_value(), undef;
$Name = SOAP::WSDL::XSD::Typelib::Builtin::language->new({});
is $Name->get_value(), undef;
ok $Name = SOAP::WSDL::XSD::Typelib::Builtin::language->new({ value => 'DE' });
is "$Name", "DE", 'stringification';

ok $Name->isa('SOAP::WSDL::XSD::Typelib::Builtin::token'), 'inheritance';