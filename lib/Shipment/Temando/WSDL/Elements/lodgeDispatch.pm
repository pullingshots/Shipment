
package Shipment::Temando::WSDL::Elements::lodgeDispatch;
use strict;
use warnings;

{ # BLOCK to scope variables

sub get_xmlns { 'http://api.temando.com/schema/2009_06/server.xsd' }

__PACKAGE__->__set_name('lodgeDispatch');
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

my %requestId_of :ATTR(:get<requestId>);
my %bookingNumber_of :ATTR(:get<bookingNumber>);
my %dispatchDetails_of :ATTR(:get<dispatchDetails>);

__PACKAGE__->_factory(
    [ qw(        requestId
        bookingNumber
        dispatchDetails

    ) ],
    {
        'requestId' => \%requestId_of,
        'bookingNumber' => \%bookingNumber_of,
        'dispatchDetails' => \%dispatchDetails_of,
    },
    {
        'requestId' => 'SOAP::WSDL::XSD::Typelib::Builtin::positiveInteger',
        'bookingNumber' => 'Shipment::Temando::WSDL::Types::BookingNumber',
        'dispatchDetails' => 'Shipment::Temando::WSDL::Types::DispatchDetails',
    },
    {

        'requestId' => 'requestId',
        'bookingNumber' => 'bookingNumber',
        'dispatchDetails' => 'dispatchDetails',
    }
);

} # end BLOCK






} # end of BLOCK



1;


=pod

=head1 NAME

Shipment::Temando::WSDL::Elements::lodgeDispatch

=head1 DESCRIPTION

Perl data type class for the XML Schema defined element
lodgeDispatch from the namespace http://api.temando.com/schema/2009_06/server.xsd.







=head1 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * requestId

 $element->set_requestId($data);
 $element->get_requestId();




=item * bookingNumber

 $element->set_bookingNumber($data);
 $element->get_bookingNumber();




=item * dispatchDetails

 $element->set_dispatchDetails($data);
 $element->get_dispatchDetails();





=back


=head1 METHODS

=head2 new

 my $element = Shipment::Temando::WSDL::Elements::lodgeDispatch->new($data);

Constructor. The following data structure may be passed to new():

 {
   requestId =>  $some_value, # positiveInteger
   bookingNumber => $some_value, # BookingNumber
   dispatchDetails =>  { # Shipment::Temando::WSDL::Types::DispatchDetails
     reference => $some_value, # CarrierReference
     carrierName => $some_value, # CompanyName
     carrierId => $some_value, # CarrierId
     accountNo => $some_value, # CarrierAccountNumber
     creatorId => $some_value, # CarrierCreatorId
     currency => $some_value, # CurrencyType
     changedCarrier => $some_value, # YesNoOption
     consignmentEdited => $some_value, # YesNoOption
     consignmentNumber => $some_value, # ConsignmentNumber
     consignmentDate => $some_value, # Date
     deliveryMethod => $some_value, # DeliveryMethod
     rateName => $some_value, # RateName
     description => $some_value, # ItemDescription
     distanceMeasurementType => $some_value, # DistanceMeasurementType
     weightMeasurementType => $some_value, # WeightMeasurementType
     length => $some_value, # Length
     width => $some_value, # Width
     height => $some_value, # Height
     actualWeight => $some_value, # Weight
     chargeableWeight => $some_value, # Weight
     actualCubic => $some_value, # Cubic
     chargeableCubic => $some_value, # Cubic
     actualQuantity => $some_value, # Quantity
     chargeableQuantity => $some_value, # Quantity
     basePrice => $some_value, # CurrencyAmount
     surcharges => $some_value, # CurrencyAmount
     tax => $some_value, # CurrencyAmount
     totalPrice => $some_value, # CurrencyAmount
     originZoneName => $some_value, # ZoneName
     originContactName => $some_value, # ContactName
     originCompanyName => $some_value, # CompanyName
     originStreet => $some_value, # Address
     originSuburb => $some_value, # Suburb
     originState => $some_value, # State
     originCode => $some_value, # PostalCode
     originCountry => $some_value, # CountryCode
     originPhone1 => $some_value, # Phone
     originPhone2 => $some_value, # Phone
     originFax => $some_value, # Fax
     originEmail => $some_value, # Email
     destinationZoneName => $some_value, # ZoneName
     destinationContactName => $some_value, # ContactName
     destinationCompanyName => $some_value, # CompanyName
     destinationStreet => $some_value, # Address
     destinationSuburb => $some_value, # Suburb
     destinationState => $some_value, # State
     destinationCode => $some_value, # PostalCode
     destinationCountry => $some_value, # CountryCode
     destinationPhone1 => $some_value, # Phone
     destinationPhone2 => $some_value, # Phone
     destinationFax => $some_value, # Fax
     destinationEmail => $some_value, # Email
   },
 },

=head1 AUTHOR

Generated by SOAP::WSDL

=cut

