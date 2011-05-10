package Shipment::FedEx::WSDL::CloseInterfaces::CloseService::CloseServicePort;
use strict;
use warnings;
use Class::Std::Fast::Storable;
use Scalar::Util qw(blessed);
use base qw(SOAP::WSDL::Client::Base);


# only load if it hasn't been loaded before
require Shipment::FedEx::WSDL::CloseTypemaps::CloseService
    if not Shipment::FedEx::WSDL::CloseTypemaps::CloseService->can('get_class');


sub START {

    my $proxy_domain = $_[2]->{proxy_domain} || 'wsbeta.fedex.com:443';

    $_[0]->set_proxy('https://' . $proxy_domain . '/web-services/close') if not $_[2]->{proxy};

    $_[0]->set_class_resolver('Shipment::FedEx::WSDL::CloseTypemaps::CloseService')
        if not $_[2]->{class_resolver};

    $_[0]->set_prefix($_[2]->{use_prefix}) if exists $_[2]->{use_prefix};
}

sub smartPostClose {
    my ($self, $body, $header) = @_;
    die "smartPostClose must be called as object method (\$self is <$self>)" if not blessed($self);
    return $self->SUPER::call({
        operation => 'smartPostClose',
        soap_action => 'smartPostClose',
        style => 'document',
        body => {
            

           'use'            => 'literal',
            namespace       => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle   => '',
            parts           =>  [qw( Shipment::FedEx::WSDL::CloseElements::SmartPostCloseRequest )],
        },
        header => {
            
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
            parts           =>  [qw( Shipment::FedEx::WSDL::CloseElements::SmartPostCloseReply )],
            },
        }
    }, $body, $header);
}


sub groundClose {
    my ($self, $body, $header) = @_;
    die "groundClose must be called as object method (\$self is <$self>)" if not blessed($self);
    return $self->SUPER::call({
        operation => 'groundClose',
        soap_action => 'groundClose',
        style => 'document',
        body => {
            

           'use'            => 'literal',
            namespace       => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle   => '',
            parts           =>  [qw( Shipment::FedEx::WSDL::CloseElements::GroundCloseRequest )],
        },
        header => {
            
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
            parts           =>  [qw( Shipment::FedEx::WSDL::CloseElements::GroundCloseReply )],
            },
        }
    }, $body, $header);
}


sub groundCloseReportsReprint {
    my ($self, $body, $header) = @_;
    die "groundCloseReportsReprint must be called as object method (\$self is <$self>)" if not blessed($self);
    return $self->SUPER::call({
        operation => 'groundCloseReportsReprint',
        soap_action => 'groundCloseReportsReprint',
        style => 'document',
        body => {
            

           'use'            => 'literal',
            namespace       => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle   => '',
            parts           =>  [qw( Shipment::FedEx::WSDL::CloseElements::GroundCloseReportsReprintRequest )],
        },
        header => {
            
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
            parts           =>  [qw( Shipment::FedEx::WSDL::CloseElements::GroundCloseReportsReprintReply )],
            },
        }
    }, $body, $header);
}


sub groundCloseWithDocuments {
    my ($self, $body, $header) = @_;
    die "groundCloseWithDocuments must be called as object method (\$self is <$self>)" if not blessed($self);
    return $self->SUPER::call({
        operation => 'groundCloseWithDocuments',
        soap_action => 'groundCloseWithDocuments',
        style => 'document',
        body => {
            

           'use'            => 'literal',
            namespace       => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle   => '',
            parts           =>  [qw( Shipment::FedEx::WSDL::CloseElements::GroundCloseWithDocumentsRequest )],
        },
        header => {
            
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
            parts           =>  [qw( Shipment::FedEx::WSDL::CloseElements::GroundCloseDocumentsReply )],
            },
        }
    }, $body, $header);
}


