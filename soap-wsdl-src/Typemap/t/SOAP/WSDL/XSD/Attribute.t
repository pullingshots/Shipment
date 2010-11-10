use strict;
use warnings;
use Test::More tests => 2; #qw(no_plan);

use_ok qw(SOAP::WSDL::XSD::Attribute);

use SOAP::WSDL::Expat::WSDLParser;
my $parser = SOAP::WSDL::Expat::WSDLParser->new();

my $xml = q{<s:schema elementFormDefault="qualified"
            targetNamespace="urn:HelloWorld" 
            xmlns="urn:HelloWorld" xmlns:s="http://www.w3.org/2001/XMLSchema">
            <s:element name="sayHello">
                <s:complexType>
                    <s:sequence>
                        <s:element minOccurs="0" maxOccurs="1" name="name"
                            type="s:string" />
                        <s:element minOccurs="0" maxOccurs="1" name="givenName"
                            type="s:string" nillable="1" />
                    </s:sequence>
                    <s:attribute name="testAttr" type="s:string" use="optional"></s:attribute>
                </s:complexType>
            </s:element>

            <s:element name="sayHelloResponse">
                <s:complexType>
                    <s:sequence>
                        <s:element minOccurs="0" maxOccurs="1"
                            name="sayHelloResult" type="s:string" />
                    </s:sequence>
                </s:complexType>
            </s:element>
        </s:schema>
};

my $schema = $parser->parse($xml);

is $schema->find_element('urn:HelloWorld', 'sayHello')
    ->first_complexType()
    ->first_attribute()->get_name(),
    'testAttr', 'found attribute';