package Shipment::Temando::WSDL::Types::AvailableQuote;
use strict;
use warnings;


__PACKAGE__->_set_element_form_qualified(0);

sub get_xmlns { 'http://' . $Shipment::Temando::WSDL::Interfaces::quoting_Service::quoting_port::ns_url . '/schema/2009_06/common.xsd' };

our $XML_ATTRIBUTE_CLASS = 'Shipment::Temando::WSDL::Types::AvailableQuote::_AvailableQuote::XmlAttr';

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}

use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %generated_of :ATTR(:get<generated>);
my %accepted_of :ATTR(:get<accepted>);
my %bookingNumber_of :ATTR(:get<bookingNumber>);
my %consignmentNumber_of :ATTR(:get<consignmentNumber>);
my %consignmentDocument_of :ATTR(:get<consignmentDocument>);
my %consignmentDocumentType_of :ATTR(:get<consignmentDocumentType>);
my %labelDocument_of :ATTR(:get<labelDocument>);
my %labelDocumentType_of :ATTR(:get<labelDocumentType>);
my %manifestNumber_of :ATTR(:get<manifestNumber>);
my %articles_of :ATTR(:get<articles>);
my %trackingStatus_of :ATTR(:get<trackingStatus>);
my %trackingStatusOccurred_of :ATTR(:get<trackingStatusOccurred>);
my %trackingLastChecked_of :ATTR(:get<trackingLastChecked>);
my %trackingFurtherDetails_of :ATTR(:get<trackingFurtherDetails>);
my %totalPrice_of :ATTR(:get<totalPrice>);
my %basePrice_of :ATTR(:get<basePrice>);
my %tax_of :ATTR(:get<tax>);
my %currency_of :ATTR(:get<currency>);
my %deliveryMethod_of :ATTR(:get<deliveryMethod>);
my %usingGeneralRail_of :ATTR(:get<usingGeneralRail>);
my %usingGeneralRoad_of :ATTR(:get<usingGeneralRoad>);
my %usingGeneralSea_of :ATTR(:get<usingGeneralSea>);
my %usingExpressAir_of :ATTR(:get<usingExpressAir>);
my %usingExpressRoad_of :ATTR(:get<usingExpressRoad>);
my %etaFrom_of :ATTR(:get<etaFrom>);
my %etaTo_of :ATTR(:get<etaTo>);
my %guaranteedEta_of :ATTR(:get<guaranteedEta>);
my %adjustments_of :ATTR(:get<adjustments>);
my %inclusions_of :ATTR(:get<inclusions>);
my %extras_of :ATTR(:get<extras>);
my %carrier_of :ATTR(:get<carrier>);
my %originatingDepot_of :ATTR(:get<originatingDepot>);
my %destinationDepot_of :ATTR(:get<destinationDepot>);

