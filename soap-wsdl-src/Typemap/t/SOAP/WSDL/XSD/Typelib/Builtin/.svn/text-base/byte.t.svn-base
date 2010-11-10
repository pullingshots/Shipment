use Test::More tests => 6;
use strict;
use warnings;
use SOAP::WSDL::XSD::Typelib::Builtin::byte;
my $byte = SOAP::WSDL::XSD::Typelib::Builtin::byte->new();
ok defined $byte;
ok $byte->set_value('127');
ok $byte = SOAP::WSDL::XSD::Typelib::Builtin::byte->new({ value => 127 });
is $byte * 1, 127, 'numerification';
is "$byte", "127", 'stringification';

ok $byte->isa('SOAP::WSDL::XSD::Typelib::Builtin::short'), 'inheritance';