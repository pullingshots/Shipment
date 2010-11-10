use Test::More tests => 6;
use strict;
use warnings;
use SOAP::WSDL::XSD::Typelib::Builtin::short;
my $short = SOAP::WSDL::XSD::Typelib::Builtin::short->new();
ok defined $short;
ok $short->set_value('127');
ok $short = SOAP::WSDL::XSD::Typelib::Builtin::short->new({ value => 127 });
is $short * 1, 127, 'numerification';
is "$short", "127", 'stringification';

ok $short->isa('SOAP::WSDL::XSD::Typelib::Builtin::int'), 'inheritance';