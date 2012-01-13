package Shipment::Temando::WSDL::Types::Location;
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

my %description_of :ATTR(:get<description>);
my %type_of :ATTR(:get<type>);
my %contactName_of :ATTR(:get<contactName>);
my %companyName_of :ATTR(:get<companyName>);
my %street_of :ATTR(:get<street>);
my %suburb_of :ATTR(:get<suburb>);
my %state_of :ATTR(:get<state>);
my %code_of :ATTR(:get<code>);
my %country_of :ATTR(:get<country>);
my %phone1_of :ATTR(:get<phone1>);
my %phone2_of :ATTR(:get<phone2>);
my %fax_of :ATTR(:get<fax>);
my %email_of :ATTR(:get<email>);
my %loadingFacilities_of :ATTR(:get<loadingFacilities>);
my %forklift_of :ATTR(:get<forklift>);
my %dock_of :ATTR(:get<dock>);
my %limitedAccess_of :ATTR(:get<limitedAccess>);
my %postalBox_of :ATTR(:get<postalBox>);
my %auspostMerchantLocationId_of :ATTR(:get<auspostMerchantLocationId>);
my %auspostLodgementFacility_of :ATTR(:get<auspostLodgementFacility>);
my %manifesting_of :ATTR(:get<manifesting>);

__PACKAGE__->_factory(
    [ qw(        description
        type
        contactName
        companyName
        street
        suburb
        state
        code
        country
        phone1
        phone2
        fax
        email
        loadingFacilities
        forklift
        dock
        limitedAccess
        postalBox
        auspostMerchantLocationId
        auspostLodgementFacility
        manifesting

    ) ],
    {
        'description' => \%description_of,
        'type' => \%type_of,
        'contactName' => \%contactName_of,
        'companyName' => \%companyName_of,
        'street' => \%street_of,
        'suburb' => \%suburb_of,
        'state' => \%state_of,
        'code' => \%code_of,
        'country' => \%country_of,
        'phone1' => \%phone1_of,
        'phone2' => \%phone2_of,
        'fax' => \%fax_of,
        'email' => \%email_of,
        'loadingFacilities' => \%loadingFacilities_of,
        'forklift' => \%forklift_of,
        'dock' => \%dock_of,
        'limitedAccess' => \%limitedAccess_of,
        'postalBox' => \%postalBox_of,
        'auspostMerchantLocationId' => \%auspostMerchantLocationId_of,
        'auspostLodgementFacility' => \%auspostLodgementFacility_of,
        'manifesting' => \%manifesting_of,
    },
    {
        'description' => 'Shipment::Temando::WSDL::Types::LocationName',
        'type' => 'Shipment::Temando::WSDL::Types::LocationPosition',
        'contactName' => 'Shipment::Temando::WSDL::Types::ContactName',
        'companyName' => 'Shipment::Temando::WSDL::Types::CompanyName',
        'street' => 'Shipment::Temando::WSDL::Types::Address',
        'suburb' => 'Shipment::Temando::WSDL::Types::Suburb',
        'state' => 'Shipment::Temando::WSDL::Types::State',
        'code' => 'Shipment::Temando::WSDL::Types::PostalCode',
        'country' => 'Shipment::Temando::WSDL::Types::CountryCode',
        'phone1' => 'Shipment::Temando::WSDL::Types::Phone',
        'phone2' => 'Shipment::Temando::WSDL::Types::Phone',
        'fax' => 'Shipment::Temando::WSDL::Types::Fax',
        'email' => 'Shipment::Temando::WSDL::Types::Email',
        'loadingFacilities' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'forklift' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'dock' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'limitedAccess' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'postalBox' => 'Shipment::Temando::WSDL::Types::YesNoOption',
        'auspostMerchantLocationId' => 'Shipment::Temando::WSDL::Types::AuspostMerchantLocationId',
        'auspostLodgementFacility' => 'Shipment::Temando::WSDL::Types::AuspostLodgementFacility',
        'manifesting' => 'Shipment::Temando::WSDL::Types::YesNoOption',
    },
    {

        'description' => 'description',
        'type' => 'type',
        'contactName' => 'contactName',
        'companyName' => 'companyName',
        'street' => 'street',
        'suburb' => 'suburb',
        'state' => 'state',
        'code' => 'code',
        'country' => 'country',
        'phone1' => 'phone1',
        'phone2' => 'phone2',
        'fax' => 'fax',
        'email' => 'email',
        'loadingFacilities' => 'loadingFacilities',
        'forklift' => 'forklift',
        'dock' => 'dock',
        'limitedAccess' => 'limitedAccess',
        'postalBox' => 'postalBox',
        'auspostMerchantLocationId' => 'auspostMerchantLocationId',
        'auspostLodgementFacility' => 'auspostLodgementFacility',
        'manifesting' => 'manifesting',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::Temando::WSDL::Types::Location

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
Location from the namespace http://' . $Shipment::Temando::WSDL::Interfaces::quoting_Service::quoting_port::ns_url . '/schema/2009_06/common.xsd.






=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * description (min/maxOccurs: 0/1)


=item * type (min/maxOccurs: 0/1)


=item * contactName (min/maxOccurs: 0/1)


=item * companyName (min/maxOccurs: 0/1)


=item * street (min/maxOccurs: 0/1)


=item * suburb (min/maxOccurs: 0/1)


=item * state (min/maxOccurs: 0/1)


=item * code (min/maxOccurs: 0/1)


=item * country (min/maxOccurs: 0/1)


=item * phone1 (min/maxOccurs: 0/1)


=item * phone2 (min/maxOccurs: 0/1)


=item * fax (min/maxOccurs: 0/1)


=item * email (min/maxOccurs: 0/1)


=item * loadingFacilities (min/maxOccurs: 0/1)


=item * forklift (min/maxOccurs: 0/1)


=item * dock (min/maxOccurs: 0/1)


=item * limitedAccess (min/maxOccurs: 0/1)


=item * postalBox (min/maxOccurs: 0/1)


=item * auspostMerchantLocationId (min/maxOccurs: 0/1)


=item * auspostLodgementFacility (min/maxOccurs: 0/1)


=item * manifesting (min/maxOccurs: 0/1)




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::Temando::WSDL::Types::Location
   description => $some_value, # LocationName
   type => $some_value, # LocationPosition
   contactName => $some_value, # ContactName
   companyName => $some_value, # CompanyName
   street => $some_value, # Address
   suburb => $some_value, # Suburb
   state => $some_value, # State
   code => $some_value, # PostalCode
   country => $some_value, # CountryCode
   phone1 => $some_value, # Phone
   phone2 => $some_value, # Phone
   fax => $some_value, # Fax
   email => $some_value, # Email
   loadingFacilities => $some_value, # YesNoOption
   forklift => $some_value, # YesNoOption
   dock => $some_value, # YesNoOption
   limitedAccess => $some_value, # YesNoOption
   postalBox => $some_value, # YesNoOption
   auspostMerchantLocationId => $some_value, # AuspostMerchantLocationId
   auspostLodgementFacility => $some_value, # AuspostLodgementFacility
   manifesting => $some_value, # YesNoOption
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

