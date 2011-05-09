package Shipment::FedEx::WSDL::RateTypes::CustomsClearanceDetail;
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

my %Broker_of :ATTR(:get<Broker>);
my %ClearanceBrokerage_of :ATTR(:get<ClearanceBrokerage>);
my %ImporterOfRecord_of :ATTR(:get<ImporterOfRecord>);
my %RecipientCustomsId_of :ATTR(:get<RecipientCustomsId>);
my %DutiesPayment_of :ATTR(:get<DutiesPayment>);
my %DocumentContent_of :ATTR(:get<DocumentContent>);
my %CustomsValue_of :ATTR(:get<CustomsValue>);
my %FreightOnValue_of :ATTR(:get<FreightOnValue>);
my %InsuranceCharges_of :ATTR(:get<InsuranceCharges>);
my %PartiesToTransactionAreRelated_of :ATTR(:get<PartiesToTransactionAreRelated>);
my %CommercialInvoice_of :ATTR(:get<CommercialInvoice>);
my %Commodities_of :ATTR(:get<Commodities>);
my %ExportDetail_of :ATTR(:get<ExportDetail>);
my %RegulatoryControls_of :ATTR(:get<RegulatoryControls>);

__PACKAGE__->_factory(
    [ qw(        Broker
        ClearanceBrokerage
        ImporterOfRecord
        RecipientCustomsId
        DutiesPayment
        DocumentContent
        CustomsValue
        FreightOnValue
        InsuranceCharges
        PartiesToTransactionAreRelated
        CommercialInvoice
        Commodities
        ExportDetail
        RegulatoryControls

    ) ],
    {
        'Broker' => \%Broker_of,
        'ClearanceBrokerage' => \%ClearanceBrokerage_of,
        'ImporterOfRecord' => \%ImporterOfRecord_of,
        'RecipientCustomsId' => \%RecipientCustomsId_of,
        'DutiesPayment' => \%DutiesPayment_of,
        'DocumentContent' => \%DocumentContent_of,
        'CustomsValue' => \%CustomsValue_of,
        'FreightOnValue' => \%FreightOnValue_of,
        'InsuranceCharges' => \%InsuranceCharges_of,
        'PartiesToTransactionAreRelated' => \%PartiesToTransactionAreRelated_of,
        'CommercialInvoice' => \%CommercialInvoice_of,
        'Commodities' => \%Commodities_of,
        'ExportDetail' => \%ExportDetail_of,
        'RegulatoryControls' => \%RegulatoryControls_of,
    },
    {
        'Broker' => 'Shipment::FedEx::WSDL::RateTypes::Party',
        'ClearanceBrokerage' => 'Shipment::FedEx::WSDL::RateTypes::ClearanceBrokerageType',
        'ImporterOfRecord' => 'Shipment::FedEx::WSDL::RateTypes::Party',
        'RecipientCustomsId' => 'Shipment::FedEx::WSDL::RateTypes::RecipientCustomsId',
        'DutiesPayment' => 'Shipment::FedEx::WSDL::RateTypes::Payment',
        'DocumentContent' => 'Shipment::FedEx::WSDL::RateTypes::InternationalDocumentContentType',
        'CustomsValue' => 'Shipment::FedEx::WSDL::RateTypes::Money',
        'FreightOnValue' => 'Shipment::FedEx::WSDL::RateTypes::FreightOnValueType',
        'InsuranceCharges' => 'Shipment::FedEx::WSDL::RateTypes::Money',
        'PartiesToTransactionAreRelated' => 'SOAP::WSDL::XSD::Typelib::Builtin::boolean',
        'CommercialInvoice' => 'Shipment::FedEx::WSDL::RateTypes::CommercialInvoice',
        'Commodities' => 'Shipment::FedEx::WSDL::RateTypes::Commodity',
        'ExportDetail' => 'Shipment::FedEx::WSDL::RateTypes::ExportDetail',
        'RegulatoryControls' => 'Shipment::FedEx::WSDL::RateTypes::RegulatoryControlType',
    },
    {

        'Broker' => 'Broker',
        'ClearanceBrokerage' => 'ClearanceBrokerage',
        'ImporterOfRecord' => 'ImporterOfRecord',
        'RecipientCustomsId' => 'RecipientCustomsId',
        'DutiesPayment' => 'DutiesPayment',
        'DocumentContent' => 'DocumentContent',
        'CustomsValue' => 'CustomsValue',
        'FreightOnValue' => 'FreightOnValue',
        'InsuranceCharges' => 'InsuranceCharges',
        'PartiesToTransactionAreRelated' => 'PartiesToTransactionAreRelated',
        'CommercialInvoice' => 'CommercialInvoice',
        'Commodities' => 'Commodities',
        'ExportDetail' => 'ExportDetail',
        'RegulatoryControls' => 'RegulatoryControls',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::FedEx::WSDL::RateTypes::CustomsClearanceDetail

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
CustomsClearanceDetail from the namespace http://fedex.com/ws/rate/v9.






=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * Broker (min/maxOccurs: 0/1)


=item * ClearanceBrokerage (min/maxOccurs: 0/1)


=item * ImporterOfRecord (min/maxOccurs: 0/1)


=item * RecipientCustomsId (min/maxOccurs: 0/1)


=item * DutiesPayment (min/maxOccurs: 0/1)


=item * DocumentContent (min/maxOccurs: 0/1)


=item * CustomsValue (min/maxOccurs: 0/1)


=item * FreightOnValue (min/maxOccurs: 0/1)


=item * InsuranceCharges (min/maxOccurs: 0/1)


=item * PartiesToTransactionAreRelated (min/maxOccurs: 0/1)


=item * CommercialInvoice (min/maxOccurs: 0/1)


=item * Commodities (min/maxOccurs: 0/99)


=item * ExportDetail (min/maxOccurs: 0/1)


=item * RegulatoryControls (min/maxOccurs: 0/unbounded)




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::FedEx::WSDL::RateTypes::CustomsClearanceDetail
   Broker =>  { # Shipment::FedEx::WSDL::RateTypes::Party
     AccountNumber =>  $some_value, # string
     Tins =>  { # Shipment::FedEx::WSDL::RateTypes::TaxpayerIdentification
       TinType => $some_value, # TinType
       Number =>  $some_value, # string
       Usage =>  $some_value, # string
     },
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
   ClearanceBrokerage => $some_value, # ClearanceBrokerageType
   ImporterOfRecord => {}, # Shipment::FedEx::WSDL::RateTypes::Party
   RecipientCustomsId =>  { # Shipment::FedEx::WSDL::RateTypes::RecipientCustomsId
     Type => $some_value, # RecipientCustomsIdType
     Value =>  $some_value, # string
   },
   DutiesPayment =>  { # Shipment::FedEx::WSDL::RateTypes::Payment
     PaymentType => $some_value, # PaymentType
     Payor =>  { # Shipment::FedEx::WSDL::RateTypes::Payor
       AccountNumber =>  $some_value, # string
       CountryCode =>  $some_value, # string
     },
   },
   DocumentContent => $some_value, # InternationalDocumentContentType
   CustomsValue =>  { # Shipment::FedEx::WSDL::RateTypes::Money
     Currency =>  $some_value, # string
     Amount =>  $some_value, # decimal
   },
   FreightOnValue => $some_value, # FreightOnValueType
   InsuranceCharges => {}, # Shipment::FedEx::WSDL::RateTypes::Money
   PartiesToTransactionAreRelated =>  $some_value, # boolean
   CommercialInvoice =>  { # Shipment::FedEx::WSDL::RateTypes::CommercialInvoice
     Comments =>  $some_value, # string
     FreightCharge => {}, # Shipment::FedEx::WSDL::RateTypes::Money
     TaxesOrMiscellaneousCharge => {}, # Shipment::FedEx::WSDL::RateTypes::Money
     PackingCosts => {}, # Shipment::FedEx::WSDL::RateTypes::Money
     HandlingCosts => {}, # Shipment::FedEx::WSDL::RateTypes::Money
     SpecialInstructions =>  $some_value, # string
     DeclarationStatment =>  $some_value, # string
     PaymentTerms =>  $some_value, # string
     Purpose => $some_value, # PurposeOfShipmentType
     PurposeOfShipmentDescription =>  $some_value, # string
     CustomerInvoiceNumber =>  $some_value, # string
     OriginatorName =>  $some_value, # string
     TermsOfSale => $some_value, # TermsOfSaleType
   },
   Commodities =>  { # Shipment::FedEx::WSDL::RateTypes::Commodity
     Name =>  $some_value, # string
     NumberOfPieces =>  $some_value, # nonNegativeInteger
     Description =>  $some_value, # string
     CountryOfManufacture =>  $some_value, # string
     HarmonizedCode =>  $some_value, # string
     Weight =>  { # Shipment::FedEx::WSDL::RateTypes::Weight
       Units => $some_value, # WeightUnits
       Value =>  $some_value, # decimal
     },
     Quantity =>  $some_value, # nonNegativeInteger
     QuantityUnits =>  $some_value, # string
     AdditionalMeasures =>  { # Shipment::FedEx::WSDL::RateTypes::Measure
       Quantity =>  $some_value, # decimal
       Units =>  $some_value, # string
     },
     UnitPrice => {}, # Shipment::FedEx::WSDL::RateTypes::Money
     CustomsValue => {}, # Shipment::FedEx::WSDL::RateTypes::Money
     ExciseConditions =>  { # Shipment::FedEx::WSDL::RateTypes::EdtExciseCondition
       Category =>  $some_value, # string
       Value =>  $some_value, # string
     },
     ExportLicenseNumber =>  $some_value, # string
     ExportLicenseExpirationDate =>  $some_value, # date
     CIMarksAndNumbers =>  $some_value, # string
     NaftaDetail =>  { # Shipment::FedEx::WSDL::RateTypes::NaftaCommodityDetail
       PreferenceCriterion => $some_value, # NaftaPreferenceCriterionCode
       ProducerDetermination => $some_value, # NaftaProducerDeterminationCode
       ProducerId =>  $some_value, # string
       NetCostMethod => $some_value, # NaftaNetCostMethodCode
       NetCostDateRange =>  { # Shipment::FedEx::WSDL::RateTypes::DateRange
         Begins =>  $some_value, # date
         Ends =>  $some_value, # date
       },
     },
   },
   ExportDetail =>  { # Shipment::FedEx::WSDL::RateTypes::ExportDetail
     B13AFilingOption => $some_value, # B13AFilingOptionType
     ExportComplianceStatement =>  $some_value, # string
     PermitNumber =>  $some_value, # string
     DestinationControlDetail =>  { # Shipment::FedEx::WSDL::RateTypes::DestinationControlDetail
       StatementTypes => $some_value, # DestinationControlStatementType
       DestinationCountries =>  $some_value, # string
       EndUser =>  $some_value, # string
     },
   },
   RegulatoryControls => $some_value, # RegulatoryControlType
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

