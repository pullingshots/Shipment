package SOAP::WSDL::XSD::Typelib::Builtin::list;
use strict;
use warnings;

sub serialize {
    my ($self, $opt) = @_;
    $opt = {} if not $opt;
    my $value = $self->get_value();
    return $self->start_tag({ %$opt, nil => 1 }) if not defined $value;
    $value = [ $value ] if not ref $value;
    return join q{}, $self->start_tag($opt, $value)
        , join( q{ }, @{ $value } )
        , $self->end_tag($opt, $value);
}
1;

__END__

=pod

=head1 NAME

SOAP::WSDL::XSD::Typelib::Builtin::list - list derivation base class

=head1 DESCRIPTION

To derive from some class by list, just inherit from list.

Make sure SOAP::WSDL::XSD::Typelib::Builtin::list is before the type
to derive from in the @ISA list.

=head1 LICENSE AND COPYRIGHT

Copyright (c) 2007 Martin Kutter. All rights reserved.

This file is part of SOAP-WSDL. You may distribute/modify it under
the same terms as perl itself

=head1 AUTHOR

Martin Kutter E<lt>martin.kutter fen-net.deE<gt>

=cut