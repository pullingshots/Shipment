use Test::More tests => 8;
use strict;
use warnings;
use SOAP::WSDL::XSD::Typelib::Builtin::IDREFS;
my $IDREFS = SOAP::WSDL::XSD::Typelib::Builtin::IDREFS->new();
is $IDREFS->get_value(), undef;
$IDREFS = SOAP::WSDL::XSD::Typelib::Builtin::IDREFS->new({});
is $IDREFS->get_value(), undef;
ok $IDREFS = SOAP::WSDL::XSD::Typelib::Builtin::IDREFS->new({ value => [ 127 , 'Test' ] });
is $IDREFS->serialize(), "127 Test", 'stringification';

ok $IDREFS = SOAP::WSDL::XSD::Typelib::Builtin::IDREFS->new({ value => 'Test' });
is "$IDREFS", "Test", 'stringification';

ok $IDREFS->isa('SOAP::WSDL::XSD::Typelib::Builtin::IDREF'), 'inheritance';
ok $IDREFS->isa('SOAP::WSDL::XSD::Typelib::Builtin::list'), 'inheritance';