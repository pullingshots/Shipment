
package Shipment::UPS::WSDL::RateElements::RateRequest;
use strict;
use warnings;

{ # BLOCK to scope variables

sub get_xmlns { 'http://www.ups.com/XMLSchema/XOLTWS/Rate/v1.1' }

__PACKAGE__->__set_name('RateRequest');
__PACKAGE__->__set_nillable();
__PACKAGE__->__set_minOccurs();
__PACKAGE__->__set_maxOccurs();
__PACKAGE__->__set_ref();

use base qw(
    SOAP::WSDL::XSD::Typelib::Element
    SOAP::WSDL::XSD::Typelib::ComplexType
);

our $XML_ATTRIBUTE_CLASS;
undef $XML_ATTRIBUTE_CLASS;

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}

use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %Request_of :ATTR(:get<Request>);
my %PickupType_of :ATTR(:get<PickupType>);
my %CustomerClassification_of :ATTR(:get<CustomerClassification>);
my %Shipment_of :ATTR(:get<Shipment>);

__PACKAGE__->_factory(
    [ qw(        Request
        PickupType
        CustomerClassification
        Shipment

    ) ],
    {
        'Request' => \%Request_of,
        'PickupType' => \%PickupType_of,
        'CustomerClassification' => \%CustomerClassification_of,
        'Shipment' => \%Shipment_of,
    },
    {
        'Request' => 'Shipment::UPS::WSDL::RateElements::Request',

        'PickupType' => 'Shipment::UPS::WSDL::RateTypes::CodeDescriptionType',
        'CustomerClassification' => 'Shipment::UPS::WSDL::RateTypes::CodeDescriptionType',
        'Shipment' => 'Shipment::UPS::WSDL::RateTypes::ShipmentType',
    },
    {

        'Request' => '',
        'PickupType' => 'PickupType',
        'CustomerClassification' => 'CustomerClassification',
        'Shipment' => 'Shipment',
    }
);

} # end BLOCK






} # end of BLOCK



1;


=pod

=head1 NAME

Shipment::UPS::WSDL::RateElements::RateRequest

=head1 DESCRIPTION

Perl data type class for the XML Schema defined element
RateRequest from the namespace http://www.ups.com/XMLSchema/XOLTWS/Rate/v1.1.







=head1 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * Request

 $element->set_Request($data);
 $element->get_Request();


Note: The name of this property has been altered, because it didn't match
perl's notion of variable/subroutine names. The altered name is used in
perl code only, XML output uses the original name:

 



=item * PickupType

 $element->set_PickupType($data);
 $element->get_PickupType();




=item * CustomerClassification

 $element->set_CustomerClassification($data);
 $element->get_CustomerClassification();




=item * Shipment

 $element->set_Shipment($data);
 $element->get_Shipment();





=back


=head1 METHODS

=head2 new

 my $element = Shipment::UPS::WSDL::RateElements::RateRequest->new($data);

Constructor. The following data structure may be passed to new():

 {
   Request =>  { # Shipment::UPS::WSDL::RateTypes::RequestType
     RequestOption =>  $some_value, # string
     TransactionReference =>  { # Shipment::UPS::WSDL::RateTypes::TransactionReferenceType
       CustomerContext =>  $some_value, # string
       TransactionIdentifier =>  $some_value, # string
     },
   },
   PickupType =>  { # Shipment::UPS::WSDL::RateTypes::CodeDescriptionType
     Code =>  $some_value, # string
     Description =>  $some_value, # string
   },
   CustomerClassification =>  { # Shipment::UPS::WSDL::RateTypes::CodeDescriptionType
     Code =>  $some_value, # string
     Description =>  $some_value, # string
   },
   Shipment =>  { # Shipment::UPS::WSDL::RateTypes::ShipmentType
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
 },

=head1 AUTHOR

Generated by SOAP::WSDL

=cut

