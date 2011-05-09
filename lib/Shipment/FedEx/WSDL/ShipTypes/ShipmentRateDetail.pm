package Shipment::FedEx::WSDL::ShipTypes::ShipmentRateDetail;
use strict;
use warnings;


__PACKAGE__->_set_element_form_qualified(1);

sub get_xmlns { 'http://fedex.com/ws/ship/v9' };

our $XML_ATTRIBUTE_CLASS;
undef $XML_ATTRIBUTE_CLASS;

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}

use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %RateType_of :ATTR(:get<RateType>);
my %RateScale_of :ATTR(:get<RateScale>);
my %RateZone_of :ATTR(:get<RateZone>);
my %PricingCode_of :ATTR(:get<PricingCode>);
my %RatedWeightMethod_of :ATTR(:get<RatedWeightMethod>);
my %MinimumChargeType_of :ATTR(:get<MinimumChargeType>);
my %CurrencyExchangeRate_of :ATTR(:get<CurrencyExchangeRate>);
my %SpecialRatingApplied_of :ATTR(:get<SpecialRatingApplied>);
my %DimDivisor_of :ATTR(:get<DimDivisor>);
my %DimDivisorType_of :ATTR(:get<DimDivisorType>);
my %FuelSurchargePercent_of :ATTR(:get<FuelSurchargePercent>);
my %TotalBillingWeight_of :ATTR(:get<TotalBillingWeight>);
my %TotalDimWeight_of :ATTR(:get<TotalDimWeight>);
my %TotalBaseCharge_of :ATTR(:get<TotalBaseCharge>);
my %TotalFreightDiscounts_of :ATTR(:get<TotalFreightDiscounts>);
my %TotalNetFreight_of :ATTR(:get<TotalNetFreight>);
my %TotalSurcharges_of :ATTR(:get<TotalSurcharges>);
my %TotalNetFedExCharge_of :ATTR(:get<TotalNetFedExCharge>);
my %TotalTaxes_of :ATTR(:get<TotalTaxes>);
my %TotalNetCharge_of :ATTR(:get<TotalNetCharge>);
my %TotalRebates_of :ATTR(:get<TotalRebates>);
my %TotalDutiesAndTaxes_of :ATTR(:get<TotalDutiesAndTaxes>);
my %TotalNetChargeWithDutiesAndTaxes_of :ATTR(:get<TotalNetChargeWithDutiesAndTaxes>);
my %FreightRateDetail_of :ATTR(:get<FreightRateDetail>);
my %FreightDiscounts_of :ATTR(:get<FreightDiscounts>);
my %Rebates_of :ATTR(:get<Rebates>);
my %Surcharges_of :ATTR(:get<Surcharges>);
my %Taxes_of :ATTR(:get<Taxes>);
my %DutiesAndTaxes_of :ATTR(:get<DutiesAndTaxes>);
my %VariableHandlingCharges_of :ATTR(:get<VariableHandlingCharges>);
my %TotalVariableHandlingCharges_of :ATTR(:get<TotalVariableHandlingCharges>);

