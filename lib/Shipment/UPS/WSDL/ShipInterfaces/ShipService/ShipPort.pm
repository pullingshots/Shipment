package Shipment::UPS::WSDL::ShipInterfaces::ShipService::ShipPort;
use strict;
use warnings;
use Class::Std::Fast::Storable;
use Scalar::Util qw(blessed);
use base qw(SOAP::WSDL::Client::Base);


# only load if it hasn't been loaded before
require Shipment::UPS::WSDL::ShipTypemaps::ShipService
    if not Shipment::UPS::WSDL::ShipTypemaps::ShipService->can('get_class');


sub START {

    my $proxy_domain = $_[2]->{proxy_domain} || 'wwwcie.ups.com';

    $_[0]->set_proxy('https://' . $proxy_domain . '/webservices/Ship') if not $_[2]->{proxy};

    $_[0]->set_class_resolver('Shipment::UPS::WSDL::ShipTypemaps::ShipService')
        if not $_[2]->{class_resolver};

    $_[0]->set_prefix($_[2]->{use_prefix}) if exists $_[2]->{use_prefix};
}

sub ProcessShipment {
    my ($self, $body, $header) = @_;
    die "ProcessShipment must be called as object method (\$self is <$self>)" if not blessed($self);
    return $self->SUPER::call({
        operation => 'ProcessShipment',
        soap_action => 'http://onlinetools.ups.com/webservices/ShipBinding/v1.0',
        style => 'document',
        body => {
            

           'use'            => 'literal',
            namespace       => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle   => '',
            parts           =>  [qw( Shipment::UPS::WSDL::ShipElements::ShipmentRequest )],
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
            parts           =>  [qw( Shipment::UPS::WSDL::ShipElements::ShipmentResponse )],
            },
        }
    }, $body, $header);
}


sub ProcessShipConfirm {
    my ($self, $body, $header) = @_;
    die "ProcessShipConfirm must be called as object method (\$self is <$self>)" if not blessed($self);
    return $self->SUPER::call({
        operation => 'ProcessShipConfirm',
        soap_action => 'http://onlinetools.ups.com/webservices/ShipBinding/v1.0',
        style => 'document',
        body => {
            

           'use'            => 'literal',
            namespace       => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle   => '',
            parts           =>  [qw( Shipment::UPS::WSDL::ShipElements::ShipConfirmRequest )],
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
            parts           =>  [qw( Shipment::UPS::WSDL::ShipElements::ShipConfirmResponse )],
            },
        }
    }, $body, $header);
}


