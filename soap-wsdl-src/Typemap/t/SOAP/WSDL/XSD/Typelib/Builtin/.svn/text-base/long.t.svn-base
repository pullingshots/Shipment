use Test::More tests => 6;
use strict;
use warnings;
use SOAP::WSDL::XSD::Typelib::Builtin::long;
my $long = SOAP::WSDL::XSD::Typelib::Builtin::long->new();
ok defined $long;
ok $long->set_value('127');
ok $long = SOAP::WSDL::XSD::Typelib::Builtin::long->new({ value => 127 });
is $long * 1, 127, 'numerification';
is "$long", "127", 'stringification';

ok $long->isa('SOAP::WSDL::XSD::Typelib::Builtin::decimal'), 'inheritance';