sub reprintGroundCloseDocuments {
    my ($self, $body, $header) = @_;
    die "reprintGroundCloseDocuments must be called as object method (\$self is <$self>)" if not blessed($self);
    return $self->SUPER::call({
        operation => 'reprintGroundCloseDocuments',
        soap_action => 'reprintGroundCloseDocuments',
        style => 'document',
        body => {
            

           'use'            => 'literal',
            namespace       => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle   => '',
            parts           =>  [qw( Shipment::FedEx::WSDL::CloseElements::ReprintGroundCloseDocumentsRequest )],
        },
        header => {
            
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
            parts           =>  [qw( Shipment::FedEx::WSDL::CloseElements::GroundCloseDocumentsReply )],
            },
        }
    }, $body, $header);
}





sub _get_name_resolver {

    my $prefix_1 = {
              'attribute' => 'Shipment::FedEx::WSDL::CloseAttributes',
              'typemap' => 'Shipment::FedEx::WSDL::CloseTypemaps',
              'interface' => 'Shipment::FedEx::WSDL::CloseInterfaces',
              'type' => 'Shipment::FedEx::WSDL::CloseTypes',
              'server' => 'Shipment::FedEx::WSDL::CloseServer',
              'element' => 'Shipment::FedEx::WSDL::CloseElements'
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

Shipment::FedEx::WSDL::CloseInterfaces::CloseService::CloseServicePort - SOAP Interface for the CloseService Web Service

=head1 SYNOPSIS

 use Shipment::FedEx::WSDL::CloseInterfaces::CloseService::CloseServicePort;
 my $interface = Shipment::FedEx::WSDL::CloseInterfaces::CloseService::CloseServicePort->new();

 my $response;
 $response = $interface->smartPostClose();
 $response = $interface->groundClose();
 $response = $interface->groundCloseReportsReprint();
 $response = $interface->groundCloseWithDocuments();
 $response = $interface->reprintGroundCloseDocuments();



=head1 DESCRIPTION

SOAP Interface for the CloseService web service
located at https://gatewaybeta.fedex.com:443/web-services/close.

=head1 SERVICE CloseService



=head2 Port CloseServicePort



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



=head3 smartPostClose



Returns a L<Shipment::FedEx::WSDL::CloseElements::SmartPostCloseReply|Shipment::FedEx::WSDL::CloseElements::SmartPostCloseReply> object.

 $response = $interface->smartPostClose( { # Shipment::FedEx::WSDL::CloseTypes::SmartPostCloseRequest
    WebAuthenticationDetail =>  { # Shipment::FedEx::WSDL::CloseTypes::WebAuthenticationDetail
      UserCredential =>  { # Shipment::FedEx::WSDL::CloseTypes::WebAuthenticationCredential
        Key =>  $some_value, # string
        Password =>  $some_value, # string
      },
    },
    ClientDetail =>  { # Shipment::FedEx::WSDL::CloseTypes::ClientDetail
      AccountNumber =>  $some_value, # string
      MeterNumber =>  $some_value, # string
      IntegratorId =>  $some_value, # string
      Localization =>  { # Shipment::FedEx::WSDL::CloseTypes::Localization
        LanguageCode =>  $some_value, # string
        LocaleCode =>  $some_value, # string
      },
    },
    TransactionDetail =>  { # Shipment::FedEx::WSDL::CloseTypes::TransactionDetail
      CustomerTransactionId =>  $some_value, # string
      Localization => {}, # Shipment::FedEx::WSDL::CloseTypes::Localization
    },
    Version =>  { # Shipment::FedEx::WSDL::CloseTypes::VersionId
      ServiceId =>  $some_value, # string
      Major =>  $some_value, # int
      Intermediate =>  $some_value, # int
      Minor =>  $some_value, # int
    },
    HubId =>  $some_value, # string
    CustomerManifestId =>  $some_value, # string
    DestinationCountryCode =>  $some_value, # string
    PickUpCarrier => $some_value, # CarrierCodeType
  },,
 );

=head3 groundClose



Returns a L<Shipment::FedEx::WSDL::CloseElements::GroundCloseReply|Shipment::FedEx::WSDL::CloseElements::GroundCloseReply> object.

 $response = $interface->groundClose( { # Shipment::FedEx::WSDL::CloseTypes::GroundCloseRequest
    WebAuthenticationDetail =>  { # Shipment::FedEx::WSDL::CloseTypes::WebAuthenticationDetail
      UserCredential =>  { # Shipment::FedEx::WSDL::CloseTypes::WebAuthenticationCredential
        Key =>  $some_value, # string
        Password =>  $some_value, # string
      },
    },
    ClientDetail =>  { # Shipment::FedEx::WSDL::CloseTypes::ClientDetail
      AccountNumber =>  $some_value, # string
      MeterNumber =>  $some_value, # string
      IntegratorId =>  $some_value, # string
      Localization =>  { # Shipment::FedEx::WSDL::CloseTypes::Localization
        LanguageCode =>  $some_value, # string
        LocaleCode =>  $some_value, # string
      },
    },
    TransactionDetail =>  { # Shipment::FedEx::WSDL::CloseTypes::TransactionDetail
      CustomerTransactionId =>  $some_value, # string
      Localization => {}, # Shipment::FedEx::WSDL::CloseTypes::Localization
    },
    Version =>  { # Shipment::FedEx::WSDL::CloseTypes::VersionId
      ServiceId =>  $some_value, # string
      Major =>  $some_value, # int
      Intermediate =>  $some_value, # int
      Minor =>  $some_value, # int
    },
    TimeUpToWhichShipmentsAreToBeClosed =>  $some_value, # dateTime
  },,
 );

=head3 groundCloseReportsReprint



Returns a L<Shipment::FedEx::WSDL::CloseElements::GroundCloseReportsReprintReply|Shipment::FedEx::WSDL::CloseElements::GroundCloseReportsReprintReply> object.

 $response = $interface->groundCloseReportsReprint( { # Shipment::FedEx::WSDL::CloseTypes::GroundCloseReportsReprintRequest
    WebAuthenticationDetail =>  { # Shipment::FedEx::WSDL::CloseTypes::WebAuthenticationDetail
      UserCredential =>  { # Shipment::FedEx::WSDL::CloseTypes::WebAuthenticationCredential
        Key =>  $some_value, # string
        Password =>  $some_value, # string
      },
    },
    ClientDetail =>  { # Shipment::FedEx::WSDL::CloseTypes::ClientDetail
      AccountNumber =>  $some_value, # string
      MeterNumber =>  $some_value, # string
      IntegratorId =>  $some_value, # string
      Localization =>  { # Shipment::FedEx::WSDL::CloseTypes::Localization
        LanguageCode =>  $some_value, # string
        LocaleCode =>  $some_value, # string
      },
    },
    TransactionDetail =>  { # Shipment::FedEx::WSDL::CloseTypes::TransactionDetail
      CustomerTransactionId =>  $some_value, # string
      Localization => {}, # Shipment::FedEx::WSDL::CloseTypes::Localization
    },
    Version =>  { # Shipment::FedEx::WSDL::CloseTypes::VersionId
      ServiceId =>  $some_value, # string
      Major =>  $some_value, # int
      Intermediate =>  $some_value, # int
      Minor =>  $some_value, # int
    },
    ReportDate =>  $some_value, # date
    TrackingNumber =>  $some_value, # string
    CloseReportType => $some_value, # CloseReportType
  },,
 );

=head3 groundCloseWithDocuments



Returns a L<Shipment::FedEx::WSDL::CloseElements::GroundCloseDocumentsReply|Shipment::FedEx::WSDL::CloseElements::GroundCloseDocumentsReply> object.

 $response = $interface->groundCloseWithDocuments( { # Shipment::FedEx::WSDL::CloseTypes::GroundCloseWithDocumentsRequest
    WebAuthenticationDetail =>  { # Shipment::FedEx::WSDL::CloseTypes::WebAuthenticationDetail
      UserCredential =>  { # Shipment::FedEx::WSDL::CloseTypes::WebAuthenticationCredential
        Key =>  $some_value, # string
        Password =>  $some_value, # string
      },
    },
    ClientDetail =>  { # Shipment::FedEx::WSDL::CloseTypes::ClientDetail
      AccountNumber =>  $some_value, # string
      MeterNumber =>  $some_value, # string
      IntegratorId =>  $some_value, # string
      Localization =>  { # Shipment::FedEx::WSDL::CloseTypes::Localization
        LanguageCode =>  $some_value, # string
        LocaleCode =>  $some_value, # string
      },
    },
    TransactionDetail =>  { # Shipment::FedEx::WSDL::CloseTypes::TransactionDetail
      CustomerTransactionId =>  $some_value, # string
      Localization => {}, # Shipment::FedEx::WSDL::CloseTypes::Localization
    },
    Version =>  { # Shipment::FedEx::WSDL::CloseTypes::VersionId
      ServiceId =>  $some_value, # string
      Major =>  $some_value, # int
      Intermediate =>  $some_value, # int
      Minor =>  $some_value, # int
    },
    CloseDate =>  $some_value, # date
    CloseDocumentSpecification =>  { # Shipment::FedEx::WSDL::CloseTypes::CloseDocumentSpecification
      CloseDocumentTypes => $some_value, # CloseDocumentType
      Op950Detail =>  { # Shipment::FedEx::WSDL::CloseTypes::Op950Detail
        Format =>  { # Shipment::FedEx::WSDL::CloseTypes::CloseDocumentFormat
          Dispositions =>  { # Shipment::FedEx::WSDL::CloseTypes::ShippingDocumentDispositionDetail
            DispositionType => $some_value, # ShippingDocumentDispositionType
            Grouping => $some_value, # ShippingDocumentGroupingType
            StorageDetail =>  { # Shipment::FedEx::WSDL::CloseTypes::ShippingDocumentStorageDetail
              FilePath =>  $some_value, # string
              FileNaming => $some_value, # ShippingDocumentNamingType
              FileSuffix =>  $some_value, # string
            },
            EMailDetail =>  { # Shipment::FedEx::WSDL::CloseTypes::ShippingDocumentEMailDetail
              EMailRecipients =>  { # Shipment::FedEx::WSDL::CloseTypes::ShippingDocumentEMailRecipient
                RecipientType => $some_value, # EMailNotificationRecipientType
                Address =>  $some_value, # string
              },
              Grouping => $some_value, # ShippingDocumentEMailGroupingType
            },
            PrintDetail =>  { # Shipment::FedEx::WSDL::CloseTypes::ShippingDocumentPrintDetail
              PrinterId =>  $some_value, # string
            },
          },
          TopOfPageOffset =>  { # Shipment::FedEx::WSDL::CloseTypes::LinearMeasure
            Value =>  $some_value, # decimal
            Units => $some_value, # LinearUnits
          },
          ImageType => $some_value, # ShippingDocumentImageType
          StockType => $some_value, # ShippingDocumentStockType
          ProvideInstructions =>  $some_value, # boolean
          Localization => {}, # Shipment::FedEx::WSDL::CloseTypes::Localization
        },
        CustomerImageUsages =>  { # Shipment::FedEx::WSDL::CloseTypes::CustomerImageUsage
          Type => $some_value, # CustomerImageUsageType
          Id => $some_value, # ImageId
          InternalId =>  $some_value, # string
          InternalImageType => $some_value, # InternalImageType
        },
        SignatureName =>  $some_value, # string
      },
    },
  },,
 );

=head3 reprintGroundCloseDocuments



Returns a L<Shipment::FedEx::WSDL::CloseElements::GroundCloseDocumentsReply|Shipment::FedEx::WSDL::CloseElements::GroundCloseDocumentsReply> object.

 $response = $interface->reprintGroundCloseDocuments( { # Shipment::FedEx::WSDL::CloseTypes::ReprintGroundCloseDocumentsRequest
    WebAuthenticationDetail =>  { # Shipment::FedEx::WSDL::CloseTypes::WebAuthenticationDetail
      UserCredential =>  { # Shipment::FedEx::WSDL::CloseTypes::WebAuthenticationCredential
        Key =>  $some_value, # string
        Password =>  $some_value, # string
      },
    },
    ClientDetail =>  { # Shipment::FedEx::WSDL::CloseTypes::ClientDetail
      AccountNumber =>  $some_value, # string
      MeterNumber =>  $some_value, # string
      IntegratorId =>  $some_value, # string
      Localization =>  { # Shipment::FedEx::WSDL::CloseTypes::Localization
        LanguageCode =>  $some_value, # string
        LocaleCode =>  $some_value, # string
      },
    },
    TransactionDetail =>  { # Shipment::FedEx::WSDL::CloseTypes::TransactionDetail
      CustomerTransactionId =>  $some_value, # string
      Localization => {}, # Shipment::FedEx::WSDL::CloseTypes::Localization
    },
    Version =>  { # Shipment::FedEx::WSDL::CloseTypes::VersionId
      ServiceId =>  $some_value, # string
      Major =>  $some_value, # int
      Intermediate =>  $some_value, # int
      Minor =>  $some_value, # int
    },
    ReprintOption => $some_value, # ReprintGroundCloseDocumentsOptionType
    CloseDate =>  $some_value, # date
    TrackingNumber =>  $some_value, # string
    CloseDocumentSpecification =>  { # Shipment::FedEx::WSDL::CloseTypes::CloseDocumentSpecification
      CloseDocumentTypes => $some_value, # CloseDocumentType
      Op950Detail =>  { # Shipment::FedEx::WSDL::CloseTypes::Op950Detail
        Format =>  { # Shipment::FedEx::WSDL::CloseTypes::CloseDocumentFormat
          Dispositions =>  { # Shipment::FedEx::WSDL::CloseTypes::ShippingDocumentDispositionDetail
            DispositionType => $some_value, # ShippingDocumentDispositionType
            Grouping => $some_value, # ShippingDocumentGroupingType
            StorageDetail =>  { # Shipment::FedEx::WSDL::CloseTypes::ShippingDocumentStorageDetail
              FilePath =>  $some_value, # string
              FileNaming => $some_value, # ShippingDocumentNamingType
              FileSuffix =>  $some_value, # string
            },
            EMailDetail =>  { # Shipment::FedEx::WSDL::CloseTypes::ShippingDocumentEMailDetail
              EMailRecipients =>  { # Shipment::FedEx::WSDL::CloseTypes::ShippingDocumentEMailRecipient
                RecipientType => $some_value, # EMailNotificationRecipientType
                Address =>  $some_value, # string
              },
              Grouping => $some_value, # ShippingDocumentEMailGroupingType
            },
            PrintDetail =>  { # Shipment::FedEx::WSDL::CloseTypes::ShippingDocumentPrintDetail
              PrinterId =>  $some_value, # string
            },
          },
          TopOfPageOffset =>  { # Shipment::FedEx::WSDL::CloseTypes::LinearMeasure
            Value =>  $some_value, # decimal
            Units => $some_value, # LinearUnits
          },
          ImageType => $some_value, # ShippingDocumentImageType
          StockType => $some_value, # ShippingDocumentStockType
          ProvideInstructions =>  $some_value, # boolean
          Localization => {}, # Shipment::FedEx::WSDL::CloseTypes::Localization
        },
        CustomerImageUsages =>  { # Shipment::FedEx::WSDL::CloseTypes::CustomerImageUsage
          Type => $some_value, # CustomerImageUsageType
          Id => $some_value, # ImageId
          InternalId =>  $some_value, # string
          InternalImageType => $some_value, # InternalImageType
        },
        SignatureName =>  $some_value, # string
      },
    },
  },,
 );



=head1 AUTHOR

Generated by SOAP::WSDL on Thu Oct 14 17:01:35 2010

=cut
