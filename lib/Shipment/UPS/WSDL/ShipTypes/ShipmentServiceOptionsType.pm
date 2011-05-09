package Shipment::UPS::WSDL::ShipTypes::ShipmentServiceOptionsType;
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

my %SaturdayDeliveryIndicator_of :ATTR(:get<SaturdayDeliveryIndicator>);
my %OnCall_of :ATTR(:get<OnCall>);
my %COD_of :ATTR(:get<COD>);
my %Notification_of :ATTR(:get<Notification>);
my %LabelDelivery_of :ATTR(:get<LabelDelivery>);
my %InternationalForms_of :ATTR(:get<InternationalForms>);
my %DeliveryConfirmation_of :ATTR(:get<DeliveryConfirmation>);
my %ReturnOfDocumentIndicator_of :ATTR(:get<ReturnOfDocumentIndicator>);
my %ImportControlIndicator_of :ATTR(:get<ImportControlIndicator>);
my %LabelMethod_of :ATTR(:get<LabelMethod>);
my %CommercialInvoiceRemovalIndicator_of :ATTR(:get<CommercialInvoiceRemovalIndicator>);
my %UPScarbonneutralIndicator_of :ATTR(:get<UPScarbonneutralIndicator>);

__PACKAGE__->_factory(
    [ qw(        SaturdayDeliveryIndicator
        OnCall
        COD
        Notification
        LabelDelivery
        InternationalForms
        DeliveryConfirmation
        ReturnOfDocumentIndicator
        ImportControlIndicator
        LabelMethod
        CommercialInvoiceRemovalIndicator
        UPScarbonneutralIndicator

    ) ],
    {
        'SaturdayDeliveryIndicator' => \%SaturdayDeliveryIndicator_of,
        'OnCall' => \%OnCall_of,
        'COD' => \%COD_of,
        'Notification' => \%Notification_of,
        'LabelDelivery' => \%LabelDelivery_of,
        'InternationalForms' => \%InternationalForms_of,
        'DeliveryConfirmation' => \%DeliveryConfirmation_of,
        'ReturnOfDocumentIndicator' => \%ReturnOfDocumentIndicator_of,
        'ImportControlIndicator' => \%ImportControlIndicator_of,
        'LabelMethod' => \%LabelMethod_of,
        'CommercialInvoiceRemovalIndicator' => \%CommercialInvoiceRemovalIndicator_of,
        'UPScarbonneutralIndicator' => \%UPScarbonneutralIndicator_of,
    },
    {
        'SaturdayDeliveryIndicator' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'OnCall' => 'Shipment::UPS::WSDL::ShipTypes::OnCallType',
        'COD' => 'Shipment::UPS::WSDL::ShipTypes::CODType',
        'Notification' => 'Shipment::UPS::WSDL::ShipTypes::NotificationType',
        'LabelDelivery' => 'Shipment::UPS::WSDL::ShipTypes::LabelDeliveryType',
        'InternationalForms' => 'Shipment::UPS::WSDL::ShipTypes::InternationalFormType',
        'DeliveryConfirmation' => 'Shipment::UPS::WSDL::ShipTypes::DeliveryConfirmationType',
        'ReturnOfDocumentIndicator' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'ImportControlIndicator' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'LabelMethod' => 'Shipment::UPS::WSDL::ShipTypes::LabelMethodType',
        'CommercialInvoiceRemovalIndicator' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'UPScarbonneutralIndicator' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    },
    {

        'SaturdayDeliveryIndicator' => 'SaturdayDeliveryIndicator',
        'OnCall' => 'OnCall',
        'COD' => 'COD',
        'Notification' => 'Notification',
        'LabelDelivery' => 'LabelDelivery',
        'InternationalForms' => 'InternationalForms',
        'DeliveryConfirmation' => 'DeliveryConfirmation',
        'ReturnOfDocumentIndicator' => 'ReturnOfDocumentIndicator',
        'ImportControlIndicator' => 'ImportControlIndicator',
        'LabelMethod' => 'LabelMethod',
        'CommercialInvoiceRemovalIndicator' => 'CommercialInvoiceRemovalIndicator',
        'UPScarbonneutralIndicator' => 'UPScarbonneutralIndicator',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::UPS::WSDL::ShipTypes::ShipmentServiceOptionsType

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
ShipmentServiceOptionsType from the namespace http://www.ups.com/XMLSchema/XOLTWS/Ship/v1.0.






=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * SaturdayDeliveryIndicator (min/maxOccurs: 0/1)


=item * OnCall (min/maxOccurs: 0/1)


=item * COD (min/maxOccurs: 0/1)


=item * Notification (min/maxOccurs: 0/unbounded)


=item * LabelDelivery (min/maxOccurs: 0/1)


=item * InternationalForms (min/maxOccurs: 0/1)


=item * DeliveryConfirmation (min/maxOccurs: 0/1)


=item * ReturnOfDocumentIndicator (min/maxOccurs: 0/1)


=item * ImportControlIndicator (min/maxOccurs: 0/1)


=item * LabelMethod (min/maxOccurs: 0/1)


=item * CommercialInvoiceRemovalIndicator (min/maxOccurs: 0/1)


=item * UPScarbonneutralIndicator (min/maxOccurs: 0/1)




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::UPS::WSDL::ShipTypes::ShipmentServiceOptionsType
   SaturdayDeliveryIndicator =>  $some_value, # string
   OnCall =>  { # Shipment::UPS::WSDL::ShipTypes::OnCallType
     PickupDetails =>  { # Shipment::UPS::WSDL::ShipTypes::PickupDetailsType
       DistrictCode =>  $some_value, # string
       PickupDate =>  $some_value, # string
       EarliestTimeReady =>  $some_value, # string
       LatestTimeReady =>  $some_value, # string
       SuiteRoomID =>  $some_value, # string
       FloorID =>  $some_value, # string
       Location =>  $some_value, # string
       ContactInfo =>  { # Shipment::UPS::WSDL::ShipTypes::ContactInfoType
         Name =>  $some_value, # string
         Phone =>  { # Shipment::UPS::WSDL::ShipTypes::ShipPhoneType
           Number =>  $some_value, # string
           Extension =>  $some_value, # string
         },
       },
     },
   },
   COD =>  { # Shipment::UPS::WSDL::ShipTypes::CODType
     CODFundsCode =>  $some_value, # string
     CODAmount =>  { # Shipment::UPS::WSDL::ShipTypes::CurrencyMonetaryType
       CurrencyCode =>  $some_value, # string
       MonetaryValue =>  $some_value, # string
     },
   },
   Notification =>  { # Shipment::UPS::WSDL::ShipTypes::NotificationType
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
   LabelDelivery =>  { # Shipment::UPS::WSDL::ShipTypes::LabelDeliveryType
     EMail => {}, # Shipment::UPS::WSDL::ShipTypes::EmailDetailsType
     LabelLinksIndicator =>  $some_value, # string
   },
   InternationalForms =>  { # Shipment::UPS::WSDL::ShipTypes::InternationalFormType
     FormType =>  $some_value, # string
     AdditionalDocumentIndicator =>  $some_value, # string
     FormGroupIdName =>  $some_value, # string
     SEDFilingOption =>  $some_value, # string
     Contacts =>  { # Shipment::UPS::WSDL::ShipTypes::ContactType
       ForwardAgent =>  { # Shipment::UPS::WSDL::ShipTypes::ForwardAgentType
         CompanyName =>  $some_value, # string
         TaxIdentificationNumber =>  $some_value, # string
         Address =>  { # Shipment::UPS::WSDL::ShipTypes::AddressType
           AddressLine =>  $some_value, # string
           City =>  $some_value, # string
           StateProvinceCode =>  $some_value, # string
           Town =>  $some_value, # string
           PostalCode =>  $some_value, # string
           CountryCode =>  $some_value, # string
         },
       },
       UltimateConsignee =>  { # Shipment::UPS::WSDL::ShipTypes::UltimateConsigneeType
         CompanyName =>  $some_value, # string
         Address => {}, # Shipment::UPS::WSDL::ShipTypes::AddressType
       },
       IntermediateConsignee =>  { # Shipment::UPS::WSDL::ShipTypes::IntermediateConsigneeType
         CompanyName =>  $some_value, # string
         Address => {}, # Shipment::UPS::WSDL::ShipTypes::AddressType
       },
       Producer =>  { # Shipment::UPS::WSDL::ShipTypes::ProducerType
         Option =>  $some_value, # string
         CompanyName =>  $some_value, # string
         TaxIdentificationNumber =>  $some_value, # string
         Address => {}, # Shipment::UPS::WSDL::ShipTypes::AddressType
       },
       SoldTo =>  { # Shipment::UPS::WSDL::ShipTypes::SoldToType
         Option =>  $some_value, # string
         Address => {}, # Shipment::UPS::WSDL::ShipTypes::AddressType
       },
     },
     Product =>  { # Shipment::UPS::WSDL::ShipTypes::ProductType
       Description =>  $some_value, # string
       Unit =>  { # Shipment::UPS::WSDL::ShipTypes::UnitType
         Number =>  $some_value, # string
         UnitOfMeasurement =>  { # Shipment::UPS::WSDL::ShipTypes::UnitOfMeasurementType
           Code =>  $some_value, # string
           Description =>  $some_value, # string
         },
         Value =>  $some_value, # string
       },
       CommodityCode =>  $some_value, # string
       PartNumber =>  $some_value, # string
       OriginCountryCode =>  $some_value, # string
       JointProductionIndicator =>  $some_value, # string
       NetCostCode =>  $some_value, # string
       NetCostDateRange =>  { # Shipment::UPS::WSDL::ShipTypes::NetCostDateType
         BeginDate =>  $some_value, # string
         EndDate =>  $some_value, # string
       },
       PreferenceCriteria =>  $some_value, # string
       ProducerInfo =>  $some_value, # string
       MarksAndNumbers =>  $some_value, # string
       NumberOfPackagesPerCommodity =>  $some_value, # string
       ProductWeight =>  { # Shipment::UPS::WSDL::ShipTypes::ProductWeightType
         UnitOfMeasurement => {}, # Shipment::UPS::WSDL::ShipTypes::UnitOfMeasurementType
         Weight =>  $some_value, # string
       },
       VehicleID =>  $some_value, # string
       ScheduleB =>  { # Shipment::UPS::WSDL::ShipTypes::ScheduleBType
         Number =>  $some_value, # string
         Quantity =>  $some_value, # string
         UnitOfMeasurement => {}, # Shipment::UPS::WSDL::ShipTypes::UnitOfMeasurementType
       },
       ExportType =>  $some_value, # string
       SEDTotalValue =>  $some_value, # string
     },
     InvoiceNumber =>  $some_value, # string
     InvoiceDate =>  $some_value, # string
     PurchaseOrderNumber =>  $some_value, # string
     TermsOfShipment =>  $some_value, # string
     ReasonForExport =>  $some_value, # string
     Comments =>  $some_value, # string
     DeclarationStatement =>  $some_value, # string
     Discount =>  { # Shipment::UPS::WSDL::ShipTypes::IFChargesType
       MonetaryValue =>  $some_value, # string
     },
     FreightCharges => {}, # Shipment::UPS::WSDL::ShipTypes::IFChargesType
     InsuranceCharges => {}, # Shipment::UPS::WSDL::ShipTypes::IFChargesType
     OtherCharges =>  { # Shipment::UPS::WSDL::ShipTypes::OtherChargesType
       MonetaryValue =>  $some_value, # string
       Description =>  $some_value, # string
     },
     CurrencyCode =>  $some_value, # string
     BlanketPeriod =>  { # Shipment::UPS::WSDL::ShipTypes::BlanketPeriodType
       BeginDate =>  $some_value, # string
       EndDate =>  $some_value, # string
     },
     ExportDate =>  $some_value, # string
     ExportingCarrier =>  $some_value, # string
     CarrierID =>  $some_value, # string
     InBondCode =>  $some_value, # string
     EntryNumber =>  $some_value, # string
     PointOfOrigin =>  $some_value, # string
     ModeOfTransport =>  $some_value, # string
     PortOfExport =>  $some_value, # string
     PortOfUnloading =>  $some_value, # string
     LoadingPier =>  $some_value, # string
     PartiesToTransaction =>  $some_value, # string
     RoutedExportTransactionIndicator =>  $some_value, # string
     ContainerizedIndicator =>  $some_value, # string
     License =>  { # Shipment::UPS::WSDL::ShipTypes::LicenseType
       Number =>  $some_value, # string
       Date =>  $some_value, # string
       ExceptionCode =>  $some_value, # string
     },
     ECCNNumber =>  $some_value, # string
   },
   DeliveryConfirmation =>  { # Shipment::UPS::WSDL::ShipTypes::DeliveryConfirmationType
     DCISType =>  $some_value, # string
     DCISNumber =>  $some_value, # string
   },
   ReturnOfDocumentIndicator =>  $some_value, # string
   ImportControlIndicator =>  $some_value, # string
   LabelMethod =>  { # Shipment::UPS::WSDL::ShipTypes::LabelMethodType
     Code =>  $some_value, # string
     Description =>  $some_value, # string
   },
   CommercialInvoiceRemovalIndicator =>  $some_value, # string
   UPScarbonneutralIndicator =>  $some_value, # string
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

