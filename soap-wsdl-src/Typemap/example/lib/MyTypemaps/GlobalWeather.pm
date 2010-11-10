package MyTypemaps::GlobalWeather;
use strict;
use warnings;

our $typemap_1 = {
               'GetWeatherResponse/GetWeatherResult' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetWeather' => 'MyElements::GetWeather',
               'GetCitiesByCountryResponse/GetCitiesByCountryResult' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'Fault/faultactor' => 'SOAP::WSDL::XSD::Typelib::Builtin::token',
               'GetWeatherResponse' => 'MyElements::GetWeatherResponse',
               'Fault/detail' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'Fault/faultcode' => 'SOAP::WSDL::XSD::Typelib::Builtin::anyURI',
               'GetWeather/CityName' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetCitiesByCountry' => 'MyElements::GetCitiesByCountry',
               'Fault/faultstring' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetCitiesByCountry/CountryName' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetWeather/CountryName' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'Fault' => 'SOAP::WSDL::SOAP::Typelib::Fault11',
               'GetCitiesByCountryResponse' => 'MyElements::GetCitiesByCountryResponse'
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

MyTypemaps::GlobalWeather; - typemap for ::GlobalWeather;

=head1 DESCRIPTION

Typemap created by SOAP::WSDL for map-based SOAP message parsers.

=cut

