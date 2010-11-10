use strict;
use warnings;

package TestResolver;
sub get_typemap { {} };
sub get_class {};

package main;
use Test::More tests => 11;

use SOAP::WSDL::Deserializer::XSD;

my $obj;

ok $obj = SOAP::WSDL::Deserializer::XSD->new();
ok $obj = SOAP::WSDL::Deserializer::XSD->new({
    class_resolver => 'TestResolver',
    some_other_option => 'ignored',
});

my $fault = $obj->generate_fault();

is $fault->get_faultstring(), 'Unknown error';
is $fault->get_faultactor(), 'urn:localhost';
is $fault->get_faultcode(), 'SOAP-ENV:Client';

isa_ok $obj->deserialize('rubbeldiekatz'), 'SOAP::WSDL::SOAP::Typelib::Fault11';
isa_ok $obj->deserialize('<zumsel></zumsel>'), 'SOAP::WSDL::SOAP::Typelib::Fault11';
isa_ok $obj->deserialize('<Envelope xmlns="huchmampf"></Envelope>'), 'SOAP::WSDL::SOAP::Typelib::Fault11';
is $obj->deserialize('<SOAP-ENV:Envelope
        xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" >
    <SOAP-ENV:Body ></SOAP-ENV:Body></SOAP-ENV:Envelope>'), undef, 'Deserialize empty envelope';

is $obj->get_strict(), 1;
$obj->set_strict(0);

is $obj->deserialize('<SOAP-ENV:Envelope
        xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" >
    <SOAP-ENV:Body ><foo></foo></SOAP-ENV:Body></SOAP-ENV:Envelope>'),
    undef,
    'Deserialize envelope with unknown element with strict disabled';
