
package Shipment::UPS::WSDL::ShipTypemaps::VoidService;
use strict;
use warnings;

our $typemap_1 = {
               'UPSSecurity/UsernameToken/Username' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'UPSSecurity/ServiceAccessToken' => 'Shipment::UPS::WSDL::ShipElements::UPSSecurity::_ServiceAccessToken',
               'VoidShipmentResponse/Response/Alert' => 'Shipment::UPS::WSDL::ShipTypes::CodeDescriptionType',
               'VoidShipmentRequest/Request/TransactionReference' => 'Shipment::UPS::WSDL::ShipTypes::TransactionReferenceType',
               'VoidShipmentResponse/PackageLevelResult/Status' => 'Shipment::UPS::WSDL::ShipTypes::CodeDescriptionType',
               'Fault/detail/Errors/ErrorDetail/Location/LocationElementName' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'UPSSecurity' => 'Shipment::UPS::WSDL::ShipElements::UPSSecurity',
               'Fault/faultcode' => 'SOAP::WSDL::XSD::Typelib::Builtin::anyURI',
               'Fault/detail/Errors/ErrorDetail/AdditionalInformation/Value/Code' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'Fault/detail/Errors/ErrorDetail/SubErrorCode/Code' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'VoidShipmentRequest/Request' => 'Shipment::UPS::WSDL::ShipTypes::RequestType',
               'VoidShipmentResponse/Response/ResponseStatus' => 'Shipment::UPS::WSDL::ShipTypes::CodeDescriptionType',
               'Fault/detail/Errors/ErrorDetail/AdditionalInformation/Value' => 'Shipment::UPS::WSDL::ShipTypes::AdditionalCodeDescType',
               'Fault/detail/Errors/ErrorDetail/SubErrorCode' => 'Shipment::UPS::WSDL::ShipTypes::CodeType',
               'Fault/detail/Errors/ErrorDetail/SubErrorCode/Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'VoidShipmentResponse/SummaryResult/Status/Code' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'VoidShipmentRequest/VoidShipment/TrackingNumber' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'Fault/detail/Errors/ErrorDetail/AdditionalInformation' => 'Shipment::UPS::WSDL::ShipTypes::AdditionalInfoType',
               'Fault/detail/Errors/ErrorDetail/SubErrorCode/Digest' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'UPSSecurity/UsernameToken/Password' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'VoidShipmentResponse/SummaryResult/Status' => 'Shipment::UPS::WSDL::ShipTypes::CodeDescriptionType',
               'Fault/detail/Errors/ErrorDetail/PrimaryErrorCode/Digest' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'Fault/detail/Errors/ErrorDetail/Severity' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'VoidShipmentResponse/Response' => 'Shipment::UPS::WSDL::ShipTypes::ResponseType',
               'VoidShipmentResponse/Response/TransactionReference/TransactionIdentifier' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'VoidShipmentResponse/PackageLevelResult/Status/Code' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'VoidShipmentRequest/Request/TransactionReference/CustomerContext' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'VoidShipmentResponse/PackageLevelResult' => 'Shipment::UPS::WSDL::ShipTypes::PackageLevelResult',
               'VoidShipmentRequest/VoidShipment' => 'Shipment::UPS::WSDL::ShipElements::VoidShipmentRequest::_VoidShipment',
               'VoidShipmentResponse/Response/ResponseStatus/Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'VoidShipmentResponse/Response/ResponseStatus/Code' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'VoidShipmentResponse/SummaryResult' => 'Shipment::UPS::WSDL::ShipElements::VoidShipmentResponse::_SummaryResult',
               'Fault/detail/Errors/ErrorDetail' => 'Shipment::UPS::WSDL::ShipTypes::ErrorDetailType',
               'Fault/detail/Errors/ErrorDetail/AdditionalInformation/Type' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'Fault/detail/Errors/ErrorDetail/Location/XPathOfElement' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'VoidShipmentResponse' => 'Shipment::UPS::WSDL::ShipElements::VoidShipmentResponse',
               'VoidShipmentResponse/Response/Alert/Code' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'Fault/detail/Errors/ErrorDetail/PrimaryErrorCode/Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'VoidShipmentResponse/SummaryResult/Status/Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'UPSSecurity/ServiceAccessToken/AccessLicenseNumber' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'Fault/detail/Errors/ErrorDetail/PrimaryErrorCode' => 'Shipment::UPS::WSDL::ShipTypes::CodeType',
               'Errors' => 'Shipment::UPS::WSDL::ShipElements::Errors',
               'Fault/faultstring' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'VoidShipmentResponse/PackageLevelResult/TrackingNumber' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'Fault' => 'SOAP::WSDL::SOAP::Typelib::Fault11',
               'VoidShipmentResponse/Response/TransactionReference/CustomerContext' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'Fault/detail/Errors/ErrorDetail/Location' => 'Shipment::UPS::WSDL::ShipTypes::LocationType',
               'VoidShipmentRequest/VoidShipment/ShipmentIdentificationNumber' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'VoidShipmentRequest/Request/RequestOption' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'Fault/faultactor' => 'SOAP::WSDL::XSD::Typelib::Builtin::token',
               'UPSSecurity/UsernameToken' => 'Shipment::UPS::WSDL::ShipElements::UPSSecurity::_UsernameToken',
               'Fault/detail/Errors/ErrorDetail/AdditionalInformation/Value/Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'VoidShipmentRequest/Request/TransactionReference/TransactionIdentifier' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'VoidShipmentResponse/PackageLevelResult/Status/Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'Fault/detail' => 'Shipment::UPS::WSDL::ShipElements::FaultDetail',
               'Fault/detail/Errors' => 'Shipment::UPS::WSDL::ShipElements::Errors',
               'Fault/detail/Errors/ErrorDetail/MinimumRetrySeconds' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'VoidShipmentRequest' => 'Shipment::UPS::WSDL::ShipElements::VoidShipmentRequest',
               'Fault/detail/Errors/ErrorDetail/Location/OriginalValue' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'VoidShipmentResponse/Response/Alert/Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'VoidShipmentResponse/Response/TransactionReference' => 'Shipment::UPS::WSDL::ShipTypes::TransactionReferenceType',
               'Fault/detail/Errors/ErrorDetail/PrimaryErrorCode/Code' => 'SOAP::WSDL::XSD::Typelib::Builtin::string'
             };
;

sub get_class {
  my $name = join '/', @{ $_[1] };
  return $typemap_1->{ $name };
}

sub get_typemap {
    return $typemap_1;
}

1;

__END__

__END__

=pod

=head1 NAME

Shipment::UPS::WSDL::ShipTypemaps::VoidService - typemap for VoidService

=head1 DESCRIPTION

Typemap created by SOAP::WSDL for map-based SOAP message parsers.

=cut

