package Shipment::Purolator::WSDL::Types::ServiceRule;
use strict;
use warnings;


__PACKAGE__->_set_element_form_qualified(1);

sub get_xmlns { 'http://purolator.com/pws/datatypes/v1' };

our $XML_ATTRIBUTE_CLASS;
undef $XML_ATTRIBUTE_CLASS;

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}

use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %ServiceID_of :ATTR(:get<ServiceID>);
my %MinimumTotalPieces_of :ATTR(:get<MinimumTotalPieces>);
my %MaximumTotalPieces_of :ATTR(:get<MaximumTotalPieces>);
my %MinimumTotalWeight_of :ATTR(:get<MinimumTotalWeight>);
my %MaximumTotalWeight_of :ATTR(:get<MaximumTotalWeight>);
my %MinimumPieceWeight_of :ATTR(:get<MinimumPieceWeight>);
my %MaximumPieceWeight_of :ATTR(:get<MaximumPieceWeight>);
my %MinimumPieceLength_of :ATTR(:get<MinimumPieceLength>);
my %MaximumPieceLength_of :ATTR(:get<MaximumPieceLength>);
my %MinimumPieceWidth_of :ATTR(:get<MinimumPieceWidth>);
my %MaximumPieceWidth_of :ATTR(:get<MaximumPieceWidth>);
my %MinimumPieceHeight_of :ATTR(:get<MinimumPieceHeight>);
my %MaximumPieceHeight_of :ATTR(:get<MaximumPieceHeight>);
my %MaximumSize_of :ATTR(:get<MaximumSize>);
my %MaximumDeclaredValue_of :ATTR(:get<MaximumDeclaredValue>);

