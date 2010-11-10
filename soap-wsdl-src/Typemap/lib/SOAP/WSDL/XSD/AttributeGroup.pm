package SOAP::WSDL::XSD::AttributeGroup;
use strict;
use warnings;
use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::Base);

use version; our $VERSION = qv('2.00.99_3');

#<attributeGroup
#  id = ID
#  name = NCName
#  ref = QName
#  {any attributes with non-schema namespace . . .}>
#  Content: (annotation?, ((attribute | attributeGroup)*, anyAttribute?))
#</attributeGroup>

# id provided by Base
# name provided by Base
# annotation provided by Base

my %ref_of          :ATTR(:name<ref>        :default<()>);

# may be defined as atomic simpleType
my %attribute_of        :ATTR(:name<attribute> :default<()>);
my %attributeGroup_of   :ATTR(:name<attributeGroup> :default<()>);

1;