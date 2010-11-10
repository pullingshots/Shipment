package SOAP::WSDL::XSD::Typelib::Attribute;
use strict;
use warnings;

use base qw(SOAP::WSDL::XSD::Typelib::Element);

use version; our $VERSION = qv('2.00.99_3');

sub start_tag {
    # my ($self, $opt, $value) = @_;
    return q{} if (@_ < 3);
    my $ns = $_[0]->get_xmlns();
    if ($ns eq 'http://www.w3.org/XML/1998/namespace') {
        return qq{ xml:$_[1]->{ name }="};
    }
    return qq{ $_[1]->{ name }="};
}

sub end_tag {
    return q{"};
}

1;