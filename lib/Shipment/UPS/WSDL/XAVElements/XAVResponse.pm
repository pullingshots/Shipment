
package Shipment::UPS::WSDL::XAVElements::XAVResponse;
use strict;
use warnings;

{ # BLOCK to scope variables

sub get_xmlns { 'http://www.ups.com/XMLSchema/XOLTWS/xav/v1.0' }

__PACKAGE__->__set_name('XAVResponse');
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

my %Response_of :ATTR(:get<Response>);
my %ValidAddressIndicator_of :ATTR(:get<ValidAddressIndicator>);
my %AmbiguousAddressIndicator_of :ATTR(:get<AmbiguousAddressIndicator>);
my %NoCandidatesIndicator_of :ATTR(:get<NoCandidatesIndicator>);
my %AddressClassification_of :ATTR(:get<AddressClassification>);
my %Candidate_of :ATTR(:get<Candidate>);

__PACKAGE__->_factory(
    [ qw(        Response
        ValidAddressIndicator
        AmbiguousAddressIndicator
        NoCandidatesIndicator
        AddressClassification
        Candidate

    ) ],
    {
        'Response' => \%Response_of,
        'ValidAddressIndicator' => \%ValidAddressIndicator_of,
        'AmbiguousAddressIndicator' => \%AmbiguousAddressIndicator_of,
        'NoCandidatesIndicator' => \%NoCandidatesIndicator_of,
        'AddressClassification' => \%AddressClassification_of,
        'Candidate' => \%Candidate_of,
    },
    {
        'Response' => 'Shipment::UPS::WSDL::XAVElements::Response',

        'ValidAddressIndicator' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'AmbiguousAddressIndicator' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'NoCandidatesIndicator' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'AddressClassification' => 'Shipment::UPS::WSDL::XAVTypes::AddressClassificationType',
        'Candidate' => 'Shipment::UPS::WSDL::XAVTypes::CandidateType',
    },
    {

        'Response' => '',
        'ValidAddressIndicator' => 'ValidAddressIndicator',
        'AmbiguousAddressIndicator' => 'AmbiguousAddressIndicator',
        'NoCandidatesIndicator' => 'NoCandidatesIndicator',
        'AddressClassification' => 'AddressClassification',
        'Candidate' => 'Candidate',
    }
);

} # end BLOCK






} # end of BLOCK



1;


=pod

=head1 NAME

Shipment::UPS::WSDL::XAVElements::XAVResponse

=head1 DESCRIPTION

Perl data type class for the XML Schema defined element
XAVResponse from the namespace http://www.ups.com/XMLSchema/XOLTWS/xav/v1.0.







=head1 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * Response

 $element->set_Response($data);
 $element->get_Response();


Note: The name of this property has been altered, because it didn't match
perl's notion of variable/subroutine names. The altered name is used in
perl code only, XML output uses the original name:

 



=item * ValidAddressIndicator

 $element->set_ValidAddressIndicator($data);
 $element->get_ValidAddressIndicator();




=item * AmbiguousAddressIndicator

 $element->set_AmbiguousAddressIndicator($data);
 $element->get_AmbiguousAddressIndicator();




=item * NoCandidatesIndicator

 $element->set_NoCandidatesIndicator($data);
 $element->get_NoCandidatesIndicator();




=item * AddressClassification

 $element->set_AddressClassification($data);
 $element->get_AddressClassification();




=item * Candidate

 $element->set_Candidate($data);
 $element->get_Candidate();





=back


=head1 METHODS

=head2 new

 my $element = Shipment::UPS::WSDL::XAVElements::XAVResponse->new($data);

Constructor. The following data structure may be passed to new():

 {
   # One of the following elements.
   # No occurance checks yet, so be sure to pass just one...
   Response =>  { # Shipment::UPS::WSDL::XAVTypes::ResponseType
     ResponseStatus =>  { # Shipment::UPS::WSDL::XAVTypes::CodeDescriptionType
       Code =>  $some_value, # string
       Description =>  $some_value, # string
     },
     Alert => {}, # Shipment::UPS::WSDL::XAVTypes::CodeDescriptionType
     TransactionReference =>  { # Shipment::UPS::WSDL::XAVTypes::TransactionReferenceType
       CustomerContext =>  $some_value, # string
       TransactionIdentifier =>  $some_value, # string
     },
   },
   ValidAddressIndicator =>  $some_value, # string
   AmbiguousAddressIndicator =>  $some_value, # string
   NoCandidatesIndicator =>  $some_value, # string
   AddressClassification =>  { # Shipment::UPS::WSDL::XAVTypes::AddressClassificationType
     Code =>  $some_value, # string
     Description =>  $some_value, # string
   },
   Candidate =>  { # Shipment::UPS::WSDL::XAVTypes::CandidateType
     AddressClassification =>  { # Shipment::UPS::WSDL::XAVTypes::AddressClassificationType
       Code =>  $some_value, # string
       Description =>  $some_value, # string
     },
     AddressKeyFormat =>  { # Shipment::UPS::WSDL::XAVTypes::AddressKeyFormatType
       ConsigneeName =>  $some_value, # string
       AttentionName =>  $some_value, # string
       AddressLine =>  $some_value, # string
       PoliticalDivision2 =>  $some_value, # string
       PoliticalDivision1 =>  $some_value, # string
       PostcodePrimaryLow =>  $some_value, # string
       PostcodeExtendedLow =>  $some_value, # string
       Region =>  $some_value, # string
       Urbanization =>  $some_value, # string
       CountryCode =>  $some_value, # string
     },
   },
 },

=head1 AUTHOR

Generated by SOAP::WSDL

=cut