sub ProcessShipAccept {
    my ($self, $body, $header) = @_;
    die "ProcessShipAccept must be called as object method (\$self is <$self>)" if not blessed($self);
    return $self->SUPER::call({
        operation => 'ProcessShipAccept',
        soap_action => 'http://onlinetools.ups.com/webservices/ShipBinding/v1.0',
        style => 'document',
        body => {
            

           'use'            => 'literal',
            namespace       => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle   => '',
            parts           =>  [qw( Shipment::UPS::WSDL::ShipElements::ShipAcceptRequest )],
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
            parts           =>  [qw( Shipment::UPS::WSDL::ShipElements::ShipAcceptResponse )],
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

Shipment::UPS::WSDL::ShipInterfaces::ShipService::ShipPort - SOAP Interface for the ShipService Web Service

=head1 SYNOPSIS

 use Shipment::UPS::WSDL::ShipInterfaces::ShipService::ShipPort;
 my $interface = Shipment::UPS::WSDL::ShipInterfaces::ShipService::ShipPort->new();

 my $response;
 $response = $interface->ProcessShipment();
 $response = $interface->ProcessShipConfirm();
 $response = $interface->ProcessShipAccept();



=head1 DESCRIPTION

SOAP Interface for the ShipService web service
located at https://wwwcie.ups.com/webservices/Ship.

=head1 SERVICE ShipService



=head2 Port ShipPort



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



=head3 ProcessShipment



Returns a L<Shipment::UPS::WSDL::ShipElements::ShipmentResponse|Shipment::UPS::WSDL::ShipElements::ShipmentResponse> object.

 $response = $interface->ProcessShipment( {
    Request =>  { # Shipment::UPS::WSDL::ShipTypes::RequestType
      RequestOption =>  $some_value, # string
      TransactionReference =>  { # Shipment::UPS::WSDL::ShipTypes::TransactionReferenceType
        CustomerContext =>  $some_value, # string
        TransactionIdentifier =>  $some_value, # string
      },
    },
    Shipment =>  { # Shipment::UPS::WSDL::ShipTypes::ShipmentType
      Description =>  $some_value, # string
      ReturnService =>  { # Shipment::UPS::WSDL::ShipTypes::ReturnServiceType
        Code =>  $some_value, # string
        Description =>  $some_value, # string
      },
      DocumentsOnlyIndicator =>  $some_value, # string
      Shipper =>  { # Shipment::UPS::WSDL::ShipTypes::ShipperType
        ShipperNumber =>  $some_value, # string
        FaxNumber =>  $some_value, # string
        EMailAddress =>  $some_value, # string
        Address =>  { # Shipment::UPS::WSDL::ShipTypes::ShipAddressType
          AddressLine =>  $some_value, # string
          City =>  $some_value, # string
          StateProvinceCode =>  $some_value, # string
          PostalCode =>  $some_value, # string
          CountryCode =>  $some_value, # string
        },
      },
      ShipTo =>  { # Shipment::UPS::WSDL::ShipTypes::ShipToType
        FaxNumber =>  $some_value, # string
        EMailAddress =>  $some_value, # string
        Address =>  { # Shipment::UPS::WSDL::ShipTypes::ShipToAddressType
          ResidentialAddressIndicator =>  $some_value, # string
        },
        LocationID =>  $some_value, # string
      },
      ShipFrom =>  { # Shipment::UPS::WSDL::ShipTypes::ShipFromType
        FaxNumber =>  $some_value, # string
        Address => {}, # Shipment::UPS::WSDL::ShipTypes::ShipAddressType
      },
      PaymentInformation =>  { # Shipment::UPS::WSDL::ShipTypes::PaymentInfoType
        ShipmentCharge =>  { # Shipment::UPS::WSDL::ShipTypes::ShipmentChargeType
          Type =>  $some_value, # string
          BillShipper =>  { # Shipment::UPS::WSDL::ShipTypes::BillShipperType
            AccountNumber =>  $some_value, # string
            CreditCard =>  { # Shipment::UPS::WSDL::ShipTypes::CreditCardType
              Type =>  $some_value, # string
              Number =>  $some_value, # string
              ExpirationDate =>  $some_value, # string
              SecurityCode =>  $some_value, # string
              Address =>  { # Shipment::UPS::WSDL::ShipTypes::CreditCardAddressType
                AddressLine =>  $some_value, # string
                City =>  $some_value, # string
                StateProvinceCode =>  $some_value, # string
                PostalCode =>  $some_value, # string
                CountryCode =>  $some_value, # string
              },
            },
          },
          BillReceiver =>  { # Shipment::UPS::WSDL::ShipTypes::BillReceiverType
            AccountNumber =>  $some_value, # string
            Address =>  { # Shipment::UPS::WSDL::ShipTypes::BillReceiverAddressType
              PostalCode =>  $some_value, # string
            },
          },
          BillThirdParty =>  { # Shipment::UPS::WSDL::ShipTypes::BillThirdPartyChargeType
            AccountNumber =>  $some_value, # string
            Address =>  { # Shipment::UPS::WSDL::ShipTypes::AccountAddressType
              PostalCode =>  $some_value, # string
              CountryCode =>  $some_value, # string
            },
          },
          ConsigneeBilledIndicator =>  $some_value, # string
        },
        SplitDutyVATIndicator =>  $some_value, # string
      },
      FRSPaymentInformation =>  { # Shipment::UPS::WSDL::ShipTypes::FRSPaymentInfoType
        Type =>  { # Shipment::UPS::WSDL::ShipTypes::PaymentType
          Code =>  $some_value, # string
          Description =>  $some_value, # string
        },
        AccountNumber =>  $some_value, # string
        Address => {}, # Shipment::UPS::WSDL::ShipTypes::AccountAddressType
      },
      GoodsNotInFreeCirculationIndicator =>  $some_value, # string
      ShipmentRatingOptions =>  { # Shipment::UPS::WSDL::ShipTypes::RateInfoType
        NegotiatedRatesIndicator =>  $some_value, # string
        FRSShipmentIndicator =>  $some_value, # string
      },
      MovementReferenceNumber =>  $some_value, # string
      ReferenceNumber =>  { # Shipment::UPS::WSDL::ShipTypes::ReferenceNumberType
        BarCodeIndicator =>  $some_value, # string
        Code =>  $some_value, # string
        Value =>  $some_value, # string
      },
      Service =>  { # Shipment::UPS::WSDL::ShipTypes::ServiceType
        Code =>  $some_value, # string
        Description =>  $some_value, # string
      },
      InvoiceLineTotal =>  { # Shipment::UPS::WSDL::ShipTypes::CurrencyMonetaryType
        CurrencyCode =>  $some_value, # string
        MonetaryValue =>  $some_value, # string
      },
      ShipmentServiceOptions =>  {
      },
      Package =>  { # Shipment::UPS::WSDL::ShipTypes::PackageType
        Description =>  $some_value, # string
        Packaging =>  { # Shipment::UPS::WSDL::ShipTypes::PackagingType
          Code =>  $some_value, # string
          Description =>  $some_value, # string
        },
        Dimensions =>  { # Shipment::UPS::WSDL::ShipTypes::DimensionsType
          UnitOfMeasurement =>  { # Shipment::UPS::WSDL::ShipTypes::ShipUnitOfMeasurementType
            Code =>  $some_value, # string
            Description =>  $some_value, # string
          },
          Length =>  $some_value, # string
          Width =>  $some_value, # string
          Height =>  $some_value, # string
        },
        PackageWeight =>  { # Shipment::UPS::WSDL::ShipTypes::PackageWeightType
          UnitOfMeasurement => {}, # Shipment::UPS::WSDL::ShipTypes::ShipUnitOfMeasurementType
          Weight =>  $some_value, # string
        },
        LargePackageIndicator =>  $some_value, # string
        ReferenceNumber => {}, # Shipment::UPS::WSDL::ShipTypes::ReferenceNumberType
        AdditionalHandlingIndicator =>  $some_value, # string
        PackageServiceOptions =>  { # Shipment::UPS::WSDL::ShipTypes::PackageServiceOptionsType
          DeliveryConfirmation =>  { # Shipment::UPS::WSDL::ShipTypes::DeliveryConfirmationType
            DCISType =>  $some_value, # string
            DCISNumber =>  $some_value, # string
          },
          DeclaredValue =>  { # Shipment::UPS::WSDL::ShipTypes::PackageDeclaredValueType
            Type =>  { # Shipment::UPS::WSDL::ShipTypes::DeclaredValueType
              Code =>  $some_value, # string
              Description =>  $some_value, # string
            },
            CurrencyCode =>  $some_value, # string
            MonetaryValue =>  $some_value, # string
          },
          COD =>  { # Shipment::UPS::WSDL::ShipTypes::PSOCODType
            CODFundsCode =>  $some_value, # string
            CODAmount => {}, # Shipment::UPS::WSDL::ShipTypes::CurrencyMonetaryType
          },
          VerbalConfirmation =>  { # Shipment::UPS::WSDL::ShipTypes::VerbalConfirmationType
            ContactInfo =>  { # Shipment::UPS::WSDL::ShipTypes::ContactInfoType
              Name =>  $some_value, # string
              Phone =>  { # Shipment::UPS::WSDL::ShipTypes::ShipPhoneType
                Number =>  $some_value, # string
                Extension =>  $some_value, # string
              },
            },
          },
          ShipperReleaseIndicator =>  $some_value, # string
          Notification =>  { # Shipment::UPS::WSDL::ShipTypes::PSONotificationType
            NotificationCode =>  $some_value, # string
            EMail =>  { # Shipment::UPS::WSDL::ShipTypes::EmailDetailsType
              EMailAddress =>  $some_value, # string
              UndeliverableEMailAddress =>  $some_value, # string
              FromEMailAddress =>  $some_value, # string
              FromName =>  $some_value, # string
              Memo =>  $some_value, # string
              Subject =>  $some_value, # string
              SubjectCode =>  $some_value, # string
            },
          },
          ReturnsFlexibleAccessIndicator =>  $some_value, # string
        },
        Commodity =>  { # Shipment::UPS::WSDL::ShipTypes::CommodityType
          FreightClass =>  $some_value, # string
          NMFC =>  { # Shipment::UPS::WSDL::ShipTypes::NMFCType
            PrimeCode =>  $some_value, # string
            SubCode =>  $some_value, # string
          },
        },
      },
    },
    LabelSpecification =>  { # Shipment::UPS::WSDL::ShipTypes::LabelSpecificationType
      LabelImageFormat =>  { # Shipment::UPS::WSDL::ShipTypes::LabelImageFormatType
        Code =>  $some_value, # string
        Description =>  $some_value, # string
      },
      HTTPUserAgent =>  $some_value, # string
      LabelStockSize =>  { # Shipment::UPS::WSDL::ShipTypes::LabelStockSizeType
        Height =>  $some_value, # string
        Width =>  $some_value, # string
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

=head3 ProcessShipConfirm



Returns a L<Shipment::UPS::WSDL::ShipElements::ShipConfirmResponse|Shipment::UPS::WSDL::ShipElements::ShipConfirmResponse> object.

 $response = $interface->ProcessShipConfirm( {
    Request =>  { # Shipment::UPS::WSDL::ShipTypes::RequestType
      RequestOption =>  $some_value, # string
      TransactionReference =>  { # Shipment::UPS::WSDL::ShipTypes::TransactionReferenceType
        CustomerContext =>  $some_value, # string
        TransactionIdentifier =>  $some_value, # string
      },
    },
    Shipment =>  { # Shipment::UPS::WSDL::ShipTypes::ShipmentType
      Description =>  $some_value, # string
      ReturnService =>  { # Shipment::UPS::WSDL::ShipTypes::ReturnServiceType
        Code =>  $some_value, # string
        Description =>  $some_value, # string
      },
      DocumentsOnlyIndicator =>  $some_value, # string
      Shipper =>  { # Shipment::UPS::WSDL::ShipTypes::ShipperType
        ShipperNumber =>  $some_value, # string
        FaxNumber =>  $some_value, # string
        EMailAddress =>  $some_value, # string
        Address =>  { # Shipment::UPS::WSDL::ShipTypes::ShipAddressType
          AddressLine =>  $some_value, # string
          City =>  $some_value, # string
          StateProvinceCode =>  $some_value, # string
          PostalCode =>  $some_value, # string
          CountryCode =>  $some_value, # string
        },
      },
      ShipTo =>  { # Shipment::UPS::WSDL::ShipTypes::ShipToType
        FaxNumber =>  $some_value, # string
        EMailAddress =>  $some_value, # string
        Address =>  { # Shipment::UPS::WSDL::ShipTypes::ShipToAddressType
          ResidentialAddressIndicator =>  $some_value, # string
        },
        LocationID =>  $some_value, # string
      },
      ShipFrom =>  { # Shipment::UPS::WSDL::ShipTypes::ShipFromType
        FaxNumber =>  $some_value, # string
        Address => {}, # Shipment::UPS::WSDL::ShipTypes::ShipAddressType
      },
      PaymentInformation =>  { # Shipment::UPS::WSDL::ShipTypes::PaymentInfoType
        ShipmentCharge =>  { # Shipment::UPS::WSDL::ShipTypes::ShipmentChargeType
          Type =>  $some_value, # string
          BillShipper =>  { # Shipment::UPS::WSDL::ShipTypes::BillShipperType
            AccountNumber =>  $some_value, # string
            CreditCard =>  { # Shipment::UPS::WSDL::ShipTypes::CreditCardType
              Type =>  $some_value, # string
              Number =>  $some_value, # string
              ExpirationDate =>  $some_value, # string
              SecurityCode =>  $some_value, # string
              Address =>  { # Shipment::UPS::WSDL::ShipTypes::CreditCardAddressType
                AddressLine =>  $some_value, # string
                City =>  $some_value, # string
                StateProvinceCode =>  $some_value, # string
                PostalCode =>  $some_value, # string
                CountryCode =>  $some_value, # string
              },
            },
          },
          BillReceiver =>  { # Shipment::UPS::WSDL::ShipTypes::BillReceiverType
            AccountNumber =>  $some_value, # string
            Address =>  { # Shipment::UPS::WSDL::ShipTypes::BillReceiverAddressType
              PostalCode =>  $some_value, # string
            },
          },
          BillThirdParty =>  { # Shipment::UPS::WSDL::ShipTypes::BillThirdPartyChargeType
            AccountNumber =>  $some_value, # string
            Address =>  { # Shipment::UPS::WSDL::ShipTypes::AccountAddressType
              PostalCode =>  $some_value, # string
              CountryCode =>  $some_value, # string
            },
          },
          ConsigneeBilledIndicator =>  $some_value, # string
        },
        SplitDutyVATIndicator =>  $some_value, # string
      },
      FRSPaymentInformation =>  { # Shipment::UPS::WSDL::ShipTypes::FRSPaymentInfoType
        Type =>  { # Shipment::UPS::WSDL::ShipTypes::PaymentType
          Code =>  $some_value, # string
          Description =>  $some_value, # string
        },
        AccountNumber =>  $some_value, # string
        Address => {}, # Shipment::UPS::WSDL::ShipTypes::AccountAddressType
      },
      GoodsNotInFreeCirculationIndicator =>  $some_value, # string
      ShipmentRatingOptions =>  { # Shipment::UPS::WSDL::ShipTypes::RateInfoType
        NegotiatedRatesIndicator =>  $some_value, # string
        FRSShipmentIndicator =>  $some_value, # string
      },
      MovementReferenceNumber =>  $some_value, # string
      ReferenceNumber =>  { # Shipment::UPS::WSDL::ShipTypes::ReferenceNumberType
        BarCodeIndicator =>  $some_value, # string
        Code =>  $some_value, # string
        Value =>  $some_value, # string
      },
      Service =>  { # Shipment::UPS::WSDL::ShipTypes::ServiceType
        Code =>  $some_value, # string
        Description =>  $some_value, # string
      },
      InvoiceLineTotal =>  { # Shipment::UPS::WSDL::ShipTypes::CurrencyMonetaryType
        CurrencyCode =>  $some_value, # string
        MonetaryValue =>  $some_value, # string
      },
      ShipmentServiceOptions =>  {
      },
      Package =>  { # Shipment::UPS::WSDL::ShipTypes::PackageType
        Description =>  $some_value, # string
        Packaging =>  { # Shipment::UPS::WSDL::ShipTypes::PackagingType
          Code =>  $some_value, # string
          Description =>  $some_value, # string
        },
        Dimensions =>  { # Shipment::UPS::WSDL::ShipTypes::DimensionsType
          UnitOfMeasurement =>  { # Shipment::UPS::WSDL::ShipTypes::ShipUnitOfMeasurementType
            Code =>  $some_value, # string
            Description =>  $some_value, # string
          },
          Length =>  $some_value, # string
          Width =>  $some_value, # string
          Height =>  $some_value, # string
        },
        PackageWeight =>  { # Shipment::UPS::WSDL::ShipTypes::PackageWeightType
          UnitOfMeasurement => {}, # Shipment::UPS::WSDL::ShipTypes::ShipUnitOfMeasurementType
          Weight =>  $some_value, # string
        },
        LargePackageIndicator =>  $some_value, # string
        ReferenceNumber => {}, # Shipment::UPS::WSDL::ShipTypes::ReferenceNumberType
        AdditionalHandlingIndicator =>  $some_value, # string
        PackageServiceOptions =>  { # Shipment::UPS::WSDL::ShipTypes::PackageServiceOptionsType
          DeliveryConfirmation =>  { # Shipment::UPS::WSDL::ShipTypes::DeliveryConfirmationType
            DCISType =>  $some_value, # string
            DCISNumber =>  $some_value, # string
          },
          DeclaredValue =>  { # Shipment::UPS::WSDL::ShipTypes::PackageDeclaredValueType
            Type =>  { # Shipment::UPS::WSDL::ShipTypes::DeclaredValueType
              Code =>  $some_value, # string
              Description =>  $some_value, # string
            },
            CurrencyCode =>  $some_value, # string
            MonetaryValue =>  $some_value, # string
          },
          COD =>  { # Shipment::UPS::WSDL::ShipTypes::PSOCODType
            CODFundsCode =>  $some_value, # string
            CODAmount => {}, # Shipment::UPS::WSDL::ShipTypes::CurrencyMonetaryType
          },
          VerbalConfirmation =>  { # Shipment::UPS::WSDL::ShipTypes::VerbalConfirmationType
            ContactInfo =>  { # Shipment::UPS::WSDL::ShipTypes::ContactInfoType
              Name =>  $some_value, # string
              Phone =>  { # Shipment::UPS::WSDL::ShipTypes::ShipPhoneType
                Number =>  $some_value, # string
                Extension =>  $some_value, # string
              },
            },
          },
          ShipperReleaseIndicator =>  $some_value, # string
          Notification =>  { # Shipment::UPS::WSDL::ShipTypes::PSONotificationType
            NotificationCode =>  $some_value, # string
            EMail =>  { # Shipment::UPS::WSDL::ShipTypes::EmailDetailsType
              EMailAddress =>  $some_value, # string
              UndeliverableEMailAddress =>  $some_value, # string
              FromEMailAddress =>  $some_value, # string
              FromName =>  $some_value, # string
              Memo =>  $some_value, # string
              Subject =>  $some_value, # string
              SubjectCode =>  $some_value, # string
            },
          },
          ReturnsFlexibleAccessIndicator =>  $some_value, # string
        },
        Commodity =>  { # Shipment::UPS::WSDL::ShipTypes::CommodityType
          FreightClass =>  $some_value, # string
          NMFC =>  { # Shipment::UPS::WSDL::ShipTypes::NMFCType
            PrimeCode =>  $some_value, # string
            SubCode =>  $some_value, # string
          },
        },
      },
    },
    LabelSpecification =>  { # Shipment::UPS::WSDL::ShipTypes::LabelSpecificationType
      LabelImageFormat =>  { # Shipment::UPS::WSDL::ShipTypes::LabelImageFormatType
        Code =>  $some_value, # string
        Description =>  $some_value, # string
      },
      HTTPUserAgent =>  $some_value, # string
      LabelStockSize =>  { # Shipment::UPS::WSDL::ShipTypes::LabelStockSizeType
        Height =>  $some_value, # string
        Width =>  $some_value, # string
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

=head3 ProcessShipAccept



Returns a L<Shipment::UPS::WSDL::ShipElements::ShipAcceptResponse|Shipment::UPS::WSDL::ShipElements::ShipAcceptResponse> object.

 $response = $interface->ProcessShipAccept( {
    Request =>  { # Shipment::UPS::WSDL::ShipTypes::RequestType
      RequestOption =>  $some_value, # string
      TransactionReference =>  { # Shipment::UPS::WSDL::ShipTypes::TransactionReferenceType
        CustomerContext =>  $some_value, # string
        TransactionIdentifier =>  $some_value, # string
      },
    },
    ShipmentDigest =>  $some_value, # string
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

Generated by SOAP::WSDL on Thu Oct  7 13:09:01 2010

=cut
