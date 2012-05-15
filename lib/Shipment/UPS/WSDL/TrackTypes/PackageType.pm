package Shipment::UPS::WSDL::TrackTypes::PackageType;
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

my %TrackingNumber_of :ATTR(:get<TrackingNumber>);
my %DeliveryDetail_of :ATTR(:get<DeliveryDetail>);
my %PackageAddress_of :ATTR(:get<PackageAddress>);
my %PackageServiceOption_of :ATTR(:get<PackageServiceOption>);
my %COD_of :ATTR(:get<COD>);
my %Activity_of :ATTR(:get<Activity>);
my %Message_of :ATTR(:get<Message>);
my %PackageWeight_of :ATTR(:get<PackageWeight>);
my %ReferenceNumber_of :ATTR(:get<ReferenceNumber>);
my %AlternateTrackingNumber_of :ATTR(:get<AlternateTrackingNumber>);
my %AlternateTrackingInfo_of :ATTR(:get<AlternateTrackingInfo>);
my %Document_of :ATTR(:get<Document>);
my %AdditionalAttribute_of :ATTR(:get<AdditionalAttribute>);

__PACKAGE__->_factory(
    [ qw(        TrackingNumber
        DeliveryDetail
        PackageAddress
        PackageServiceOption
        COD
        Activity
        Message
        PackageWeight
        ReferenceNumber
        AlternateTrackingNumber
        AlternateTrackingInfo
        Document
        AdditionalAttribute

    ) ],
    {
        'TrackingNumber' => \%TrackingNumber_of,
        'DeliveryDetail' => \%DeliveryDetail_of,
        'PackageAddress' => \%PackageAddress_of,
        'PackageServiceOption' => \%PackageServiceOption_of,
        'COD' => \%COD_of,
        'Activity' => \%Activity_of,
        'Message' => \%Message_of,
        'PackageWeight' => \%PackageWeight_of,
        'ReferenceNumber' => \%ReferenceNumber_of,
        'AlternateTrackingNumber' => \%AlternateTrackingNumber_of,
        'AlternateTrackingInfo' => \%AlternateTrackingInfo_of,
        'Document' => \%Document_of,
        'AdditionalAttribute' => \%AdditionalAttribute_of,
    },
    {
        'TrackingNumber' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'DeliveryDetail' => 'Shipment::UPS::WSDL::TrackTypes::DeliveryDetailType',
        'PackageAddress' => 'Shipment::UPS::WSDL::TrackTypes::PackageAddressType',
        'PackageServiceOption' => 'Shipment::UPS::WSDL::TrackTypes::ServiceOptionType',
        'COD' => 'Shipment::UPS::WSDL::TrackTypes::CODType',
        'Activity' => 'Shipment::UPS::WSDL::TrackTypes::ActivityType',
        'Message' => 'Shipment::UPS::WSDL::TrackTypes::MessageType',
        'PackageWeight' => 'Shipment::UPS::WSDL::TrackTypes::WeightType',
        'ReferenceNumber' => 'Shipment::UPS::WSDL::TrackTypes::ReferenceNumberType',
        'AlternateTrackingNumber' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'AlternateTrackingInfo' => 'Shipment::UPS::WSDL::TrackTypes::AlternateTrackingInfoType',
        'Document' => 'Shipment::UPS::WSDL::TrackTypes::DocumentType',
        'AdditionalAttribute' => 'Shipment::UPS::WSDL::TrackTypes::AdditionalCodeDescriptionValueType',
    },
    {

        'TrackingNumber' => 'TrackingNumber',
        'DeliveryDetail' => 'DeliveryDetail',
        'PackageAddress' => 'PackageAddress',
        'PackageServiceOption' => 'PackageServiceOption',
        'COD' => 'COD',
        'Activity' => 'Activity',
        'Message' => 'Message',
        'PackageWeight' => 'PackageWeight',
        'ReferenceNumber' => 'ReferenceNumber',
        'AlternateTrackingNumber' => 'AlternateTrackingNumber',
        'AlternateTrackingInfo' => 'AlternateTrackingInfo',
        'Document' => 'Document',
        'AdditionalAttribute' => 'AdditionalAttribute',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

Shipment::UPS::WSDL::TrackTypes::PackageType

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
PackageType from the namespace http://www.ups.com/XMLSchema/XOLTWS/Track/v2.0.






=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * TrackingNumber


=item * DeliveryDetail


=item * PackageAddress


=item * PackageServiceOption


=item * COD


=item * Activity


=item * Message


=item * PackageWeight


=item * ReferenceNumber


=item * AlternateTrackingNumber


=item * AlternateTrackingInfo


=item * Document


=item * AdditionalAttribute




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # Shipment::UPS::WSDL::TrackTypes::PackageType
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




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

