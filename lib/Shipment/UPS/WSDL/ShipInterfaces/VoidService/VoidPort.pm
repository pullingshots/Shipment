package Shipment::UPS::WSDL::ShipInterfaces::VoidService::VoidPort;
use strict;
use warnings;
use Class::Std::Fast::Storable;
use Scalar::Util qw(blessed);
use base qw(SOAP::WSDL::Client::Base);


# only load if it hasn't been loaded before
require Shipment::UPS::WSDL::ShipTypemaps::VoidService
    if not Shipment::UPS::WSDL::ShipTypemaps::VoidService->can('get_class');


sub START {

    my $proxy_domain = $_[2]->{proxy_domain} || 'wwwcie.ups.com';

    $_[0]->set_proxy('https://' . $proxy_domain . '/webservices/Void') if not $_[2]->{proxy};

    $_[0]->set_class_resolver('Shipment::UPS::WSDL::ShipTypemaps::VoidService')
        if not $_[2]->{class_resolver};

    $_[0]->set_prefix($_[2]->{use_prefix}) if exists $_[2]->{use_prefix};
}

sub ProcessVoid {
    my ($self, $body, $header) = @_;
    die "ProcessVoid must be called as object method (\$self is <$self>)" if not blessed($self);
    return $self->SUPER::call({
        operation => 'ProcessVoid',
        soap_action => 'http://onlinetools.ups.com/webservices/VoidBinding/v1.1',
        style => 'document',
        body => {
            

           'use'            => 'literal',
            namespace       => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle   => '',
            parts           =>  [qw( Shipment::UPS::WSDL::ShipElements::VoidShipmentRequest )],
        },
        header => {
            
           'use' => 'literal',
            namespace => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle => '',
            parts => [qw( Shipment::UPS::WSDL::ShipElements::UPSSecurity )],

        },
        headerfault => {
            
        },
        response => {
            header => {
                
            },
            body => {
                

           'use'            => 'literal',
            namespace       => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle   => '',
            parts           =>  [qw( Shipment::UPS::WSDL::ShipElements::VoidShipmentResponse )],
            },
        }
    }, $body, $header);
}





sub _get_name_resolver {

    my $prefix_1 = {
              'attribute' => 'Shipment::UPS::WSDL::ShipAttributes',
              'typemap' => 'Shipment::UPS::WSDL::ShipTypemaps',
              'interface' => 'Shipment::UPS::WSDL::ShipInterfaces',
              'type' => 'Shipment::UPS::WSDL::ShipTypes',
              'server' => 'Shipment::UPS::WSDL::ShipServer',
              'element' => 'Shipment::UPS::WSDL::ShipElements'
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

Shipment::UPS::WSDL::ShipInterfaces::VoidService::VoidPort - SOAP Interface for the VoidService Web Service

=head1 SYNOPSIS

 use Shipment::UPS::WSDL::ShipInterfaces::VoidService::VoidPort;
 my $interface = Shipment::UPS::WSDL::ShipInterfaces::VoidService::VoidPort->new();

 my $response;
 $response = $interface->ProcessVoid();



=head1 DESCRIPTION

SOAP Interface for the VoidService web service
located at https://wwwcie.ups.com/webservices/Void.

=head1 SERVICE VoidService



=head2 Port VoidPort



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



=head3 ProcessVoid



Returns a L<Shipment::UPS::WSDL::ShipElements::VoidShipmentResponse|Shipment::UPS::WSDL::ShipElements::VoidShipmentResponse> object.

 $response = $interface->ProcessVoid( {
    Request =>  { # Shipment::UPS::WSDL::ShipTypes::RequestType
      RequestOption =>  $some_value, # string
      TransactionReference =>  { # Shipment::UPS::WSDL::ShipTypes::TransactionReferenceType
        CustomerContext =>  $some_value, # string
        TransactionIdentifier =>  $some_value, # string
      },
    },
    VoidShipment =>  {
      ShipmentIdentificationNumber =>  $some_value, # string
      TrackingNumber =>  $some_value, # string
    },
  },,
 {
    UsernameToken =>  {
      Username =>  $some_value, # string
      Password =>  $some_value, # string
    },
    ServiceAccessToken =>  {
      AccessLicenseNumber =>  $some_value, # string
    },
  },,
 );



=head1 AUTHOR

Generated by SOAP::WSDL on Fri Oct 15 14:54:28 2010

=cut
