package Shipment::UPS::WSDL::RateInterfaces::RateService::RatePort;
use strict;
use warnings;
use Class::Std::Fast::Storable;
use Scalar::Util qw(blessed);
use base qw(SOAP::WSDL::Client::Base);


# only load if it hasn't been loaded before
require Shipment::UPS::WSDL::RateTypemaps::RateService
    if not Shipment::UPS::WSDL::RateTypemaps::RateService->can('get_class');


sub START {
    
    my $proxy_domain = $_[2]->{proxy_domain} || 'wwwcie.ups.com';

    $_[0]->set_proxy('https://' . $proxy_domain . '/webservices/Rate') if not $_[2]->{proxy};

    $_[0]->set_class_resolver('Shipment::UPS::WSDL::RateTypemaps::RateService')
        if not $_[2]->{class_resolver};

    $_[0]->set_prefix($_[2]->{use_prefix}) if exists $_[2]->{use_prefix};
}

sub ProcessRate {
    my ($self, $body, $header) = @_;
    die "ProcessRate must be called as object method (\$self is <$self>)" if not blessed($self);
    return $self->SUPER::call({
        operation => 'ProcessRate',
        soap_action => 'http://onlinetools.ups.com/webservices/RateBinding/v1.1',
        style => 'document',
        body => {
            

           'use'            => 'literal',
            namespace       => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle   => '',
            parts           =>  [qw( Shipment::UPS::WSDL::RateElements::RateRequest )],
        },
        header => {
            
           'use' => 'literal',
            namespace => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle => '',
            parts => [qw( Shipment::UPS::WSDL::RateElements::UPSSecurity )],

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
            parts           =>  [qw( Shipment::UPS::WSDL::RateElements::RateResponse )],
            },
        }
    }, $body, $header);
}





