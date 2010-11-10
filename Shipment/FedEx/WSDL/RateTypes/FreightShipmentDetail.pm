package Shipment::FedEx::WSDL::RateTypes::FreightShipmentDetail;
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

my %FedExFreightAccountNumber_of :ATTR(:get<FedExFreightAccountNumber>);
my %FedExFreightBillingContactAndAddress_of :ATTR(:get<FedExFreightBillingContactAndAddress>);
my %FedExNationalFreightAccountNumber_of :ATTR(:get<FedExNationalFreightAccountNumber>);
my %FedExNationalFreightBillingContactAndAddress_of :ATTR(:get<FedExNationalFreightBillingContactAndAddress>);
my %Role_of :ATTR(:get<Role>);
my %PaymentType_of :ATTR(:get<PaymentType>);
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
my %LineItems_of :ATTR(:get<LineItems>);

__PACKAGE__->_factory(
    [ qw(        FedExFreightAccountNumber
        FedExFreightBillingContactAndAddress
        FedExNationalFreightAccountNumber
        FedExNationalFreightBillingContactAndAddress
        Role
        PaymentType
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
        LineItems

    ) ],
    {
        'FedExFreightAccountNumber' => \%FedExFreightAccountNumber_of,
        'FedExFreightBillingContactAndAddress' => \%FedExFreightBillingContactAndAddress_of,
        'FedExNationalFreightAccountNumber' => \%FedExNationalFreightAccountNumber_of,
        'FedExNationalFreightBillingContactAndAddress' => \%FedExNationalFreightBillingContactAndAddress_of,
        'Role' => \%Role_of,
        'PaymentType' => \%PaymentType_of,
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
        'LineItems' => \%LineItems_of,
    },
    {
        'FedExFreightAccountNumber' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'FedExFreightBillingContactAndAddress' => 'Shipment::FedEx::WSDL::RateTypes::ContactAndAddress',
        'FedExNationalFreightAccountNumber' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'FedExNationalFreightBillingContactAndAddress' => 'Shipment::FedEx::WSDL::RateTypes::ContactAndAddress',
        'Role' => 'Shipment::FedEx::WSDL::RateTypes::FreightShipmentRoleType',
        'PaymentType' => 'Shipment::FedEx::WSDL::RateTypes::FreightAccountPaymentType',
        'DeclaredValuePerUnit' => 'Shipment::FedEx::WSDL::RateTypes::Money',
        'DeclaredValueUnits' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'LiabilityCoverageDetail' => 'Shipment::FedEx::WSDL::RateTypes::LiabilityCoverageDetail',
        'Coupons' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'TotalHandlingUnits' => 'SOAP::WSDL::XSD::Typelib::Builtin::nonNegativeInteger',
        'ClientDiscountPercent' => 'SOAP::WSDL::XSD::Typelib::Builtin::decimal',
        'PalletWeight' => 'Shipment::FedEx::WSDL::RateTypes::Weight',
        'ShipmentDimensions' => 'Shipment::FedEx::WSDL::RateTypes::Dimensions',
        'Comment' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'SpecialServicePayments' => 'Shipment::FedEx::WSDL::RateTypes::FreightSpecialServicePayment',
        'LineItems' => 'Shipment::FedEx::WSDL::RateTypes::FreightShipmentLineItem',
    },
    {

        'FedExFreightAccountNumber' => 'FedExFreightAccountNumber',
        'FedExFreightBillingContactAndAddress' => 'FedExFreightBillingContactAndAddress',
        'FedExNationalFreightAccountNumber' => 'FedExNationalFreightAccountNumber',
        'FedExNationalFreightBillingContactAndAddress' => 'FedExNationalFreightBillingContactAndAddress',
        'Role' => 'Role',
        'PaymentType' => 'PaymentType',
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
        'LineItems' => 'LineItems',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::FedEx::WSDL::RateTypes::FreightShipmentDetail

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
FreightShipmentDetail from the namespace http://fedex.com/ws/rate/v9.

Data applicable to shipments using FEDEX_FREIGHT and FEDEX_NATIONAL_FREIGHT services.




=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * FedExFreightAccountNumber (min/maxOccurs: 0/1)


=item * FedExFreightBillingContactAndAddress (min/maxOccurs: 0/1)


=item * FedExNationalFreightAccountNumber (min/maxOccurs: 0/1)


=item * FedExNationalFreightBillingContactAndAddress (min/maxOccurs: 0/1)


=item * Role (min/maxOccurs: 0/1)


=item * PaymentType (min/maxOccurs: 0/1)


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


=item * LineItems (min/maxOccurs: 0/unbounded)




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::FedEx::WSDL::RateTypes::FreightShipmentDetail
   FedExFreightAccountNumber =>  $some_value, # string
   FedExFreightBillingContactAndAddress =>  { # Shipment::FedEx::WSDL::RateTypes::ContactAndAddress
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
   FedExNationalFreightAccountNumber =>  $some_value, # string
   FedExNationalFreightBillingContactAndAddress => {}, # Shipment::FedEx::WSDL::RateTypes::ContactAndAddress
   Role => $some_value, # FreightShipmentRoleType
   PaymentType => $some_value, # FreightAccountPaymentType
   DeclaredValuePerUnit =>  { # Shipment::FedEx::WSDL::RateTypes::Money
     Currency =>  $some_value, # string
     Amount =>  $some_value, # decimal
   },
   DeclaredValueUnits =>  $some_value, # string
   LiabilityCoverageDetail =>  { # Shipment::FedEx::WSDL::RateTypes::LiabilityCoverageDetail
     CoverageType => $some_value, # LiabilityCoverageType
     CoverageAmount => {}, # Shipment::FedEx::WSDL::RateTypes::Money
   },
   Coupons =>  $some_value, # string
   TotalHandlingUnits =>  $some_value, # nonNegativeInteger
   ClientDiscountPercent =>  $some_value, # decimal
   PalletWeight =>  { # Shipment::FedEx::WSDL::RateTypes::Weight
     Units => $some_value, # WeightUnits
     Value =>  $some_value, # decimal
   },
   ShipmentDimensions =>  { # Shipment::FedEx::WSDL::RateTypes::Dimensions
     Length => $some_value, # atomic
     Width => $some_value, # atomic
     Height => $some_value, # atomic
     Units => $some_value, # LinearUnits
   },
   Comment =>  $some_value, # string
   SpecialServicePayments =>  { # Shipment::FedEx::WSDL::RateTypes::FreightSpecialServicePayment
     SpecialService => $some_value, # ShipmentSpecialServiceType
     PaymentType => $some_value, # FreightAccountPaymentType
   },
   LineItems =>  { # Shipment::FedEx::WSDL::RateTypes::FreightShipmentLineItem
     FreightClass => $some_value, # FreightClassType
     Packaging => $some_value, # PhysicalPackagingType
     Description =>  $some_value, # string
     Weight => {}, # Shipment::FedEx::WSDL::RateTypes::Weight
     Dimensions => {}, # Shipment::FedEx::WSDL::RateTypes::Dimensions
     Volume =>  { # Shipment::FedEx::WSDL::RateTypes::Volume
       Units => $some_value, # VolumeUnits
       Value =>  $some_value, # decimal
     },
   },
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

