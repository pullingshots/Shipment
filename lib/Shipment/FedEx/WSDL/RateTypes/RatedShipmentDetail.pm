package Shipment::FedEx::WSDL::RateTypes::RatedShipmentDetail;
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

my %EffectiveNetDiscount_of :ATTR(:get<EffectiveNetDiscount>);
my %AdjustedCodCollectionAmount_of :ATTR(:get<AdjustedCodCollectionAmount>);
my %ShipmentRateDetail_of :ATTR(:get<ShipmentRateDetail>);
my %RatedPackages_of :ATTR(:get<RatedPackages>);

__PACKAGE__->_factory(
    [ qw(        EffectiveNetDiscount
        AdjustedCodCollectionAmount
        ShipmentRateDetail
        RatedPackages

    ) ],
    {
        'EffectiveNetDiscount' => \%EffectiveNetDiscount_of,
        'AdjustedCodCollectionAmount' => \%AdjustedCodCollectionAmount_of,
        'ShipmentRateDetail' => \%ShipmentRateDetail_of,
        'RatedPackages' => \%RatedPackages_of,
    },
    {
        'EffectiveNetDiscount' => 'Shipment::FedEx::WSDL::RateTypes::Money',
        'AdjustedCodCollectionAmount' => 'Shipment::FedEx::WSDL::RateTypes::Money',
        'ShipmentRateDetail' => 'Shipment::FedEx::WSDL::RateTypes::ShipmentRateDetail',
        'RatedPackages' => 'Shipment::FedEx::WSDL::RateTypes::RatedPackageDetail',
    },
    {

        'EffectiveNetDiscount' => 'EffectiveNetDiscount',
        'AdjustedCodCollectionAmount' => 'AdjustedCodCollectionAmount',
        'ShipmentRateDetail' => 'ShipmentRateDetail',
        'RatedPackages' => 'RatedPackages',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::FedEx::WSDL::RateTypes::RatedShipmentDetail

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
RatedShipmentDetail from the namespace http://fedex.com/ws/rate/v9.

This class groups the shipment and package rating data for a specific rate type for use in a rating reply, which groups result data by rate type.




=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * EffectiveNetDiscount (min/maxOccurs: 0/1)


=item * AdjustedCodCollectionAmount (min/maxOccurs: 0/1)


=item * ShipmentRateDetail (min/maxOccurs: 0/1)


=item * RatedPackages (min/maxOccurs: 0/unbounded)




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::FedEx::WSDL::RateTypes::RatedShipmentDetail
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




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

