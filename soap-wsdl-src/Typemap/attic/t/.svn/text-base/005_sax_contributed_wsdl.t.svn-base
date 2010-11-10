#!/usr/bin/perl -w
use strict;
use warnings;
use Test::More ; #skip_all => 'not valid WSDL1.1 - maybe check 1.2'; # TODO: change to tests => N;
use lib '../lib';

if (eval "require XML::LibXML") {
     plan tests => 5;
}
else {
    plan skip_all => "Cannot test without XML::LibXML";
}

use_ok(qw/SOAP::WSDL::SAX::WSDLHandler/);

my $filter;

ok($filter = SOAP::WSDL::SAX::WSDLHandler->new(), "Object creation");

my $parser = XML::LibXML->new();
$parser->set_handler( $filter );

eval { $parser->parse_string( xml() ) };
if ($@)
{
	fail("parsing WSDL");
	die "Can't test without parsed WSDL: $@";
}
else
{
	pass("parsing XML");
}

my $wsdl;
ok( $wsdl = $filter->get_data() , "get object tree");

my $opt = {
	namespace => $wsdl->get_xmlns(),
	style => 'perl',
	wsdl => $wsdl,
	readable => 1,
};

my $txt;
ok( $txt = $wsdl->explain( $opt ) , "explain WSDL" );

# print $txt;