sub _get_name_resolver {

    my $prefix_1 = {
              'attribute' => 'Shipment::UPS::WSDL::RateAttributes',
              'typemap' => 'Shipment::UPS::WSDL::RateTypemaps',
              'interface' => 'Shipment::UPS::WSDL::RateInterfaces',
              'type' => 'Shipment::UPS::WSDL::RateTypes',
              'server' => 'Shipment::UPS::WSDL::RateServer',
              'element' => 'Shipment::UPS::WSDL::RateElements'
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

Shipment::UPS::WSDL::RateInterfaces::RateService::RatePort - SOAP Interface for the RateService Web Service

=head1 SYNOPSIS

 use Shipment::UPS::WSDL::RateInterfaces::RateService::RatePort;
 my $interface = Shipment::UPS::WSDL::RateInterfaces::RateService::RatePort->new();

 my $response;
 $response = $interface->ProcessRate();



=head1 DESCRIPTION

SOAP Interface for the RateService web service
located at https://wwwcie.ups.com/webservices/Rate.

=head1 SERVICE RateService



=head2 Port RatePort



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



=head3 ProcessRate



Returns a L<Shipment::UPS::WSDL::RateElements::RateResponse|Shipment::UPS::WSDL::RateElements::RateResponse> object.

 $response = $interface->ProcessRate( {
    Request =>  { # Shipment::UPS::WSDL::RateTypes::RequestType
      RequestOption =>  $some_value, # string
      TransactionReference =>  { # Shipment::UPS::WSDL::RateTypes::TransactionReferenceType
        CustomerContext =>  $some_value, # string
        TransactionIdentifier =>  $some_value, # string
      },
    },
    PickupType =>  { # Shipment::UPS::WSDL::RateTypes::CodeDescriptionType
      Code =>  $some_value, # string
      Description =>  $some_value, # string
    },
    CustomerClassification =>  { # Shipment::UPS::WSDL::RateTypes::CodeDescriptionType
      Code =>  $some_value, # string
      Description =>  $some_value, # string
    },
    Shipment =>  { # Shipment::UPS::WSDL::RateTypes::ShipmentType
      Shipper =>  { # Shipment::UPS::WSDL::RateTypes::ShipperType
        Name =>  $some_value, # string
        ShipperNumber =>  $some_value, # string
        Address =>  { # Shipment::UPS::WSDL::RateTypes::AddressType
          AddressLine =>  $some_value, # string
          City =>  $some_value, # string
          StateProvinceCode =>  $some_value, # string
          PostalCode =>  $some_value, # string
          CountryCode =>  $some_value, # string
        },
      },
      ShipTo =>  { # Shipment::UPS::WSDL::RateTypes::ShipToType
        Name =>  $some_value, # string
        Address =>  { # Shipment::UPS::WSDL::RateTypes::ShipToAddressType
          ResidentialAddressIndicator =>  $some_value, # string
        },
      },
      ShipFrom =>  { # Shipment::UPS::WSDL::RateTypes::ShipFromType
        Name =>  $some_value, # string
        Address => {}, # Shipment::UPS::WSDL::RateTypes::AddressType
      },
      FRSPaymentInformation =>  { # Shipment::UPS::WSDL::RateTypes::FRSPaymentInfoType
        Type =>  { # Shipment::UPS::WSDL::RateTypes::CodeDescriptionType
          Code =>  $some_value, # string
          Description =>  $some_value, # string
        },
        AccountNumber =>  $some_value, # string
        Address =>  { # Shipment::UPS::WSDL::RateTypes::PayerAddressType
          PostalCode =>  $some_value, # string
          CountryCode =>  $some_value, # string
        },
      },
      Service => {}, # Shipment::UPS::WSDL::RateTypes::CodeDescriptionType
      DocumentsOnlyIndicator =>  $some_value, # string
      Package =>  { # Shipment::UPS::WSDL::RateTypes::PackageType
        PackagingType => {}, # Shipment::UPS::WSDL::RateTypes::CodeDescriptionType
        Dimensions =>  { # Shipment::UPS::WSDL::RateTypes::DimensionsType
          UnitOfMeasurement => {}, # Shipment::UPS::WSDL::RateTypes::CodeDescriptionType
          Length =>  $some_value, # string
          Width =>  $some_value, # string
          Height =>  $some_value, # string
        },
        PackageWeight =>  { # Shipment::UPS::WSDL::RateTypes::PackageWeightType
          UnitOfMeasurement => {}, # Shipment::UPS::WSDL::RateTypes::CodeDescriptionType
          Weight =>  $some_value, # string
        },
        Commodity =>  { # Shipment::UPS::WSDL::RateTypes::CommodityType
          FreightClass =>  $some_value, # string
          NMFC =>  { # Shipment::UPS::WSDL::RateTypes::NMFCCommodityType
            PrimeCode =>  $some_value, # string
            SubCode =>  $some_value, # string
          },
        },
        LargePackageIndicator =>  $some_value, # string
        PackageServiceOptions =>  { # Shipment::UPS::WSDL::RateTypes::PackageServiceOptionsType
          DeliveryConfirmation =>  { # Shipment::UPS::WSDL::RateTypes::DeliveryConfirmationType
            DCISType =>  $some_value, # string
          },
          COD =>  { # Shipment::UPS::WSDL::RateTypes::CODType
            CODFundsCode =>  $some_value, # string
            CODAmount =>  { # Shipment::UPS::WSDL::RateTypes::CODAmountType
              CurrencyCode =>  $some_value, # string
              MonetaryValue =>  $some_value, # string
            },
          },
          DeclaredValue =>  { # Shipment::UPS::WSDL::RateTypes::InsuredValueType
            CurrencyCode =>  $some_value, # string
            MonetaryValue =>  $some_value, # string
          },
          VerbalConfirmationIndicator =>  $some_value, # string
        },
        AdditionalHandlingIndicator =>  $some_value, # string
      },
      ShipmentServiceOptions =>  { # Shipment::UPS::WSDL::RateTypes::ShipmentServiceOptionsType
        SaturdayPickupIndicator =>  $some_value, # string
        SaturdayDeliveryIndicator =>  $some_value, # string
        OnCallPickup =>  { # Shipment::UPS::WSDL::RateTypes::OnCallPickupType
          Schedule =>  { # Shipment::UPS::WSDL::RateTypes::ScheduleType
            PickupDay =>  $some_value, # string
            Method =>  $some_value, # string
          },
        },
        COD => {}, # Shipment::UPS::WSDL::RateTypes::CODType
        DeliveryConfirmation => {}, # Shipment::UPS::WSDL::RateTypes::DeliveryConfirmationType
        ReturnOfDocumentIndicator =>  $some_value, # string
        UPScarbonneutralIndicator =>  $some_value, # string
      },
      ShipmentRatingOptions =>  { # Shipment::UPS::WSDL::RateTypes::ShipmentRatingOptionsType
        NegotiatedRatesIndicator =>  $some_value, # string
        FRSShipmentIndicator =>  $some_value, # string
      },
      InvoiceLineTotal =>  { # Shipment::UPS::WSDL::RateTypes::InvoiceLineTotalType
        CurrencyCode =>  $some_value, # string
        MonetaryValue =>  $some_value, # string
      },
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

Generated by SOAP::WSDL on Wed Oct  6 15:58:16 2010

=cut
