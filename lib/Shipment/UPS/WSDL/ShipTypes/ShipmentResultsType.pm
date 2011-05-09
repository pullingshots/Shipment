package Shipment::UPS::WSDL::ShipTypes::ShipmentResultsType;
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

my %ShipmentCharges_of :ATTR(:get<ShipmentCharges>);
my %NegotiatedRateCharges_of :ATTR(:get<NegotiatedRateCharges>);
my %FRSShipmentData_of :ATTR(:get<FRSShipmentData>);
my %BillingWeight_of :ATTR(:get<BillingWeight>);
my %ShipmentIdentificationNumber_of :ATTR(:get<ShipmentIdentificationNumber>);
my %ShipmentDigest_of :ATTR(:get<ShipmentDigest>);
my %PickupRequestNumber_of :ATTR(:get<PickupRequestNumber>);
my %PackageResults_of :ATTR(:get<PackageResults>);
my %ControlLogReceipt_of :ATTR(:get<ControlLogReceipt>);
my %Form_of :ATTR(:get<Form>);
my %CODTurnInPage_of :ATTR(:get<CODTurnInPage>);
my %HighValueReport_of :ATTR(:get<HighValueReport>);
my %LabelURL_of :ATTR(:get<LabelURL>);
my %LocalLanguageLabelURL_of :ATTR(:get<LocalLanguageLabelURL>);
my %ReceiptURL_of :ATTR(:get<ReceiptURL>);
my %LocalLanguageReceiptURL_of :ATTR(:get<LocalLanguageReceiptURL>);

__PACKAGE__->_factory(
    [ qw(        ShipmentCharges
        NegotiatedRateCharges
        FRSShipmentData
        BillingWeight
        ShipmentIdentificationNumber
        ShipmentDigest
        PickupRequestNumber
        PackageResults
        ControlLogReceipt
        Form
        CODTurnInPage
        HighValueReport
        LabelURL
        LocalLanguageLabelURL
        ReceiptURL
        LocalLanguageReceiptURL

    ) ],
    {
        'ShipmentCharges' => \%ShipmentCharges_of,
        'NegotiatedRateCharges' => \%NegotiatedRateCharges_of,
        'FRSShipmentData' => \%FRSShipmentData_of,
        'BillingWeight' => \%BillingWeight_of,
        'ShipmentIdentificationNumber' => \%ShipmentIdentificationNumber_of,
        'ShipmentDigest' => \%ShipmentDigest_of,
        'PickupRequestNumber' => \%PickupRequestNumber_of,
        'PackageResults' => \%PackageResults_of,
        'ControlLogReceipt' => \%ControlLogReceipt_of,
        'Form' => \%Form_of,
        'CODTurnInPage' => \%CODTurnInPage_of,
        'HighValueReport' => \%HighValueReport_of,
        'LabelURL' => \%LabelURL_of,
        'LocalLanguageLabelURL' => \%LocalLanguageLabelURL_of,
        'ReceiptURL' => \%ReceiptURL_of,
        'LocalLanguageReceiptURL' => \%LocalLanguageReceiptURL_of,
    },
    {
        'ShipmentCharges' => 'Shipment::UPS::WSDL::ShipTypes::ShipmentChargesType',
        'NegotiatedRateCharges' => 'Shipment::UPS::WSDL::ShipTypes::NegotiatedRateChargesType',
        'FRSShipmentData' => 'Shipment::UPS::WSDL::ShipTypes::FRSShipmentDataType',
        'BillingWeight' => 'Shipment::UPS::WSDL::ShipTypes::BillingWeightType',
        'ShipmentIdentificationNumber' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'ShipmentDigest' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'PickupRequestNumber' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'PackageResults' => 'Shipment::UPS::WSDL::ShipTypes::PackageResultsType',
        'ControlLogReceipt' => 'Shipment::UPS::WSDL::ShipTypes::ImageType',
        'Form' => 'Shipment::UPS::WSDL::ShipTypes::FormType',
        'CODTurnInPage' => 'Shipment::UPS::WSDL::ShipTypes::SCReportType',
        'HighValueReport' => 'Shipment::UPS::WSDL::ShipTypes::HighValueReportType',
        'LabelURL' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'LocalLanguageLabelURL' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'ReceiptURL' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'LocalLanguageReceiptURL' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    },
    {

        'ShipmentCharges' => 'ShipmentCharges',
        'NegotiatedRateCharges' => 'NegotiatedRateCharges',
        'FRSShipmentData' => 'FRSShipmentData',
        'BillingWeight' => 'BillingWeight',
        'ShipmentIdentificationNumber' => 'ShipmentIdentificationNumber',
        'ShipmentDigest' => 'ShipmentDigest',
        'PickupRequestNumber' => 'PickupRequestNumber',
        'PackageResults' => 'PackageResults',
        'ControlLogReceipt' => 'ControlLogReceipt',
        'Form' => 'Form',
        'CODTurnInPage' => 'CODTurnInPage',
        'HighValueReport' => 'HighValueReport',
        'LabelURL' => 'LabelURL',
        'LocalLanguageLabelURL' => 'LocalLanguageLabelURL',
        'ReceiptURL' => 'ReceiptURL',
        'LocalLanguageReceiptURL' => 'LocalLanguageReceiptURL',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::UPS::WSDL::ShipTypes::ShipmentResultsType

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
ShipmentResultsType from the namespace http://www.ups.com/XMLSchema/XOLTWS/Ship/v1.0.






=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * ShipmentCharges (min/maxOccurs: 0/1)


=item * NegotiatedRateCharges (min/maxOccurs: 0/1)


=item * FRSShipmentData (min/maxOccurs: 0/1)


=item * BillingWeight (min/maxOccurs: 1/1)


=item * ShipmentIdentificationNumber (min/maxOccurs: 0/1)


=item * ShipmentDigest (min/maxOccurs: 0/1)


=item * PickupRequestNumber (min/maxOccurs: 0/1)


=item * PackageResults (min/maxOccurs: 0/unbounded)


=item * ControlLogReceipt (min/maxOccurs: 0/unbounded)


=item * Form (min/maxOccurs: 0/1)


=item * CODTurnInPage (min/maxOccurs: 0/1)


=item * HighValueReport (min/maxOccurs: 0/1)


=item * LabelURL (min/maxOccurs: 0/1)


=item * LocalLanguageLabelURL (min/maxOccurs: 0/1)


=item * ReceiptURL (min/maxOccurs: 0/1)


=item * LocalLanguageReceiptURL (min/maxOccurs: 0/1)




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::UPS::WSDL::ShipTypes::ShipmentResultsType
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
     ShippingReceipt => 
 # No documentation generated for complexContent / extension yet
,
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




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

