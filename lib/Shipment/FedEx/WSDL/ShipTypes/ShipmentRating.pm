package Shipment::FedEx::WSDL::ShipTypes::ShipmentRating;
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

my %ActualRateType_of :ATTR(:get<ActualRateType>);
my %EffectiveNetDiscount_of :ATTR(:get<EffectiveNetDiscount>);
my %ShipmentRateDetails_of :ATTR(:get<ShipmentRateDetails>);

__PACKAGE__->_factory(
    [ qw(        ActualRateType
        EffectiveNetDiscount
        ShipmentRateDetails

    ) ],
    {
        'ActualRateType' => \%ActualRateType_of,
        'EffectiveNetDiscount' => \%EffectiveNetDiscount_of,
        'ShipmentRateDetails' => \%ShipmentRateDetails_of,
    },
    {
        'ActualRateType' => 'Shipment::FedEx::WSDL::ShipTypes::ReturnedRateType',
        'EffectiveNetDiscount' => 'Shipment::FedEx::WSDL::ShipTypes::Money',
        'ShipmentRateDetails' => 'Shipment::FedEx::WSDL::ShipTypes::ShipmentRateDetail',
    },
    {

        'ActualRateType' => 'ActualRateType',
        'EffectiveNetDiscount' => 'EffectiveNetDiscount',
        'ShipmentRateDetails' => 'ShipmentRateDetails',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::FedEx::WSDL::ShipTypes::ShipmentRating

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
ShipmentRating from the namespace http://fedex.com/ws/ship/v9.

This class groups together all shipment-level rate data (across all rate types) as part of the response to a shipping request, which groups shipment-level data together and groups package-level data by package.




=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * ActualRateType (min/maxOccurs: 0/1)


=item * EffectiveNetDiscount (min/maxOccurs: 0/1)


=item * ShipmentRateDetails (min/maxOccurs: 0/unbounded)




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::FedEx::WSDL::ShipTypes::ShipmentRating
   ActualRateType => $some_value, # ReturnedRateType
   EffectiveNetDiscount =>  { # Shipment::FedEx::WSDL::ShipTypes::Money
     Currency =>  $some_value, # string
     Amount =>  $some_value, # decimal
   },
   ShipmentRateDetails =>  { # Shipment::FedEx::WSDL::ShipTypes::ShipmentRateDetail
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
     TotalBaseCharge => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
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
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

