package SOAP::WSDL::Binding;
use strict;
use warnings;
use Class::Std::Fast::Storable;

use base qw(SOAP::WSDL::Base);

use version; our $VERSION = qv('2.00.99_3');

my %operation_of    :ATTR(:name<operation> :default<()>);
my %type_of         :ATTR(:name<type> :default<()>);
my %transport_of    :ATTR(:name<transport> :default<()>);
my %style_of        :ATTR(:name<style> :default<()>);

1;
