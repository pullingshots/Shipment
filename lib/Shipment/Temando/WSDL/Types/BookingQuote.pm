package Shipment::Temando::WSDL::Types::BookingQuote;
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

my %totalPrice_of :ATTR(:get<totalPrice>);
my %basePrice_of :ATTR(:get<basePrice>);
my %tax_of :ATTR(:get<tax>);
my %currency_of :ATTR(:get<currency>);
my %deliveryMethod_of :ATTR(:get<deliveryMethod>);
my %etaFrom_of :ATTR(:get<etaFrom>);
my %etaTo_of :ATTR(:get<etaTo>);
my %guaranteedEta_of :ATTR(:get<guaranteedEta>);
my %carrierId_of :ATTR(:get<carrierId>);
my %extras_of :ATTR(:get<extras>);

__PACKAGE__->_factory(
    [ qw(        totalPrice
        basePrice
        tax
        currency
        deliveryMethod
        etaFrom
        etaTo
        guaranteedEta
        carrierId
        extras

    ) ],
    {
        'totalPrice' => \%totalPrice_of,
        'basePrice' => \%basePrice_of,
        'tax' => \%tax_of,
        'currency' => \%currency_of,
        'deliveryMethod' => \%deliveryMethod_of,
        'etaFrom' => \%etaFrom_of,
        'etaTo' => \%etaTo_of,
        'guaranteedEta' => \%guaranteedEta_of,
        'carrierId' => \%carrierId_of,
        'extras' => \%extras_of,
    },
    {
        'totalPrice' => 'Shipment::Temando::WSDL::Types::CurrencyAmount',
        'basePrice' => 'Shipment::Temando::WSDL::Types::CurrencyAmount',
        'tax' => 'Shipment::Temando::WSDL::Types::CurrencyAmount',
        'currency' => 'Shipment::Temando::WSDL::Types::CurrencyType',
        'deliveryMethod' => 'Shipment::Temando::WSDL::Types::DeliveryMethod',
        'etaFrom' => 'Shipment::Temando::WSDL::Types::Eta',
        'etaTo' => 'Shipment::Temando::WSDL::Types::Eta',
        'guaranteedEta' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'carrierId' => 'Shipment::Temando::WSDL::Types::CarrierId',

        'extras' => 'Shipment::Temando::WSDL::Types::BookingQuote::_extras',
    },
    {

        'totalPrice' => 'totalPrice',
        'basePrice' => 'basePrice',
        'tax' => 'tax',
        'currency' => 'currency',
        'deliveryMethod' => 'deliveryMethod',
        'etaFrom' => 'etaFrom',
        'etaTo' => 'etaTo',
        'guaranteedEta' => 'guaranteedEta',
        'carrierId' => 'carrierId',
        'extras' => 'extras',
    }
);

} # end BLOCK




package Shipment::Temando::WSDL::Types::BookingQuote::_extras;
use strict;
use warnings;
{
our $XML_ATTRIBUTE_CLASS;
undef $XML_ATTRIBUTE_CLASS;

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}

use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %extra_of :ATTR(:get<extra>);

__PACKAGE__->_factory(
    [ qw(        extra

    ) ],
    {
        'extra' => \%extra_of,
    },
    {
        'extra' => 'Shipment::Temando::WSDL::Types::Extra',
    },
    {

        'extra' => 'extra',
    }
);

} # end BLOCK






}






1;


=pod

=head1 NAME

Shipment::Temando::WSDL::Types::BookingQuote

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
BookingQuote from the namespace http://' . $Shipment::Temando::WSDL::Interfaces::quoting_Service::quoting_port::ns_url . '/schema/2009_06/common.xsd.






=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * totalPrice (min/maxOccurs: 0/1)


=item * basePrice (min/maxOccurs: 0/1)


=item * tax (min/maxOccurs: 0/1)


=item * currency (min/maxOccurs: 0/1)


=item * deliveryMethod (min/maxOccurs: 0/1)


=item * etaFrom (min/maxOccurs: 0/1)


=item * etaTo (min/maxOccurs: 0/1)


=item * guaranteedEta (min/maxOccurs: 0/1)


=item * carrierId (min/maxOccurs: 0/1)


=item * extras (min/maxOccurs: 0/1)




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::Temando::WSDL::Types::BookingQuote
   totalPrice => $some_value, # CurrencyAmount
   basePrice => $some_value, # CurrencyAmount
   tax => $some_value, # CurrencyAmount
   currency => $some_value, # CurrencyType
   deliveryMethod => $some_value, # DeliveryMethod
   etaFrom => $some_value, # Eta
   etaTo => $some_value, # Eta
   guaranteedEta => $some_value, # YesNoOption
   carrierId => $some_value, # CarrierId
   extras =>  {
     extra =>  { # Shipment::Temando::WSDL::Types::Extra
       summary => $some_value, # ExtraSummary
       details => $some_value, # ExtraDetails
       totalPrice => $some_value, # CurrencyAmount
       basePrice => $some_value, # CurrencyAmount
       tax => $some_value, # CurrencyAmount
       adjustments =>  {
         adjustment =>  { # Shipment::Temando::WSDL::Types::Adjustment
           description => $some_value, # AdjustmentDescription
           amount => $some_value, # CurrencyAmount
           tax => $some_value, # CurrencyAmount
         },
       },
     },
   },
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

