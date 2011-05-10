package Shipment::FedEx::WSDL::RateTypes::CommitDetail;
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

my %CommodityName_of :ATTR(:get<CommodityName>);
my %ServiceType_of :ATTR(:get<ServiceType>);
my %AppliedOptions_of :ATTR(:get<AppliedOptions>);
my %AppliedSubOptions_of :ATTR(:get<AppliedSubOptions>);
my %CommitTimestamp_of :ATTR(:get<CommitTimestamp>);
my %DayOfWeek_of :ATTR(:get<DayOfWeek>);
my %TransitTime_of :ATTR(:get<TransitTime>);
my %MaximumTransitTime_of :ATTR(:get<MaximumTransitTime>);
my %DestinationServiceArea_of :ATTR(:get<DestinationServiceArea>);
my %BrokerAddress_of :ATTR(:get<BrokerAddress>);
my %BrokerLocationId_of :ATTR(:get<BrokerLocationId>);
my %BrokerCommitTimestamp_of :ATTR(:get<BrokerCommitTimestamp>);
my %BrokerCommitDayOfWeek_of :ATTR(:get<BrokerCommitDayOfWeek>);
my %BrokerToDestinationDays_of :ATTR(:get<BrokerToDestinationDays>);
my %ProofOfDeliveryDate_of :ATTR(:get<ProofOfDeliveryDate>);
my %ProofOfDeliveryDayOfWeek_of :ATTR(:get<ProofOfDeliveryDayOfWeek>);
my %CommitMessages_of :ATTR(:get<CommitMessages>);
my %DeliveryMessages_of :ATTR(:get<DeliveryMessages>);
my %DelayDetails_of :ATTR(:get<DelayDetails>);
my %DocumentContent_of :ATTR(:get<DocumentContent>);
my %RequiredDocuments_of :ATTR(:get<RequiredDocuments>);
my %FreightCommitDetail_of :ATTR(:get<FreightCommitDetail>);

