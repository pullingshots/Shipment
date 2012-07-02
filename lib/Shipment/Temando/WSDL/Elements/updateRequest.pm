
package Shipment::Temando::WSDL::Elements::updateRequest;
use strict;
use warnings;

{ # BLOCK to scope variables

sub get_xmlns { 'http://' . $Shipment::Temando::WSDL::Interfaces::quoting_Service::quoting_port::ns_url . '/schema/2009_06/server.xsd' }

__PACKAGE__->__set_name('updateRequest');
__PACKAGE__->__set_nillable();
__PACKAGE__->__set_minOccurs();
__PACKAGE__->__set_maxOccurs();
__PACKAGE__->__set_ref();

use base qw(
    SOAP::WSDL::XSD::Typelib::Element
    SOAP::WSDL::XSD::Typelib::ComplexType
);

our $XML_ATTRIBUTE_CLASS;
undef $XML_ATTRIBUTE_CLASS;

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}

use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %action_of :ATTR(:get<action>);
my %requestId_of :ATTR(:get<requestId>);
my %reference_of :ATTR(:get<reference>);
my %anythings_of :ATTR(:get<anythings>);
my %articles_of :ATTR(:get<articles>);
my %general_of :ATTR(:get<general>);
my %payment_of :ATTR(:get<payment>);
my %clientId_of :ATTR(:get<clientId>);
my %labelPrinterType_of :ATTR(:get<labelPrinterType>);
my %detail_of :ATTR(:get<detail>);

__PACKAGE__->_factory(
    [ qw(        action
        requestId
        reference
        anythings
        articles
        general
        payment
        clientId
        labelPrinterType
        detail

    ) ],
    {
        'action' => \%action_of,
        'requestId' => \%requestId_of,
        'reference' => \%reference_of,
        'anythings' => \%anythings_of,
        'articles' => \%articles_of,
        'general' => \%general_of,
        'payment' => \%payment_of,
        'clientId' => \%clientId_of,
        'labelPrinterType' => \%labelPrinterType_of,
        'detail' => \%detail_of,
    },
    {
        'action' => 'Shipment::Temando::WSDL::Types::UpdateAction',
        'requestId' => 'SOAP::WSDL::XSD::Typelib::Builtin::positiveInteger',
        'reference' => 'Shipment::Temando::WSDL::Types::ClientReference',

        'anythings' => 'Shipment::Temando::WSDL::Elements::updateRequest::_anythings',

        'articles' => 'Shipment::Temando::WSDL::Elements::updateRequest::_articles',
        'general' => 'Shipment::Temando::WSDL::Types::General',
        'payment' => 'Shipment::Temando::WSDL::Types::Payment',
        'clientId' => 'Shipment::Temando::WSDL::Types::ClientId',
        'labelPrinterType' => 'Shipment::Temando::WSDL::Types::LabelPrinterType',
        'detail' => 'Shipment::Temando::WSDL::Types::Detail',
    },
    {

        'action' => 'action',
        'requestId' => 'requestId',
        'reference' => 'reference',
        'anythings' => 'anythings',
        'articles' => 'articles',
        'general' => 'general',
        'payment' => 'payment',
        'clientId' => 'clientId',
        'labelPrinterType' => 'labelPrinterType',
        'detail' => 'detail',
    }
);

} # end BLOCK




package Shipment::Temando::WSDL::Elements::updateRequest::_anythings;
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

my %anything_of :ATTR(:get<anything>);

__PACKAGE__->_factory(
    [ qw(        anything

    ) ],
    {
        'anything' => \%anything_of,
    },
    {
        'anything' => 'Shipment::Temando::WSDL::Types::Anything',
    },
    {

        'anything' => 'anything',
    }
);

} # end BLOCK






}



package Shipment::Temando::WSDL::Elements::updateRequest::_articles;
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





} # end of BLOCK



1;


=pod

=head1 NAME

Shipment::Temando::WSDL::Elements::updateRequest

=head1 DESCRIPTION

Perl data type class for the XML Schema defined element
updateRequest from the namespace http://' . $Shipment::Temando::WSDL::Interfaces::quoting_Service::quoting_port::ns_url . '/schema/2009_06/server.xsd.







=head1 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * action

 $element->set_action($data);
 $element->get_action();




=item * requestId

 $element->set_requestId($data);
 $element->get_requestId();




=item * reference

 $element->set_reference($data);
 $element->get_reference();




