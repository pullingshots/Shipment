package Shipment::Temando::WSDL::Types::DispatchDetails;
use strict;
use warnings;


__PACKAGE__->_set_element_form_qualified(0);

sub get_xmlns { 'http://' . $Shipment::Temando::WSDL::Interfaces::quoting_Service::quoting_port::ns_url . '/schema/2009_06/common.xsd' };

our $XML_ATTRIBUTE_CLASS;
undef $XML_ATTRIBUTE_CLASS;

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}

use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %reference_of :ATTR(:get<reference>);
my %carrierName_of :ATTR(:get<carrierName>);
my %carrierId_of :ATTR(:get<carrierId>);
my %accountNo_of :ATTR(:get<accountNo>);
my %creatorId_of :ATTR(:get<creatorId>);
my %currency_of :ATTR(:get<currency>);
my %changedCarrier_of :ATTR(:get<changedCarrier>);
my %consignmentEdited_of :ATTR(:get<consignmentEdited>);
my %consignmentNumber_of :ATTR(:get<consignmentNumber>);
my %consignmentDate_of :ATTR(:get<consignmentDate>);
my %deliveryMethod_of :ATTR(:get<deliveryMethod>);
my %rateName_of :ATTR(:get<rateName>);
my %description_of :ATTR(:get<description>);
my %distanceMeasurementType_of :ATTR(:get<distanceMeasurementType>);
my %weightMeasurementType_of :ATTR(:get<weightMeasurementType>);
my %length_of :ATTR(:get<length>);
my %width_of :ATTR(:get<width>);
my %height_of :ATTR(:get<height>);
my %actualWeight_of :ATTR(:get<actualWeight>);
my %chargeableWeight_of :ATTR(:get<chargeableWeight>);
my %actualCubic_of :ATTR(:get<actualCubic>);
my %chargeableCubic_of :ATTR(:get<chargeableCubic>);
my %actualQuantity_of :ATTR(:get<actualQuantity>);
my %chargeableQuantity_of :ATTR(:get<chargeableQuantity>);
my %basePrice_of :ATTR(:get<basePrice>);
my %surcharges_of :ATTR(:get<surcharges>);
my %tax_of :ATTR(:get<tax>);
my %totalPrice_of :ATTR(:get<totalPrice>);
my %originZoneName_of :ATTR(:get<originZoneName>);
my %originContactName_of :ATTR(:get<originContactName>);
my %originCompanyName_of :ATTR(:get<originCompanyName>);
my %originStreet_of :ATTR(:get<originStreet>);
my %originSuburb_of :ATTR(:get<originSuburb>);
my %originState_of :ATTR(:get<originState>);
my %originCode_of :ATTR(:get<originCode>);
my %originCountry_of :ATTR(:get<originCountry>);
my %originPhone1_of :ATTR(:get<originPhone1>);
my %originPhone2_of :ATTR(:get<originPhone2>);
my %originFax_of :ATTR(:get<originFax>);
my %originEmail_of :ATTR(:get<originEmail>);
my %destinationZoneName_of :ATTR(:get<destinationZoneName>);
my %destinationContactName_of :ATTR(:get<destinationContactName>);
my %destinationCompanyName_of :ATTR(:get<destinationCompanyName>);
my %destinationStreet_of :ATTR(:get<destinationStreet>);
my %destinationSuburb_of :ATTR(:get<destinationSuburb>);
my %destinationState_of :ATTR(:get<destinationState>);
my %destinationCode_of :ATTR(:get<destinationCode>);
my %destinationCountry_of :ATTR(:get<destinationCountry>);
my %destinationPhone1_of :ATTR(:get<destinationPhone1>);
my %destinationPhone2_of :ATTR(:get<destinationPhone2>);
my %destinationFax_of :ATTR(:get<destinationFax>);
my %destinationEmail_of :ATTR(:get<destinationEmail>);

