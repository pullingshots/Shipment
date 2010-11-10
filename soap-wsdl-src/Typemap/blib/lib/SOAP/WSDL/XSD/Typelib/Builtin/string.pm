package SOAP::WSDL::XSD::Typelib::Builtin::string;
use strict;
use warnings;
use Class::Std::Fast::Storable constructor => 'none', cache => 1;
use base qw(SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType);

my %char2entity = (
    q{&} => q{&amp;},
    q{<} => q{&lt;},
    q{>} => q{&gt;},
    q{"} => q{&quot;},
    q{'} => q{&apos;},
);

# sub get_xmltype { "xs:string" }

sub serialize {
    $_[1] ||= {};

    my $value = $_[0]->get_value();

    return $_[0]->start_tag({ %{ $_[1] }, nil => 1})
        if not defined $value;

    # HTML::Entities does the same - and more, thus it's around 1/3 slower...
    $value =~ s{([&<>"'])}{$char2entity{$1}}xgmso;

    return join q{}, $_[0]->start_tag($_[1], $value)
        #, encode_entities( $value, q{&<>"'} )
        , $value
        , $_[0]->end_tag($_[1]);
}

sub as_bool :BOOLIFY {
    return $_[0]->get_value();
}

Class::Std::initialize();
1;
