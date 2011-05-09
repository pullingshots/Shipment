package Shipment::UPS::WSDL::ShipTypes::PackageServiceOptionsType;
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

my %DeliveryConfirmation_of :ATTR(:get<DeliveryConfirmation>);
my %DeclaredValue_of :ATTR(:get<DeclaredValue>);
my %COD_of :ATTR(:get<COD>);
my %VerbalConfirmation_of :ATTR(:get<VerbalConfirmation>);
my %ShipperReleaseIndicator_of :ATTR(:get<ShipperReleaseIndicator>);
my %Notification_of :ATTR(:get<Notification>);
my %ReturnsFlexibleAccessIndicator_of :ATTR(:get<ReturnsFlexibleAccessIndicator>);

__PACKAGE__->_factory(
    [ qw(        DeliveryConfirmation
        DeclaredValue
        COD
        VerbalConfirmation
        ShipperReleaseIndicator
        Notification
        ReturnsFlexibleAccessIndicator

    ) ],
    {
        'DeliveryConfirmation' => \%DeliveryConfirmation_of,
        'DeclaredValue' => \%DeclaredValue_of,
        'COD' => \%COD_of,
        'VerbalConfirmation' => \%VerbalConfirmation_of,
        'ShipperReleaseIndicator' => \%ShipperReleaseIndicator_of,
        'Notification' => \%Notification_of,
        'ReturnsFlexibleAccessIndicator' => \%ReturnsFlexibleAccessIndicator_of,
    },
    {
        'DeliveryConfirmation' => 'Shipment::UPS::WSDL::ShipTypes::DeliveryConfirmationType',
        'DeclaredValue' => 'Shipment::UPS::WSDL::ShipTypes::PackageDeclaredValueType',
        'COD' => 'Shipment::UPS::WSDL::ShipTypes::PSOCODType',
        'VerbalConfirmation' => 'Shipment::UPS::WSDL::ShipTypes::VerbalConfirmationType',
        'ShipperReleaseIndicator' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'Notification' => 'Shipment::UPS::WSDL::ShipTypes::PSONotificationType',
        'ReturnsFlexibleAccessIndicator' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    },
    {

        'DeliveryConfirmation' => 'DeliveryConfirmation',
        'DeclaredValue' => 'DeclaredValue',
        'COD' => 'COD',
        'VerbalConfirmation' => 'VerbalConfirmation',
        'ShipperReleaseIndicator' => 'ShipperReleaseIndicator',
        'Notification' => 'Notification',
        'ReturnsFlexibleAccessIndicator' => 'ReturnsFlexibleAccessIndicator',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::UPS::WSDL::ShipTypes::PackageServiceOptionsType

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
PackageServiceOptionsType from the namespace http://www.ups.com/XMLSchema/XOLTWS/Ship/v1.0.






=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * DeliveryConfirmation (min/maxOccurs: 0/1)


=item * DeclaredValue (min/maxOccurs: 0/1)


=item * COD (min/maxOccurs: 0/1)


=item * VerbalConfirmation (min/maxOccurs: 0/1)


=item * ShipperReleaseIndicator (min/maxOccurs: 0/1)


=item * Notification (min/maxOccurs: 0/1)


=item * ReturnsFlexibleAccessIndicator (min/maxOccurs: 0/1)




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::UPS::WSDL::ShipTypes::PackageServiceOptionsType
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




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

