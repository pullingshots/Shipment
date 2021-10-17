package Shipment::CanadaPost::XSD;
use strict;
use warnings;

our $common = q`
    <xsd:element name="links">
        <xsd:complexType>
            <xsd:sequence>
                <xsd:element ref="link" maxOccurs="unbounded"/>
            </xsd:sequence>
        </xsd:complexType>
    </xsd:element>

    <xsd:complexType name="LinkType">
        <xsd:attribute name="href" type="xsd:anyURI" use="required"/>
        <xsd:attribute name="rel" type="RelType" use="required"/>
        <xsd:attribute name="index" type="xsd:nonNegativeInteger" use="optional"/>
        <xsd:attribute name="media-type" type="xsd:normalizedString" use="required"/>
    </xsd:complexType>

    <xsd:element name="link" type="LinkType"/>
    <xsd:simpleType name="RelType">
        <xsd:restriction base="xsd:string">

        </xsd:restriction>
    </xsd:simpleType>

    <xsd:complexType name="CcDetailsType">
        <xsd:all>
            <xsd:element name="cc-type" type="CcType" />
            <xsd:element name="cc-number" type="CcNumberType" />
            <xsd:element name="cc-name" type="CcNameType" />
            <xsd:element name="cc-expiry" type="CcExpiryType" />
            <xsd:element name="cc-cvv" type="CcCvvType" minOccurs="0" />
            <xsd:element name="cc-address-details" type="CcAddressDetailsType" minOccurs="0"/>
        </xsd:all>
    </xsd:complexType>

    <xsd:simpleType name="CcType">
        <xsd:restriction base="xsd:normalizedString">
            <xsd:enumeration value="MC"/>
            <xsd:enumeration value="VIS"/>
            <xsd:enumeration value="AME"/>
            <xsd:enumeration value="DC"/>
            <xsd:enumeration value="DIS"/>
            <xsd:enumeration value="ER"/>
        </xsd:restriction>
    </xsd:simpleType>

    <xsd:simpleType name="CcNumberType">
        <xsd:restriction base="xsd:normalizedString">
            <xsd:pattern value="\d{1,25}" />
        </xsd:restriction>
    </xsd:simpleType>

    <xsd:simpleType name="CcMaskedNumberType">
        <xsd:restriction base="xsd:normalizedString">
            <xsd:minLength value="1" />
            <xsd:maxLength value="25" />
        </xsd:restriction>
    </xsd:simpleType>

    <xsd:simpleType name="CcNameType">
        <xsd:restriction base="xsd:normalizedString">
            <xsd:minLength value="1"/>
            <xsd:maxLength value="40" />
        </xsd:restriction>
    </xsd:simpleType>

    <xsd:simpleType name="CcExpiryType">
        <xsd:restriction base="xsd:normalizedString">
            <xsd:pattern value="\d{2}/\d{2}" />
        </xsd:restriction>
    </xsd:simpleType>

    <xsd:simpleType name="CcCvvType">
        <xsd:restriction base="xsd:normalizedString">
            <xsd:minLength value="1"/>
            <xsd:maxLength value="6" />
        </xsd:restriction>
    </xsd:simpleType>

    <xsd:simpleType name="CcAuthorizationCodeType">
        <xsd:restriction base="xsd:normalizedString">
            <xsd:minLength value="1"/>
            <xsd:maxLength value="10" />
        </xsd:restriction>
    </xsd:simpleType>

    <xsd:simpleType name="CcAuthorizationAmountType">
        <xsd:restriction base="xsd:decimal">
        </xsd:restriction>
    </xsd:simpleType>

    <xsd:simpleType name="CurrencyType">
        <xsd:restriction base="xsd:normalizedString">
            <xsd:minLength value="1"/>
            <xsd:maxLength value="3"/>
        </xsd:restriction>
    </xsd:simpleType>

    <xsd:complexType name="CcAddressDetailsType">
        <xsd:all>
            <xsd:element name="address-line-1">
                <xsd:simpleType>
                    <xsd:restriction base="xsd:normalizedString">
                        <xsd:minLength value="1"/>
                        <xsd:maxLength value="44" />
                    </xsd:restriction>
                </xsd:simpleType>
            </xsd:element>
            <xsd:element name="address-line-2" minOccurs="0">
                <xsd:simpleType>
                    <xsd:restriction base="xsd:normalizedString">
                        <xsd:maxLength value="44" />
                    </xsd:restriction>
                </xsd:simpleType>
            </xsd:element>
            <xsd:element name="city">
                <xsd:simpleType>
                    <xsd:restriction base="xsd:normalizedString">
                        <xsd:minLength value="1"/>
                        <xsd:maxLength value="40" />
                    </xsd:restriction>
                </xsd:simpleType>
            </xsd:element>
            <xsd:element name="prov-state" type="ProvinceStateOrInternationalType" />
            <xsd:element name="postal-zip-code" type="PostalCodeOrZipOrInternationalType" minOccurs="0" />
            <xsd:element name="country-code" type="CountryCodeType" />
        </xsd:all>
    </xsd:complexType>

    <xsd:simpleType name="ThirdPartyAccountIdType">
        <xsd:restriction base="xsd:normalizedString">
            <xsd:minLength value="1"/>
            <xsd:maxLength value="16" />
        </xsd:restriction>
    </xsd:simpleType>

    <xsd:simpleType name="ThirdPartyAccountCodeType">
        <xsd:restriction base="xsd:normalizedString">
            <xsd:enumeration value="PB"/>
            <xsd:enumeration value="FP"/>
            <xsd:enumeration value="NE"/>
        </xsd:restriction>
    </xsd:simpleType>

    <xsd:simpleType name="AuthorizationCodeType">
        <xsd:restriction base="xsd:normalizedString">
            <xsd:minLength value="1"/>
            <xsd:maxLength value="16" />
        </xsd:restriction>
    </xsd:simpleType>

    <xsd:simpleType name="AuthorizationAmountType">
        <xsd:restriction base="xsd:decimal">
        </xsd:restriction>
    </xsd:simpleType>

    <xsd:simpleType name="ProvinceStateOrInternationalType">
        <xsd:restriction base="xsd:normalizedString">
            <xsd:minLength value="1"/>
            <xsd:maxLength value="20"/>
        </xsd:restriction>
    </xsd:simpleType>

  
    
    <xsd:simpleType name="PostalCodeOrZipType">
        <xsd:restriction base="xsd:string">
            <xsd:pattern value="([A-Z]\d[A-Z]\d[A-Z]\d)|(\d{5}(-\d{4})?)"/>
        </xsd:restriction>
    </xsd:simpleType>

    <xsd:simpleType name="PostalCodeOrZipOrInternationalType">
        <xsd:restriction base="xsd:normalizedString">
            <xsd:minLength value="1"/>
            <xsd:maxLength value="14"/>
        </xsd:restriction>
    </xsd:simpleType>

    <xsd:simpleType name="PostalCodeType">
        <xsd:restriction base="xsd:string">
            <xsd:pattern value="[A-Z]\d[A-Z]\d[A-Z]\d"/>
        </xsd:restriction>
    </xsd:simpleType>

    <xsd:simpleType name="ZipCodeType">
        <xsd:restriction base="xsd:string">
            <xsd:pattern value="\d{5}(-\d{4})?"/>
        </xsd:restriction>
    </xsd:simpleType>

    <xsd:simpleType name="CountryCodeType">
        <xsd:restriction base="xsd:string">
             <xsd:pattern value="[a-zA-Z][a-zA-Z]"/>
        </xsd:restriction>
    </xsd:simpleType>

    <xsd:simpleType name="StateType">
        <xsd:restriction base="xsd:normalizedString">
            <xsd:minLength value="1"/>
            <xsd:maxLength value="2"/>
        </xsd:restriction>
    </xsd:simpleType>

    <xsd:simpleType name="ProvinceType">
        <xsd:restriction base="xsd:normalizedString">
            <xsd:minLength value="1"/>
            <xsd:maxLength value="2"/>
        </xsd:restriction>
    </xsd:simpleType>

    <xsd:simpleType name="PhoneNumberType">
        <xsd:restriction base="xsd:normalizedString">
            <xsd:maxLength value="25"/>
        </xsd:restriction>
    </xsd:simpleType>

    <xsd:simpleType name="CustomerIDType">
        <xsd:restriction base="xsd:string">
            <xsd:pattern value="\d{1,10}" />
        </xsd:restriction>
    </xsd:simpleType>

    <xsd:simpleType name="ContractIDType">
        <xsd:restriction base="xsd:string">
            <xsd:pattern value="\d{1,10}" />
        </xsd:restriction>
    </xsd:simpleType>

    <xsd:simpleType name="MethodOfPaymentType">
        <xsd:restriction base="xsd:normalizedString">
            <xsd:maxLength value="15" />
        </xsd:restriction>
    </xsd:simpleType>

    <xsd:simpleType name="PoNumberType">
        <xsd:restriction base="xsd:string">
            <xsd:pattern value="[a-zA-Z0-9]{1,10}" />
        </xsd:restriction>
    </xsd:simpleType>

    <xsd:simpleType name="OutletIDType">
        <xsd:restriction base="xsd:normalizedString">
            <xsd:maxLength value="4" />
        </xsd:restriction>
    </xsd:simpleType>

    <xsd:simpleType name="CostTypeNonZero">
        <xsd:restriction base="xsd:decimal">
            <xsd:minExclusive value="0" />
            <xsd:maxInclusive value="999999.99" />
            <xsd:fractionDigits value="2" />
        </xsd:restriction>
    </xsd:simpleType>

    <xsd:simpleType name="CostTypeAllowsZero">
        <xsd:restriction base="xsd:decimal">
            <xsd:minInclusive value="0" />
            <xsd:maxInclusive value="999999.99" />
            <xsd:fractionDigits value="2" />
        </xsd:restriction>
    </xsd:simpleType>
    
     <xsd:simpleType name="CostTypeAllowsNegative">
        <xsd:restriction base="xsd:decimal">
            <xsd:minInclusive value="-999999.99" />
            <xsd:maxInclusive value="999999.99" />
            <xsd:fractionDigits value="2" />
        </xsd:restriction>
    </xsd:simpleType>

    <xsd:simpleType name="ServiceCodeType">
        <xsd:restriction base="xsd:normalizedString">
            <xsd:minLength value="1"/>
            <xsd:maxLength value="32"/>
        </xsd:restriction>
    </xsd:simpleType>

    <xsd:simpleType name="Time24HoursType">
        <xsd:restriction base="xsd:normalizedString">
            <xsd:pattern value="((0?\d)|(1\d)|(2[0-3])):[0-5]\d" />
        </xsd:restriction>
    </xsd:simpleType>

    
     <xsd:simpleType name="DimensionMeasurementType">
        <xsd:restriction base="xsd:decimal">
            <xsd:minExclusive value="0"/>
            <xsd:maxInclusive value="999.9"/>
            <xsd:fractionDigits value="1"/>
        </xsd:restriction>
    </xsd:simpleType>

    <xsd:simpleType name="WeightType">
       <xsd:restriction base="xsd:decimal">
         <xsd:minExclusive value="0"/>
         <xsd:maxInclusive value="99.999"/>
         <xsd:fractionDigits value="3"/>
         </xsd:restriction>
     </xsd:simpleType>

    <xsd:simpleType name="MeterNumberType">
        <xsd:restriction base="xsd:string">
            <xsd:pattern value="[0-9]{7}" />
        </xsd:restriction>
    </xsd:simpleType>
    
    <xsd:simpleType name="CustomsUnitOfMeasure">
		<xsd:restriction base="xsd:normalizedString">
			<xsd:length value="3" />
		</xsd:restriction>
	</xsd:simpleType>
</xsd:schema>
`;

