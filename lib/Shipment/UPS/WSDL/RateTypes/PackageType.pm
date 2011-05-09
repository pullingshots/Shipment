package Shipment::UPS::WSDL::RateTypes::PackageType;
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

my %PackagingType_of :ATTR(:get<PackagingType>);
my %Dimensions_of :ATTR(:get<Dimensions>);
my %PackageWeight_of :ATTR(:get<PackageWeight>);
my %Commodity_of :ATTR(:get<Commodity>);
my %LargePackageIndicator_of :ATTR(:get<LargePackageIndicator>);
my %PackageServiceOptions_of :ATTR(:get<PackageServiceOptions>);
my %AdditionalHandlingIndicator_of :ATTR(:get<AdditionalHandlingIndicator>);

__PACKAGE__->_factory(
    [ qw(        PackagingType
        Dimensions
        PackageWeight
        Commodity
        LargePackageIndicator
        PackageServiceOptions
        AdditionalHandlingIndicator

    ) ],
    {
        'PackagingType' => \%PackagingType_of,
        'Dimensions' => \%Dimensions_of,
        'PackageWeight' => \%PackageWeight_of,
        'Commodity' => \%Commodity_of,
        'LargePackageIndicator' => \%LargePackageIndicator_of,
        'PackageServiceOptions' => \%PackageServiceOptions_of,
        'AdditionalHandlingIndicator' => \%AdditionalHandlingIndicator_of,
    },
    {
        'PackagingType' => 'Shipment::UPS::WSDL::RateTypes::CodeDescriptionType',
        'Dimensions' => 'Shipment::UPS::WSDL::RateTypes::DimensionsType',
        'PackageWeight' => 'Shipment::UPS::WSDL::RateTypes::PackageWeightType',
        'Commodity' => 'Shipment::UPS::WSDL::RateTypes::CommodityType',
        'LargePackageIndicator' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'PackageServiceOptions' => 'Shipment::UPS::WSDL::RateTypes::PackageServiceOptionsType',
        'AdditionalHandlingIndicator' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    },
    {

        'PackagingType' => 'PackagingType',
        'Dimensions' => 'Dimensions',
        'PackageWeight' => 'PackageWeight',
        'Commodity' => 'Commodity',
        'LargePackageIndicator' => 'LargePackageIndicator',
        'PackageServiceOptions' => 'PackageServiceOptions',
        'AdditionalHandlingIndicator' => 'AdditionalHandlingIndicator',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::UPS::WSDL::RateTypes::PackageType

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
PackageType from the namespace http://www.ups.com/XMLSchema/XOLTWS/Rate/v1.1.






=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * PackagingType (min/maxOccurs: 0/1)


=item * Dimensions (min/maxOccurs: 0/1)


=item * PackageWeight (min/maxOccurs: 0/1)


=item * Commodity (min/maxOccurs: 0/1)


=item * LargePackageIndicator (min/maxOccurs: 0/1)


=item * PackageServiceOptions (min/maxOccurs: 0/1)


=item * AdditionalHandlingIndicator (min/maxOccurs: 0/1)




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::UPS::WSDL::RateTypes::PackageType
   PackagingType =>  { # Shipment::UPS::WSDL::RateTypes::CodeDescriptionType
     Code =>  $some_value, # string
     Description =>  $some_value, # string
   },
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




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

