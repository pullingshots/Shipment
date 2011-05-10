
package Shipment::Purolator::WSDL::Typemaps::ShippingDocumentsService;
use strict;
use warnings;

our $typemap_1 = {
               'GetDocumentsResponse' => 'Shipment::Purolator::WSDL::Elements::GetDocumentsResponse',
               'GetShipmentManifestDocumentResponse/ResponseInformation/Errors/Error/AdditionalInformation' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'Fault/faultcode' => 'SOAP::WSDL::XSD::Typelib::Builtin::anyURI',
               'GetDocumentsRequest/DocumentCriterium' => 'Shipment::Purolator::WSDL::Types::ArrayOfDocumentCriteria',
               'GetDocumentsResponse/ResponseInformation/InformationalMessages/InformationalMessage/Message' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'ValidationFault/Details' => 'Shipment::Purolator::WSDL::Types::ArrayOfValidationDetail',
               'GetDocumentsResponse/ResponseInformation/Errors/Error/Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetShipmentManifestDocumentRequest/ShipmentManifestDocumentCriterium' => 'Shipment::Purolator::WSDL::Types::ArrayOfShipmentManifestDocumentCriteria',
               'GetDocumentsResponse/Documents/Document/DocumentDetails/DocumentDetail/DocumentStatus' => 'Shipment::Purolator::WSDL::Types::DocumentStatus',
               'GetShipmentManifestDocumentRequest/ShipmentManifestDocumentCriterium/ShipmentManifestDocumentCriteria/ManifestDate' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetDocumentsResponse/ResponseInformation/InformationalMessages/InformationalMessage/Code' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetDocumentsRequest/DocumentCriterium/DocumentCriteria/PIN' => 'Shipment::Purolator::WSDL::Types::PIN',
               'GetShipmentManifestDocumentResponse/ResponseInformation/InformationalMessages' => 'Shipment::Purolator::WSDL::Types::ArrayOfInformationalMessage',
               'GetShipmentManifestDocumentResponse/ManifestBatches/ManifestBatch/ManifestBatchDetails/ManifestBatchDetail/DocumentType' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetShipmentManifestDocumentResponse/ManifestBatches/ManifestBatch' => 'Shipment::Purolator::WSDL::Types::ManifestBatch',
               'Fault/faultstring' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetDocumentsResponse/Documents/Document/DocumentDetails/DocumentDetail/Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'ValidationFault/Details/ValidationDetail/Message' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetDocumentsResponse/ResponseInformation/Errors/Error/AdditionalInformation' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetShipmentManifestDocumentRequest' => 'Shipment::Purolator::WSDL::Elements::GetShipmentManifestDocumentRequest',
               'ValidationFault/Details/ValidationDetail/Key' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetDocumentsRequest/DocumentCriterium/DocumentCriteria/DocumentTypes' => 'Shipment::Purolator::WSDL::Types::DocumentTypes',
               'GetDocumentsRequest/DocumentCriterium/DocumentCriteria' => 'Shipment::Purolator::WSDL::Types::DocumentCriteria',
               'ValidationFault/Details/ValidationDetail' => 'Shipment::Purolator::WSDL::Types::ValidationDetail',
               'Fault/detail' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetShipmentManifestDocumentResponse/ResponseInformation/InformationalMessages/InformationalMessage/Code' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetDocumentsResponse/Documents/Document/DocumentDetails' => 'Shipment::Purolator::WSDL::Types::ArrayOfDocumentDetail',
               'GetShipmentManifestDocumentResponse/ManifestBatches/ManifestBatch/ManifestBatchDetails/ManifestBatchDetail/Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetShipmentManifestDocumentResponse/ResponseInformation/Errors/Error' => 'Shipment::Purolator::WSDL::Types::Error',
               'ValidationFault/Details/ValidationDetail/Tag' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetDocumentsResponse/ResponseInformation/Errors/Error' => 'Shipment::Purolator::WSDL::Types::Error',
               'GetDocumentsResponse/ResponseInformation/InformationalMessages/InformationalMessage' => 'Shipment::Purolator::WSDL::Types::InformationalMessage',
               'GetShipmentManifestDocumentRequest/ShipmentManifestDocumentCriterium/ShipmentManifestDocumentCriteria' => 'Shipment::Purolator::WSDL::Types::ShipmentManifestDocumentCriteria',
               'GetDocumentsRequest/DocumentCriterium/DocumentCriteria/DocumentTypes/DocumentType' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetDocumentsResponse/Documents' => 'Shipment::Purolator::WSDL::Types::ArrayOfDocument',
               'GetDocumentsResponse/ResponseInformation' => 'Shipment::Purolator::WSDL::Types::ResponseInformation',
               'GetShipmentManifestDocumentResponse' => 'Shipment::Purolator::WSDL::Elements::GetShipmentManifestDocumentResponse',
               'GetDocumentsResponse/Documents/Document/DocumentDetails/DocumentDetail/DocumentType' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetShipmentManifestDocumentResponse/ManifestBatches/ManifestBatch/ManifestBatchDetails/ManifestBatchDetail' => 'Shipment::Purolator::WSDL::Types::ManifestBatchDetail',
               'GetDocumentsResponse/Documents/Document' => 'Shipment::Purolator::WSDL::Types::Document',
               'GetShipmentManifestDocumentResponse/ManifestBatches/ManifestBatch/ManifestBatchDetails/ManifestBatchDetail/DocumentStatus' => 'Shipment::Purolator::WSDL::Types::DocumentStatus',
               'GetShipmentManifestDocumentResponse/ResponseInformation/Errors/Error/Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetDocumentsRequest/DocumentCriterium/DocumentCriteria/PIN/Value' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetShipmentManifestDocumentResponse/ResponseInformation' => 'Shipment::Purolator::WSDL::Types::ResponseInformation',
               'GetShipmentManifestDocumentResponse/ResponseInformation/Errors/Error/Code' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetDocumentsResponse/Documents/Document/DocumentDetails/DocumentDetail' => 'Shipment::Purolator::WSDL::Types::DocumentDetail',
               'GetDocumentsResponse/ResponseInformation/Errors' => 'Shipment::Purolator::WSDL::Types::ArrayOfError',
               'GetShipmentManifestDocumentResponse/ManifestBatches/ManifestBatch/ManifestBatchDetails/ManifestBatchDetail/URL' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetShipmentManifestDocumentResponse/ResponseInformation/InformationalMessages/InformationalMessage/Message' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetShipmentManifestDocumentResponse/ManifestBatches/ManifestBatch/ManifestBatchDetails' => 'Shipment::Purolator::WSDL::Types::ArrayOfManifestBatchDetail',
               'GetShipmentManifestDocumentResponse/ResponseInformation/InformationalMessages/InformationalMessage' => 'Shipment::Purolator::WSDL::Types::InformationalMessage',
               'GetShipmentManifestDocumentResponse/ManifestBatches/ManifestBatch/ShipmentManifestDate' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetDocumentsResponse/Documents/Document/PIN' => 'Shipment::Purolator::WSDL::Types::PIN',
               'GetDocumentsResponse/Documents/Document/PIN/Value' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetShipmentManifestDocumentResponse/ResponseInformation/Errors' => 'Shipment::Purolator::WSDL::Types::ArrayOfError',
               'Fault' => 'SOAP::WSDL::SOAP::Typelib::Fault11',
               'ValidationFault' => 'Shipment::Purolator::WSDL::Elements::ValidationFault',
               'Fault/faultactor' => 'SOAP::WSDL::XSD::Typelib::Builtin::token',
               'GetDocumentsRequest' => 'Shipment::Purolator::WSDL::Elements::GetDocumentsRequest',
               'GetDocumentsResponse/ResponseInformation/InformationalMessages' => 'Shipment::Purolator::WSDL::Types::ArrayOfInformationalMessage',
               'GetDocumentsResponse/ResponseInformation/Errors/Error/Code' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetShipmentManifestDocumentResponse/ManifestBatches' => 'Shipment::Purolator::WSDL::Types::ArrayOfManifestBatch',
               'GetDocumentsResponse/Documents/Document/DocumentDetails/DocumentDetail/URL' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetShipmentManifestDocumentResponse/ManifestBatches/ManifestBatch/ManifestCloseDateTime' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    ## Add missing
    'ResponseContext' => 'Shipment::Purolator::WSDL::Elements::ResponseContext',
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

Shipment::Purolator::WSDL::Typemaps::ShippingDocumentsService - typemap for ShippingDocumentsService

=head1 DESCRIPTION

Typemap created by SOAP::WSDL for map-based SOAP message parsers.

=cut

