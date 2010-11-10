use Test::More tests => 5;
use strict;
use warnings;
use SOAP::WSDL::XSD::Typelib::Builtin::NCName;
my $NCName = SOAP::WSDL::XSD::Typelib::Builtin::NCName->new();
is $NCName->get_value(), undef;
$NCName = SOAP::WSDL::XSD::Typelib::Builtin::NCName->new({});
is $NCName->get_value(), undef;
ok $NCName = SOAP::WSDL::XSD::Typelib::Builtin::NCName->new({ value => 'Test' });
is "$NCName", "Test", 'stringification';

ok $NCName->isa('SOAP::WSDL::XSD::Typelib::Builtin::Name'), 'inheritance';