__PACKAGE__->_factory(
    [ qw(        reference
        carrierName
        carrierId
        accountNo
        creatorId
        currency
        changedCarrier
        consignmentEdited
        consignmentNumber
        consignmentDate
        deliveryMethod
        rateName
        description
        distanceMeasurementType
        weightMeasurementType
        length
        width
        height
        actualWeight
        chargeableWeight
        actualCubic
        chargeableCubic
        actualQuantity
        chargeableQuantity
        basePrice
        surcharges
        tax
        totalPrice
        originZoneName
        originContactName
        originCompanyName
        originStreet
        originSuburb
        originState
        originCode
        originCountry
        originPhone1
        originPhone2
        originFax
        originEmail
        destinationZoneName
        destinationContactName
        destinationCompanyName
        destinationStreet
        destinationSuburb
        destinationState
        destinationCode
        destinationCountry
        destinationPhone1
        destinationPhone2
        destinationFax
        destinationEmail

    ) ],
    {
        'reference' => \%reference_of,
        'carrierName' => \%carrierName_of,
        'carrierId' => \%carrierId_of,
        'accountNo' => \%accountNo_of,
        'creatorId' => \%creatorId_of,
        'currency' => \%currency_of,
        'changedCarrier' => \%changedCarrier_of,
        'consignmentEdited' => \%consignmentEdited_of,
        'consignmentNumber' => \%consignmentNumber_of,
        'consignmentDate' => \%consignmentDate_of,
        'deliveryMethod' => \%deliveryMethod_of,
        'rateName' => \%rateName_of,
        'description' => \%description_of,
        'distanceMeasurementType' => \%distanceMeasurementType_of,
        'weightMeasurementType' => \%weightMeasurementType_of,
        'length' => \%length_of,
        'width' => \%width_of,
        'height' => \%height_of,
        'actualWeight' => \%actualWeight_of,
        'chargeableWeight' => \%chargeableWeight_of,
        'actualCubic' => \%actualCubic_of,
        'chargeableCubic' => \%chargeableCubic_of,
        'actualQuantity' => \%actualQuantity_of,
        'chargeableQuantity' => \%chargeableQuantity_of,
        'basePrice' => \%basePrice_of,
        'surcharges' => \%surcharges_of,
        'tax' => \%tax_of,
        'totalPrice' => \%totalPrice_of,
        'originZoneName' => \%originZoneName_of,
        'originContactName' => \%originContactName_of,
        'originCompanyName' => \%originCompanyName_of,
        'originStreet' => \%originStreet_of,
        'originSuburb' => \%originSuburb_of,
        'originState' => \%originState_of,
        'originCode' => \%originCode_of,
        'originCountry' => \%originCountry_of,
        'originPhone1' => \%originPhone1_of,
        'originPhone2' => \%originPhone2_of,
        'originFax' => \%originFax_of,
        'originEmail' => \%originEmail_of,
        'destinationZoneName' => \%destinationZoneName_of,
        'destinationContactName' => \%destinationContactName_of,
        'destinationCompanyName' => \%destinationCompanyName_of,
        'destinationStreet' => \%destinationStreet_of,
        'destinationSuburb' => \%destinationSuburb_of,
        'destinationState' => \%destinationState_of,
        'destinationCode' => \%destinationCode_of,
        'destinationCountry' => \%destinationCountry_of,
        'destinationPhone1' => \%destinationPhone1_of,
        'destinationPhone2' => \%destinationPhone2_of,
        'destinationFax' => \%destinationFax_of,
        'destinationEmail' => \%destinationEmail_of,
    },
    {
        'reference' => 'Shipment::Temando::WSDL::Types::CarrierReference',
        'carrierName' => 'Shipment::Temando::WSDL::Types::CompanyName',
        'carrierId' => 'Shipment::Temando::WSDL::Types::CarrierId',
        'accountNo' => 'Shipment::Temando::WSDL::Types::CarrierAccountNumber',
        'creatorId' => 'Shipment::Temando::WSDL::Types::CarrierCreatorId',
        'currency' => 'Shipment::Temando::WSDL::Types::CurrencyType',
        'changedCarrier' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'consignmentEdited' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'consignmentNumber' => 'Shipment::Temando::WSDL::Types::ConsignmentNumber',
        'consignmentDate' => 'Shipment::Temando::WSDL::Types::Date',
        'deliveryMethod' => 'Shipment::Temando::WSDL::Types::DeliveryMethod',
        'rateName' => 'Shipment::Temando::WSDL::Types::RateName',
        'description' => 'Shipment::Temando::WSDL::Types::ItemDescription',
        'distanceMeasurementType' => 'Shipment::Temando::WSDL::Types::DistanceMeasurementType',
        'weightMeasurementType' => 'Shipment::Temando::WSDL::Types::WeightMeasurementType',
        'length' => 'Shipment::Temando::WSDL::Types::Length',
        'width' => 'Shipment::Temando::WSDL::Types::Width',
        'height' => 'Shipment::Temando::WSDL::Types::Height',
        'actualWeight' => 'Shipment::Temando::WSDL::Types::Weight',
        'chargeableWeight' => 'Shipment::Temando::WSDL::Types::Weight',
        'actualCubic' => 'Shipment::Temando::WSDL::Types::Cubic',
        'chargeableCubic' => 'Shipment::Temando::WSDL::Types::Cubic',
        'actualQuantity' => 'Shipment::Temando::WSDL::Types::Quantity',
        'chargeableQuantity' => 'Shipment::Temando::WSDL::Types::Quantity',
        'basePrice' => 'Shipment::Temando::WSDL::Types::CurrencyAmount',
        'surcharges' => 'Shipment::Temando::WSDL::Types::CurrencyAmount',
        'tax' => 'Shipment::Temando::WSDL::Types::CurrencyAmount',
        'totalPrice' => 'Shipment::Temando::WSDL::Types::CurrencyAmount',
        'originZoneName' => 'Shipment::Temando::WSDL::Types::ZoneName',
        'originContactName' => 'Shipment::Temando::WSDL::Types::ContactName',
        'originCompanyName' => 'Shipment::Temando::WSDL::Types::CompanyName',
        'originStreet' => 'Shipment::Temando::WSDL::Types::Address',
        'originSuburb' => 'Shipment::Temando::WSDL::Types::Suburb',
        'originState' => 'Shipment::Temando::WSDL::Types::State',
        'originCode' => 'Shipment::Temando::WSDL::Types::PostalCode',
        'originCountry' => 'Shipment::Temando::WSDL::Types::CountryCode',
        'originPhone1' => 'Shipment::Temando::WSDL::Types::Phone',
        'originPhone2' => 'Shipment::Temando::WSDL::Types::Phone',
        'originFax' => 'Shipment::Temando::WSDL::Types::Fax',
        'originEmail' => 'Shipment::Temando::WSDL::Types::Email',
        'destinationZoneName' => 'Shipment::Temando::WSDL::Types::ZoneName',
        'destinationContactName' => 'Shipment::Temando::WSDL::Types::ContactName',
        'destinationCompanyName' => 'Shipment::Temando::WSDL::Types::CompanyName',
        'destinationStreet' => 'Shipment::Temando::WSDL::Types::Address',
        'destinationSuburb' => 'Shipment::Temando::WSDL::Types::Suburb',
        'destinationState' => 'Shipment::Temando::WSDL::Types::State',
        'destinationCode' => 'Shipment::Temando::WSDL::Types::PostalCode',
        'destinationCountry' => 'Shipment::Temando::WSDL::Types::CountryCode',
        'destinationPhone1' => 'Shipment::Temando::WSDL::Types::Phone',
        'destinationPhone2' => 'Shipment::Temando::WSDL::Types::Phone',
        'destinationFax' => 'Shipment::Temando::WSDL::Types::Fax',
        'destinationEmail' => 'Shipment::Temando::WSDL::Types::Email',
    },
    {

        'reference' => 'reference',
        'carrierName' => 'carrierName',
        'carrierId' => 'carrierId',
        'accountNo' => 'accountNo',
        'creatorId' => 'creatorId',
        'currency' => 'currency',
        'changedCarrier' => 'changedCarrier',
        'consignmentEdited' => 'consignmentEdited',
        'consignmentNumber' => 'consignmentNumber',
        'consignmentDate' => 'consignmentDate',
        'deliveryMethod' => 'deliveryMethod',
        'rateName' => 'rateName',
        'description' => 'description',
        'distanceMeasurementType' => 'distanceMeasurementType',
        'weightMeasurementType' => 'weightMeasurementType',
        'length' => 'length',
        'width' => 'width',
        'height' => 'height',
        'actualWeight' => 'actualWeight',
        'chargeableWeight' => 'chargeableWeight',
        'actualCubic' => 'actualCubic',
        'chargeableCubic' => 'chargeableCubic',
        'actualQuantity' => 'actualQuantity',
        'chargeableQuantity' => 'chargeableQuantity',
        'basePrice' => 'basePrice',
        'surcharges' => 'surcharges',
        'tax' => 'tax',
        'totalPrice' => 'totalPrice',
        'originZoneName' => 'originZoneName',
        'originContactName' => 'originContactName',
        'originCompanyName' => 'originCompanyName',
        'originStreet' => 'originStreet',
        'originSuburb' => 'originSuburb',
        'originState' => 'originState',
        'originCode' => 'originCode',
        'originCountry' => 'originCountry',
        'originPhone1' => 'originPhone1',
        'originPhone2' => 'originPhone2',
        'originFax' => 'originFax',
        'originEmail' => 'originEmail',
        'destinationZoneName' => 'destinationZoneName',
        'destinationContactName' => 'destinationContactName',
        'destinationCompanyName' => 'destinationCompanyName',
        'destinationStreet' => 'destinationStreet',
        'destinationSuburb' => 'destinationSuburb',
        'destinationState' => 'destinationState',
        'destinationCode' => 'destinationCode',
        'destinationCountry' => 'destinationCountry',
        'destinationPhone1' => 'destinationPhone1',
        'destinationPhone2' => 'destinationPhone2',
        'destinationFax' => 'destinationFax',
        'destinationEmail' => 'destinationEmail',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::Temando::WSDL::Types::DispatchDetails

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
DispatchDetails from the namespace http://' . $Shipment::Temando::WSDL::Interfaces::quoting_Service::quoting_port::ns_url . '/schema/2009_06/common.xsd.






=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * reference (min/maxOccurs: 0/1)


=item * carrierName (min/maxOccurs: 0/1)


=item * carrierId (min/maxOccurs: 0/1)


=item * accountNo (min/maxOccurs: 0/1)


=item * creatorId (min/maxOccurs: 0/1)


=item * currency (min/maxOccurs: 0/1)


=item * changedCarrier (min/maxOccurs: 0/1)


=item * consignmentEdited (min/maxOccurs: 0/1)


=item * consignmentNumber (min/maxOccurs: 0/1)


=item * consignmentDate (min/maxOccurs: 0/1)


=item * deliveryMethod (min/maxOccurs: 0/1)


=item * rateName (min/maxOccurs: 0/1)


=item * description (min/maxOccurs: 0/1)


=item * distanceMeasurementType (min/maxOccurs: 0/1)


=item * weightMeasurementType (min/maxOccurs: 0/1)


=item * length (min/maxOccurs: 0/1)


=item * width (min/maxOccurs: 0/1)


=item * height (min/maxOccurs: 0/1)


=item * actualWeight (min/maxOccurs: 0/1)


=item * chargeableWeight (min/maxOccurs: 0/1)


=item * actualCubic (min/maxOccurs: 0/1)


=item * chargeableCubic (min/maxOccurs: 0/1)


=item * actualQuantity (min/maxOccurs: 0/1)


=item * chargeableQuantity (min/maxOccurs: 0/1)


=item * basePrice (min/maxOccurs: 0/1)


=item * surcharges (min/maxOccurs: 0/1)


=item * tax (min/maxOccurs: 0/1)


=item * totalPrice (min/maxOccurs: 0/1)


=item * originZoneName (min/maxOccurs: 0/1)


=item * originContactName (min/maxOccurs: 0/1)


=item * originCompanyName (min/maxOccurs: 0/1)


=item * originStreet (min/maxOccurs: 0/1)


=item * originSuburb (min/maxOccurs: 0/1)


=item * originState (min/maxOccurs: 0/1)


=item * originCode (min/maxOccurs: 0/1)


=item * originCountry (min/maxOccurs: 0/1)


=item * originPhone1 (min/maxOccurs: 0/1)


=item * originPhone2 (min/maxOccurs: 0/1)


=item * originFax (min/maxOccurs: 0/1)


=item * originEmail (min/maxOccurs: 0/1)


=item * destinationZoneName (min/maxOccurs: 0/1)


=item * destinationContactName (min/maxOccurs: 0/1)


=item * destinationCompanyName (min/maxOccurs: 0/1)


=item * destinationStreet (min/maxOccurs: 0/1)


=item * destinationSuburb (min/maxOccurs: 0/1)


=item * destinationState (min/maxOccurs: 0/1)


=item * destinationCode (min/maxOccurs: 0/1)


=item * destinationCountry (min/maxOccurs: 0/1)


=item * destinationPhone1 (min/maxOccurs: 0/1)


=item * destinationPhone2 (min/maxOccurs: 0/1)


=item * destinationFax (min/maxOccurs: 0/1)


=item * destinationEmail (min/maxOccurs: 0/1)




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::Temando::WSDL::Types::DispatchDetails
   reference => $some_value, # CarrierReference
   carrierName => $some_value, # CompanyName
   carrierId => $some_value, # CarrierId
   accountNo => $some_value, # CarrierAccountNumber
   creatorId => $some_value, # CarrierCreatorId
   currency => $some_value, # CurrencyType
   changedCarrier => $some_value, # YesNoOption
   consignmentEdited => $some_value, # YesNoOption
   consignmentNumber => $some_value, # ConsignmentNumber
   consignmentDate => $some_value, # Date
   deliveryMethod => $some_value, # DeliveryMethod
   rateName => $some_value, # RateName
   description => $some_value, # ItemDescription
   distanceMeasurementType => $some_value, # DistanceMeasurementType
   weightMeasurementType => $some_value, # WeightMeasurementType
   length => $some_value, # Length
   width => $some_value, # Width
   height => $some_value, # Height
   actualWeight => $some_value, # Weight
   chargeableWeight => $some_value, # Weight
   actualCubic => $some_value, # Cubic
   chargeableCubic => $some_value, # Cubic
   actualQuantity => $some_value, # Quantity
   chargeableQuantity => $some_value, # Quantity
   basePrice => $some_value, # CurrencyAmount
   surcharges => $some_value, # CurrencyAmount
   tax => $some_value, # CurrencyAmount
   totalPrice => $some_value, # CurrencyAmount
   originZoneName => $some_value, # ZoneName
   originContactName => $some_value, # ContactName
   originCompanyName => $some_value, # CompanyName
   originStreet => $some_value, # Address
   originSuburb => $some_value, # Suburb
   originState => $some_value, # State
   originCode => $some_value, # PostalCode
   originCountry => $some_value, # CountryCode
   originPhone1 => $some_value, # Phone
   originPhone2 => $some_value, # Phone
   originFax => $some_value, # Fax
   originEmail => $some_value, # Email
   destinationZoneName => $some_value, # ZoneName
   destinationContactName => $some_value, # ContactName
   destinationCompanyName => $some_value, # CompanyName
   destinationStreet => $some_value, # Address
   destinationSuburb => $some_value, # Suburb
   destinationState => $some_value, # State
   destinationCode => $some_value, # PostalCode
   destinationCountry => $some_value, # CountryCode
   destinationPhone1 => $some_value, # Phone
   destinationPhone2 => $some_value, # Phone
   destinationFax => $some_value, # Fax
   destinationEmail => $some_value, # Email
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

