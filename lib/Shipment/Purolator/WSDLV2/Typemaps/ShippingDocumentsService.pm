
package Shipment::Purolator::WSDLV2::Typemaps::ShippingDocumentsService;
use strict;
use warnings;

our $typemap_1 = {
               'GetDocumentsResponse' => 'Shipment::Purolator::WSDLV2::Elements::GetDocumentsResponse',
               'GetShipmentManifestDocumentResponse/ResponseInformation/Errors/Error/AdditionalInformation' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'Fault/faultcode' => 'SOAP::WSDL::XSD::Typelib::Builtin::anyURI',
               'GetDocumentsRequest/DocumentCriterium' => 'Shipment::Purolator::WSDLV2::Types::ArrayOfDocumentCriteria',
               'GetDocumentsResponse/ResponseInformation/InformationalMessages/InformationalMessage/Message' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'ValidationFault/Details' => 'Shipment::Purolator::WSDLV2::Types::ArrayOfValidationDetail',
               'GetDocumentsResponse/ResponseInformation/Errors/Error/Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetShipmentManifestDocumentRequest/ShipmentManifestDocumentCriterium' => 'Shipment::Purolator::WSDLV2::Types::ArrayOfShipmentManifestDocumentCriteria',
               'GetDocumentsResponse/Documents/Document/DocumentDetails/DocumentDetail/DocumentStatus' => 'Shipment::Purolator::WSDLV2::Types::DocumentStatus',
               'GetShipmentManifestDocumentRequest/ShipmentManifestDocumentCriterium/ShipmentManifestDocumentCriteria/ManifestDate' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetDocumentsResponse/ResponseInformation/InformationalMessages/InformationalMessage/Code' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetDocumentsRequest/DocumentCriterium/DocumentCriteria/PIN' => 'Shipment::Purolator::WSDLV2::Types::PIN',
               'GetShipmentManifestDocumentResponse/ResponseInformation/InformationalMessages' => 'Shipment::Purolator::WSDLV2::Types::ArrayOfInformationalMessage',
               'GetShipmentManifestDocumentResponse/ManifestBatches/ManifestBatch/ManifestBatchDetails/ManifestBatchDetail/DocumentType' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetShipmentManifestDocumentResponse/ManifestBatches/ManifestBatch' => 'Shipment::Purolator::WSDLV2::Types::ManifestBatch',
               'Fault/faultstring' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetDocumentsResponse/Documents/Document/DocumentDetails/DocumentDetail/Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'ValidationFault/Details/ValidationDetail/Message' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetDocumentsResponse/ResponseInformation/Errors/Error/AdditionalInformation' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetShipmentManifestDocumentRequest' => 'Shipment::Purolator::WSDLV2::Elements::GetShipmentManifestDocumentRequest',
               'ValidationFault/Details/ValidationDetail/Key' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetDocumentsRequest/DocumentCriterium/DocumentCriteria/DocumentTypes' => 'Shipment::Purolator::WSDLV2::Types::DocumentTypes',
               'GetDocumentsRequest/DocumentCriterium/DocumentCriteria' => 'Shipment::Purolator::WSDLV2::Types::DocumentCriteria',
               'ValidationFault/Details/ValidationDetail' => 'Shipment::Purolator::WSDLV2::Types::ValidationDetail',
               'Fault/detail' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetShipmentManifestDocumentResponse/ResponseInformation/InformationalMessages/InformationalMessage/Code' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetDocumentsResponse/Documents/Document/DocumentDetails' => 'Shipment::Purolator::WSDLV2::Types::ArrayOfDocumentDetail',
               'GetShipmentManifestDocumentResponse/ManifestBatches/ManifestBatch/ManifestBatchDetails/ManifestBatchDetail/Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetShipmentManifestDocumentResponse/ResponseInformation/Errors/Error' => 'Shipment::Purolator::WSDLV2::Types::Error',
               'ValidationFault/Details/ValidationDetail/Tag' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetDocumentsResponse/ResponseInformation/Errors/Error' => 'Shipment::Purolator::WSDLV2::Types::Error',
               'GetDocumentsResponse/ResponseInformation/InformationalMessages/InformationalMessage' => 'Shipment::Purolator::WSDLV2::Types::InformationalMessage',
               'GetShipmentManifestDocumentRequest/ShipmentManifestDocumentCriterium/ShipmentManifestDocumentCriteria' => 'Shipment::Purolator::WSDLV2::Types::ShipmentManifestDocumentCriteria',
               'GetDocumentsRequest/DocumentCriterium/DocumentCriteria/DocumentTypes/DocumentType' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetDocumentsResponse/Documents' => 'Shipment::Purolator::WSDLV2::Types::ArrayOfDocument',
               'GetDocumentsResponse/ResponseInformation' => 'Shipment::Purolator::WSDLV2::Types::ResponseInformation',
               'GetShipmentManifestDocumentResponse' => 'Shipment::Purolator::WSDLV2::Elements::GetShipmentManifestDocumentResponse',
               'GetDocumentsResponse/Documents/Document/DocumentDetails/DocumentDetail/DocumentType' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetShipmentManifestDocumentResponse/ManifestBatches/ManifestBatch/ManifestBatchDetails/ManifestBatchDetail' => 'Shipment::Purolator::WSDLV2::Types::ManifestBatchDetail',
               'GetDocumentsResponse/Documents/Document' => 'Shipment::Purolator::WSDLV2::Types::Document',
               'GetShipmentManifestDocumentResponse/ManifestBatches/ManifestBatch/ManifestBatchDetails/ManifestBatchDetail/DocumentStatus' => 'Shipment::Purolator::WSDLV2::Types::DocumentStatus',
               'GetShipmentManifestDocumentResponse/ResponseInformation/Errors/Error/Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetDocumentsRequest/DocumentCriterium/DocumentCriteria/PIN/Value' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetShipmentManifestDocumentResponse/ResponseInformation' => 'Shipment::Purolator::WSDLV2::Types::ResponseInformation',
               'GetShipmentManifestDocumentResponse/ResponseInformation/Errors/Error/Code' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetDocumentsResponse/Documents/Document/DocumentDetails/DocumentDetail' => 'Shipment::Purolator::WSDLV2::Types::DocumentDetail',
               'GetDocumentsResponse/ResponseInformation/Errors' => 'Shipment::Purolator::WSDLV2::Types::ArrayOfError',
               'GetShipmentManifestDocumentResponse/ManifestBatches/ManifestBatch/ManifestBatchDetails/ManifestBatchDetail/URL' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetShipmentManifestDocumentResponse/ResponseInformation/InformationalMessages/InformationalMessage/Message' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetShipmentManifestDocumentResponse/ManifestBatches/ManifestBatch/ManifestBatchDetails' => 'Shipment::Purolator::WSDLV2::Types::ArrayOfManifestBatchDetail',
               'GetShipmentManifestDocumentResponse/ResponseInformation/InformationalMessages/InformationalMessage' => 'Shipment::Purolator::WSDLV2::Types::InformationalMessage',
               'GetShipmentManifestDocumentResponse/ManifestBatches/ManifestBatch/ShipmentManifestDate' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetDocumentsResponse/Documents/Document/PIN' => 'Shipment::Purolator::WSDLV2::Types::PIN',
               'GetDocumentsResponse/Documents/Document/PIN/Value' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetShipmentManifestDocumentResponse/ResponseInformation/Errors' => 'Shipment::Purolator::WSDLV2::Types::ArrayOfError',
               'Fault' => 'SOAP::WSDL::SOAP::Typelib::Fault11',
               'ValidationFault' => 'Shipment::Purolator::WSDLV2::Elements::ValidationFault',
               'Fault/faultactor' => 'SOAP::WSDL::XSD::Typelib::Builtin::token',
               'GetDocumentsRequest' => 'Shipment::Purolator::WSDLV2::Elements::GetDocumentsRequest',
               'GetDocumentsResponse/ResponseInformation/InformationalMessages' => 'Shipment::Purolator::WSDLV2::Types::ArrayOfInformationalMessage',
               'GetDocumentsResponse/ResponseInformation/Errors/Error/Code' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetShipmentManifestDocumentResponse/ManifestBatches' => 'Shipment::Purolator::WSDLV2::Types::ArrayOfManifestBatch',
               'GetDocumentsResponse/Documents/Document/DocumentDetails/DocumentDetail/URL' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetShipmentManifestDocumentResponse/ManifestBatches/ManifestBatch/ManifestCloseDateTime' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    ## Add missing
    'ResponseContext' => 'Shipment::Purolator::WSDLV2::Elements::ResponseContext',
    'ResponseContext/ResponseReference' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
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

Shipment::Purolator::WSDLV2::Typemaps::ShippingDocumentsService - typemap for ShippingDocumentsService

=head1 DESCRIPTION

Typemap created by SOAP::WSDL for map-based SOAP message parsers.

=cut

