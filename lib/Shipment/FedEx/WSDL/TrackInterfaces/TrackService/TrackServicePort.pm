package Shipment::FedEx::WSDL::TrackInterfaces::TrackService::TrackServicePort;
use strict;
use warnings;
use Class::Std::Fast::Storable;
use Scalar::Util qw(blessed);
use base qw(SOAP::WSDL::Client::Base);

# only load if it hasn't been loaded before
require Shipment::FedEx::WSDL::TrackTypemaps::TrackService
    if not Shipment::FedEx::WSDL::TrackTypemaps::TrackService->can('get_class');

sub START {
    my $proxy_domain = $_[2]->{proxy_domain} || 'wsbeta.fedex.com:443';

    $_[0]->set_proxy('https://' . $proxy_domain . '/web-services/track') if not $_[2]->{proxy};

    $_[0]->set_class_resolver('Shipment::FedEx::WSDL::TrackTypemaps::TrackService')
        if not $_[2]->{class_resolver};

    $_[0]->set_prefix($_[2]->{use_prefix}) if exists $_[2]->{use_prefix};
}

sub retrieveSignatureProofOfDeliveryLetter {
    my ($self, $body, $header) = @_;
    die "retrieveSignatureProofOfDeliveryLetter must be called as object method (\$self is <$self>)" if not blessed($self);
    return $self->SUPER::call({
        operation => 'retrieveSignatureProofOfDeliveryLetter',
        soap_action => 'http://fedex.com/ws/track/v9/retrieveSignatureProofOfDeliveryLetter',
        style => 'document',
        body => {
            

           'use'            => 'literal',
            namespace       => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle   => '',
            parts           =>  [qw( Shipment::FedEx::WSDL::TrackElements::SignatureProofOfDeliveryLetterRequest )],
        },
        header => {
            
        },
        headerfault => {
            
        }
    }, $body, $header);
}


sub track {
    my ($self, $body, $header) = @_;
    die "track must be called as object method (\$self is <$self>)" if not blessed($self);
    return $self->SUPER::call({
        operation => 'track',
        soap_action => 'http://fedex.com/ws/track/v9/track',
        style => 'document',
        body => {
            

           'use'            => 'literal',
            namespace       => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle   => '',
            parts           =>  [qw( Shipment::FedEx::WSDL::TrackElements::TrackRequest )],
        },
        header => {
            
        },
        headerfault => {
            
        }
    }, $body, $header);
}


sub sendSignatureProofOfDeliveryFax {
    my ($self, $body, $header) = @_;
    die "sendSignatureProofOfDeliveryFax must be called as object method (\$self is <$self>)" if not blessed($self);
    return $self->SUPER::call({
        operation => 'sendSignatureProofOfDeliveryFax',
        soap_action => 'http://fedex.com/ws/track/v9/sendSignatureProofOfDeliveryFax',
        style => 'document',
        body => {
            

           'use'            => 'literal',
            namespace       => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle   => '',
            parts           =>  [qw( Shipment::FedEx::WSDL::TrackElements::SignatureProofOfDeliveryFaxRequest )],
        },
        header => {
            
        },
        headerfault => {
            
        }
    }, $body, $header);
}


sub sendNotifications {
    my ($self, $body, $header) = @_;
    die "sendNotifications must be called as object method (\$self is <$self>)" if not blessed($self);
    return $self->SUPER::call({
        operation => 'sendNotifications',
        soap_action => 'http://fedex.com/ws/track/v9/sendNotifications',
        style => 'document',
        body => {
            

           'use'            => 'literal',
            namespace       => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle   => '',
            parts           =>  [qw( Shipment::FedEx::WSDL::TrackElements::SendNotificationsRequest )],
        },
        header => {
            
        },
        headerfault => {
            
        }
    }, $body, $header);
}




1;



__END__

=pod

=head1 NAME

Shipment::FedEx::WSDL::TrackInterfaces::TrackService::TrackServicePort - SOAP Interface for the TrackService Web Service

