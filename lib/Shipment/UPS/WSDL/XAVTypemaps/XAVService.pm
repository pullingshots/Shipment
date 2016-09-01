
package Shipment::UPS::WSDL::XAVTypemaps::XAVService;
use strict;
use warnings;

our $typemap_1 = {
               'XAVResponse/Candidate/AddressKeyFormat/AttentionName' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'UPSSecurity/UsernameToken/Username' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'UPSSecurity/ServiceAccessToken' => 'Shipment::UPS::WSDL::XAVElements::UPSSecurity::_ServiceAccessToken',
               'XAVResponse/Candidate' => 'Shipment::UPS::WSDL::XAVTypes::CandidateType',
               'XAVResponse/Candidate/AddressKeyFormat/ConsigneeName' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'XAVResponse/Response/ResponseStatus' => 'Shipment::UPS::WSDL::XAVTypes::CodeDescriptionType',
               'XAVResponse/AddressClassification/Code' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'Errors/ErrorDetail/Location/LocationElementName' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'Fault/faultcode' => 'SOAP::WSDL::XSD::Typelib::Builtin::anyURI',
               'Errors/ErrorDetail/SubErrorCode/Code' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'XAVResponse/Response/ResponseStatus/Code' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'Errors/ErrorDetail/SubErrorCode/Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'XAVResponse' => 'Shipment::UPS::WSDL::XAVElements::XAVResponse',
               'XAVResponse/Candidate/AddressKeyFormat/PostcodePrimaryLow' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'XAVResponse/Candidate/AddressClassification/Code' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'XAVRequest/Request/TransactionReference' => 'Shipment::UPS::WSDL::XAVTypes::TransactionReferenceType',
               'Errors/ErrorDetail/SubErrorCode/Digest' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'XAVRequest/RegionalRequestIndicator' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'XAVResponse/AddressClassification' => 'Shipment::UPS::WSDL::XAVTypes::AddressClassificationType',
               'XAVResponse/Response/Alert/Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'XAVRequest/AddressKeyFormat/CountryCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'Errors/ErrorDetail/PrimaryErrorCode/Digest' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'XAVRequest/Request/RequestOption' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'XAVResponse/Candidate/AddressKeyFormat/CountryCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'XAVResponse/AmbiguousAddressIndicator' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'XAVRequest/AddressKeyFormat/AddressLine' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'Errors/ErrorDetail/Location/XPathOfElement' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'XAVRequest/AddressKeyFormat/Region' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'XAVResponse/Response/TransactionReference/TransactionIdentifier' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'UPSSecurity/ServiceAccessToken/AccessLicenseNumber' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'XAVRequest/Request' => 'Shipment::UPS::WSDL::XAVTypes::RequestType',
               'Errors/ErrorDetail/PrimaryErrorCode' => 'Shipment::UPS::WSDL::XAVTypes::CodeType',
               'Errors' => 'Shipment::UPS::WSDL::XAVElements::Errors',
               'Fault/faultstring' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'XAVRequest/Request/TransactionReference/TransactionIdentifier' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'XAVResponse/AddressClassification/Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'XAVResponse/Response/Alert' => 'Shipment::UPS::WSDL::XAVTypes::CodeDescriptionType',
               'Errors/TransactionReference/CustomerContext' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'XAVResponse/Candidate/AddressKeyFormat' => 'Shipment::UPS::WSDL::XAVTypes::AddressKeyFormatType',
               'XAVRequest/AddressKeyFormat/AttentionName' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'XAVResponse/Response/TransactionReference/CustomerContext' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'XAVRequest' => 'Shipment::UPS::WSDL::XAVElements::XAVRequest',
               'Fault/detail' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'XAVResponse/Response/TransactionReference' => 'Shipment::UPS::WSDL::XAVTypes::TransactionReferenceType',
               'XAVResponse/Candidate/AddressKeyFormat/PostcodeExtendedLow' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'XAVResponse/Response' => 'Shipment::UPS::WSDL::XAVTypes::ResponseType',
               'XAVResponse/ValidAddressIndicator' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'XAVRequest/AddressKeyFormat/PostcodePrimaryLow' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'Errors/TransactionReference' => 'Shipment::UPS::WSDL::XAVTypes::TransactionReferenceType',
               'XAVRequest/Request/TransactionReference/CustomerContext' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'XAVResponse/Candidate/AddressKeyFormat/AddressLine' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'UPSSecurity' => 'Shipment::UPS::WSDL::XAVElements::UPSSecurity',
               'Errors/TransactionReference/TransactionIdentifier' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'Errors/ErrorDetail/SubErrorCode' => 'Shipment::UPS::WSDL::XAVTypes::CodeType',
               'XAVResponse/Candidate/AddressKeyFormat/Urbanization' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'XAVRequest/MaximumCandidateListSize' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'UPSSecurity/UsernameToken/Password' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'XAVResponse/NoCandidatesIndicator' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'XAVResponse/Candidate/AddressKeyFormat/PoliticalDivision2' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'XAVRequest/AddressKeyFormat/PoliticalDivision1' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'XAVRequest/AddressKeyFormat/PostcodeExtendedLow' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'Errors/ErrorDetail/Severity' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'XAVResponse/Response/Alert/Code' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'XAVResponse/Candidate/AddressKeyFormat/PoliticalDivision1' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'XAVResponse/Response/ResponseStatus/Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'XAVResponse/Candidate/AddressClassification' => 'Shipment::UPS::WSDL::XAVTypes::AddressClassificationType',
               'Errors/ErrorDetail' => 'Shipment::UPS::WSDL::XAVTypes::ErrorDetailType',
               'XAVResponse/Candidate/AddressClassification/Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'Errors/ErrorDetail/PrimaryErrorCode/Description' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'XAVResponse/Candidate/AddressKeyFormat/Region' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'Fault' => 'SOAP::WSDL::SOAP::Typelib::Fault11',
               'Errors/ErrorDetail/Location' => 'Shipment::UPS::WSDL::XAVTypes::LocationType',
               'Fault/faultactor' => 'SOAP::WSDL::XSD::Typelib::Builtin::token',
               'UPSSecurity/UsernameToken' => 'Shipment::UPS::WSDL::XAVElements::UPSSecurity::_UsernameToken',
               'XAVRequest/AddressKeyFormat/PoliticalDivision2' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'Errors/ErrorDetail/MinimumRetrySeconds' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'XAVRequest/AddressKeyFormat/Urbanization' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'XAVRequest/AddressKeyFormat' => 'Shipment::UPS::WSDL::XAVTypes::AddressKeyFormatType',
               'XAVRequest/AddressKeyFormat/ConsigneeName' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'Errors/ErrorDetail/Location/OriginalValue' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'Errors/ErrorDetail/PrimaryErrorCode/Code' => 'SOAP::WSDL::XSD::Typelib::Builtin::string'
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

Shipment::UPS::WSDL::XAVTypemaps::XAVService - typemap for XAVService

=head1 DESCRIPTION

Typemap created by SOAP::WSDL for map-based SOAP message parsers.

=cut

