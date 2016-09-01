package Shipment::UPS::WSDL::TrackTypes::ShipmentType;
use strict;
use warnings;


__PACKAGE__->_set_element_form_qualified(1);

sub get_xmlns { 'http://www.ups.com/XMLSchema/XOLTWS/Track/v2.0' };

our $XML_ATTRIBUTE_CLASS;
undef $XML_ATTRIBUTE_CLASS;

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}

use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %InquiryNumber_of :ATTR(:get<InquiryNumber>);
my %ShipmentType_of :ATTR(:get<ShipmentType>);
my %CandidateBookmark_of :ATTR(:get<CandidateBookmark>);
my %ShipperNumber_of :ATTR(:get<ShipperNumber>);
my %ShipmentAddress_of :ATTR(:get<ShipmentAddress>);
my %ShipmentWeight_of :ATTR(:get<ShipmentWeight>);
my %Service_of :ATTR(:get<Service>);
my %ReferenceNumber_of :ATTR(:get<ReferenceNumber>);
my %CurrentStatus_of :ATTR(:get<CurrentStatus>);
my %PickupDate_of :ATTR(:get<PickupDate>);
my %ServiceCenter_of :ATTR(:get<ServiceCenter>);
my %DeliveryDetail_of :ATTR(:get<DeliveryDetail>);
my %Volume_of :ATTR(:get<Volume>);
my %BillToName_of :ATTR(:get<BillToName>);
my %NumberOfPackagingUnit_of :ATTR(:get<NumberOfPackagingUnit>);
my %ShipmentServiceOption_of :ATTR(:get<ShipmentServiceOption>);
my %COD_of :ATTR(:get<COD>);
my %SignedForByName_of :ATTR(:get<SignedForByName>);
my %Activity_of :ATTR(:get<Activity>);
my %OriginPortDetail_of :ATTR(:get<OriginPortDetail>);
my %DestinationPortDetail_of :ATTR(:get<DestinationPortDetail>);
my %DescriptionOfGoods_of :ATTR(:get<DescriptionOfGoods>);
my %CargoReady_of :ATTR(:get<CargoReady>);
my %Manifest_of :ATTR(:get<Manifest>);
my %CarrierActivityInformation_of :ATTR(:get<CarrierActivityInformation>);
my %Document_of :ATTR(:get<Document>);
my %FileNumber_of :ATTR(:get<FileNumber>);
my %Appointment_of :ATTR(:get<Appointment>);
my %Package_of :ATTR(:get<Package>);
my %AdditionalAttribute_of :ATTR(:get<AdditionalAttribute>);