__PACKAGE__->_factory(
    [ qw(        CommodityName
        ServiceType
        AppliedOptions
        AppliedSubOptions
        CommitTimestamp
        DayOfWeek
        TransitTime
        MaximumTransitTime
        DestinationServiceArea
        BrokerAddress
        BrokerLocationId
        BrokerCommitTimestamp
        BrokerCommitDayOfWeek
        BrokerToDestinationDays
        ProofOfDeliveryDate
        ProofOfDeliveryDayOfWeek
        CommitMessages
        DeliveryMessages
        DelayDetails
        DocumentContent
        RequiredDocuments
        FreightCommitDetail

    ) ],
    {
        'CommodityName' => \%CommodityName_of,
        'ServiceType' => \%ServiceType_of,
        'AppliedOptions' => \%AppliedOptions_of,
        'AppliedSubOptions' => \%AppliedSubOptions_of,
        'CommitTimestamp' => \%CommitTimestamp_of,
        'DayOfWeek' => \%DayOfWeek_of,
        'TransitTime' => \%TransitTime_of,
        'MaximumTransitTime' => \%MaximumTransitTime_of,
        'DestinationServiceArea' => \%DestinationServiceArea_of,
        'BrokerAddress' => \%BrokerAddress_of,
        'BrokerLocationId' => \%BrokerLocationId_of,
        'BrokerCommitTimestamp' => \%BrokerCommitTimestamp_of,
        'BrokerCommitDayOfWeek' => \%BrokerCommitDayOfWeek_of,
        'BrokerToDestinationDays' => \%BrokerToDestinationDays_of,
        'ProofOfDeliveryDate' => \%ProofOfDeliveryDate_of,
        'ProofOfDeliveryDayOfWeek' => \%ProofOfDeliveryDayOfWeek_of,
        'CommitMessages' => \%CommitMessages_of,
        'DeliveryMessages' => \%DeliveryMessages_of,
        'DelayDetails' => \%DelayDetails_of,
        'DocumentContent' => \%DocumentContent_of,
        'RequiredDocuments' => \%RequiredDocuments_of,
        'FreightCommitDetail' => \%FreightCommitDetail_of,
    },
    {
        'CommodityName' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'ServiceType' => 'Shipment::FedEx::WSDL::RateTypes::ServiceType',
        'AppliedOptions' => 'Shipment::FedEx::WSDL::RateTypes::ServiceOptionType',
        'AppliedSubOptions' => 'Shipment::FedEx::WSDL::RateTypes::ServiceSubOptionDetail',
        'CommitTimestamp' => 'SOAP::WSDL::XSD::Typelib::Builtin::dateTime',
        'DayOfWeek' => 'Shipment::FedEx::WSDL::RateTypes::DayOfWeekType',
        'TransitTime' => 'Shipment::FedEx::WSDL::RateTypes::TransitTimeType',
        'MaximumTransitTime' => 'Shipment::FedEx::WSDL::RateTypes::TransitTimeType',
        'DestinationServiceArea' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'BrokerAddress' => 'Shipment::FedEx::WSDL::RateTypes::Address',
        'BrokerLocationId' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'BrokerCommitTimestamp' => 'SOAP::WSDL::XSD::Typelib::Builtin::dateTime',
        'BrokerCommitDayOfWeek' => 'Shipment::FedEx::WSDL::RateTypes::DayOfWeekType',
        'BrokerToDestinationDays' => 'SOAP::WSDL::XSD::Typelib::Builtin::nonNegativeInteger',
        'ProofOfDeliveryDate' => 'SOAP::WSDL::XSD::Typelib::Builtin::date',
        'ProofOfDeliveryDayOfWeek' => 'Shipment::FedEx::WSDL::RateTypes::DayOfWeekType',
        'CommitMessages' => 'Shipment::FedEx::WSDL::RateTypes::Notification',
        'DeliveryMessages' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'DelayDetails' => 'Shipment::FedEx::WSDL::RateTypes::DelayDetail',
        'DocumentContent' => 'Shipment::FedEx::WSDL::RateTypes::InternationalDocumentContentType',
        'RequiredDocuments' => 'Shipment::FedEx::WSDL::RateTypes::RequiredShippingDocumentType',
        'FreightCommitDetail' => 'Shipment::FedEx::WSDL::RateTypes::FreightCommitDetail',
    },
    {

        'CommodityName' => 'CommodityName',
        'ServiceType' => 'ServiceType',
        'AppliedOptions' => 'AppliedOptions',
        'AppliedSubOptions' => 'AppliedSubOptions',
        'CommitTimestamp' => 'CommitTimestamp',
        'DayOfWeek' => 'DayOfWeek',
        'TransitTime' => 'TransitTime',
        'MaximumTransitTime' => 'MaximumTransitTime',
        'DestinationServiceArea' => 'DestinationServiceArea',
        'BrokerAddress' => 'BrokerAddress',
        'BrokerLocationId' => 'BrokerLocationId',
        'BrokerCommitTimestamp' => 'BrokerCommitTimestamp',
        'BrokerCommitDayOfWeek' => 'BrokerCommitDayOfWeek',
        'BrokerToDestinationDays' => 'BrokerToDestinationDays',
        'ProofOfDeliveryDate' => 'ProofOfDeliveryDate',
        'ProofOfDeliveryDayOfWeek' => 'ProofOfDeliveryDayOfWeek',
        'CommitMessages' => 'CommitMessages',
        'DeliveryMessages' => 'DeliveryMessages',
        'DelayDetails' => 'DelayDetails',
        'DocumentContent' => 'DocumentContent',
        'RequiredDocuments' => 'RequiredDocuments',
        'FreightCommitDetail' => 'FreightCommitDetail',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::FedEx::WSDL::RateTypes::CommitDetail

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
CommitDetail from the namespace http://fedex.com/ws/rate/v9.

Information about the transit time and delivery commitment date and time.




=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * CommodityName (min/maxOccurs: 0/1)


=item * ServiceType (min/maxOccurs: 0/1)


=item * AppliedOptions (min/maxOccurs: 0/unbounded)


=item * AppliedSubOptions (min/maxOccurs: 0/1)


=item * CommitTimestamp (min/maxOccurs: 0/1)


=item * DayOfWeek (min/maxOccurs: 0/1)


=item * TransitTime (min/maxOccurs: 0/1)


=item * MaximumTransitTime (min/maxOccurs: 0/1)


=item * DestinationServiceArea (min/maxOccurs: 0/1)


=item * BrokerAddress (min/maxOccurs: 0/1)


=item * BrokerLocationId (min/maxOccurs: 0/1)


=item * BrokerCommitTimestamp (min/maxOccurs: 0/1)


=item * BrokerCommitDayOfWeek (min/maxOccurs: 0/1)


=item * BrokerToDestinationDays (min/maxOccurs: 0/1)


=item * ProofOfDeliveryDate (min/maxOccurs: 0/1)


=item * ProofOfDeliveryDayOfWeek (min/maxOccurs: 0/1)


=item * CommitMessages (min/maxOccurs: 0/unbounded)


=item * DeliveryMessages (min/maxOccurs: 0/unbounded)


=item * DelayDetails (min/maxOccurs: 0/unbounded)


=item * DocumentContent (min/maxOccurs: 0/1)


=item * RequiredDocuments (min/maxOccurs: 0/unbounded)


=item * FreightCommitDetail (min/maxOccurs: 0/1)




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::FedEx::WSDL::RateTypes::CommitDetail
   CommodityName =>  $some_value, # string
   ServiceType => $some_value, # ServiceType
   AppliedOptions => $some_value, # ServiceOptionType
   AppliedSubOptions =>  { # Shipment::FedEx::WSDL::RateTypes::ServiceSubOptionDetail
     FreightGuarantee => $some_value, # FreightGuaranteeType
     SmartPostHubId =>  $some_value, # string
     SmartPostIndicia => $some_value, # SmartPostIndiciaType
   },
   CommitTimestamp =>  $some_value, # dateTime
   DayOfWeek => $some_value, # DayOfWeekType
   TransitTime => $some_value, # TransitTimeType
   MaximumTransitTime => $some_value, # TransitTimeType
   DestinationServiceArea =>  $some_value, # string
   BrokerAddress =>  { # Shipment::FedEx::WSDL::RateTypes::Address
     StreetLines =>  $some_value, # string
     City =>  $some_value, # string
     StateOrProvinceCode =>  $some_value, # string
     PostalCode =>  $some_value, # string
     UrbanizationCode =>  $some_value, # string
     CountryCode =>  $some_value, # string
     Residential =>  $some_value, # boolean
   },
   BrokerLocationId =>  $some_value, # string
   BrokerCommitTimestamp =>  $some_value, # dateTime
   BrokerCommitDayOfWeek => $some_value, # DayOfWeekType
   BrokerToDestinationDays =>  $some_value, # nonNegativeInteger
   ProofOfDeliveryDate =>  $some_value, # date
   ProofOfDeliveryDayOfWeek => $some_value, # DayOfWeekType
   CommitMessages =>  { # Shipment::FedEx::WSDL::RateTypes::Notification
     Severity => $some_value, # NotificationSeverityType
     Source =>  $some_value, # string
     Code =>  $some_value, # string
     Message =>  $some_value, # string
     LocalizedMessage =>  $some_value, # string
     MessageParameters =>  { # Shipment::FedEx::WSDL::RateTypes::NotificationParameter
       Id =>  $some_value, # string
       Value =>  $some_value, # string
     },
   },
   DeliveryMessages =>  $some_value, # string
   DelayDetails =>  { # Shipment::FedEx::WSDL::RateTypes::DelayDetail
     Date =>  $some_value, # date
     DayOfWeek => $some_value, # DayOfWeekType
     Level => $some_value, # DelayLevelType
     Point => $some_value, # DelayPointType
     Type => $some_value, # CommitmentDelayType
     Description =>  $some_value, # string
   },
   DocumentContent => $some_value, # InternationalDocumentContentType
   RequiredDocuments => $some_value, # RequiredShippingDocumentType
   FreightCommitDetail =>  { # Shipment::FedEx::WSDL::RateTypes::FreightCommitDetail
     OriginDetail =>  { # Shipment::FedEx::WSDL::RateTypes::FreightServiceCenterDetail
       InterlineCarrierCode =>  $some_value, # string
       InterlineCarrierName =>  $some_value, # string
       AdditionalDays =>  $some_value, # int
       LocalService => $some_value, # ServiceType
       LocalDistance =>  { # Shipment::FedEx::WSDL::RateTypes::Distance
         Value =>  $some_value, # decimal
         Units => $some_value, # DistanceUnits
       },
       LocalDuration =>  $some_value, # string
       LocalServiceScheduling => $some_value, # FreightServiceSchedulingType
       LimitedServiceDays => $some_value, # DayOfWeekType
       GatewayLocationId =>  $some_value, # string
       Location =>  $some_value, # string
       ContactAndAddress =>  { # Shipment::FedEx::WSDL::RateTypes::ContactAndAddress
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
         Address => {}, # Shipment::FedEx::WSDL::RateTypes::Address
       },
     },
     DestinationDetail => {}, # Shipment::FedEx::WSDL::RateTypes::FreightServiceCenterDetail
     TotalDistance => {}, # Shipment::FedEx::WSDL::RateTypes::Distance
   },
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

