package Shipment::UPS::WSDL::ShipTypes::PackageType;
use strict;
use warnings;


__PACKAGE__->_set_element_form_qualified(1);

sub get_xmlns { 'http://www.ups.com/XMLSchema/XOLTWS/Ship/v1.0' };

our $XML_ATTRIBUTE_CLASS;
undef $XML_ATTRIBUTE_CLASS;

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}

use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %Description_of :ATTR(:get<Description>);
my %Packaging_of :ATTR(:get<Packaging>);
my %Dimensions_of :ATTR(:get<Dimensions>);
my %PackageWeight_of :ATTR(:get<PackageWeight>);
my %LargePackageIndicator_of :ATTR(:get<LargePackageIndicator>);
my %ReferenceNumber_of :ATTR(:get<ReferenceNumber>);
my %AdditionalHandlingIndicator_of :ATTR(:get<AdditionalHandlingIndicator>);
my %PackageServiceOptions_of :ATTR(:get<PackageServiceOptions>);
my %Commodity_of :ATTR(:get<Commodity>);

__PACKAGE__->_factory(
    [ qw(        Description
        Packaging
        Dimensions
        PackageWeight
        LargePackageIndicator
        ReferenceNumber
        AdditionalHandlingIndicator
        PackageServiceOptions
        Commodity

    ) ],
    {
        'Description' => \%Description_of,
        'Packaging' => \%Packaging_of,
        'Dimensions' => \%Dimensions_of,
        'PackageWeight' => \%PackageWeight_of,
        'LargePackageIndicator' => \%LargePackageIndicator_of,
        'ReferenceNumber' => \%ReferenceNumber_of,
        'AdditionalHandlingIndicator' => \%AdditionalHandlingIndicator_of,
        'PackageServiceOptions' => \%PackageServiceOptions_of,
        'Commodity' => \%Commodity_of,
    },
    {
        'Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'Packaging' => 'Shipment::UPS::WSDL::ShipTypes::PackagingType',
        'Dimensions' => 'Shipment::UPS::WSDL::ShipTypes::DimensionsType',
        'PackageWeight' => 'Shipment::UPS::WSDL::ShipTypes::PackageWeightType',
        'LargePackageIndicator' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'ReferenceNumber' => 'Shipment::UPS::WSDL::ShipTypes::ReferenceNumberType',
        'AdditionalHandlingIndicator' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'PackageServiceOptions' => 'Shipment::UPS::WSDL::ShipTypes::PackageServiceOptionsType',
        'Commodity' => 'Shipment::UPS::WSDL::ShipTypes::CommodityType',
    },
    {

        'Description' => 'Description',
        'Packaging' => 'Packaging',
        'Dimensions' => 'Dimensions',
        'PackageWeight' => 'PackageWeight',
        'LargePackageIndicator' => 'LargePackageIndicator',
        'ReferenceNumber' => 'ReferenceNumber',
        'AdditionalHandlingIndicator' => 'AdditionalHandlingIndicator',
        'PackageServiceOptions' => 'PackageServiceOptions',
        'Commodity' => 'Commodity',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::UPS::WSDL::ShipTypes::PackageType

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
PackageType from the namespace http://www.ups.com/XMLSchema/XOLTWS/Ship/v1.0.






=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * Description (min/maxOccurs: 0/1)


=item * Packaging (min/maxOccurs: 0/1)


=item * Dimensions (min/maxOccurs: 0/1)


=item * PackageWeight (min/maxOccurs: 0/1)


=item * LargePackageIndicator (min/maxOccurs: 0/1)


=item * ReferenceNumber (min/maxOccurs: 0/2)


=item * AdditionalHandlingIndicator (min/maxOccurs: 0/1)


=item * PackageServiceOptions (min/maxOccurs: 0/1)


=item * Commodity (min/maxOccurs: 0/1)




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::UPS::WSDL::ShipTypes::PackageType
   Description =>  $some_value, # string
   Packaging =>  { # Shipment::UPS::WSDL::ShipTypes::PackagingType
     Code =>  $some_value, # string
     Description =>  $some_value, # string
   },
   Dimensions =>  { # Shipment::UPS::WSDL::ShipTypes::DimensionsType
     UnitOfMeasurement =>  { # Shipment::UPS::WSDL::ShipTypes::ShipUnitOfMeasurementType
       Code =>  $some_value, # string
       Description =>  $some_value, # string
     },
     Length =>  $some_value, # string
     Width =>  $some_value, # string
     Height =>  $some_value, # string
   },
   PackageWeight =>  { # Shipment::UPS::WSDL::ShipTypes::PackageWeightType
     UnitOfMeasurement => {}, # Shipment::UPS::WSDL::ShipTypes::ShipUnitOfMeasurementType
     Weight =>  $some_value, # string
   },
   LargePackageIndicator =>  $some_value, # string
   ReferenceNumber =>  { # Shipment::UPS::WSDL::ShipTypes::ReferenceNumberType
     BarCodeIndicator =>  $some_value, # string
     Code =>  $some_value, # string
     Value =>  $some_value, # string
   },
   AdditionalHandlingIndicator =>  $some_value, # string
   PackageServiceOptions =>  { # Shipment::UPS::WSDL::ShipTypes::PackageServiceOptionsType
     DeliveryConfirmation =>  { # Shipment::UPS::WSDL::ShipTypes::DeliveryConfirmationType
       DCISType =>  $some_value, # string
       DCISNumber =>  $some_value, # string
     },
     DeclaredValue =>  { # Shipment::UPS::WSDL::ShipTypes::PackageDeclaredValueType
       Type =>  { # Shipment::UPS::WSDL::ShipTypes::DeclaredValueType
         Code =>  $some_value, # string
         Description =>  $some_value, # string
       },
       CurrencyCode =>  $some_value, # string
       MonetaryValue =>  $some_value, # string
     },
     COD =>  { # Shipment::UPS::WSDL::ShipTypes::PSOCODType
       CODFundsCode =>  $some_value, # string
       CODAmount =>  { # Shipment::UPS::WSDL::ShipTypes::CurrencyMonetaryType
         CurrencyCode =>  $some_value, # string
         MonetaryValue =>  $some_value, # string
       },
     },
     VerbalConfirmation =>  { # Shipment::UPS::WSDL::ShipTypes::VerbalConfirmationType
       ContactInfo =>  { # Shipment::UPS::WSDL::ShipTypes::ContactInfoType
         Name =>  $some_value, # string
         Phone =>  { # Shipment::UPS::WSDL::ShipTypes::ShipPhoneType
           Number =>  $some_value, # string
           Extension =>  $some_value, # string
         },
       },
     },
     ShipperReleaseIndicator =>  $some_value, # string
     Notification =>  { # Shipment::UPS::WSDL::ShipTypes::PSONotificationType
       NotificationCode =>  $some_value, # string
       EMail =>  { # Shipment::UPS::WSDL::ShipTypes::EmailDetailsType
         EMailAddress =>  $some_value, # string
         UndeliverableEMailAddress =>  $some_value, # string
         FromEMailAddress =>  $some_value, # string
         FromName =>  $some_value, # string
         Memo =>  $some_value, # string
         Subject =>  $some_value, # string
         SubjectCode =>  $some_value, # string
       },
     },
     ReturnsFlexibleAccessIndicator =>  $some_value, # string
   },
   Commodity =>  { # Shipment::UPS::WSDL::ShipTypes::CommodityType
     FreightClass =>  $some_value, # string
     NMFC =>  { # Shipment::UPS::WSDL::ShipTypes::NMFCType
       PrimeCode =>  $some_value, # string
       SubCode =>  $some_value, # string
     },
   },
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

