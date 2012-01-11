package Shipment::Temando::WSDL::Interfaces::quoting_Service::quoting_port;
use strict;
use warnings;
use Class::Std::Fast::Storable;
use Scalar::Util qw(blessed);
use base qw(SOAP::WSDL::Client::Base);


# only load if it hasn't been loaded before
require Shipment::Temando::WSDL::Typemaps::quoting_Service
    if not Shipment::Temando::WSDL::Typemaps::quoting_Service->can('get_class');

sub START {

    my $service_address = $_[2]->{service_address} || 'https://api.temando.com/soapServer.html';

    $_[0]->set_proxy($service_address) if not $_[2]->{proxy};

    $_[0]->set_class_resolver('Shipment::Temando::WSDL::Typemaps::quoting_Service')
        if not $_[2]->{class_resolver};

    $_[0]->set_prefix($_[2]->{use_prefix}) if exists $_[2]->{use_prefix};
}

sub getQuotesByRequest {
    my ($self, $body, $header) = @_;
    die "getQuotesByRequest must be called as object method (\$self is <$self>)" if not blessed($self);
    return $self->SUPER::call({
        operation => 'getQuotesByRequest',
        soap_action => 'getQuotesByRequest',
        style => 'document',
        body => {
            

           'use'            => 'literal',
            namespace       => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle   => '',
            parts           =>  [qw( Shipment::Temando::WSDL::Elements::getQuotesByRequest )],
        },
        header => {

            'use' => 'literal',
            namespace => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle => '',
            parts => [qw( Shipment::Temando::WSDL::Elements::TemandoSecurity )],

   
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
            parts           =>  [qw( Shipment::Temando::WSDL::Elements::getQuotesByRequestResponse )],
            },
        }
    }, $body, $header);
}


sub makeBookingByRequest {
    my ($self, $body, $header) = @_;
    die "makeBookingByRequest must be called as object method (\$self is <$self>)" if not blessed($self);
    return $self->SUPER::call({
        operation => 'makeBookingByRequest',
        soap_action => '',
        style => 'document',
        body => {
            

           'use'            => 'literal',
            namespace       => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle   => '',
            parts           =>  [qw( Shipment::Temando::WSDL::Elements::makeBookingByRequest )],
        },
        header => {

            'use' => 'literal',
            namespace => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle => '',
            parts => [qw( Shipment::Temando::WSDL::Elements::TemandoSecurity )],

            
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
            parts           =>  [qw( Shipment::Temando::WSDL::Elements::makeBookingByRequestResponse )],
            },
        }
    }, $body, $header);
}


sub getRequest {
    my ($self, $body, $header) = @_;
    die "getRequest must be called as object method (\$self is <$self>)" if not blessed($self);
    return $self->SUPER::call({
        operation => 'getRequest',
        soap_action => '',
        style => 'document',
        body => {
            

           'use'            => 'literal',
            namespace       => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle   => '',
            parts           =>  [qw( Shipment::Temando::WSDL::Elements::getRequest )],
        },
        header => {

            'use' => 'literal',
            namespace => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle => '',
            parts => [qw( Shipment::Temando::WSDL::Elements::TemandoSecurity )],

            
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
            parts           =>  [qw( Shipment::Temando::WSDL::Elements::getRequestResponse )],
            },
        }
    }, $body, $header);
}


sub getRequestsRequiringBooking {
    my ($self, $body, $header) = @_;
    die "getRequestsRequiringBooking must be called as object method (\$self is <$self>)" if not blessed($self);
    return $self->SUPER::call({
        operation => 'getRequestsRequiringBooking',
        soap_action => '',
        style => 'document',
        body => {
            

           'use'            => 'literal',
            namespace       => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle   => '',
            parts           =>  [qw( Shipment::Temando::WSDL::Elements::getRequestsRequiringBooking )],
        },
        header => {

            'use' => 'literal',
            namespace => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle => '',
            parts => [qw( Shipment::Temando::WSDL::Elements::TemandoSecurity )],

            
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
            parts           =>  [qw( Shipment::Temando::WSDL::Elements::getRequestsRequiringBookingResponse )],
            },
        }
    }, $body, $header);
}


sub addBookingDetails {
    my ($self, $body, $header) = @_;
    die "addBookingDetails must be called as object method (\$self is <$self>)" if not blessed($self);
    return $self->SUPER::call({
        operation => 'addBookingDetails',
        soap_action => '',
        style => 'document',
        body => {
            

           'use'            => 'literal',
            namespace       => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle   => '',
            parts           =>  [qw( Shipment::Temando::WSDL::Elements::addBookingDetails )],
        },
        header => {

            'use' => 'literal',
            namespace => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle => '',
            parts => [qw( Shipment::Temando::WSDL::Elements::TemandoSecurity )],

            
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
            parts           =>  [qw( Shipment::Temando::WSDL::Elements::addBookingDetailsResponse )],
            },
        }
    }, $body, $header);
}


