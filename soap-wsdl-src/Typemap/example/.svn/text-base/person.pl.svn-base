use strict;
use warnings;
use lib 'lib';
use MyInterfaces::TestService::TestPort;

my $soap = MyInterfaces::TestService::TestPort->new();

my $result = $soap->ListPerson({})
    or die "error calling SOAP method";

print "Found " . @{ $result->get_out()->get_NewElement } . " persons\n";

