package Shipment::Purolator::WSDLV2::Types::PackageInformation;
use strict;
use warnings;


__PACKAGE__->_set_element_form_qualified(1);

sub get_xmlns { 'http://purolator.com/pws/datatypes/v2' };

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
my %Description_of :ATTR(:get<Description>);
my %TotalWeight_of :ATTR(:get<TotalWeight>);
my %TotalPieces_of :ATTR(:get<TotalPieces>);
my %PiecesInformation_of :ATTR(:get<PiecesInformation>);
my %DangerousGoodsDeclarationDocumentIndicator_of :ATTR(:get<DangerousGoodsDeclarationDocumentIndicator>);
my %OptionsInformation_of :ATTR(:get<OptionsInformation>);

__PACKAGE__->_factory(
    [ qw(        ServiceID
        Description
        TotalWeight
        TotalPieces
        PiecesInformation
        DangerousGoodsDeclarationDocumentIndicator
        OptionsInformation

    ) ],
    {
        'ServiceID' => \%ServiceID_of,
        'Description' => \%Description_of,
        'TotalWeight' => \%TotalWeight_of,
        'TotalPieces' => \%TotalPieces_of,
        'PiecesInformation' => \%PiecesInformation_of,
        'DangerousGoodsDeclarationDocumentIndicator' => \%DangerousGoodsDeclarationDocumentIndicator_of,
        'OptionsInformation' => \%OptionsInformation_of,
    },
    {
        'ServiceID' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'TotalWeight' => 'Shipment::Purolator::WSDLV2::Types::TotalWeight',
        'TotalPieces' => 'SOAP::WSDL::XSD::Typelib::Builtin::int',
        'PiecesInformation' => 'Shipment::Purolator::WSDLV2::Types::ArrayOfPiece',
        'DangerousGoodsDeclarationDocumentIndicator' => 'SOAP::WSDL::XSD::Typelib::Builtin::boolean',
        'OptionsInformation' => 'Shipment::Purolator::WSDLV2::Types::OptionsInformation',
    },
    {

        'ServiceID' => 'ServiceID',
        'Description' => 'Description',
        'TotalWeight' => 'TotalWeight',
        'TotalPieces' => 'TotalPieces',
        'PiecesInformation' => 'PiecesInformation',
        'DangerousGoodsDeclarationDocumentIndicator' => 'DangerousGoodsDeclarationDocumentIndicator',
        'OptionsInformation' => 'OptionsInformation',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::Purolator::WSDLV2::Types::PackageInformation

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
PackageInformation from the namespace http://purolator.com/pws/datatypes/v2.

PackageInformation




=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * ServiceID (min/maxOccurs: 1/1)


=item * Description (min/maxOccurs: 0/1)


=item * TotalWeight (min/maxOccurs: 1/1)


=item * TotalPieces (min/maxOccurs: 1/1)


=item * PiecesInformation (min/maxOccurs: 0/1)


=item * DangerousGoodsDeclarationDocumentIndicator (min/maxOccurs: 0/1)


=item * OptionsInformation (min/maxOccurs: 0/1)




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::Purolator::WSDLV2::Types::PackageInformation
   ServiceID =>  $some_value, # string
   Description =>  $some_value, # string
   TotalWeight =>  { # Shipment::Purolator::WSDLV2::Types::TotalWeight
     Value =>  $some_value, # int
     WeightUnit => $some_value, # WeightUnit
   },
   TotalPieces =>  $some_value, # int
   PiecesInformation =>  { # Shipment::Purolator::WSDLV2::Types::ArrayOfPiece
     Piece =>  { # Shipment::Purolator::WSDLV2::Types::Piece
       Weight =>  { # Shipment::Purolator::WSDLV2::Types::Weight
         Value =>  $some_value, # decimal
         WeightUnit => $some_value, # WeightUnit
       },
       Length =>  { # Shipment::Purolator::WSDLV2::Types::Dimension
         Value =>  $some_value, # decimal
         DimensionUnit => $some_value, # DimensionUnit
       },
       Width => {}, # Shipment::Purolator::WSDLV2::Types::Dimension
       Height => {}, # Shipment::Purolator::WSDLV2::Types::Dimension
       Options =>  { # Shipment::Purolator::WSDLV2::Types::ArrayOfOptionIDValuePair
         OptionIDValuePair =>  { # Shipment::Purolator::WSDLV2::Types::OptionIDValuePair
           ID =>  $some_value, # string
           Value =>  $some_value, # string
         },
       },
     },
   },
   DangerousGoodsDeclarationDocumentIndicator =>  $some_value, # boolean
   OptionsInformation =>  { # Shipment::Purolator::WSDLV2::Types::OptionsInformation
     Options => {}, # Shipment::Purolator::WSDLV2::Types::ArrayOfOptionIDValuePair
     ExpressChequeAddress =>  { # Shipment::Purolator::WSDLV2::Types::Address
       Name =>  $some_value, # string
       Company =>  $some_value, # string
       Department =>  $some_value, # string
       StreetNumber =>  $some_value, # string
       StreetSuffix =>  $some_value, # string
       StreetName =>  $some_value, # string
       StreetType =>  $some_value, # string
       StreetDirection =>  $some_value, # string
       Suite =>  $some_value, # string
       Floor =>  $some_value, # string
       StreetAddress2 =>  $some_value, # string
       StreetAddress3 =>  $some_value, # string
       City =>  $some_value, # string
       Province =>  $some_value, # string
       Country =>  $some_value, # string
       PostalCode =>  $some_value, # string
       PhoneNumber =>  { # Shipment::Purolator::WSDLV2::Types::PhoneNumber
         CountryCode =>  $some_value, # string
         AreaCode =>  $some_value, # string
         Phone =>  $some_value, # string
         Extension =>  $some_value, # string
       },
       FaxNumber => {}, # Shipment::Purolator::WSDLV2::Types::PhoneNumber
     },
   },
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