sub createClient {
    my ($self, $body, $header) = @_;
    die "createClient must be called as object method (\$self is <$self>)" if not blessed($self);
    return $self->SUPER::call({
        operation => 'createClient',
        soap_action => '',
        style => 'document',
        body => {
            

           'use'            => 'literal',
            namespace       => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle   => '',
            parts           =>  [qw( Shipment::Temando::WSDL::Elements::createClient )],
        },
        header => {

            'use' => 'literal',
            namespace => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle => '',
            parts => [qw( Shipment::Temando::WSDL::Elements::TemandoSecurity )],

            
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
            parts           =>  [qw( Shipment::Temando::WSDL::Elements::createClientResponse )],
            },
        }
    }, $body, $header);
}


sub updateClient {
    my ($self, $body, $header) = @_;
    die "updateClient must be called as object method (\$self is <$self>)" if not blessed($self);
    return $self->SUPER::call({
        operation => 'updateClient',
        soap_action => '',
        style => 'document',
        body => {
            

           'use'            => 'literal',
            namespace       => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle   => '',
            parts           =>  [qw( Shipment::Temando::WSDL::Elements::updateClient )],
        },
        header => {

            'use' => 'literal',
            namespace => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle => '',
            parts => [qw( Shipment::Temando::WSDL::Elements::TemandoSecurity )],

            
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
            parts           =>  [qw( Shipment::Temando::WSDL::Elements::updateClientResponse )],
            },
        }
    }, $body, $header);
}


sub getClient {
    my ($self, $body, $header) = @_;
    die "getClient must be called as object method (\$self is <$self>)" if not blessed($self);
    return $self->SUPER::call({
        operation => 'getClient',
        soap_action => '',
        style => 'document',
        body => {
            

           'use'            => 'literal',
            namespace       => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle   => '',
            parts           =>  [qw( Shipment::Temando::WSDL::Elements::getClient )],
        },
        header => {

            'use' => 'literal',
            namespace => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle => '',
            parts => [qw( Shipment::Temando::WSDL::Elements::TemandoSecurity )],

            
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
            parts           =>  [qw( Shipment::Temando::WSDL::Elements::getClientResponse )],
            },
        }
    }, $body, $header);
}


sub lodgeDispatch {
    my ($self, $body, $header) = @_;
    die "lodgeDispatch must be called as object method (\$self is <$self>)" if not blessed($self);
    return $self->SUPER::call({
        operation => 'lodgeDispatch',
        soap_action => '',
        style => 'document',
        body => {
            

           'use'            => 'literal',
            namespace       => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle   => '',
            parts           =>  [qw( Shipment::Temando::WSDL::Elements::lodgeDispatch )],
        },
        header => {

            'use' => 'literal',
            namespace => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle => '',
            parts => [qw( Shipment::Temando::WSDL::Elements::TemandoSecurity )],

            
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
            parts           =>  [qw( Shipment::Temando::WSDL::Elements::lodgeDispatchResponse )],
            },
        }
    }, $body, $header);
}


sub cancelRequest {
    my ($self, $body, $header) = @_;
    die "cancelRequest must be called as object method (\$self is <$self>)" if not blessed($self);
    return $self->SUPER::call({
        operation => 'cancelRequest',
        soap_action => '',
        style => 'document',
        body => {
            

           'use'            => 'literal',
            namespace       => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle   => '',
            parts           =>  [qw( Shipment::Temando::WSDL::Elements::cancelRequest )],
        },
        header => {

            'use' => 'literal',
            namespace => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle => '',
            parts => [qw( Shipment::Temando::WSDL::Elements::TemandoSecurity )],

            
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
            parts           =>  [qw( Shipment::Temando::WSDL::Elements::cancelRequestResponse )],
            },
        }
    }, $body, $header);
}


sub updateTrackingDetails {
    my ($self, $body, $header) = @_;
    die "updateTrackingDetails must be called as object method (\$self is <$self>)" if not blessed($self);
    return $self->SUPER::call({
        operation => 'updateTrackingDetails',
        soap_action => '',
        style => 'document',
        body => {
            

           'use'            => 'literal',
            namespace       => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle   => '',
            parts           =>  [qw( Shipment::Temando::WSDL::Elements::updateTrackingDetails )],
        },
        header => {

            'use' => 'literal',
            namespace => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle => '',
            parts => [qw( Shipment::Temando::WSDL::Elements::TemandoSecurity )],

            
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
            parts           =>  [qw( Shipment::Temando::WSDL::Elements::updateTrackingDetailsResponse )],
            },
        }
    }, $body, $header);
}