our $messages = q`
<xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema" targetNamespace="http://www.canadapost.ca/ws/messages"
            xmlns="http://www.canadapost.ca/ws/messages"
            elementFormDefault="qualified">
    <xsd:element name="messages">
        <xsd:complexType>
            <xsd:sequence>
                <xsd:element name="message" minOccurs="0" maxOccurs="unbounded">
                    <xsd:complexType>
                        <xsd:all>
                            <xsd:element name="code" type="xsd:normalizedString"/>
                            <xsd:element name="description" type="xsd:normalizedString"/>
                        </xsd:all>
                    </xsd:complexType>
                </xsd:element>
            </xsd:sequence>
        </xsd:complexType>
    </xsd:element>
</xsd:schema>
`;

our $discovery = q`
<xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema" targetNamespace="http://www.canadapost.ca/ws/ship/rate-v4"
            xmlns="http://www.canadapost.ca/ws/ship/rate-v4" elementFormDefault="qualified">

    <xsd:redefine schemaLocation="common.xsd">
        <xsd:simpleType name="RelType">
            <xsd:restriction base="RelType">
                <xsd:enumeration value="service"/>
                <xsd:enumeration value="option"/>
            </xsd:restriction>
        </xsd:simpleType>
    </xsd:redefine>

    <xsd:element name="services">
        <xsd:complexType>
            <xsd:sequence>
                <xsd:element name="service" minOccurs="0" maxOccurs="unbounded">
                    <xsd:complexType>
                        <xsd:all>
                            <xsd:element name="service-code" type="ServiceCodeType"/>
                            <xsd:element name="service-name" type="xsd:normalizedString"/>
                            <xsd:element name="link" type="LinkType"/>
                        </xsd:all>
                    </xsd:complexType>
                </xsd:element>
            </xsd:sequence>
        </xsd:complexType>
    </xsd:element>

    <xsd:element name="option">
        <xsd:complexType>
            <xsd:all>
                <xsd:element name="option-code" type="xsd:normalizedString"/>
                <xsd:element name="option-name" type="xsd:normalizedString"/>
                <xsd:element name="option-class" type="xsd:normalizedString"/>
                <xsd:element name="prints-on-label" type="xsd:boolean"/>
                <xsd:element name="qualifier-required" type="xsd:boolean"/>
                <xsd:element name="conflicting-options" minOccurs="0">
                    <xsd:complexType>
                        <xsd:sequence>
                            <xsd:element name="option-code" type="xsd:normalizedString" maxOccurs="unbounded"/>
                        </xsd:sequence>
                    </xsd:complexType>
                </xsd:element>
                <xsd:element name="prerequisite-options" minOccurs="0">
                    <xsd:complexType>
                        <xsd:sequence>
                            <xsd:element name="option-code" type="xsd:normalizedString" maxOccurs="unbounded"/>
                        </xsd:sequence>
                    </xsd:complexType>
                </xsd:element>
            </xsd:all>
        </xsd:complexType>
    </xsd:element>

    <xsd:element name="service">
        <xsd:complexType>
            <xsd:all>
                <xsd:element name="service-code" type="ServiceCodeType"/>
                <xsd:element name="service-name" type="xsd:normalizedString"/>
                <xsd:element name="comment" type="xsd:normalizedString" minOccurs="0"/>
                <xsd:element name="options" minOccurs="0">
                    <xsd:complexType>
                        <xsd:sequence>
                            <xsd:element name="option" maxOccurs="unbounded">
                                <xsd:complexType>
                                    <xsd:all>
                                        <xsd:element name="option-code" type="xsd:normalizedString"/>
                                        <xsd:element name="option-name" type="xsd:normalizedString"/>
                                        <xsd:element name="link" type="LinkType"/>
                                        <xsd:element name="mandatory" type="xsd:boolean"/>
                                        <xsd:element name="qualifier-required" type="xsd:boolean"/>
                                        <xsd:element name="qualifier-max" type="xsd:decimal" minOccurs="0"/>
                                    </xsd:all>
                                </xsd:complexType>
                            </xsd:element>
                        </xsd:sequence>
                    </xsd:complexType>
                </xsd:element>
                <xsd:element name="restrictions">
                    <xsd:complexType>
                        <xsd:all>
                            <xsd:element name="weight-restriction" type="NumberRangeType"/>
                            <xsd:element name="dimensional-restrictions">
                                <xsd:complexType>
                                    <xsd:all>
                                        <xsd:element name="length" type="NumberRangeType"/>
                                        <xsd:element name="width" type="NumberRangeType"/>
                                        <xsd:element name="height" type="NumberRangeType"/>
                                        <xsd:element name="length-plus-girth-max" type="xsd:decimal" minOccurs="0"/>
                                        <xsd:element name="length-height-width-sum-max" type="xsd:decimal" minOccurs="0"/>
                                        <xsd:element name="oversize-limit" type="xsd:decimal" minOccurs="0"/>
                                    </xsd:all>
                                </xsd:complexType>
                            </xsd:element>
                            <xsd:element name="density-factor" type="xsd:decimal" minOccurs="0"/>
                            <xsd:element name="can-ship-in-mailing-tube" type="xsd:boolean"/>
                            <xsd:element name="can-ship-unpackaged" type="xsd:boolean"/>
                            <xsd:element name="allowed-as-return-service" type="xsd:boolean"/>
                        </xsd:all>
                    </xsd:complexType>
                </xsd:element>
            </xsd:all>
        </xsd:complexType>
    </xsd:element>

    <xsd:element name="options">
        <xsd:complexType>
            <xsd:sequence>
                <xsd:element name="option" minOccurs="0" maxOccurs="unbounded">
                    <xsd:complexType>
                        <xsd:all>
                            <xsd:element name="option-code" type="xsd:token"/>
                            <xsd:element name="option-name" type="xsd:token"/>
                            <xsd:element name="link" type="LinkType"/>
                            <xsd:element name="qualifier-required" type="xsd:boolean"/>
                        </xsd:all>
                    </xsd:complexType>
                </xsd:element>
            </xsd:sequence>
        </xsd:complexType>
    </xsd:element>

    <xsd:complexType name="NumberRangeType">
        <xsd:attribute name="min" type="xsd:decimal"/>
        <xsd:attribute name="max" type="xsd:decimal"/>
    </xsd:complexType>
`;

