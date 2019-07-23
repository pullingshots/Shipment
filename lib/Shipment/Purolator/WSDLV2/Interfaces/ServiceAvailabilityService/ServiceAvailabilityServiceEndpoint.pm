package Shipment::Purolator::WSDLV2::Interfaces::ServiceAvailabilityService::ServiceAvailabilityServiceEndpoint;
use strict;
use warnings;
use Class::Std::Fast::Storable;
use Scalar::Util qw(blessed);
use base qw(SOAP::WSDL::Client::Base);


# only load if it hasn't been loaded before
require Shipment::Purolator::WSDLV2::Typemaps::ServiceAvailabilityService
    if not Shipment::Purolator::WSDLV2::Typemaps::ServiceAvailabilityService->can('get_class');


sub START {

    my $proxy_domain = $_[2]->{proxy_domain} || 'devwebservices.purolator.com';

    $_[0]->set_proxy('https://' . $proxy_domain . '/EWS/V2/ServiceAvailability/ServiceAvailabilityService.asmx') if not $_[2]->{proxy};

    $_[0]->set_class_resolver('Shipment::Purolator::WSDLV2::Typemaps::ServiceAvailabilityService')
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

sub GetServicesOptions {
    my ($self, $body, $header) = @_;
    die "GetServicesOptions must be called as object method (\$self is <$self>)" if not blessed($self);
    return $self->SUPER::call({
        operation => 'GetServicesOptions',
        soap_action => 'http://purolator.com/pws/service/v2/GetServicesOptions',
        style => 'document',
        body => {
            

           'use'            => 'literal',
            namespace       => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle   => '',
            parts           =>  [qw( Shipment::Purolator::WSDLV2::Elements::GetServicesOptionsRequest )],
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
            parts           =>  [qw( Shipment::Purolator::WSDLV2::Elements::GetServicesOptionsResponse )],
            },
        }
    }, $body, $header);
}


sub GetServiceRules {
    my ($self, $body, $header) = @_;
    die "GetServiceRules must be called as object method (\$self is <$self>)" if not blessed($self);
    return $self->SUPER::call({
        operation => 'GetServiceRules',
        soap_action => 'http://purolator.com/pws/service/v2/GetServiceRules',
        style => 'document',
        body => {
            

           'use'            => 'literal',
            namespace       => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle   => '',
            parts           =>  [qw( Shipment::Purolator::WSDLV2::Elements::GetServiceRulesRequest )],
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
            parts           =>  [qw( Shipment::Purolator::WSDLV2::Elements::GetServiceRulesResponse )],
            },
        }
    }, $body, $header);
}


sub ValidateCityPostalCodeZip {
    my ($self, $body, $header) = @_;
    die "ValidateCityPostalCodeZip must be called as object method (\$self is <$self>)" if not blessed($self);
    return $self->SUPER::call({
        operation => 'ValidateCityPostalCodeZip',
        soap_action => 'http://purolator.com/pws/service/v2/ValidateCityPostalCodeZip',
        style => 'document',
        body => {
            

           'use'            => 'literal',
            namespace       => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle   => '',
            parts           =>  [qw( Shipment::Purolator::WSDLV2::Elements::ValidateCityPostalCodeZipRequest )],
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
            parts           =>  [qw( Shipment::Purolator::WSDLV2::Elements::ValidateCityPostalCodeZipResponse )],
            },
        }
    }, $body, $header);
}