__PACKAGE__->_factory(
    [ qw(        generated
        accepted
        bookingNumber
        consignmentNumber
        consignmentDocument
        consignmentDocumentType
        labelDocument
        labelDocumentType
        manifestNumber
        articles
        trackingStatus
        trackingStatusOccurred
        trackingLastChecked
        trackingFurtherDetails
        totalPrice
        basePrice
        tax
        currency
        deliveryMethod
        usingGeneralRail
        usingGeneralRoad
        usingGeneralSea
        usingExpressAir
        usingExpressRoad
        etaFrom
        etaTo
        guaranteedEta
        adjustments
        inclusions
        extras
        carrier
        originatingDepot
        destinationDepot

    ) ],
    {
        'generated' => \%generated_of,
        'accepted' => \%accepted_of,
        'bookingNumber' => \%bookingNumber_of,
        'consignmentNumber' => \%consignmentNumber_of,
        'consignmentDocument' => \%consignmentDocument_of,
        'consignmentDocumentType' => \%consignmentDocumentType_of,
        'labelDocument' => \%labelDocument_of,
        'labelDocumentType' => \%labelDocumentType_of,
        'manifestNumber' => \%manifestNumber_of,
        'articles' => \%articles_of,
        'trackingStatus' => \%trackingStatus_of,
        'trackingStatusOccurred' => \%trackingStatusOccurred_of,
        'trackingLastChecked' => \%trackingLastChecked_of,
        'trackingFurtherDetails' => \%trackingFurtherDetails_of,
        'totalPrice' => \%totalPrice_of,
        'basePrice' => \%basePrice_of,
        'tax' => \%tax_of,
        'currency' => \%currency_of,
        'deliveryMethod' => \%deliveryMethod_of,
        'usingGeneralRail' => \%usingGeneralRail_of,
        'usingGeneralRoad' => \%usingGeneralRoad_of,
        'usingGeneralSea' => \%usingGeneralSea_of,
        'usingExpressAir' => \%usingExpressAir_of,
        'usingExpressRoad' => \%usingExpressRoad_of,
        'etaFrom' => \%etaFrom_of,
        'etaTo' => \%etaTo_of,
        'guaranteedEta' => \%guaranteedEta_of,
        'adjustments' => \%adjustments_of,
        'inclusions' => \%inclusions_of,
        'extras' => \%extras_of,
        'carrier' => \%carrier_of,
        'originatingDepot' => \%originatingDepot_of,
        'destinationDepot' => \%destinationDepot_of,
    },
    {
        'generated' => 'Shipment::Temando::WSDL::Types::GeneratedType',
        'accepted' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'bookingNumber' => 'Shipment::Temando::WSDL::Types::BookingNumber',
        'consignmentNumber' => 'Shipment::Temando::WSDL::Types::ConsignmentNumber',
        'consignmentDocument' => 'Shipment::Temando::WSDL::Types::ConsignmentDocument',
        'consignmentDocumentType' => 'Shipment::Temando::WSDL::Types::ConsignmentDocumentType',
        'labelDocument' => 'Shipment::Temando::WSDL::Types::LabelDocument',
        'labelDocumentType' => 'Shipment::Temando::WSDL::Types::LabelDocumentType',
        'manifestNumber' => 'Shipment::Temando::WSDL::Types::ManifestNumber',

        'articles' => 'Shipment::Temando::WSDL::Types::AvailableQuote::_articles',
        'trackingStatus' => 'Shipment::Temando::WSDL::Types::TrackingStatus',
        'trackingStatusOccurred' => 'Shipment::Temando::WSDL::Types::Datetime',
        'trackingLastChecked' => 'Shipment::Temando::WSDL::Types::Datetime',
        'trackingFurtherDetails' => 'Shipment::Temando::WSDL::Types::TrackingFurtherDetails',
        'totalPrice' => 'Shipment::Temando::WSDL::Types::CurrencyAmount',
        'basePrice' => 'Shipment::Temando::WSDL::Types::CurrencyAmount',
        'tax' => 'Shipment::Temando::WSDL::Types::CurrencyAmount',
        'currency' => 'Shipment::Temando::WSDL::Types::CurrencyType',
        'deliveryMethod' => 'Shipment::Temando::WSDL::Types::DeliveryMethod',
        'usingGeneralRail' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'usingGeneralRoad' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'usingGeneralSea' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'usingExpressAir' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'usingExpressRoad' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'etaFrom' => 'Shipment::Temando::WSDL::Types::Eta',
        'etaTo' => 'Shipment::Temando::WSDL::Types::Eta',
        'guaranteedEta' => 'Shipment::Temando::WSDL::Types::YesNoOption',

        'adjustments' => 'Shipment::Temando::WSDL::Types::AvailableQuote::_adjustments',

        'inclusions' => 'Shipment::Temando::WSDL::Types::AvailableQuote::_inclusions',

        'extras' => 'Shipment::Temando::WSDL::Types::AvailableQuote::_extras',
        'carrier' => 'Shipment::Temando::WSDL::Types::Carrier',
        'originatingDepot' => 'Shipment::Temando::WSDL::Types::Depot',
        'destinationDepot' => 'Shipment::Temando::WSDL::Types::Depot',
    },
    {

        'generated' => 'generated',
        'accepted' => 'accepted',
        'bookingNumber' => 'bookingNumber',
        'consignmentNumber' => 'consignmentNumber',
        'consignmentDocument' => 'consignmentDocument',
        'consignmentDocumentType' => 'consignmentDocumentType',
        'labelDocument' => 'labelDocument',
        'labelDocumentType' => 'labelDocumentType',
        'manifestNumber' => 'manifestNumber',
        'articles' => 'articles',
        'trackingStatus' => 'trackingStatus',
        'trackingStatusOccurred' => 'trackingStatusOccurred',
        'trackingLastChecked' => 'trackingLastChecked',
        'trackingFurtherDetails' => 'trackingFurtherDetails',
        'totalPrice' => 'totalPrice',
        'basePrice' => 'basePrice',
        'tax' => 'tax',
        'currency' => 'currency',
        'deliveryMethod' => 'deliveryMethod',
        'usingGeneralRail' => 'usingGeneralRail',
        'usingGeneralRoad' => 'usingGeneralRoad',
        'usingGeneralSea' => 'usingGeneralSea',
        'usingExpressAir' => 'usingExpressAir',
        'usingExpressRoad' => 'usingExpressRoad',
        'etaFrom' => 'etaFrom',
        'etaTo' => 'etaTo',
        'guaranteedEta' => 'guaranteedEta',
        'adjustments' => 'adjustments',
        'inclusions' => 'inclusions',
        'extras' => 'extras',
        'carrier' => 'carrier',
        'originatingDepot' => 'originatingDepot',
        'destinationDepot' => 'destinationDepot',
    }
);

} # end BLOCK




