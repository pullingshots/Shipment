package Shipment::FedEx::WSDL::TrackTypes::TrackDetail;
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

my %Notification_of :ATTR(:get<Notification>);
my %TrackingNumber_of :ATTR(:get<TrackingNumber>);
my %Barcode_of :ATTR(:get<Barcode>);
my %TrackingNumberUniqueIdentifier_of :ATTR(:get<TrackingNumberUniqueIdentifier>);
my %StatusDetail_of :ATTR(:get<StatusDetail>);
my %CustomerExceptionRequests_of :ATTR(:get<CustomerExceptionRequests>);
my %Reconciliation_of :ATTR(:get<Reconciliation>);
my %ServiceCommitMessage_of :ATTR(:get<ServiceCommitMessage>);
my %DestinationServiceArea_of :ATTR(:get<DestinationServiceArea>);
my %DestinationServiceAreaDescription_of :ATTR(:get<DestinationServiceAreaDescription>);
my %CarrierCode_of :ATTR(:get<CarrierCode>);
my %OperatingCompany_of :ATTR(:get<OperatingCompany>);
my %OperatingCompanyOrCarrierDescription_of :ATTR(:get<OperatingCompanyOrCarrierDescription>);
my %CartageAgentCompanyName_of :ATTR(:get<CartageAgentCompanyName>);
my %ProductionLocationContactAndAddress_of :ATTR(:get<ProductionLocationContactAndAddress>);
my %OtherIdentifiers_of :ATTR(:get<OtherIdentifiers>);
my %FormId_of :ATTR(:get<FormId>);
my %Service_of :ATTR(:get<Service>);
my %PackageWeight_of :ATTR(:get<PackageWeight>);
my %PackageDimensions_of :ATTR(:get<PackageDimensions>);
my %PackageDimensionalWeight_of :ATTR(:get<PackageDimensionalWeight>);
my %ShipmentWeight_of :ATTR(:get<ShipmentWeight>);
my %Packaging_of :ATTR(:get<Packaging>);
my %PackagingType_of :ATTR(:get<PackagingType>);
my %PackageSequenceNumber_of :ATTR(:get<PackageSequenceNumber>);
my %PackageCount_of :ATTR(:get<PackageCount>);
my %Charges_of :ATTR(:get<Charges>);
my %NickName_of :ATTR(:get<NickName>);
my %Notes_of :ATTR(:get<Notes>);
my %Attributes_of :ATTR(:get<Attributes>);
my %ShipmentContents_of :ATTR(:get<ShipmentContents>);
my %PackageContents_of :ATTR(:get<PackageContents>);
my %ClearanceLocationCode_of :ATTR(:get<ClearanceLocationCode>);
my %Commodities_of :ATTR(:get<Commodities>);
my %ReturnDetail_of :ATTR(:get<ReturnDetail>);
my %CustomsOptionDetails_of :ATTR(:get<CustomsOptionDetails>);
my %AdvanceNotificationDetail_of :ATTR(:get<AdvanceNotificationDetail>);
my %SpecialHandlings_of :ATTR(:get<SpecialHandlings>);
my %Shipper_of :ATTR(:get<Shipper>);
my %PossessionStatus_of :ATTR(:get<PossessionStatus>);
my %ShipperAddress_of :ATTR(:get<ShipperAddress>);
my %OriginLocationAddress_of :ATTR(:get<OriginLocationAddress>);
my %OriginStationId_of :ATTR(:get<OriginStationId>);
my %EstimatedPickupTimestamp_of :ATTR(:get<EstimatedPickupTimestamp>);
my %ShipTimestamp_of :ATTR(:get<ShipTimestamp>);
my %TotalTransitDistance_of :ATTR(:get<TotalTransitDistance>);
my %DistanceToDestination_of :ATTR(:get<DistanceToDestination>);
my %SpecialInstructions_of :ATTR(:get<SpecialInstructions>);
my %Recipient_of :ATTR(:get<Recipient>);
my %LastUpdatedDestinationAddress_of :ATTR(:get<LastUpdatedDestinationAddress>);
my %DestinationAddress_of :ATTR(:get<DestinationAddress>);
my %HoldAtLocationContact_of :ATTR(:get<HoldAtLocationContact>);
my %HoldAtLocationAddress_of :ATTR(:get<HoldAtLocationAddress>);
my %DestinationStationId_of :ATTR(:get<DestinationStationId>);
my %DestinationLocationAddress_of :ATTR(:get<DestinationLocationAddress>);
my %DestinationLocationType_of :ATTR(:get<DestinationLocationType>);
my %DestinationLocationTimeZoneOffset_of :ATTR(:get<DestinationLocationTimeZoneOffset>);
my %CommitmentTimestamp_of :ATTR(:get<CommitmentTimestamp>);
my %AppointmentDeliveryTimestamp_of :ATTR(:get<AppointmentDeliveryTimestamp>);
my %EstimatedDeliveryTimestamp_of :ATTR(:get<EstimatedDeliveryTimestamp>);
my %ActualDeliveryTimestamp_of :ATTR(:get<ActualDeliveryTimestamp>);
my %ActualDeliveryAddress_of :ATTR(:get<ActualDeliveryAddress>);
my %OfficeOrderDeliveryMethod_of :ATTR(:get<OfficeOrderDeliveryMethod>);
my %DeliveryLocationType_of :ATTR(:get<DeliveryLocationType>);
my %DeliveryLocationDescription_of :ATTR(:get<DeliveryLocationDescription>);
my %DeliveryAttempts_of :ATTR(:get<DeliveryAttempts>);
my %DeliverySignatureName_of :ATTR(:get<DeliverySignatureName>);
my %PieceCountVerificationDetails_of :ATTR(:get<PieceCountVerificationDetails>);
my %TotalUniqueAddressCountInConsolidation_of :ATTR(:get<TotalUniqueAddressCountInConsolidation>);
my %AvailableImages_of :ATTR(:get<AvailableImages>);
my %Signature_of :ATTR(:get<Signature>);
my %NotificationEventsAvailable_of :ATTR(:get<NotificationEventsAvailable>);
my %SplitShipmentParts_of :ATTR(:get<SplitShipmentParts>);
my %DeliveryOptionEligibilityDetails_of :ATTR(:get<DeliveryOptionEligibilityDetails>);
my %Events_of :ATTR(:get<Events>);

