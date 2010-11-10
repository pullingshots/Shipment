# Accessing the globalweather service at
# www.webservicex.net/GlobalWeather/GlobalWeather.asmx
#
# Note that the GlobalWeather web service returns a (quoted) XML structure - 
# don't be surprised by the response's format.
#
# I have no connection to www.webservicex.net
# Use this script at your own risk.
#
# This script demonstrates the use of SOAP::WSDL in SOAP::Lite style.

use lib 'lib/';
use lib '../lib';
use File::Basename qw(dirname);
use File::Spec;
my $path = File::Spec->rel2abs( dirname __FILE__);

# SOAP::WSDL variant
use SOAP::WSDL;
my $soap = SOAP::WSDL->new();
my $som = $soap->wsdl("file:///$path/wsdl/globalweather.xml")
  ->call('GetWeather', GetWeather => 
    { CountryName => 'Germany', CityName => 'Munich' }
);

die "Error" if $som->fault();
print $som->result();

# SOAP::Lite variant:
# Note that you have to look both the proxy and the xmlns attribute 
# set on the GetWeather SOAP::Data object from the WSDL.

use SOAP::Lite +trace;
$soap = SOAP::Lite->new()->on_action( sub { join'/', @_ } )
  ->proxy("http://www.webservicex.net/globalweather.asmx");     # from WSDL
$som = $soap->call(
    SOAP::Data->name('GetWeather')
        ->attr({ xmlns => 'http://www.webserviceX.NET' }),      # from WSDL
    SOAP::Data->name('CountryName')->value('Germany'), 
    SOAP::Data->name('CityName')->value('Munich') 
);
die "Error" if $som->fault();
print $som->result();
