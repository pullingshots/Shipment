package Shipment::UPS::WSDL::ShipTypes::InternationalFormType;
use strict;
use warnings;


__PACKAGE__->_set_element_form_qualified(1);

sub get_xmlns { 'http://www.ups.com/XMLSchema/XOLTWS/IF/v1.0' };

our $XML_ATTRIBUTE_CLASS;
undef $XML_ATTRIBUTE_CLASS;

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}

use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %FormType_of :ATTR(:get<FormType>);
my %AdditionalDocumentIndicator_of :ATTR(:get<AdditionalDocumentIndicator>);
my %FormGroupIdName_of :ATTR(:get<FormGroupIdName>);
my %SEDFilingOption_of :ATTR(:get<SEDFilingOption>);
my %Contacts_of :ATTR(:get<Contacts>);
my %Product_of :ATTR(:get<Product>);
my %InvoiceNumber_of :ATTR(:get<InvoiceNumber>);
my %InvoiceDate_of :ATTR(:get<InvoiceDate>);
my %PurchaseOrderNumber_of :ATTR(:get<PurchaseOrderNumber>);
my %TermsOfShipment_of :ATTR(:get<TermsOfShipment>);
my %ReasonForExport_of :ATTR(:get<ReasonForExport>);
my %Comments_of :ATTR(:get<Comments>);
my %DeclarationStatement_of :ATTR(:get<DeclarationStatement>);
my %Discount_of :ATTR(:get<Discount>);
my %FreightCharges_of :ATTR(:get<FreightCharges>);
my %InsuranceCharges_of :ATTR(:get<InsuranceCharges>);
my %OtherCharges_of :ATTR(:get<OtherCharges>);
my %CurrencyCode_of :ATTR(:get<CurrencyCode>);
my %BlanketPeriod_of :ATTR(:get<BlanketPeriod>);
my %ExportDate_of :ATTR(:get<ExportDate>);
my %ExportingCarrier_of :ATTR(:get<ExportingCarrier>);
my %CarrierID_of :ATTR(:get<CarrierID>);
my %InBondCode_of :ATTR(:get<InBondCode>);
my %EntryNumber_of :ATTR(:get<EntryNumber>);
my %PointOfOrigin_of :ATTR(:get<PointOfOrigin>);
my %ModeOfTransport_of :ATTR(:get<ModeOfTransport>);
my %PortOfExport_of :ATTR(:get<PortOfExport>);
my %PortOfUnloading_of :ATTR(:get<PortOfUnloading>);
my %LoadingPier_of :ATTR(:get<LoadingPier>);
my %PartiesToTransaction_of :ATTR(:get<PartiesToTransaction>);
my %RoutedExportTransactionIndicator_of :ATTR(:get<RoutedExportTransactionIndicator>);
my %ContainerizedIndicator_of :ATTR(:get<ContainerizedIndicator>);
my %License_of :ATTR(:get<License>);
my %ECCNNumber_of :ATTR(:get<ECCNNumber>);

