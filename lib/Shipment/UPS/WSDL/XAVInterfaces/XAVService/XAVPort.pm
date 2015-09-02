package Shipment::UPS::WSDL::XAVInterfaces::XAVService::XAVPort;
use strict;
use warnings;
use Class::Std::Fast::Storable;
use Scalar::Util qw(blessed);
use base qw(SOAP::WSDL::Client::Base);


# only load if it hasn't been loaded before
require Shipment::UPS::WSDL::XAVTypemaps::XAVService
    if not Shipment::UPS::WSDL::XAVTypemaps::XAVService->can('get_class');


sub START {

    my $proxy_domain = $_[2]->{proxy_domain} || 'wwwcie.ups.com';

    $_[0]->set_proxy('https://' . $proxy_domain . '/webservices/XAV') if not $_[2]->{proxy};

    $_[0]->set_class_resolver('Shipment::UPS::WSDL::XAVTypemaps::XAVService')
        if not $_[2]->{class_resolver};

    $_[0]->set_prefix($_[2]->{use_prefix}) if exists $_[2]->{use_prefix};
}

sub ProcessXAV {
    my ($self, $body, $header) = @_;
    die "ProcessXAV must be called as object method (\$self is <$self>)" if not blessed($self);
    return $self->SUPER::call({
        operation => 'ProcessXAV',
        soap_action => 'http://onlinetools.ups.com/webservices/XAVBinding/v1.0',
        style => 'document',
        body => {
            

           'use'            => 'literal',
            namespace       => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle   => '',
            parts           =>  [qw( Shipment::UPS::WSDL::XAVElements::XAVRequest )],
        },
        header => {
            
           'use' => 'literal',
            namespace => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle => '',
            parts => [qw( Shipment::UPS::WSDL::XAVElements::UPSSecurity )],

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
            parts           =>  [qw( Shipment::UPS::WSDL::XAVElements::XAVResponse )],
            },
        }
    }, $body, $header);
}





sub _get_name_resolver {

    my $prefix_1 = {
              'attribute' => 'Shipment::UPS::WSDL::XAVAttributes',
              'typemap' => 'Shipment::UPS::WSDL::XAVTypemaps',
              'interface' => 'Shipment::UPS::WSDL::XAVInterfaces',
              'type' => 'Shipment::UPS::WSDL::XAVTypes',
              'server' => 'Shipment::UPS::WSDL::XAVServer',
              'element' => 'Shipment::UPS::WSDL::XAVElements'
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

Shipment::UPS::WSDL::XAVInterfaces::XAVService::XAVPort - SOAP Interface for the XAVService Web Service

=head1 SYNOPSIS

 use Shipment::UPS::WSDL::XAVInterfaces::XAVService::XAVPort;
 my $interface = Shipment::UPS::WSDL::XAVInterfaces::XAVService::XAVPort->new();

 my $response;
 $response = $interface->ProcessXAV();



=head1 DESCRIPTION

SOAP Interface for the XAVService web service
located at https://wwwcie.ups.com/webservices/XAV.

=head1 SERVICE XAVService



=head2 Port XAVPort



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



=head3 ProcessXAV



Returns a L<Shipment::UPS::WSDL::XAVElements::XAVResponse|Shipment::UPS::WSDL::XAVElements::XAVResponse> object.

 $response = $interface->ProcessXAV( {
    Request =>  { # Shipment::UPS::WSDL::XAVTypes::RequestType
      RequestOption =>  $some_value, # string
      TransactionReference =>  { # Shipment::UPS::WSDL::XAVTypes::TransactionReferenceType
        CustomerContext =>  $some_value, # string
        TransactionIdentifier =>  $some_value, # string
      },
    },
    RegionalRequestIndicator =>  $some_value, # string
    MaximumCandidateListSize =>  $some_value, # string
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

Generated by SOAP::WSDL on Wed Aug 22 14:25:52 2012

=cut