__PACKAGE__->_factory(
    [ qw(        RateType
        RateScale
        RateZone
        PricingCode
        RatedWeightMethod
        MinimumChargeType
        CurrencyExchangeRate
        SpecialRatingApplied
        DimDivisor
        DimDivisorType
        FuelSurchargePercent
        TotalBillingWeight
        TotalDimWeight
        TotalBaseCharge
        TotalFreightDiscounts
        TotalNetFreight
        TotalSurcharges
        TotalNetFedExCharge
        TotalTaxes
        TotalNetCharge
        TotalRebates
        TotalDutiesAndTaxes
        TotalNetChargeWithDutiesAndTaxes
        FreightRateDetail
        FreightDiscounts
        Rebates
        Surcharges
        Taxes
        DutiesAndTaxes
        VariableHandlingCharges
        TotalVariableHandlingCharges

    ) ],
    {
        'RateType' => \%RateType_of,
        'RateScale' => \%RateScale_of,
        'RateZone' => \%RateZone_of,
        'PricingCode' => \%PricingCode_of,
        'RatedWeightMethod' => \%RatedWeightMethod_of,
        'MinimumChargeType' => \%MinimumChargeType_of,
        'CurrencyExchangeRate' => \%CurrencyExchangeRate_of,
        'SpecialRatingApplied' => \%SpecialRatingApplied_of,
        'DimDivisor' => \%DimDivisor_of,
        'DimDivisorType' => \%DimDivisorType_of,
        'FuelSurchargePercent' => \%FuelSurchargePercent_of,
        'TotalBillingWeight' => \%TotalBillingWeight_of,
        'TotalDimWeight' => \%TotalDimWeight_of,
        'TotalBaseCharge' => \%TotalBaseCharge_of,
        'TotalFreightDiscounts' => \%TotalFreightDiscounts_of,
        'TotalNetFreight' => \%TotalNetFreight_of,
        'TotalSurcharges' => \%TotalSurcharges_of,
        'TotalNetFedExCharge' => \%TotalNetFedExCharge_of,
        'TotalTaxes' => \%TotalTaxes_of,
        'TotalNetCharge' => \%TotalNetCharge_of,
        'TotalRebates' => \%TotalRebates_of,
        'TotalDutiesAndTaxes' => \%TotalDutiesAndTaxes_of,
        'TotalNetChargeWithDutiesAndTaxes' => \%TotalNetChargeWithDutiesAndTaxes_of,
        'FreightRateDetail' => \%FreightRateDetail_of,
        'FreightDiscounts' => \%FreightDiscounts_of,
        'Rebates' => \%Rebates_of,
        'Surcharges' => \%Surcharges_of,
        'Taxes' => \%Taxes_of,
        'DutiesAndTaxes' => \%DutiesAndTaxes_of,
        'VariableHandlingCharges' => \%VariableHandlingCharges_of,
        'TotalVariableHandlingCharges' => \%TotalVariableHandlingCharges_of,
    },
    {
        'RateType' => 'Shipment::FedEx::WSDL::ShipTypes::ReturnedRateType',
        'RateScale' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'RateZone' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'PricingCode' => 'Shipment::FedEx::WSDL::ShipTypes::PricingCodeType',
        'RatedWeightMethod' => 'Shipment::FedEx::WSDL::ShipTypes::RatedWeightMethod',
        'MinimumChargeType' => 'Shipment::FedEx::WSDL::ShipTypes::MinimumChargeType',
        'CurrencyExchangeRate' => 'Shipment::FedEx::WSDL::ShipTypes::CurrencyExchangeRate',
        'SpecialRatingApplied' => 'Shipment::FedEx::WSDL::ShipTypes::SpecialRatingAppliedType',
        'DimDivisor' => 'SOAP::WSDL::XSD::Typelib::Builtin::nonNegativeInteger',
        'DimDivisorType' => 'Shipment::FedEx::WSDL::ShipTypes::RateDimensionalDivisorType',
        'FuelSurchargePercent' => 'SOAP::WSDL::XSD::Typelib::Builtin::decimal',
        'TotalBillingWeight' => 'Shipment::FedEx::WSDL::ShipTypes::Weight',
        'TotalDimWeight' => 'Shipment::FedEx::WSDL::ShipTypes::Weight',
        'TotalBaseCharge' => 'Shipment::FedEx::WSDL::ShipTypes::Money',
        'TotalFreightDiscounts' => 'Shipment::FedEx::WSDL::ShipTypes::Money',
        'TotalNetFreight' => 'Shipment::FedEx::WSDL::ShipTypes::Money',
        'TotalSurcharges' => 'Shipment::FedEx::WSDL::ShipTypes::Money',
        'TotalNetFedExCharge' => 'Shipment::FedEx::WSDL::ShipTypes::Money',
        'TotalTaxes' => 'Shipment::FedEx::WSDL::ShipTypes::Money',
        'TotalNetCharge' => 'Shipment::FedEx::WSDL::ShipTypes::Money',
        'TotalRebates' => 'Shipment::FedEx::WSDL::ShipTypes::Money',
        'TotalDutiesAndTaxes' => 'Shipment::FedEx::WSDL::ShipTypes::Money',
        'TotalNetChargeWithDutiesAndTaxes' => 'Shipment::FedEx::WSDL::ShipTypes::Money',
        'FreightRateDetail' => 'Shipment::FedEx::WSDL::ShipTypes::FreightRateDetail',
        'FreightDiscounts' => 'Shipment::FedEx::WSDL::ShipTypes::RateDiscount',
        'Rebates' => 'Shipment::FedEx::WSDL::ShipTypes::Rebate',
        'Surcharges' => 'Shipment::FedEx::WSDL::ShipTypes::Surcharge',
        'Taxes' => 'Shipment::FedEx::WSDL::ShipTypes::Tax',
        'DutiesAndTaxes' => 'Shipment::FedEx::WSDL::ShipTypes::EdtCommodityTax',
        'VariableHandlingCharges' => 'Shipment::FedEx::WSDL::ShipTypes::VariableHandlingCharges',
        'TotalVariableHandlingCharges' => 'Shipment::FedEx::WSDL::ShipTypes::VariableHandlingCharges',
    },
    {

        'RateType' => 'RateType',
        'RateScale' => 'RateScale',
        'RateZone' => 'RateZone',
        'PricingCode' => 'PricingCode',
        'RatedWeightMethod' => 'RatedWeightMethod',
        'MinimumChargeType' => 'MinimumChargeType',
        'CurrencyExchangeRate' => 'CurrencyExchangeRate',
        'SpecialRatingApplied' => 'SpecialRatingApplied',
        'DimDivisor' => 'DimDivisor',
        'DimDivisorType' => 'DimDivisorType',
        'FuelSurchargePercent' => 'FuelSurchargePercent',
        'TotalBillingWeight' => 'TotalBillingWeight',
        'TotalDimWeight' => 'TotalDimWeight',
        'TotalBaseCharge' => 'TotalBaseCharge',
        'TotalFreightDiscounts' => 'TotalFreightDiscounts',
        'TotalNetFreight' => 'TotalNetFreight',
        'TotalSurcharges' => 'TotalSurcharges',
        'TotalNetFedExCharge' => 'TotalNetFedExCharge',
        'TotalTaxes' => 'TotalTaxes',
        'TotalNetCharge' => 'TotalNetCharge',
        'TotalRebates' => 'TotalRebates',
        'TotalDutiesAndTaxes' => 'TotalDutiesAndTaxes',
        'TotalNetChargeWithDutiesAndTaxes' => 'TotalNetChargeWithDutiesAndTaxes',
        'FreightRateDetail' => 'FreightRateDetail',
        'FreightDiscounts' => 'FreightDiscounts',
        'Rebates' => 'Rebates',
        'Surcharges' => 'Surcharges',
        'Taxes' => 'Taxes',
        'DutiesAndTaxes' => 'DutiesAndTaxes',
        'VariableHandlingCharges' => 'VariableHandlingCharges',
        'TotalVariableHandlingCharges' => 'TotalVariableHandlingCharges',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::FedEx::WSDL::ShipTypes::ShipmentRateDetail

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
ShipmentRateDetail from the namespace http://fedex.com/ws/ship/v9.

Data for a shipment's total/summary rates, as calculated per a specific rate type. The "total..." fields may differ from the sum of corresponding package data for Multiweight or Express MPS.




=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * RateType (min/maxOccurs: 0/1)


=item * RateScale (min/maxOccurs: 0/1)


=item * RateZone (min/maxOccurs: 0/1)


=item * PricingCode (min/maxOccurs: 0/1)


=item * RatedWeightMethod (min/maxOccurs: 0/1)


=item * MinimumChargeType (min/maxOccurs: 0/1)


=item * CurrencyExchangeRate (min/maxOccurs: 0/1)


=item * SpecialRatingApplied (min/maxOccurs: 0/unbounded)


=item * DimDivisor (min/maxOccurs: 0/1)


=item * DimDivisorType (min/maxOccurs: 0/1)


=item * FuelSurchargePercent (min/maxOccurs: 0/1)


=item * TotalBillingWeight (min/maxOccurs: 0/1)


=item * TotalDimWeight (min/maxOccurs: 0/1)


=item * TotalBaseCharge (min/maxOccurs: 0/1)


=item * TotalFreightDiscounts (min/maxOccurs: 0/1)


=item * TotalNetFreight (min/maxOccurs: 0/1)


=item * TotalSurcharges (min/maxOccurs: 0/1)


=item * TotalNetFedExCharge (min/maxOccurs: 0/1)


=item * TotalTaxes (min/maxOccurs: 0/1)


=item * TotalNetCharge (min/maxOccurs: 0/1)


=item * TotalRebates (min/maxOccurs: 0/1)


=item * TotalDutiesAndTaxes (min/maxOccurs: 0/1)


=item * TotalNetChargeWithDutiesAndTaxes (min/maxOccurs: 0/1)


=item * FreightRateDetail (min/maxOccurs: 0/1)


=item * FreightDiscounts (min/maxOccurs: 0/unbounded)


=item * Rebates (min/maxOccurs: 0/unbounded)


=item * Surcharges (min/maxOccurs: 0/unbounded)


=item * Taxes (min/maxOccurs: 0/unbounded)


=item * DutiesAndTaxes (min/maxOccurs: 0/unbounded)


=item * VariableHandlingCharges (min/maxOccurs: 0/1)


=item * TotalVariableHandlingCharges (min/maxOccurs: 0/1)




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::FedEx::WSDL::ShipTypes::ShipmentRateDetail
   RateType => $some_value, # ReturnedRateType
   RateScale =>  $some_value, # string
   RateZone =>  $some_value, # string
   PricingCode => $some_value, # PricingCodeType
   RatedWeightMethod => $some_value, # RatedWeightMethod
   MinimumChargeType => $some_value, # MinimumChargeType
   CurrencyExchangeRate =>  { # Shipment::FedEx::WSDL::ShipTypes::CurrencyExchangeRate
     FromCurrency =>  $some_value, # string
     IntoCurrency =>  $some_value, # string
     Rate =>  $some_value, # decimal
   },
   SpecialRatingApplied => $some_value, # SpecialRatingAppliedType
   DimDivisor =>  $some_value, # nonNegativeInteger
   DimDivisorType => $some_value, # RateDimensionalDivisorType
   FuelSurchargePercent =>  $some_value, # decimal
   TotalBillingWeight =>  { # Shipment::FedEx::WSDL::ShipTypes::Weight
     Units => $some_value, # WeightUnits
     Value =>  $some_value, # decimal
   },
   TotalDimWeight => {}, # Shipment::FedEx::WSDL::ShipTypes::Weight
   TotalBaseCharge =>  { # Shipment::FedEx::WSDL::ShipTypes::Money
     Currency =>  $some_value, # string
     Amount =>  $some_value, # decimal
   },
   TotalFreightDiscounts => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
   TotalNetFreight => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
   TotalSurcharges => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
   TotalNetFedExCharge => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
   TotalTaxes => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
   TotalNetCharge => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
   TotalRebates => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
   TotalDutiesAndTaxes => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
   TotalNetChargeWithDutiesAndTaxes => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
   FreightRateDetail =>  { # Shipment::FedEx::WSDL::ShipTypes::FreightRateDetail
     QuoteNumber =>  $some_value, # string
     BaseCharges =>  { # Shipment::FedEx::WSDL::ShipTypes::FreightBaseCharge
       FreightClass => $some_value, # FreightClassType
       RatedAsClass => $some_value, # FreightClassType
       NmfcCode =>  $some_value, # string
       Description =>  $some_value, # string
       Weight => {}, # Shipment::FedEx::WSDL::ShipTypes::Weight
       ChargeRate => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
       ChargeBasis => $some_value, # FreightChargeBasisType
       ExtendedAmount => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
     },
     Notations =>  { # Shipment::FedEx::WSDL::ShipTypes::FreightRateNotation
       Code =>  $some_value, # string
       Description =>  $some_value, # string
     },
   },
   FreightDiscounts =>  { # Shipment::FedEx::WSDL::ShipTypes::RateDiscount
     RateDiscountType => $some_value, # RateDiscountType
     Description =>  $some_value, # string
     Amount => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
     Percent =>  $some_value, # decimal
   },
   Rebates =>  { # Shipment::FedEx::WSDL::ShipTypes::Rebate
     RebateType => $some_value, # RebateType
     Description =>  $some_value, # string
     Amount => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
     Percent =>  $some_value, # decimal
   },
   Surcharges =>  { # Shipment::FedEx::WSDL::ShipTypes::Surcharge
     SurchargeType => $some_value, # SurchargeType
     Level => $some_value, # SurchargeLevelType
     Description =>  $some_value, # string
     Amount => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
   },
   Taxes =>  { # Shipment::FedEx::WSDL::ShipTypes::Tax
     TaxType => $some_value, # TaxType
     Description =>  $some_value, # string
     Amount => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
   },
   DutiesAndTaxes =>  { # Shipment::FedEx::WSDL::ShipTypes::EdtCommodityTax
     HarmonizedCode =>  $some_value, # string
     Taxes =>  { # Shipment::FedEx::WSDL::ShipTypes::EdtTaxDetail
       TaxType => $some_value, # EdtTaxType
       EffectiveDate =>  $some_value, # date
       Name =>  $some_value, # string
       TaxableValue => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
       Description =>  $some_value, # string
       Formula =>  $some_value, # string
       Amount => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
     },
   },
   VariableHandlingCharges =>  { # Shipment::FedEx::WSDL::ShipTypes::VariableHandlingCharges
     VariableHandlingCharge => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
     TotalCustomerCharge => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
   },
   TotalVariableHandlingCharges => {}, # Shipment::FedEx::WSDL::ShipTypes::VariableHandlingCharges
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

