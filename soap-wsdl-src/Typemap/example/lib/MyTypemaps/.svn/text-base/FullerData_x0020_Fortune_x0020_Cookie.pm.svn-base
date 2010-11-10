
package MyTypemaps::FullerData_x0020_Fortune_x0020_Cookie;
use strict;
use warnings;

our $typemap_1 = {
               'GetFortuneCookie' => 'MyElements::GetFortuneCookie',
               'CountCookiesResponse/CountCookiesResult' => 'SOAP::WSDL::XSD::Typelib::Builtin::int',
               'Fault/faultcode' => 'SOAP::WSDL::XSD::Typelib::Builtin::anyURI',
               'readNodeCountResponse/readNodeCountResult' => 'SOAP::WSDL::XSD::Typelib::Builtin::int',
               'CountCookiesResponse' => 'MyElements::CountCookiesResponse',
               'Fault/faultstring' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetSpecificCookieResponse' => 'MyElements::GetSpecificCookieResponse',
               'GetFortuneCookieResponse' => 'MyElements::GetFortuneCookieResponse',
               'Fault' => 'SOAP::WSDL::SOAP::Typelib::Fault11',
               'GetSpecificCookie' => 'MyElements::GetSpecificCookie',
               'Fault/faultactor' => 'SOAP::WSDL::XSD::Typelib::Builtin::token',
               'CountCookies' => 'MyElements::CountCookies',
               'GetSpecificCookie/index' => 'SOAP::WSDL::XSD::Typelib::Builtin::int',
               'Fault/detail' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetFortuneCookieResponse/GetFortuneCookieResult' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'GetSpecificCookieResponse/GetSpecificCookieResult' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'readNodeCount' => 'MyElements::readNodeCount',
               'readNodeCountResponse' => 'MyElements::readNodeCountResponse'
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

__END__

=pod

=head1 NAME

MyTypemaps::FullerData_x0020_Fortune_x0020_Cookie - typemap for FullerData_x0020_Fortune_x0020_Cookie

=head1 DESCRIPTION

Typemap created by SOAP::WSDL for map-based SOAP message parsers.

=cut

