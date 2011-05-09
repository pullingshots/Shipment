package Shipment::FedEx::WSDL::ShipTypes::PackageRateDetail;
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
my %RatedWeightMethod_of :ATTR(:get<RatedWeightMethod>);
my %MinimumChargeType_of :ATTR(:get<MinimumChargeType>);
my %BillingWeight_of :ATTR(:get<BillingWeight>);
my %DimWeight_of :ATTR(:get<DimWeight>);
my %OversizeWeight_of :ATTR(:get<OversizeWeight>);
my %BaseCharge_of :ATTR(:get<BaseCharge>);
my %TotalFreightDiscounts_of :ATTR(:get<TotalFreightDiscounts>);
my %NetFreight_of :ATTR(:get<NetFreight>);
my %TotalSurcharges_of :ATTR(:get<TotalSurcharges>);
my %NetFedExCharge_of :ATTR(:get<NetFedExCharge>);
my %TotalTaxes_of :ATTR(:get<TotalTaxes>);
my %NetCharge_of :ATTR(:get<NetCharge>);
my %TotalRebates_of :ATTR(:get<TotalRebates>);
my %FreightDiscounts_of :ATTR(:get<FreightDiscounts>);
my %Rebates_of :ATTR(:get<Rebates>);
my %Surcharges_of :ATTR(:get<Surcharges>);
my %Taxes_of :ATTR(:get<Taxes>);
my %VariableHandlingCharges_of :ATTR(:get<VariableHandlingCharges>);

