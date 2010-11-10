package MyTypemaps::TestService;
use strict;
use warnings;

our $typemap_1 = {
               'ListPersonResponse/out/NewElement/WorkAddress/Street' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'ListPerson/in/Contracts' => 'MyTypes::ArrayOfContract',
               'ListPerson/in/HomeAddress/PhoneNumber' => 'MyTypes::PhoneNumber',
               'ListPersonResponse/out/NewElement/HomeAddress' => 'MyTypes::Address',
               'ListPersonResponse/out/NewElement/Contracts/Contract' => 'MyTypes::Contract',
               'ListPersonResponse/out/NewElement/HomeAddress/ZIP' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'ListPerson/in/WorkAddress/City' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'ListPerson/in/HomeAddress' => 'MyTypes::Address',
               'Fault/faultcode' => 'SOAP::WSDL::XSD::Typelib::Builtin::anyURI',
               'ListPerson/in/HomeAddress/City' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'ListPersonResponse/out/NewElement/WorkAddress/PhoneNumber' => 'MyTypes::PhoneNumber',
               'ListPerson/in/WorkAddress/ZIP' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'ListPersonResponse/out/NewElement/Contracts' => 'MyTypes::ArrayOfContract',
               'ListPerson/in/WorkAddress/Street' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'ListPerson/in' => 'MyTypes::Person',
               'ListPersonResponse/out/NewElement/GivenName' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'ListPersonResponse/out/NewElement/HomeAddress/PhoneNumber' => 'MyTypes::PhoneNumber',
               'ListPersonResponse/out/NewElement/HomeAddress/City' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'ListPersonResponse/out/NewElement' => 'MyTypes::Person',
               'ListPerson/in/PersonID/ID' => 'SOAP::WSDL::XSD::Typelib::Builtin::int',
               'ListPerson/in/HomeAddress/Street' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'ListPersonResponse/out/NewElement/PersonID/ID' => 'SOAP::WSDL::XSD::Typelib::Builtin::int',
               'ListPerson/in/HomeAddress/Country' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'ListPerson/in/GivenName' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'ListPerson/in/HomeAddress/MobilePhoneNumber' => 'MyTypes::PhoneNumber',
               'ListPerson/in/Name' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'ListPersonResponse/out/NewElement/PersonID' => 'MyTypes::PersonID',
               'ListPersonResponse/out/NewElement/WorkAddress/MobilePhoneNumber' => 'MyTypes::PhoneNumber',
               'ListPersonResponse/out' => 'MyTypes::ArrayOfPerson',
               'ListPerson/in/Contracts/Contract' => 'MyTypes::Contract',
               'ListPersonResponse/out/NewElement/Name' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'ListPersonResponse/out/NewElement/WorkAddress/ZIP' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'ListPerson/in/DateOfBirth' => 'SOAP::WSDL::XSD::Typelib::Builtin::date',
               'ListPersonResponse/out/NewElement/HomeAddress/MobilePhoneNumber' => 'MyTypes::PhoneNumber',
               'ListPersonResponse/out/NewElement/HomeAddress/Country' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'Fault/faultstring' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'ListPersonResponse/out/NewElement/HomeAddress/Street' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'ListPersonResponse/out/NewElement/Contracts/Contract/ContractName' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'Fault' => 'SOAP::WSDL::SOAP::Typelib::Fault11',
               'ListPerson/in/Contracts/Contract/ContractName' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'ListPersonResponse' => 'MyElements::ListPersonResponse',
               'ListPersonResponse/out/NewElement/Salutation' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'ListPersonResponse/out/NewElement/WorkAddress/City' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'Fault/faultactor' => 'SOAP::WSDL::XSD::Typelib::Builtin::token',
               'ListPerson' => 'MyElements::ListPerson',
               'ListPerson/in/Salutation' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'ListPerson/in/WorkAddress/MobilePhoneNumber' => 'MyTypes::PhoneNumber',
               'Fault/detail' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'ListPerson/in/WorkAddress/Country' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'ListPerson/in/PersonID' => 'MyTypes::PersonID',
               'ListPerson/in/HomeAddress/ZIP' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'ListPersonResponse/out/NewElement/WorkAddress' => 'MyTypes::Address',
               'ListPersonResponse/out/NewElement/DateOfBirth' => 'SOAP::WSDL::XSD::Typelib::Builtin::date',
               'ListPerson/in/WorkAddress/PhoneNumber' => 'MyTypes::PhoneNumber',
               'ListPersonResponse/out/NewElement/WorkAddress/Country' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'ListPersonResponse/out/NewElement/Contracts/Contract/ContractID' => 'SOAP::WSDL::XSD::Typelib::Builtin::long',
               'ListPerson/in/Contracts/Contract/ContractID' => 'SOAP::WSDL::XSD::Typelib::Builtin::long',
               'ListPerson/in/WorkAddress' => 'MyTypes::Address'
             };
;

sub get_class {
  my $name = join '/', @{ $_[1] };
  exists $typemap_1->{ $name } or die "Cannot resolve $name via " . __PACKAGE__;
  return $typemap_1->{ $name };
}

sub get_typemap {
    return $typemap_1;
}

1;

__END__

=pod

=head1 NAME

MyTypemaps::TestService; - typemap for ::TestService;

=head1 DESCRIPTION

Typemap created by SOAP::WSDL for map-based SOAP message parsers.

=cut

