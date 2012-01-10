package Shipment::Temando::WSDL::Types::Client;
use strict;
use warnings;


__PACKAGE__->_set_element_form_qualified(0);

sub get_xmlns { 'http://api.temando.com/schema/2009_06/common.xsd' };

our $XML_ATTRIBUTE_CLASS;
undef $XML_ATTRIBUTE_CLASS;

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}

use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %id_of :ATTR(:get<id>);
my %individualCompany_of :ATTR(:get<individualCompany>);
my %companyName_of :ATTR(:get<companyName>);
my %companyContactPerson_of :ATTR(:get<companyContactPerson>);
my %companyNo_of :ATTR(:get<companyNo>);
my %individualSurname_of :ATTR(:get<individualSurname>);
my %individualFirstname_of :ATTR(:get<individualFirstname>);
my %individualDateOfBirth_of :ATTR(:get<individualDateOfBirth>);
my %streetAddress_of :ATTR(:get<streetAddress>);
my %streetSuburb_of :ATTR(:get<streetSuburb>);
my %streetCity_of :ATTR(:get<streetCity>);
my %streetState_of :ATTR(:get<streetState>);
my %streetCode_of :ATTR(:get<streetCode>);
my %streetCountry_of :ATTR(:get<streetCountry>);
my %postalAddress_of :ATTR(:get<postalAddress>);
my %postalSuburb_of :ATTR(:get<postalSuburb>);
my %postalCity_of :ATTR(:get<postalCity>);
my %postalState_of :ATTR(:get<postalState>);
my %postalCode_of :ATTR(:get<postalCode>);
my %postalCountry_of :ATTR(:get<postalCountry>);
my %phone1_of :ATTR(:get<phone1>);
my %phone2_of :ATTR(:get<phone2>);
my %email_of :ATTR(:get<email>);

