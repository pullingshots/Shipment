package Shipment::FedEx::WSDL::RateTypes::PackageSpecialServicesRequested;
use strict;
use warnings;


__PACKAGE__->_set_element_form_qualified(1);

sub get_xmlns { 'http://fedex.com/ws/rate/v9' };

our $XML_ATTRIBUTE_CLASS;
undef $XML_ATTRIBUTE_CLASS;

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}

use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %SpecialServiceTypes_of :ATTR(:get<SpecialServiceTypes>);
my %CodDetail_of :ATTR(:get<CodDetail>);
my %DangerousGoodsDetail_of :ATTR(:get<DangerousGoodsDetail>);
my %DryIceWeight_of :ATTR(:get<DryIceWeight>);
my %SignatureOptionDetail_of :ATTR(:get<SignatureOptionDetail>);
my %PriorityAlertDetail_of :ATTR(:get<PriorityAlertDetail>);

__PACKAGE__->_factory(
    [ qw(        SpecialServiceTypes
        CodDetail
        DangerousGoodsDetail
        DryIceWeight
        SignatureOptionDetail
        PriorityAlertDetail

    ) ],
    {
        'SpecialServiceTypes' => \%SpecialServiceTypes_of,
        'CodDetail' => \%CodDetail_of,
        'DangerousGoodsDetail' => \%DangerousGoodsDetail_of,
        'DryIceWeight' => \%DryIceWeight_of,
        'SignatureOptionDetail' => \%SignatureOptionDetail_of,
        'PriorityAlertDetail' => \%PriorityAlertDetail_of,
    },
    {
        'SpecialServiceTypes' => 'Shipment::FedEx::WSDL::RateTypes::PackageSpecialServiceType',
        'CodDetail' => 'Shipment::FedEx::WSDL::RateTypes::CodDetail',
        'DangerousGoodsDetail' => 'Shipment::FedEx::WSDL::RateTypes::DangerousGoodsDetail',
        'DryIceWeight' => 'Shipment::FedEx::WSDL::RateTypes::Weight',
        'SignatureOptionDetail' => 'Shipment::FedEx::WSDL::RateTypes::SignatureOptionDetail',
        'PriorityAlertDetail' => 'Shipment::FedEx::WSDL::RateTypes::PriorityAlertDetail',
    },
    {

        'SpecialServiceTypes' => 'SpecialServiceTypes',
        'CodDetail' => 'CodDetail',
        'DangerousGoodsDetail' => 'DangerousGoodsDetail',
        'DryIceWeight' => 'DryIceWeight',
        'SignatureOptionDetail' => 'SignatureOptionDetail',
        'PriorityAlertDetail' => 'PriorityAlertDetail',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::FedEx::WSDL::RateTypes::PackageSpecialServicesRequested

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
PackageSpecialServicesRequested from the namespace http://fedex.com/ws/rate/v9.

These special services are available at the package level for some or all service types. If the shipper is requesting a special service which requires additional data, the package special service type must be present in the specialServiceTypes collection, and the supporting detail must be provided in the appropriate sub-object below.




=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * SpecialServiceTypes (min/maxOccurs: 0/unbounded)


=item * CodDetail (min/maxOccurs: 0/1)


=item * DangerousGoodsDetail (min/maxOccurs: 0/1)


=item * DryIceWeight (min/maxOccurs: 0/1)


=item * SignatureOptionDetail (min/maxOccurs: 0/1)


=item * PriorityAlertDetail (min/maxOccurs: 0/1)




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::FedEx::WSDL::RateTypes::PackageSpecialServicesRequested
   SpecialServiceTypes => $some_value, # PackageSpecialServiceType
   CodDetail =>  { # Shipment::FedEx::WSDL::RateTypes::CodDetail
     CodCollectionAmount =>  { # Shipment::FedEx::WSDL::RateTypes::Money
       Currency =>  $some_value, # string
       Amount =>  $some_value, # decimal
     },
     AddTransportationCharges => $some_value, # CodAddTransportationChargesType
     CollectionType => $some_value, # CodCollectionType
     CodRecipient =>  { # Shipment::FedEx::WSDL::RateTypes::Party
       AccountNumber =>  $some_value, # string
       Tins =>  { # Shipment::FedEx::WSDL::RateTypes::TaxpayerIdentification
         TinType => $some_value, # TinType
         Number =>  $some_value, # string
         Usage =>  $some_value, # string
       },
       Contact =>  { # Shipment::FedEx::WSDL::RateTypes::Contact
         ContactId =>  $some_value, # string
         PersonName =>  $some_value, # string
         Title =>  $some_value, # string
         CompanyName =>  $some_value, # string
         PhoneNumber =>  $some_value, # string
         PhoneExtension =>  $some_value, # string
         PagerNumber =>  $some_value, # string
         FaxNumber =>  $some_value, # string
         EMailAddress =>  $some_value, # string
       },
       Address =>  { # Shipment::FedEx::WSDL::RateTypes::Address
         StreetLines =>  $some_value, # string
         City =>  $some_value, # string
         StateOrProvinceCode =>  $some_value, # string
         PostalCode =>  $some_value, # string
         UrbanizationCode =>  $some_value, # string
         CountryCode =>  $some_value, # string
         Residential =>  $some_value, # boolean
       },
     },
     ReferenceIndicator => $some_value, # CodReturnReferenceIndicatorType
   },
   DangerousGoodsDetail =>  { # Shipment::FedEx::WSDL::RateTypes::DangerousGoodsDetail
     Accessibility => $some_value, # DangerousGoodsAccessibilityType
     CargoAircraftOnly =>  $some_value, # boolean
     Options => $some_value, # HazardousCommodityOptionType
     HazardousCommodities =>  { # Shipment::FedEx::WSDL::RateTypes::HazardousCommodityContent
       Description =>  { # Shipment::FedEx::WSDL::RateTypes::HazardousCommodityDescription
         Id =>  $some_value, # string
         PackingGroup => $some_value, # HazardousCommodityPackingGroupType
         ProperShippingName =>  $some_value, # string
         TechnicalName =>  $some_value, # string
         HazardClass =>  $some_value, # string
         SubsidiaryClasses =>  $some_value, # string
         LabelText =>  $some_value, # string
       },
       Quantity =>  { # Shipment::FedEx::WSDL::RateTypes::HazardousCommodityQuantityDetail
         Amount =>  $some_value, # decimal
         Units =>  $some_value, # string
       },
       Options =>  { # Shipment::FedEx::WSDL::RateTypes::HazardousCommodityOptionDetail
         LabelTextOption => $some_value, # HazardousCommodityLabelTextOptionType
         CustomerSuppliedLabelText =>  $some_value, # string
       },
     },
     Packaging =>  { # Shipment::FedEx::WSDL::RateTypes::HazardousCommodityPackagingDetail
       Count =>  $some_value, # nonNegativeInteger
       Units =>  $some_value, # string
     },
     EmergencyContactNumber =>  $some_value, # string
   },
   DryIceWeight =>  { # Shipment::FedEx::WSDL::RateTypes::Weight
     Units => $some_value, # WeightUnits
     Value =>  $some_value, # decimal
   },
   SignatureOptionDetail =>  { # Shipment::FedEx::WSDL::RateTypes::SignatureOptionDetail
     OptionType => $some_value, # SignatureOptionType
     SignatureReleaseNumber =>  $some_value, # string
   },
   PriorityAlertDetail =>  { # Shipment::FedEx::WSDL::RateTypes::PriorityAlertDetail
     Content =>  $some_value, # string
   },
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

