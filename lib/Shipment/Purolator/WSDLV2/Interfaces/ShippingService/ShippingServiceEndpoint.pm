package Shipment::Purolator::WSDLV2::Interfaces::ShippingService::ShippingServiceEndpoint;
use strict;
use warnings;
use Class::Std::Fast::Storable;
use Scalar::Util qw(blessed);
use base qw(SOAP::WSDL::Client::Base);


# only load if it hasn't been loaded before
require Shipment::Purolator::WSDLV2::Typemaps::ShippingService
    if not Shipment::Purolator::WSDLV2::Typemaps::ShippingService->can('get_class');


sub START {

    my $proxy_domain = $_[2]->{proxy_domain} || 'devwebservices.purolator.com';

    $_[0]->set_proxy('https://' . $proxy_domain . '/EWS/V2/Shipping/ShippingService.asmx') if not $_[2]->{proxy};

    $_[0]->set_class_resolver('Shipment::Purolator::WSDLV2::Typemaps::ShippingService')
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

sub CreateShipment {
    my ($self, $body, $header) = @_;
    die "CreateShipment must be called as object method (\$self is <$self>)" if not blessed($self);
    return $self->SUPER::call({
        operation => 'CreateShipment',
        soap_action => 'http://purolator.com/pws/service/v2/CreateShipment',
        style => 'document',
        body => {
            

           'use'            => 'literal',
            namespace       => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle   => '',
            parts           =>  [qw( Shipment::Purolator::WSDLV2::Elements::CreateShipmentRequest )],
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
            parts           =>  [qw( Shipment::Purolator::WSDLV2::Elements::CreateShipmentResponse )],
            },
        }
    }, $body, $header);
}


sub VoidShipment {
    my ($self, $body, $header) = @_;
    die "VoidShipment must be called as object method (\$self is <$self>)" if not blessed($self);
    return $self->SUPER::call({
        operation => 'VoidShipment',
        soap_action => 'http://purolator.com/pws/service/v2/VoidShipment',
        style => 'document',
        body => {
            

           'use'            => 'literal',
            namespace       => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle   => '',
            parts           =>  [qw( Shipment::Purolator::WSDLV2::Elements::VoidShipmentRequest )],
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
            parts           =>  [qw( Shipment::Purolator::WSDLV2::Elements::VoidShipmentResponse )],
            },
        }
    }, $body, $header);
}


sub ValidateShipment {
    my ($self, $body, $header) = @_;
    die "ValidateShipment must be called as object method (\$self is <$self>)" if not blessed($self);
    return $self->SUPER::call({
        operation => 'ValidateShipment',
        soap_action => 'http://purolator.com/pws/service/v2/ValidateShipment',
        style => 'document',
        body => {
            

           'use'            => 'literal',
            namespace       => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle   => '',
            parts           =>  [qw( Shipment::Purolator::WSDLV2::Elements::ValidateShipmentRequest )],
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
            parts           =>  [qw( Shipment::Purolator::WSDLV2::Elements::ValidateShipmentResponse )],
            },
        }
    }, $body, $header);
}