package Shipment::Temando::WSDL::Types::AvailableQuote::_adjustments;
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

my %adjustment_of :ATTR(:get<adjustment>);

__PACKAGE__->_factory(
    [ qw(        adjustment

    ) ],
    {
        'adjustment' => \%adjustment_of,
    },
    {
        'adjustment' => 'Shipment::Temando::WSDL::Types::Adjustment',
    },
    {

        'adjustment' => 'adjustment',
    }
);

} # end BLOCK






}



package Shipment::Temando::WSDL::Types::AvailableQuote::_articles;
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

my %article_of :ATTR(:get<article>);

__PACKAGE__->_factory(
    [ qw(        article

    ) ],
    {
        'article' => \%article_of,
    },
    {
        'article' => 'Shipment::Temando::WSDL::Types::Article',
    },
    {

        'article' => 'article',
    }
);

} # end BLOCK






}



package Shipment::Temando::WSDL::Types::AvailableQuote::_extras;
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



package Shipment::Temando::WSDL::Types::AvailableQuote::_inclusions;
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

my %inclusion_of :ATTR(:get<inclusion>);

__PACKAGE__->_factory(
    [ qw(        inclusion

    ) ],
    {
        'inclusion' => \%inclusion_of,
    },
    {
        'inclusion' => 'Shipment::Temando::WSDL::Types::Inclusion',
    },
    {

        'inclusion' => 'inclusion',
    }
);

} # end BLOCK






}



package Shipment::Temando::WSDL::Types::AvailableQuote::_AvailableQuote::XmlAttr;
use base qw(SOAP::WSDL::XSD::Typelib::AttributeSet);

{ # BLOCK to scope variables

my %id_of :ATTR(:get<id>);

__PACKAGE__->_factory(
    [ qw(
        id
    ) ],
    {

        id => \%id_of,
    },
    {
        id => 'SOAP::WSDL::XSD::Typelib::Builtin::positiveInteger',
    }
);

} # end BLOCK



1;


=pod

=head1 NAME

Shipment::Temando::WSDL::Types::AvailableQuote

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
AvailableQuote from the namespace http://' . $Shipment::Temando::WSDL::Interfaces::quoting_Service::quoting_port::ns_url . '/schema/2009_06/common.xsd.






=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * generated (min/maxOccurs: 0/1)


=item * accepted (min/maxOccurs: 0/1)


=item * bookingNumber (min/maxOccurs: 0/1)


=item * consignmentNumber (min/maxOccurs: 0/1)


=item * consignmentDocument (min/maxOccurs: 0/1)


=item * consignmentDocumentType (min/maxOccurs: 0/1)


=item * labelDocument (min/maxOccurs: 0/1)


=item * labelDocumentType (min/maxOccurs: 0/1)


=item * manifestNumber (min/maxOccurs: 0/1)


=item * articles (min/maxOccurs: 0/1)


=item * trackingStatus (min/maxOccurs: 0/1)


=item * trackingStatusOccurred (min/maxOccurs: 0/1)


=item * trackingLastChecked (min/maxOccurs: 0/1)


=item * trackingFurtherDetails (min/maxOccurs: 0/1)


=item * totalPrice (min/maxOccurs: 0/1)


=item * basePrice (min/maxOccurs: 0/1)


=item * tax (min/maxOccurs: 0/1)


=item * currency (min/maxOccurs: 0/1)


=item * deliveryMethod (min/maxOccurs: 0/1)


=item * usingGeneralRail (min/maxOccurs: 0/1)


=item * usingGeneralRoad (min/maxOccurs: 0/1)


=item * usingGeneralSea (min/maxOccurs: 0/1)


=item * usingExpressAir (min/maxOccurs: 0/1)


=item * usingExpressRoad (min/maxOccurs: 0/1)


=item * etaFrom (min/maxOccurs: 0/1)


=item * etaTo (min/maxOccurs: 0/1)


=item * guaranteedEta (min/maxOccurs: 0/1)


=item * adjustments (min/maxOccurs: 0/1)


=item * inclusions (min/maxOccurs: 0/1)


=item * extras (min/maxOccurs: 0/1)


=item * carrier (min/maxOccurs: 0/1)


=item * originatingDepot (min/maxOccurs: 0/1)


