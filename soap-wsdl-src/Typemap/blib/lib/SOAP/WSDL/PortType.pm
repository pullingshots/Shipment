package SOAP::WSDL::PortType;
use strict;
use warnings;
use Class::Std::Fast::Storable;
use List::Util;
use base qw(SOAP::WSDL::Base);

use version; our $VERSION = qv('2.00.99_3');

my %operation_of :ATTR(:name<operation> :default<()>);

#
#=head2 find_operation
#
#$port_type->find_operation($namespace, $name)
#
#Returns the PortType's operation object matching the given namespace and
#name
#

sub find_operation {
    return List::Util::first {
        ( $_->get_targetNamespace() eq $_[1] ) && ( $_->get_name() eq $_[2] )
    } @{ $operation_of{ ${ $_[0] } } };
};

1;
