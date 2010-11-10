#!/usr/bin/perl -w
use strict;
use warnings;
use Test::More;
use lib '../lib';

if (eval "require XML::LibXML") {
     plan tests => 18;
}
else {
    plan skip_all => "Cannot test without XML::LibXML";
}

eval {
    require Test::XML;
    import Test::XML;
};

use_ok(qw/SOAP::WSDL::SAX::WSDLHandler/);

my $filter;

ok($filter = SOAP::WSDL::SAX::WSDLHandler->new(
), "Object creation");

my $parser = XML::LibXML->new();
$parser->set_handler( $filter );

$parser->parse_string( xml() );

my $wsdl;
ok( $wsdl = $filter->get_data() , "get object tree");

my $types = $wsdl->first_types();

is $types->get_parent(), $wsdl , 'types parent';

my $serializer_options = {
    readable => 1,
    autotype => 1,
    namespace => { 'urn:myNamespace' => 'tns',
        "http://www.w3.org/2001/XMLSchema" => 'xsd' },
    typelib => $wsdl->first_types(),
    indent => "\t",
};

my $xml;
my $type = $types->find_type( 'urn:myNamespace', 'testSimpleType1' );


ok($xml = $type->serialize( 'test', 1 , $serializer_options ),
    "serialize simple Type"
);

# print $xml;

SKIP: {
    skip_without_test_xml();
    is_xml( $xml, '<test type="tns:testSimpleType1">1</test>',
        "content compare" );
};

$type = $types->find_type( 'urn:myNamespace', 'testSimpleList' );
ok($xml = $type->serialize( 'testList', [ 1, 2, 3 ] , $serializer_options ),
    "serialize simple list type"
);
SKIP: {
    skip_without_test_xml();
    is_xml( $xml, '<testList type="tns:testSimpleList">1 2 3</testList>',
        "content compare" );
};

$type = $types->find_element( 'urn:myNamespace', 'TestElement' );

ok($xml = $type->serialize( undef, 1 , $serializer_options ),
    "serialize simple element");
SKIP: {
    skip_without_test_xml();
    is_xml( $xml, '<TestElement type="xsd:int">1</TestElement>',
        "content compare" );
};

ok( $xml = $types->find_type( 'urn:myNamespace', 'length3')->serialize(
        'TestComplex', { size => -13, unit => 'BLA' } ,
        $serializer_options
    ),
    "serialize complex type");

SKIP: {
    skip_without_test_xml();
    is_xml( $xml, q{
        <TestComplex type="tns:length3">
           <size type="xsd:non-positive-integer">-13</size>
           <unit type="xsd:NMTOKEN">BLA</unit>
        </TestComplex>},
        "content compare" );
};

ok($xml = $types->find_element( 'urn:myNamespace', 'TestElementComplexType')
    ->serialize(
        undef, { size => -13, unit => 'BLA' } , $serializer_options ),
        "serialize element with complex type"
);
SKIP: {
    skip_without_test_xml();
    is_xml( $xml, q{
        <TestElementComplexType type="tns:length3">
                <size type="xsd:non-positive-integer">-13</size>
                <unit type="xsd:NMTOKEN">BLA</unit>
        </TestElementComplexType>
    },
    "content compare" );
};


ok($xml = $types->find_type( 'urn:myNamespace', 'complex')->serialize(
        'complexComplex',
        { 'length' => {  size => -13, unit => 'BLA' }, 'int' => 1 },
        $serializer_options ),
        "serialize complex type with complex content"
);
SKIP: {
    skip_without_test_xml();
    is_xml( $xml, q{
        <complexComplex type="tns:complex">
                <length type="tns:length3">
                        <size type="xsd:non-positive-integer">-13</size>
                        <unit type="xsd:NMTOKEN">BLA</unit>
                </length>
                <int type="xsd:int">1</int>
        </complexComplex>
        },
        "content compare" );
}
ok($xml = $wsdl->find_message('urn:myNamespace', 'testRequest')
        ->get_part()->[0]->serialize(
        undef, 
        { test => { length => {  size => -13, unit => 'BLA' } , int => 3 } },
    $serializer_options ),
    "serialize part"
);
SKIP: {
    skip_without_test_xml();
    is_xml( $xml, q{
        <test type="tns:complex">
                <length type="tns:length3">
                        <size type="xsd:non-positive-integer">-13</size>
                        <unit type="xsd:NMTOKEN">BLA</unit>
                </length>
                <int type="xsd:int">3</int>
        </test>
    },
    "content compare")
};

my $opt = {
        typelib => $types,
        readable => 1,
        autotype => 0,
        namespace => { 'urn:myNamespace' => 'tns',
                'http://www.w3.org/2001/XMLSchema' => 'xsd',
                'http://schemas.xmlsoap.org/wsdl/' => 'wsdl',
        },
        indent => "",
        wsdl => $wsdl,
};

# ok $wsdl->explain($opt) =~ m/#optional/m;

