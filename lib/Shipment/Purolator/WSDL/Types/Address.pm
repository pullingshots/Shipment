package Shipment::Purolator::WSDL::Types::Address;
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

my %Name_of :ATTR(:get<Name>);
my %Company_of :ATTR(:get<Company>);
my %Department_of :ATTR(:get<Department>);
my %StreetNumber_of :ATTR(:get<StreetNumber>);
my %StreetSuffix_of :ATTR(:get<StreetSuffix>);
my %StreetName_of :ATTR(:get<StreetName>);
my %StreetType_of :ATTR(:get<StreetType>);
my %StreetDirection_of :ATTR(:get<StreetDirection>);
my %Suite_of :ATTR(:get<Suite>);
my %Floor_of :ATTR(:get<Floor>);
my %StreetAddress2_of :ATTR(:get<StreetAddress2>);
my %StreetAddress3_of :ATTR(:get<StreetAddress3>);
my %City_of :ATTR(:get<City>);
my %Province_of :ATTR(:get<Province>);
my %Country_of :ATTR(:get<Country>);
my %PostalCode_of :ATTR(:get<PostalCode>);
my %PhoneNumber_of :ATTR(:get<PhoneNumber>);
my %FaxNumber_of :ATTR(:get<FaxNumber>);

__PACKAGE__->_factory(
    [ qw(        Name
        Company
        Department
        StreetNumber
        StreetSuffix
        StreetName
        StreetType
        StreetDirection
        Suite
        Floor
        StreetAddress2
        StreetAddress3
        City
        Province
        Country
        PostalCode
        PhoneNumber
        FaxNumber

    ) ],
    {
        'Name' => \%Name_of,
        'Company' => \%Company_of,
        'Department' => \%Department_of,
        'StreetNumber' => \%StreetNumber_of,
        'StreetSuffix' => \%StreetSuffix_of,
        'StreetName' => \%StreetName_of,
        'StreetType' => \%StreetType_of,
        'StreetDirection' => \%StreetDirection_of,
        'Suite' => \%Suite_of,
        'Floor' => \%Floor_of,
        'StreetAddress2' => \%StreetAddress2_of,
        'StreetAddress3' => \%StreetAddress3_of,
        'City' => \%City_of,
        'Province' => \%Province_of,
        'Country' => \%Country_of,
        'PostalCode' => \%PostalCode_of,
        'PhoneNumber' => \%PhoneNumber_of,
        'FaxNumber' => \%FaxNumber_of,
    },
    {
        'Name' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'Company' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'Department' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'StreetNumber' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'StreetSuffix' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'StreetName' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'StreetType' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'StreetDirection' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'Suite' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'Floor' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'StreetAddress2' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'StreetAddress3' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'City' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'Province' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'Country' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'PostalCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'PhoneNumber' => 'Shipment::Purolator::WSDL::Types::PhoneNumber',
        'FaxNumber' => 'Shipment::Purolator::WSDL::Types::PhoneNumber',
    },
    {

        'Name' => 'Name',
        'Company' => 'Company',
        'Department' => 'Department',
        'StreetNumber' => 'StreetNumber',
        'StreetSuffix' => 'StreetSuffix',
        'StreetName' => 'StreetName',
        'StreetType' => 'StreetType',
        'StreetDirection' => 'StreetDirection',
        'Suite' => 'Suite',
        'Floor' => 'Floor',
        'StreetAddress2' => 'StreetAddress2',
        'StreetAddress3' => 'StreetAddress3',
        'City' => 'City',
        'Province' => 'Province',
        'Country' => 'Country',
        'PostalCode' => 'PostalCode',
        'PhoneNumber' => 'PhoneNumber',
        'FaxNumber' => 'FaxNumber',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::Purolator::WSDL::Types::Address

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
Address from the namespace http://purolator.com/pws/datatypes/v1.

Address




=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * Name (min/maxOccurs: 1/1)


=item * Company (min/maxOccurs: 0/1)


=item * Department (min/maxOccurs: 0/1)


=item * StreetNumber (min/maxOccurs: 1/1)


=item * StreetSuffix (min/maxOccurs: 0/1)


=item * StreetName (min/maxOccurs: 1/1)


=item * StreetType (min/maxOccurs: 0/1)


=item * StreetDirection (min/maxOccurs: 0/1)


=item * Suite (min/maxOccurs: 0/1)


=item * Floor (min/maxOccurs: 0/1)


=item * StreetAddress2 (min/maxOccurs: 0/1)


=item * StreetAddress3 (min/maxOccurs: 0/1)


=item * City (min/maxOccurs: 1/1)


=item * Province (min/maxOccurs: 1/1)


=item * Country (min/maxOccurs: 1/1)


=item * PostalCode (min/maxOccurs: 1/1)


=item * PhoneNumber (min/maxOccurs: 1/1)


=item * FaxNumber (min/maxOccurs: 0/1)




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::Purolator::WSDL::Types::Address
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
   PhoneNumber =>  { # Shipment::Purolator::WSDL::Types::PhoneNumber
     CountryCode =>  $some_value, # string
     AreaCode =>  $some_value, # string
     Phone =>  $some_value, # string
     Extension =>  $some_value, # string
   },
   FaxNumber => {}, # Shipment::Purolator::WSDL::Types::PhoneNumber
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

