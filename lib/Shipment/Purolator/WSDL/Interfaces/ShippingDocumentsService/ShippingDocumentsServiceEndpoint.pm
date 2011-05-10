package Shipment::Purolator::WSDL::Interfaces::ShippingDocumentsService::ShippingDocumentsServiceEndpoint;
use strict;
use warnings;
use Class::Std::Fast::Storable;
use Scalar::Util qw(blessed);
use base qw(SOAP::WSDL::Client::Base);


# only load if it hasn't been loaded before
require Shipment::Purolator::WSDL::Typemaps::ShippingDocumentsService
    if not Shipment::Purolator::WSDL::Typemaps::ShippingDocumentsService->can('get_class');


sub START {

    my $proxy_domain = $_[2]->{proxy_domain} || 'devwebservices.purolator.com';

    $_[0]->set_proxy('https://' . $proxy_domain . '/EWS/V1/ShippingDocuments/ShippingDocumentsService.asmx') if not $_[2]->{proxy};

    $_[0]->set_class_resolver('Shipment::Purolator::WSDL::Typemaps::ShippingDocumentsService')
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

sub GetDocuments {
    my ($self, $body, $header) = @_;
    die "GetDocuments must be called as object method (\$self is <$self>)" if not blessed($self);
    return $self->SUPER::call({
        operation => 'GetDocuments',
        soap_action => 'http://purolator.com/pws/service/v1/GetDocuments',
        style => 'document',
        body => {
            

           'use'            => 'literal',
            namespace       => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle   => '',
            parts           =>  [qw( Shipment::Purolator::WSDL::Elements::GetDocumentsRequest )],
        },
        header => {
            
           'use' => 'literal',
            namespace => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle => '',
            parts => [qw( Shipment::Purolator::WSDL::Elements::RequestContext )],

        },
        headerfault => {
            
        },
        response => {
            header => {
                


           'use' => 'literal',
            namespace => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle => '',
            parts => [qw( Shipment::Purolator::WSDL::Elements::ResponseContext )],
            },
            body => {
                

           'use'            => 'literal',
            namespace       => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle   => '',
            parts           =>  [qw( Shipment::Purolator::WSDL::Elements::GetDocumentsResponse )],
            },
        }
    }, $body, $header);
}


sub GetShipmentManifestDocument {
    my ($self, $body, $header) = @_;
    die "GetShipmentManifestDocument must be called as object method (\$self is <$self>)" if not blessed($self);
    return $self->SUPER::call({
        operation => 'GetShipmentManifestDocument',
        soap_action => 'http://purolator.com/pws/service/v1/GetShipmentManifestDocument',
        style => 'document',
        body => {
            

           'use'            => 'literal',
            namespace       => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle   => '',
            parts           =>  [qw( Shipment::Purolator::WSDL::Elements::GetShipmentManifestDocumentRequest )],
        },
        header => {
            
           'use' => 'literal',
            namespace => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle => '',
            parts => [qw( Shipment::Purolator::WSDL::Elements::RequestContext )],

        },
        headerfault => {
            
        },
        response => {
            header => {
                


           'use' => 'literal',
            namespace => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle => '',
            parts => [qw( Shipment::Purolator::WSDL::Elements::ResponseContext )],
            },
            body => {
                

           'use'            => 'literal',
            namespace       => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle   => '',
            parts           =>  [qw( Shipment::Purolator::WSDL::Elements::GetShipmentManifestDocumentResponse )],
            },
        }
    }, $body, $header);
}





sub _get_name_resolver {

    my $prefix_1 = {
              'attribute' => 'Shipment::Purolator::WSDL::Attributes',
              'typemap' => 'Shipment::Purolator::WSDL::Typemaps',
              'interface' => 'Shipment::Purolator::WSDL::Interfaces',
              'type' => 'Shipment::Purolator::WSDL::Types',
              'server' => 'Shipment::Purolator::WSDL::Server',
              'element' => 'Shipment::Purolator::WSDL::Elements'
            };


    return SOAP::WSDL::Generator::Template::Plugin::XSD->new({
        prefix_resolver => SOAP::WSDL::Generator::PrefixResolver->new({
            namespace_prefix_map => {
                'http://www.w3.org/2001/XMLSchema' => 'SOAP::WSDL::XSD::Typelib::Builtin',
            },
            namespace_map => {
            },
            prefix => $prefix_1,
        })
    });
}

1;



__END__

=pod

=head1 NAME

Shipment::Purolator::WSDL::Interfaces::ShippingDocumentsService::ShippingDocumentsServiceEndpoint - SOAP Interface for the ShippingDocumentsService Web Service

=head1 SYNOPSIS

 use Shipment::Purolator::WSDL::Interfaces::ShippingDocumentsService::ShippingDocumentsServiceEndpoint;
 my $interface = Shipment::Purolator::WSDL::Interfaces::ShippingDocumentsService::ShippingDocumentsServiceEndpoint->new();

 my $response;
 $response = $interface->GetDocuments();
 $response = $interface->GetShipmentManifestDocument();



=head1 DESCRIPTION

SOAP Interface for the ShippingDocumentsService web service
located at https://devwebservices.purolator.com/EWS/V1/ShippingDocuments/ShippingDocumentsService.asmx.

=head1 SERVICE ShippingDocumentsService



=head2 Port ShippingDocumentsServiceEndpoint



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



=head3 GetDocuments

GetDocuments @param request GetDocumentsRequest @return GetDocumentsResponse

Returns a L<Shipment::Purolator::WSDL::Elements::GetDocumentsResponse|Shipment::Purolator::WSDL::Elements::GetDocumentsResponse> object.

 $response = $interface->GetDocuments( { # Shipment::Purolator::WSDL::Types::GetDocumentsRequestContainer
    DocumentCriterium =>  { # Shipment::Purolator::WSDL::Types::ArrayOfDocumentCriteria
      DocumentCriteria =>  { # Shipment::Purolator::WSDL::Types::DocumentCriteria
        PIN =>  { # Shipment::Purolator::WSDL::Types::PIN
          Value =>  $some_value, # string
        },
        DocumentTypes =>  { # Shipment::Purolator::WSDL::Types::DocumentTypes
          DocumentType =>  $some_value, # string
        },
      },
    },
  },,
 );

=head3 GetShipmentManifestDocument

GetShipemntManifestDocument @param request GetShipmentManifestDocumentRequest @return GetShipmentManifestDocumentResponse 

Returns a L<Shipment::Purolator::WSDL::Elements::GetShipmentManifestDocumentResponse|Shipment::Purolator::WSDL::Elements::GetShipmentManifestDocumentResponse> object.

 $response = $interface->GetShipmentManifestDocument( { # Shipment::Purolator::WSDL::Types::GetShipmentManifestDocumentRequestContainer
    ShipmentManifestDocumentCriterium =>  { # Shipment::Purolator::WSDL::Types::ArrayOfShipmentManifestDocumentCriteria
      ShipmentManifestDocumentCriteria =>  { # Shipment::Purolator::WSDL::Types::ShipmentManifestDocumentCriteria
        ManifestDate =>  $some_value, # string
      },
    },
  },,
 );



=head1 AUTHOR

Generated by SOAP::WSDL on Tue Sep 14 15:09:17 2010

=cut
