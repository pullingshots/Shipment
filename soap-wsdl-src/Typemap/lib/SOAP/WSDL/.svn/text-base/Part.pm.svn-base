package SOAP::WSDL::Part;
use strict;
use warnings;
use Carp qw(croak);
use Class::Std::Fast::Storable;

use base qw(SOAP::WSDL::Base);

use version; our $VERSION = qv('2.00.99_3');

my %element_of  :ATTR(:name<element>    :default<()>);
my %type_of     :ATTR(:name<type>       :default<()>);

sub serialize
{
    my $self = shift;
    my $name = shift;
    my $data = shift;
    my $opt = shift;
    my $typelib = $opt->{ typelib } || die "No typelib";
    my %ns_map = %{ $opt->{ namespace } };

    my $item_name;
    if ($item_name = $self->get_type() ) {
        # resolve type
        my ($prefix, $localname) = split /:/ , $item_name, 2;
        my $type = $typelib->find_type( $ns_map{ $prefix }, $localname)
          or die "type $item_name , $ns_map{ $prefix } not found";

        my $name = $self->get_name();
        return $type->serialize( $name, $data->{ $name }, $opt );
    }
    elsif ( $item_name = $self->get_element() ) {
        my ($prefix, $localname) = split /:/ , $item_name, 2;
        my $element = $typelib->find_element(
            $ns_map{ $prefix },
            $localname
        )
            or die "element $item_name , $ns_map{ $prefix } not found";
        $opt->{ qualify } = 1;
        return $element->serialize( undef, $data->{ $element->get_name() }, $opt );
    }
    die "Neither type nor element - don't know what to do";
}

1;
