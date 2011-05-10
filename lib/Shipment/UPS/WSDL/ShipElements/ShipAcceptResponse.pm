
package Shipment::UPS::WSDL::ShipElements::ShipAcceptResponse;
use strict;
use warnings;

{ # BLOCK to scope variables

sub get_xmlns { 'http://www.ups.com/XMLSchema/XOLTWS/Ship/v1.0' }

__PACKAGE__->__set_name('ShipAcceptResponse');
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

my %Response_of :ATTR(:get<Response>);
my %ShipmentResults_of :ATTR(:get<ShipmentResults>);

__PACKAGE__->_factory(
    [ qw(        Response
        ShipmentResults

    ) ],
    {
        'Response' => \%Response_of,
        'ShipmentResults' => \%ShipmentResults_of,
    },
    {
        'Response' => 'Shipment::UPS::WSDL::ShipElements::Response',

        'ShipmentResults' => 'Shipment::UPS::WSDL::ShipTypes::ShipmentResultsType',
    },
    {

        'Response' => '',
        'ShipmentResults' => 'ShipmentResults',
    }
);

} # end BLOCK






} # end of BLOCK



1;


=pod

=head1 NAME

Shipment::UPS::WSDL::ShipElements::ShipAcceptResponse

=head1 DESCRIPTION

Perl data type class for the XML Schema defined element
ShipAcceptResponse from the namespace http://www.ups.com/XMLSchema/XOLTWS/Ship/v1.0.







=head1 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * Response

 $element->set_Response($data);
 $element->get_Response();


Note: The name of this property has been altered, because it didn't match
perl's notion of variable/subroutine names. The altered name is used in
perl code only, XML output uses the original name:

 



=item * ShipmentResults

 $element->set_ShipmentResults($data);
 $element->get_ShipmentResults();





=back


=head1 METHODS

=head2 new

 my $element = Shipment::UPS::WSDL::ShipElements::ShipAcceptResponse->new($data);

Constructor. The following data structure may be passed to new():

 {
   Response =>  { # Shipment::UPS::WSDL::ShipTypes::ResponseType
     ResponseStatus =>  { # Shipment::UPS::WSDL::ShipTypes::CodeDescriptionType
       Code =>  $some_value, # string
       Description =>  $some_value, # string
     },
     Alert => {}, # Shipment::UPS::WSDL::ShipTypes::CodeDescriptionType
     TransactionReference =>  { # Shipment::UPS::WSDL::ShipTypes::TransactionReferenceType
       CustomerContext =>  $some_value, # string
       TransactionIdentifier =>  $some_value, # string
     },
   },
   ShipmentResults =>  { # Shipment::UPS::WSDL::ShipTypes::ShipmentResultsType
     ShipmentCharges =>  { # Shipment::UPS::WSDL::ShipTypes::ShipmentChargesType
       TransportationCharges =>  { # Shipment::UPS::WSDL::ShipTypes::ShipChargeType
         CurrencyCode =>  $some_value, # string
         MonetaryValue =>  $some_value, # string
       },
       ServiceOptionsCharges => {}, # Shipment::UPS::WSDL::ShipTypes::ShipChargeType
       TotalCharges => {}, # Shipment::UPS::WSDL::ShipTypes::ShipChargeType
     },
     NegotiatedRateCharges =>  { # Shipment::UPS::WSDL::ShipTypes::NegotiatedRateChargesType
       TotalCharge => {}, # Shipment::UPS::WSDL::ShipTypes::ShipChargeType
     },
     FRSShipmentData =>  { # Shipment::UPS::WSDL::ShipTypes::FRSShipmentDataType
       TransportationCharges =>  { # Shipment::UPS::WSDL::ShipTypes::TransportationChargeType
         GrossCharge => {}, # Shipment::UPS::WSDL::ShipTypes::ShipChargeType
         DiscountAmount => {}, # Shipment::UPS::WSDL::ShipTypes::ShipChargeType
         DiscountPercentage =>  $some_value, # string
         NetCharge => {}, # Shipment::UPS::WSDL::ShipTypes::ShipChargeType
       },
     },
     BillingWeight =>  { # Shipment::UPS::WSDL::ShipTypes::BillingWeightType
       UnitOfMeasurement =>  { # Shipment::UPS::WSDL::ShipTypes::BillingUnitOfMeasurementType
         Code =>  $some_value, # string
         Description =>  $some_value, # string
       },
       Weight =>  $some_value, # string
     },
     ShipmentIdentificationNumber =>  $some_value, # string
     ShipmentDigest =>  $some_value, # string
     PickupRequestNumber =>  $some_value, # string
     PackageResults =>  { # Shipment::UPS::WSDL::ShipTypes::PackageResultsType
       TrackingNumber =>  $some_value, # string
       ServiceOptionsCharges => {}, # Shipment::UPS::WSDL::ShipTypes::ShipChargeType
       ShippingLabel =>  { # Shipment::UPS::WSDL::ShipTypes::LabelType
         InternationalSignatureGraphicImage =>  $some_value, # string
         HTMLImage =>  $some_value, # string
         PDF417 =>  $some_value, # string
       },
       ShippingReceipt =>  { # Shipment::UPS::WSDL::ShipTypes::ReceiptType
       },
       USPSPICNumber =>  $some_value, # string
     },
     ControlLogReceipt =>  { # Shipment::UPS::WSDL::ShipTypes::ImageType
       ImageFormat =>  { # Shipment::UPS::WSDL::ShipTypes::ImageFormatType
         Code =>  $some_value, # string
         Description =>  $some_value, # string
       },
       GraphicImage =>  $some_value, # string
     },
     Form =>  { # Shipment::UPS::WSDL::ShipTypes::FormType
       Code =>  $some_value, # string
       Description =>  $some_value, # string
       Image =>  { # Shipment::UPS::WSDL::ShipTypes::FormImageType
         ImageFormat => {}, # Shipment::UPS::WSDL::ShipTypes::ImageFormatType
         GraphicImage =>  $some_value, # string
       },
       FormGroupId =>  $some_value, # string
       FormGroupIdName =>  $some_value, # string
     },
     CODTurnInPage =>  { # Shipment::UPS::WSDL::ShipTypes::SCReportType
       Image => {}, # Shipment::UPS::WSDL::ShipTypes::ImageType
     },
     HighValueReport =>  { # Shipment::UPS::WSDL::ShipTypes::HighValueReportType
       Image => {}, # Shipment::UPS::WSDL::ShipTypes::ImageType
     },
     LabelURL =>  $some_value, # string
     LocalLanguageLabelURL =>  $some_value, # string
     ReceiptURL =>  $some_value, # string
     LocalLanguageReceiptURL =>  $some_value, # string
   },
 },

=head1 AUTHOR

Generated by SOAP::WSDL

=cut