sub getManifest {
    my ($self, $body, $header) = @_;
    die "getManifest must be called as object method (\$self is <$self>)" if not blessed($self);
    return $self->SUPER::call({
        operation => 'getManifest',
        soap_action => '',
        style => 'document',
        body => {
            

           'use'            => 'literal',
            namespace       => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle   => '',
            parts           =>  [qw( Shipment::Temando::WSDL::Elements::getManifest )],
        },
        header => {

            'use' => 'literal',
            namespace => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle => '',
            parts => [qw( Shipment::Temando::WSDL::Elements::TemandoSecurity )],

            
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
            parts           =>  [qw( Shipment::Temando::WSDL::Elements::getManifestResponse )],
            },
        }
    }, $body, $header);
}


sub confirmManifest {
    my ($self, $body, $header) = @_;
    die "confirmManifest must be called as object method (\$self is <$self>)" if not blessed($self);
    return $self->SUPER::call({
        operation => 'confirmManifest',
        soap_action => '',
        style => 'document',
        body => {
            

           'use'            => 'literal',
            namespace       => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle   => '',
            parts           =>  [qw( Shipment::Temando::WSDL::Elements::confirmManifest )],
        },
        header => {

            'use' => 'literal',
            namespace => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle => '',
            parts => [qw( Shipment::Temando::WSDL::Elements::TemandoSecurity )],

            
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
            parts           =>  [qw( Shipment::Temando::WSDL::Elements::confirmManifestResponse )],
            },
        }
    }, $body, $header);
}


sub getLocations {
    my ($self, $body, $header) = @_;
    die "getLocations must be called as object method (\$self is <$self>)" if not blessed($self);
    return $self->SUPER::call({
        operation => 'getLocations',
        soap_action => '',
        style => 'document',
        body => {
            

           'use'            => 'literal',
            namespace       => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle   => '',
            parts           =>  [qw( Shipment::Temando::WSDL::Elements::getLocations )],
        },
        header => {

            'use' => 'literal',
            namespace => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle => '',
            parts => [qw( Shipment::Temando::WSDL::Elements::TemandoSecurity )],

            
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
            parts           =>  [qw( Shipment::Temando::WSDL::Elements::getLocationsResponse )],
            },
        }
    }, $body, $header);
}


sub createLocation {
    my ($self, $body, $header) = @_;
    die "createLocation must be called as object method (\$self is <$self>)" if not blessed($self);
    return $self->SUPER::call({
        operation => 'createLocation',
        soap_action => '',
        style => 'document',
        body => {
            

           'use'            => 'literal',
            namespace       => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle   => '',
            parts           =>  [qw( Shipment::Temando::WSDL::Elements::createLocation )],
        },
        header => {

            'use' => 'literal',
            namespace => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle => '',
            parts => [qw( Shipment::Temando::WSDL::Elements::TemandoSecurity )],

            
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
            parts           =>  [qw( Shipment::Temando::WSDL::Elements::createLocationResponse )],
            },
        }
    }, $body, $header);
}


sub updateLocation {
    my ($self, $body, $header) = @_;
    die "updateLocation must be called as object method (\$self is <$self>)" if not blessed($self);
    return $self->SUPER::call({
        operation => 'updateLocation',
        soap_action => '',
        style => 'document',
        body => {
            

           'use'            => 'literal',
            namespace       => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle   => '',
            parts           =>  [qw( Shipment::Temando::WSDL::Elements::updateLocation )],
        },
        header => {

            'use' => 'literal',
            namespace => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle => '',
            parts => [qw( Shipment::Temando::WSDL::Elements::TemandoSecurity )],

            
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
            parts           =>  [qw( Shipment::Temando::WSDL::Elements::updateLocationResponse )],
            },
        }
    }, $body, $header);
}





