package Shipment::FedEx::WSDL::RateTypes::RateReplyDetail;
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

my %ServiceType_of :ATTR(:get<ServiceType>);
my %PackagingType_of :ATTR(:get<PackagingType>);
my %AppliedOptions_of :ATTR(:get<AppliedOptions>);
my %AppliedSubOptions_of :ATTR(:get<AppliedSubOptions>);
my %DeliveryStation_of :ATTR(:get<DeliveryStation>);
my %DeliveryDayOfWeek_of :ATTR(:get<DeliveryDayOfWeek>);
my %DeliveryTimestamp_of :ATTR(:get<DeliveryTimestamp>);
my %CommitDetails_of :ATTR(:get<CommitDetails>);
my %DestinationAirportId_of :ATTR(:get<DestinationAirportId>);
my %IneligibleForMoneyBackGuarantee_of :ATTR(:get<IneligibleForMoneyBackGuarantee>);
my %OriginServiceArea_of :ATTR(:get<OriginServiceArea>);
my %DestinationServiceArea_of :ATTR(:get<DestinationServiceArea>);
my %TransitTime_of :ATTR(:get<TransitTime>);
my %MaximumTransitTime_of :ATTR(:get<MaximumTransitTime>);
my %SignatureOption_of :ATTR(:get<SignatureOption>);
my %ActualRateType_of :ATTR(:get<ActualRateType>);
my %RatedShipmentDetails_of :ATTR(:get<RatedShipmentDetails>);

