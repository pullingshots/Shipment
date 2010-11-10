use strict;
use warnings;
use Test::More tests => 3; #qw(no_plan);

use_ok qw(SOAP::WSDL::XSD::Enumeration);

use SOAP::WSDL::Expat::WSDLParser;
my $parser = SOAP::WSDL::Expat::WSDLParser->new();

my $xml = q{<s:schema elementFormDefault="qualified"
    targetNamespace="urn:HelloWorld" xmlns:s="http://www.w3.org/2001/XMLSchema"
    xmlns="urn:HelloWorld">
    <s:simpleType name="test">
        <s:restriction base="s:string">
            <s:enumeration value="foo"/>
            <s:enumeration value="bar">
                <s:annotation>
                    <s:documentation>foobar</s:documentation>
                </s:annotation>
            </s:enumeration>
        </s:restriction>
    </s:simpleType>
</s:schema>
};

my $schema = $parser->parse($xml);

is $schema->find_type('urn:HelloWorld', 'test')
    ->get_enumeration()->[0]->get_value(), 'foo';
is $schema->find_type('urn:HelloWorld', 'test')
    ->get_enumeration()->[1]->get_value(), 'bar';
