package SOAP::WSDL::XSD::Typelib::SimpleType;
use strict; use warnings;
use SOAP::WSDL::XSD::Typelib::Builtin;

use version; our $VERSION = qv('2.00.99_3');

package SOAP::WSDL::XSD::Typelib::SimpleType::restriction;
use strict;
use SOAP::WSDL::XSD::Typelib::Builtin;
use base qw(SOAP::WSDL::XSD::Typelib::SimpleType);

use version; our $VERSION = qv('2.00.99_3');

1;
__END__

=pod

=head1 NAME

SOAP::WSDL::XSD::Typelib::SimpleType - simpleType base class

=head1 DESCRIPTION

This module implements a base class for designing simple type classes
modelling XML Schema simpleType definitions.

=head1 SYNOPSIS

    # example simpleType derived by restriction
    # XSD would be:
    # <simpleType name="MySimpleType">
    #    <restriction base="xsd:string" />
    # </simpleType>
    package MySimpleType;
    use Class::Std::Fast::Storable constructor => 'none';
    # restriction base implemented via inheritance
    use SOAP::WSDL::XSD::Typelib::Builtin;
    use SOAP::WSDL::XSD::Typelib::SimpleType;
    use base qw(
        # derive by restriction
        'SOAP::WSDL::XSD::Typelib::SimpleType::restriction',
        # restriction base
        'SOAP::WSDL::XSD::Typelib::Builtin::string'
    );

    # example simpleType derived by list.
    # XSD would be:
    # <simpleType name="MySimpleListType">
    #    <list itemTipe="xsd:string" />
    # </simpleType>
    package MySimpleListType;
    use Class::Std::Fast::Storable constructor => 'none';
    # restriction base implemented via inheritance
    use SOAP::WSDL::XSD::Typelib::Builtin;
    use base ('SOAP::WSDL::XSD::Typelib::SimpleType',
        'SOAP::WSDL::XSD::Typelib::Builtin::list',        # derive by list
        'SOAP::WSDL::XSD::Typelib::Builtin::string'       # list itemType
    );

=head1 How to write your own simple type

Writing a simple type class is easy - all you have to do is setting up the
base classes correctly.

The following rules apply:

=over

=item * simpleType derived via list

simpleType classes derived via list must inherit from these classes in
exactly this order:

 SOAP::WSDL::XSD::Typelib::SimpleType
 SOAP::WSDL::XSD::Typelib::Builtin::list         # derive by list
 The::List::ItemType::Class                      # list itemType

The::List::ItemType::Class can either be a builtin class (see
SOAP::WSDL::XSD::Builtin) or another simpleType class (any other class
implementing the right methods is supported too, but not for the
faint of heart).

=item * simpleType derived via restriction

simpleType classes derived via restriction must inherit from these classes in
exactly this order:

 SOAP::WSDL::XSD::Typelib::SimpleType               # you may leave this out
 SOAP::WSDL::XSD::Typelib::SimpleType::restriction  # derive by restriction
 The::Restriction::Base::Class                      # restriction base

The::Restriction::Base::Class can either be a builtin class (see
SOAP::WSDL::XSD::Builtin) or another simpleType class.

The slight inconsistency between the these variants is caused by the
restriction element, which has different meanings for simpleType and
complexType definitions.

=back

=head1 BUGS AND LIMITATIONS

=over

=item * Thread safety

SOAP::WSDL::XSD::Typelib::SimpleType uses Class::Std::Fast::Storable which uses
Class::Std. Class::Std is not thread safe, so
SOAP::WSDL::XSD::Typelib::SimpleType is neither.

=item * union

union simple types are not supported yet.

=item * XML Schema facets

No facets are implemented yet.

=back

=head1 LICENSE AND COPYRIGHT

Copyright 2004-2007 Martin Kutter.

This file is part of SOAP-WSDL. You may distribute/modify it under the same
terms as perl itself

=head1 AUTHOR

Martin Kutter E<lt>martin.kutter fen-net.deE<gt>

=head1 REPOSITORY INFORMATION

 $Rev: 861 $
 $LastChangedBy: kutterma $
 $Id: SimpleType.pm 861 2010-03-28 10:41:26Z kutterma $
 $HeadURL: https://soap-wsdl.svn.sourceforge.net/svnroot/soap-wsdl/SOAP-WSDL/branches/Typemap/lib/SOAP/WSDL/XSD/Typelib/SimpleType.pm $

=cut

