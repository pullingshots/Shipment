
package Shipment::UPS::WSDL::TrackElements::TrackResponse;
use strict;
use warnings;

{ # BLOCK to scope variables

sub get_xmlns { 'http://www.ups.com/XMLSchema/XOLTWS/Track/v2.0' }

__PACKAGE__->__set_name('TrackResponse');
__PACKAGE__->__set_nillable();
__PACKAGE__->__set_minOccurs();
__PACKAGE__->__set_maxOccurs();
__PACKAGE__->__set_ref();

use base qw(
    SOAP::WSDL::XSD::Typelib::Element
    SOAP::WSDL::XSD::Typelib::ComplexType
);

our $XML_ATTRIBUTE_CLASS;
undef $XML_ATTRIBUTE_CLASS;

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}

use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %Response_of :ATTR(:get<Response>);
my %Shipment_of :ATTR(:get<Shipment>);
my %Disclaimer_of :ATTR(:get<Disclaimer>);

__PACKAGE__->_factory(
    [ qw(        Response
        Shipment
        Disclaimer

    ) ],
    {
        'Response' => \%Response_of,
        'Shipment' => \%Shipment_of,
        'Disclaimer' => \%Disclaimer_of,
    },
    {
        'Response' => 'Shipment::UPS::WSDL::TrackElements::Response',

        'Shipment' => 'Shipment::UPS::WSDL::TrackTypes::ShipmentType',
        'Disclaimer' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    },
    {

        'Response' => '',
        'Shipment' => 'Shipment',
        'Disclaimer' => 'Disclaimer',
    }
);

} # end BLOCK






} # end of BLOCK



1;


=pod

=head1 NAME

Shipment::UPS::WSDL::TrackElements::TrackResponse

=head1 DESCRIPTION

Perl data type class for the XML Schema defined element
TrackResponse from the namespace http://www.ups.com/XMLSchema/XOLTWS/Track/v2.0.







=head1 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * Response

 $element->set_Response($data);
 $element->get_Response();


Note: The name of this property has been altered, because it didn't match
perl's notion of variable/subroutine names. The altered name is used in
perl code only, XML output uses the original name:

 



=item * Shipment

 $element->set_Shipment($data);
 $element->get_Shipment();




=item * Disclaimer

 $element->set_Disclaimer($data);
 $element->get_Disclaimer();





=back


=head1 METHODS

=head2 new

 my $element = Shipment::UPS::WSDL::TrackElements::TrackResponse->new($data);

Constructor. The following data structure may be passed to new():

 {
   Response =>  { # Shipment::UPS::WSDL::TrackTypes::ResponseType
     ResponseStatus =>  { # Shipment::UPS::WSDL::TrackTypes::CodeDescriptionType
       Code =>  $some_value, # string
       Description =>  $some_value, # string
     },
     Alert =>  { # Shipment::UPS::WSDL::TrackTypes::CodeDescriptionType
       Code =>  $some_value, # string
       Description =>  $some_value, # string
     },
     TransactionReference =>  { # Shipment::UPS::WSDL::TrackTypes::TransactionReferenceType
       CustomerContext =>  $some_value, # string
       TransactionIdentifier =>  $some_value, # string
     },
   },
   Shipment =>  { # Shipment::UPS::WSDL::TrackTypes::ShipmentType
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
   Disclaimer =>  $some_value, # string
 },

=head1 AUTHOR

Generated by SOAP::WSDL

=cut

