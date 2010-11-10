use strict;
use warnings;
use Test::More tests => 5;
use File::Basename;
use File::Spec;
my $path = File::Spec->rel2abs( dirname __FILE__ );
use SOAP::WSDL::Generator::Template::Plugin::XSD;
use SOAP::WSDL::Generator::Iterator::WSDL11;
use SOAP::WSDL::Generator::PrefixResolver;
use_ok qw(SOAP::WSDL::Generator::Visitor::Typemap);

my $visitor;
ok $visitor = SOAP::WSDL::Generator::Visitor::Typemap->new({
    resolver => SOAP::WSDL::Generator::Template::Plugin::XSD->new({
        prefix_resolver=> SOAP::WSDL::Generator::PrefixResolver->new({
             prefix => {
                type => 'TestTypes',
                element => 'TestElements',
                typemap => 'TestTypemap',
             }
        }),
    })
}), 'constructor';

use SOAP::WSDL::Expat::WSDLParser;

my $parser = SOAP::WSDL::Expat::WSDLParser->new();

$parser->parse_file(
    $path . '/../../../../acceptance/wsdl/'
    #. '04_element.wsdl'
    #. '11_helloworld.wsdl'
    #. '008_complexType.wsdl'
    . '006_sax_client.wsdl'
);

my $definitions = $parser->get_data();

my $iter = SOAP::WSDL::Generator::Iterator::WSDL11->new({
    definitions => $definitions
});
$visitor->set_definitions($definitions);
$iter->init();
while (my $node = $iter->get_next()) {
    $node->_accept( $visitor );
};

my $typemap = $visitor->get_typemap();
is $typemap->{'EnqueueMessage/MMessage/MKeepalive'}, 'TestTypes::TKeepalive', 'content';
is $typemap->{'EnqueueMessageResponse'}, 'TestElements::EnqueueMessageResponse', 'content';
is $typemap->{'KeepaliveMessageResponse'}, 'TestElements::KeepaliveMessageResponse', 'content';
use Data::Dumper;
print Dumper $typemap;

sub wsdl {
q{<?xml version="1.0" encoding="UTF-8"?>
<definitions xmlns:http="http://schemas.xmlsoap.org/wsdl/http/"
xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/"
xmlns:s="http://www.w3.org/2001/XMLSchema"
xmlns:s0="urn:HelloWorld"
xmlns:soapenc="http://schemas.xmlsoap.org/soap/encoding/"
xmlns:tm="http://microsoft.com/wsdl/mime/textMatching/"
xmlns:mime="http://schemas.xmlsoap.org/wsdl/mime/"
targetNamespace="urn:HelloWorld"
xmlns="http://schemas.xmlsoap.org/wsdl/">
  <types>
    <s:schema elementFormDefault="qualified"
    targetNamespace="urn:HelloWorld">
      <s:element name="sayHello">
        <s:complexType>
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="name"
            type="s:string" />

            <s:element minOccurs="0" maxOccurs="1" name="givenName"
            type="s:string" nillable="1"/>

<!--            <s:element minOccurs="0" maxOccurs="1" name="test"
            type="s0:test2" /> //-->
          </s:sequence>
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

      <s:complexType name="test2">
        <s:sequence>
          <s:element minOccurs="0" maxOccurs="1" name="name"
          type="s:string" />

          <s:element minOccurs="0" maxOccurs="1" name="givenName"
          type="s:string" />
        </s:sequence>
      </s:complexType>

      <s:complexType name="testExtended">
        <s:extension base="s0:test2">
          <s:sequence>
            <s:element minOccurs="0" maxOccurs="1" name="extend"
            type="s:string" />
          </s:sequence>
        </s:extension>
      </s:complexType>
    </s:schema>
  </types>

  <message name="sayHelloSoapIn">
    <part name="parameters" element="s0:sayHello" />

<!--    <part name="test1" type="s0:testExtended" />

    <part name="test2" type="s0:test2"
    targetNamespace="urn:test2" /> //-->
  </message>

  <message name="sayHelloSoapOut">
    <part name="parameters" element="s0:sayHelloResponse" />
  </message>

  <portType name="Service1Soap">
    <operation name="sayHello">
      <input message="s0:sayHelloSoapIn" />

      <output message="s0:sayHelloSoapOut" />
    </operation>
  </portType>

  <binding name="Service1Soap" type="s0:Service1Soap">
    <soap:binding transport="http://schemas.xmlsoap.org/soap/http"
    style="document" />

    <operation name="sayHello">
      <soap:operation soapAction="urn:HelloWorld#sayHello"
      style="document" />

      <input>
        <soap:body use="literal" />
      </input>

      <output>
        <soap:body use="literal" />
      </output>
    </operation>
  </binding>

  <service name="Service1">
    <port name="Service1Soap" binding="s0:Service1Soap">
      <soap:address
      location="http://helloworld/helloworld.asmx" />
    </port>
  </service>
</definitions>
}
}