__PACKAGE__->_factory(
    [ qw(        FormType
        AdditionalDocumentIndicator
        FormGroupIdName
        SEDFilingOption
        Contacts
        Product
        InvoiceNumber
        InvoiceDate
        PurchaseOrderNumber
        TermsOfShipment
        ReasonForExport
        Comments
        DeclarationStatement
        Discount
        FreightCharges
        InsuranceCharges
        OtherCharges
        CurrencyCode
        BlanketPeriod
        ExportDate
        ExportingCarrier
        CarrierID
        InBondCode
        EntryNumber
        PointOfOrigin
        ModeOfTransport
        PortOfExport
        PortOfUnloading
        LoadingPier
        PartiesToTransaction
        RoutedExportTransactionIndicator
        ContainerizedIndicator
        License
        ECCNNumber

    ) ],
    {
        'FormType' => \%FormType_of,
        'AdditionalDocumentIndicator' => \%AdditionalDocumentIndicator_of,
        'FormGroupIdName' => \%FormGroupIdName_of,
        'SEDFilingOption' => \%SEDFilingOption_of,
        'Contacts' => \%Contacts_of,
        'Product' => \%Product_of,
        'InvoiceNumber' => \%InvoiceNumber_of,
        'InvoiceDate' => \%InvoiceDate_of,
        'PurchaseOrderNumber' => \%PurchaseOrderNumber_of,
        'TermsOfShipment' => \%TermsOfShipment_of,
        'ReasonForExport' => \%ReasonForExport_of,
        'Comments' => \%Comments_of,
        'DeclarationStatement' => \%DeclarationStatement_of,
        'Discount' => \%Discount_of,
        'FreightCharges' => \%FreightCharges_of,
        'InsuranceCharges' => \%InsuranceCharges_of,
        'OtherCharges' => \%OtherCharges_of,
        'CurrencyCode' => \%CurrencyCode_of,
        'BlanketPeriod' => \%BlanketPeriod_of,
        'ExportDate' => \%ExportDate_of,
        'ExportingCarrier' => \%ExportingCarrier_of,
        'CarrierID' => \%CarrierID_of,
        'InBondCode' => \%InBondCode_of,
        'EntryNumber' => \%EntryNumber_of,
        'PointOfOrigin' => \%PointOfOrigin_of,
        'ModeOfTransport' => \%ModeOfTransport_of,
        'PortOfExport' => \%PortOfExport_of,
        'PortOfUnloading' => \%PortOfUnloading_of,
        'LoadingPier' => \%LoadingPier_of,
        'PartiesToTransaction' => \%PartiesToTransaction_of,
        'RoutedExportTransactionIndicator' => \%RoutedExportTransactionIndicator_of,
        'ContainerizedIndicator' => \%ContainerizedIndicator_of,
        'License' => \%License_of,
        'ECCNNumber' => \%ECCNNumber_of,
    },
    {
        'FormType' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'AdditionalDocumentIndicator' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'FormGroupIdName' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'SEDFilingOption' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'Contacts' => 'Shipment::UPS::WSDL::ShipTypes::ContactType',
        'Product' => 'Shipment::UPS::WSDL::ShipTypes::ProductType',
        'InvoiceNumber' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'InvoiceDate' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'PurchaseOrderNumber' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'TermsOfShipment' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'ReasonForExport' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'Comments' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'DeclarationStatement' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'Discount' => 'Shipment::UPS::WSDL::ShipTypes::IFChargesType',
        'FreightCharges' => 'Shipment::UPS::WSDL::ShipTypes::IFChargesType',
        'InsuranceCharges' => 'Shipment::UPS::WSDL::ShipTypes::IFChargesType',
        'OtherCharges' => 'Shipment::UPS::WSDL::ShipTypes::OtherChargesType',
        'CurrencyCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'BlanketPeriod' => 'Shipment::UPS::WSDL::ShipTypes::BlanketPeriodType',
        'ExportDate' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'ExportingCarrier' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'CarrierID' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'InBondCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'EntryNumber' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'PointOfOrigin' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'ModeOfTransport' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'PortOfExport' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'PortOfUnloading' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'LoadingPier' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'PartiesToTransaction' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'RoutedExportTransactionIndicator' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'ContainerizedIndicator' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'License' => 'Shipment::UPS::WSDL::ShipTypes::LicenseType',
        'ECCNNumber' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    },
    {

        'FormType' => 'FormType',
        'AdditionalDocumentIndicator' => 'AdditionalDocumentIndicator',
        'FormGroupIdName' => 'FormGroupIdName',
        'SEDFilingOption' => 'SEDFilingOption',
        'Contacts' => 'Contacts',
        'Product' => 'Product',
        'InvoiceNumber' => 'InvoiceNumber',
        'InvoiceDate' => 'InvoiceDate',
        'PurchaseOrderNumber' => 'PurchaseOrderNumber',
        'TermsOfShipment' => 'TermsOfShipment',
        'ReasonForExport' => 'ReasonForExport',
        'Comments' => 'Comments',
        'DeclarationStatement' => 'DeclarationStatement',
        'Discount' => 'Discount',
        'FreightCharges' => 'FreightCharges',
        'InsuranceCharges' => 'InsuranceCharges',
        'OtherCharges' => 'OtherCharges',
        'CurrencyCode' => 'CurrencyCode',
        'BlanketPeriod' => 'BlanketPeriod',
        'ExportDate' => 'ExportDate',
        'ExportingCarrier' => 'ExportingCarrier',
        'CarrierID' => 'CarrierID',
        'InBondCode' => 'InBondCode',
        'EntryNumber' => 'EntryNumber',
        'PointOfOrigin' => 'PointOfOrigin',
        'ModeOfTransport' => 'ModeOfTransport',
        'PortOfExport' => 'PortOfExport',
        'PortOfUnloading' => 'PortOfUnloading',
        'LoadingPier' => 'LoadingPier',
        'PartiesToTransaction' => 'PartiesToTransaction',
        'RoutedExportTransactionIndicator' => 'RoutedExportTransactionIndicator',
        'ContainerizedIndicator' => 'ContainerizedIndicator',
        'License' => 'License',
        'ECCNNumber' => 'ECCNNumber',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::UPS::WSDL::ShipTypes::InternationalFormType

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
InternationalFormType from the namespace http://www.ups.com/XMLSchema/XOLTWS/IF/v1.0.






=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * FormType (min/maxOccurs: 1/4)


=item * AdditionalDocumentIndicator (min/maxOccurs: 0/1)


=item * FormGroupIdName (min/maxOccurs: 0/1)


=item * SEDFilingOption (min/maxOccurs: 0/1)


=item * Contacts (min/maxOccurs: 0/1)


=item * Product (min/maxOccurs: 1/50)


=item * InvoiceNumber (min/maxOccurs: 0/1)


=item * InvoiceDate (min/maxOccurs: 0/1)


=item * PurchaseOrderNumber (min/maxOccurs: 0/1)


=item * TermsOfShipment (min/maxOccurs: 0/1)


=item * ReasonForExport (min/maxOccurs: 0/1)


=item * Comments (min/maxOccurs: 0/1)


=item * DeclarationStatement (min/maxOccurs: 0/1)


=item * Discount (min/maxOccurs: 0/1)


=item * FreightCharges (min/maxOccurs: 0/1)


=item * InsuranceCharges (min/maxOccurs: 0/1)


=item * OtherCharges (min/maxOccurs: 0/1)


=item * CurrencyCode (min/maxOccurs: 1/1)


=item * BlanketPeriod (min/maxOccurs: 0/1)


=item * ExportDate (min/maxOccurs: 0/1)


=item * ExportingCarrier (min/maxOccurs: 0/1)


=item * CarrierID (min/maxOccurs: 0/1)


=item * InBondCode (min/maxOccurs: 0/1)


=item * EntryNumber (min/maxOccurs: 0/1)


=item * PointOfOrigin (min/maxOccurs: 0/1)


=item * ModeOfTransport (min/maxOccurs: 0/1)


=item * PortOfExport (min/maxOccurs: 0/1)


=item * PortOfUnloading (min/maxOccurs: 0/1)


=item * LoadingPier (min/maxOccurs: 0/1)


=item * PartiesToTransaction (min/maxOccurs: 0/1)


=item * RoutedExportTransactionIndicator (min/maxOccurs: 0/1)


=item * ContainerizedIndicator (min/maxOccurs: 0/1)


=item * License (min/maxOccurs: 0/1)


=item * ECCNNumber (min/maxOccurs: 0/1)




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::UPS::WSDL::ShipTypes::InternationalFormType
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




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