__PACKAGE__->_factory(
    [ qw(        Notification
        TrackingNumber
        Barcode
        TrackingNumberUniqueIdentifier
        StatusDetail
        CustomerExceptionRequests
        Reconciliation
        ServiceCommitMessage
        DestinationServiceArea
        DestinationServiceAreaDescription
        CarrierCode
        OperatingCompany
        OperatingCompanyOrCarrierDescription
        CartageAgentCompanyName
        ProductionLocationContactAndAddress
        OtherIdentifiers
        FormId
        Service
        PackageWeight
        PackageDimensions
        PackageDimensionalWeight
        ShipmentWeight
        Packaging
        PackagingType
        PackageSequenceNumber
        PackageCount
        Charges
        NickName
        Notes
        Attributes
        ShipmentContents
        PackageContents
        ClearanceLocationCode
        Commodities
        ReturnDetail
        CustomsOptionDetails
        AdvanceNotificationDetail
        SpecialHandlings
        Shipper
        PossessionStatus
        ShipperAddress
        OriginLocationAddress
        OriginStationId
        EstimatedPickupTimestamp
        ShipTimestamp
        TotalTransitDistance
        DistanceToDestination
        SpecialInstructions
        Recipient
        LastUpdatedDestinationAddress
        DestinationAddress
        HoldAtLocationContact
        HoldAtLocationAddress
        DestinationStationId
        DestinationLocationAddress
        DestinationLocationType
        DestinationLocationTimeZoneOffset
        CommitmentTimestamp
        AppointmentDeliveryTimestamp
        EstimatedDeliveryTimestamp
        ActualDeliveryTimestamp
        ActualDeliveryAddress
        OfficeOrderDeliveryMethod
        DeliveryLocationType
        DeliveryLocationDescription
        DeliveryAttempts
        DeliverySignatureName
        PieceCountVerificationDetails
        TotalUniqueAddressCountInConsolidation
        AvailableImages
        Signature
        NotificationEventsAvailable
        SplitShipmentParts
        DeliveryOptionEligibilityDetails
        Events

    ) ],
    {
        'Notification' => \%Notification_of,
        'TrackingNumber' => \%TrackingNumber_of,
        'Barcode' => \%Barcode_of,
        'TrackingNumberUniqueIdentifier' => \%TrackingNumberUniqueIdentifier_of,
        'StatusDetail' => \%StatusDetail_of,
        'CustomerExceptionRequests' => \%CustomerExceptionRequests_of,
        'Reconciliation' => \%Reconciliation_of,
        'ServiceCommitMessage' => \%ServiceCommitMessage_of,
        'DestinationServiceArea' => \%DestinationServiceArea_of,
        'DestinationServiceAreaDescription' => \%DestinationServiceAreaDescription_of,
        'CarrierCode' => \%CarrierCode_of,
        'OperatingCompany' => \%OperatingCompany_of,
        'OperatingCompanyOrCarrierDescription' => \%OperatingCompanyOrCarrierDescription_of,
        'CartageAgentCompanyName' => \%CartageAgentCompanyName_of,
        'ProductionLocationContactAndAddress' => \%ProductionLocationContactAndAddress_of,
        'OtherIdentifiers' => \%OtherIdentifiers_of,
        'FormId' => \%FormId_of,
        'Service' => \%Service_of,
        'PackageWeight' => \%PackageWeight_of,
        'PackageDimensions' => \%PackageDimensions_of,
        'PackageDimensionalWeight' => \%PackageDimensionalWeight_of,
        'ShipmentWeight' => \%ShipmentWeight_of,
        'Packaging' => \%Packaging_of,
        'PackagingType' => \%PackagingType_of,
        'PackageSequenceNumber' => \%PackageSequenceNumber_of,
        'PackageCount' => \%PackageCount_of,
        'Charges' => \%Charges_of,
        'NickName' => \%NickName_of,
        'Notes' => \%Notes_of,
        'Attributes' => \%Attributes_of,
        'ShipmentContents' => \%ShipmentContents_of,
        'PackageContents' => \%PackageContents_of,
        'ClearanceLocationCode' => \%ClearanceLocationCode_of,
        'Commodities' => \%Commodities_of,
        'ReturnDetail' => \%ReturnDetail_of,
        'CustomsOptionDetails' => \%CustomsOptionDetails_of,
        'AdvanceNotificationDetail' => \%AdvanceNotificationDetail_of,
        'SpecialHandlings' => \%SpecialHandlings_of,
        'Shipper' => \%Shipper_of,
        'PossessionStatus' => \%PossessionStatus_of,
        'ShipperAddress' => \%ShipperAddress_of,
        'OriginLocationAddress' => \%OriginLocationAddress_of,
        'OriginStationId' => \%OriginStationId_of,
        'EstimatedPickupTimestamp' => \%EstimatedPickupTimestamp_of,
        'ShipTimestamp' => \%ShipTimestamp_of,
        'TotalTransitDistance' => \%TotalTransitDistance_of,
        'DistanceToDestination' => \%DistanceToDestination_of,
        'SpecialInstructions' => \%SpecialInstructions_of,
        'Recipient' => \%Recipient_of,
        'LastUpdatedDestinationAddress' => \%LastUpdatedDestinationAddress_of,
        'DestinationAddress' => \%DestinationAddress_of,
        'HoldAtLocationContact' => \%HoldAtLocationContact_of,
        'HoldAtLocationAddress' => \%HoldAtLocationAddress_of,
        'DestinationStationId' => \%DestinationStationId_of,
        'DestinationLocationAddress' => \%DestinationLocationAddress_of,
        'DestinationLocationType' => \%DestinationLocationType_of,
        'DestinationLocationTimeZoneOffset' => \%DestinationLocationTimeZoneOffset_of,
        'CommitmentTimestamp' => \%CommitmentTimestamp_of,
        'AppointmentDeliveryTimestamp' => \%AppointmentDeliveryTimestamp_of,
        'EstimatedDeliveryTimestamp' => \%EstimatedDeliveryTimestamp_of,
        'ActualDeliveryTimestamp' => \%ActualDeliveryTimestamp_of,
        'ActualDeliveryAddress' => \%ActualDeliveryAddress_of,
        'OfficeOrderDeliveryMethod' => \%OfficeOrderDeliveryMethod_of,
        'DeliveryLocationType' => \%DeliveryLocationType_of,
        'DeliveryLocationDescription' => \%DeliveryLocationDescription_of,
        'DeliveryAttempts' => \%DeliveryAttempts_of,
        'DeliverySignatureName' => \%DeliverySignatureName_of,
        'PieceCountVerificationDetails' => \%PieceCountVerificationDetails_of,
        'TotalUniqueAddressCountInConsolidation' => \%TotalUniqueAddressCountInConsolidation_of,
        'AvailableImages' => \%AvailableImages_of,
        'Signature' => \%Signature_of,
        'NotificationEventsAvailable' => \%NotificationEventsAvailable_of,
        'SplitShipmentParts' => \%SplitShipmentParts_of,
        'DeliveryOptionEligibilityDetails' => \%DeliveryOptionEligibilityDetails_of,
        'Events' => \%Events_of,
    },
    {
        'Notification' => 'Shipment::FedEx::WSDL::TrackTypes::Notification',
        'TrackingNumber' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'Barcode' => 'Shipment::FedEx::WSDL::TrackTypes::StringBarcode',
        'TrackingNumberUniqueIdentifier' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'StatusDetail' => 'Shipment::FedEx::WSDL::TrackTypes::TrackStatusDetail',
        'CustomerExceptionRequests' => 'Shipment::FedEx::WSDL::TrackTypes::CustomerExceptionRequestDetail',
        'Reconciliation' => 'Shipment::FedEx::WSDL::TrackTypes::TrackReconciliation',
        'ServiceCommitMessage' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'DestinationServiceArea' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'DestinationServiceAreaDescription' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'CarrierCode' => 'Shipment::FedEx::WSDL::TrackTypes::CarrierCodeType',
        'OperatingCompany' => 'Shipment::FedEx::WSDL::TrackTypes::OperatingCompanyType',
        'OperatingCompanyOrCarrierDescription' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'CartageAgentCompanyName' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'ProductionLocationContactAndAddress' => 'Shipment::FedEx::WSDL::TrackTypes::ContactAndAddress',
        'OtherIdentifiers' => 'Shipment::FedEx::WSDL::TrackTypes::TrackOtherIdentifierDetail',
        'FormId' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'Service' => 'Shipment::FedEx::WSDL::TrackTypes::TrackServiceDescriptionDetail',
        'PackageWeight' => 'Shipment::FedEx::WSDL::TrackTypes::Weight',
        'PackageDimensions' => 'Shipment::FedEx::WSDL::TrackTypes::Dimensions',
        'PackageDimensionalWeight' => 'Shipment::FedEx::WSDL::TrackTypes::Weight',
        'ShipmentWeight' => 'Shipment::FedEx::WSDL::TrackTypes::Weight',
        'Packaging' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'PackagingType' => 'Shipment::FedEx::WSDL::TrackTypes::PackagingType',
        'PackageSequenceNumber' => 'SOAP::WSDL::XSD::Typelib::Builtin::nonNegativeInteger',
        'PackageCount' => 'SOAP::WSDL::XSD::Typelib::Builtin::nonNegativeInteger',
        'Charges' => 'Shipment::FedEx::WSDL::TrackTypes::TrackChargeDetail',
        'NickName' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'Notes' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'Attributes' => 'Shipment::FedEx::WSDL::TrackTypes::TrackDetailAttributeType',
        'ShipmentContents' => 'Shipment::FedEx::WSDL::TrackTypes::ContentRecord',
        'PackageContents' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'ClearanceLocationCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'Commodities' => 'Shipment::FedEx::WSDL::TrackTypes::Commodity',
        'ReturnDetail' => 'Shipment::FedEx::WSDL::TrackTypes::TrackReturnDetail',
        'CustomsOptionDetails' => 'Shipment::FedEx::WSDL::TrackTypes::CustomsOptionDetail',
        'AdvanceNotificationDetail' => 'Shipment::FedEx::WSDL::TrackTypes::TrackAdvanceNotificationDetail',
        'SpecialHandlings' => 'Shipment::FedEx::WSDL::TrackTypes::TrackSpecialHandling',
        'Shipper' => 'Shipment::FedEx::WSDL::TrackTypes::Contact',
        'PossessionStatus' => 'Shipment::FedEx::WSDL::TrackTypes::TrackPossessionStatusType',
        'ShipperAddress' => 'Shipment::FedEx::WSDL::TrackTypes::Address',
        'OriginLocationAddress' => 'Shipment::FedEx::WSDL::TrackTypes::Address',
        'OriginStationId' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'EstimatedPickupTimestamp' => 'SOAP::WSDL::XSD::Typelib::Builtin::dateTime',
        'ShipTimestamp' => 'SOAP::WSDL::XSD::Typelib::Builtin::dateTime',
        'TotalTransitDistance' => 'Shipment::FedEx::WSDL::TrackTypes::Distance',
        'DistanceToDestination' => 'Shipment::FedEx::WSDL::TrackTypes::Distance',
        'SpecialInstructions' => 'Shipment::FedEx::WSDL::TrackTypes::TrackSpecialInstruction',
        'Recipient' => 'Shipment::FedEx::WSDL::TrackTypes::Contact',
        'LastUpdatedDestinationAddress' => 'Shipment::FedEx::WSDL::TrackTypes::Address',
        'DestinationAddress' => 'Shipment::FedEx::WSDL::TrackTypes::Address',
        'HoldAtLocationContact' => 'Shipment::FedEx::WSDL::TrackTypes::Contact',
        'HoldAtLocationAddress' => 'Shipment::FedEx::WSDL::TrackTypes::Address',
        'DestinationStationId' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'DestinationLocationAddress' => 'Shipment::FedEx::WSDL::TrackTypes::Address',
        'DestinationLocationType' => 'Shipment::FedEx::WSDL::TrackTypes::FedExLocationType',
        'DestinationLocationTimeZoneOffset' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'CommitmentTimestamp' => 'SOAP::WSDL::XSD::Typelib::Builtin::dateTime',
        'AppointmentDeliveryTimestamp' => 'SOAP::WSDL::XSD::Typelib::Builtin::dateTime',
        'EstimatedDeliveryTimestamp' => 'SOAP::WSDL::XSD::Typelib::Builtin::dateTime',
        'ActualDeliveryTimestamp' => 'SOAP::WSDL::XSD::Typelib::Builtin::dateTime',
        'ActualDeliveryAddress' => 'Shipment::FedEx::WSDL::TrackTypes::Address',
        'OfficeOrderDeliveryMethod' => 'Shipment::FedEx::WSDL::TrackTypes::OfficeOrderDeliveryMethodType',
        'DeliveryLocationType' => 'Shipment::FedEx::WSDL::TrackTypes::TrackDeliveryLocationType',
        'DeliveryLocationDescription' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'DeliveryAttempts' => 'SOAP::WSDL::XSD::Typelib::Builtin::nonNegativeInteger',
        'DeliverySignatureName' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'PieceCountVerificationDetails' => 'Shipment::FedEx::WSDL::TrackTypes::PieceCountVerificationDetail',
        'TotalUniqueAddressCountInConsolidation' => 'SOAP::WSDL::XSD::Typelib::Builtin::nonNegativeInteger',
        'AvailableImages' => 'Shipment::FedEx::WSDL::TrackTypes::AvailableImageType',
        'Signature' => 'Shipment::FedEx::WSDL::TrackTypes::SignatureImageDetail',
        'NotificationEventsAvailable' => 'Shipment::FedEx::WSDL::TrackTypes::EMailNotificationEventType',
        'SplitShipmentParts' => 'Shipment::FedEx::WSDL::TrackTypes::TrackSplitShipmentPart',
        'DeliveryOptionEligibilityDetails' => 'Shipment::FedEx::WSDL::TrackTypes::DeliveryOptionEligibilityDetail',
        'Events' => 'Shipment::FedEx::WSDL::TrackTypes::TrackEvent',
    },
    {

        'Notification' => 'Notification',
        'TrackingNumber' => 'TrackingNumber',
        'Barcode' => 'Barcode',
        'TrackingNumberUniqueIdentifier' => 'TrackingNumberUniqueIdentifier',
        'StatusDetail' => 'StatusDetail',
        'CustomerExceptionRequests' => 'CustomerExceptionRequests',
        'Reconciliation' => 'Reconciliation',
        'ServiceCommitMessage' => 'ServiceCommitMessage',
        'DestinationServiceArea' => 'DestinationServiceArea',
        'DestinationServiceAreaDescription' => 'DestinationServiceAreaDescription',
        'CarrierCode' => 'CarrierCode',
        'OperatingCompany' => 'OperatingCompany',
        'OperatingCompanyOrCarrierDescription' => 'OperatingCompanyOrCarrierDescription',
        'CartageAgentCompanyName' => 'CartageAgentCompanyName',
        'ProductionLocationContactAndAddress' => 'ProductionLocationContactAndAddress',
        'OtherIdentifiers' => 'OtherIdentifiers',
        'FormId' => 'FormId',
        'Service' => 'Service',
        'PackageWeight' => 'PackageWeight',
        'PackageDimensions' => 'PackageDimensions',
        'PackageDimensionalWeight' => 'PackageDimensionalWeight',
        'ShipmentWeight' => 'ShipmentWeight',
        'Packaging' => 'Packaging',
        'PackagingType' => 'PackagingType',
        'PackageSequenceNumber' => 'PackageSequenceNumber',
        'PackageCount' => 'PackageCount',
        'Charges' => 'Charges',
        'NickName' => 'NickName',
        'Notes' => 'Notes',
        'Attributes' => 'Attributes',
        'ShipmentContents' => 'ShipmentContents',
        'PackageContents' => 'PackageContents',
        'ClearanceLocationCode' => 'ClearanceLocationCode',
        'Commodities' => 'Commodities',
        'ReturnDetail' => 'ReturnDetail',
        'CustomsOptionDetails' => 'CustomsOptionDetails',
        'AdvanceNotificationDetail' => 'AdvanceNotificationDetail',
        'SpecialHandlings' => 'SpecialHandlings',
        'Shipper' => 'Shipper',
        'PossessionStatus' => 'PossessionStatus',
        'ShipperAddress' => 'ShipperAddress',
        'OriginLocationAddress' => 'OriginLocationAddress',
        'OriginStationId' => 'OriginStationId',
        'EstimatedPickupTimestamp' => 'EstimatedPickupTimestamp',
        'ShipTimestamp' => 'ShipTimestamp',
        'TotalTransitDistance' => 'TotalTransitDistance',
        'DistanceToDestination' => 'DistanceToDestination',
        'SpecialInstructions' => 'SpecialInstructions',
        'Recipient' => 'Recipient',
        'LastUpdatedDestinationAddress' => 'LastUpdatedDestinationAddress',
        'DestinationAddress' => 'DestinationAddress',
        'HoldAtLocationContact' => 'HoldAtLocationContact',
        'HoldAtLocationAddress' => 'HoldAtLocationAddress',
        'DestinationStationId' => 'DestinationStationId',
        'DestinationLocationAddress' => 'DestinationLocationAddress',
        'DestinationLocationType' => 'DestinationLocationType',
        'DestinationLocationTimeZoneOffset' => 'DestinationLocationTimeZoneOffset',
        'CommitmentTimestamp' => 'CommitmentTimestamp',
        'AppointmentDeliveryTimestamp' => 'AppointmentDeliveryTimestamp',
        'EstimatedDeliveryTimestamp' => 'EstimatedDeliveryTimestamp',
        'ActualDeliveryTimestamp' => 'ActualDeliveryTimestamp',
        'ActualDeliveryAddress' => 'ActualDeliveryAddress',
        'OfficeOrderDeliveryMethod' => 'OfficeOrderDeliveryMethod',
        'DeliveryLocationType' => 'DeliveryLocationType',
        'DeliveryLocationDescription' => 'DeliveryLocationDescription',
        'DeliveryAttempts' => 'DeliveryAttempts',
        'DeliverySignatureName' => 'DeliverySignatureName',
        'PieceCountVerificationDetails' => 'PieceCountVerificationDetails',
        'TotalUniqueAddressCountInConsolidation' => 'TotalUniqueAddressCountInConsolidation',
        'AvailableImages' => 'AvailableImages',
        'Signature' => 'Signature',
        'NotificationEventsAvailable' => 'NotificationEventsAvailable',
        'SplitShipmentParts' => 'SplitShipmentParts',
        'DeliveryOptionEligibilityDetails' => 'DeliveryOptionEligibilityDetails',
        'Events' => 'Events',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::FedEx::WSDL::TrackTypes::TrackDetail

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
TrackDetail from the namespace http://fedex.com/ws/track/v9.

Detailed tracking information about a particular package.




=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * Notification


=item * TrackingNumber


=item * Barcode


=item * TrackingNumberUniqueIdentifier


=item * StatusDetail


=item * CustomerExceptionRequests


=item * Reconciliation


=item * ServiceCommitMessage


=item * DestinationServiceArea


=item * DestinationServiceAreaDescription


=item * CarrierCode


=item * OperatingCompany


=item * OperatingCompanyOrCarrierDescription


=item * CartageAgentCompanyName


=item * ProductionLocationContactAndAddress


=item * OtherIdentifiers


=item * FormId


=item * Service


=item * PackageWeight


=item * PackageDimensions


=item * PackageDimensionalWeight


=item * ShipmentWeight


=item * Packaging


=item * PackagingType


=item * PackageSequenceNumber


=item * PackageCount


=item * Charges


=item * NickName


=item * Notes


=item * Attributes


=item * ShipmentContents


=item * PackageContents


=item * ClearanceLocationCode


=item * Commodities


=item * ReturnDetail


=item * CustomsOptionDetails


=item * AdvanceNotificationDetail


=item * SpecialHandlings


=item * Shipper


=item * PossessionStatus


=item * ShipperAddress


=item * OriginLocationAddress


=item * OriginStationId


=item * EstimatedPickupTimestamp


=item * ShipTimestamp


=item * TotalTransitDistance


=item * DistanceToDestination


=item * SpecialInstructions


=item * Recipient


=item * LastUpdatedDestinationAddress


=item * DestinationAddress


=item * HoldAtLocationContact


=item * HoldAtLocationAddress


=item * DestinationStationId


=item * DestinationLocationAddress


=item * DestinationLocationType


=item * DestinationLocationTimeZoneOffset


=item * CommitmentTimestamp


=item * AppointmentDeliveryTimestamp


=item * EstimatedDeliveryTimestamp


=item * ActualDeliveryTimestamp


=item * ActualDeliveryAddress


=item * OfficeOrderDeliveryMethod


=item * DeliveryLocationType


=item * DeliveryLocationDescription


=item * DeliveryAttempts


=item * DeliverySignatureName


=item * PieceCountVerificationDetails


=item * TotalUniqueAddressCountInConsolidation


=item * AvailableImages


=item * Signature


=item * NotificationEventsAvailable


=item * SplitShipmentParts


=item * DeliveryOptionEligibilityDetails


=item * Events




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::FedEx::WSDL::TrackTypes::TrackDetail
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




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