__PACKAGE__->_factory(
    [ qw(        ServiceType
        PackagingType
        AppliedOptions
        AppliedSubOptions
        DeliveryStation
        DeliveryDayOfWeek
        DeliveryTimestamp
        CommitDetails
        DestinationAirportId
        IneligibleForMoneyBackGuarantee
        OriginServiceArea
        DestinationServiceArea
        TransitTime
        MaximumTransitTime
        SignatureOption
        ActualRateType
        RatedShipmentDetails

    ) ],
    {
        'ServiceType' => \%ServiceType_of,
        'PackagingType' => \%PackagingType_of,
        'AppliedOptions' => \%AppliedOptions_of,
        'AppliedSubOptions' => \%AppliedSubOptions_of,
        'DeliveryStation' => \%DeliveryStation_of,
        'DeliveryDayOfWeek' => \%DeliveryDayOfWeek_of,
        'DeliveryTimestamp' => \%DeliveryTimestamp_of,
        'CommitDetails' => \%CommitDetails_of,
        'DestinationAirportId' => \%DestinationAirportId_of,
        'IneligibleForMoneyBackGuarantee' => \%IneligibleForMoneyBackGuarantee_of,
        'OriginServiceArea' => \%OriginServiceArea_of,
        'DestinationServiceArea' => \%DestinationServiceArea_of,
        'TransitTime' => \%TransitTime_of,
        'MaximumTransitTime' => \%MaximumTransitTime_of,
        'SignatureOption' => \%SignatureOption_of,
        'ActualRateType' => \%ActualRateType_of,
        'RatedShipmentDetails' => \%RatedShipmentDetails_of,
    },
    {
        'ServiceType' => 'Shipment::FedEx::WSDL::RateTypes::ServiceType',
        'PackagingType' => 'Shipment::FedEx::WSDL::RateTypes::PackagingType',
        'AppliedOptions' => 'Shipment::FedEx::WSDL::RateTypes::ServiceOptionType',
        'AppliedSubOptions' => 'Shipment::FedEx::WSDL::RateTypes::ServiceSubOptionDetail',
        'DeliveryStation' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'DeliveryDayOfWeek' => 'Shipment::FedEx::WSDL::RateTypes::DayOfWeekType',
        'DeliveryTimestamp' => 'SOAP::WSDL::XSD::Typelib::Builtin::dateTime',
        'CommitDetails' => 'Shipment::FedEx::WSDL::RateTypes::CommitDetail',
        'DestinationAirportId' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'IneligibleForMoneyBackGuarantee' => 'SOAP::WSDL::XSD::Typelib::Builtin::boolean',
        'OriginServiceArea' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'DestinationServiceArea' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'TransitTime' => 'Shipment::FedEx::WSDL::RateTypes::TransitTimeType',
        'MaximumTransitTime' => 'Shipment::FedEx::WSDL::RateTypes::TransitTimeType',
        'SignatureOption' => 'Shipment::FedEx::WSDL::RateTypes::SignatureOptionType',
        'ActualRateType' => 'Shipment::FedEx::WSDL::RateTypes::ReturnedRateType',
        'RatedShipmentDetails' => 'Shipment::FedEx::WSDL::RateTypes::RatedShipmentDetail',
    },
    {

        'ServiceType' => 'ServiceType',
        'PackagingType' => 'PackagingType',
        'AppliedOptions' => 'AppliedOptions',
        'AppliedSubOptions' => 'AppliedSubOptions',
        'DeliveryStation' => 'DeliveryStation',
        'DeliveryDayOfWeek' => 'DeliveryDayOfWeek',
        'DeliveryTimestamp' => 'DeliveryTimestamp',
        'CommitDetails' => 'CommitDetails',
        'DestinationAirportId' => 'DestinationAirportId',
        'IneligibleForMoneyBackGuarantee' => 'IneligibleForMoneyBackGuarantee',
        'OriginServiceArea' => 'OriginServiceArea',
        'DestinationServiceArea' => 'DestinationServiceArea',
        'TransitTime' => 'TransitTime',
        'MaximumTransitTime' => 'MaximumTransitTime',
        'SignatureOption' => 'SignatureOption',
        'ActualRateType' => 'ActualRateType',
        'RatedShipmentDetails' => 'RatedShipmentDetails',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::FedEx::WSDL::RateTypes::RateReplyDetail

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
RateReplyDetail from the namespace http://fedex.com/ws/rate/v9.






=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * ServiceType (min/maxOccurs: 0/1)


=item * PackagingType (min/maxOccurs: 0/1)


=item * AppliedOptions (min/maxOccurs: 0/unbounded)


=item * AppliedSubOptions (min/maxOccurs: 0/1)


=item * DeliveryStation (min/maxOccurs: 0/1)


=item * DeliveryDayOfWeek (min/maxOccurs: 0/1)


=item * DeliveryTimestamp (min/maxOccurs: 0/1)


=item * CommitDetails (min/maxOccurs: 0/unbounded)


=item * DestinationAirportId (min/maxOccurs: 0/1)


=item * IneligibleForMoneyBackGuarantee (min/maxOccurs: 0/1)


=item * OriginServiceArea (min/maxOccurs: 0/1)


=item * DestinationServiceArea (min/maxOccurs: 0/1)


=item * TransitTime (min/maxOccurs: 0/1)


=item * MaximumTransitTime (min/maxOccurs: 0/1)


=item * SignatureOption (min/maxOccurs: 0/1)


=item * ActualRateType (min/maxOccurs: 0/1)


=item * RatedShipmentDetails (min/maxOccurs: 0/unbounded)




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::FedEx::WSDL::RateTypes::RateReplyDetail
   ServiceType => $some_value, # ServiceType
   PackagingType => $some_value, # PackagingType
   AppliedOptions => $some_value, # ServiceOptionType
   AppliedSubOptions =>  { # Shipment::FedEx::WSDL::RateTypes::ServiceSubOptionDetail
     FreightGuarantee => $some_value, # FreightGuaranteeType
     SmartPostHubId =>  $some_value, # string
     SmartPostIndicia => $some_value, # SmartPostIndiciaType
   },
   DeliveryStation =>  $some_value, # string
   DeliveryDayOfWeek => $some_value, # DayOfWeekType
   DeliveryTimestamp =>  $some_value, # dateTime
   CommitDetails =>  { # Shipment::FedEx::WSDL::RateTypes::CommitDetail
     CommodityName =>  $some_value, # string
     ServiceType => $some_value, # ServiceType
     AppliedOptions => $some_value, # ServiceOptionType
     AppliedSubOptions => {}, # Shipment::FedEx::WSDL::RateTypes::ServiceSubOptionDetail
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
   DestinationAirportId =>  $some_value, # string
   IneligibleForMoneyBackGuarantee =>  $some_value, # boolean
   OriginServiceArea =>  $some_value, # string
   DestinationServiceArea =>  $some_value, # string
   TransitTime => $some_value, # TransitTimeType
   MaximumTransitTime => $some_value, # TransitTimeType
   SignatureOption => $some_value, # SignatureOptionType
   ActualRateType => $some_value, # ReturnedRateType
   RatedShipmentDetails =>  { # Shipment::FedEx::WSDL::RateTypes::RatedShipmentDetail
     EffectiveNetDiscount =>  { # Shipment::FedEx::WSDL::RateTypes::Money
       Currency =>  $some_value, # string
       Amount =>  $some_value, # decimal
     },
     AdjustedCodCollectionAmount => {}, # Shipment::FedEx::WSDL::RateTypes::Money
     ShipmentRateDetail =>  { # Shipment::FedEx::WSDL::RateTypes::ShipmentRateDetail
       RateType => $some_value, # ReturnedRateType
       RateScale =>  $some_value, # string
       RateZone =>  $some_value, # string
       PricingCode => $some_value, # PricingCodeType
       RatedWeightMethod => $some_value, # RatedWeightMethod
       MinimumChargeType => $some_value, # MinimumChargeType
       CurrencyExchangeRate =>  { # Shipment::FedEx::WSDL::RateTypes::CurrencyExchangeRate
         FromCurrency =>  $some_value, # string
         IntoCurrency =>  $some_value, # string
         Rate =>  $some_value, # decimal
       },
       SpecialRatingApplied => $some_value, # SpecialRatingAppliedType
       DimDivisor =>  $some_value, # nonNegativeInteger
       DimDivisorType => $some_value, # RateDimensionalDivisorType
       FuelSurchargePercent =>  $some_value, # decimal
       TotalBillingWeight =>  { # Shipment::FedEx::WSDL::RateTypes::Weight
         Units => $some_value, # WeightUnits
         Value =>  $some_value, # decimal
       },
       TotalDimWeight => {}, # Shipment::FedEx::WSDL::RateTypes::Weight
       TotalBaseCharge => {}, # Shipment::FedEx::WSDL::RateTypes::Money
       TotalFreightDiscounts => {}, # Shipment::FedEx::WSDL::RateTypes::Money
       TotalNetFreight => {}, # Shipment::FedEx::WSDL::RateTypes::Money
       TotalSurcharges => {}, # Shipment::FedEx::WSDL::RateTypes::Money
       TotalNetFedExCharge => {}, # Shipment::FedEx::WSDL::RateTypes::Money
       TotalTaxes => {}, # Shipment::FedEx::WSDL::RateTypes::Money
       TotalNetCharge => {}, # Shipment::FedEx::WSDL::RateTypes::Money
       TotalRebates => {}, # Shipment::FedEx::WSDL::RateTypes::Money
       TotalDutiesAndTaxes => {}, # Shipment::FedEx::WSDL::RateTypes::Money
       TotalNetChargeWithDutiesAndTaxes => {}, # Shipment::FedEx::WSDL::RateTypes::Money
       FreightRateDetail =>  { # Shipment::FedEx::WSDL::RateTypes::FreightRateDetail
         QuoteNumber =>  $some_value, # string
         BaseChargeCalculation => $some_value, # FreightBaseChargeCalculationType
         BaseCharges =>  { # Shipment::FedEx::WSDL::RateTypes::FreightBaseCharge
           FreightClass => $some_value, # FreightClassType
           RatedAsClass => $some_value, # FreightClassType
           NmfcCode =>  $some_value, # string
           Description =>  $some_value, # string
           Weight => {}, # Shipment::FedEx::WSDL::RateTypes::Weight
           ChargeRate => {}, # Shipment::FedEx::WSDL::RateTypes::Money
           ChargeBasis => $some_value, # FreightChargeBasisType
           ExtendedAmount => {}, # Shipment::FedEx::WSDL::RateTypes::Money
         },
         Notations =>  { # Shipment::FedEx::WSDL::RateTypes::FreightRateNotation
           Code =>  $some_value, # string
           Description =>  $some_value, # string
         },
       },
       FreightDiscounts =>  { # Shipment::FedEx::WSDL::RateTypes::RateDiscount
         RateDiscountType => $some_value, # RateDiscountType
         Description =>  $some_value, # string
         Amount => {}, # Shipment::FedEx::WSDL::RateTypes::Money
         Percent =>  $some_value, # decimal
       },
       Rebates =>  { # Shipment::FedEx::WSDL::RateTypes::Rebate
         RebateType => $some_value, # RebateType
         Description =>  $some_value, # string
         Amount => {}, # Shipment::FedEx::WSDL::RateTypes::Money
         Percent =>  $some_value, # decimal
       },
       Surcharges =>  { # Shipment::FedEx::WSDL::RateTypes::Surcharge
         SurchargeType => $some_value, # SurchargeType
         Level => $some_value, # SurchargeLevelType
         Description =>  $some_value, # string
         Amount => {}, # Shipment::FedEx::WSDL::RateTypes::Money
       },
       Taxes =>  { # Shipment::FedEx::WSDL::RateTypes::Tax
         TaxType => $some_value, # TaxType
         Description =>  $some_value, # string
         Amount => {}, # Shipment::FedEx::WSDL::RateTypes::Money
       },
       DutiesAndTaxes =>  { # Shipment::FedEx::WSDL::RateTypes::EdtCommodityTax
         HarmonizedCode =>  $some_value, # string
         Taxes =>  { # Shipment::FedEx::WSDL::RateTypes::EdtTaxDetail
           TaxType => $some_value, # EdtTaxType
           EffectiveDate =>  $some_value, # date
           Name =>  $some_value, # string
           TaxableValue => {}, # Shipment::FedEx::WSDL::RateTypes::Money
           Description =>  $some_value, # string
           Formula =>  $some_value, # string
           Amount => {}, # Shipment::FedEx::WSDL::RateTypes::Money
         },
       },
       VariableHandlingCharges =>  { # Shipment::FedEx::WSDL::RateTypes::VariableHandlingCharges
         VariableHandlingCharge => {}, # Shipment::FedEx::WSDL::RateTypes::Money
         TotalCustomerCharge => {}, # Shipment::FedEx::WSDL::RateTypes::Money
       },
       TotalVariableHandlingCharges => {}, # Shipment::FedEx::WSDL::RateTypes::VariableHandlingCharges
     },
     RatedPackages =>  { # Shipment::FedEx::WSDL::RateTypes::RatedPackageDetail
       TrackingIds =>  { # Shipment::FedEx::WSDL::RateTypes::TrackingId
         TrackingIdType => $some_value, # TrackingIdType
         FormId =>  $some_value, # string
         TrackingNumber =>  $some_value, # string
       },
       GroupNumber =>  $some_value, # nonNegativeInteger
       EffectiveNetDiscount => {}, # Shipment::FedEx::WSDL::RateTypes::Money
       AdjustedCodCollectionAmount => {}, # Shipment::FedEx::WSDL::RateTypes::Money
       OversizeClass => $some_value, # OversizeClassType
       PackageRateDetail =>  { # Shipment::FedEx::WSDL::RateTypes::PackageRateDetail
         RateType => $some_value, # ReturnedRateType
         RatedWeightMethod => $some_value, # RatedWeightMethod
         MinimumChargeType => $some_value, # MinimumChargeType
         BillingWeight => {}, # Shipment::FedEx::WSDL::RateTypes::Weight
         DimWeight => {}, # Shipment::FedEx::WSDL::RateTypes::Weight
         OversizeWeight => {}, # Shipment::FedEx::WSDL::RateTypes::Weight
         BaseCharge => {}, # Shipment::FedEx::WSDL::RateTypes::Money
         TotalFreightDiscounts => {}, # Shipment::FedEx::WSDL::RateTypes::Money
         NetFreight => {}, # Shipment::FedEx::WSDL::RateTypes::Money
         TotalSurcharges => {}, # Shipment::FedEx::WSDL::RateTypes::Money
         NetFedExCharge => {}, # Shipment::FedEx::WSDL::RateTypes::Money
         TotalTaxes => {}, # Shipment::FedEx::WSDL::RateTypes::Money
         NetCharge => {}, # Shipment::FedEx::WSDL::RateTypes::Money
         TotalRebates => {}, # Shipment::FedEx::WSDL::RateTypes::Money
         FreightDiscounts => {}, # Shipment::FedEx::WSDL::RateTypes::RateDiscount
         Rebates => {}, # Shipment::FedEx::WSDL::RateTypes::Rebate
         Surcharges => {}, # Shipment::FedEx::WSDL::RateTypes::Surcharge
         Taxes => {}, # Shipment::FedEx::WSDL::RateTypes::Tax
         VariableHandlingCharges => {}, # Shipment::FedEx::WSDL::RateTypes::VariableHandlingCharges
       },
     },
   },
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