=head1 SYNOPSIS

 use Shipment::FedEx::WSDL::TrackInterfaces::TrackService::TrackServicePort;
 my $interface = Shipment::FedEx::WSDL::TrackInterfaces::TrackService::TrackServicePort->new();

 my $response;
 $response = $interface->retrieveSignatureProofOfDeliveryLetter();
 $response = $interface->track();
 $response = $interface->sendSignatureProofOfDeliveryFax();
 $response = $interface->sendNotifications();



=head1 DESCRIPTION

SOAP Interface for the TrackService web service
located at https://wsbeta.fedex.com:443/web-services/track.

=head1 SERVICE TrackService



=head2 Port TrackServicePort



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



=head3 retrieveSignatureProofOfDeliveryLetter



Returns a L<Shipment::FedEx::WSDL::TrackElements::SignatureProofOfDeliveryLetterReply|Shipment::FedEx::WSDL::TrackElements::SignatureProofOfDeliveryLetterReply> object.

 $response = $interface->retrieveSignatureProofOfDeliveryLetter( { # Shipment::FedEx::WSDL::TrackTypes::SignatureProofOfDeliveryLetterRequest
    WebAuthenticationDetail =>  { # Shipment::FedEx::WSDL::TrackTypes::WebAuthenticationDetail
      UserCredential =>  { # Shipment::FedEx::WSDL::TrackTypes::WebAuthenticationCredential
        Key =>  $some_value, # string
        Password =>  $some_value, # string
      },
    },
    ClientDetail =>  { # Shipment::FedEx::WSDL::TrackTypes::ClientDetail
      AccountNumber =>  $some_value, # string
      MeterNumber =>  $some_value, # string
      IntegratorId =>  $some_value, # string
      Localization =>  { # Shipment::FedEx::WSDL::TrackTypes::Localization
        LanguageCode =>  $some_value, # string
        LocaleCode =>  $some_value, # string
      },
    },
    TransactionDetail =>  { # Shipment::FedEx::WSDL::TrackTypes::TransactionDetail
      CustomerTransactionId =>  $some_value, # string
      Localization =>  { # Shipment::FedEx::WSDL::TrackTypes::Localization
        LanguageCode =>  $some_value, # string
        LocaleCode =>  $some_value, # string
      },
    },
    Version =>  { # Shipment::FedEx::WSDL::TrackTypes::VersionId
      ServiceId =>  $some_value, # string
      Major =>  $some_value, # int
      Intermediate =>  $some_value, # int
      Minor =>  $some_value, # int
    },
    QualifiedTrackingNumber =>  { # Shipment::FedEx::WSDL::TrackTypes::QualifiedTrackingNumber
      TrackingNumber =>  $some_value, # string
      ShipDate =>  $some_value, # date
      AccountNumber =>  $some_value, # string
      Carrier => $some_value, # CarrierCodeType
      Destination =>  { # Shipment::FedEx::WSDL::TrackTypes::Address
        StreetLines =>  $some_value, # string
        City =>  $some_value, # string
        StateOrProvinceCode =>  $some_value, # string
        PostalCode =>  $some_value, # string
        UrbanizationCode =>  $some_value, # string
        CountryCode =>  $some_value, # string
        CountryName =>  $some_value, # string
        Residential =>  $some_value, # boolean
      },
    },
    AdditionalComments =>  $some_value, # string
    LetterFormat => $some_value, # SignatureProofOfDeliveryImageType
    Consignee =>  { # Shipment::FedEx::WSDL::TrackTypes::ContactAndAddress
      Contact =>  { # Shipment::FedEx::WSDL::TrackTypes::Contact
        PersonName =>  $some_value, # string
        Title =>  $some_value, # string
        CompanyName =>  $some_value, # string
        PhoneNumber =>  $some_value, # string
        PhoneExtension =>  $some_value, # string
        TollFreePhoneNumber =>  $some_value, # string
        PagerNumber =>  $some_value, # string
        FaxNumber =>  $some_value, # string
        EMailAddress =>  $some_value, # string
      },
      Address =>  { # Shipment::FedEx::WSDL::TrackTypes::Address
        StreetLines =>  $some_value, # string
        City =>  $some_value, # string
        StateOrProvinceCode =>  $some_value, # string
        PostalCode =>  $some_value, # string
        UrbanizationCode =>  $some_value, # string
        CountryCode =>  $some_value, # string
        CountryName =>  $some_value, # string
        Residential =>  $some_value, # boolean
      },
    },
  },,
 );

