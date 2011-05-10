package Shipment::UPS::WSDL::RateTypes::ShipmentType;
use strict;
use warnings;


__PACKAGE__->_set_element_form_qualified(1);

sub get_xmlns { 'http://www.ups.com/XMLSchema/XOLTWS/Rate/v1.1' };

our $XML_ATTRIBUTE_CLASS;
undef $XML_ATTRIBUTE_CLASS;

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}

use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %Shipper_of :ATTR(:get<Shipper>);
my %ShipTo_of :ATTR(:get<ShipTo>);
my %ShipFrom_of :ATTR(:get<ShipFrom>);
my %FRSPaymentInformation_of :ATTR(:get<FRSPaymentInformation>);
my %Service_of :ATTR(:get<Service>);
my %DocumentsOnlyIndicator_of :ATTR(:get<DocumentsOnlyIndicator>);
my %Package_of :ATTR(:get<Package>);
my %ShipmentServiceOptions_of :ATTR(:get<ShipmentServiceOptions>);
my %ShipmentRatingOptions_of :ATTR(:get<ShipmentRatingOptions>);
my %InvoiceLineTotal_of :ATTR(:get<InvoiceLineTotal>);

__PACKAGE__->_factory(
    [ qw(        Shipper
        ShipTo
        ShipFrom
        FRSPaymentInformation
        Service
        DocumentsOnlyIndicator
        Package
        ShipmentServiceOptions
        ShipmentRatingOptions
        InvoiceLineTotal

    ) ],
    {
        'Shipper' => \%Shipper_of,
        'ShipTo' => \%ShipTo_of,
        'ShipFrom' => \%ShipFrom_of,
        'FRSPaymentInformation' => \%FRSPaymentInformation_of,
        'Service' => \%Service_of,
        'DocumentsOnlyIndicator' => \%DocumentsOnlyIndicator_of,
        'Package' => \%Package_of,
        'ShipmentServiceOptions' => \%ShipmentServiceOptions_of,
        'ShipmentRatingOptions' => \%ShipmentRatingOptions_of,
        'InvoiceLineTotal' => \%InvoiceLineTotal_of,
    },
    {
        'Shipper' => 'Shipment::UPS::WSDL::RateTypes::ShipperType',
        'ShipTo' => 'Shipment::UPS::WSDL::RateTypes::ShipToType',
        'ShipFrom' => 'Shipment::UPS::WSDL::RateTypes::ShipFromType',
        'FRSPaymentInformation' => 'Shipment::UPS::WSDL::RateTypes::FRSPaymentInfoType',
        'Service' => 'Shipment::UPS::WSDL::RateTypes::CodeDescriptionType',
        'DocumentsOnlyIndicator' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'Package' => 'Shipment::UPS::WSDL::RateTypes::PackageType',
        'ShipmentServiceOptions' => 'Shipment::UPS::WSDL::RateTypes::ShipmentServiceOptionsType',
        'ShipmentRatingOptions' => 'Shipment::UPS::WSDL::RateTypes::ShipmentRatingOptionsType',
        'InvoiceLineTotal' => 'Shipment::UPS::WSDL::RateTypes::InvoiceLineTotalType',
    },
    {

        'Shipper' => 'Shipper',
        'ShipTo' => 'ShipTo',
        'ShipFrom' => 'ShipFrom',
        'FRSPaymentInformation' => 'FRSPaymentInformation',
        'Service' => 'Service',
        'DocumentsOnlyIndicator' => 'DocumentsOnlyIndicator',
        'Package' => 'Package',
        'ShipmentServiceOptions' => 'ShipmentServiceOptions',
        'ShipmentRatingOptions' => 'ShipmentRatingOptions',
        'InvoiceLineTotal' => 'InvoiceLineTotal',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::UPS::WSDL::RateTypes::ShipmentType

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
ShipmentType from the namespace http://www.ups.com/XMLSchema/XOLTWS/Rate/v1.1.






=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * Shipper (min/maxOccurs: 1/1)


=item * ShipTo (min/maxOccurs: 1/1)


=item * ShipFrom (min/maxOccurs: 0/1)


=item * FRSPaymentInformation (min/maxOccurs: 0/1)


=item * Service (min/maxOccurs: 0/1)


=item * DocumentsOnlyIndicator (min/maxOccurs: 0/1)


=item * Package (min/maxOccurs: 1/unbounded)


=item * ShipmentServiceOptions (min/maxOccurs: 0/1)


=item * ShipmentRatingOptions (min/maxOccurs: 0/1)


=item * InvoiceLineTotal (min/maxOccurs: 0/1)




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::UPS::WSDL::RateTypes::ShipmentType
   Shipper =>  { # Shipment::UPS::WSDL::RateTypes::ShipperType
     Name =>  $some_value, # string
     ShipperNumber =>  $some_value, # string
     Address =>  { # Shipment::UPS::WSDL::RateTypes::AddressType
       AddressLine =>  $some_value, # string
       City =>  $some_value, # string
       StateProvinceCode =>  $some_value, # string
       PostalCode =>  $some_value, # string
       CountryCode =>  $some_value, # string
     },
   },
   ShipTo =>  { # Shipment::UPS::WSDL::RateTypes::ShipToType
     Name =>  $some_value, # string
     Address =>  { # Shipment::UPS::WSDL::RateTypes::ShipToAddressType
       ResidentialAddressIndicator =>  $some_value, # string
     },
   },
   ShipFrom =>  { # Shipment::UPS::WSDL::RateTypes::ShipFromType
     Name =>  $some_value, # string
     Address => {}, # Shipment::UPS::WSDL::RateTypes::AddressType
   },
   FRSPaymentInformation =>  { # Shipment::UPS::WSDL::RateTypes::FRSPaymentInfoType
     Type =>  { # Shipment::UPS::WSDL::RateTypes::CodeDescriptionType
       Code =>  $some_value, # string
       Description =>  $some_value, # string
     },
     AccountNumber =>  $some_value, # string
     Address =>  { # Shipment::UPS::WSDL::RateTypes::PayerAddressType
       PostalCode =>  $some_value, # string
       CountryCode =>  $some_value, # string
     },
   },
   Service => {}, # Shipment::UPS::WSDL::RateTypes::CodeDescriptionType
   DocumentsOnlyIndicator =>  $some_value, # string
   Package =>  { # Shipment::UPS::WSDL::RateTypes::PackageType
     PackagingType => {}, # Shipment::UPS::WSDL::RateTypes::CodeDescriptionType
     Dimensions =>  { # Shipment::UPS::WSDL::RateTypes::DimensionsType
       UnitOfMeasurement => {}, # Shipment::UPS::WSDL::RateTypes::CodeDescriptionType
       Length =>  $some_value, # string
       Width =>  $some_value, # string
       Height =>  $some_value, # string
     },
     PackageWeight =>  { # Shipment::UPS::WSDL::RateTypes::PackageWeightType
       UnitOfMeasurement => {}, # Shipment::UPS::WSDL::RateTypes::CodeDescriptionType
       Weight =>  $some_value, # string
     },
     Commodity =>  { # Shipment::UPS::WSDL::RateTypes::CommodityType
       FreightClass =>  $some_value, # string
       NMFC =>  { # Shipment::UPS::WSDL::RateTypes::NMFCCommodityType
         PrimeCode =>  $some_value, # string
         SubCode =>  $some_value, # string
       },
     },
     LargePackageIndicator =>  $some_value, # string
     PackageServiceOptions =>  { # Shipment::UPS::WSDL::RateTypes::PackageServiceOptionsType
       DeliveryConfirmation =>  { # Shipment::UPS::WSDL::RateTypes::DeliveryConfirmationType
         DCISType =>  $some_value, # string
       },
       COD =>  { # Shipment::UPS::WSDL::RateTypes::CODType
         CODFundsCode =>  $some_value, # string
         CODAmount =>  { # Shipment::UPS::WSDL::RateTypes::CODAmountType
           CurrencyCode =>  $some_value, # string
           MonetaryValue =>  $some_value, # string
         },
       },
       DeclaredValue =>  { # Shipment::UPS::WSDL::RateTypes::InsuredValueType
         CurrencyCode =>  $some_value, # string
         MonetaryValue =>  $some_value, # string
       },
       VerbalConfirmationIndicator =>  $some_value, # string
     },
     AdditionalHandlingIndicator =>  $some_value, # string
   },
   ShipmentServiceOptions =>  { # Shipment::UPS::WSDL::RateTypes::ShipmentServiceOptionsType
     SaturdayPickupIndicator =>  $some_value, # string
     SaturdayDeliveryIndicator =>  $some_value, # string
     OnCallPickup =>  { # Shipment::UPS::WSDL::RateTypes::OnCallPickupType
       Schedule =>  { # Shipment::UPS::WSDL::RateTypes::ScheduleType
         PickupDay =>  $some_value, # string
         Method =>  $some_value, # string
       },
     },
     COD => {}, # Shipment::UPS::WSDL::RateTypes::CODType
     DeliveryConfirmation => {}, # Shipment::UPS::WSDL::RateTypes::DeliveryConfirmationType
     ReturnOfDocumentIndicator =>  $some_value, # string
     UPScarbonneutralIndicator =>  $some_value, # string
   },
   ShipmentRatingOptions =>  { # Shipment::UPS::WSDL::RateTypes::ShipmentRatingOptionsType
     NegotiatedRatesIndicator =>  $some_value, # string
     FRSShipmentIndicator =>  $some_value, # string
   },
   InvoiceLineTotal =>  { # Shipment::UPS::WSDL::RateTypes::InvoiceLineTotalType
     CurrencyCode =>  $some_value, # string
     MonetaryValue =>  $some_value, # string
   },
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