__PACKAGE__->_factory(
    [ qw(        id
        individualCompany
        companyName
        companyContactPerson
        companyNo
        individualSurname
        individualFirstname
        individualDateOfBirth
        streetAddress
        streetSuburb
        streetCity
        streetState
        streetCode
        streetCountry
        postalAddress
        postalSuburb
        postalCity
        postalState
        postalCode
        postalCountry
        phone1
        phone2
        email

    ) ],
    {
        'id' => \%id_of,
        'individualCompany' => \%individualCompany_of,
        'companyName' => \%companyName_of,
        'companyContactPerson' => \%companyContactPerson_of,
        'companyNo' => \%companyNo_of,
        'individualSurname' => \%individualSurname_of,
        'individualFirstname' => \%individualFirstname_of,
        'individualDateOfBirth' => \%individualDateOfBirth_of,
        'streetAddress' => \%streetAddress_of,
        'streetSuburb' => \%streetSuburb_of,
        'streetCity' => \%streetCity_of,
        'streetState' => \%streetState_of,
        'streetCode' => \%streetCode_of,
        'streetCountry' => \%streetCountry_of,
        'postalAddress' => \%postalAddress_of,
        'postalSuburb' => \%postalSuburb_of,
        'postalCity' => \%postalCity_of,
        'postalState' => \%postalState_of,
        'postalCode' => \%postalCode_of,
        'postalCountry' => \%postalCountry_of,
        'phone1' => \%phone1_of,
        'phone2' => \%phone2_of,
        'email' => \%email_of,
    },
    {
        'id' => 'Shipment::Temando::WSDL::Types::ClientId',
        'individualCompany' => 'Shipment::Temando::WSDL::Types::IndividualCompany',
        'companyName' => 'Shipment::Temando::WSDL::Types::CompanyName',
        'companyContactPerson' => 'Shipment::Temando::WSDL::Types::ContactName',
        'companyNo' => 'Shipment::Temando::WSDL::Types::CompanyNumber',
        'individualSurname' => 'Shipment::Temando::WSDL::Types::Surname',
        'individualFirstname' => 'Shipment::Temando::WSDL::Types::Firstname',
        'individualDateOfBirth' => 'Shipment::Temando::WSDL::Types::Date',
        'streetAddress' => 'Shipment::Temando::WSDL::Types::Address',
        'streetSuburb' => 'Shipment::Temando::WSDL::Types::Suburb',
        'streetCity' => 'Shipment::Temando::WSDL::Types::City',
        'streetState' => 'Shipment::Temando::WSDL::Types::State',
        'streetCode' => 'Shipment::Temando::WSDL::Types::PostalCode',
        'streetCountry' => 'Shipment::Temando::WSDL::Types::CountryCode',
        'postalAddress' => 'Shipment::Temando::WSDL::Types::Address',
        'postalSuburb' => 'Shipment::Temando::WSDL::Types::Suburb',
        'postalCity' => 'Shipment::Temando::WSDL::Types::City',
        'postalState' => 'Shipment::Temando::WSDL::Types::State',
        'postalCode' => 'Shipment::Temando::WSDL::Types::PostalCode',
        'postalCountry' => 'Shipment::Temando::WSDL::Types::CountryCode',
        'phone1' => 'Shipment::Temando::WSDL::Types::Phone',
        'phone2' => 'Shipment::Temando::WSDL::Types::Phone',
        'email' => 'Shipment::Temando::WSDL::Types::Email',
    },
    {

        'id' => 'id',
        'individualCompany' => 'individualCompany',
        'companyName' => 'companyName',
        'companyContactPerson' => 'companyContactPerson',
        'companyNo' => 'companyNo',
        'individualSurname' => 'individualSurname',
        'individualFirstname' => 'individualFirstname',
        'individualDateOfBirth' => 'individualDateOfBirth',
        'streetAddress' => 'streetAddress',
        'streetSuburb' => 'streetSuburb',
        'streetCity' => 'streetCity',
        'streetState' => 'streetState',
        'streetCode' => 'streetCode',
        'streetCountry' => 'streetCountry',
        'postalAddress' => 'postalAddress',
        'postalSuburb' => 'postalSuburb',
        'postalCity' => 'postalCity',
        'postalState' => 'postalState',
        'postalCode' => 'postalCode',
        'postalCountry' => 'postalCountry',
        'phone1' => 'phone1',
        'phone2' => 'phone2',
        'email' => 'email',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::Temando::WSDL::Types::Client

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
Client from the namespace http://api.temando.com/schema/2009_06/common.xsd.






=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * id (min/maxOccurs: 0/1)


=item * individualCompany (min/maxOccurs: 0/1)


=item * companyName (min/maxOccurs: 0/1)


=item * companyContactPerson (min/maxOccurs: 0/1)


=item * companyNo (min/maxOccurs: 0/1)


=item * individualSurname (min/maxOccurs: 0/1)


=item * individualFirstname (min/maxOccurs: 0/1)


=item * individualDateOfBirth (min/maxOccurs: 0/1)


=item * streetAddress (min/maxOccurs: 0/1)


=item * streetSuburb (min/maxOccurs: 0/1)


=item * streetCity (min/maxOccurs: 0/1)


=item * streetState (min/maxOccurs: 0/1)


=item * streetCode (min/maxOccurs: 0/1)


=item * streetCountry (min/maxOccurs: 0/1)


=item * postalAddress (min/maxOccurs: 0/1)


=item * postalSuburb (min/maxOccurs: 0/1)


=item * postalCity (min/maxOccurs: 0/1)


=item * postalState (min/maxOccurs: 0/1)


=item * postalCode (min/maxOccurs: 0/1)


=item * postalCountry (min/maxOccurs: 0/1)


=item * phone1 (min/maxOccurs: 0/1)


=item * phone2 (min/maxOccurs: 0/1)


=item * email (min/maxOccurs: 0/1)




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::Temando::WSDL::Types::Client
   id => $some_value, # ClientId
   individualCompany => $some_value, # IndividualCompany
   companyName => $some_value, # CompanyName
   companyContactPerson => $some_value, # ContactName
   companyNo => $some_value, # CompanyNumber
   individualSurname => $some_value, # Surname
   individualFirstname => $some_value, # Firstname
   individualDateOfBirth => $some_value, # Date
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
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

