package SOAP::WSDL::XSD::Group;
use strict;
use warnings;
use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::Base);

use version; our $VERSION = qv('2.00.99_3');

#<xs:group name="myModelGroup">
# <xs:sequence>
#  <xs:element ref="someThing"/>
#  . . .
# </xs:sequence>
#</xs:group>
#
#<xs:complexType name="trivial">
# <xs:group ref="myModelGroup"/>
# <xs:attribute .../>
#</xs:complexType>
#
#<xs:complexType name="moreSo">
# <xs:choice>
#  <xs:element ref="anotherThing"/>
#  <xs:group ref="myModelGroup"/>
# </xs:choice>
# <xs:attribute .../>
#</xs:complexType>

my %ref_of          :ATTR(:name<ref>      :default<()>);

my %maxOccurs_of    :ATTR(:name<maxOccurs>  :default<()>);
my %minOccurs_of    :ATTR(:name<minOccurs>  :default<()>);
my %annotation_of   :ATTR(:name<annotation> :default<()>);
my %element_of      :ATTR(:name<element>    :default<()>);
my %group_of        :ATTR(:name<group>      :default<()>);
my %variety_of      :ATTR(:name<variety>    :default<()>);

1;