sub _get_name_resolver {

    my $prefix_1 = {
              'attribute' => 'Shipment::Temando::WSDL::Attributes',
              'typemap' => 'Shipment::Temando::WSDL::Typemaps',
              'interface' => 'Shipment::Temando::WSDL::Interfaces',
              'type' => 'Shipment::Temando::WSDL::Types',
              'server' => 'Shipment::Temando::WSDL::Server',
              'element' => 'Shipment::Temando::WSDL::Elements'
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

Shipment::Temando::WSDL::Interfaces::quoting_Service::quoting_port - SOAP Interface for the quoting_Service Web Service

=head1 SYNOPSIS

 use Shipment::Temando::WSDL::Interfaces::quoting_Service::quoting_port;
 my $interface = Shipment::Temando::WSDL::Interfaces::quoting_Service::quoting_port->new();

 my $response;
 $response = $interface->getQuotesByRequest();
 $response = $interface->makeBookingByRequest();
 $response = $interface->getRequest();
 $response = $interface->getRequestsRequiringBooking();
 $response = $interface->addBookingDetails();
 $response = $interface->createClient();
 $response = $interface->updateClient();
 $response = $interface->getClient();
 $response = $interface->lodgeDispatch();
 $response = $interface->cancelRequest();
 $response = $interface->updateTrackingDetails();
 $response = $interface->getManifest();
 $response = $interface->confirmManifest();
 $response = $interface->getLocations();
 $response = $interface->createLocation();
 $response = $interface->updateLocation();



=head1 DESCRIPTION

SOAP Interface for the quoting_Service web service
located at https://api.temando.com/soapServer.html.

=head1 SERVICE quoting_Service



=head2 Port quoting_port



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



=head3 getQuotesByRequest



Returns a L<Shipment::Temando::WSDL::Elements::getQuotesByRequestResponse|Shipment::Temando::WSDL::Elements::getQuotesByRequestResponse> object.

 $response = $interface->getQuotesByRequest( {
    anythings =>  {
      anything =>  { # Shipment::Temando::WSDL::Types::Anything
        class => $some_value, # Class
        subclass => $some_value, # Subclass
        mode => $some_value, # Mode
        tlSubclass => $some_value, # TlSubclass
        packaging => $some_value, # Packaging
        palletType => $some_value, # PalletType
        palletNature => $some_value, # PalletNature
        containerDimensions => $some_value, # ContainerDimensions
        containerNature => $some_value, # ContainerNature
        containerRegistered => $some_value, # YesNoOption
        qualifierFreightGeneralDangerousGoods => $some_value, # YesNoOption
        qualifierFreightGeneralFragile => $some_value, # YesNoOption
        qualifierFreightGeneralRefrigerated => $some_value, # YesNoOption
        qualifierVehicleMake => $some_value, # VehicleMake
        qualifierVehicleModel => $some_value, # VehicleModel
        qualifierVehicleDescription => $some_value, # VehicleDescription
        qualifierVehicleRunning => $some_value, # YesNoOption
        qualifierVehicleRegistered => $some_value, # YesNoOption
        qualifierVehicleYear => $some_value, # VehicleYear
        qualifierVehicleRegistration => $some_value, # VehicleRegistration
        qualifierBoatMake => $some_value, # BoatMake
        qualifierBoatModel => $some_value, # BoatModel
        qualifierBoatSeaworthy => $some_value, # YesNoOption
        qualifierBoatTrailer => $some_value, # YesNoOption
        qualifierBoatHullType => $some_value, # BoatHullType
        qualifierLivestockType => $some_value, # LivestockType
        qualifierAnimalVaccinated => $some_value, # YesNoOption
        qualifierAnimalRegistered => $some_value, # YesNoOption
        qualifierAnimalType => $some_value, # AnimalType
        qualifierAnimalBreed => $some_value, # AnimalBreed
        qualifierAnimalSex => $some_value, # Sex
        qualifierAnimalAge => $some_value, # AnimalAge
        qualifierAnimalCrate => $some_value, # AnimalCrate
        distanceMeasurementType => $some_value, # DistanceMeasurementType
        weightMeasurementType => $some_value, # WeightMeasurementType
        length => $some_value, # Length
        width => $some_value, # Width
        height => $some_value, # Height
        weight => $some_value, # Weight
        quantity => $some_value, # Quantity
        description => $some_value, # ItemDescription
      },
    },
    anywhere =>  { # Shipment::Temando::WSDL::Types::Anywhere
      itemNature => $some_value, # DeliveryNature
      itemMethod => $some_value, # DeliveryType
      originDescription => $some_value, # LocationName
      originCountry => $some_value, # CountryCode
      originCode => $some_value, # PostalCode
      originSuburb => $some_value, # Suburb
      originState => $some_value, # State
      originCity => $some_value, # City
      originPort => $some_value, # PortName
      destinationDescription => $some_value, # LocationName
      destinationCountry => $some_value, # CountryCode
      destinationCode => $some_value, # PostalCode
      destinationSuburb => $some_value, # Suburb
      destinationState => $some_value, # State
      destinationCity => $some_value, # City
      destinationPort => $some_value, # PortName
      portType => $some_value, # PortType
      destinationIs => $some_value, # LocationType
      destinationBusPostalBox => $some_value, # YesNoOption
      destinationBusUnattended => $some_value, # YesNoOption
      destinationBusDock => $some_value, # YesNoOption
      destinationBusForklift => $some_value, # YesNoOption
      destinationBusLoadingFacilities => $some_value, # YesNoOption
      destinationBusInside => $some_value, # YesNoOption
      destinationBusNotifyBefore => $some_value, # YesNoOption
      destinationBusLimitedAccess => $some_value, # YesNoOption
      destinationBusHeavyLift => $some_value, # YesNoOption
      destinationBusTailgateLifter => $some_value, # YesNoOption
      destinationBusContainerSwingLifter => $some_value, # YesNoOption
      destinationResPostalBox => $some_value, # YesNoOption
      destinationResUnattended => $some_value, # YesNoOption
      destinationResInside => $some_value, # YesNoOption
      destinationResNotifyBefore => $some_value, # YesNoOption
      destinationResLimitedAccess => $some_value, # YesNoOption
      destinationResHeavyLift => $some_value, # YesNoOption
      destinationResTailgateLifter => $some_value, # YesNoOption
      originIs => $some_value, # LocationType
      originBusUnattended => $some_value, # YesNoOption
      originBusDock => $some_value, # YesNoOption
      originBusForklift => $some_value, # YesNoOption
      originBusLoadingFacilities => $some_value, # YesNoOption
      originBusInside => $some_value, # YesNoOption
      originBusNotifyBefore => $some_value, # YesNoOption
      originBusLimitedAccess => $some_value, # YesNoOption
      originBusHeavyLift => $some_value, # YesNoOption
      originBusTailgateLifter => $some_value, # YesNoOption
      originBusContainerSwingLifter => $some_value, # YesNoOption
      originResUnattended => $some_value, # YesNoOption
      originResInside => $some_value, # YesNoOption
      originResNotifyBefore => $some_value, # YesNoOption
      originResLimitedAccess => $some_value, # YesNoOption
      originResHeavyLift => $some_value, # YesNoOption
      originResTailgateLifter => $some_value, # YesNoOption
    },
    anytime =>  { # Shipment::Temando::WSDL::Types::Anytime
      readyDate => $some_value, # Date
      readyTime => $some_value, # ReadyTime
    },
    general =>  { # Shipment::Temando::WSDL::Types::General
      goodsValue => $some_value, # CurrencyAmount
    },
    clientId => $some_value, # ClientId
  },,
 );

=head3 makeBookingByRequest



Returns a L<Shipment::Temando::WSDL::Elements::makeBookingByRequestResponse|Shipment::Temando::WSDL::Elements::makeBookingByRequestResponse> object.

 $response = $interface->makeBookingByRequest( {
    anythings =>  {
      anything =>  { # Shipment::Temando::WSDL::Types::Anything
        class => $some_value, # Class
        subclass => $some_value, # Subclass
        mode => $some_value, # Mode
        tlSubclass => $some_value, # TlSubclass
        packaging => $some_value, # Packaging
        palletType => $some_value, # PalletType
        palletNature => $some_value, # PalletNature
        containerDimensions => $some_value, # ContainerDimensions
        containerNature => $some_value, # ContainerNature
        containerRegistered => $some_value, # YesNoOption
        qualifierFreightGeneralDangerousGoods => $some_value, # YesNoOption
        qualifierFreightGeneralFragile => $some_value, # YesNoOption
        qualifierFreightGeneralRefrigerated => $some_value, # YesNoOption
        qualifierVehicleMake => $some_value, # VehicleMake
        qualifierVehicleModel => $some_value, # VehicleModel
        qualifierVehicleDescription => $some_value, # VehicleDescription
        qualifierVehicleRunning => $some_value, # YesNoOption
        qualifierVehicleRegistered => $some_value, # YesNoOption
        qualifierVehicleYear => $some_value, # VehicleYear
        qualifierVehicleRegistration => $some_value, # VehicleRegistration
        qualifierBoatMake => $some_value, # BoatMake
        qualifierBoatModel => $some_value, # BoatModel
        qualifierBoatSeaworthy => $some_value, # YesNoOption
        qualifierBoatTrailer => $some_value, # YesNoOption
        qualifierBoatHullType => $some_value, # BoatHullType
        qualifierLivestockType => $some_value, # LivestockType
        qualifierAnimalVaccinated => $some_value, # YesNoOption
        qualifierAnimalRegistered => $some_value, # YesNoOption
        qualifierAnimalType => $some_value, # AnimalType
        qualifierAnimalBreed => $some_value, # AnimalBreed
        qualifierAnimalSex => $some_value, # Sex
        qualifierAnimalAge => $some_value, # AnimalAge
        qualifierAnimalCrate => $some_value, # AnimalCrate
        distanceMeasurementType => $some_value, # DistanceMeasurementType
        weightMeasurementType => $some_value, # WeightMeasurementType
        length => $some_value, # Length
        width => $some_value, # Width
        height => $some_value, # Height
        weight => $some_value, # Weight
        quantity => $some_value, # Quantity
        description => $some_value, # ItemDescription
      },
    },
    anywhere =>  { # Shipment::Temando::WSDL::Types::Anywhere
      itemNature => $some_value, # DeliveryNature
      itemMethod => $some_value, # DeliveryType
      originDescription => $some_value, # LocationName
      originCountry => $some_value, # CountryCode
      originCode => $some_value, # PostalCode
      originSuburb => $some_value, # Suburb
      originState => $some_value, # State
      originCity => $some_value, # City
      originPort => $some_value, # PortName
      destinationDescription => $some_value, # LocationName
      destinationCountry => $some_value, # CountryCode
      destinationCode => $some_value, # PostalCode
      destinationSuburb => $some_value, # Suburb
      destinationState => $some_value, # State
      destinationCity => $some_value, # City
      destinationPort => $some_value, # PortName
      portType => $some_value, # PortType
      destinationIs => $some_value, # LocationType
      destinationBusPostalBox => $some_value, # YesNoOption
      destinationBusUnattended => $some_value, # YesNoOption
      destinationBusDock => $some_value, # YesNoOption
      destinationBusForklift => $some_value, # YesNoOption
      destinationBusLoadingFacilities => $some_value, # YesNoOption
      destinationBusInside => $some_value, # YesNoOption
      destinationBusNotifyBefore => $some_value, # YesNoOption
      destinationBusLimitedAccess => $some_value, # YesNoOption
      destinationBusHeavyLift => $some_value, # YesNoOption
      destinationBusTailgateLifter => $some_value, # YesNoOption
      destinationBusContainerSwingLifter => $some_value, # YesNoOption
      destinationResPostalBox => $some_value, # YesNoOption
      destinationResUnattended => $some_value, # YesNoOption
      destinationResInside => $some_value, # YesNoOption
      destinationResNotifyBefore => $some_value, # YesNoOption
      destinationResLimitedAccess => $some_value, # YesNoOption
      destinationResHeavyLift => $some_value, # YesNoOption
      destinationResTailgateLifter => $some_value, # YesNoOption
      originIs => $some_value, # LocationType
      originBusUnattended => $some_value, # YesNoOption
      originBusDock => $some_value, # YesNoOption
      originBusForklift => $some_value, # YesNoOption
      originBusLoadingFacilities => $some_value, # YesNoOption
      originBusInside => $some_value, # YesNoOption
      originBusNotifyBefore => $some_value, # YesNoOption
      originBusLimitedAccess => $some_value, # YesNoOption
      originBusHeavyLift => $some_value, # YesNoOption
      originBusTailgateLifter => $some_value, # YesNoOption
      originBusContainerSwingLifter => $some_value, # YesNoOption
      originResUnattended => $some_value, # YesNoOption
      originResInside => $some_value, # YesNoOption
      originResNotifyBefore => $some_value, # YesNoOption
      originResLimitedAccess => $some_value, # YesNoOption
      originResHeavyLift => $some_value, # YesNoOption
      originResTailgateLifter => $some_value, # YesNoOption
    },
    anytime =>  { # Shipment::Temando::WSDL::Types::Anytime
      readyDate => $some_value, # Date
      readyTime => $some_value, # ReadyTime
    },
    general =>  { # Shipment::Temando::WSDL::Types::General
      goodsValue => $some_value, # CurrencyAmount
    },
    origin =>  { # Shipment::Temando::WSDL::Types::Location
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
    destination =>  { # Shipment::Temando::WSDL::Types::Location
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
    quote =>  { # Shipment::Temando::WSDL::Types::BookingQuote
      totalPrice => $some_value, # CurrencyAmount
      basePrice => $some_value, # CurrencyAmount
      tax => $some_value, # CurrencyAmount
      currency => $some_value, # CurrencyType
      deliveryMethod => $some_value, # DeliveryMethod
      etaFrom => $some_value, # Eta
      etaTo => $some_value, # Eta
      guaranteedEta => $some_value, # YesNoOption
      carrierId => $some_value, # CarrierId
      extras =>  {
        extra =>  { # Shipment::Temando::WSDL::Types::Extra
          summary => $some_value, # ExtraSummary
          details => $some_value, # ExtraDetails
          totalPrice => $some_value, # CurrencyAmount
          basePrice => $some_value, # CurrencyAmount
          tax => $some_value, # CurrencyAmount
          adjustments =>  {
            adjustment =>  { # Shipment::Temando::WSDL::Types::Adjustment
              description => $some_value, # AdjustmentDescription
              amount => $some_value, # CurrencyAmount
              tax => $some_value, # CurrencyAmount
            },
          },
        },
      },
    },
    payment =>  { # Shipment::Temando::WSDL::Types::Payment
      paymentType => $some_value, # PaymentType
      cardType => $some_value, # CreditCardType
      cardExpiryDate => $some_value, # CreditCardExpiryDate
      cardNumber => $some_value, # CreditCardNumber
      cardName => $some_value, # CreditCardName
      paypalPayerId => $some_value, # PaypalPayerId
      paypalToken => $some_value, # PaypalToken
    },
    instructions => $some_value, # Instructions
    comments => $some_value, # Comments
    reference => $some_value, # ClientReference
    promotionCode => $some_value, # PromotionCode
    clientId => $some_value, # ClientId
    labelPrinterType => $some_value, # LabelPrinterType
  },,
 );

=head3 getRequest



Returns a L<Shipment::Temando::WSDL::Elements::getRequestResponse|Shipment::Temando::WSDL::Elements::getRequestResponse> object.

 $response = $interface->getRequest( {
    requestId =>  $some_value, # positiveInteger
    bookingNumber => $some_value, # BookingNumber
    reference => $some_value, # ClientReference
    detail => $some_value, # Detail
  },,
 );

=head3 getRequestsRequiringBooking



Returns a L<Shipment::Temando::WSDL::Elements::getRequestsRequiringBookingResponse|Shipment::Temando::WSDL::Elements::getRequestsRequiringBookingResponse> object.

 $response = $interface->getRequestsRequiringBooking(,,
 );

=head3 addBookingDetails



Returns a L<Shipment::Temando::WSDL::Elements::addBookingDetailsResponse|Shipment::Temando::WSDL::Elements::addBookingDetailsResponse> object.

 $response = $interface->addBookingDetails( {
    requestId =>  $some_value, # positiveInteger
    bookingNumber => $some_value, # BookingNumber
    consignmentNumber => $some_value, # ConsignmentNumber
    consignmentDocument => $some_value, # ConsignmentDocument
    consignmentDocumentType => $some_value, # ConsignmentDocumentType
  },,
 );

=head3 createClient



Returns a L<Shipment::Temando::WSDL::Elements::createClientResponse|Shipment::Temando::WSDL::Elements::createClientResponse> object.

 $response = $interface->createClient( {
    loginDetails =>  { # Shipment::Temando::WSDL::Types::LoginDetails
      loginId => $some_value, # LoginId
      password => $some_value, # Password
    },
    client =>  { # Shipment::Temando::WSDL::Types::Client
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
    promotionCode => $some_value, # PromotionCode
  },,
 );

=head3 updateClient



Returns a L<Shipment::Temando::WSDL::Elements::updateClientResponse|Shipment::Temando::WSDL::Elements::updateClientResponse> object.

 $response = $interface->updateClient( {
    client =>  { # Shipment::Temando::WSDL::Types::Client
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
  },,
 );

=head3 getClient



Returns a L<Shipment::Temando::WSDL::Elements::getClientResponse|Shipment::Temando::WSDL::Elements::getClientResponse> object.

 $response = $interface->getClient( {
    loginDetails =>  { # Shipment::Temando::WSDL::Types::LoginDetails
      loginId => $some_value, # LoginId
      password => $some_value, # Password
    },
    clientId => $some_value, # ClientId
  },,
 );

=head3 lodgeDispatch



Returns a L<Shipment::Temando::WSDL::Elements::lodgeDispatchResponse|Shipment::Temando::WSDL::Elements::lodgeDispatchResponse> object.

 $response = $interface->lodgeDispatch( {
    requestId =>  $some_value, # positiveInteger
    bookingNumber => $some_value, # BookingNumber
    dispatchDetails =>  { # Shipment::Temando::WSDL::Types::DispatchDetails
      reference => $some_value, # CarrierReference
      carrierName => $some_value, # CompanyName
      carrierId => $some_value, # CarrierId
      accountNo => $some_value, # CarrierAccountNumber
      creatorId => $some_value, # CarrierCreatorId
      currency => $some_value, # CurrencyType
      changedCarrier => $some_value, # YesNoOption
      consignmentEdited => $some_value, # YesNoOption
      consignmentNumber => $some_value, # ConsignmentNumber
      consignmentDate => $some_value, # Date
      deliveryMethod => $some_value, # DeliveryMethod
      rateName => $some_value, # RateName
      description => $some_value, # ItemDescription
      distanceMeasurementType => $some_value, # DistanceMeasurementType
      weightMeasurementType => $some_value, # WeightMeasurementType
      length => $some_value, # Length
      width => $some_value, # Width
      height => $some_value, # Height
      actualWeight => $some_value, # Weight
      chargeableWeight => $some_value, # Weight
      actualCubic => $some_value, # Cubic
      chargeableCubic => $some_value, # Cubic
      actualQuantity => $some_value, # Quantity
      chargeableQuantity => $some_value, # Quantity
      basePrice => $some_value, # CurrencyAmount
      surcharges => $some_value, # CurrencyAmount
      tax => $some_value, # CurrencyAmount
      totalPrice => $some_value, # CurrencyAmount
      originZoneName => $some_value, # ZoneName
      originContactName => $some_value, # ContactName
      originCompanyName => $some_value, # CompanyName
      originStreet => $some_value, # Address
      originSuburb => $some_value, # Suburb
      originState => $some_value, # State
      originCode => $some_value, # PostalCode
      originCountry => $some_value, # CountryCode
      originPhone1 => $some_value, # Phone
      originPhone2 => $some_value, # Phone
      originFax => $some_value, # Fax
      originEmail => $some_value, # Email
      destinationZoneName => $some_value, # ZoneName
      destinationContactName => $some_value, # ContactName
      destinationCompanyName => $some_value, # CompanyName
      destinationStreet => $some_value, # Address
      destinationSuburb => $some_value, # Suburb
      destinationState => $some_value, # State
      destinationCode => $some_value, # PostalCode
      destinationCountry => $some_value, # CountryCode
      destinationPhone1 => $some_value, # Phone
      destinationPhone2 => $some_value, # Phone
      destinationFax => $some_value, # Fax
      destinationEmail => $some_value, # Email
    },
  },,
 );

=head3 cancelRequest



Returns a L<Shipment::Temando::WSDL::Elements::cancelRequestResponse|Shipment::Temando::WSDL::Elements::cancelRequestResponse> object.

 $response = $interface->cancelRequest( {
    requestId =>  $some_value, # positiveInteger
    reference => $some_value, # ClientReference
  },,
 );

=head3 updateTrackingDetails



Returns a L<Shipment::Temando::WSDL::Elements::updateTrackingDetailsResponse|Shipment::Temando::WSDL::Elements::updateTrackingDetailsResponse> object.

 $response = $interface->updateTrackingDetails( {
    requestId =>  $some_value, # positiveInteger
    bookingNumber => $some_value, # BookingNumber
    trackingStatus => $some_value, # TrackingStatus
    trackingStatusOccurred => $some_value, # Datetime
    trackingFurtherDetails => $some_value, # TrackingFurtherDetails
  },,
 );

=head3 getManifest



Returns a L<Shipment::Temando::WSDL::Elements::getManifestResponse|Shipment::Temando::WSDL::Elements::getManifestResponse> object.

 $response = $interface->getManifest( {
    type => $some_value, # ManifestType
    labelPrinterType => $some_value, # LabelPrinterType
    carrierId => $some_value, # CarrierId
    clientId => $some_value, # ClientId
    location => $some_value, # LocationName
    readyDate => $some_value, # Date
    lastConfirmed => $some_value, # YesNoOption
    listRequests => $some_value, # YesNoOption
  },,
 );

=head3 confirmManifest



Returns a L<Shipment::Temando::WSDL::Elements::confirmManifestResponse|Shipment::Temando::WSDL::Elements::confirmManifestResponse> object.

 $response = $interface->confirmManifest( {
    carrierId => $some_value, # CarrierId
    clientId => $some_value, # ClientId
    location => $some_value, # LocationName
    startReadyDate => $some_value, # Date
    endReadyDate => $some_value, # Date
    confirmedReadyDate => $some_value, # Date
    listRequests => $some_value, # YesNoOption
    labelPrinterType => $some_value, # LabelPrinterType
  },,
 );

=head3 getLocations



Returns a L<Shipment::Temando::WSDL::Elements::getLocationsResponse|Shipment::Temando::WSDL::Elements::getLocationsResponse> object.

 $response = $interface->getLocations( {
    clientId => $some_value, # ClientId
    description => $some_value, # LocationName
    type => $some_value, # LocationPosition
  },,
 );

=head3 createLocation



Returns a L<Shipment::Temando::WSDL::Elements::createLocationResponse|Shipment::Temando::WSDL::Elements::createLocationResponse> object.

 $response = $interface->createLocation( {
    clientId => $some_value, # ClientId
    location =>  { # Shipment::Temando::WSDL::Types::Location
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
  },,
 );

=head3 updateLocation



Returns a L<Shipment::Temando::WSDL::Elements::updateLocationResponse|Shipment::Temando::WSDL::Elements::updateLocationResponse> object.

 $response = $interface->updateLocation( {
    clientId => $some_value, # ClientId
    location =>  { # Shipment::Temando::WSDL::Types::Location
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
  },,
 );



=head1 AUTHOR

Generated by SOAP::WSDL on Mon Jan  9 22:46:02 2012

=cut
