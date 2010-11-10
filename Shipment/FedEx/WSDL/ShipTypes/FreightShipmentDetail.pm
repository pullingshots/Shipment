package Shipment::FedEx::WSDL::ShipTypes::FreightShipmentDetail;
use strict;
use warnings;


__PACKAGE__->_set_element_form_qualified(1);

sub get_xmlns { 'http://fedex.com/ws/ship/v9' };

our $XML_ATTRIBUTE_CLASS;
undef $XML_ATTRIBUTE_CLASS;

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}

use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %FedExFreightAccountNumber_of :ATTR(:get<FedExFreightAccountNumber>);
my %FedExFreightBillingContactAndAddress_of :ATTR(:get<FedExFreightBillingContactAndAddress>);
my %PrintedReferences_of :ATTR(:get<PrintedReferences>);
my %Role_of :ATTR(:get<Role>);
my %PaymentType_of :ATTR(:get<PaymentType>);
my %CollectTermsType_of :ATTR(:get<CollectTermsType>);
my %DeclaredValuePerUnit_of :ATTR(:get<DeclaredValuePerUnit>);
my %DeclaredValueUnits_of :ATTR(:get<DeclaredValueUnits>);
my %LiabilityCoverageDetail_of :ATTR(:get<LiabilityCoverageDetail>);
my %Coupons_of :ATTR(:get<Coupons>);
my %TotalHandlingUnits_of :ATTR(:get<TotalHandlingUnits>);
my %ClientDiscountPercent_of :ATTR(:get<ClientDiscountPercent>);
my %PalletWeight_of :ATTR(:get<PalletWeight>);
my %ShipmentDimensions_of :ATTR(:get<ShipmentDimensions>);
my %Comment_of :ATTR(:get<Comment>);
my %SpecialServicePayments_of :ATTR(:get<SpecialServicePayments>);
my %HazardousMaterialsEmergencyContactNumber_of :ATTR(:get<HazardousMaterialsEmergencyContactNumber>);
my %LineItems_of :ATTR(:get<LineItems>);

