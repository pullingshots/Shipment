use strict;
use warnings;
use Test::More tests => 2; #qw(no_plan);

use_ok qw(SOAP::WSDL::XSD::AttributeGroup);

ok my $group = SOAP::WSDL::XSD::AttributeGroup->new();