sub xml {
	return q{<?xml version="1.0" encoding="UTF-8"?>
<wsdl:definitions targetNamespace="http://example.com/soap/services/ETest/impl"
  xmlns="http://schemas.xmlsoap.org/wsdl/"
  xmlns:apachesoap="http://xml.apache.org/xml-soap"
  xmlns:impl="http://example.com/soap/services/ETest/impl"
  xmlns:intf="http://example.com/soap/services/ETest"
  xmlns:soapenc="http://schemas.xmlsoap.org/soap/encoding/"
  xmlns:tns1="urn:ETest"
  xmlns:tns2="urn:acquisition"
  xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/"
  xmlns:wsdlsoap="http://schemas.xmlsoap.org/wsdl/soap/"
  xmlns:xsd="http://www.w3.org/2001/XMLSchema">

  <wsdl:types>
    <schema targetNamespace="urn:ETest" xmlns="http://www.w3.org/2001/XMLSchema">
      <import namespace="http://schemas.xmlsoap.org/soap/encoding/" />
      <complexType name="CreationBaseData">
        <sequence>
          <element name="createdBy" nillable="true" type="xsd:long" />
          <element name="creationDate" nillable="true" type="xsd:dateTime" />
          <element name="updateDateCenter" nillable="true" type="xsd:dateTime" />
          <element name="updateDateLocal" nillable="true" type="xsd:dateTime" />
          <element name="updatedBy" nillable="true" type="xsd:long" />
        </sequence>
      </complexType>
      <complexType name="CreationData">
        <complexContent>
          <extension base="tns1:CreationBaseData">
            <sequence>
              <element name="creatorFullName" nillable="true" type="xsd:string" />
              <element name="modifierFullName" nillable="true" type="xsd:string" />
            </sequence>
          </extension>
        </complexContent>
      </complexType>
      <complexType abstract="true" name="EProductData">
        <sequence>
          <element name="EStatus" nillable="true" type="xsd:string" />
          <element name="EStatusUpdatedate" nillable="true" type="xsd:dateTime" />
          <element name="SFXID" nillable="true" type="xsd:string" />
          <element name="activationFromDate" nillable="true" type="xsd:dateTime" />
          <element name="activationToDate" nillable="true" type="xsd:dateTime" />
          <element name="activityStatusDateFrom" nillable="true" type="xsd:dateTime" />
          <element name="activityStatusDateTo" nillable="true" type="xsd:dateTime" />
          <element name="canEditSFXID" type="xsd:boolean" />
          <element name="concurrentNumberOfUsers" nillable="true" type="xsd:int" />
          <element name="creationData" nillable="true" type="tns1:CreationData" />
          <element name="deleteable" type="xsd:boolean" />
          <element name="ETestCode" nillable="true" type="xsd:string" />
          <element name="id" nillable="true" type="xsd:long" />
          <element name="instanceCode" nillable="true" type="xsd:string" />
          <element name="mainContact" nillable="true" type="xsd:string" />
          <element name="metaLibID" nillable="true" type="xsd:string" />
          <element name="otherID" nillable="true" type="xsd:string" />
          <element name="otherSource" nillable="true" type="xsd:string" />
          <element name="privateNote" nillable="true" type="xsd:string" />
          <element name="procurementStatus" nillable="true" type="xsd:string" />
          <element name="procurementStatusUpdateDate" nillable="true" type="xsd:dateTime" />
          <element name="procurementStatusUpdatedate" nillable="true" type="xsd:dateTime" />
          <element name="sourceInstanceCode" nillable="true" type="xsd:string" />
          <element name="sponseringLibraryCode" nillable="true" type="xsd:string" />
          <element name="sponseringLibraryName" nillable="true" type="xsd:string" />
          <element name="updateTarget" nillable="true" type="xsd:string" />
          <element name="workExpressionCode" nillable="true" type="xsd:string" />
        </sequence>
      </complexType>
      <complexType name="EProductInformation">
        <sequence>
          <element name="acquisitions" nillable="true"
            type="impl:ArrayOf_tns2_AcquisitionData" />
          <element name="data" nillable="true" type="tns1:EProductData" />
        </sequence>
      </complexType>
    </schema>
    <schema targetNamespace="urn:acquisition" xmlns="http://www.w3.org/2001/XMLSchema">
      <import namespace="http://schemas.xmlsoap.org/soap/encoding/" />
      <complexType name="AcquisitionCommonData">
        <sequence>
          <element name="budgets" nillable="true" type="xsd:string" />
          <element name="campusCode" nillable="true" type="xsd:string" />
          <element name="concurrentUsersNote" nillable="true" type="xsd:string" />
          <element name="creationData" nillable="true" type="tns1:CreationData" />
          <element name="id" nillable="true" type="xsd:long" />
          <element name="instituteCode" nillable="true" type="xsd:string" />
        </sequence>
      </complexType>
      <complexType name="AcquisitionData">
        <sequence>
          <element name="ILSSubscriptionNo" nillable="true" type="xsd:string" />
          <element name="acquisitionCode" nillable="true" type="xsd:string" />
          <element name="acquisitionCommonData" nillable="true"
            type="tns2:AcquisitionCommonData" />
          <element name="acquisitionMethod" nillable="true" type="xsd:string" />
          <element name="acquisitionNumber" nillable="true" type="xsd:string" />
          <element name="acquisitionStatus" nillable="true" type="xsd:string" />
          <element name="acquisitionStatusDate" nillable="true" type="xsd:dateTime" />
          <element name="advanceNoticeDate" nillable="true" type="xsd:dateTime" />
          <element name="autoRenewal" nillable="true" type="xsd:boolean" />
          <element name="consortialAgreement" type="xsd:boolean" />
          <element name="discountOnPrice" nillable="true" type="xsd:int" />
          <element name="id" nillable="true" type="xsd:long" />
          <element name="instanceCode" nillable="true" type="xsd:string" />
          <element name="materialType" nillable="true" type="xsd:string" />
          <element name="noteForILS" nillable="true" type="xsd:string" />
          <element name="noteForVendor" nillable="true" type="xsd:string" />
          <element name="noticePeriodCode" nillable="true" type="xsd:string" />
          <element name="numberOfCopies" nillable="true" type="xsd:int" />
          <element name="orderDate" nillable="true" type="xsd:dateTime" />
          <element name="orderForm" nillable="true" type="xsd:string" />
          <element name="orderSendMethod" nillable="true" type="xsd:string" />
          <element name="pooledConcurrentUsers" nillable="true" type="xsd:int" />
          <element name="price" nillable="true" type="xsd:double" />
          <element name="pricingCap" nillable="true" type="xsd:int" />
          <element name="pricingCapFrom" nillable="true" type="xsd:dateTime" />
          <element name="pricingCapTo" nillable="true" type="xsd:dateTime" />
          <element name="pricingModel" nillable="true" type="xsd:string" />
          <element name="printCancellationNote" nillable="true" type="xsd:string" />
          <element name="printCancellationRestriction" type="xsd:boolean" />
          <element name="printPurchaseOrderNo" nillable="true" type="xsd:string" />
          <element name="purchaseOrderNo" nillable="true" type="xsd:string" />
          <element name="renewallOrCancellationDate" nillable="true" type="xsd:dateTime" />
          <element name="renewallOrCancellationDescisionNote" nillable="true"
            type="xsd:string" />
          <element name="renewallOrCancellationNoteForILS" nillable="true"
            type="xsd:string" />
          <element name="renewallOrCancellationNoteForVendor" nillable="true"
            type="xsd:string" />
          <element name="subscriptionNotification" nillable="true" type="xsd:int" />
          <element name="subscriptionPeriodCode" nillable="true" type="xsd:string" />
          <element name="subscriptionType" nillable="true" type="xsd:string" />
          <element name="subscriptionTypeNote" nillable="true" type="xsd:string" />
          <element name="vendorAdvancedNotice" nillable="true" type="xsd:int" />
          <element name="vendorAdvancedNoticeVal" nillable="true" type="xsd:string" />
          <element name="vendorCode" nillable="true" type="xsd:string" />
          <element name="vendorName" nillable="true" type="xsd:string" />
          <element name="vendorSubscriptionCode" nillable="true" type="xsd:string" />
        </sequence>
      </complexType>
    </schema>
    <schema targetNamespace="http://example.com/soap/services/ETest/impl"
      xmlns="http://www.w3.org/2001/XMLSchema">
      <import namespace="http://schemas.xmlsoap.org/soap/encoding/" />
      <complexType name="ArrayOf_tns2_AcquisitionData">
        <complexContent>
          <restriction base="soapenc:Array">
            <attribute ref="soapenc:arrayType" wsdl:arrayType="tns2:AcquisitionData[]" />
          </restriction>
        </complexContent>
      </complexType>
    </schema>
  </wsdl:types>
  <wsdl:message name="getETestResponse">
    <wsdl:part name="getETestReturn" type="tns1:EProductInformation" />
  </wsdl:message>
  <wsdl:message name="getFixedETestResponse">
    <wsdl:part name="getFixedETestReturn" type="tns1:EProductInformation" />
  </wsdl:message>
  <wsdl:message name="getFixedETestRequest"></wsdl:message>
  <wsdl:message name="getETestRequest">
    <wsdl:part name="indexName" type="xsd:string" />
    <wsdl:part name="indexValue" type="xsd:string" />
    <wsdl:part name="withStatus" type="xsd:string" />
  </wsdl:message>
  <wsdl:portType name="ETestWeb">
    <wsdl:operation name="getETest" parameterOrder="indexName indexValue withStatus">
      <wsdl:input message="impl:getETestRequest" name="getETestRequest" />
      <wsdl:output message="impl:getETestResponse" name="getETestResponse" />
    </wsdl:operation>
    <wsdl:operation name="getFixedETest">
      <wsdl:input message="impl:getFixedETestRequest" name="getFixedETestRequest" />
      <wsdl:output message="impl:getFixedETestResponse"
        name="getFixedETestResponse" />
    </wsdl:operation>
  </wsdl:portType>

  <wsdl:binding name="ETestSoapBinding" type="impl:ETestWeb">
    <wsdlsoap:binding style="rpc" transport="http://schemas.xmlsoap.org/soap/http" />
    <wsdl:operation name="getETest">
      <wsdlsoap:operation soapAction="" />
      <wsdl:input name="getETestRequest">
        <wsdlsoap:body encodingStyle="http://schemas.xmlsoap.org/soap/encoding/"
          namespace="http://example.com/soap/services/ETest" use="encoded" />
      </wsdl:input>
      <wsdl:output name="getETestResponse">
        <wsdlsoap:body encodingStyle="http://schemas.xmlsoap.org/soap/encoding/"
          namespace="http://example.com/soap/services/ETest" use="encoded" />
      </wsdl:output>
    </wsdl:operation>
    <wsdl:operation name="getFixedETest">
      <wsdlsoap:operation soapAction="" />
      <wsdl:input name="getFixedETestRequest">
        <wsdlsoap:body encodingStyle="http://schemas.xmlsoap.org/soap/encoding/"
          namespace="http://example.com/soap/services/ETest" use="encoded" />
      </wsdl:input>
      <wsdl:output name="getFixedETestResponse">
        <wsdlsoap:body encodingStyle="http://schemas.xmlsoap.org/soap/encoding/"
          namespace="http://example.com/soap/services/ETest" use="encoded" />
      </wsdl:output>
    </wsdl:operation>
  </wsdl:binding>

  <wsdl:service name="ETestWebService">
    <wsdl:port binding="impl:ETestSoapBinding" name="ETest">
      <wsdlsoap:address location="http://example.com/soap/services/ETest" />
    </wsdl:port>
  </wsdl:service>
</wsdl:definitions>
};
}