__PACKAGE__->_factory(
    [ qw(        ServiceID
        MinimumTotalPieces
        MaximumTotalPieces
        MinimumTotalWeight
        MaximumTotalWeight
        MinimumPieceWeight
        MaximumPieceWeight
        MinimumPieceLength
        MaximumPieceLength
        MinimumPieceWidth
        MaximumPieceWidth
        MinimumPieceHeight
        MaximumPieceHeight
        MaximumSize
        MaximumDeclaredValue

    ) ],
    {
        'ServiceID' => \%ServiceID_of,
        'MinimumTotalPieces' => \%MinimumTotalPieces_of,
        'MaximumTotalPieces' => \%MaximumTotalPieces_of,
        'MinimumTotalWeight' => \%MinimumTotalWeight_of,
        'MaximumTotalWeight' => \%MaximumTotalWeight_of,
        'MinimumPieceWeight' => \%MinimumPieceWeight_of,
        'MaximumPieceWeight' => \%MaximumPieceWeight_of,
        'MinimumPieceLength' => \%MinimumPieceLength_of,
        'MaximumPieceLength' => \%MaximumPieceLength_of,
        'MinimumPieceWidth' => \%MinimumPieceWidth_of,
        'MaximumPieceWidth' => \%MaximumPieceWidth_of,
        'MinimumPieceHeight' => \%MinimumPieceHeight_of,
        'MaximumPieceHeight' => \%MaximumPieceHeight_of,
        'MaximumSize' => \%MaximumSize_of,
        'MaximumDeclaredValue' => \%MaximumDeclaredValue_of,
    },
    {
        'ServiceID' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'MinimumTotalPieces' => 'SOAP::WSDL::XSD::Typelib::Builtin::int',
        'MaximumTotalPieces' => 'SOAP::WSDL::XSD::Typelib::Builtin::int',
        'MinimumTotalWeight' => 'Shipment::Purolator::WSDL::Types::Weight',
        'MaximumTotalWeight' => 'Shipment::Purolator::WSDL::Types::Weight',
        'MinimumPieceWeight' => 'Shipment::Purolator::WSDL::Types::Weight',
        'MaximumPieceWeight' => 'Shipment::Purolator::WSDL::Types::Weight',
        'MinimumPieceLength' => 'Shipment::Purolator::WSDL::Types::Dimension',
        'MaximumPieceLength' => 'Shipment::Purolator::WSDL::Types::Dimension',
        'MinimumPieceWidth' => 'Shipment::Purolator::WSDL::Types::Dimension',
        'MaximumPieceWidth' => 'Shipment::Purolator::WSDL::Types::Dimension',
        'MinimumPieceHeight' => 'Shipment::Purolator::WSDL::Types::Dimension',
        'MaximumPieceHeight' => 'Shipment::Purolator::WSDL::Types::Dimension',
        'MaximumSize' => 'Shipment::Purolator::WSDL::Types::Dimension',
        'MaximumDeclaredValue' => 'SOAP::WSDL::XSD::Typelib::Builtin::decimal',
    },
    {

        'ServiceID' => 'ServiceID',
        'MinimumTotalPieces' => 'MinimumTotalPieces',
        'MaximumTotalPieces' => 'MaximumTotalPieces',
        'MinimumTotalWeight' => 'MinimumTotalWeight',
        'MaximumTotalWeight' => 'MaximumTotalWeight',
        'MinimumPieceWeight' => 'MinimumPieceWeight',
        'MaximumPieceWeight' => 'MaximumPieceWeight',
        'MinimumPieceLength' => 'MinimumPieceLength',
        'MaximumPieceLength' => 'MaximumPieceLength',
        'MinimumPieceWidth' => 'MinimumPieceWidth',
        'MaximumPieceWidth' => 'MaximumPieceWidth',
        'MinimumPieceHeight' => 'MinimumPieceHeight',
        'MaximumPieceHeight' => 'MaximumPieceHeight',
        'MaximumSize' => 'MaximumSize',
        'MaximumDeclaredValue' => 'MaximumDeclaredValue',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::Purolator::WSDL::Types::ServiceRule

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
ServiceRule from the namespace http://purolator.com/pws/datatypes/v1.

ServiceRules




=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * ServiceID (min/maxOccurs: 1/1)


=item * MinimumTotalPieces (min/maxOccurs: 1/1)


=item * MaximumTotalPieces (min/maxOccurs: 1/1)


=item * MinimumTotalWeight (min/maxOccurs: 1/1)


=item * MaximumTotalWeight (min/maxOccurs: 1/1)


=item * MinimumPieceWeight (min/maxOccurs: 1/1)


=item * MaximumPieceWeight (min/maxOccurs: 1/1)


=item * MinimumPieceLength (min/maxOccurs: 0/1)


=item * MaximumPieceLength (min/maxOccurs: 0/1)


=item * MinimumPieceWidth (min/maxOccurs: 0/1)


=item * MaximumPieceWidth (min/maxOccurs: 0/1)


=item * MinimumPieceHeight (min/maxOccurs: 0/1)


=item * MaximumPieceHeight (min/maxOccurs: 0/1)


=item * MaximumSize (min/maxOccurs: 0/1)


=item * MaximumDeclaredValue (min/maxOccurs: 0/1)




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::Purolator::WSDL::Types::ServiceRule
   ServiceID =>  $some_value, # string
   MinimumTotalPieces =>  $some_value, # int
   MaximumTotalPieces =>  $some_value, # int
   MinimumTotalWeight =>  { # Shipment::Purolator::WSDL::Types::Weight
     Value =>  $some_value, # decimal
     WeightUnit => $some_value, # WeightUnit
   },
   MaximumTotalWeight => {}, # Shipment::Purolator::WSDL::Types::Weight
   MinimumPieceWeight => {}, # Shipment::Purolator::WSDL::Types::Weight
   MaximumPieceWeight => {}, # Shipment::Purolator::WSDL::Types::Weight
   MinimumPieceLength =>  { # Shipment::Purolator::WSDL::Types::Dimension
     Value =>  $some_value, # decimal
     DimensionUnit => $some_value, # DimensionUnit
   },
   MaximumPieceLength => {}, # Shipment::Purolator::WSDL::Types::Dimension
   MinimumPieceWidth => {}, # Shipment::Purolator::WSDL::Types::Dimension
   MaximumPieceWidth => {}, # Shipment::Purolator::WSDL::Types::Dimension
   MinimumPieceHeight => {}, # Shipment::Purolator::WSDL::Types::Dimension
   MaximumPieceHeight => {}, # Shipment::Purolator::WSDL::Types::Dimension
   MaximumSize => {}, # Shipment::Purolator::WSDL::Types::Dimension
   MaximumDeclaredValue =>  $some_value, # decimal
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

