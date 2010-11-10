# Accessing the fortune cookie service at
# www.fullerdata.com/FortuneCookie/FortuneCookie.asmx
#
# I have no connection to www.fullerdata.com 
# 
# Use this script at your own risk.

# Run before:
# D:\Eigene Dateien\Martin\SOAP-WSDL\trunk>perl -I../lib wsdl2perl.pl "file:///D:/
# Eigene Dateien/Martin/SOAP-WSDL/trunk/bin/FortuneCookie.xml"

use lib 'lib/';
use MyInterfaces::FullerData_x0020_Fortune_x0020_Cookie::FullerData_x0020_Fortune_x0020_CookieSoap;
my $cookieService = MyInterfaces::FullerData_x0020_Fortune_x0020_Cookie::FullerData_x0020_Fortune_x0020_CookieSoap->new();

my $cookie;
$cookie = $cookieService->GetFortuneCookie()
  or die "$cookie";

print $cookie->get_GetFortuneCookieResult()->get_value, "\n\n";

$cookie = $cookieService->GetSpecificCookie({ index => 23 })
  or die "$cookie";

print $cookie->get_GetSpecificCookieResult(), "\n";

# print $cookie;


=for demo:

# the same in SOAP lite (second call)
#

use SOAP::Lite;

my $lite = SOAP::Lite->new()->on_action(sub { join '/', @_ } )
  ->proxy('http://www.fullerdata.com/FortuneCookie/FortuneCookie.asmx');

$lite->call(
    SOAP::Data->name('GetSpecificCookie')
      ->attr({ 'xmlns', 'http://www.fullerdata.com/FortuneCookie/FortuneCookie.asmx' }), 
      SOAP::Data->name('index')->value(23) 
  );

die $soap->message() if ($soap->fault());
print $soap->result();