use Test::More tests => 6;
use strict;
use warnings;
use Scalar::Util qw(blessed);
use SOAP::WSDL::XSD::Typelib::Builtin::decimal;
my $decimal = SOAP::WSDL::XSD::Typelib::Builtin::decimal->new();
ok blessed $decimal;
is $decimal->get_value(), undef;
ok $decimal = SOAP::WSDL::XSD::Typelib::Builtin::decimal->new({ value => 127 });
is $decimal * 1, 127, 'numerification';
is "$decimal", "127", 'stringification';

ok $decimal->isa('SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType'), 'inheritance';

# TODO: test range (bigint)