=item * destinationDepot (min/maxOccurs: 0/1)




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::Temando::WSDL::Types::AvailableQuote
   generated => $some_value, # GeneratedType
   accepted => $some_value, # YesNoOption
   bookingNumber => $some_value, # BookingNumber
   consignmentNumber => $some_value, # ConsignmentNumber
   consignmentDocument => $some_value, # ConsignmentDocument
   consignmentDocumentType => $some_value, # ConsignmentDocumentType
   labelDocument => $some_value, # LabelDocument
   labelDocumentType => $some_value, # LabelDocumentType
   manifestNumber => $some_value, # ManifestNumber
   articles =>  {
     article =>  { # Shipment::Temando::WSDL::Types::Article
       anythingIndex => $some_value, # AnythingIndex
       articleNumber => $some_value, # ArticleNumber
       labelDocument => $some_value, # LabelDocument
       labelDocumentType => $some_value, # LabelDocumentType
     },
   },
   trackingStatus => $some_value, # TrackingStatus
   trackingStatusOccurred => $some_value, # Datetime
   trackingLastChecked => $some_value, # Datetime
   trackingFurtherDetails => $some_value, # TrackingFurtherDetails
   totalPrice => $some_value, # CurrencyAmount
   basePrice => $some_value, # CurrencyAmount
   tax => $some_value, # CurrencyAmount
   currency => $some_value, # CurrencyType
   deliveryMethod => $some_value, # DeliveryMethod
   usingGeneralRail => $some_value, # YesNoOption
   usingGeneralRoad => $some_value, # YesNoOption
   usingGeneralSea => $some_value, # YesNoOption
   usingExpressAir => $some_value, # YesNoOption
   usingExpressRoad => $some_value, # YesNoOption
   etaFrom => $some_value, # Eta
   etaTo => $some_value, # Eta
   guaranteedEta => $some_value, # YesNoOption
   adjustments =>  {
     adjustment =>  { # Shipment::Temando::WSDL::Types::Adjustment
       description => $some_value, # AdjustmentDescription
       amount => $some_value, # CurrencyAmount
       tax => $some_value, # CurrencyAmount
     },
   },
   inclusions =>  {
     inclusion =>  { # Shipment::Temando::WSDL::Types::Inclusion
       summary => $some_value, # InclusionSummary
       details => $some_value, # InclusionDetails
     },
   },
   extras =>  {
     extra =>  { # Shipment::Temando::WSDL::Types::Extra
       summary => $some_value, # ExtraSummary
       details => $some_value, # ExtraDetails
       totalPrice => $some_value, # CurrencyAmount
       basePrice => $some_value, # CurrencyAmount
       tax => $some_value, # CurrencyAmount
       adjustments =>  {
         adjustment => {}, # Shipment::Temando::WSDL::Types::Adjustment
       },
     },
   },
   carrier =>  { # Shipment::Temando::WSDL::Types::Carrier
     id => $some_value, # CarrierId
     companyName => $some_value, # CompanyName
     companyContact => $some_value, # ContactName
     streetAddress => $some_value, # Address
     streetSuburb => $some_value, # Suburb
     streetCity => $some_value, # City
     streetState => $some_value, # State
     streetCode => $some_value, # PostalCode
     streetCountry => $some_value, # CountryCode
     postalAddress => $some_value, # Address
     postalSuburb => $some_value, # Suburb
     postalCity => $some_value, # City
     postalState => $some_value, # State
     postalCode => $some_value, # PostalCode
     postalCountry => $some_value, # CountryCode
     phone1 => $some_value, # Phone
     phone2 => $some_value, # Phone
     email => $some_value, # Email
     website => $some_value, # Website
     conditions => $some_value, # CarrierConditions
   },
   originatingDepot =>  { # Shipment::Temando::WSDL::Types::Depot
     name => $some_value, # DepotName
     street => $some_value, # Address
     suburb => $some_value, # Suburb
     city => $some_value, # City
     state => $some_value, # State
     code => $some_value, # PostalCode
     country => $some_value, # CountryCode
     phone1 => $some_value, # Phone
     phone2 => $some_value, # Phone
     fax => $some_value, # Fax
     instructions => $some_value, # DepotInstructions
   },
   destinationDepot => {}, # Shipment::Temando::WSDL::Types::Depot
 },



=head2 attr

NOTE: Attribute documentation is experimental, and may be inaccurate.
See the correspondent WSDL/XML Schema if in question.

This class has additional attributes, accessibly via the C<attr()> method.

attr() returns an object of the class Shipment::Temando::WSDL::Types::AvailableQuote::_AvailableQuote::XmlAttr.

The following attributes can be accessed on this object via the corresponding
get_/set_ methods:

=over

=item * id



This attribute is of type L<SOAP::WSDL::XSD::Typelib::Builtin::positiveInteger|SOAP::WSDL::XSD::Typelib::Builtin::positiveInteger>.


=back




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

