package SOAP::WSDL::Message;
use strict;
use warnings;
use Class::Std::Fast::Storable;
use base qw(SOAP::WSDL::Base);

use version; our $VERSION = qv('2.00.99_3');

my %part_of :ATTR(:name<part> :default<[]>);

1;
