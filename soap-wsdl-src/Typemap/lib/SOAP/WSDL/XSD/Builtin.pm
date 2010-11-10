package SOAP::WSDL::XSD::Builtin;
use strict;
use warnings;
use Class::Std::Fast::Storable;
use base qw(SOAP::WSDL::Base);

use version; our $VERSION = qv('2.00.99_3');

# only used in SOAP::WSDL - will be obsolete once SOAP::WSDL uses the
# generative approach, too

sub serialize {
    my ($self, $name, $value, $opt) = @_;
    my $xml;
    $opt->{ indent } ||= "";
    $opt->{ attributes } ||= [];

    $xml .= $opt->{ indent } if ($opt->{ readable });
    $xml .= '<' . join ' ', $name, @{ $opt->{ attributes } };
    if ( $opt->{ autotype }) {
        my $ns = $self->get_targetNamespace();
        my %prefix_of = reverse %{ $opt->{ namespace } };
        my $prefix = $prefix_of{ $ns }
            || die 'No prefix found for namespace '. $ns;
        $xml .= ' type="' . $prefix . ':'
          . $self->get_name() . '"';
    }

    if (defined $value) {
        $xml .= '>';
        $xml .= "$value";
        $xml .= '</' . $name . '>' ;
    }
    else {
        $xml .= '/>';
    }
    $xml .= "\n" if ($opt->{ readable });
    return $xml;
}

1;