=head3 track



Returns a L<Shipment::FedEx::WSDL::TrackElements::TrackReply|Shipment::FedEx::WSDL::TrackElements::TrackReply> object.

 $response = $interface->track( { # Shipment::FedEx::WSDL::TrackTypes::TrackRequest
    WebAuthenticationDetail =>  { # Shipment::FedEx::WSDL::TrackTypes::WebAuthenticationDetail
      UserCredential =>  { # Shipment::FedEx::WSDL::TrackTypes::WebAuthenticationCredential
        Key =>  $some_value, # string
        Password =>  $some_value, # string
      },
    },
    ClientDetail =>  { # Shipment::FedEx::WSDL::TrackTypes::ClientDetail
      AccountNumber =>  $some_value, # string
      MeterNumber =>  $some_value, # string
      IntegratorId =>  $some_value, # string
      Localization =>  { # Shipment::FedEx::WSDL::TrackTypes::Localization
        LanguageCode =>  $some_value, # string
        LocaleCode =>  $some_value, # string
      },
    },
    TransactionDetail =>  { # Shipment::FedEx::WSDL::TrackTypes::TransactionDetail
      CustomerTransactionId =>  $some_value, # string
      Localization =>  { # Shipment::FedEx::WSDL::TrackTypes::Localization
        LanguageCode =>  $some_value, # string
        LocaleCode =>  $some_value, # string
      },
    },
    Version =>  { # Shipment::FedEx::WSDL::TrackTypes::VersionId
      ServiceId =>  $some_value, # string
      Major =>  $some_value, # int
      Intermediate =>  $some_value, # int
      Minor =>  $some_value, # int
    },
    SelectionDetails =>  { # Shipment::FedEx::WSDL::TrackTypes::TrackSelectionDetail
      CarrierCode => $some_value, # CarrierCodeType
      OperatingCompany => $some_value, # OperatingCompanyType
      PackageIdentifier =>  { # Shipment::FedEx::WSDL::TrackTypes::TrackPackageIdentifier
        Type => $some_value, # TrackIdentifierType
        Value =>  $some_value, # string
      },
      TrackingNumberUniqueIdentifier =>  $some_value, # string
      ShipDateRangeBegin =>  $some_value, # date
      ShipDateRangeEnd =>  $some_value, # date
      ShipmentAccountNumber =>  $some_value, # string
      SecureSpodAccount =>  $some_value, # string
      Destination =>  { # Shipment::FedEx::WSDL::TrackTypes::Address
        StreetLines =>  $some_value, # string
        City =>  $some_value, # string
        StateOrProvinceCode =>  $some_value, # string
        PostalCode =>  $some_value, # string
        UrbanizationCode =>  $some_value, # string
        CountryCode =>  $some_value, # string
        CountryName =>  $some_value, # string
        Residential =>  $some_value, # boolean
      },
      PagingDetail =>  { # Shipment::FedEx::WSDL::TrackTypes::PagingDetail
        PagingToken =>  $some_value, # string
        NumberOfResultsPerPage =>  $some_value, # nonNegativeInteger
      },
      CustomerSpecifiedTimeOutValueInMilliseconds =>  $some_value, # nonNegativeInteger
    },
    TransactionTimeOutValueInMilliseconds =>  $some_value, # nonNegativeInteger
    ProcessingOptions => $some_value, # TrackRequestProcessingOptionType
  },,
 );

