package ComplexType;
use strict; use warnings;
use lib '.';
our $VERSION = 0.1;
use base qw(SOAP::WSDL::XSD::Typelib::Element
    SOAP::WSDL::XSD::Typelib::ComplexType);

sub get_xmlns { 'http://www.w3.org/XMLSchema2001' }
sub __get_attr_class { 'ComplexType::_ATTR' }
__PACKAGE__->__set_name('ComplexType');

my %sequence_of :ATTR(:name<sequence> :default<()>);

__PACKAGE__->_factory(
    [   'sequence'    ],
    {
        sequence => \%sequence_of,
    },
    {
        sequence => 'sequence',
    },
    {
        sequence => 'sequence',
    },

);

package ComplexType::_ATTR;
use base qw(SOAP::WSDL::XSD::Typelib::AttributeSet);

my %name_of :ATTR(:name<name> :default<()>);

__PACKAGE__->_factory(
    [ 'name' ],
    {
        name => \%name_of
    },
    {
        name => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    },
    {
        name => 'name',
    }
);

1;
use sequence;
use element;

my $foo = element->new({
    xmlattr => {
        name => 'foo',
        type => 'string'
    }
});

my $bar = element->new({
    xmlattr => {
        name => 'bar',
        type => 'string',
    },

});

my $type = ComplexType->new({
    xmlattr => { name => 'Test' },
    sequence => {
        element => [ $foo, $bar ],
    }
});


print $type->serialize_qualified(), "\n";

use Data::Dumper;
print Dumper $type->as_hash_ref();

