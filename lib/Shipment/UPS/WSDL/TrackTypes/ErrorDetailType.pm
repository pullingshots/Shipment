package Shipment::UPS::WSDL::TrackTypes::ErrorDetailType;
use strict;
use warnings;


__PACKAGE__->_set_element_form_qualified(1);

sub get_xmlns { 'http://www.ups.com/XMLSchema/XOLTWS/Error/v1.1' };

our $XML_ATTRIBUTE_CLASS;
undef $XML_ATTRIBUTE_CLASS;

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}

use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %Severity_of :ATTR(:get<Severity>);
my %PrimaryErrorCode_of :ATTR(:get<PrimaryErrorCode>);
my %MinimumRetrySeconds_of :ATTR(:get<MinimumRetrySeconds>);
my %Location_of :ATTR(:get<Location>);
my %SubErrorCode_of :ATTR(:get<SubErrorCode>);
my %AdditionalInformation_of :ATTR(:get<AdditionalInformation>);

__PACKAGE__->_factory(
    [ qw(        Severity
        PrimaryErrorCode
        MinimumRetrySeconds
        Location
        SubErrorCode
        AdditionalInformation

    ) ],
    {
        'Severity' => \%Severity_of,
        'PrimaryErrorCode' => \%PrimaryErrorCode_of,
        'MinimumRetrySeconds' => \%MinimumRetrySeconds_of,
        'Location' => \%Location_of,
        'SubErrorCode' => \%SubErrorCode_of,
        'AdditionalInformation' => \%AdditionalInformation_of,
    },
    {
        'Severity' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'PrimaryErrorCode' => 'Shipment::UPS::WSDL::TrackTypes::CodeType',
        'MinimumRetrySeconds' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'Location' => 'Shipment::UPS::WSDL::TrackTypes::LocationType',
        'SubErrorCode' => 'Shipment::UPS::WSDL::TrackTypes::CodeType',
        'AdditionalInformation' => 'Shipment::UPS::WSDL::TrackTypes::AdditionalInfoType',
    },
    {

        'Severity' => 'Severity',
        'PrimaryErrorCode' => 'PrimaryErrorCode',
        'MinimumRetrySeconds' => 'MinimumRetrySeconds',
        'Location' => 'Location',
        'SubErrorCode' => 'SubErrorCode',
        'AdditionalInformation' => 'AdditionalInformation',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::UPS::WSDL::TrackTypes::ErrorDetailType

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
ErrorDetailType from the namespace http://www.ups.com/XMLSchema/XOLTWS/Error/v1.1.






=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * Severity


=item * PrimaryErrorCode


=item * MinimumRetrySeconds


=item * Location


=item * SubErrorCode


=item * AdditionalInformation




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::UPS::WSDL::TrackTypes::ErrorDetailType
   Severity =>  $some_value, # string
   PrimaryErrorCode =>  { # Shipment::UPS::WSDL::TrackTypes::CodeType
     Code =>  $some_value, # string
     Description =>  $some_value, # string
     Digest =>  $some_value, # string
   },
   MinimumRetrySeconds =>  $some_value, # string
   Location =>  { # Shipment::UPS::WSDL::TrackTypes::LocationType
     LocationElementName =>  $some_value, # string
     XPathOfElement =>  $some_value, # string
     OriginalValue =>  $some_value, # string
   },
   SubErrorCode =>  { # Shipment::UPS::WSDL::TrackTypes::CodeType
     Code =>  $some_value, # string
     Description =>  $some_value, # string
     Digest =>  $some_value, # string
   },
   AdditionalInformation =>  { # Shipment::UPS::WSDL::TrackTypes::AdditionalInfoType
     Type =>  $some_value, # string
     Value =>  { # Shipment::UPS::WSDL::TrackTypes::AdditionalCodeDescType
       Code =>  $some_value, # string
       Description =>  $some_value, # string
     },
   },
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

