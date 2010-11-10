package MyTypemaps::BarCode;
use strict;
use warnings;

our $typemap_1 = {
               'GenerateBarCode/BarCodeText' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GenerateBarCode/BarCodeParam/BarColor' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GenerateBarCode/BarCodeParam/barcodeOption' => 'MyTypes::BarcodeOption',
               'GenerateBarCode/BarCodeParam/Left' => 'SOAP::WSDL::XSD::Typelib::Builtin::int',
               'Fault/faultcode' => 'SOAP::WSDL::XSD::Typelib::Builtin::anyURI',
               'GenerateBarCode' => 'MyElements::GenerateBarCode',
               'Fault/faultstring' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GenerateBarCode/BarCodeParam/Angle' => 'SOAP::WSDL::XSD::Typelib::Builtin::int',
               'GenerateBarCode/BarCodeParam/Width' => 'SOAP::WSDL::XSD::Typelib::Builtin::int',
               'Fault' => 'SOAP::WSDL::SOAP::Typelib::Fault11',
               'GenerateBarCode/BarCodeParam/BarCodeImageFormat' => 'MyTypes::ImageFormats',
               'GenerateBarCode/BarCodeParam/BGColor' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GenerateBarCode/BarCodeParam/Ratio' => 'SOAP::WSDL::XSD::Typelib::Builtin::int',
               'Fault/faultactor' => 'SOAP::WSDL::XSD::Typelib::Builtin::token',
               'GenerateBarCode/BarCodeParam/Height' => 'SOAP::WSDL::XSD::Typelib::Builtin::int',
               'GenerateBarCode/BarCodeParam/CheckSum' => 'SOAP::WSDL::XSD::Typelib::Builtin::boolean',
               'GenerateBarCode/BarCodeParam/checkSumMethod' => 'MyTypes::CheckSumMethod',
               'Fault/detail' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GenerateBarCode/BarCodeParam/barcodeType' => 'MyTypes::BarcodeType',
               'GenerateBarCode/BarCodeParam/FontSize' => 'SOAP::WSDL::XSD::Typelib::Builtin::float',
               'GenerateBarCode/BarCodeParam/Top' => 'SOAP::WSDL::XSD::Typelib::Builtin::int',
               'GenerateBarCodeResponse/GenerateBarCodeResult' => 'SOAP::WSDL::XSD::Typelib::Builtin::base64Binary',
               'GenerateBarCodeResponse' => 'MyElements::GenerateBarCodeResponse',
               'GenerateBarCode/BarCodeParam/Module' => 'SOAP::WSDL::XSD::Typelib::Builtin::int',
               'GenerateBarCode/BarCodeParam/showTextPosition' => 'MyTypes::ShowTextPosition',
               'GenerateBarCode/BarCodeParam' => 'MyTypes::BarCodeData',
               'GenerateBarCode/BarCodeParam/FontName' => 'SOAP::WSDL::XSD::Typelib::Builtin::string'
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

MyTypemaps::BarCode; - typemap for ::BarCode;

=head1 DESCRIPTION

Typemap created by SOAP::WSDL for map-based SOAP message parsers.

=cut