=item * anythings

 $element->set_anythings($data);
 $element->get_anythings();




=item * articles

 $element->set_articles($data);
 $element->get_articles();




=item * general

 $element->set_general($data);
 $element->get_general();




=item * payment

 $element->set_payment($data);
 $element->get_payment();




=item * clientId

 $element->set_clientId($data);
 $element->get_clientId();




=item * labelPrinterType

 $element->set_labelPrinterType($data);
 $element->get_labelPrinterType();




=item * detail

 $element->set_detail($data);
 $element->get_detail();





=back


=head1 METHODS

=head2 new

 my $element = Shipment::Temando::WSDL::Elements::updateRequest->new($data);

Constructor. The following data structure may be passed to new():

 {
   action => $some_value, # UpdateAction
   requestId =>  $some_value, # positiveInteger
   reference => $some_value, # ClientReference
   anythings =>  {
     anything =>  { # Shipment::Temando::WSDL::Types::Anything
       class => $some_value, # Class
       subclass => $some_value, # Subclass
       mode => $some_value, # Mode
       tlSubclass => $some_value, # TlSubclass
       packaging => $some_value, # Packaging
       palletType => $some_value, # PalletType
       palletNature => $some_value, # PalletNature
       containerDimensions => $some_value, # ContainerDimensions
       containerNature => $some_value, # ContainerNature
       containerRegistered => $some_value, # YesNoOption
       qualifierFreightGeneralDangerousGoods => $some_value, # YesNoOption
       qualifierFreightGeneralFragile => $some_value, # YesNoOption
       qualifierFreightGeneralRefrigerated => $some_value, # YesNoOption
       qualifierVehicleMake => $some_value, # VehicleMake
       qualifierVehicleModel => $some_value, # VehicleModel
       qualifierVehicleDescription => $some_value, # VehicleDescription
       qualifierVehicleRunning => $some_value, # YesNoOption
       qualifierVehicleRegistered => $some_value, # YesNoOption
       qualifierVehicleYear => $some_value, # VehicleYear
       qualifierVehicleRegistration => $some_value, # VehicleRegistration
       qualifierBoatMake => $some_value, # BoatMake
       qualifierBoatModel => $some_value, # BoatModel
       qualifierBoatSeaworthy => $some_value, # YesNoOption
       qualifierBoatTrailer => $some_value, # YesNoOption
       qualifierBoatHullType => $some_value, # BoatHullType
       qualifierLivestockType => $some_value, # LivestockType
       qualifierAnimalVaccinated => $some_value, # YesNoOption
       qualifierAnimalRegistered => $some_value, # YesNoOption
       qualifierAnimalType => $some_value, # AnimalType
       qualifierAnimalBreed => $some_value, # AnimalBreed
       qualifierAnimalSex => $some_value, # Sex
       qualifierAnimalAge => $some_value, # AnimalAge
       qualifierAnimalCrate => $some_value, # AnimalCrate
       distanceMeasurementType => $some_value, # DistanceMeasurementType
       weightMeasurementType => $some_value, # WeightMeasurementType
       length => $some_value, # Length
       width => $some_value, # Width
       height => $some_value, # Height
       weight => $some_value, # Weight
       quantity => $some_value, # Quantity
       description => $some_value, # ItemDescription
     },
   },
   articles =>  {
     article =>  { # Shipment::Temando::WSDL::Types::Article
       anythingIndex => $some_value, # AnythingIndex
       articleNumber => $some_value, # ArticleNumber
       labelDocument => $some_value, # LabelDocument
       labelDocumentType => $some_value, # LabelDocumentType
     },
   },
   general =>  { # Shipment::Temando::WSDL::Types::General
     goodsValue => $some_value, # CurrencyAmount
   },
   payment =>  { # Shipment::Temando::WSDL::Types::Payment
     paymentType => $some_value, # PaymentType
     cardType => $some_value, # CreditCardType
     cardExpiryDate => $some_value, # CreditCardExpiryDate
     cardNumber => $some_value, # CreditCardNumber
     cardName => $some_value, # CreditCardName
     paypalPayerId => $some_value, # PaypalPayerId
     paypalToken => $some_value, # PaypalToken
   },
   clientId => $some_value, # ClientId
   labelPrinterType => $some_value, # LabelPrinterType
   detail => $some_value, # Detail
 },

=head1 AUTHOR

Generated by SOAP::WSDL

=cut

