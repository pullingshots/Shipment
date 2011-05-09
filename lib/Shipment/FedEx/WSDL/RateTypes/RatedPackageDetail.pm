package Shipment::FedEx::WSDL::RateTypes::RatedPackageDetail;
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

my %TrackingIds_of :ATTR(:get<TrackingIds>);
my %GroupNumber_of :ATTR(:get<GroupNumber>);
my %EffectiveNetDiscount_of :ATTR(:get<EffectiveNetDiscount>);
my %AdjustedCodCollectionAmount_of :ATTR(:get<AdjustedCodCollectionAmount>);
my %OversizeClass_of :ATTR(:get<OversizeClass>);
my %PackageRateDetail_of :ATTR(:get<PackageRateDetail>);

__PACKAGE__->_factory(
    [ qw(        TrackingIds
        GroupNumber
        EffectiveNetDiscount
        AdjustedCodCollectionAmount
        OversizeClass
        PackageRateDetail

    ) ],
    {
        'TrackingIds' => \%TrackingIds_of,
        'GroupNumber' => \%GroupNumber_of,
        'EffectiveNetDiscount' => \%EffectiveNetDiscount_of,
        'AdjustedCodCollectionAmount' => \%AdjustedCodCollectionAmount_of,
        'OversizeClass' => \%OversizeClass_of,
        'PackageRateDetail' => \%PackageRateDetail_of,
    },
    {
        'TrackingIds' => 'Shipment::FedEx::WSDL::RateTypes::TrackingId',
        'GroupNumber' => 'SOAP::WSDL::XSD::Typelib::Builtin::nonNegativeInteger',
        'EffectiveNetDiscount' => 'Shipment::FedEx::WSDL::RateTypes::Money',
        'AdjustedCodCollectionAmount' => 'Shipment::FedEx::WSDL::RateTypes::Money',
        'OversizeClass' => 'Shipment::FedEx::WSDL::RateTypes::OversizeClassType',
        'PackageRateDetail' => 'Shipment::FedEx::WSDL::RateTypes::PackageRateDetail',
    },
    {

        'TrackingIds' => 'TrackingIds',
        'GroupNumber' => 'GroupNumber',
        'EffectiveNetDiscount' => 'EffectiveNetDiscount',
        'AdjustedCodCollectionAmount' => 'AdjustedCodCollectionAmount',
        'OversizeClass' => 'OversizeClass',
        'PackageRateDetail' => 'PackageRateDetail',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::FedEx::WSDL::RateTypes::RatedPackageDetail

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
RatedPackageDetail from the namespace http://fedex.com/ws/rate/v9.

If requesting rates using the PackageDetails element (one package at a time) in the request, the rates for each package will be returned in this element. Currently total piece total weight rates are also retuned in this element.




=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * TrackingIds (min/maxOccurs: 0/unbounded)


=item * GroupNumber (min/maxOccurs: 0/1)


=item * EffectiveNetDiscount (min/maxOccurs: 0/1)


=item * AdjustedCodCollectionAmount (min/maxOccurs: 0/1)


=item * OversizeClass (min/maxOccurs: 0/1)


=item * PackageRateDetail (min/maxOccurs: 0/1)




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::FedEx::WSDL::RateTypes::RatedPackageDetail
   TrackingIds =>  { # Shipment::FedEx::WSDL::RateTypes::TrackingId
     TrackingIdType => $some_value, # TrackingIdType
     FormId =>  $some_value, # string
     TrackingNumber =>  $some_value, # string
   },
   GroupNumber =>  $some_value, # nonNegativeInteger
   EffectiveNetDiscount =>  { # Shipment::FedEx::WSDL::RateTypes::Money
     Currency =>  $some_value, # string
     Amount =>  $some_value, # decimal
   },
   AdjustedCodCollectionAmount => {}, # Shipment::FedEx::WSDL::RateTypes::Money
   OversizeClass => $some_value, # OversizeClassType
   PackageRateDetail =>  { # Shipment::FedEx::WSDL::RateTypes::PackageRateDetail
     RateType => $some_value, # ReturnedRateType
     RatedWeightMethod => $some_value, # RatedWeightMethod
     MinimumChargeType => $some_value, # MinimumChargeType
     BillingWeight =>  { # Shipment::FedEx::WSDL::RateTypes::Weight
       Units => $some_value, # WeightUnits
       Value =>  $some_value, # decimal
     },
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
     VariableHandlingCharges =>  { # Shipment::FedEx::WSDL::RateTypes::VariableHandlingCharges
       VariableHandlingCharge => {}, # Shipment::FedEx::WSDL::RateTypes::Money
       TotalCustomerCharge => {}, # Shipment::FedEx::WSDL::RateTypes::Money
     },
   },
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