sub _get_name_resolver {

    my $prefix_1 = {
              'attribute' => 'Shipment::Purolator::WSDLV2::Attributes',
              'typemap' => 'Shipment::Purolator::WSDLV2::Typemaps',
              'interface' => 'Shipment::Purolator::WSDLV2::Interfaces',
              'type' => 'Shipment::Purolator::WSDLV2::Types',
              'server' => 'Shipment::Purolator::WSDLV2::Server',
              'element' => 'Shipment::Purolator::WSDLV2::Elements'
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

Shipment::Purolator::WSDLV2::Interfaces::ServiceAvailabilityService::ServiceAvailabilityServiceEndpoint - SOAP Interface for the ServiceAvailabilityService Web Service

=head1 SYNOPSIS

 use Shipment::Purolator::WSDLV2::Interfaces::ServiceAvailabilityService::ServiceAvailabilityServiceEndpoint;
 my $interface = Shipment::Purolator::WSDLV2::Interfaces::ServiceAvailabilityService::ServiceAvailabilityServiceEndpoint->new();

 my $response;
 $response = $interface->GetServicesOptions();
 $response = $interface->GetServiceRules();
 $response = $interface->ValidateCityPostalCodeZip();



=head1 DESCRIPTION

SOAP Interface for the ServiceAvailabilityService web service
located at https://devwebservices.purolator.com/EWS/V1/ServiceAvailability/ServiceAvailabilityService.asmx.

=head1 SERVICE ServiceAvailabilityService



=head2 Port ServiceAvailabilityServiceEndpoint



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



=head3 GetServicesOptions

GetServicesOptions @param request GetServicesOptionsRequest @return GetServicesOptionsResponse

Returns a L<Shipment::Purolator::WSDLV2::Elements::GetServicesOptionsResponse|Shipment::Purolator::WSDLV2::Elements::GetServicesOptionsResponse> object.

 $response = $interface->GetServicesOptions( { # Shipment::Purolator::WSDLV2::Types::GetServicesOptionsRequestContainer
    BillingAccountNumber =>  $some_value, # string
    SenderAddress =>  { # Shipment::Purolator::WSDLV2::Types::ShortAddress
      City =>  $some_value, # string
      Province =>  $some_value, # string
      Country =>  $some_value, # string
      PostalCode =>  $some_value, # string
    },
    ReceiverAddress => {}, # Shipment::Purolator::WSDLV2::Types::ShortAddress
  },,
 );

=head3 GetServiceRules

GetServiceRules @param request GetServiceRulesRequest @return GetServiceRulesResponse

Returns a L<Shipment::Purolator::WSDLV2::Elements::GetServiceRulesResponse|Shipment::Purolator::WSDLV2::Elements::GetServiceRulesResponse> object.

 $response = $interface->GetServiceRules( { # Shipment::Purolator::WSDLV2::Types::GetServiceRulesRequestContainer
    BillingAccountNumber =>  $some_value, # string
    SenderAddress =>  { # Shipment::Purolator::WSDLV2::Types::ShortAddress
      City =>  $some_value, # string
      Province =>  $some_value, # string
      Country =>  $some_value, # string
      PostalCode =>  $some_value, # string
    },
    ReceiverAddress => {}, # Shipment::Purolator::WSDLV2::Types::ShortAddress
  },,
 );

=head3 ValidateCityPostalCodeZip

ValidateCityPostalCodeZip @param request ValidateCityPostalCodeZipRequest @return ValidateCityPostalCodeZipResponse

Returns a L<Shipment::Purolator::WSDLV2::Elements::ValidateCityPostalCodeZipResponse|Shipment::Purolator::WSDLV2::Elements::ValidateCityPostalCodeZipResponse> object.

 $response = $interface->ValidateCityPostalCodeZip( { # Shipment::Purolator::WSDLV2::Types::ValidateCityPostalCodeZipRequestContainer
    Addresses =>  { # Shipment::Purolator::WSDLV2::Types::ArrayOfShortAddress
      ShortAddress =>  { # Shipment::Purolator::WSDLV2::Types::ShortAddress
        City =>  $some_value, # string
        Province =>  $some_value, # string
        Country =>  $some_value, # string
        PostalCode =>  $some_value, # string
      },
    },
  },,
 );



=head1 AUTHOR

Generated by SOAP::WSDL on Wed Sep 15 15:52:15 2010

=cut
