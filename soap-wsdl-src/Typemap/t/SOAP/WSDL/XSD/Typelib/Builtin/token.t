use Test::More tests => 5;
use strict;
use warnings;
use SOAP::WSDL::XSD::Typelib::Builtin::NMTOKEN;
my $NMTOKEN = SOAP::WSDL::XSD::Typelib::Builtin::NMTOKEN->new();
is $NMTOKEN->get_value(), undef;
$NMTOKEN = SOAP::WSDL::XSD::Typelib::Builtin::NMTOKEN->new({});
is $NMTOKEN->get_value(), undef;
ok $NMTOKEN = SOAP::WSDL::XSD::Typelib::Builtin::NMTOKEN->new({ value => 127 });
is "$NMTOKEN", "127", 'stringification';

ok $NMTOKEN->isa('SOAP::WSDL::XSD::Typelib::Builtin::token'), 'inheritance';