sub Consolidate {
    my ($self, $body, $header) = @_;
    die "Consolidate must be called as object method (\$self is <$self>)" if not blessed($self);
    return $self->SUPER::call({
        operation => 'Consolidate',
        soap_action => 'http://purolator.com/pws/service/v2/Consolidate',
        style => 'document',
        body => {
            

           'use'            => 'literal',
            namespace       => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle   => '',
            parts           =>  [qw( Shipment::Purolator::WSDLV2::Elements::ConsolidateRequest )],
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
            parts           =>  [qw( Shipment::Purolator::WSDLV2::Elements::ConsolidateResponse )],
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

Shipment::Purolator::WSDLV2::Interfaces::ShippingService::ShippingServiceEndpoint - SOAP Interface for the ShippingService Web Service

=head1 SYNOPSIS

 use Shipment::Purolator::WSDLV2::Interfaces::ShippingService::ShippingServiceEndpoint;
 my $interface = Shipment::Purolator::WSDLV2::Interfaces::ShippingService::ShippingServiceEndpoint->new();

 my $response;
 $response = $interface->CreateShipment();
 $response = $interface->VoidShipment();
 $response = $interface->ValidateShipment();
 $response = $interface->Consolidate();



=head1 DESCRIPTION

SOAP Interface for the ShippingService web service
located at https://devwebservices.purolator.com/EWS/V1/Shipping/ShippingService.asmx.

=head1 SERVICE ShippingService



=head2 Port ShippingServiceEndpoint



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



=head3 CreateShipment

CreateShipment @param request CreateShipmentRequest @return CreateShipmentResponse 

Returns a L<Shipment::Purolator::WSDLV2::Elements::CreateShipmentResponse|Shipment::Purolator::WSDLV2::Elements::CreateShipmentResponse> object.

 $response = $interface->CreateShipment( { # Shipment::Purolator::WSDLV2::Types::CreateShipmentRequestContainer
    Shipment =>  { # Shipment::Purolator::WSDLV2::Types::Shipment
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
        OptionsInformation =>  { # Shipment::Purolator::WSDLV2::Types::OptionsInformation
          Options => {}, # Shipment::Purolator::WSDLV2::Types::ArrayOfOptionIDValuePair
          ExpressChequeAddress => {}, # Shipment::Purolator::WSDLV2::Types::Address
        },
      },
      InternationalInformation =>  { # Shipment::Purolator::WSDLV2::Types::InternationalInformation
        DocumentsOnlyIndicator =>  $some_value, # boolean
        ContentDetails =>  { # Shipment::Purolator::WSDLV2::Types::ArrayOfContentDetail
          ContentDetail =>  { # Shipment::Purolator::WSDLV2::Types::ContentDetail
            Description =>  $some_value, # string
            HarmonizedCode =>  $some_value, # string
            CountryOfManufacture =>  $some_value, # string
            ProductCode =>  $some_value, # string
            UnitValue =>  $some_value, # decimal
            Quantity =>  $some_value, # int
            NAFTADocumentIndicator =>  $some_value, # boolean
            FDADocumentIndicator =>  $some_value, # boolean
            FCCDocumentIndicator =>  $some_value, # boolean
            SenderIsProducerIndicator =>  $some_value, # boolean
            TextileIndicator =>  $some_value, # boolean
            TextileManufacturer =>  $some_value, # string
          },
        },
        BuyerInformation =>  { # Shipment::Purolator::WSDLV2::Types::BuyerInformation
          Address => {}, # Shipment::Purolator::WSDLV2::Types::Address
          TaxNumber =>  $some_value, # string
        },
        PreferredCustomsBroker =>  $some_value, # string
        DutyInformation =>  { # Shipment::Purolator::WSDLV2::Types::DutyInformation
          BillDutiesToParty => $some_value, # BillDutiesToParty
          BusinessRelationship => $some_value, # BusinessRelationship
          Currency => $some_value, # DutyCurrency
        },
        ImportExportType => $some_value, # ImportExportType
        CustomsInvoiceDocumentIndicator =>  $some_value, # boolean
      },
      ReturnShipmentInformation =>  { # Shipment::Purolator::WSDLV2::Types::ReturnShipmentInformation
        NumberOfReturnShipments =>  $some_value, # int
        ReturnShipment =>  { # Shipment::Purolator::WSDLV2::Types::ReturnShipment
          SenderInformation => {}, # Shipment::Purolator::WSDLV2::Types::SenderInformation
          ReceiverInformation => {}, # Shipment::Purolator::WSDLV2::Types::ReceiverInformation
          PackageInformation => {}, # Shipment::Purolator::WSDLV2::Types::PackageInformation
          PaymentInformation =>  { # Shipment::Purolator::WSDLV2::Types::PaymentInformation
            PaymentType => $some_value, # PaymentType
            RegisteredAccountNumber =>  $some_value, # string
            BillingAccountNumber =>  $some_value, # string
            CreditCardInformation =>  { # Shipment::Purolator::WSDLV2::Types::CreditCardInformation
              Type => $some_value, # CreditCardType
              Number =>  $some_value, # string
              Name =>  $some_value, # string
              ExpiryMonth =>  $some_value, # int
              ExpiryYear =>  $some_value, # int
              CVV =>  $some_value, # string
            },
          },
          PickupInformation =>  { # Shipment::Purolator::WSDLV2::Types::PickupInformation
            PickupType => $some_value, # PickupType
          },
          NotificationInformation =>  { # Shipment::Purolator::WSDLV2::Types::NotificationInformation
            ConfirmationEmailAddress =>  $some_value, # string
            AdvancedShippingNotificationEmailAddress1 =>  $some_value, # string
            AdvancedShippingNotificationEmailAddress2 =>  $some_value, # string
            AdvancedShippingNotificationMessage =>  $some_value, # string
          },
          TrackingReferenceInformation =>  { # Shipment::Purolator::WSDLV2::Types::TrackingReferenceInformation
            Reference1 =>  $some_value, # string
            Reference2 =>  $some_value, # string
            Reference3 =>  $some_value, # string
            Reference4 =>  $some_value, # string
          },
          OtherInformation =>  { # Shipment::Purolator::WSDLV2::Types::OtherInformation
            CostCentre =>  $some_value, # string
            SpecialInstructions =>  $some_value, # string
          },
        },
      },
      PaymentInformation => {}, # Shipment::Purolator::WSDLV2::Types::PaymentInformation
      PickupInformation => {}, # Shipment::Purolator::WSDLV2::Types::PickupInformation
      NotificationInformation => {}, # Shipment::Purolator::WSDLV2::Types::NotificationInformation
      TrackingReferenceInformation => {}, # Shipment::Purolator::WSDLV2::Types::TrackingReferenceInformation
      OtherInformation => {}, # Shipment::Purolator::WSDLV2::Types::OtherInformation
    },
    PrinterType => $some_value, # PrinterType
  },,
 );

=head3 VoidShipment

VoidShipment @param request VoidShipmentRequest @return VoidShipmentResponse 

Returns a L<Shipment::Purolator::WSDLV2::Elements::VoidShipmentResponse|Shipment::Purolator::WSDLV2::Elements::VoidShipmentResponse> object.

 $response = $interface->VoidShipment( { # Shipment::Purolator::WSDLV2::Types::VoidShipmentRequestContainer
    PIN =>  { # Shipment::Purolator::WSDLV2::Types::PIN
      Value =>  $some_value, # string
    },
  },,
 );

=head3 ValidateShipment

ValidateShipment @param request ValidateShipmentRequest @return ValidateShipmentResponse 

Returns a L<Shipment::Purolator::WSDLV2::Elements::ValidateShipmentResponse|Shipment::Purolator::WSDLV2::Elements::ValidateShipmentResponse> object.

 $response = $interface->ValidateShipment( { # Shipment::Purolator::WSDLV2::Types::ValidateShipmentRequestContainer
    Shipment =>  { # Shipment::Purolator::WSDLV2::Types::Shipment
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
        OptionsInformation =>  { # Shipment::Purolator::WSDLV2::Types::OptionsInformation
          Options => {}, # Shipment::Purolator::WSDLV2::Types::ArrayOfOptionIDValuePair
          ExpressChequeAddress => {}, # Shipment::Purolator::WSDLV2::Types::Address
        },
      },
      InternationalInformation =>  { # Shipment::Purolator::WSDLV2::Types::InternationalInformation
        DocumentsOnlyIndicator =>  $some_value, # boolean
        ContentDetails =>  { # Shipment::Purolator::WSDLV2::Types::ArrayOfContentDetail
          ContentDetail =>  { # Shipment::Purolator::WSDLV2::Types::ContentDetail
            Description =>  $some_value, # string
            HarmonizedCode =>  $some_value, # string
            CountryOfManufacture =>  $some_value, # string
            ProductCode =>  $some_value, # string
            UnitValue =>  $some_value, # decimal
            Quantity =>  $some_value, # int
            NAFTADocumentIndicator =>  $some_value, # boolean
            FDADocumentIndicator =>  $some_value, # boolean
            FCCDocumentIndicator =>  $some_value, # boolean
            SenderIsProducerIndicator =>  $some_value, # boolean
            TextileIndicator =>  $some_value, # boolean
            TextileManufacturer =>  $some_value, # string
          },
        },
        BuyerInformation =>  { # Shipment::Purolator::WSDLV2::Types::BuyerInformation
          Address => {}, # Shipment::Purolator::WSDLV2::Types::Address
          TaxNumber =>  $some_value, # string
        },
        PreferredCustomsBroker =>  $some_value, # string
        DutyInformation =>  { # Shipment::Purolator::WSDLV2::Types::DutyInformation
          BillDutiesToParty => $some_value, # BillDutiesToParty
          BusinessRelationship => $some_value, # BusinessRelationship
          Currency => $some_value, # DutyCurrency
        },
        ImportExportType => $some_value, # ImportExportType
        CustomsInvoiceDocumentIndicator =>  $some_value, # boolean
      },
      ReturnShipmentInformation =>  { # Shipment::Purolator::WSDLV2::Types::ReturnShipmentInformation
        NumberOfReturnShipments =>  $some_value, # int
        ReturnShipment =>  { # Shipment::Purolator::WSDLV2::Types::ReturnShipment
          SenderInformation => {}, # Shipment::Purolator::WSDLV2::Types::SenderInformation
          ReceiverInformation => {}, # Shipment::Purolator::WSDLV2::Types::ReceiverInformation
          PackageInformation => {}, # Shipment::Purolator::WSDLV2::Types::PackageInformation
          PaymentInformation =>  { # Shipment::Purolator::WSDLV2::Types::PaymentInformation
            PaymentType => $some_value, # PaymentType
            RegisteredAccountNumber =>  $some_value, # string
            BillingAccountNumber =>  $some_value, # string
            CreditCardInformation =>  { # Shipment::Purolator::WSDLV2::Types::CreditCardInformation
              Type => $some_value, # CreditCardType
              Number =>  $some_value, # string
              Name =>  $some_value, # string
              ExpiryMonth =>  $some_value, # int
              ExpiryYear =>  $some_value, # int
              CVV =>  $some_value, # string
            },
          },
          PickupInformation =>  { # Shipment::Purolator::WSDLV2::Types::PickupInformation
            PickupType => $some_value, # PickupType
          },
          NotificationInformation =>  { # Shipment::Purolator::WSDLV2::Types::NotificationInformation
            ConfirmationEmailAddress =>  $some_value, # string
            AdvancedShippingNotificationEmailAddress1 =>  $some_value, # string
            AdvancedShippingNotificationEmailAddress2 =>  $some_value, # string
            AdvancedShippingNotificationMessage =>  $some_value, # string
          },
          TrackingReferenceInformation =>  { # Shipment::Purolator::WSDLV2::Types::TrackingReferenceInformation
            Reference1 =>  $some_value, # string
            Reference2 =>  $some_value, # string
            Reference3 =>  $some_value, # string
            Reference4 =>  $some_value, # string
          },
          OtherInformation =>  { # Shipment::Purolator::WSDLV2::Types::OtherInformation
            CostCentre =>  $some_value, # string
            SpecialInstructions =>  $some_value, # string
          },
        },
      },
      PaymentInformation => {}, # Shipment::Purolator::WSDLV2::Types::PaymentInformation
      PickupInformation => {}, # Shipment::Purolator::WSDLV2::Types::PickupInformation
      NotificationInformation => {}, # Shipment::Purolator::WSDLV2::Types::NotificationInformation
      TrackingReferenceInformation => {}, # Shipment::Purolator::WSDLV2::Types::TrackingReferenceInformation
      OtherInformation => {}, # Shipment::Purolator::WSDLV2::Types::OtherInformation
    },
  },,
 );

=head3 Consolidate

Consolidate @param request ConsolidateRequest @return ConsolidateResponse 

Returns a L<Shipment::Purolator::WSDLV2::Elements::ConsolidateResponse|Shipment::Purolator::WSDLV2::Elements::ConsolidateResponse> object.

 $response = $interface->Consolidate( { # Shipment::Purolator::WSDLV2::Types::ConsolidateRequestContainer
  },,
 );



=head1 AUTHOR

Generated by SOAP::WSDL on Tue Sep 14 15:03:40 2010

=cut
