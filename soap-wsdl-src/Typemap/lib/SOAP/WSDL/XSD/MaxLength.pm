package SOAP::WSDL::XSD::MaxLength;
use strict;
use warnings;
use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::Base);

use version; our $VERSION = qv('2.00.99_3');

#<maxLength value="">

# id provided by Base
# name provided by Base
# annotation provided by Base

# may be defined as atomic simpleType
my %value_of        :ATTR(:name<value> :default<()>);
my %fixed_of        :ATTR(:name<fixed> :default<()>);

1;