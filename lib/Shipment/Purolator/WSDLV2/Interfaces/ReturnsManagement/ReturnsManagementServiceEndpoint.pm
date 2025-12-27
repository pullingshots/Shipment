package Shipment::Purolator::WSDLV2::Interfaces::ReturnsManagement::ReturnsManagementServiceEndpoint;
use strict;
use warnings;
use Class::Std::Fast::Storable;
use Scalar::Util qw(blessed);
use base qw(SOAP::WSDL::Client::Base);

# only load if it hasn't been loaded before
require Shipment::Purolator::WSDLV2::Typemaps::ReturnsManagement
    if not Shipment::Purolator::WSDLV2::Typemaps::ReturnsManagement->can('get_class');

sub START {

    my $proxy_domain = $_[2]->{proxy_domain} || 'devwebservices.purolator.com';

    $_[0]->set_proxy('https://' . $proxy_domain . '/EWS/V2/ReturnsManagement/ReturnsManagementService.asmx') if not $_[2]->{proxy};

    $_[0]->set_class_resolver('Shipment::Purolator::WSDLV2::Typemaps::ReturnsManagement')
        if not $_[2]->{class_resolver};

    $_[0]->set_prefix($_[2]->{use_prefix}) if exists $_[2]->{use_prefix};

    my $options = $_[2];
    ## provide credentials
    eval {
      use SOAP::Lite;
    };
    if ($@) {
      warn "SOAP::Lite not installed, using builtin SOAP::WSDL Transport";
      *SOAP::WSDL::Transport::HTTP::get_basic_credentials = sub { return ($options->{key}, $options->{password}); };
    }
    else {
      *SOAP::Transport::HTTP::Client::get_basic_credentials = sub { return ($options->{key}, $options->{password}); };
    }
}

sub CreateReturnsManagementShipment {
    my ($self, $body, $header) = @_;
    die "CreateShipment must be called as object method (\$self is <$self>)" if not blessed($self);
    return $self->SUPER::call({
        operation => 'CreateReturnsManagementShipment',
        soap_action => 'http://purolator.com/pws/service/v2/CreateReturnShipment',
        style => 'document',
        body => {
            

           'use'            => 'literal',
            namespace       => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle   => '',
            parts           =>  [qw( Shipment::Purolator::WSDLV2::Elements::CreateReturnsManagementShipmentRequest )],
        },
        header => {
            
           'use' => 'literal',
            namespace => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle => '',
            parts => [qw( Shipment::Purolator::WSDLV2::Elements::RequestContext )],

        },
        headerfault => {
            
        },
        response => {
            header => {
                


           'use' => 'literal',
            namespace => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle => '',
            parts => [qw( Shipment::Purolator::WSDLV2::Elements::ResponseContext )],
            },
            body => {
                

           'use'            => 'literal',
            namespace       => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle   => '',
            parts           =>  [qw( Shipment::Purolator::WSDLV2::Elements::CreateReturnsManagementShipmentResponse)],
            },
        }
    }, $body, $header);
}

__END__

=pod

=head1 NAME

Shipment::Purolator::WSDLV2::Interfaces::ReturnsManagement::ReturnsManagementServiceEndpoint - SOAP Interface for the ReturnsManagement Web Service

=head1 SYNOPSIS

 use Shipment::Purolator::WSDLV2::Interfaces::ReturnsManagement::ReturnsManagementServiceEndpoint;
 my $interface = Shipment::Purolator::WSDLV2::Interfaces::ReturnsManagement::ReturnsManagementServiceEndpoint->new();

 my $response;
 $response = $interface->CreateReturnsManagementShipment();

=head1 DESCRIPTION

SOAP Interface for the CreateReturnShipment web service
located at https://devwebservices.purolator.com/EWS/V2/ReturnsManagement/ReturnsManagementService.asmx

=head1 SERVICE ReturnsManagement



=head2 Port ReturnsManagementServiceEndpoint



=head1 METHODS

=head2 General methods

=head3 new

Constructor.

All arguments are forwarded to L<SOAP::WSDL::Client|SOAP::WSDL::Client>.

=head2 SOAP Service methods

Method synopsis is displayed with hash refs as parameters.

The commented class names in the method's parameters denote that objects
of the corresponding class can be passed instead of the marked hash ref.

You may pass any combination of objects, hash and list refs to these
methods, as long as you meet the structure.

List items (i.e. multiple occurences) are not displayed in the synopsis.
You may generally pass a list ref of hash refs (or objects) instead of a hash
ref - this may result in invalid XML if used improperly, though. Note that
SOAP::WSDL always expects list references at maximum depth position.

XML attributes are not displayed in this synopsis and cannot be set using
hash refs. See the respective class' documentation for additional information.



=head3 CreateReturnsManagementShipment

CreateReturnsManagementShipment @param request CreateShipmentRequest @return CreateReturnsManagementShipmentResponse

Returns a L<Shipment::Purolator::WSDLV2::Elements::CreateReturnsManagementShipmentResponse|Shipment::Purolator::WSDLV2::Elements::CreateReturnsManagementShipmentResponse> object.

 $response = $interface->CreateReturnsManagementShipment( { # Shipment::Purolator::WSDLV2::Types::CreateReturnsManagementShipmentRequestContainer
    ReturnsManagementShipment =>  { # Shipment::Purolator::WSDLV2::Types::Shipment
      SenderInformation =>  { # Shipment::Purolator::WSDLV2::Types::SenderInformation
        Address =>  { # Shipment::Purolator::WSDLV2::Types::Address
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
        TaxNumber =>  $some_value, # string
      },
      ReceiverInformation =>  { # Shipment::Purolator::WSDLV2::Types::ReceiverInformation
        Address => {}, # Shipment::Purolator::WSDLV2::Types::Address
        TaxNumber =>  $some_value, # string
      },
      PackageInformation =>  { # Shipment::Purolator::WSDLV2::Types::PackageInformation
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
      },
      PaymentInformation => {}, # Shipment::Purolator::WSDLV2::Types::PaymentInformation
      PickupInformation => {}, # Shipment::Purolator::WSDLV2::Types::PickupInformation
      TrackingReferenceInformation => {}, # Shipment::Purolator::WSDLV2::Types::TrackingReferenceInformation
      OtherInformation => {}, # Shipment::Purolator::WSDLV2::Types::OtherInformation
    },
    PrinterType => $some_value, # PrinterType
  },
 );

=head1 AUTHOR

Generated by SOAP::WSDL

=cut