__PACKAGE__->_factory(
    [ qw(        RateType
        RatedWeightMethod
        MinimumChargeType
        BillingWeight
        DimWeight
        OversizeWeight
        BaseCharge
        TotalFreightDiscounts
        NetFreight
        TotalSurcharges
        NetFedExCharge
        TotalTaxes
        NetCharge
        TotalRebates
        FreightDiscounts
        Rebates
        Surcharges
        Taxes
        VariableHandlingCharges

    ) ],
    {
        'RateType' => \%RateType_of,
        'RatedWeightMethod' => \%RatedWeightMethod_of,
        'MinimumChargeType' => \%MinimumChargeType_of,
        'BillingWeight' => \%BillingWeight_of,
        'DimWeight' => \%DimWeight_of,
        'OversizeWeight' => \%OversizeWeight_of,
        'BaseCharge' => \%BaseCharge_of,
        'TotalFreightDiscounts' => \%TotalFreightDiscounts_of,
        'NetFreight' => \%NetFreight_of,
        'TotalSurcharges' => \%TotalSurcharges_of,
        'NetFedExCharge' => \%NetFedExCharge_of,
        'TotalTaxes' => \%TotalTaxes_of,
        'NetCharge' => \%NetCharge_of,
        'TotalRebates' => \%TotalRebates_of,
        'FreightDiscounts' => \%FreightDiscounts_of,
        'Rebates' => \%Rebates_of,
        'Surcharges' => \%Surcharges_of,
        'Taxes' => \%Taxes_of,
        'VariableHandlingCharges' => \%VariableHandlingCharges_of,
    },
    {
        'RateType' => 'Shipment::FedEx::WSDL::ShipTypes::ReturnedRateType',
        'RatedWeightMethod' => 'Shipment::FedEx::WSDL::ShipTypes::RatedWeightMethod',
        'MinimumChargeType' => 'Shipment::FedEx::WSDL::ShipTypes::MinimumChargeType',
        'BillingWeight' => 'Shipment::FedEx::WSDL::ShipTypes::Weight',
        'DimWeight' => 'Shipment::FedEx::WSDL::ShipTypes::Weight',
        'OversizeWeight' => 'Shipment::FedEx::WSDL::ShipTypes::Weight',
        'BaseCharge' => 'Shipment::FedEx::WSDL::ShipTypes::Money',
        'TotalFreightDiscounts' => 'Shipment::FedEx::WSDL::ShipTypes::Money',
        'NetFreight' => 'Shipment::FedEx::WSDL::ShipTypes::Money',
        'TotalSurcharges' => 'Shipment::FedEx::WSDL::ShipTypes::Money',
        'NetFedExCharge' => 'Shipment::FedEx::WSDL::ShipTypes::Money',
        'TotalTaxes' => 'Shipment::FedEx::WSDL::ShipTypes::Money',
        'NetCharge' => 'Shipment::FedEx::WSDL::ShipTypes::Money',
        'TotalRebates' => 'Shipment::FedEx::WSDL::ShipTypes::Money',
        'FreightDiscounts' => 'Shipment::FedEx::WSDL::ShipTypes::RateDiscount',
        'Rebates' => 'Shipment::FedEx::WSDL::ShipTypes::Rebate',
        'Surcharges' => 'Shipment::FedEx::WSDL::ShipTypes::Surcharge',
        'Taxes' => 'Shipment::FedEx::WSDL::ShipTypes::Tax',
        'VariableHandlingCharges' => 'Shipment::FedEx::WSDL::ShipTypes::VariableHandlingCharges',
    },
    {

        'RateType' => 'RateType',
        'RatedWeightMethod' => 'RatedWeightMethod',
        'MinimumChargeType' => 'MinimumChargeType',
        'BillingWeight' => 'BillingWeight',
        'DimWeight' => 'DimWeight',
        'OversizeWeight' => 'OversizeWeight',
        'BaseCharge' => 'BaseCharge',
        'TotalFreightDiscounts' => 'TotalFreightDiscounts',
        'NetFreight' => 'NetFreight',
        'TotalSurcharges' => 'TotalSurcharges',
        'NetFedExCharge' => 'NetFedExCharge',
        'TotalTaxes' => 'TotalTaxes',
        'NetCharge' => 'NetCharge',
        'TotalRebates' => 'TotalRebates',
        'FreightDiscounts' => 'FreightDiscounts',
        'Rebates' => 'Rebates',
        'Surcharges' => 'Surcharges',
        'Taxes' => 'Taxes',
        'VariableHandlingCharges' => 'VariableHandlingCharges',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::FedEx::WSDL::ShipTypes::PackageRateDetail

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
PackageRateDetail from the namespace http://fedex.com/ws/ship/v9.

Data for a package's rates, as calculated per a specific rate type.




=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * RateType (min/maxOccurs: 0/1)


=item * RatedWeightMethod (min/maxOccurs: 0/1)


=item * MinimumChargeType (min/maxOccurs: 0/1)


=item * BillingWeight (min/maxOccurs: 0/1)


=item * DimWeight (min/maxOccurs: 0/1)


=item * OversizeWeight (min/maxOccurs: 0/1)


=item * BaseCharge (min/maxOccurs: 0/1)


=item * TotalFreightDiscounts (min/maxOccurs: 0/1)


=item * NetFreight (min/maxOccurs: 0/1)


=item * TotalSurcharges (min/maxOccurs: 0/1)


=item * NetFedExCharge (min/maxOccurs: 0/1)


=item * TotalTaxes (min/maxOccurs: 0/1)


=item * NetCharge (min/maxOccurs: 0/1)


=item * TotalRebates (min/maxOccurs: 0/1)


=item * FreightDiscounts (min/maxOccurs: 0/unbounded)


=item * Rebates (min/maxOccurs: 0/unbounded)


=item * Surcharges (min/maxOccurs: 0/unbounded)


=item * Taxes (min/maxOccurs: 0/unbounded)


=item * VariableHandlingCharges (min/maxOccurs: 0/1)




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::FedEx::WSDL::ShipTypes::PackageRateDetail
   RateType => $some_value, # ReturnedRateType
   RatedWeightMethod => $some_value, # RatedWeightMethod
   MinimumChargeType => $some_value, # MinimumChargeType
   BillingWeight =>  { # Shipment::FedEx::WSDL::ShipTypes::Weight
     Units => $some_value, # WeightUnits
     Value =>  $some_value, # decimal
   },
   DimWeight => {}, # Shipment::FedEx::WSDL::ShipTypes::Weight
   OversizeWeight => {}, # Shipment::FedEx::WSDL::ShipTypes::Weight
   BaseCharge =>  { # Shipment::FedEx::WSDL::ShipTypes::Money
     Currency =>  $some_value, # string
     Amount =>  $some_value, # decimal
   },
   TotalFreightDiscounts => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
   NetFreight => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
   TotalSurcharges => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
   NetFedExCharge => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
   TotalTaxes => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
   NetCharge => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
   TotalRebates => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
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
   VariableHandlingCharges =>  { # Shipment::FedEx::WSDL::ShipTypes::VariableHandlingCharges
     VariableHandlingCharge => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
     TotalCustomerCharge => {}, # Shipment::FedEx::WSDL::ShipTypes::Money
   },
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