sub skip_without_test_xml {
    skip("Test::XML not available", 1) if (not $Test::XML::VERSION);
}

sub xml
{
        return q{<?xml version="1.0"?>
<definitions name="simpleType"
        targetNamespace="urn:myNamespace"
        xmlns="http://schemas.xmlsoap.org/wsdl/"
        xmlns:tns="urn:myNamespace"
        xmlns:xsd="http://www.w3.org/2001/XMLSchema"
        xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/"
        xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/"
>
        <types>
                <xsd:schema targetNamespace="urn:myNamespace">
                <xsd:complexType name="length3">
                         <xsd:all>
                                  <xsd:element name="size" type="xsd:non-positive-integer"/>
                                  <xsd:element name="unit" type="xsd:NMTOKEN"/>
                         </xsd:all>
                </xsd:complexType>

                <xsd:complexType name="complex">
                        <xsd:sequence>
                                  <xsd:element name="length" type="tns:length3"/>
                                  <xsd:element name="int" type="xsd:int"/>
                         </xsd:sequence>
                </xsd:complexType>

                <xsd:element name="TestElement" type="xsd:int"/>
                <xsd:element name="TestElementComplexType" type="tns:length3"/>
                <xsd:simpleType name="testSimpleType1">
                        <xsd:restriction base="int">
                                <xsd:enumeration value="1"/>
                                <xsd:enumeration value="2"/>
                                <xsd:enumeration value="3"/>
                        </xsd:restriction>
                </xsd:simpleType>

                <xsd:simpleType name="testSimpleList">
                        <xsd:annotation>
                                <xsd:documentation>
                                SimpleType Test
                                </xsd:documentation>
                        </xsd:annotation>
                        <xsd:list itemType="int">
                        </xsd:list>
                </xsd:simpleType>
                <xsd:simpleType name="testSimpleUnion">
                        <xsd:annotation>
                                <xsd:documentation>
                                SimpleType Union test
                                </xsd:documentation>
                        </xsd:annotation>
                        <xsd:union memberTypes="int float">
                        </xsd:union>
                </xsd:simpleType>
                </xsd:schema>
        </types>
        <message name="testRequest">
                <part name="test" type="tns:complex"/>
        </message>
        <message name="testResponse">
                <part name="test" type="tns:testSimpleType1"/>
        </message>
        <message name="testRequest2">
                <part name="test" type="tns:testSimpleType1"/>
        </message>
        <message name="testResponse2">
                <part name="test" type="tns:testSimpleType1"/>
        </message>
        <portType name="testPort">
                <operation name="test">
                        <documentation>
                                Test-Methode
                        </documentation>

                        <input message="tns:testRequest"/>
                        <output message="tns:testResponse"/>
                </operation>
                <operation name="test2">
                        <documentation>
                                Test-Methode
                        </documentation>

                        <input message="tns:testRequest2"/>
                        <output message="tns:testResponse2"/>
                </operation>
        </portType>
        <portType name="testPort2">
                <operation name="test">
                        <documentation>
                                Test-Methode
                        </documentation>

                        <input message="tns:testRequest"/>
                        <output message="tns:testResponse"/>
                </operation>
        </portType>
        <portType name="testPort3">
                <operation name="test">
                        <documentation>
                                Test-Methode
                        </documentation>
                        <input message="tns:testRequest"/>
                        <output message="tns:testResponse"/>
                </operation>
        </portType>

        <binding type="tns:testPort" name="testBinding">
        <operation name="test">
                <soap:binding style="document" transport="http://schemas.xmlsoap.org/soap/http"/>
                <soap:operation soapAction="test" />
                        <input>
                                <soap:body use="literal"/>
                        </input>
                        <output>
                                <soap:body use="literal"/>
                        </output>
				</operation>
        </binding>
        <binding type="tns:testPort2" name="testBinding2">
                <soap:binding style="document" transport="http://schemas.xmlsoap.org/soap/http"/>
        <operation name="test">
                <soap:operation soapAction="test"/>
                        <input>
                                <soap:body use="literal"/>
                        </input>
                        <output>
                                <soap:body use="literal"/>
                        </output>
                
        </operation>
        </binding>
        <binding type="tns:testPort3" name="testBinding3">
                <soap:binding style="document" transport="http://schemas.xmlsoap.org/soap/http"/>
        <operation name="test">
                <soap:operation soapAction="test"/>
                        <input>
                                <soap:body use="literal"/>
                        </input>
                        <output>
                                <soap:body use="literal"/>
                        </output>
                
        </operation>
        </binding>
        <service name="testService">
                <port name="testPort" binding="tns:testBinding">
                        <soap:address location="http://127.0.0.1/testPort" />
                </port>
                <port name="testPort2" binding="tns:testBinding2">
                        <soap:address location="http://127.0.0.1/testPort2" />
                </port>
        </service>
        <service name="testService2">
                <port name="testPort3" binding="tns:testBinding3">
                        <soap:address location="http://127.0.0.1/testPort3" />
                </port>

        </service>
</definitions>
};

}