__PACKAGE__->_factory(
    [ qw(        InquiryNumber
        ShipmentType
        CandidateBookmark
        ShipperNumber
        ShipmentAddress
        ShipmentWeight
        Service
        ReferenceNumber
        CurrentStatus
        PickupDate
        ServiceCenter
        DeliveryDetail
        Volume
        BillToName
        NumberOfPackagingUnit
        ShipmentServiceOption
        COD
        SignedForByName
        Activity
        OriginPortDetail
        DestinationPortDetail
        DescriptionOfGoods
        CargoReady
        Manifest
        CarrierActivityInformation
        Document
        FileNumber
        Appointment
        Package
        AdditionalAttribute

    ) ],
    {
        'InquiryNumber' => \%InquiryNumber_of,
        'ShipmentType' => \%ShipmentType_of,
        'CandidateBookmark' => \%CandidateBookmark_of,
        'ShipperNumber' => \%ShipperNumber_of,
        'ShipmentAddress' => \%ShipmentAddress_of,
        'ShipmentWeight' => \%ShipmentWeight_of,
        'Service' => \%Service_of,
        'ReferenceNumber' => \%ReferenceNumber_of,
        'CurrentStatus' => \%CurrentStatus_of,
        'PickupDate' => \%PickupDate_of,
        'ServiceCenter' => \%ServiceCenter_of,
        'DeliveryDetail' => \%DeliveryDetail_of,
        'Volume' => \%Volume_of,
        'BillToName' => \%BillToName_of,
        'NumberOfPackagingUnit' => \%NumberOfPackagingUnit_of,
        'ShipmentServiceOption' => \%ShipmentServiceOption_of,
        'COD' => \%COD_of,
        'SignedForByName' => \%SignedForByName_of,
        'Activity' => \%Activity_of,
        'OriginPortDetail' => \%OriginPortDetail_of,
        'DestinationPortDetail' => \%DestinationPortDetail_of,
        'DescriptionOfGoods' => \%DescriptionOfGoods_of,
        'CargoReady' => \%CargoReady_of,
        'Manifest' => \%Manifest_of,
        'CarrierActivityInformation' => \%CarrierActivityInformation_of,
        'Document' => \%Document_of,
        'FileNumber' => \%FileNumber_of,
        'Appointment' => \%Appointment_of,
        'Package' => \%Package_of,
        'AdditionalAttribute' => \%AdditionalAttribute_of,
    },
    {
        'InquiryNumber' => 'Shipment::UPS::WSDL::TrackTypes::CodeDescriptionValueType',
        'ShipmentType' => 'Shipment::UPS::WSDL::TrackTypes::RefShipmentType',
        'CandidateBookmark' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'ShipperNumber' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'ShipmentAddress' => 'Shipment::UPS::WSDL::TrackTypes::ShipmentAddressType',
        'ShipmentWeight' => 'Shipment::UPS::WSDL::TrackTypes::WeightType',
        'Service' => 'Shipment::UPS::WSDL::TrackTypes::ServiceType',
        'ReferenceNumber' => 'Shipment::UPS::WSDL::TrackTypes::ShipmentReferenceNumberType',
        'CurrentStatus' => 'Shipment::UPS::WSDL::TrackTypes::CommonCodeDescriptionType',
        'PickupDate' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'ServiceCenter' => 'Shipment::UPS::WSDL::TrackTypes::ServiceCenterType',
        'DeliveryDetail' => 'Shipment::UPS::WSDL::TrackTypes::DeliveryDetailType',
        'Volume' => 'Shipment::UPS::WSDL::TrackTypes::VolumeType',
        'BillToName' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'NumberOfPackagingUnit' => 'Shipment::UPS::WSDL::TrackTypes::NumberOfPackagingUnitType',
        'ShipmentServiceOption' => 'Shipment::UPS::WSDL::TrackTypes::ServiceOptionType',
        'COD' => 'Shipment::UPS::WSDL::TrackTypes::CODType',
        'SignedForByName' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'Activity' => 'Shipment::UPS::WSDL::TrackTypes::ShipmentActivityType',
        'OriginPortDetail' => 'Shipment::UPS::WSDL::TrackTypes::OriginPortDetailType',
        'DestinationPortDetail' => 'Shipment::UPS::WSDL::TrackTypes::DestinationPortDetailType',
        'DescriptionOfGoods' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'CargoReady' => 'Shipment::UPS::WSDL::TrackTypes::DateTimeType',
        'Manifest' => 'Shipment::UPS::WSDL::TrackTypes::DateTimeType',
        'CarrierActivityInformation' => 'Shipment::UPS::WSDL::TrackTypes::CarrierActivityInformationType',
        'Document' => 'Shipment::UPS::WSDL::TrackTypes::DocumentType',
        'FileNumber' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'Appointment' => 'Shipment::UPS::WSDL::TrackTypes::AppointmentType',
        'Package' => 'Shipment::UPS::WSDL::TrackTypes::PackageType',
        'AdditionalAttribute' => 'Shipment::UPS::WSDL::TrackTypes::AdditionalCodeDescriptionValueType',
    },
    {

        'InquiryNumber' => 'InquiryNumber',
        'ShipmentType' => 'ShipmentType',
        'CandidateBookmark' => 'CandidateBookmark',
        'ShipperNumber' => 'ShipperNumber',
        'ShipmentAddress' => 'ShipmentAddress',
        'ShipmentWeight' => 'ShipmentWeight',
        'Service' => 'Service',
        'ReferenceNumber' => 'ReferenceNumber',
        'CurrentStatus' => 'CurrentStatus',
        'PickupDate' => 'PickupDate',
        'ServiceCenter' => 'ServiceCenter',
        'DeliveryDetail' => 'DeliveryDetail',
        'Volume' => 'Volume',
        'BillToName' => 'BillToName',
        'NumberOfPackagingUnit' => 'NumberOfPackagingUnit',
        'ShipmentServiceOption' => 'ShipmentServiceOption',
        'COD' => 'COD',
        'SignedForByName' => 'SignedForByName',
        'Activity' => 'Activity',
        'OriginPortDetail' => 'OriginPortDetail',
        'DestinationPortDetail' => 'DestinationPortDetail',
        'DescriptionOfGoods' => 'DescriptionOfGoods',
        'CargoReady' => 'CargoReady',
        'Manifest' => 'Manifest',
        'CarrierActivityInformation' => 'CarrierActivityInformation',
        'Document' => 'Document',
        'FileNumber' => 'FileNumber',
        'Appointment' => 'Appointment',
        'Package' => 'Package',
        'AdditionalAttribute' => 'AdditionalAttribute',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::UPS::WSDL::TrackTypes::ShipmentType

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
ShipmentType from the namespace http://www.ups.com/XMLSchema/XOLTWS/Track/v2.0.






=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * InquiryNumber


=item * ShipmentType


=item * CandidateBookmark


=item * ShipperNumber


=item * ShipmentAddress


=item * ShipmentWeight


=item * Service


=item * ReferenceNumber


=item * CurrentStatus


=item * PickupDate


=item * ServiceCenter


=item * DeliveryDetail


=item * Volume


=item * BillToName


=item * NumberOfPackagingUnit


=item * ShipmentServiceOption


=item * COD


=item * SignedForByName


=item * Activity


=item * OriginPortDetail


=item * DestinationPortDetail


=item * DescriptionOfGoods


=item * CargoReady


=item * Manifest


=item * CarrierActivityInformation


=item * Document


=item * FileNumber


=item * Appointment


=item * Package


=item * AdditionalAttribute




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::UPS::WSDL::TrackTypes::ShipmentType
   InquiryNumber =>  { # Shipment::UPS::WSDL::TrackTypes::CodeDescriptionValueType
     Code =>  $some_value, # string
     Description =>  $some_value, # string
     Value =>  $some_value, # string
   },
   ShipmentType =>  { # Shipment::UPS::WSDL::TrackTypes::RefShipmentType
     Code =>  $some_value, # string
     Description =>  $some_value, # string
   },
   CandidateBookmark =>  $some_value, # string
   ShipperNumber =>  $some_value, # string
   ShipmentAddress =>  { # Shipment::UPS::WSDL::TrackTypes::ShipmentAddressType
     Type =>  { # Shipment::UPS::WSDL::TrackTypes::CommonCodeDescriptionType
       Code =>  $some_value, # string
       Description =>  $some_value, # string
     },
     Address =>  { # Shipment::UPS::WSDL::TrackTypes::AddressType
       AddressLine =>  $some_value, # string
       City =>  $some_value, # string
       StateProvinceCode =>  $some_value, # string
       PostalCode =>  $some_value, # string
       CountryCode =>  $some_value, # string
     },
   },
   ShipmentWeight =>  { # Shipment::UPS::WSDL::TrackTypes::WeightType
     UnitOfMeasurement =>  { # Shipment::UPS::WSDL::TrackTypes::UnitOfMeasurementType
       Code =>  $some_value, # string
       Description =>  $some_value, # string
     },
     Weight =>  $some_value, # string
   },
   Service =>  { # Shipment::UPS::WSDL::TrackTypes::ServiceType
     Code =>  $some_value, # string
     Description =>  $some_value, # string
   },
   ReferenceNumber =>  { # Shipment::UPS::WSDL::TrackTypes::ShipmentReferenceNumberType
     Code =>  $some_value, # string
     Description =>  $some_value, # string
     Value =>  $some_value, # string
   },
   CurrentStatus =>  { # Shipment::UPS::WSDL::TrackTypes::CommonCodeDescriptionType
     Code =>  $some_value, # string
     Description =>  $some_value, # string
   },
   PickupDate =>  $some_value, # string
   ServiceCenter =>  { # Shipment::UPS::WSDL::TrackTypes::ServiceCenterType
     Type =>  { # Shipment::UPS::WSDL::TrackTypes::CommonCodeDescriptionType
       Code =>  $some_value, # string
       Description =>  $some_value, # string
     },
     Name =>  $some_value, # string
     Address =>  { # Shipment::UPS::WSDL::TrackTypes::AddressType
       AddressLine =>  $some_value, # string
       City =>  $some_value, # string
       StateProvinceCode =>  $some_value, # string
       PostalCode =>  $some_value, # string
       CountryCode =>  $some_value, # string
     },
   },
   DeliveryDetail =>  { # Shipment::UPS::WSDL::TrackTypes::DeliveryDetailType
     Type =>  { # Shipment::UPS::WSDL::TrackTypes::CommonCodeDescriptionType
       Code =>  $some_value, # string
       Description =>  $some_value, # string
     },
     Date =>  $some_value, # string
     Time =>  $some_value, # string
   },
   Volume =>  { # Shipment::UPS::WSDL::TrackTypes::VolumeType
     UnitOfMeasurement =>  { # Shipment::UPS::WSDL::TrackTypes::UnitOfMeasurementType
       Code =>  $some_value, # string
       Description =>  $some_value, # string
     },
     Value =>  $some_value, # string
   },
   BillToName =>  $some_value, # string
   NumberOfPackagingUnit =>  { # Shipment::UPS::WSDL::TrackTypes::NumberOfPackagingUnitType
     Type =>  { # Shipment::UPS::WSDL::TrackTypes::CommonCodeDescriptionType
       Code =>  $some_value, # string
       Description =>  $some_value, # string
     },
     Value =>  $some_value, # string
   },
   ShipmentServiceOption =>  { # Shipment::UPS::WSDL::TrackTypes::ServiceOptionType
     Type =>  { # Shipment::UPS::WSDL::TrackTypes::CommonCodeDescriptionType
       Code =>  $some_value, # string
       Description =>  $some_value, # string
     },
     Value =>  $some_value, # string
     AdditionalAttribute =>  { # Shipment::UPS::WSDL::TrackTypes::AdditionalCodeDescriptionValueType
       Code =>  $some_value, # string
       Description =>  $some_value, # string
       Value =>  $some_value, # string
     },
   },
   COD =>  { # Shipment::UPS::WSDL::TrackTypes::CODType
     Amount =>  { # Shipment::UPS::WSDL::TrackTypes::AmountType
       CurrencyCode =>  $some_value, # string
       MonetaryValue =>  $some_value, # string
     },
     Status =>  { # Shipment::UPS::WSDL::TrackTypes::CODStatusType
       Code =>  $some_value, # string
       Description =>  $some_value, # string
     },
     ControlNumber =>  $some_value, # string
   },
   SignedForByName =>  $some_value, # string
   Activity =>  { # Shipment::UPS::WSDL::TrackTypes::ShipmentActivityType
     ActivityLocation =>  { # Shipment::UPS::WSDL::TrackTypes::AddressType
       AddressLine =>  $some_value, # string
       City =>  $some_value, # string
       StateProvinceCode =>  $some_value, # string
       PostalCode =>  $some_value, # string
       CountryCode =>  $some_value, # string
     },
     Code =>  $some_value, # string
     Description =>  $some_value, # string
     Date =>  $some_value, # string
     Time =>  $some_value, # string
     Trailer =>  $some_value, # string
     Document =>  { # Shipment::UPS::WSDL::TrackTypes::DocumentType
       Type =>  { # Shipment::UPS::WSDL::TrackTypes::CommonCodeDescriptionType
         Code =>  $some_value, # string
         Description =>  $some_value, # string
       },
       Content =>  $some_value, # string
       Format =>  { # Shipment::UPS::WSDL::TrackTypes::CommonCodeDescriptionType
         Code =>  $some_value, # string
         Description =>  $some_value, # string
       },
     },
     AdditionalAttribute =>  { # Shipment::UPS::WSDL::TrackTypes::AdditionalCodeDescriptionValueType
       Code =>  $some_value, # string
       Description =>  $some_value, # string
       Value =>  $some_value, # string
     },
   },
   OriginPortDetail =>  { # Shipment::UPS::WSDL::TrackTypes::OriginPortDetailType
     OriginPort =>  $some_value, # string
     EstimatedDeparture =>  { # Shipment::UPS::WSDL::TrackTypes::DateTimeType
       Date =>  $some_value, # string
       Time =>  $some_value, # string
     },
   },
   DestinationPortDetail =>  { # Shipment::UPS::WSDL::TrackTypes::DestinationPortDetailType
     DestinationPort =>  $some_value, # string
     EstimatedArrival =>  { # Shipment::UPS::WSDL::TrackTypes::DateTimeType
       Date =>  $some_value, # string
       Time =>  $some_value, # string
     },
   },
   DescriptionOfGoods =>  $some_value, # string
   CargoReady =>  { # Shipment::UPS::WSDL::TrackTypes::DateTimeType
     Date =>  $some_value, # string
     Time =>  $some_value, # string
   },
   Manifest =>  { # Shipment::UPS::WSDL::TrackTypes::DateTimeType
     Date =>  $some_value, # string
     Time =>  $some_value, # string
   },
   CarrierActivityInformation =>  { # Shipment::UPS::WSDL::TrackTypes::CarrierActivityInformationType
     CarrierId =>  $some_value, # string
     Description =>  $some_value, # string
     Status =>  $some_value, # string
     Arrival =>  { # Shipment::UPS::WSDL::TrackTypes::DateTimeType
       Date =>  $some_value, # string
       Time =>  $some_value, # string
     },
     Departure =>  { # Shipment::UPS::WSDL::TrackTypes::DateTimeType
       Date =>  $some_value, # string
       Time =>  $some_value, # string
     },
     OriginPort =>  $some_value, # string
     DestinationPort =>  $some_value, # string
   },
   Document =>  { # Shipment::UPS::WSDL::TrackTypes::DocumentType
     Type =>  { # Shipment::UPS::WSDL::TrackTypes::CommonCodeDescriptionType
       Code =>  $some_value, # string
       Description =>  $some_value, # string
     },
     Content =>  $some_value, # string
     Format =>  { # Shipment::UPS::WSDL::TrackTypes::CommonCodeDescriptionType
       Code =>  $some_value, # string
       Description =>  $some_value, # string
     },
   },
   FileNumber =>  $some_value, # string
   Appointment =>  { # Shipment::UPS::WSDL::TrackTypes::AppointmentType
     Made =>  { # Shipment::UPS::WSDL::TrackTypes::DateTimeType
       Date =>  $some_value, # string
       Time =>  $some_value, # string
     },
     Requested =>  { # Shipment::UPS::WSDL::TrackTypes::DateTimeType
       Date =>  $some_value, # string
       Time =>  $some_value, # string
     },
     BeginTime =>  $some_value, # string
     EndTime =>  $some_value, # string
   },
   Package =>  { # Shipment::UPS::WSDL::TrackTypes::PackageType
     TrackingNumber =>  $some_value, # string
     DeliveryDetail =>  { # Shipment::UPS::WSDL::TrackTypes::DeliveryDetailType
       Type =>  { # Shipment::UPS::WSDL::TrackTypes::CommonCodeDescriptionType
         Code =>  $some_value, # string
         Description =>  $some_value, # string
       },
       Date =>  $some_value, # string
       Time =>  $some_value, # string
     },
     PackageAddress =>  { # Shipment::UPS::WSDL::TrackTypes::PackageAddressType
       Type =>  { # Shipment::UPS::WSDL::TrackTypes::CommonCodeDescriptionType
         Code =>  $some_value, # string
         Description =>  $some_value, # string
       },
       Address =>  { # Shipment::UPS::WSDL::TrackTypes::AddressType
         AddressLine =>  $some_value, # string
         City =>  $some_value, # string
         StateProvinceCode =>  $some_value, # string
         PostalCode =>  $some_value, # string
         CountryCode =>  $some_value, # string
       },
     },
     PackageServiceOption =>  { # Shipment::UPS::WSDL::TrackTypes::ServiceOptionType
       Type =>  { # Shipment::UPS::WSDL::TrackTypes::CommonCodeDescriptionType
         Code =>  $some_value, # string
         Description =>  $some_value, # string
       },
       Value =>  $some_value, # string
       AdditionalAttribute =>  { # Shipment::UPS::WSDL::TrackTypes::AdditionalCodeDescriptionValueType
         Code =>  $some_value, # string
         Description =>  $some_value, # string
         Value =>  $some_value, # string
       },
     },
     COD =>  { # Shipment::UPS::WSDL::TrackTypes::CODType
       Amount =>  { # Shipment::UPS::WSDL::TrackTypes::AmountType
         CurrencyCode =>  $some_value, # string
         MonetaryValue =>  $some_value, # string
       },
       Status =>  { # Shipment::UPS::WSDL::TrackTypes::CODStatusType
         Code =>  $some_value, # string
         Description =>  $some_value, # string
       },
       ControlNumber =>  $some_value, # string
     },
     Activity =>  { # Shipment::UPS::WSDL::TrackTypes::ActivityType
       AlternateTrackingInfo =>  { # Shipment::UPS::WSDL::TrackTypes::AlternateTrackingInfoType
         Type =>  $some_value, # string
         Description =>  $some_value, # string
         Value =>  $some_value, # string
       },
       ActivityLocation =>  { # Shipment::UPS::WSDL::TrackTypes::ActivityLocationType
         Address =>  { # Shipment::UPS::WSDL::TrackTypes::AddressType
           AddressLine =>  $some_value, # string
           City =>  $some_value, # string
           StateProvinceCode =>  $some_value, # string
           PostalCode =>  $some_value, # string
           CountryCode =>  $some_value, # string
         },
         TransportFacility =>  { # Shipment::UPS::WSDL::TrackTypes::TransportFacilityType
           Type =>  $some_value, # string
           Code =>  $some_value, # string
         },
         Code =>  $some_value, # string
         Description =>  $some_value, # string
         SignedForByName =>  $some_value, # string
       },
       Status =>  { # Shipment::UPS::WSDL::TrackTypes::StatusType
         Type =>  $some_value, # string
         Description =>  $some_value, # string
         Code =>  $some_value, # string
       },
       Date =>  $some_value, # string
       Time =>  $some_value, # string
       Document =>  { # Shipment::UPS::WSDL::TrackTypes::DocumentType
         Type =>  { # Shipment::UPS::WSDL::TrackTypes::CommonCodeDescriptionType
           Code =>  $some_value, # string
           Description =>  $some_value, # string
         },
         Content =>  $some_value, # string
         Format =>  { # Shipment::UPS::WSDL::TrackTypes::CommonCodeDescriptionType
           Code =>  $some_value, # string
           Description =>  $some_value, # string
         },
       },
       AdditionalAttribute =>  { # Shipment::UPS::WSDL::TrackTypes::AdditionalCodeDescriptionValueType
         Code =>  $some_value, # string
         Description =>  $some_value, # string
         Value =>  $some_value, # string
       },
     },
     Message =>  { # Shipment::UPS::WSDL::TrackTypes::MessageType
       Code =>  $some_value, # string
       Description =>  $some_value, # string
     },
     PackageWeight =>  { # Shipment::UPS::WSDL::TrackTypes::WeightType
       UnitOfMeasurement =>  { # Shipment::UPS::WSDL::TrackTypes::UnitOfMeasurementType
         Code =>  $some_value, # string
         Description =>  $some_value, # string
       },
       Weight =>  $some_value, # string
     },
     ReferenceNumber =>  { # Shipment::UPS::WSDL::TrackTypes::ReferenceNumberType
       Code =>  $some_value, # string
       Value =>  $some_value, # string
     },
     AlternateTrackingNumber =>  $some_value, # string
     AlternateTrackingInfo =>  { # Shipment::UPS::WSDL::TrackTypes::AlternateTrackingInfoType
       Type =>  $some_value, # string
       Description =>  $some_value, # string
       Value =>  $some_value, # string
     },
     Document =>  { # Shipment::UPS::WSDL::TrackTypes::DocumentType
       Type =>  { # Shipment::UPS::WSDL::TrackTypes::CommonCodeDescriptionType
         Code =>  $some_value, # string
         Description =>  $some_value, # string
       },
       Content =>  $some_value, # string
       Format =>  { # Shipment::UPS::WSDL::TrackTypes::CommonCodeDescriptionType
         Code =>  $some_value, # string
         Description =>  $some_value, # string
       },
     },
     AdditionalAttribute =>  { # Shipment::UPS::WSDL::TrackTypes::AdditionalCodeDescriptionValueType
       Code =>  $some_value, # string
       Description =>  $some_value, # string
       Value =>  $some_value, # string
     },
   },
   AdditionalAttribute =>  { # Shipment::UPS::WSDL::TrackTypes::AdditionalCodeDescriptionValueType
     Code =>  $some_value, # string
     Description =>  $some_value, # string
     Value =>  $some_value, # string
   },
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