our $rating = q`
<xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema" targetNamespace="http://www.canadapost.ca/ws/ship/rate-v4"
            xmlns="http://www.canadapost.ca/ws/ship/rate-v4" elementFormDefault="qualified">
    <xsd:include schemaLocation="common.xsd"/>

    <xsd:element name="mailing-scenario">
        <xsd:complexType>
            <xsd:all>
                <xsd:element name="customer-number" type="CustomerIDType" minOccurs="0"/>
                <xsd:element name="contract-id" type="ContractIDType" minOccurs="0"/>
                <xsd:element name="promo-code" type="PromoCodeType" minOccurs="0"/>
                <xsd:element name="quote-type" minOccurs="0">
                    <xsd:simpleType>
                        <xsd:restriction base="xsd:string">
                            <xsd:enumeration value="commercial"/>
                            <xsd:enumeration value="counter"/>
                        </xsd:restriction>
                    </xsd:simpleType>
                </xsd:element>
                <xsd:element name="expected-mailing-date" type="xsd:date" minOccurs="0"/>
                <xsd:element name="options" minOccurs="0">
                    <xsd:complexType>
                        <xsd:sequence>
                            <xsd:element name="option" maxOccurs="20">
                                <xsd:complexType>
                                    <xsd:all>
                                        <xsd:element name="option-code">
                                            <xsd:simpleType>
                                                <xsd:restriction base="xsd:normalizedString">
                                                    <xsd:minLength value="1"/>
                                                    <xsd:maxLength value="10"/>
                                                </xsd:restriction>
                                            </xsd:simpleType>
                                        </xsd:element>
                                        <xsd:element name="option-amount" type="CostTypeNonZero" minOccurs="0"/>
                                    </xsd:all>
                                </xsd:complexType>
                            </xsd:element>
                        </xsd:sequence>
                    </xsd:complexType>
                </xsd:element>
                <xsd:element name="parcel-characteristics">
                    <xsd:complexType>
                        <xsd:all>
                            <xsd:element name="weight">
                                <xsd:simpleType>
                                    <xsd:restriction base="xsd:decimal">
                                        <xsd:minExclusive value="0"/>
                                        <xsd:maxInclusive value="99.999"/>
                                        <xsd:fractionDigits value="3"/>
                                    </xsd:restriction>
                                </xsd:simpleType>
                            </xsd:element>
                            <xsd:element name="dimensions" minOccurs="0">
                                <xsd:complexType>
                                    <xsd:all>
                                        <xsd:element name="length" type="DimensionMeasurementType"/>
                                        <xsd:element name="width" type="DimensionMeasurementType"/>
                                        <xsd:element name="height" type="DimensionMeasurementType"/>
                                    </xsd:all>
                                </xsd:complexType>
                            </xsd:element>
                            <xsd:element name="unpackaged" type="xsd:boolean" minOccurs="0"/>
                            <xsd:element name="mailing-tube" type="xsd:boolean" minOccurs="0"/>
                            <xsd:element name="oversized" type="xsd:boolean" minOccurs="0"/>
                        </xsd:all>
                    </xsd:complexType>
                </xsd:element>
                <xsd:element name="services" minOccurs="0">
                    <xsd:complexType>
                        <xsd:sequence>
                            <xsd:element name="service-code" type="ServiceCodeType" maxOccurs="20"/>
                        </xsd:sequence>
                    </xsd:complexType>
                </xsd:element>
                <xsd:element name="origin-postal-code" type="PostalCodeType"/>
                <xsd:element name="destination">
                    <xsd:complexType>
                        <xsd:choice>
                            <xsd:element name="domestic">
                                <xsd:complexType>
                                    <xsd:all>
                                        <xsd:element name="postal-code" type="PostalCodeType"/>
                                    </xsd:all>
                                </xsd:complexType>
                            </xsd:element>
                            <xsd:element name="united-states">
                                <xsd:complexType>
                                    <xsd:all>
                                        <xsd:element name="zip-code" type="ZipCodeType"/>
                                    </xsd:all>
                                </xsd:complexType>
                            </xsd:element>
                            <xsd:element name="international">
                                <xsd:complexType>
                                    <xsd:all>
                                        <xsd:element name="country-code" type="CountryCodeType"/>
                                        <xsd:element name="postal-code" type="IntlPostalCodeType" minOccurs="0"/>
                                    </xsd:all>
                                </xsd:complexType>
                            </xsd:element>
                        </xsd:choice>
                    </xsd:complexType>
                </xsd:element>
            </xsd:all>
        </xsd:complexType>
    </xsd:element>

    <xsd:element name="price-quotes">
        <xsd:complexType>
            <xsd:sequence>
                <xsd:element name="price-quote" minOccurs="0" maxOccurs="unbounded">
                    <xsd:complexType>
                        <xsd:all>
                            <xsd:element name="service-code" type="ServiceCodeType"/>
                            <xsd:element name="service-link" type="LinkType"/>
                            <xsd:element name="service-name" type="xsd:normalizedString"/>
                            <xsd:element name="price-details">
                                <xsd:complexType>
                                    <xsd:all>
                                        <xsd:element name="base" type="xsd:decimal"/>
                                        <xsd:element name="taxes" minOccurs="0">
                                            <xsd:complexType>
                                                <xsd:all>
                                                    <xsd:element name="gst" type="TaxType" minOccurs="0"/>
                                                    <xsd:element name="pst" type="TaxType" minOccurs="0"/>
                                                    <xsd:element name="hst" type="TaxType" minOccurs="0"/>
                                                </xsd:all>
                                            </xsd:complexType>
                                        </xsd:element>
                                        <xsd:element name="due" type="xsd:decimal"/>
                                        <xsd:element name="options" minOccurs="0">
                                            <xsd:complexType>
                                                <xsd:sequence>
                                                    <xsd:element name="option" maxOccurs="20">
                                                        <xsd:complexType>
                                                            <xsd:all>
                                                                <xsd:element name="option-code" type="xsd:normalizedString"/>
                                                                <xsd:element name="option-name" type="xsd:normalizedString"/>
                                                                <xsd:element name="option-price" type="xsd:decimal"/>
                                                                <xsd:element name="qualifier" minOccurs="0">
                                                                    <xsd:complexType>
                                                                        <xsd:all>
                                                                            <xsd:element name="step-size" type="xsd:decimal" minOccurs="0"/>
                                                                            <xsd:element name="step-cost" type="xsd:decimal" minOccurs="0"/>
                                                                            <xsd:element name="included-amount" type="xsd:decimal" minOccurs="0"/>
                                                                            <xsd:element name="max-value" type="xsd:decimal" minOccurs="0"/>
                                                                            <xsd:element name="included" type="xsd:boolean" minOccurs="0"/>
                                                                            <xsd:element name="percent" type="xsd:decimal" minOccurs="0"/>
                                                                        </xsd:all>
                                                                    </xsd:complexType>
                                                                </xsd:element>
                                                            </xsd:all>
                                                        </xsd:complexType>
                                                    </xsd:element>
                                                </xsd:sequence>
                                            </xsd:complexType>
                                        </xsd:element>
                                        <xsd:element name="adjustments" minOccurs="0">
                                            <xsd:complexType>
                                                <xsd:sequence>
                                                    <xsd:element name="adjustment" maxOccurs="20">
                                                        <xsd:complexType>
                                                            <xsd:all>
                                                                <xsd:element name="adjustment-code" type="xsd:normalizedString"/>
                                                                <xsd:element name="adjustment-name" type="xsd:normalizedString"/>
                                                                <xsd:element name="adjustment-cost" type="xsd:decimal"/>
                                                                <xsd:element name="qualifier" minOccurs="0">
                                                                    <xsd:complexType>
                                                                        <xsd:all>
                                                                            <xsd:element name="percent" type="xsd:decimal"/>
                                                                        </xsd:all>
                                                                    </xsd:complexType>
                                                                </xsd:element>
                                                            </xsd:all>
                                                        </xsd:complexType>
                                                    </xsd:element>
                                                </xsd:sequence>
                                            </xsd:complexType>
                                        </xsd:element>
                                    </xsd:all>
                                </xsd:complexType>
                            </xsd:element>
                            <xsd:element name="weight-details">
                                <xsd:complexType>
                                    <xsd:all>
                                        <xsd:element name="cubed-weight" type="xsd:decimal" minOccurs="0"/>
                                    </xsd:all>
                                </xsd:complexType>
                            </xsd:element>
                            <xsd:element name="service-standard">
                                <xsd:complexType>
                                    <xsd:all>
                                        <xsd:element name="am-delivery" type="xsd:boolean"/>
                                        <xsd:element name="guaranteed-delivery" type="xsd:boolean"/>
                                        <xsd:element name="expected-transit-time" minOccurs="0">
                                            <xsd:simpleType>
                                                <xsd:restriction base="xsd:integer">
                                                    <xsd:minInclusive value="0" />
                                                    <xsd:maxInclusive value="99" />
                                                </xsd:restriction>
                                            </xsd:simpleType>
                                        </xsd:element>
                                        <xsd:element name="expected-delivery-date" type="xsd:date" minOccurs="0"/>
                                    </xsd:all>
                                </xsd:complexType>
                            </xsd:element>
                        </xsd:all>
                    </xsd:complexType>
                </xsd:element>
            </xsd:sequence>
        </xsd:complexType>
    </xsd:element>

    <xsd:complexType name="TaxType">
        <xsd:simpleContent>
            <xsd:extension base="xsd:decimal">
                <xsd:attribute name="percent" type="xsd:decimal" use="optional"/>
            </xsd:extension>
        </xsd:simpleContent>
    </xsd:complexType>

    <xsd:simpleType name="PromoCodeType">
        <xsd:restriction base="xsd:normalizedString">
            <xsd:minLength value="1" />
            <xsd:maxLength value="10" />
        </xsd:restriction>
    </xsd:simpleType>
    <xsd:simpleType name="IntlPostalCodeType">
        <xsd:restriction base="xsd:normalizedString">
            <xsd:minLength value="1" />
            <xsd:maxLength value="10" />
        </xsd:restriction>
    </xsd:simpleType>
`;


