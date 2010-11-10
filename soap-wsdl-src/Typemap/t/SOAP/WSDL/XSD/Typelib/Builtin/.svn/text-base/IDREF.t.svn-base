use Test::More tests => 5;
use strict;
use warnings;
use SOAP::WSDL::XSD::Typelib::Builtin::IDREF;
my $IDREF = SOAP::WSDL::XSD::Typelib::Builtin::IDREF->new();
is $IDREF->get_value(), undef;
$IDREF = SOAP::WSDL::XSD::Typelib::Builtin::IDREF->new({});
is $IDREF->get_value(), undef;
ok $IDREF = SOAP::WSDL::XSD::Typelib::Builtin::IDREF->new({ value => 127 });
is "$IDREF", "127", 'stringification';

ok $IDREF->isa('SOAP::WSDL::XSD::Typelib::Builtin::NCName'), 'inheritance';