package SOAP::WSDL::XSD::Element;
use strict;
use warnings;
use Class::Std::Fast::Storable;
use base qw(SOAP::WSDL::Base);

use version; our $VERSION = qv('2.00.99_3');

# id provided by Base
# name provided by Base
# annotation provided by Base
my %simpleType_of   :ATTR(:name<simpleType> :default<()>);
my %complexType_of  :ATTR(:name<complexType> :default<()>);
my %facet_of        :ATTR(:name<facet>      :default<()>);
my %type_of         :ATTR(:name<type>       :default<()>);
my %abstract_of     :ATTR(:name<abstract>   :default<()>);
my %block_of        :ATTR(:name<block>      :default<()>);
my %default_of      :ATTR(:name<default>    :default<()>);
my %final_of        :ATTR(:name<final>      :default<()>);
my %fixed_of        :ATTR(:name<fixed>      :default<()>);
my %form_of         :ATTR(:name<form>       :default<()>);
my %maxOccurs_of    :ATTR(:name<maxOccurs>  :default<()>);
my %minOccurs_of    :ATTR(:name<minOccurs>  :default<()>);
my %nillable_of     :ATTR(:name<nillable>   :default<()>);
my %ref_of          :ATTR(:name<ref>        :default<()>);
my %substitutionGroup_of :ATTR(:name<substitutionGroup> :default<()>);

sub first_simpleType {
    my $result_ref = $simpleType_of{ ident shift };
    return if not $result_ref;
    return $result_ref if (not ref $result_ref eq 'ARRAY');
    return $result_ref->[0];
}

sub first_complexType {
    my $result_ref = $complexType_of{ ident shift };
    return if not $result_ref;
    return $result_ref if (not ref $result_ref eq 'ARRAY');
    return $result_ref->[0];
}

# serialize type instead...
sub serialize {
    my ($self, $name, $value, $opt) = @_;
    my $type;
    my $typelib = $opt->{ typelib };
    my %ns_map = %{ $opt->{ namespace } };
    my $ident = ident $self;

    # abstract elements may only be serialized via ref - and then we have a
    # name...
    die "cannot serialize abstract element" if $abstract_of{ $ident }
        and not $name;

    # TODO: implement final and substitutionGroup - maybe never implement
    # substitutionGroup ?

    $name = $self->get_name() if not ($name);

    if ( $opt->{ qualify } ) {
        $opt->{ attributes } = [ ' xmlns="' . $self->get_targetNamespace .'"' ];
    }


    # set default and fixed - fixed overrides everything,
    # default only empty (undefined) values
    if (not defined $value)     {
      $value = $default_of{ ident $self } if $default_of{ ident $self };
    }
    $value = $fixed_of{ ident $self } if $fixed_of{ ident $self };

    # TODO check nillable and serialize empty data correctly

    # return if minOccurs is 0 and we have no value
    if (defined $minOccurs_of{ ident $self }
        and $minOccurs_of{ ident $self } == 0) {
        return q{} if not defined $value;
    }

    # handle direct simpleType and complexType here
    if ($type = $self->first_simpleType() ) {             # simpleType
        return $type->serialize( $name, $value, $opt );
    }
    elsif ($type = $self->first_complexType() ) {           # complexType
        return $type->serialize( $name, $value, $opt );
    }
    elsif (my $ref_name = $ref_of{ $ident }) {              # ref
        my ($prefix, $localname) = split /:/ , $ref_name;
        my $ns = $ns_map{ $prefix };
        $type = $typelib->find_element( $ns, $localname );
        die "no element for ref $prefix:$localname" if (not $type);
        return $type->serialize( $name, $value, $opt );
    }

    # lookup type
    my ($prefix, $localname) = split /:/ , $self->get_type();
    my $ns = $ns_map{ $prefix };
    $type = $typelib->find_type(
        $ns, $localname
    );

    # safety check
    die "no type for $prefix:$localname $ns_map{$prefix}" if (not $type);

    return $type->serialize( $name, $value, $opt );
}

1;

