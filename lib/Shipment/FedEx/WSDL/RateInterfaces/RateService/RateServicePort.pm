package Shipment::FedEx::WSDL::RateInterfaces::RateService::RateServicePort;
use strict;
use warnings;
use Class::Std::Fast::Storable;
use Scalar::Util qw(blessed);
use base qw(SOAP::WSDL::Client::Base);


# only load if it hasn't been loaded before
require Shipment::FedEx::WSDL::RateTypemaps::RateService
    if not Shipment::FedEx::WSDL::RateTypemaps::RateService->can('get_class');


sub START {

    my $proxy_domain = $_[2]->{proxy_domain} || 'wsbeta.fedex.com:443';

    $_[0]->set_proxy('https://' . $proxy_domain . '/web-services/rate') if not $_[2]->{proxy};

    $_[0]->set_class_resolver('Shipment::FedEx::WSDL::RateTypemaps::RateService')
        if not $_[2]->{class_resolver};

    $_[0]->set_prefix($_[2]->{use_prefix}) if exists $_[2]->{use_prefix};
}

sub getRates {
    my ($self, $body, $header) = @_;
    die "getRates must be called as object method (\$self is <$self>)" if not blessed($self);
    return $self->SUPER::call({
        operation => 'getRates',
        soap_action => 'getRates',
        style => 'document',
        body => {
            

           'use'            => 'literal',
            namespace       => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle   => '',
            parts           =>  [qw( Shipment::FedEx::WSDL::RateElements::RateRequest )],
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
            parts           =>  [qw( Shipment::FedEx::WSDL::RateElements::RateReply )],
            },
        }
    }, $body, $header);
}