our $shipment = q`
<xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema" targetNamespace="http://www.canadapost.ca/ws/shipment-v8" xmlns="http://www.canadapost.ca/ws/shipment-v8" elementFormDefault="qualified">
    <xsd:annotation>
        <xsd:documentation>
            - Added customer-request-id to Create Shipment, to be used by Get Shipments.
            - Added promo-code to Create Shipment.
            - Added provide-pricing-info and provide-receipt-info flags to Create Shipment.
            - Added pre-authorized-payment to Create Shipment.
            - Get Shipment Receipt returns credit card receipt details or supplier account receipt details.
            - Modified Get Shipments:
                - added provideShipmentInfo url parameter in request to get a structured list similiar to Get Shipment.
                - added customer-request-id in request that matches the change to the create request.
        </xsd:documentation>
    </xsd:annotation>
	
	<xsd:include schemaLocation="common.xsd"/>
	<!--<xsd:redefine schemaLocation="common.xsd">
        <xsd:simpleType name="RelType">
            <xsd:restriction base="RelType">
                <xsd:enumeration value="self"/>
                <xsd:enumeration value="details"/>
                <xsd:enumeration value="group"/>
                <xsd:enumeration value="shipment"/>
                <xsd:enumeration value="price"/>
                <xsd:enumeration value="label"/>
                <xsd:enumeration value="returnLabel"/>
                <xsd:enumeration value="commercialInvoice"/>
                <xsd:enumeration value="receipt"/>
                <xsd:enumeration value="refund"/>
            </xsd:restriction>
        </xsd:simpleType>
    </xsd:redefine>-->


    <xsd:element name="shipment" type="ShipmentType"/>

    <xsd:element name="shipment-info" type="ShipmentInfoType"/>

    <xsd:element name="shipment-details" type="ShipmentDetailsType"/>

    <xsd:element name="shipments" type="ShipmentsType" />

    <xsd:element name="shipment-price" type="ShipmentPriceType" />

    <xsd:element name="shipment-cc-receipt" type="ShipmentCCReceiptType" />

    <xsd:element name="shipment-receipt" type="ShipmentReceiptType" />

    <xsd:element name="shipment-refund-request" type="ShipmentRefundRequestType" />

    <xsd:element name="shipment-refund-request-info" type="ShipmentRefundRequestInfoType" />

    <xsd:element name="groups" type="GroupsType" />

    <xsd:complexType name="GroupsType">
        <xsd:sequence>
            <xsd:element name="group" type="GroupType" minOccurs="0" maxOccurs="unbounded"/>
        </xsd:sequence>
    </xsd:complexType>

    <xsd:complexType name="GroupType">
        <xsd:all>
            <xsd:element name="group-id" type="GroupIDType"/>
            <xsd:element ref="link" />
        </xsd:all>
    </xsd:complexType>


    <xsd:complexType name="ShipmentPriceType">
        <xsd:all>
            <xsd:element name="service-code" type="ServiceCodeType"/>
            <xsd:element name="base-amount" type="CostTypeNonZero"/>
            <xsd:element name="priced-options" type="PricedOptionsType" minOccurs="0"/>
            <xsd:element name="adjustments" type="AdjustmentsType" minOccurs="0"/>
            <xsd:element name="pre-tax-amount" type="CostTypeAllowsZero"/>
            <xsd:element name="gst-amount" type="CostTypeAllowsZero"/>
            <xsd:element name="pst-amount" type="CostTypeAllowsZero"/>
            <xsd:element name="hst-amount" type="CostTypeAllowsZero"/>
            <xsd:element name="due-amount" type="CostTypeAllowsZero"/>
            <xsd:element name="service-standard" type="ServiceStandardType"/>
            <xsd:element name="rated-weight">
                <xsd:simpleType>
                    <xsd:restriction base="xsd:decimal">
                        <xsd:minExclusive value="0"/>
                        <xsd:maxInclusive value="999.999"/>
                        <xsd:fractionDigits value="3"/>
                    </xsd:restriction>
                </xsd:simpleType>
            </xsd:element>
        </xsd:all>
    </xsd:complexType>

    <xsd:complexType name="ServiceStandardType">
        <xsd:all>
            <xsd:element name="am-delivery" type="xsd:boolean"/>
            <xsd:element name="guaranteed-delivery" type="xsd:boolean"/>
            <xsd:element name="expected-transmit-time" minOccurs="0">
                <xsd:simpleType>
                    <xsd:restriction base="xsd:integer">
                        <xsd:minInclusive value="0"/>
                        <xsd:maxInclusive value="99"/>
                    </xsd:restriction>
                </xsd:simpleType>
            </xsd:element>
            <xsd:element name="expected-delivery-date" type="xsd:date" minOccurs="0"/>
        </xsd:all>
    </xsd:complexType>

    <xsd:complexType name="PricedOptionsType">
        <xsd:sequence>
            <xsd:element name="priced-option" type="PricedOptionType" minOccurs="0" maxOccurs="unbounded"/>
        </xsd:sequence>
    </xsd:complexType>

    <xsd:complexType name="PricedOptionType">
        <xsd:all>
            <xsd:element name="option-code" type="xsd:normalizedString"/>
            <xsd:element name="option-price" minOccurs="0" type="CostTypeAllowsNegative" />
        </xsd:all>
    </xsd:complexType>

    <xsd:complexType name="AdjustmentsType">
        <xsd:sequence>
            <xsd:element name="adjustment" type="AdjustmentType" minOccurs="0" maxOccurs="unbounded"/>
        </xsd:sequence>
    </xsd:complexType>

    <xsd:complexType name="AdjustmentType">
        <xsd:all>
            <xsd:element name="adjustment-code" type="xsd:normalizedString"/>
            <xsd:element name="adjustment-amount" type="CostTypeAllowsNegative"/>
        </xsd:all>
    </xsd:complexType>

    <xsd:complexType name="ShipmentsType">
        <xsd:sequence>
            <xsd:choice>
                <xsd:element ref="link" minOccurs="0" maxOccurs="unbounded"/>
                <xsd:element name="shipment-info" type="ShipmentInfoType" minOccurs="0" maxOccurs="unbounded"/>
            </xsd:choice>
        </xsd:sequence>
    </xsd:complexType>

    <xsd:complexType name="ShipmentInfoType">
        <xsd:all>
            <xsd:element name="customer-request-id" type="CustomerRequestIdType" minOccurs="0" />
            <xsd:element name="shipment-id" type="ShipmentIDType"/>
            <xsd:element name="shipment-status" type="ShipmentStatusType"/>
            <xsd:element name="tracking-pin" type="TrackingPINType" minOccurs="0"/>
            <xsd:element name="return-tracking-pin" type="TrackingPINType" minOccurs="0"/>
            <xsd:element name="po-number" type="PoNumberType" minOccurs="0"/>
            <xsd:element name="shipment-price" type="ShipmentPriceType" minOccurs="0"/>
            <xsd:element name="shipment-receipt" type="ShipmentReceiptType" minOccurs="0"/>
            <xsd:element ref="links"/>
        </xsd:all>
    </xsd:complexType>

    <!-- group-id and transmit-shipment are mutually exclusive -->
    <xsd:element name="groupIdOrTransmitShipment" abstract="true" />
    <xsd:element name="group-id" type="GroupIDType" substitutionGroup="groupIdOrTransmitShipment"/>
    <xsd:element name="transmit-shipment" type="xsd:boolean" fixed="true" substitutionGroup="groupIdOrTransmitShipment"/>

    <xsd:complexType name="ShipmentType">
        <xsd:all>
            <xsd:element name="customer-request-id" type="CustomerRequestIdType" minOccurs="0" />
            <xsd:element ref="groupIdOrTransmitShipment" />
            <xsd:element name="quickship-label-requested" type="xsd:boolean" minOccurs="0"/>
            <xsd:element name="cpc-pickup-indicator" type="xsd:boolean" fixed="true" minOccurs="0"/>
            <xsd:element name="requested-shipping-point" type="PostalCodeType" minOccurs="0"/>
            <xsd:element name="shipping-point-id" type="OutletIDType" minOccurs="0" />
            <xsd:element name="expected-mailing-date" type="xsd:date" minOccurs="0"/>
            <xsd:element name="provide-pricing-info" type="xsd:boolean" fixed="true" minOccurs="0"/>
            <xsd:element name="provide-receipt-info" type="xsd:boolean" fixed="true" minOccurs="0"/>
            <xsd:element name="delivery-spec" type="DeliverySpecType"/>
            <xsd:element name="return-spec" type="ReturnSpecType" minOccurs="0"/>
            <xsd:element name="pre-authorized-payment" type="PreAuthorizedPaymentType" minOccurs="0"/>
        </xsd:all>
    </xsd:complexType>


    <xsd:complexType name="DeliverySpecType">
        <xsd:all>
            <xsd:element name="service-code" type="ServiceCodeType"/>
            <xsd:element name="sender" type="SenderType"/>
            <xsd:element name="destination" type="DestinationType"/>
            <xsd:element name="options" minOccurs="0">
                <xsd:complexType>
                    <xsd:sequence>
                        <xsd:element name="option" type="OptionType" maxOccurs="20"/>
                    </xsd:sequence>
                </xsd:complexType>
            </xsd:element>
            <xsd:element name="parcel-characteristics" type="ParcelCharacteristicsType"/>
            <xsd:element name="notification" type="NotificationType" minOccurs="0"/>
            <xsd:element name="print-preferences" type="PrintPreferencesType" minOccurs="0"/>
            <xsd:element name="preferences" type="PreferencesType"/>
            <xsd:element name="references" type="ReferencesType" minOccurs="0"/>
            <xsd:element name="customs" type="CustomsType" minOccurs="0"/>
            <xsd:element name="settlement-info" type="SettlementInfoType"/>
        </xsd:all>
    </xsd:complexType>



    <xsd:complexType name="CustomsType">
        <xsd:all>
            <xsd:element name="currency">
                <xsd:simpleType>
                    <xsd:restriction base="xsd:normalizedString">
                        <xsd:minLength value="1"/>
                        <xsd:maxLength value="3"/>
                    </xsd:restriction>
                </xsd:simpleType>
            </xsd:element>
            <xsd:element name="conversion-from-cad"  minOccurs="0">
                <xsd:simpleType>
                    <xsd:restriction base="xsd:decimal">
                        <xsd:minExclusive value="0"/>
                        <xsd:maxInclusive value="999.999999"/>
                        <xsd:fractionDigits value="6"/>
                    </xsd:restriction>
                </xsd:simpleType>
            </xsd:element>
            <xsd:element name="reason-for-export">
                <xsd:simpleType>
                    <xsd:restriction base="xsd:normalizedString">
                        <xsd:minLength value="1"/>
                        <xsd:maxLength value="3"/>
                    </xsd:restriction>
                </xsd:simpleType>
            </xsd:element>
            <xsd:element name="other-reason" minOccurs="0">
                <xsd:simpleType>
                    <xsd:restriction base="xsd:normalizedString">
                        <xsd:maxLength value="44"/>
                    </xsd:restriction>
                </xsd:simpleType>
            </xsd:element>
            <xsd:element name="sku-list">
                <xsd:complexType>
                    <xsd:sequence>
                        <xsd:element name="item" type="SkuType" maxOccurs="500"/>
                    </xsd:sequence>
                </xsd:complexType>
            </xsd:element>
            <xsd:element name="duties-and-taxes-prepaid"  minOccurs="0">
                <xsd:simpleType>
                    <xsd:restriction base="xsd:decimal">
                        <xsd:minExclusive value="0"/>
                        <xsd:maxInclusive value="99999.99"/>
                        <xsd:fractionDigits value="2"/>
                    </xsd:restriction>
                </xsd:simpleType>
            </xsd:element>
            <xsd:element name="certificate-number"  minOccurs="0">
                <xsd:simpleType>
                    <xsd:restriction base="xsd:normalizedString">
                        <xsd:maxLength value="10"/>
                    </xsd:restriction>
                </xsd:simpleType>
            </xsd:element>
            <xsd:element name="licence-number"  minOccurs="0">
                <xsd:simpleType>
                    <xsd:restriction base="xsd:normalizedString">
                        <xsd:maxLength value="10"/>
                    </xsd:restriction>
                </xsd:simpleType>
            </xsd:element>
            <xsd:element name="invoice-number"  minOccurs="0">
                <xsd:simpleType>
                    <xsd:restriction base="xsd:normalizedString">
                        <xsd:maxLength value="10"/>
                    </xsd:restriction>
                </xsd:simpleType>
            </xsd:element>
        </xsd:all>
    </xsd:complexType>

    <xsd:complexType name="SkuType">
        <xsd:all>
            <xsd:element name="customs-number-of-units">
                <xsd:simpleType>
                    <xsd:restriction base="xsd:positiveInteger">
                        <xsd:minInclusive value="1"/>
                        <xsd:maxInclusive value="9999"/>
                    </xsd:restriction>
                </xsd:simpleType>
            </xsd:element>
            <xsd:element name="customs-description">
                <xsd:simpleType>
                    <xsd:restriction base="xsd:normalizedString">
                        <xsd:minLength value="1"/>
                        <xsd:maxLength value="45"/>
                    </xsd:restriction>
                </xsd:simpleType>
            </xsd:element>
            <xsd:element name="sku" minOccurs="0">
                <xsd:simpleType>
                    <xsd:restriction base="xsd:normalizedString">
                        <xsd:maxLength value="15"/>
                    </xsd:restriction>
                </xsd:simpleType>
            </xsd:element>
            <xsd:element name="hs-tariff-code" minOccurs="0">
                <xsd:simpleType>
                    <xsd:restriction base="xsd:string">
                        <xsd:pattern value="\d{4}(\.\d{2}(\.\d{2}(\.\d{2})?)?)?"/>
                    </xsd:restriction>
                </xsd:simpleType>
            </xsd:element>
            <xsd:element name="unit-weight">
                <xsd:simpleType>
                    <xsd:restriction base="xsd:decimal">
                        <xsd:minExclusive value="0"/>
                        <xsd:maxInclusive value="99.999"/>
                        <xsd:fractionDigits value="3"/>
                    </xsd:restriction>
                </xsd:simpleType>
            </xsd:element>
            <xsd:element name="customs-value-per-unit">
                <xsd:simpleType>
                    <xsd:restriction base="xsd:decimal">
                        <xsd:minExclusive value="0"/>
                        <xsd:maxInclusive value="99999.99"/>
                        <xsd:fractionDigits value="2"/>
                    </xsd:restriction>
                </xsd:simpleType>
            </xsd:element>
            <xsd:element name="customs-unit-of-measure" type="CustomsUnitOfMeasure" minOccurs="0"/>

            <xsd:element name="country-of-origin" type="CountryCodeType" minOccurs="0"/>
            <xsd:element name="province-of-origin" type="ProvinceType" minOccurs="0"/>
        </xsd:all>
    </xsd:complexType>

    <xsd:complexType name="SenderType">
        <xsd:all>
            <xsd:element name="name" type="ContactNameType" minOccurs="0"/>
            <xsd:element name="company" type="CompanyNameType"/>
            <xsd:element name="contact-phone" type="PhoneNumberType" maxOccurs="1"/>
            <xsd:element name="address-details" type="AddressDetailsType"/>
        </xsd:all>
    </xsd:complexType>

    <xsd:complexType name="DestinationType">
        <xsd:all>
            <xsd:element name="name" type="ContactNameType" minOccurs="0"/>
            <xsd:element name="company" type="CompanyNameType" minOccurs="0"/>
            <xsd:element name="additional-address-info" minOccurs="0">
                <xsd:simpleType>
                    <xsd:restriction base="xsd:normalizedString">
                        <xsd:maxLength value="44"/>
                    </xsd:restriction>
                </xsd:simpleType>
            </xsd:element>
            <xsd:element name="client-voice-number" type="PhoneNumberType" minOccurs="0"/>
            <xsd:element name="address-details" type="DestinationAddressDetailsType"/>
        </xsd:all>
    </xsd:complexType>
    <xsd:complexType name="RecipientAddressType">
        <xsd:all>
            <xsd:element name="name" type="ContactNameType" minOccurs="0"/>
            <xsd:element name="company" type="CompanyNameType" minOccurs="0"/>
            <xsd:element name="additional-address-info" minOccurs="0">
                <xsd:simpleType>
                    <xsd:restriction base="xsd:normalizedString">
                        <xsd:maxLength value="44"/>
                    </xsd:restriction>
                </xsd:simpleType>
            </xsd:element>
            <xsd:element name="client-voice-number" type="PhoneNumberType" minOccurs="0"/>
            <xsd:element name="address-details" type="DestinationAddressDetailsType"/>
        </xsd:all>
    </xsd:complexType>

    <xsd:complexType name="ReturnSpecType">
        <xsd:all>
            <xsd:element name="service-code" type="ServiceCodeType"/>
            <xsd:element name="return-recipient" type="ReturnRecipientType"/>
            <xsd:element name="return-notification" type="EmailType" minOccurs="0"/>
        </xsd:all>
    </xsd:complexType>

    <xsd:complexType name="ReturnRecipientType">
        <xsd:all>
            <xsd:element name="name" type="ContactNameType" minOccurs="0"/>
            <xsd:element name="company" type="CompanyNameType" minOccurs="0"/>
            <xsd:element name="address-details" type="DomesticAddressDetailsType"/>
        </xsd:all>
    </xsd:complexType>

    <xsd:complexType name="DomesticAddressDetailsType">
        <xsd:all>
            <xsd:element name="address-line-1">
                <xsd:simpleType>
                    <xsd:restriction base="xsd:normalizedString">
                        <xsd:minLength value="1"/>
                        <xsd:maxLength value="44"/>
                    </xsd:restriction>
                </xsd:simpleType>
            </xsd:element>
            <xsd:element name="address-line-2" minOccurs="0">
                <xsd:simpleType>
                    <xsd:restriction base="xsd:normalizedString">
                        <xsd:maxLength value="44"/>
                    </xsd:restriction>
                </xsd:simpleType>
            </xsd:element>
            <xsd:element name="city">
                <xsd:simpleType>
                    <xsd:restriction base="xsd:normalizedString">
                        <xsd:minLength value="1"/>
                        <xsd:maxLength value="40"/>
                    </xsd:restriction>
                </xsd:simpleType>
            </xsd:element>
            <xsd:element name="prov-state" type="ProvinceType"/>
            <xsd:element name="postal-zip-code" type="PostalCodeType"/>
        </xsd:all>
    </xsd:complexType>

    <xsd:complexType name="AddressDetailsType">
        <xsd:all>
            <xsd:element name="address-line-1">
                <xsd:simpleType>
                    <xsd:restriction base="xsd:normalizedString">
                        <xsd:minLength value="1"/>
                        <xsd:maxLength value="44"/>
                    </xsd:restriction>
                </xsd:simpleType>
            </xsd:element>
            <xsd:element name="address-line-2" minOccurs="0">
                <xsd:simpleType>
                    <xsd:restriction base="xsd:normalizedString">
                        <xsd:maxLength value="44"/>
                    </xsd:restriction>
                </xsd:simpleType>
            </xsd:element>
            <xsd:element name="city">
                <xsd:simpleType>
                    <xsd:restriction base="xsd:normalizedString">
                        <xsd:minLength value="1"/>
                        <xsd:maxLength value="40"/>
                    </xsd:restriction>
                </xsd:simpleType>
            </xsd:element>
            <xsd:element name="prov-state" type="ProvinceStateOrInternationalType"/>
            <xsd:element name="country-code" type="CountryCodeType"/>
            <xsd:element name="postal-zip-code" type="PostalCodeOrZipOrInternationalType" minOccurs="0"/>
        </xsd:all>
    </xsd:complexType>

    <xsd:complexType name="DestinationAddressDetailsType">
        <xsd:all>
            <xsd:element name="address-line-1" minOccurs="0">
                <xsd:simpleType>
                    <xsd:restriction base="xsd:normalizedString">
                        <xsd:minLength value="1"/>
                        <xsd:maxLength value="44"/>
                    </xsd:restriction>
                </xsd:simpleType>
            </xsd:element>
            <xsd:element name="address-line-2" minOccurs="0">
                <xsd:simpleType>
                    <xsd:restriction base="xsd:normalizedString">
                        <xsd:maxLength value="44"/>
                    </xsd:restriction>
                </xsd:simpleType>
            </xsd:element>
            <xsd:element name="city" minOccurs="0">
                <xsd:simpleType>
                    <xsd:restriction base="xsd:normalizedString">
                        <xsd:minLength value="1"/>
                        <xsd:maxLength value="40"/>
                    </xsd:restriction>
                </xsd:simpleType>
            </xsd:element>
            <xsd:element name="prov-state" type="ProvinceStateOrInternationalType" minOccurs="0"/>
            <xsd:element name="country-code" type="CountryCodeType"/>
            <xsd:element name="postal-zip-code" type="PostalCodeOrZipOrInternationalType" minOccurs="0"/>
        </xsd:all>
    </xsd:complexType>

    <xsd:complexType name="OptionType">
        <xsd:all>
            <xsd:element name="option-code">
                <xsd:simpleType>
                    <xsd:restriction base="xsd:normalizedString">
                        <xsd:minLength value="1"/>
                        <xsd:maxLength value="10"/>
                    </xsd:restriction>
                </xsd:simpleType>
            </xsd:element>
            <xsd:element name="option-amount" type="CostTypeNonZero" minOccurs="0"/>
            <xsd:element name="option-qualifier-1"  type="xsd:boolean" minOccurs="0"/>
            <xsd:element name="option-qualifier-2" minOccurs="0">
                <xsd:simpleType>
                    <xsd:restriction base="xsd:normalizedString">
                        <xsd:maxLength value="12"/>
                    </xsd:restriction>
                </xsd:simpleType>
            </xsd:element>
        </xsd:all>
    </xsd:complexType>

    <xsd:complexType name="ParcelCharacteristicsType">
        <xsd:all>
            <xsd:element name="weight">
                <xsd:simpleType>
                    <xsd:restriction base="xsd:decimal">
                        <xsd:minExclusive value="0"/>
                        <xsd:maxInclusive value="999.999"/>
                        <xsd:fractionDigits value="3"/>
                    </xsd:restriction>
                </xsd:simpleType>
            </xsd:element>
            <xsd:element name="dimensions" minOccurs="0">
                <xsd:complexType>
                    <xsd:all>
                        <xsd:element name="length" type="DimensionMeasurementType"/>
                        <xsd:element name="width" type="DimensionMeasurementType"/>
                        <xsd:element name="height" type="DimensionMeasurementType"/>
                    </xsd:all>
                </xsd:complexType>
            </xsd:element>
            <xsd:element name="unpackaged" type="xsd:boolean" minOccurs="0"/>
            <xsd:element name="mailing-tube" type="xsd:boolean" minOccurs="0"/>
            <xsd:element name="oversized" type="xsd:boolean" minOccurs="0"/>
        </xsd:all>
    </xsd:complexType>

    <xsd:complexType name="NotificationType">
        <xsd:all>
            <xsd:element name="email" type="EmailType"/>
            <xsd:element name="on-shipment" type="xsd:boolean"/>
            <xsd:element name="on-exception" type="xsd:boolean"/>
            <xsd:element name="on-delivery" type="xsd:boolean"/>
        </xsd:all>
    </xsd:complexType>

    <xsd:complexType name="PrintPreferencesType">
        <xsd:all>
            <xsd:element name="output-format" minOccurs="0">
                <xsd:simpleType>
                    <xsd:restriction base="xsd:string">
                        <xsd:enumeration value="8.5x11"/>
                        <xsd:enumeration value="4x6"/>
                    </xsd:restriction>
                </xsd:simpleType>
            </xsd:element>
            <xsd:element name="encoding" minOccurs="0">
                <xsd:simpleType>
                    <xsd:restriction base="xsd:string">
                        <xsd:enumeration value="PDF"/>
                        <xsd:enumeration value="ZPL"/>
                    </xsd:restriction>
                </xsd:simpleType>
            </xsd:element>
        </xsd:all>
    </xsd:complexType>

    <xsd:complexType name="PreferencesType">
        <xsd:all>
            <xsd:element name="show-packing-instructions" type="xsd:boolean"/>
            <xsd:element name="show-postage-rate" type="xsd:boolean" minOccurs="0"/>
            <xsd:element name="show-insured-value" type="xsd:boolean" minOccurs="0"/>
        </xsd:all>
    </xsd:complexType>

    <xsd:complexType name="ReferencesType">
        <xsd:all>
            <xsd:element name="cost-centre" type="CostCentreIDType" minOccurs="0"/>
            <xsd:element name="customer-ref-1" minOccurs="0">
                <xsd:simpleType>
                    <xsd:restriction base="xsd:normalizedString">
                        <xsd:maxLength value="35"/>
                    </xsd:restriction>
                </xsd:simpleType>
            </xsd:element>
            <xsd:element name="customer-ref-2" minOccurs="0">
                <xsd:simpleType>
                    <xsd:restriction base="xsd:normalizedString">
                        <xsd:maxLength value="35"/>
                    </xsd:restriction>
                </xsd:simpleType>
            </xsd:element>
        </xsd:all>
    </xsd:complexType>

    <xsd:complexType name="SettlementInfoType">
        <xsd:all>
            <xsd:element name="paid-by-customer" type="CustomerIDType" minOccurs="0"/>
            <xsd:element name="contract-id" type="ContractIDType" minOccurs="0"/>
            <xsd:element name="cif-shipment" type="xsd:boolean" fixed="true" minOccurs="0" />
            <xsd:element name="intended-method-of-payment" type="MethodOfPaymentType"/>
            <xsd:element name="promo-code" type="PromoCodeType" minOccurs="0" />
        </xsd:all>
    </xsd:complexType>

    <xsd:complexType name="PreAuthorizedPaymentType">
        <xsd:all>
            <xsd:element name="account-number">
                <xsd:simpleType>
                    <xsd:restriction base="xsd:normalizedString">
                        <xsd:minLength value="1"/>
                        <xsd:maxLength value="16"/>
                    </xsd:restriction>
                </xsd:simpleType>
            </xsd:element>
            <xsd:element name="auth-code">
                <xsd:simpleType>
                    <xsd:restriction base="xsd:normalizedString">
                        <xsd:minLength value="1"/>
                        <xsd:maxLength value="16"/>
                    </xsd:restriction>
                </xsd:simpleType>
            </xsd:element>
            <xsd:element name="auth-timestamp" type="xsd:dateTime" />
            <xsd:element name="charge-amount">
                <xsd:simpleType>
                    <xsd:restriction base="xsd:decimal">
                        <xsd:minExclusive value="0"/>
                        <xsd:maxInclusive value="9999999.99"/>
                        <xsd:fractionDigits value="2"/>
                    </xsd:restriction>
                </xsd:simpleType>
            </xsd:element>
        </xsd:all>
    </xsd:complexType>

    <xsd:simpleType name="CostCentreIDType">
        <xsd:restriction base="xsd:normalizedString">
            <xsd:maxLength value="30"/>
        </xsd:restriction>
    </xsd:simpleType>

    <xsd:simpleType name="EmailType">
        <xsd:restriction base="xsd:normalizedString">
            <xsd:pattern value="(['_A-Za-z0-9\-\+]+)(\.['_A-Za-z0-9\-\+]+)*@([A-Za-z0-9-]+)(\.[A-Za-z0-9-]+)*(\.[A-Za-z]{2,5})"/>
            <xsd:maxLength value="60"/>
        </xsd:restriction>
    </xsd:simpleType>

    <xsd:simpleType name="CompanyNameType">
        <xsd:restriction base="xsd:normalizedString">
            <xsd:maxLength value="44"/>
        </xsd:restriction>
    </xsd:simpleType>

    <xsd:simpleType name="ContactNameType">
        <xsd:restriction base="xsd:normalizedString">
            <xsd:maxLength value="44"/>
        </xsd:restriction>
    </xsd:simpleType>

    <xsd:simpleType name="GroupIDType">
        <xsd:restriction base="xsd:normalizedString">
            <xsd:minLength value="1"/>
            <xsd:maxLength value="32"/>
        </xsd:restriction>
    </xsd:simpleType>

    <xsd:simpleType name="TrackingPINType">
        <xsd:restriction base="xsd:normalizedString">
            <xsd:minLength value="11"/>
            <xsd:maxLength value="16"/>
        </xsd:restriction>
    </xsd:simpleType>

    <xsd:simpleType name="ShipmentIDType">
        <xsd:restriction base="xsd:normalizedString">
            <xsd:maxLength value="32"/>
        </xsd:restriction>
    </xsd:simpleType>

    <xsd:simpleType name="ShipmentStatusType">
        <xsd:restriction base="xsd:normalizedString">
            <xsd:maxLength value="14"/>
        </xsd:restriction>
    </xsd:simpleType>


    <xsd:simpleType name="CustomerRequestIdType">
        <xsd:restriction base="xsd:normalizedString">
            <xsd:maxLength value="35" />
        </xsd:restriction>
    </xsd:simpleType>

    <xsd:simpleType name="PromoCodeType">
        <xsd:restriction base="xsd:normalizedString">
            <xsd:maxLength value="10" />
        </xsd:restriction>
    </xsd:simpleType>


    <xsd:complexType name="ShipmentDetailsType">
        <xsd:all>
            <xsd:element name="customer-request-id" type="CustomerRequestIdType" minOccurs="0" />
            <xsd:element name="shipment-status" type="ShipmentStatusType"/>
            <xsd:element name="final-shipping-point" type="PostalCodeType"/>
            <xsd:element name="tracking-pin" type="TrackingPINType" minOccurs="0"/>
            <xsd:element name="po-number" type="PoNumberType" minOccurs="0"/>
            <xsd:element name="shipping-point-id" type="OutletIDType" minOccurs="0" />
            <xsd:element name="cpc-pickup-indicator" type="xsd:boolean" fixed="true" minOccurs="0"/>

            <!--
                Redefine ShipmentType locally without the requested-shipping-point element because it is mandatory
                in the create shipment request but removed from the shipment details response.

                <xsd:element name="shipment-detail" type="ShipmentType"/>
            -->
            <xsd:element name="shipment-detail">
                <xsd:complexType>
                    <xsd:all>
                        <xsd:element ref="groupIdOrTransmitShipment" />
                        <xsd:element name="quickship-label-requested" type="xsd:boolean" minOccurs="0"/>
                        <xsd:element name="expected-mailing-date" type="xsd:date" minOccurs="0"/>
                        <xsd:element name="delivery-spec">
                            <xsd:complexType>
                                <xsd:all>
                                    <xsd:element name="service-code" type="ServiceCodeType"/>
                                    <xsd:element name="sender" type="SenderType"/>
                                    <xsd:element name="destination" type="DestinationType"/>
                                    <xsd:element name="recipient" type="RecipientAddressType" minOccurs="0"/>
                                    <xsd:element name="options" minOccurs="0">
                                        <xsd:complexType>
                                            <xsd:sequence>
                                                <xsd:element name="option" type="OptionType" maxOccurs="20"/>
                                            </xsd:sequence>
                                        </xsd:complexType>
                                    </xsd:element>
                                    <xsd:element name="parcel-characteristics" type="ParcelCharacteristicsType"/>
                                    <xsd:element name="notification" type="NotificationType" minOccurs="0"/>
                                    <xsd:element name="print-preferences" type="PrintPreferencesType" minOccurs="0"/>
                                    <xsd:element name="preferences" type="PreferencesType"/>
                                    <xsd:element name="references" type="ReferencesType" minOccurs="0"/>
                                    <xsd:element name="customs" type="CustomsType" minOccurs="0"/>
                                    <xsd:element name="settlement-info" type="SettlementInfoType"/>
                                </xsd:all>
                            </xsd:complexType>
                        </xsd:element>
                        <xsd:element name="return-spec" type="ReturnSpecType" minOccurs="0"/>
                        <xsd:element name="refund-request-info" type="ShipmentRefundRequestInfoType" minOccurs="0"/>
                    </xsd:all>
                </xsd:complexType>
            </xsd:element>
        </xsd:all>
    </xsd:complexType>

    <xsd:complexType name="ShipmentCCReceiptType">
        <xsd:all>
            <xsd:element name="cc-receipt-details">
                <xsd:complexType>
                    <xsd:all>
                        <xsd:element name="merchant-name">
                            <xsd:simpleType>
                                <xsd:restriction base="xsd:normalizedString">
                                    <xsd:maxLength value="44" />
                                </xsd:restriction>
                            </xsd:simpleType>
                        </xsd:element>
                        <xsd:element name="merchant-url">
                            <xsd:simpleType>
                                <xsd:restriction base="xsd:normalizedString">
                                    <xsd:maxLength value="60" />
                                </xsd:restriction>
                            </xsd:simpleType>
                        </xsd:element>
                        <xsd:element name="name-on-card" type="CcNameType" minOccurs="0"/>
                        <xsd:element name="auth-code" type="CcAuthorizationCodeType" />
                        <xsd:element name="auth-timestamp" type="xsd:dateTime" />
                        <xsd:element name="card-type" type="CcType" />
                        <xsd:element name="charge-amount" type="CcAuthorizationAmountType" />
                        <xsd:element name="currency" type="CurrencyType" />
                        <xsd:element name="transaction-type">
                            <xsd:simpleType>
                                <xsd:restriction base="xsd:normalizedString">
                                    <xsd:maxLength value="44" />
                                </xsd:restriction>
                            </xsd:simpleType>
                        </xsd:element>
                    </xsd:all>
                </xsd:complexType>
            </xsd:element>
        </xsd:all>
    </xsd:complexType>

    <xsd:complexType name="ShipmentReceiptType">
        <xsd:choice>
            <xsd:element name="cc-receipt-details">
                <xsd:complexType>
                    <xsd:all>
                        <xsd:element name="merchant-name">
                            <xsd:simpleType>
                                <xsd:restriction base="xsd:normalizedString">
                                    <xsd:maxLength value="44" />
                                </xsd:restriction>
                            </xsd:simpleType>
                        </xsd:element>
                        <xsd:element name="merchant-url">
                            <xsd:simpleType>
                                <xsd:restriction base="xsd:normalizedString">
                                    <xsd:maxLength value="60" />
                                </xsd:restriction>
                            </xsd:simpleType>
                        </xsd:element>
                        <xsd:element name="name-on-card" type="CcNameType" minOccurs="0"/>
                        <xsd:element name="auth-code" type="CcAuthorizationCodeType" />
                        <xsd:element name="auth-timestamp" type="xsd:dateTime" />
                        <xsd:element name="card-type" type="CcType" />
                        <xsd:element name="charge-amount" type="CcAuthorizationAmountType" />
                        <xsd:element name="currency" type="CurrencyType" />
                        <xsd:element name="transaction-type">
                            <xsd:simpleType>
                                <xsd:restriction base="xsd:normalizedString">
                                    <xsd:maxLength value="44" />
                                </xsd:restriction>
                            </xsd:simpleType>
                        </xsd:element>
                    </xsd:all>
                </xsd:complexType>
            </xsd:element>
            <xsd:element name="supplier-account-receipt-details">
                <xsd:complexType>
                    <xsd:all>
                        <xsd:element name="merchant-name">
                            <xsd:simpleType>
                                <xsd:restriction base="xsd:normalizedString">
                                    <xsd:maxLength value="44" />
                                </xsd:restriction>
                            </xsd:simpleType>
                        </xsd:element>
                        <xsd:element name="merchant-url">
                            <xsd:simpleType>
                                <xsd:restriction base="xsd:normalizedString">
                                    <xsd:maxLength value="60" />
                                </xsd:restriction>
                            </xsd:simpleType>
                        </xsd:element>
                        <xsd:element name="auth-code" type="AuthorizationCodeType" />
                        <xsd:element name="auth-timestamp" type="xsd:dateTime" />
                        <xsd:element name="supplier-id" type="xsd:normalizedString" />
                        <xsd:element name="charge-amount" type="AuthorizationAmountType" />
                        <xsd:element name="currency" type="CurrencyType" />
                        <xsd:element name="transaction-type">
                            <xsd:simpleType>
                                <xsd:restriction base="xsd:normalizedString">
                                    <xsd:maxLength value="44" />
                                </xsd:restriction>
                            </xsd:simpleType>
                        </xsd:element>
                    </xsd:all>
                </xsd:complexType>
            </xsd:element>
        </xsd:choice>
    </xsd:complexType>

    <xsd:complexType name="ShipmentRefundRequestType">
        <xsd:all>
            <xsd:element name="email" type="EmailType"/>
        </xsd:all>
    </xsd:complexType>

    <xsd:complexType name="ShipmentRefundRequestInfoType">
        <xsd:all>
            <xsd:element name="service-ticket-date" type="xsd:date"/>
            <xsd:element name="service-ticket-id" type="xsd:normalizedString"/>
        </xsd:all>
    </xsd:complexType>
`;
