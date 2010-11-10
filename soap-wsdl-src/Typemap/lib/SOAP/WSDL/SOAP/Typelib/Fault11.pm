package SOAP::WSDL::SOAP::Typelib::Fault11;
{
    use strict;
    use warnings;
    use Class::Std::Fast::Storable constructor => 'none';

    use version; our $VERSION = qv('2.00.99_3');

    use Scalar::Util qw(blessed);

    use SOAP::WSDL::XSD::Typelib::ComplexType;
    use SOAP::WSDL::XSD::Typelib::Element;

    use base qw(
      SOAP::WSDL::SOAP::Typelib::Fault
      SOAP::WSDL::XSD::Typelib::Element
      SOAP::WSDL::XSD::Typelib::ComplexType
    );

    my %faultcode_of : ATTR(:get<faultcode>);
    my %faultstring_of : ATTR(:get<faultstring>);
    my %faultactor_of : ATTR(:get<faultactor>);
    my %detail_of : ATTR(:get<detail>);

    __PACKAGE__->_factory(
        [qw(faultcode faultstring faultactor detail)],
        {
            faultcode   => \%faultcode_of,
            faultstring => \%faultstring_of,
            faultactor  => \%faultactor_of,
            detail      => \%detail_of,
        },
        {
            faultcode   => 'SOAP::WSDL::XSD::Typelib::Builtin::QName',
            faultstring => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
            faultactor  => 'SOAP::WSDL::XSD::Typelib::Builtin::anyURI',
            detail      => 'SOAP::WSDL::SOAP::Typelib::Fault11Detail',
        } );

    sub get_xmlns { return 'http://schemas.xmlsoap.org/soap/envelope/' }

    __PACKAGE__->__set_name('Fault');
    __PACKAGE__->__set_nillable(0);
    __PACKAGE__->__set_minOccurs();
    __PACKAGE__->__set_maxOccurs();
    __PACKAGE__->__set_ref('');

    # always return false in boolean context - a fault is never true...
    sub as_bool : BOOLIFY {
        return;
    }

    # override set_detail to allow "auto-vivification" of a details object
    # must be implemented via symbol table operation - _factory adds
    # methods via symbol table, too.

    # BLOCK to scope warnings
    {
        no warnings qw(redefine);
        my $set_detail_sub = \&set_detail;
        *set_detail = sub {
            my ( $self, $detail ) = @_;

            # create SOAP::WSDL::SOAP::Typelib::Fault11Detail wrapper if there
            # is none
            if (   not blessed $detail
                or
                not $detail->isa('SOAP::WSDL::SOAP::Typelib::Fault11Detail') )
            {
                $detail = SOAP::WSDL::SOAP::Typelib::Fault11Detail->new(
                    {value => $detail} );
            }

            # call original method
            $set_detail_sub->( $self, $detail );
        };
    }
    Class::Std::initialize();
}

package SOAP::WSDL::SOAP::Typelib::Fault11Detail;
{
    use strict;
    use warnings;
    use Class::Std::Fast::Storable constructor => 'none';
    use base qw(
      SOAP::WSDL::XSD::Typelib::Element
      SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType
    );

    sub get_xmlns { return 'http://schemas.xmlsoap.org/soap/envelope/' }

    __PACKAGE__->__set_name('Fault');
    __PACKAGE__->__set_nillable(0);
    __PACKAGE__->__set_minOccurs();
    __PACKAGE__->__set_maxOccurs();
    Class::Std::initialize();
}

1;

=pod

=head1 NAME

SOAP::WSDL::SOAP::Typelib::Fault11 - SOAP 1.1 Fault class

=head1 DESCRIPTION

Models a SOAP 1.1 Fault.

SOAP::WSDL::SOAP::Typelib::Fault11 objects are false in boolean context
and serialize to XML on stringification.

This means you can do something like:

 my $soap = SOAP::WSDL::Client->new();
 # ...
 my $result = $soap->call($method, $data);
 if (not $result) {
     die "Error calling SOAP method: ", $result->get_faultstring();
 }

=head1 METHODS

=head2 get_faultcode / set_faultcode

Getter/setter for object's faultcode property.

=head2 get_faultstring / set_faultstring

Getter/setter for object's faultstring property.

=head2 get_faultactor / set_faultactor

Getter/setter for object's faultactor property.

=head2 get_detail / set_detail

Getter/setter for detail object's detail property.

The detail element is a SOAP::WSDL::SOAP::Typelib::Fault11Detail object.
This class is automatically loaded when using
SOAP::WSDL::SOAP::Typelib::Fault11, so you can't B<use> it separately.

Any string or object not of this class will be automatically wrapped into
a detail object.

Note that passing a list of detail object is currently not supported (though
the SOAP1.1 note allows this).

=head1 LICENSE AND COPYRIGHT

Copyright 2007 Martin Kutter. All rights reserved.

This file is part of SOAP-WSDL. You may distribute/modify it under
the same terms as perl itself

=head1 AUTHOR

Martin Kutter E<lt>martin.kutter fen-net.deE<gt>

=head1 REPOSITORY INFORMATION

 $Rev: 861 $
 $LastChangedBy: kutterma $
 $Id: Fault11.pm 861 2010-03-28 10:41:26Z kutterma $
 $HeadURL: https://soap-wsdl.svn.sourceforge.net/svnroot/soap-wsdl/SOAP-WSDL/branches/Typemap/lib/SOAP/WSDL/SOAP/Typelib/Fault11.pm $

=cut

