package SOAP::WSDL::XSD::Attribute;
use strict;
use warnings;
use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::Base);

use version; our $VERSION = qv('2.00.99_3');

#<attribute
#  default = string
#  fixed = string
#  form = (qualified | unqualified)
#  id = ID
#  name = NCName
#  ref = QName
#  type = QName
#  use = (optional | prohibited | required) : optional
#  {any attributes with non-schema namespace . . .}>
#  Content: (annotation?, (simpleType?))
#</attribute>

# id provided by Base
# name provided by Base
# annotation provided by Base

my %default_of      :ATTR(:name<default>    :default<()>);
my %fixed_of        :ATTR(:name<fixed>      :default<()>);
my %form_of         :ATTR(:name<form>       :default<()>);

my %type_of         :ATTR(:name<type>       :default<()>);
my %use_of          :ATTR(:name<use>        :default<()>);
my %ref_of          :ATTR(:name<ref>        :default<()>);

# may be defined as atomic simpleType
my %simpleType_of   :ATTR(:name<simpleType> :default<()>);

1;