=head3 sendSignatureProofOfDeliveryFax



Returns a L<Shipment::FedEx::WSDL::TrackElements::SignatureProofOfDeliveryFaxReply|Shipment::FedEx::WSDL::TrackElements::SignatureProofOfDeliveryFaxReply> object.

 $response = $interface->sendSignatureProofOfDeliveryFax( { # Shipment::FedEx::WSDL::TrackTypes::SignatureProofOfDeliveryFaxRequest
    WebAuthenticationDetail =>  { # Shipment::FedEx::WSDL::TrackTypes::WebAuthenticationDetail
      UserCredential =>  { # Shipment::FedEx::WSDL::TrackTypes::WebAuthenticationCredential
        Key =>  $some_value, # string
        Password =>  $some_value, # string
      },
    },
    ClientDetail =>  { # Shipment::FedEx::WSDL::TrackTypes::ClientDetail
      AccountNumber =>  $some_value, # string
      MeterNumber =>  $some_value, # string
      IntegratorId =>  $some_value, # string
      Localization =>  { # Shipment::FedEx::WSDL::TrackTypes::Localization
        LanguageCode =>  $some_value, # string
        LocaleCode =>  $some_value, # string
      },
    },
    TransactionDetail =>  { # Shipment::FedEx::WSDL::TrackTypes::TransactionDetail
      CustomerTransactionId =>  $some_value, # string
      Localization =>  { # Shipment::FedEx::WSDL::TrackTypes::Localization
        LanguageCode =>  $some_value, # string
        LocaleCode =>  $some_value, # string
      },
    },
    Version =>  { # Shipment::FedEx::WSDL::TrackTypes::VersionId
      ServiceId =>  $some_value, # string
      Major =>  $some_value, # int
      Intermediate =>  $some_value, # int
      Minor =>  $some_value, # int
    },
    QualifiedTrackingNumber =>  { # Shipment::FedEx::WSDL::TrackTypes::QualifiedTrackingNumber
      TrackingNumber =>  $some_value, # string
      ShipDate =>  $some_value, # date
      AccountNumber =>  $some_value, # string
      Carrier => $some_value, # CarrierCodeType
      Destination =>  { # Shipment::FedEx::WSDL::TrackTypes::Address
        StreetLines =>  $some_value, # string
        City =>  $some_value, # string
        StateOrProvinceCode =>  $some_value, # string
        PostalCode =>  $some_value, # string
        UrbanizationCode =>  $some_value, # string
        CountryCode =>  $some_value, # string
        CountryName =>  $some_value, # string
        Residential =>  $some_value, # boolean
      },
    },
    AdditionalComments =>  $some_value, # string
    FaxSender =>  { # Shipment::FedEx::WSDL::TrackTypes::ContactAndAddress
      Contact =>  { # Shipment::FedEx::WSDL::TrackTypes::Contact
        PersonName =>  $some_value, # string
        Title =>  $some_value, # string
        CompanyName =>  $some_value, # string
        PhoneNumber =>  $some_value, # string
        PhoneExtension =>  $some_value, # string
        TollFreePhoneNumber =>  $some_value, # string
        PagerNumber =>  $some_value, # string
        FaxNumber =>  $some_value, # string
        EMailAddress =>  $some_value, # string
      },
      Address =>  { # Shipment::FedEx::WSDL::TrackTypes::Address
        StreetLines =>  $some_value, # string
        City =>  $some_value, # string
        StateOrProvinceCode =>  $some_value, # string
        PostalCode =>  $some_value, # string
        UrbanizationCode =>  $some_value, # string
        CountryCode =>  $some_value, # string
        CountryName =>  $some_value, # string
        Residential =>  $some_value, # boolean
      },
    },
    FaxRecipient =>  { # Shipment::FedEx::WSDL::TrackTypes::ContactAndAddress
      Contact =>  { # Shipment::FedEx::WSDL::TrackTypes::Contact
        PersonName =>  $some_value, # string
        Title =>  $some_value, # string
        CompanyName =>  $some_value, # string
        PhoneNumber =>  $some_value, # string
        PhoneExtension =>  $some_value, # string
        TollFreePhoneNumber =>  $some_value, # string
        PagerNumber =>  $some_value, # string
        FaxNumber =>  $some_value, # string
        EMailAddress =>  $some_value, # string
      },
      Address =>  { # Shipment::FedEx::WSDL::TrackTypes::Address
        StreetLines =>  $some_value, # string
        City =>  $some_value, # string
        StateOrProvinceCode =>  $some_value, # string
        PostalCode =>  $some_value, # string
        UrbanizationCode =>  $some_value, # string
        CountryCode =>  $some_value, # string
        CountryName =>  $some_value, # string
        Residential =>  $some_value, # boolean
      },
    },
  },,
 );

