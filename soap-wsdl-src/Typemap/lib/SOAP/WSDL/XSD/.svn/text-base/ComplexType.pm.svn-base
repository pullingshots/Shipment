package SOAP::WSDL::XSD::ComplexType;
use strict;
use warnings;
use Class::Std::Fast::Storable;
use Scalar::Util qw(blessed);
use base qw(SOAP::WSDL::Base);

use version; our $VERSION = qv('2.00.99_3');

# id provided by Base
# name provided by Base
# annotation provided by Base
my %length_of           :ATTR(:name<length>         :default<[]>);
my %minLength_of        :ATTR(:name<minLength>      :default<[]>);
my %maxLength_of        :ATTR(:name<maxLength>      :default<[]>);
my %pattern_of          :ATTR(:name<pattern>        :default<[]>);
my %enumeration_of      :ATTR(:name<enumeration>    :default<[]>);
my %whiteSpace_of       :ATTR(:name<whiteSpace>     :default<[]>);
my %totalDigits_of      :ATTR(:name<totalDigits>    :default<[]>);
my %fractionDigits_of   :ATTR(:name<fractionDigits>    :default<[]>);
my %minExclusive        :ATTR(:name<minExclusive>   :default<[]>);
my %minInclusive        :ATTR(:name<minInclusive>   :default<[]>);
my %maxExclusive        :ATTR(:name<maxExclusive>   :default<[]>);
my %maxInclusive        :ATTR(:name<maxInclusive>   :default<[]>);


my %attribute_of    :ATTR(:name<attribute>  :default<()>);
my %element_of      :ATTR(:name<element>    :default<[]>);
my %group_of        :ATTR(:name<group>      :default<()>);
my %variety_of      :ATTR(:name<variety>    :default<()>);
my %base_of         :ATTR(:name<base>       :default<()>);
my %itemType_of     :ATTR(:name<itemType>   :default<()>);
my %abstract_of     :ATTR(:name<abstract>   :default<()>);
my %final_of        :ATTR(:name<final>      :default<()>);
my %mixed_of        :ATTR(:name<mixed>      :default<()>);      # default is false

my %derivation_of   :ATTR(:name<derivation> :default<()>);

# is set to simpleContent/complexContent
my %content_model_of    :ATTR(:name<contentModel>   :default<NONE>);

sub get_flavor; *get_flavor = \&get_variety;

sub push_element {
    my $self = shift;
    my $element = shift;
    if ($variety_of{ ident $self } eq 'all')
    {
        $element->set_minOccurs(0) if not defined ($element->get_minOccurs);
        $element->set_maxOccurs(1) if not defined ($element->get_maxOccurs);
    }
    elsif ($variety_of{ ident $self } eq 'sequence')
    {
        $element->set_minOccurs(1) if not defined ($element->get_minOccurs);
        $element->set_maxOccurs(1) if not defined ($element->get_maxOccurs);
    }
    push @{ $element_of{ ident $self } }, $element;
}

sub set_restriction {
    my $self = shift;
    my $element = shift;
    $variety_of{ ident $self } = 'restriction';
    $derivation_of{ ident $self } = 'restriction';
    $base_of{ ident $self } = $element->{ Value };
}

sub set_extension {
    my $self = shift;
    my $element = shift;
    $variety_of{ ident $self } = 'extension';
    $derivation_of{ ident $self } = 'extension';
    $base_of{ ident $self } = $element->{ Value };
}

sub init {
    my $self = shift;
    my @args = @_;
    $self->SUPER::init( @args );
}

sub serialize {
    my ($self, $name, $value, $opt) = @_;

    $opt->{ indent } ||= q{};
    $opt->{ attributes } ||= [];
    my $variety = $self->get_variety();
    my $xml = ($opt->{ readable }) ? $opt->{ indent } : q{};    # add indentation

    if ( $opt->{ qualify } ) {
        $opt->{ attributes } = [ ' xmlns="' . $self->get_targetNamespace .'"' ];
        delete $opt->{ qualify };
    }

    $xml .= join q{ } , "<$name" , @{ $opt->{ attributes } };
    delete $opt->{ attributes };                                # don't propagate...

    if ( $opt->{ autotype }) {
        my $ns = $self->get_targetNamespace();
        # reverse namespace by prefix hash
        my %prefix_of = reverse %{ $opt->{ namespace } };
        my $prefix = $prefix_of{ $ns }
            || die 'No prefix found for namespace '. $ns;
        $xml .= join q{}, " type=\"$prefix:", $self->get_name(), '" '
            if ($self->get_name() );
    }
    $xml .= '>';
    $xml .= "\n" if ( $opt->{ readable } );                 # add linebreak

    if ($self->schema) {
        if ($self->schema()->get_elementFormDefault() ne "qualified") {
            push @{$opt->{ attributes } }, q{xmlns=""}
                if ($self->get_targetNamespace() ne "");
        }
    }
    if ( ($variety eq "sequence") or ($variety eq "all") ) {
        $opt->{ indent } .= "\t";
        for my $element (@{ $self->get_element() }) {
            # resolve element ref
            #
            # Basic algorithm is like this:
            # If on serialization, we meet a element whose get_ref method
            # returns a true value, lookup the element from the <types>
            # definitions instead, and serialize this element.
            #
            if (my $ref = $element->get_ref()) {
                $element = $opt->{ typelib }->find_element(
                    $element->expand($ref)
                );
            }

            # might be list - listify
            $value = [ $value ] if not ref $value eq 'ARRAY';

            for my $single_value (@{ $value }) {
                my $element_value;
                if (blessed $single_value) {
                    my $method = 'get_' . $element->get_name();
                    $element_value = $single_value->$method();
                }
                else {
                    $element_value = $single_value->{ $element->get_name() };
                }
                $element_value = [ $element_value ]
                    if not ref $element_value eq 'ARRAY';

                $xml .= join q{}
                    , map { $element->serialize( undef, $_, $opt ) }
                       @{ $element_value };
            }
        }
        $opt->{ indent } =~s/\t$//;
    }
    else {
        die "sorry, we just handle all and sequence types yet...";
    }
    $xml .= $opt->{ indent } if ( $opt->{ readable } ); # add indentation
    $xml .= '</' . $name . '>';
    $xml .= "\n" if ($opt->{ readable } );              # add linebreak
    return $xml;
}

1;

