
package Shipment::UPS::WSDL::TrackElements::FaultDetail;
use strict;
use warnings;

{ # BLOCK to scope variables

sub get_xmlns { 'http://www.ups.com/XMLSchema/XOLTWS/Error/v1.1' }

__PACKAGE__->__set_name('FaultDetail');
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

my %Errors_of :ATTR(:get<Errors>);

__PACKAGE__->_factory(
    [ qw(        Errors

    ) ],
    {
        'Errors' => \%Errors_of,
    },
    {
        'Errors' => 'Shipment::UPS::WSDL::TrackElements::Errors',
    },
    {

        'Errors' => 'Errors',
    }
);

} # end BLOCK






} # end of BLOCK



1;


=pod

=head1 NAME

Shipment::UPS::WSDL::TrackElements::Errors

=head1 DESCRIPTION

Perl data type class for the XML Schema defined element
Errors from the namespace http://www.ups.com/XMLSchema/XOLTWS/Error/v1.1.







=head1 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * ErrorDetail

 $element->set_ErrorDetail($data);
 $element->get_ErrorDetail();





=back


=head1 METHODS

=head2 new

 my $element = Shipment::UPS::WSDL::TrackElements::Errors->new($data);

Constructor. The following data structure may be passed to new():

 {
   ErrorDetail =>  { # Shipment::UPS::WSDL::TrackTypes::ErrorDetailType
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
     SubErrorCode => {}, # Shipment::UPS::WSDL::TrackTypes::CodeType
     AdditionalInformation =>  { # Shipment::UPS::WSDL::TrackTypes::AdditionalInfoType
       Type =>  $some_value, # string
       Value =>  { # Shipment::UPS::WSDL::TrackTypes::AdditionalCodeDescType
         Code =>  $some_value, # string
         Description =>  $some_value, # string
       },
     },
   },
 },

=head1 AUTHOR

Generated by SOAP::WSDL

=cut