=head3 sendNotifications



Returns a L<Shipment::FedEx::WSDL::TrackElements::SendNotificationsReply|Shipment::FedEx::WSDL::TrackElements::SendNotificationsReply> object.

 $response = $interface->sendNotifications( { # Shipment::FedEx::WSDL::TrackTypes::SendNotificationsRequest
    WebAuthenticationDetail =>  { # Shipment::FedEx::WSDL::TrackTypes::WebAuthenticationDetail
      UserCredential =>  { # Shipment::FedEx::WSDL::TrackTypes::WebAuthenticationCredential
        Key =>  $some_value, # string
        Password =>  $some_value, # string
      },
    },
    ClientDetail =>  { # Shipment::FedEx::WSDL::TrackTypes::ClientDetail
      AccountNumber =>  $some_value, # string
      MeterNumber =>  $some_value, # string
      IntegratorId =>  $some_value, # string
      Localization =>  { # Shipment::FedEx::WSDL::TrackTypes::Localization
        LanguageCode =>  $some_value, # string
        LocaleCode =>  $some_value, # string
      },
    },
    TransactionDetail =>  { # Shipment::FedEx::WSDL::TrackTypes::TransactionDetail
      CustomerTransactionId =>  $some_value, # string
      Localization =>  { # Shipment::FedEx::WSDL::TrackTypes::Localization
        LanguageCode =>  $some_value, # string
        LocaleCode =>  $some_value, # string
      },
    },
    Version =>  { # Shipment::FedEx::WSDL::TrackTypes::VersionId
      ServiceId =>  $some_value, # string
      Major =>  $some_value, # int
      Intermediate =>  $some_value, # int
      Minor =>  $some_value, # int
    },
    TrackingNumber =>  $some_value, # string
    MultiPiece =>  $some_value, # boolean
    PagingToken =>  $some_value, # string
    TrackingNumberUniqueId =>  $some_value, # string
    ShipDateRangeBegin =>  $some_value, # date
    ShipDateRangeEnd =>  $some_value, # date
    SenderEMailAddress =>  $some_value, # string
    SenderContactName =>  $some_value, # string
    NotificationDetail =>  { # Shipment::FedEx::WSDL::TrackTypes::EMailNotificationDetail
      PersonalMessage =>  $some_value, # string
      Recipients =>  { # Shipment::FedEx::WSDL::TrackTypes::EMailNotificationRecipient
        EMailNotificationRecipientType => $some_value, # EMailNotificationRecipientType
        EMailAddress =>  $some_value, # string
        NotificationEventsRequested => $some_value, # EMailNotificationEventType
        Format => $some_value, # EMailNotificationFormatType
        Localization =>  { # Shipment::FedEx::WSDL::TrackTypes::Localization
          LanguageCode =>  $some_value, # string
          LocaleCode =>  $some_value, # string
        },
      },
    },
  },,
 );



=head1 AUTHOR

Generated by SOAP::WSDL on Tue Aug 30 21:30:56 2016

=cut