sub _get_name_resolver {

    my $prefix_1 = {
              'attribute' => 'Shipment::FedEx::WSDL::RateAttributes',
              'typemap' => 'Shipment::FedEx::WSDL::RateTypemaps',
              'interface' => 'Shipment::FedEx::WSDL::RateInterfaces',
              'type' => 'Shipment::FedEx::WSDL::RateTypes',
              'server' => 'Shipment::FedEx::WSDL::RateServer',
              'element' => 'Shipment::FedEx::WSDL::RateElements'
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

Shipment::FedEx::WSDL::RateInterfaces::RateService::RateServicePort - SOAP Interface for the RateService Web Service

=head1 SYNOPSIS

 use Shipment::FedEx::WSDL::RateInterfaces::RateService::RateServicePort;
 my $interface = Shipment::FedEx::WSDL::RateInterfaces::RateService::RateServicePort->new();

 my $response;
 $response = $interface->getRates();



=head1 DESCRIPTION

SOAP Interface for the RateService web service
located at https://wsbeta.fedex.com:443/web-services/rate.

=head1 SERVICE RateService



=head2 Port RateServicePort



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



=head3 getRates



Returns a L<Shipment::FedEx::WSDL::RateElements::RateReply|Shipment::FedEx::WSDL::RateElements::RateReply> object.

 $response = $interface->getRates( { # Shipment::FedEx::WSDL::RateTypes::RateRequest
    WebAuthenticationDetail =>  { # Shipment::FedEx::WSDL::RateTypes::WebAuthenticationDetail
      UserCredential =>  { # Shipment::FedEx::WSDL::RateTypes::WebAuthenticationCredential
        Key =>  $some_value, # string
        Password =>  $some_value, # string
      },
    },
    ClientDetail =>  { # Shipment::FedEx::WSDL::RateTypes::ClientDetail
      AccountNumber =>  $some_value, # string
      MeterNumber =>  $some_value, # string
      IntegratorId =>  $some_value, # string
      Region => $some_value, # ExpressRegionCode
      Localization =>  { # Shipment::FedEx::WSDL::RateTypes::Localization
        LanguageCode =>  $some_value, # string
        LocaleCode =>  $some_value, # string
      },
    },
    TransactionDetail =>  { # Shipment::FedEx::WSDL::RateTypes::TransactionDetail
      CustomerTransactionId =>  $some_value, # string
      Localization => {}, # Shipment::FedEx::WSDL::RateTypes::Localization
    },
    Version =>  { # Shipment::FedEx::WSDL::RateTypes::VersionId
      ServiceId =>  $some_value, # string
      Major =>  $some_value, # int
      Intermediate =>  $some_value, # int
      Minor =>  $some_value, # int
    },
    ReturnTransitAndCommit =>  $some_value, # boolean
    CarrierCodes => $some_value, # CarrierCodeType
    VariableOptions => $some_value, # ServiceOptionType
    RequestedShipment =>  { # Shipment::FedEx::WSDL::RateTypes::RequestedShipment
      ShipTimestamp =>  $some_value, # dateTime
      DropoffType => $some_value, # DropoffType
      ServiceType => $some_value, # ServiceType
      PackagingType => $some_value, # PackagingType
      TotalWeight =>  { # Shipment::FedEx::WSDL::RateTypes::Weight
        Units => $some_value, # WeightUnits
        Value =>  $some_value, # decimal
      },
      TotalInsuredValue =>  { # Shipment::FedEx::WSDL::RateTypes::Money
        Currency =>  $some_value, # string
        Amount =>  $some_value, # decimal
      },
      Shipper =>  { # Shipment::FedEx::WSDL::RateTypes::Party
        AccountNumber =>  $some_value, # string
        Tins =>  { # Shipment::FedEx::WSDL::RateTypes::TaxpayerIdentification
          TinType => $some_value, # TinType
          Number =>  $some_value, # string
          Usage =>  $some_value, # string
        },
        Contact =>  { # Shipment::FedEx::WSDL::RateTypes::Contact
          ContactId =>  $some_value, # string
          PersonName =>  $some_value, # string
          Title =>  $some_value, # string
          CompanyName =>  $some_value, # string
          PhoneNumber =>  $some_value, # string
          PhoneExtension =>  $some_value, # string
          PagerNumber =>  $some_value, # string
          FaxNumber =>  $some_value, # string
          EMailAddress =>  $some_value, # string
        },
        Address =>  { # Shipment::FedEx::WSDL::RateTypes::Address
          StreetLines =>  $some_value, # string
          City =>  $some_value, # string
          StateOrProvinceCode =>  $some_value, # string
          PostalCode =>  $some_value, # string
          UrbanizationCode =>  $some_value, # string
          CountryCode =>  $some_value, # string
          Residential =>  $some_value, # boolean
        },
      },
      Recipient => {}, # Shipment::FedEx::WSDL::RateTypes::Party
      RecipientLocationNumber =>  $some_value, # string
      Origin =>  { # Shipment::FedEx::WSDL::RateTypes::ContactAndAddress
        Contact => {}, # Shipment::FedEx::WSDL::RateTypes::Contact
        Address => {}, # Shipment::FedEx::WSDL::RateTypes::Address
      },
      ShippingChargesPayment =>  { # Shipment::FedEx::WSDL::RateTypes::Payment
        PaymentType => $some_value, # PaymentType
        Payor =>  { # Shipment::FedEx::WSDL::RateTypes::Payor
          AccountNumber =>  $some_value, # string
          CountryCode =>  $some_value, # string
        },
      },
      SpecialServicesRequested =>  { # Shipment::FedEx::WSDL::RateTypes::ShipmentSpecialServicesRequested
        SpecialServiceTypes => $some_value, # ShipmentSpecialServiceType
        CodDetail =>  { # Shipment::FedEx::WSDL::RateTypes::CodDetail
          CodCollectionAmount => {}, # Shipment::FedEx::WSDL::RateTypes::Money
          AddTransportationCharges => $some_value, # CodAddTransportationChargesType
          CollectionType => $some_value, # CodCollectionType
          CodRecipient => {}, # Shipment::FedEx::WSDL::RateTypes::Party
          ReferenceIndicator => $some_value, # CodReturnReferenceIndicatorType
        },
        HoldAtLocationDetail =>  { # Shipment::FedEx::WSDL::RateTypes::HoldAtLocationDetail
          PhoneNumber =>  $some_value, # string
          LocationContactAndAddress => {}, # Shipment::FedEx::WSDL::RateTypes::ContactAndAddress
          LocationType => $some_value, # FedExLocationType
          LocationId =>  $some_value, # string
          LocationNumber =>  $some_value, # int
        },
        EMailNotificationDetail =>  { # Shipment::FedEx::WSDL::RateTypes::EMailNotificationDetail
          PersonalMessage =>  $some_value, # string
          Recipients =>  { # Shipment::FedEx::WSDL::RateTypes::EMailNotificationRecipient
            EMailNotificationRecipientType => $some_value, # EMailNotificationRecipientType
            EMailAddress =>  $some_value, # string
            NotifyOnShipment =>  $some_value, # boolean
            NotifyOnException =>  $some_value, # boolean
            NotifyOnDelivery =>  $some_value, # boolean
            Format => $some_value, # EMailNotificationFormatType
            Localization => {}, # Shipment::FedEx::WSDL::RateTypes::Localization
          },
        },
        ReturnShipmentDetail =>  { # Shipment::FedEx::WSDL::RateTypes::ReturnShipmentDetail
          ReturnType => $some_value, # ReturnType
          Rma =>  { # Shipment::FedEx::WSDL::RateTypes::Rma
            Number =>  $some_value, # string
            Reason =>  $some_value, # string
          },
          ReturnEMailDetail =>  { # Shipment::FedEx::WSDL::RateTypes::ReturnEMailDetail
            MerchantPhoneNumber =>  $some_value, # string
            AllowedSpecialServices => $some_value, # ReturnEMailAllowedSpecialServiceType
          },
        },
        PendingShipmentDetail =>  { # Shipment::FedEx::WSDL::RateTypes::PendingShipmentDetail
          Type => $some_value, # PendingShipmentType
          ExpirationDate =>  $some_value, # dateTime
          EmailLabelDetail =>  { # Shipment::FedEx::WSDL::RateTypes::EMailLabelDetail
            NotificationEMailAddress =>  $some_value, # string
            NotificationMessage =>  $some_value, # string
          },
        },
        ShipmentDryIceDetail =>  { # Shipment::FedEx::WSDL::RateTypes::ShipmentDryIceDetail
          PackageCount =>  $some_value, # nonNegativeInteger
          TotalWeight => {}, # Shipment::FedEx::WSDL::RateTypes::Weight
        },
        HomeDeliveryPremiumDetail =>  { # Shipment::FedEx::WSDL::RateTypes::HomeDeliveryPremiumDetail
          HomeDeliveryPremiumType => $some_value, # HomeDeliveryPremiumType
          Date =>  $some_value, # date
          PhoneNumber =>  $some_value, # string
        },
        FlatbedTrailerDetail =>  { # Shipment::FedEx::WSDL::RateTypes::FlatbedTrailerDetail
          Options => $some_value, # FlatbedTrailerOption
        },
        FreightGuaranteeDetail =>  { # Shipment::FedEx::WSDL::RateTypes::FreightGuaranteeDetail
          Type => $some_value, # FreightGuaranteeType
          Date =>  $some_value, # date
          Time =>  $some_value, # time
        },
        EtdDetail =>  { # Shipment::FedEx::WSDL::RateTypes::EtdDetail
          RequestedDocumentCopies => $some_value, # RequestedShippingDocumentType
          Documents =>  { # Shipment::FedEx::WSDL::RateTypes::UploadDocumentDetail
            LineNumber =>  $some_value, # nonNegativeInteger
            CustomerReference =>  $some_value, # string
            DocumentProducer => $some_value, # UploadDocumentProducerType
            DocumentType => $some_value, # UploadDocumentType
            FileName =>  $some_value, # string
            DocumentContent =>  $some_value, # base64Binary
          },
          DocumentReferences =>  { # Shipment::FedEx::WSDL::RateTypes::UploadDocumentReferenceDetail
            LineNumber =>  $some_value, # nonNegativeInteger
            CustomerReference =>  $some_value, # string
            DocumentProducer => $some_value, # UploadDocumentProducerType
            DocumentType => $some_value, # UploadDocumentType
            DocumentId =>  $some_value, # string
            DocumentIdProducer => $some_value, # UploadDocumentIdProducer
          },
        },
        CustomDeliveryWindowDetail =>  { # Shipment::FedEx::WSDL::RateTypes::CustomDeliveryWindowDetail
          Type => $some_value, # CustomDeliveryWindowType
          RequestTime =>  $some_value, # time
          RequestRange =>  { # Shipment::FedEx::WSDL::RateTypes::DateRange
            Begins =>  $some_value, # date
            Ends =>  $some_value, # date
          },
          RequestDate =>  $some_value, # date
        },
      },
      ExpressFreightDetail =>  { # Shipment::FedEx::WSDL::RateTypes::ExpressFreightDetail
        PackingListEnclosed =>  $some_value, # boolean
        ShippersLoadAndCount =>  $some_value, # positiveInteger
        BookingConfirmationNumber =>  $some_value, # string
        ReferenceLabelRequested =>  $some_value, # boolean
        BeforeDeliveryContact =>  { # Shipment::FedEx::WSDL::RateTypes::ExpressFreightDetailContact
          Name =>  $some_value, # string
          Phone =>  $some_value, # string
        },
        UndeliverableContact => {}, # Shipment::FedEx::WSDL::RateTypes::ExpressFreightDetailContact
      },
      FreightShipmentDetail =>  { # Shipment::FedEx::WSDL::RateTypes::FreightShipmentDetail
        FedExFreightAccountNumber =>  $some_value, # string
        FedExFreightBillingContactAndAddress => {}, # Shipment::FedEx::WSDL::RateTypes::ContactAndAddress
        FedExNationalFreightAccountNumber =>  $some_value, # string
        FedExNationalFreightBillingContactAndAddress => {}, # Shipment::FedEx::WSDL::RateTypes::ContactAndAddress
        Role => $some_value, # FreightShipmentRoleType
        PaymentType => $some_value, # FreightAccountPaymentType
        DeclaredValuePerUnit => {}, # Shipment::FedEx::WSDL::RateTypes::Money
        DeclaredValueUnits =>  $some_value, # string
        LiabilityCoverageDetail =>  { # Shipment::FedEx::WSDL::RateTypes::LiabilityCoverageDetail
          CoverageType => $some_value, # LiabilityCoverageType
          CoverageAmount => {}, # Shipment::FedEx::WSDL::RateTypes::Money
        },
        Coupons =>  $some_value, # string
        TotalHandlingUnits =>  $some_value, # nonNegativeInteger
        ClientDiscountPercent =>  $some_value, # decimal
        PalletWeight => {}, # Shipment::FedEx::WSDL::RateTypes::Weight
        ShipmentDimensions =>  { # Shipment::FedEx::WSDL::RateTypes::Dimensions
          Length => $some_value, # atomic
          Width => $some_value, # atomic
          Height => $some_value, # atomic
          Units => $some_value, # LinearUnits
        },
        Comment =>  $some_value, # string
        SpecialServicePayments =>  { # Shipment::FedEx::WSDL::RateTypes::FreightSpecialServicePayment
          SpecialService => $some_value, # ShipmentSpecialServiceType
          PaymentType => $some_value, # FreightAccountPaymentType
        },
        LineItems =>  { # Shipment::FedEx::WSDL::RateTypes::FreightShipmentLineItem
          FreightClass => $some_value, # FreightClassType
          Packaging => $some_value, # PhysicalPackagingType
          Description =>  $some_value, # string
          Weight => {}, # Shipment::FedEx::WSDL::RateTypes::Weight
          Dimensions => {}, # Shipment::FedEx::WSDL::RateTypes::Dimensions
          Volume =>  { # Shipment::FedEx::WSDL::RateTypes::Volume
            Units => $some_value, # VolumeUnits
            Value =>  $some_value, # decimal
          },
        },
      },
      DeliveryInstructions =>  $some_value, # string
      VariableHandlingChargeDetail =>  { # Shipment::FedEx::WSDL::RateTypes::VariableHandlingChargeDetail
        VariableHandlingChargeType => $some_value, # VariableHandlingChargeType
        FixedValue => {}, # Shipment::FedEx::WSDL::RateTypes::Money
        PercentValue =>  $some_value, # decimal
      },
      CustomsClearanceDetail =>  { # Shipment::FedEx::WSDL::RateTypes::CustomsClearanceDetail
        Broker => {}, # Shipment::FedEx::WSDL::RateTypes::Party
        ClearanceBrokerage => $some_value, # ClearanceBrokerageType
        ImporterOfRecord => {}, # Shipment::FedEx::WSDL::RateTypes::Party
        RecipientCustomsId =>  { # Shipment::FedEx::WSDL::RateTypes::RecipientCustomsId
          Type => $some_value, # RecipientCustomsIdType
          Value =>  $some_value, # string
        },
        DutiesPayment => {}, # Shipment::FedEx::WSDL::RateTypes::Payment
        DocumentContent => $some_value, # InternationalDocumentContentType
        CustomsValue => {}, # Shipment::FedEx::WSDL::RateTypes::Money
        FreightOnValue => $some_value, # FreightOnValueType
        InsuranceCharges => {}, # Shipment::FedEx::WSDL::RateTypes::Money
        PartiesToTransactionAreRelated =>  $some_value, # boolean
        CommercialInvoice =>  { # Shipment::FedEx::WSDL::RateTypes::CommercialInvoice
          Comments =>  $some_value, # string
          FreightCharge => {}, # Shipment::FedEx::WSDL::RateTypes::Money
          TaxesOrMiscellaneousCharge => {}, # Shipment::FedEx::WSDL::RateTypes::Money
          PackingCosts => {}, # Shipment::FedEx::WSDL::RateTypes::Money
          HandlingCosts => {}, # Shipment::FedEx::WSDL::RateTypes::Money
          SpecialInstructions =>  $some_value, # string
          DeclarationStatment =>  $some_value, # string
          PaymentTerms =>  $some_value, # string
          Purpose => $some_value, # PurposeOfShipmentType
          PurposeOfShipmentDescription =>  $some_value, # string
          CustomerInvoiceNumber =>  $some_value, # string
          OriginatorName =>  $some_value, # string
          TermsOfSale => $some_value, # TermsOfSaleType
        },
        Commodities =>  { # Shipment::FedEx::WSDL::RateTypes::Commodity
          Name =>  $some_value, # string
          NumberOfPieces =>  $some_value, # nonNegativeInteger
          Description =>  $some_value, # string
          CountryOfManufacture =>  $some_value, # string
          HarmonizedCode =>  $some_value, # string
          Weight => {}, # Shipment::FedEx::WSDL::RateTypes::Weight
          Quantity =>  $some_value, # nonNegativeInteger
          QuantityUnits =>  $some_value, # string
          AdditionalMeasures =>  { # Shipment::FedEx::WSDL::RateTypes::Measure
            Quantity =>  $some_value, # decimal
            Units =>  $some_value, # string
          },
          UnitPrice => {}, # Shipment::FedEx::WSDL::RateTypes::Money
          CustomsValue => {}, # Shipment::FedEx::WSDL::RateTypes::Money
          ExciseConditions =>  { # Shipment::FedEx::WSDL::RateTypes::EdtExciseCondition
            Category =>  $some_value, # string
            Value =>  $some_value, # string
          },
          ExportLicenseNumber =>  $some_value, # string
          ExportLicenseExpirationDate =>  $some_value, # date
          CIMarksAndNumbers =>  $some_value, # string
          NaftaDetail =>  { # Shipment::FedEx::WSDL::RateTypes::NaftaCommodityDetail
            PreferenceCriterion => $some_value, # NaftaPreferenceCriterionCode
            ProducerDetermination => $some_value, # NaftaProducerDeterminationCode
            ProducerId =>  $some_value, # string
            NetCostMethod => $some_value, # NaftaNetCostMethodCode
            NetCostDateRange => {}, # Shipment::FedEx::WSDL::RateTypes::DateRange
          },
        },
        ExportDetail =>  { # Shipment::FedEx::WSDL::RateTypes::ExportDetail
          B13AFilingOption => $some_value, # B13AFilingOptionType
          ExportComplianceStatement =>  $some_value, # string
          PermitNumber =>  $some_value, # string
          DestinationControlDetail =>  { # Shipment::FedEx::WSDL::RateTypes::DestinationControlDetail
            StatementTypes => $some_value, # DestinationControlStatementType
            DestinationCountries =>  $some_value, # string
            EndUser =>  $some_value, # string
          },
        },
        RegulatoryControls => $some_value, # RegulatoryControlType
      },
      PickupDetail =>  { # Shipment::FedEx::WSDL::RateTypes::PickupDetail
        ReadyDateTime =>  $some_value, # dateTime
        LatestPickupDateTime =>  $some_value, # dateTime
        CourierInstructions =>  $some_value, # string
        RequestType => $some_value, # PickupRequestType
        RequestSource => $some_value, # PickupRequestSourceType
      },
      SmartPostDetail =>  { # Shipment::FedEx::WSDL::RateTypes::SmartPostShipmentDetail
        Indicia => $some_value, # SmartPostIndiciaType
        AncillaryEndorsement => $some_value, # SmartPostAncillaryEndorsementType
        HubId =>  $some_value, # string
        CustomerManifestId =>  $some_value, # string
      },
      BlockInsightVisibility =>  $some_value, # boolean
      LabelSpecification =>  { # Shipment::FedEx::WSDL::RateTypes::LabelSpecification
        LabelFormatType => $some_value, # LabelFormatType
        ImageType => $some_value, # ShippingDocumentImageType
        LabelStockType => $some_value, # LabelStockType
        LabelPrintingOrientation => $some_value, # LabelPrintingOrientationType
        LabelRotation => $some_value, # LabelRotationType
        PrintedLabelOrigin => {}, # Shipment::FedEx::WSDL::RateTypes::ContactAndAddress
        CustomerSpecifiedDetail =>  { # Shipment::FedEx::WSDL::RateTypes::CustomerSpecifiedLabelDetail
          DocTabContent =>  { # Shipment::FedEx::WSDL::RateTypes::DocTabContent
            DocTabContentType => $some_value, # DocTabContentType
            Zone001 =>  { # Shipment::FedEx::WSDL::RateTypes::DocTabContentZone001
              DocTabZoneSpecifications =>  { # Shipment::FedEx::WSDL::RateTypes::DocTabZoneSpecification
                ZoneNumber =>  $some_value, # positiveInteger
                Header =>  $some_value, # string
                DataField =>  $some_value, # string
                LiteralValue =>  $some_value, # string
                Justification => $some_value, # DocTabZoneJustificationType
              },
            },
            Barcoded =>  { # Shipment::FedEx::WSDL::RateTypes::DocTabContentBarcoded
              Symbology => $some_value, # BarcodeSymbologyType
              Specification => {}, # Shipment::FedEx::WSDL::RateTypes::DocTabZoneSpecification
            },
          },
          CustomContent =>  { # Shipment::FedEx::WSDL::RateTypes::CustomLabelDetail
            CoordinateUnits => $some_value, # CustomLabelCoordinateUnits
            TextEntries =>  { # Shipment::FedEx::WSDL::RateTypes::CustomLabelTextEntry
              Position =>  { # Shipment::FedEx::WSDL::RateTypes::CustomLabelPosition
                X =>  $some_value, # nonNegativeInteger
                Y =>  $some_value, # nonNegativeInteger
              },
              Format =>  $some_value, # string
              DataFields =>  $some_value, # string
              ThermalFontId =>  $some_value, # string
              FontName =>  $some_value, # string
              FontSize =>  $some_value, # positiveInteger
            },
            GraphicEntries =>  { # Shipment::FedEx::WSDL::RateTypes::CustomLabelGraphicEntry
              Position => {}, # Shipment::FedEx::WSDL::RateTypes::CustomLabelPosition
              PrinterGraphicId =>  $some_value, # string
              FileGraphicFullName =>  $some_value, # string
            },
            BoxEntries =>  { # Shipment::FedEx::WSDL::RateTypes::CustomLabelBoxEntry
              TopLeftCorner => {}, # Shipment::FedEx::WSDL::RateTypes::CustomLabelPosition
              BottomRightCorner => {}, # Shipment::FedEx::WSDL::RateTypes::CustomLabelPosition
            },
            BarcodeEntries =>  { # Shipment::FedEx::WSDL::RateTypes::CustomLabelBarcodeEntry
              Position => {}, # Shipment::FedEx::WSDL::RateTypes::CustomLabelPosition
              Format =>  $some_value, # string
              DataFields =>  $some_value, # string
              BarHeight =>  $some_value, # int
              ThinBarWidth =>  $some_value, # int
              BarcodeSymbology => $some_value, # BarcodeSymbologyType
            },
          },
          ConfigurableReferenceEntries =>  { # Shipment::FedEx::WSDL::RateTypes::ConfigurableLabelReferenceEntry
            ZoneNumber =>  $some_value, # positiveInteger
            Header =>  $some_value, # string
            DataField =>  $some_value, # string
            LiteralValue =>  $some_value, # string
          },
          MaskedData => $some_value, # LabelMaskableDataType
          TermsAndConditionsLocalization => {}, # Shipment::FedEx::WSDL::RateTypes::Localization
          AdditionalLabels =>  { # Shipment::FedEx::WSDL::RateTypes::AdditionalLabelsDetail
            Type => $some_value, # AdditionalLabelsType
            Count =>  $some_value, # nonNegativeInteger
          },
          AirWaybillSuppressionCount =>  $some_value, # nonNegativeInteger
        },
      },
      ShippingDocumentSpecification =>  { # Shipment::FedEx::WSDL::RateTypes::ShippingDocumentSpecification
        ShippingDocumentTypes => $some_value, # RequestedShippingDocumentType
        CertificateOfOrigin =>  { # Shipment::FedEx::WSDL::RateTypes::CertificateOfOriginDetail
          DocumentFormat =>  { # Shipment::FedEx::WSDL::RateTypes::ShippingDocumentFormat
            Dispositions =>  { # Shipment::FedEx::WSDL::RateTypes::ShippingDocumentDispositionDetail
              DispositionType => $some_value, # ShippingDocumentDispositionType
              Grouping => $some_value, # ShippingDocumentGroupingType
              EMailDetail =>  { # Shipment::FedEx::WSDL::RateTypes::ShippingDocumentEMailDetail
                EMailRecipients =>  { # Shipment::FedEx::WSDL::RateTypes::ShippingDocumentEMailRecipient
                  RecipientType => $some_value, # EMailNotificationRecipientType
                  Address =>  $some_value, # string
                },
                Grouping => $some_value, # ShippingDocumentEMailGroupingType
              },
              PrintDetail =>  { # Shipment::FedEx::WSDL::RateTypes::ShippingDocumentPrintDetail
                PrinterId =>  $some_value, # string
              },
            },
            TopOfPageOffset =>  { # Shipment::FedEx::WSDL::RateTypes::LinearMeasure
              Value =>  $some_value, # decimal
              Units => $some_value, # LinearUnits
            },
            ImageType => $some_value, # ShippingDocumentImageType
            StockType => $some_value, # ShippingDocumentStockType
            ProvideInstructions =>  $some_value, # boolean
            Localization => {}, # Shipment::FedEx::WSDL::RateTypes::Localization
          },
          CustomerImageUsages =>  { # Shipment::FedEx::WSDL::RateTypes::CustomerImageUsage
            Type => $some_value, # CustomerImageUsageType
            Id => $some_value, # ImageId
          },
        },
        CommercialInvoiceDetail =>  { # Shipment::FedEx::WSDL::RateTypes::CommercialInvoiceDetail
          Format => {}, # Shipment::FedEx::WSDL::RateTypes::ShippingDocumentFormat
          CustomerImageUsages => {}, # Shipment::FedEx::WSDL::RateTypes::CustomerImageUsage
        },
        CustomPackageDocumentDetail =>  { # Shipment::FedEx::WSDL::RateTypes::CustomDocumentDetail
          Format => {}, # Shipment::FedEx::WSDL::RateTypes::ShippingDocumentFormat
          LabelPrintingOrientation => $some_value, # LabelPrintingOrientationType
          LabelRotation => $some_value, # LabelRotationType
          SpecificationId =>  $some_value, # string
        },
        CustomShipmentDocumentDetail => {}, # Shipment::FedEx::WSDL::RateTypes::CustomDocumentDetail
        GeneralAgencyAgreementDetail =>  { # Shipment::FedEx::WSDL::RateTypes::GeneralAgencyAgreementDetail
          Format => {}, # Shipment::FedEx::WSDL::RateTypes::ShippingDocumentFormat
        },
        NaftaCertificateOfOriginDetail =>  { # Shipment::FedEx::WSDL::RateTypes::NaftaCertificateOfOriginDetail
          Format => {}, # Shipment::FedEx::WSDL::RateTypes::ShippingDocumentFormat
          BlanketPeriod => {}, # Shipment::FedEx::WSDL::RateTypes::DateRange
          ImporterSpecification => $some_value, # NaftaImporterSpecificationType
          SignatureContact => {}, # Shipment::FedEx::WSDL::RateTypes::Contact
          ProducerSpecification => $some_value, # NaftaProducerSpecificationType
          Producers =>  { # Shipment::FedEx::WSDL::RateTypes::NaftaProducer
            Id =>  $some_value, # string
            Producer => {}, # Shipment::FedEx::WSDL::RateTypes::Party
          },
          CustomerImageUsages => {}, # Shipment::FedEx::WSDL::RateTypes::CustomerImageUsage
        },
        Op900Detail =>  { # Shipment::FedEx::WSDL::RateTypes::Op900Detail
          Format => {}, # Shipment::FedEx::WSDL::RateTypes::ShippingDocumentFormat
          Reference => $some_value, # CustomerReferenceType
          CustomerImageUsages => {}, # Shipment::FedEx::WSDL::RateTypes::CustomerImageUsage
          SignatureName =>  $some_value, # string
        },
      },
      RateRequestTypes => $some_value, # RateRequestType
      EdtRequestType => $some_value, # EdtRequestType
      PackageCount =>  $some_value, # nonNegativeInteger
      PackageDetail => $some_value, # RequestedPackageDetailType
      RequestedPackageLineItems =>  { # Shipment::FedEx::WSDL::RateTypes::RequestedPackageLineItem
        SequenceNumber =>  $some_value, # positiveInteger
        GroupNumber =>  $some_value, # nonNegativeInteger
        GroupPackageCount =>  $some_value, # nonNegativeInteger
        VariableHandlingChargeDetail => {}, # Shipment::FedEx::WSDL::RateTypes::VariableHandlingChargeDetail
        InsuredValue => {}, # Shipment::FedEx::WSDL::RateTypes::Money
        Weight => {}, # Shipment::FedEx::WSDL::RateTypes::Weight
        Dimensions => {}, # Shipment::FedEx::WSDL::RateTypes::Dimensions
        PhysicalPackaging => $some_value, # PhysicalPackagingType
        ItemDescription =>  $some_value, # string
        CustomerReferences =>  { # Shipment::FedEx::WSDL::RateTypes::CustomerReference
          CustomerReferenceType => $some_value, # CustomerReferenceType
          Value =>  $some_value, # string
        },
        SpecialServicesRequested =>  { # Shipment::FedEx::WSDL::RateTypes::PackageSpecialServicesRequested
          SpecialServiceTypes => $some_value, # PackageSpecialServiceType
          CodDetail => {}, # Shipment::FedEx::WSDL::RateTypes::CodDetail
          DangerousGoodsDetail =>  { # Shipment::FedEx::WSDL::RateTypes::DangerousGoodsDetail
            Accessibility => $some_value, # DangerousGoodsAccessibilityType
            CargoAircraftOnly =>  $some_value, # boolean
            Options => $some_value, # HazardousCommodityOptionType
            HazardousCommodities =>  { # Shipment::FedEx::WSDL::RateTypes::HazardousCommodityContent
              Description =>  { # Shipment::FedEx::WSDL::RateTypes::HazardousCommodityDescription
                Id =>  $some_value, # string
                PackingGroup => $some_value, # HazardousCommodityPackingGroupType
                ProperShippingName =>  $some_value, # string
                TechnicalName =>  $some_value, # string
                HazardClass =>  $some_value, # string
                SubsidiaryClasses =>  $some_value, # string
                LabelText =>  $some_value, # string
              },
              Quantity =>  { # Shipment::FedEx::WSDL::RateTypes::HazardousCommodityQuantityDetail
                Amount =>  $some_value, # decimal
                Units =>  $some_value, # string
              },
              Options =>  { # Shipment::FedEx::WSDL::RateTypes::HazardousCommodityOptionDetail
                LabelTextOption => $some_value, # HazardousCommodityLabelTextOptionType
                CustomerSuppliedLabelText =>  $some_value, # string
              },
            },
            Packaging =>  { # Shipment::FedEx::WSDL::RateTypes::HazardousCommodityPackagingDetail
              Count =>  $some_value, # nonNegativeInteger
              Units =>  $some_value, # string
            },
            EmergencyContactNumber =>  $some_value, # string
          },
          DryIceWeight => {}, # Shipment::FedEx::WSDL::RateTypes::Weight
          SignatureOptionDetail =>  { # Shipment::FedEx::WSDL::RateTypes::SignatureOptionDetail
            OptionType => $some_value, # SignatureOptionType
            SignatureReleaseNumber =>  $some_value, # string
          },
          PriorityAlertDetail =>  { # Shipment::FedEx::WSDL::RateTypes::PriorityAlertDetail
            Content =>  $some_value, # string
          },
        },
        ContentRecords =>  { # Shipment::FedEx::WSDL::RateTypes::ContentRecord
          PartNumber =>  $some_value, # string
          ItemNumber =>  $some_value, # string
          ReceivedQuantity =>  $some_value, # nonNegativeInteger
          Description =>  $some_value, # string
        },
      },
    },
  },,
 );



=head1 AUTHOR

Generated by SOAP::WSDL on Tue Oct 12 13:55:29 2010

=cut