__PACKAGE__->_factory(
    [ qw(        FedExFreightAccountNumber
        FedExFreightBillingContactAndAddress
        PrintedReferences
        Role
        PaymentType
        CollectTermsType
        DeclaredValuePerUnit
        DeclaredValueUnits
        LiabilityCoverageDetail
        Coupons
        TotalHandlingUnits
        ClientDiscountPercent
        PalletWeight
        ShipmentDimensions
        Comment
        SpecialServicePayments
        HazardousMaterialsEmergencyContactNumber
        LineItems

    ) ],
    {
        'FedExFreightAccountNumber' => \%FedExFreightAccountNumber_of,
        'FedExFreightBillingContactAndAddress' => \%FedExFreightBillingContactAndAddress_of,
        'PrintedReferences' => \%PrintedReferences_of,
        'Role' => \%Role_of,
        'PaymentType' => \%PaymentType_of,
        'CollectTermsType' => \%CollectTermsType_of,
        'DeclaredValuePerUnit' => \%DeclaredValuePerUnit_of,
        'DeclaredValueUnits' => \%DeclaredValueUnits_of,
        'LiabilityCoverageDetail' => \%LiabilityCoverageDetail_of,
        'Coupons' => \%Coupons_of,
        'TotalHandlingUnits' => \%TotalHandlingUnits_of,
        'ClientDiscountPercent' => \%ClientDiscountPercent_of,
        'PalletWeight' => \%PalletWeight_of,
        'ShipmentDimensions' => \%ShipmentDimensions_of,
        'Comment' => \%Comment_of,
        'SpecialServicePayments' => \%SpecialServicePayments_of,
        'HazardousMaterialsEmergencyContactNumber' => \%HazardousMaterialsEmergencyContactNumber_of,
        'LineItems' => \%LineItems_of,
    },
    {
        'FedExFreightAccountNumber' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'FedExFreightBillingContactAndAddress' => 'Shipment::FedEx::WSDL::ShipTypes::ContactAndAddress',
        'PrintedReferences' => 'Shipment::FedEx::WSDL::ShipTypes::PrintedReference',
        'Role' => 'Shipment::FedEx::WSDL::ShipTypes::FreightShipmentRoleType',
        'PaymentType' => 'Shipment::FedEx::WSDL::ShipTypes::FreightAccountPaymentType',
        'CollectTermsType' => 'Shipment::FedEx::WSDL::ShipTypes::FreightCollectTermsType',
        'DeclaredValuePerUnit' => 'Shipment::FedEx::WSDL::ShipTypes::Money',
        'DeclaredValueUnits' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'LiabilityCoverageDetail' => 'Shipment::FedEx::WSDL::ShipTypes::LiabilityCoverageDetail',
        'Coupons' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'TotalHandlingUnits' => 'SOAP::WSDL::XSD::Typelib::Builtin::nonNegativeInteger',
        'ClientDiscountPercent' => 'SOAP::WSDL::XSD::Typelib::Builtin::decimal',
        'PalletWeight' => 'Shipment::FedEx::WSDL::ShipTypes::Weight',
        'ShipmentDimensions' => 'Shipment::FedEx::WSDL::ShipTypes::Dimensions',
        'Comment' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'SpecialServicePayments' => 'Shipment::FedEx::WSDL::ShipTypes::FreightSpecialServicePayment',
        'HazardousMaterialsEmergencyContactNumber' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'LineItems' => 'Shipment::FedEx::WSDL::ShipTypes::FreightShipmentLineItem',
    },
    {

        'FedExFreightAccountNumber' => 'FedExFreightAccountNumber',
        'FedExFreightBillingContactAndAddress' => 'FedExFreightBillingContactAndAddress',
        'PrintedReferences' => 'PrintedReferences',
        'Role' => 'Role',
        'PaymentType' => 'PaymentType',
        'CollectTermsType' => 'CollectTermsType',
        'DeclaredValuePerUnit' => 'DeclaredValuePerUnit',
        'DeclaredValueUnits' => 'DeclaredValueUnits',
        'LiabilityCoverageDetail' => 'LiabilityCoverageDetail',
        'Coupons' => 'Coupons',
        'TotalHandlingUnits' => 'TotalHandlingUnits',
        'ClientDiscountPercent' => 'ClientDiscountPercent',
        'PalletWeight' => 'PalletWeight',
        'ShipmentDimensions' => 'ShipmentDimensions',
        'Comment' => 'Comment',
        'SpecialServicePayments' => 'SpecialServicePayments',
        'HazardousMaterialsEmergencyContactNumber' => 'HazardousMaterialsEmergencyContactNumber',
        'LineItems' => 'LineItems',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::FedEx::WSDL::ShipTypes::FreightShipmentDetail

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
FreightShipmentDetail from the namespace http://fedex.com/ws/ship/v9.

Data applicable to shipments using FEDEX_FREIGHT and FEDEX_NATIONAL_FREIGHT services.




=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * FedExFreightAccountNumber (min/maxOccurs: 0/1)


=item * FedExFreightBillingContactAndAddress (min/maxOccurs: 0/1)


=item * PrintedReferences (min/maxOccurs: 0/unbounded)


=item * Role (min/maxOccurs: 0/1)


=item * PaymentType (min/maxOccurs: 0/1)


=item * CollectTermsType (min/maxOccurs: 0/1)


=item * DeclaredValuePerUnit (min/maxOccurs: 0/1)


=item * DeclaredValueUnits (min/maxOccurs: 0/1)


=item * LiabilityCoverageDetail (min/maxOccurs: 0/1)


=item * Coupons (min/maxOccurs: 0/unbounded)


=item * TotalHandlingUnits (min/maxOccurs: 0/1)


=item * ClientDiscountPercent (min/maxOccurs: 0/1)


=item * PalletWeight (min/maxOccurs: 0/1)


=item * ShipmentDimensions (min/maxOccurs: 0/1)


=item * Comment (min/maxOccurs: 0/1)


=item * SpecialServicePayments (min/maxOccurs: 0/unbounded)


=item * HazardousMaterialsEmergencyContactNumber (min/maxOccurs: 0/1)


=item * LineItems (min/maxOccurs: 0/unbounded)




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::FedEx::WSDL::ShipTypes::FreightShipmentDetail
   FedExFreightAccountNumber =>  $some_value, # string
   FedExFreightBillingContactAndAddress =>  { # Shipment::FedEx::WSDL::ShipTypes::ContactAndAddress
     Contact =>  { # Shipment::FedEx::WSDL::ShipTypes::Contact
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
     Address =>  { # Shipment::FedEx::WSDL::ShipTypes::Address
       StreetLines =>  $some_value, # string
       City =>  $some_value, # string
       StateOrProvinceCode =>  $some_value, # string
       PostalCode =>  $some_value, # string
       UrbanizationCode =>  $some_value, # string
       CountryCode =>  $some_value, # string
       Residential =>  $some_value, # boolean
     },
   },
   PrintedReferences =>  { # Shipment::FedEx::WSDL::ShipTypes::PrintedReference
     Type => $some_value, # PrintedReferenceType
     Value =>  $some_value, # string
   },
   Role => $some_value, # FreightShipmentRoleType
   PaymentType => $some_value, # FreightAccountPaymentType
   CollectTermsType => $some_value, # FreightCollectTermsType
   DeclaredValuePerUnit =>  { # Shipment::FedEx::WSDL::ShipTypes::Money
     Currency =>  $some_value, # string
     Amount =>  $some_value, # decimal
   },
   DeclaredValueUnits =>  $some_value, # string
   LiabilityCoverageDetail =>  { # Shipment::FedEx::WSDL::ShipTypes::LiabilityCoverageDetail
     CoverageType => $some_value, # LiabilityCoverageType
     CoverageAmount => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
   },
   Coupons =>  $some_value, # string
   TotalHandlingUnits =>  $some_value, # nonNegativeInteger
   ClientDiscountPercent =>  $some_value, # decimal
   PalletWeight =>  { # Shipment::FedEx::WSDL::ShipTypes::Weight
     Units => $some_value, # WeightUnits
     Value =>  $some_value, # decimal
   },
   ShipmentDimensions =>  { # Shipment::FedEx::WSDL::ShipTypes::Dimensions
     Length =>  $some_value, # nonNegativeInteger
     Width =>  $some_value, # nonNegativeInteger
     Height =>  $some_value, # nonNegativeInteger
     Units => $some_value, # LinearUnits
   },
   Comment =>  $some_value, # string
   SpecialServicePayments =>  { # Shipment::FedEx::WSDL::ShipTypes::FreightSpecialServicePayment
     SpecialService => $some_value, # ShipmentSpecialServiceType
     PaymentType => $some_value, # FreightAccountPaymentType
   },
   HazardousMaterialsEmergencyContactNumber =>  $some_value, # string
   LineItems =>  { # Shipment::FedEx::WSDL::ShipTypes::FreightShipmentLineItem
     FreightClass => $some_value, # FreightClassType
     ClassProvidedByCustomer =>  $some_value, # boolean
     HandlingUnits =>  $some_value, # nonNegativeInteger
     Packaging => $some_value, # PhysicalPackagingType
     Pieces =>  $some_value, # nonNegativeInteger
     NmfcCode =>  $some_value, # string
     HazardousMaterials => $some_value, # HazardousCommodityOptionType
     BillOfLadingNumber =>  $some_value, # string
     PurchaseOrderNumber =>  $some_value, # string
     Description =>  $some_value, # string
     Weight => {}, # Shipment::FedEx::WSDL::ShipTypes::Weight
     Dimensions => {}, # Shipment::FedEx::WSDL::ShipTypes::Dimensions
     Volume =>  { # Shipment::FedEx::WSDL::ShipTypes::Volume
       Units => $some_value, # VolumeUnits
       Value =>  $some_value, # decimal
     },
   },
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

