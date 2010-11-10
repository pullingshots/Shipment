use strict;
use warnings;
use Test::More qw(no_plan);
use File::Basename;
my $path = dirname __FILE__;
use diagnostics;
use SOAP::WSDL::Generator::Iterator;
use SOAP::WSDL::Generator::Iterator::Code;

use_ok qw(SOAP::WSDL::Generator::Visitor::Code);

my $visitor;
ok $visitor = SOAP::WSDL::Generator::Visitor::Code->new(), 'constructor';

my $iterator = SOAP::WSDL::Generator::Iterator::Code->new({
    visitor => $visitor,
});

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

$iterator->walk( $definitions );



# $definitions->_accept( $visitor );

use Data::Dumper;
# print Dumper $visitor->get_class();

$Data::Dumper::Terse = 1;
while (my ($name, $value) = each %{ $visitor->get_class }) {
print "            
package $name; 
use strict; use warnings;
use Class::Std::Storable;
use base qw(SOAP::WSDL::Client);

sub START {
    \$_[0]->set_proxy('$value->{location}') if not \$_[2]->{proxy};
    \$_[0]->set_class_resolver('$value->{class_resolver}')
        if not \$_[2]->{class_resolver};
}
";

    while (my ($operation, $info) = each %{ $value->{ operations }}) {
        print "
sub $operation {
    my (\$self, \$body, \$header) = \@_;
    # call SUPER to allow 'call' as method name
    return \$self->SUPER::call(" . Dumper($info) . "
    \$body, \$header);
}
";
    }
}

print "1;\n";

#for (values %{ $visitor->get_class }) {
#    print join "\n", @{$_};
#}

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