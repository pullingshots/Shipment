use Test::More tests => 5;
use strict;
use warnings;
use SOAP::WSDL::XSD::Typelib::Builtin::NOTATION;
my $NOTATION = SOAP::WSDL::XSD::Typelib::Builtin::NOTATION->new();
is $NOTATION->get_value(), undef;
$NOTATION = SOAP::WSDL::XSD::Typelib::Builtin::NOTATION->new({});
is $NOTATION->get_value(), undef;
ok $NOTATION = SOAP::WSDL::XSD::Typelib::Builtin::NOTATION->new({ value => 'Test' });
is "$NOTATION", "Test", 'stringification';

ok $NOTATION->isa('SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType'), 'inheritance';