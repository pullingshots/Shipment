package Shipment::FedEx::WSDL::TrackTypes::CompletedTrackDetail;
use strict;
use warnings;


__PACKAGE__->_set_element_form_qualified(1);

sub get_xmlns { 'http://fedex.com/ws/track/v9' };

our $XML_ATTRIBUTE_CLASS;
undef $XML_ATTRIBUTE_CLASS;

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}

use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %HighestSeverity_of :ATTR(:get<HighestSeverity>);
my %Notifications_of :ATTR(:get<Notifications>);
my %DuplicateWaybill_of :ATTR(:get<DuplicateWaybill>);
my %MoreData_of :ATTR(:get<MoreData>);
my %PagingToken_of :ATTR(:get<PagingToken>);
my %TrackDetailsCount_of :ATTR(:get<TrackDetailsCount>);
my %TrackDetails_of :ATTR(:get<TrackDetails>);

__PACKAGE__->_factory(
    [ qw(        HighestSeverity
        Notifications
        DuplicateWaybill
        MoreData
        PagingToken
        TrackDetailsCount
        TrackDetails

    ) ],
    {
        'HighestSeverity' => \%HighestSeverity_of,
        'Notifications' => \%Notifications_of,
        'DuplicateWaybill' => \%DuplicateWaybill_of,
        'MoreData' => \%MoreData_of,
        'PagingToken' => \%PagingToken_of,
        'TrackDetailsCount' => \%TrackDetailsCount_of,
        'TrackDetails' => \%TrackDetails_of,
    },
    {
        'HighestSeverity' => 'Shipment::FedEx::WSDL::TrackTypes::NotificationSeverityType',
        'Notifications' => 'Shipment::FedEx::WSDL::TrackTypes::Notification',
        'DuplicateWaybill' => 'SOAP::WSDL::XSD::Typelib::Builtin::boolean',
        'MoreData' => 'SOAP::WSDL::XSD::Typelib::Builtin::boolean',
        'PagingToken' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'TrackDetailsCount' => 'SOAP::WSDL::XSD::Typelib::Builtin::nonNegativeInteger',
        'TrackDetails' => 'Shipment::FedEx::WSDL::TrackTypes::TrackDetail',
    },
    {

        'HighestSeverity' => 'HighestSeverity',
        'Notifications' => 'Notifications',
        'DuplicateWaybill' => 'DuplicateWaybill',
        'MoreData' => 'MoreData',
        'PagingToken' => 'PagingToken',
        'TrackDetailsCount' => 'TrackDetailsCount',
        'TrackDetails' => 'TrackDetails',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::FedEx::WSDL::TrackTypes::CompletedTrackDetail

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
CompletedTrackDetail from the namespace http://fedex.com/ws/track/v9.






=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * HighestSeverity


=item * Notifications


=item * DuplicateWaybill


=item * MoreData


=item * PagingToken


=item * TrackDetailsCount


=item * TrackDetails




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::FedEx::WSDL::TrackTypes::CompletedTrackDetail
   HighestSeverity => $some_value, # NotificationSeverityType
   Notifications =>  { # Shipment::FedEx::WSDL::TrackTypes::Notification
     Severity => $some_value, # NotificationSeverityType
     Source =>  $some_value, # string
     Code =>  $some_value, # string
     Message =>  $some_value, # string
     LocalizedMessage =>  $some_value, # string
     MessageParameters =>  { # Shipment::FedEx::WSDL::TrackTypes::NotificationParameter
       Id =>  $some_value, # string
       Value =>  $some_value, # string
     },
   },
   DuplicateWaybill =>  $some_value, # boolean
   MoreData =>  $some_value, # boolean
   PagingToken =>  $some_value, # string
   TrackDetailsCount =>  $some_value, # nonNegativeInteger
   TrackDetails =>  { # Shipment::FedEx::WSDL::TrackTypes::TrackDetail
     Notification =>  { # Shipment::FedEx::WSDL::TrackTypes::Notification
       Severity => $some_value, # NotificationSeverityType
       Source =>  $some_value, # string
       Code =>  $some_value, # string
       Message =>  $some_value, # string
       LocalizedMessage =>  $some_value, # string
       MessageParameters =>  { # Shipment::FedEx::WSDL::TrackTypes::NotificationParameter
         Id =>  $some_value, # string
         Value =>  $some_value, # string
       },
     },
     TrackingNumber =>  $some_value, # string
     Barcode =>  { # Shipment::FedEx::WSDL::TrackTypes::StringBarcode
       Type => $some_value, # StringBarcodeType
       Value =>  $some_value, # string
     },
     TrackingNumberUniqueIdentifier =>  $some_value, # string
     StatusDetail =>  { # Shipment::FedEx::WSDL::TrackTypes::TrackStatusDetail
       CreationTime =>  $some_value, # dateTime
       Code =>  $some_value, # string
       Description =>  $some_value, # string
       Location =>  { # Shipment::FedEx::WSDL::TrackTypes::Address
         StreetLines =>  $some_value, # string
         City =>  $some_value, # string
         StateOrProvinceCode =>  $some_value, # string
         PostalCode =>  $some_value, # string
         UrbanizationCode =>  $some_value, # string
         CountryCode =>  $some_value, # string
         CountryName =>  $some_value, # string
         Residential =>  $some_value, # boolean
       },
       AncillaryDetails =>  { # Shipment::FedEx::WSDL::TrackTypes::TrackStatusAncillaryDetail
         Reason =>  $some_value, # string
         ReasonDescription =>  $some_value, # string
         Action =>  $some_value, # string
         ActionDescription =>  $some_value, # string
       },
     },
     CustomerExceptionRequests =>  { # Shipment::FedEx::WSDL::TrackTypes::CustomerExceptionRequestDetail
       Id =>  $some_value, # string
       StatusCode =>  $some_value, # string
       StatusDescription =>  $some_value, # string
       CreateTime =>  $some_value, # dateTime
     },
     Reconciliation =>  { # Shipment::FedEx::WSDL::TrackTypes::TrackReconciliation
       Status =>  $some_value, # string
       Description =>  $some_value, # string
     },
     ServiceCommitMessage =>  $some_value, # string
     DestinationServiceArea =>  $some_value, # string
     DestinationServiceAreaDescription =>  $some_value, # string
     CarrierCode => $some_value, # CarrierCodeType
     OperatingCompany => $some_value, # OperatingCompanyType
     OperatingCompanyOrCarrierDescription =>  $some_value, # string
     CartageAgentCompanyName =>  $some_value, # string
     ProductionLocationContactAndAddress =>  { # Shipment::FedEx::WSDL::TrackTypes::ContactAndAddress
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
     OtherIdentifiers =>  { # Shipment::FedEx::WSDL::TrackTypes::TrackOtherIdentifierDetail
       PackageIdentifier =>  { # Shipment::FedEx::WSDL::TrackTypes::TrackPackageIdentifier
         Type => $some_value, # TrackIdentifierType
         Value =>  $some_value, # string
       },
       TrackingNumberUniqueIdentifier =>  $some_value, # string
       CarrierCode => $some_value, # CarrierCodeType
     },
     FormId =>  $some_value, # string
     Service =>  { # Shipment::FedEx::WSDL::TrackTypes::TrackServiceDescriptionDetail
       Type => $some_value, # ServiceType
       Description =>  $some_value, # string
       ShortDescription =>  $some_value, # string
     },
     PackageWeight =>  { # Shipment::FedEx::WSDL::TrackTypes::Weight
       Units => $some_value, # WeightUnits
       Value =>  $some_value, # decimal
     },
     PackageDimensions =>  { # Shipment::FedEx::WSDL::TrackTypes::Dimensions
       Length =>  $some_value, # nonNegativeInteger
       Width =>  $some_value, # nonNegativeInteger
       Height =>  $some_value, # nonNegativeInteger
       Units => $some_value, # LinearUnits
     },
     PackageDimensionalWeight =>  { # Shipment::FedEx::WSDL::TrackTypes::Weight
       Units => $some_value, # WeightUnits
       Value =>  $some_value, # decimal
     },
     ShipmentWeight =>  { # Shipment::FedEx::WSDL::TrackTypes::Weight
       Units => $some_value, # WeightUnits
       Value =>  $some_value, # decimal
     },
     Packaging =>  $some_value, # string
     PackagingType => $some_value, # PackagingType
     PackageSequenceNumber =>  $some_value, # nonNegativeInteger
     PackageCount =>  $some_value, # nonNegativeInteger
     Charges =>  { # Shipment::FedEx::WSDL::TrackTypes::TrackChargeDetail
       Type => $some_value, # TrackChargeDetailType
       ChargeAmount =>  { # Shipment::FedEx::WSDL::TrackTypes::Money
         Currency =>  $some_value, # string
         Amount =>  $some_value, # decimal
       },
     },
     NickName =>  $some_value, # string
     Notes =>  $some_value, # string
     Attributes => $some_value, # TrackDetailAttributeType
     ShipmentContents =>  { # Shipment::FedEx::WSDL::TrackTypes::ContentRecord
       PartNumber =>  $some_value, # string
       ItemNumber =>  $some_value, # string
       ReceivedQuantity =>  $some_value, # nonNegativeInteger
       Description =>  $some_value, # string
     },
     PackageContents =>  $some_value, # string
     ClearanceLocationCode =>  $some_value, # string
     Commodities =>  { # Shipment::FedEx::WSDL::TrackTypes::Commodity
       CommodityId =>  $some_value, # string
       Name =>  $some_value, # string
       NumberOfPieces =>  $some_value, # nonNegativeInteger
       Description =>  $some_value, # string
       CountryOfManufacture =>  $some_value, # string
       HarmonizedCode =>  $some_value, # string
       Weight =>  { # Shipment::FedEx::WSDL::TrackTypes::Weight
         Units => $some_value, # WeightUnits
         Value =>  $some_value, # decimal
       },
       Quantity =>  $some_value, # decimal
       QuantityUnits =>  $some_value, # string
       AdditionalMeasures =>  { # Shipment::FedEx::WSDL::TrackTypes::Measure
         Quantity =>  $some_value, # decimal
         Units =>  $some_value, # string
       },
       UnitPrice =>  { # Shipment::FedEx::WSDL::TrackTypes::Money
         Currency =>  $some_value, # string
         Amount =>  $some_value, # decimal
       },
       CustomsValue =>  { # Shipment::FedEx::WSDL::TrackTypes::Money
         Currency =>  $some_value, # string
         Amount =>  $some_value, # decimal
       },
       ExciseConditions =>  { # Shipment::FedEx::WSDL::TrackTypes::EdtExciseCondition
         Category =>  $some_value, # string
         Value =>  $some_value, # string
       },
       ExportLicenseNumber =>  $some_value, # string
       ExportLicenseExpirationDate =>  $some_value, # date
       CIMarksAndNumbers =>  $some_value, # string
       PartNumber =>  $some_value, # string
       NaftaDetail =>  { # Shipment::FedEx::WSDL::TrackTypes::NaftaCommodityDetail
         PreferenceCriterion => $some_value, # NaftaPreferenceCriterionCode
         ProducerDetermination => $some_value, # NaftaProducerDeterminationCode
         ProducerId =>  $some_value, # string
         NetCostMethod => $some_value, # NaftaNetCostMethodCode
         NetCostDateRange =>  { # Shipment::FedEx::WSDL::TrackTypes::DateRange
           Begins =>  $some_value, # date
           Ends =>  $some_value, # date
         },
       },
     },
     ReturnDetail =>  { # Shipment::FedEx::WSDL::TrackTypes::TrackReturnDetail
       MovementStatus => $some_value, # TrackReturnMovementStatusType
       LabelType => $some_value, # TrackReturnLabelType
       Description =>  $some_value, # string
       AuthorizationName =>  $some_value, # string
     },
     CustomsOptionDetails =>  { # Shipment::FedEx::WSDL::TrackTypes::CustomsOptionDetail
       Type => $some_value, # CustomsOptionType
       Description =>  $some_value, # string
     },
     AdvanceNotificationDetail =>  { # Shipment::FedEx::WSDL::TrackTypes::TrackAdvanceNotificationDetail
       EstimatedTimeOfArrival =>  $some_value, # dateTime
       Reason =>  $some_value, # string
       Status => $some_value, # TrackAdvanceNotificationStatusType
       StatusDescription =>  $some_value, # string
       StatusTime =>  $some_value, # dateTime
     },
     SpecialHandlings =>  { # Shipment::FedEx::WSDL::TrackTypes::TrackSpecialHandling
       Type => $some_value, # TrackSpecialHandlingType
       Description =>  $some_value, # string
       PaymentType => $some_value, # TrackPaymentType
     },
     Shipper =>  { # Shipment::FedEx::WSDL::TrackTypes::Contact
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
     PossessionStatus => $some_value, # TrackPossessionStatusType
     ShipperAddress =>  { # Shipment::FedEx::WSDL::TrackTypes::Address
       StreetLines =>  $some_value, # string
       City =>  $some_value, # string
       StateOrProvinceCode =>  $some_value, # string
       PostalCode =>  $some_value, # string
       UrbanizationCode =>  $some_value, # string
       CountryCode =>  $some_value, # string
       CountryName =>  $some_value, # string
       Residential =>  $some_value, # boolean
     },
     OriginLocationAddress =>  { # Shipment::FedEx::WSDL::TrackTypes::Address
       StreetLines =>  $some_value, # string
       City =>  $some_value, # string
       StateOrProvinceCode =>  $some_value, # string
       PostalCode =>  $some_value, # string
       UrbanizationCode =>  $some_value, # string
       CountryCode =>  $some_value, # string
       CountryName =>  $some_value, # string
       Residential =>  $some_value, # boolean
     },
     OriginStationId =>  $some_value, # string
     EstimatedPickupTimestamp =>  $some_value, # dateTime
     ShipTimestamp =>  $some_value, # dateTime
     TotalTransitDistance =>  { # Shipment::FedEx::WSDL::TrackTypes::Distance
       Value =>  $some_value, # decimal
       Units => $some_value, # DistanceUnits
     },
     DistanceToDestination =>  { # Shipment::FedEx::WSDL::TrackTypes::Distance
       Value =>  $some_value, # decimal
       Units => $some_value, # DistanceUnits
     },
     SpecialInstructions =>  { # Shipment::FedEx::WSDL::TrackTypes::TrackSpecialInstruction
       Description =>  $some_value, # string
       DeliveryOption => $some_value, # TrackDeliveryOptionType
       StatusDetail =>  { # Shipment::FedEx::WSDL::TrackTypes::SpecialInstructionStatusDetail
         Status => $some_value, # SpecialInstructionsStatusCode
         StatusCreateTime =>  $some_value, # dateTime
       },
       OriginalEstimatedDeliveryTimestamp =>  $some_value, # dateTime
       OriginalRequestTime =>  $some_value, # dateTime
       RequestedAppointmentTime =>  { # Shipment::FedEx::WSDL::TrackTypes::AppointmentDetail
         Date =>  $some_value, # date
         WindowDetails =>  { # Shipment::FedEx::WSDL::TrackTypes::AppointmentTimeDetail
           Type => $some_value, # AppointmentWindowType
           Window =>  { # Shipment::FedEx::WSDL::TrackTypes::LocalTimeRange
             Begins =>  $some_value, # string
             Ends =>  $some_value, # string
           },
           Description =>  $some_value, # string
         },
       },
     },
     Recipient =>  { # Shipment::FedEx::WSDL::TrackTypes::Contact
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
     LastUpdatedDestinationAddress =>  { # Shipment::FedEx::WSDL::TrackTypes::Address
       StreetLines =>  $some_value, # string
       City =>  $some_value, # string
       StateOrProvinceCode =>  $some_value, # string
       PostalCode =>  $some_value, # string
       UrbanizationCode =>  $some_value, # string
       CountryCode =>  $some_value, # string
       CountryName =>  $some_value, # string
       Residential =>  $some_value, # boolean
     },
     DestinationAddress =>  { # Shipment::FedEx::WSDL::TrackTypes::Address
       StreetLines =>  $some_value, # string
       City =>  $some_value, # string
       StateOrProvinceCode =>  $some_value, # string
       PostalCode =>  $some_value, # string
       UrbanizationCode =>  $some_value, # string
       CountryCode =>  $some_value, # string
       CountryName =>  $some_value, # string
       Residential =>  $some_value, # boolean
     },
     HoldAtLocationContact =>  { # Shipment::FedEx::WSDL::TrackTypes::Contact
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
     HoldAtLocationAddress =>  { # Shipment::FedEx::WSDL::TrackTypes::Address
       StreetLines =>  $some_value, # string
       City =>  $some_value, # string
       StateOrProvinceCode =>  $some_value, # string
       PostalCode =>  $some_value, # string
       UrbanizationCode =>  $some_value, # string
       CountryCode =>  $some_value, # string
       CountryName =>  $some_value, # string
       Residential =>  $some_value, # boolean
     },
     DestinationStationId =>  $some_value, # string
     DestinationLocationAddress =>  { # Shipment::FedEx::WSDL::TrackTypes::Address
       StreetLines =>  $some_value, # string
       City =>  $some_value, # string
       StateOrProvinceCode =>  $some_value, # string
       PostalCode =>  $some_value, # string
       UrbanizationCode =>  $some_value, # string
       CountryCode =>  $some_value, # string
       CountryName =>  $some_value, # string
       Residential =>  $some_value, # boolean
     },
     DestinationLocationType => $some_value, # FedExLocationType
     DestinationLocationTimeZoneOffset =>  $some_value, # string
     CommitmentTimestamp =>  $some_value, # dateTime
     AppointmentDeliveryTimestamp =>  $some_value, # dateTime
     EstimatedDeliveryTimestamp =>  $some_value, # dateTime
     ActualDeliveryTimestamp =>  $some_value, # dateTime
     ActualDeliveryAddress =>  { # Shipment::FedEx::WSDL::TrackTypes::Address
       StreetLines =>  $some_value, # string
       City =>  $some_value, # string
       StateOrProvinceCode =>  $some_value, # string
       PostalCode =>  $some_value, # string
       UrbanizationCode =>  $some_value, # string
       CountryCode =>  $some_value, # string
       CountryName =>  $some_value, # string
       Residential =>  $some_value, # boolean
     },
     OfficeOrderDeliveryMethod => $some_value, # OfficeOrderDeliveryMethodType
     DeliveryLocationType => $some_value, # TrackDeliveryLocationType
     DeliveryLocationDescription =>  $some_value, # string
     DeliveryAttempts =>  $some_value, # nonNegativeInteger
     DeliverySignatureName =>  $some_value, # string
     PieceCountVerificationDetails =>  { # Shipment::FedEx::WSDL::TrackTypes::PieceCountVerificationDetail
       CountLocationType => $some_value, # PieceCountLocationType
       Count =>  $some_value, # nonNegativeInteger
       Description =>  $some_value, # string
     },
     TotalUniqueAddressCountInConsolidation =>  $some_value, # nonNegativeInteger
     AvailableImages => $some_value, # AvailableImageType
     Signature =>  { # Shipment::FedEx::WSDL::TrackTypes::SignatureImageDetail
       Image =>  $some_value, # base64Binary
       Notifications =>  { # Shipment::FedEx::WSDL::TrackTypes::Notification
         Severity => $some_value, # NotificationSeverityType
         Source =>  $some_value, # string
         Code =>  $some_value, # string
         Message =>  $some_value, # string
         LocalizedMessage =>  $some_value, # string
         MessageParameters =>  { # Shipment::FedEx::WSDL::TrackTypes::NotificationParameter
           Id =>  $some_value, # string
           Value =>  $some_value, # string
         },
       },
     },
     NotificationEventsAvailable => $some_value, # EMailNotificationEventType
     SplitShipmentParts =>  { # Shipment::FedEx::WSDL::TrackTypes::TrackSplitShipmentPart
       PieceCount =>  $some_value, # positiveInteger
       Timestamp =>  $some_value, # dateTime
       StatusCode =>  $some_value, # string
       StatusDescription =>  $some_value, # string
     },
     DeliveryOptionEligibilityDetails =>  { # Shipment::FedEx::WSDL::TrackTypes::DeliveryOptionEligibilityDetail
       Option => $some_value, # DeliveryOptionType
       Eligibility => $some_value, # EligibilityType
     },
     Events =>  { # Shipment::FedEx::WSDL::TrackTypes::TrackEvent
       Timestamp =>  $some_value, # dateTime
       EventType =>  $some_value, # string
       EventDescription =>  $some_value, # string
       StatusExceptionCode =>  $some_value, # string
       StatusExceptionDescription =>  $some_value, # string
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
       StationId =>  $some_value, # string
       ArrivalLocation => $some_value, # ArrivalLocationType
     },
   },
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

