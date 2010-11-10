package SOAP::WSDL::XSD::Typelib::Builtin;
use strict;
use warnings;
use Class::Std::Fast::Storable;

use version; our $VERSION = qv('2.00.99_3');

use SOAP::WSDL::XSD::Typelib::Builtin::anyType;
use SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType;
use SOAP::WSDL::XSD::Typelib::Builtin::anyURI;
use SOAP::WSDL::XSD::Typelib::Builtin::base64Binary;
use SOAP::WSDL::XSD::Typelib::Builtin::boolean;
use SOAP::WSDL::XSD::Typelib::Builtin::byte;
use SOAP::WSDL::XSD::Typelib::Builtin::date;
use SOAP::WSDL::XSD::Typelib::Builtin::dateTime;
use SOAP::WSDL::XSD::Typelib::Builtin::decimal;
use SOAP::WSDL::XSD::Typelib::Builtin::double;
use SOAP::WSDL::XSD::Typelib::Builtin::duration;
use SOAP::WSDL::XSD::Typelib::Builtin::ENTITY;
use SOAP::WSDL::XSD::Typelib::Builtin::float;
use SOAP::WSDL::XSD::Typelib::Builtin::gDay;
use SOAP::WSDL::XSD::Typelib::Builtin::gMonth;
use SOAP::WSDL::XSD::Typelib::Builtin::gMonthDay;
use SOAP::WSDL::XSD::Typelib::Builtin::gYear;
use SOAP::WSDL::XSD::Typelib::Builtin::gYearMonth;
use SOAP::WSDL::XSD::Typelib::Builtin::hexBinary;
use SOAP::WSDL::XSD::Typelib::Builtin::ID;
use SOAP::WSDL::XSD::Typelib::Builtin::IDREF;
use SOAP::WSDL::XSD::Typelib::Builtin::IDREFS;
use SOAP::WSDL::XSD::Typelib::Builtin::int;
use SOAP::WSDL::XSD::Typelib::Builtin::integer;
use SOAP::WSDL::XSD::Typelib::Builtin::language;
use SOAP::WSDL::XSD::Typelib::Builtin::list;
use SOAP::WSDL::XSD::Typelib::Builtin::long;
use SOAP::WSDL::XSD::Typelib::Builtin::Name;
use SOAP::WSDL::XSD::Typelib::Builtin::NCName;
use SOAP::WSDL::XSD::Typelib::Builtin::negativeInteger;
use SOAP::WSDL::XSD::Typelib::Builtin::NMTOKEN;
use SOAP::WSDL::XSD::Typelib::Builtin::NMTOKENS;
use SOAP::WSDL::XSD::Typelib::Builtin::nonNegativeInteger;
use SOAP::WSDL::XSD::Typelib::Builtin::nonPositiveInteger;
use SOAP::WSDL::XSD::Typelib::Builtin::normalizedString;
use SOAP::WSDL::XSD::Typelib::Builtin::NOTATION;
use SOAP::WSDL::XSD::Typelib::Builtin::positiveInteger;
use SOAP::WSDL::XSD::Typelib::Builtin::QName;
use SOAP::WSDL::XSD::Typelib::Builtin::short;
use SOAP::WSDL::XSD::Typelib::Builtin::string;
use SOAP::WSDL::XSD::Typelib::Builtin::time;
use SOAP::WSDL::XSD::Typelib::Builtin::token;
use SOAP::WSDL::XSD::Typelib::Builtin::unsignedByte;
use SOAP::WSDL::XSD::Typelib::Builtin::unsignedInt;
use SOAP::WSDL::XSD::Typelib::Builtin::unsignedLong;
use SOAP::WSDL::XSD::Typelib::Builtin::unsignedShort;

1;

__END__

=pod

=head1 NAME

SOAP::WSDL::XSD::Typelib::Builtin - Built-in XML Schema datatypes

=head1 DESCRIPTION

The SOAP::WSDL::XSD::Typelib::Builtin hierarchy implements all builtin types
from the XML schema specification.

All XML schema derived types inherit from
SOAP::WSDL::XSD::Typelib::Builtin::anyType.

These basic type classes are most useful when used as element or simpleType
base classes.

Using SOAP::WSDL::XSD::Typelib::Builtin uses all of the builtin datatype
classes.

All builtin types feature common behaviour described below in
L</OVERLOADED OPERATORS>

=head1 EXAMPLES

 my $bool = SOAP::WSDL::XSD::Typelib::Builtin::bool->new({ value => 0} );
 print $bool;    # prints "true"

 # implements <simpleType name="MySimpleType">
 #               <list itemType="xsd:string" />
 #            </simpleType>
 package MySimpleType;
 use SOAP::WSDL::XSD::Typelib::Builtin;
 use SOAP::WSDL::XSD::Typelib::SimpleType;

 use base qw(SOAP::WSDL::XSD::Typelib::SimpleType
    SOAP::WSDL::XSD::Typelib::Builtin::list
    SOAP::WSDL::XSD::Typelib::Builtin::string
 );
 1;

 # somewhere else
 my $list = MySimpleType->new({ value => [ 'You', 'shall', 'overcome' ] });
 print $list;   # prints "You shall overcome"

=head1 CLASS HIERARCHY

This is the inheritance graph for builtin types.

Types with [] marker describe types derived via the item in [] in the XML
Schema specs.

Derivation is implemented via multiple inheritance with the derivation method
as first item in the base class list.

 anyType
 - anySimpleType
     - duration
     - dateTime
     - date
     - time
     - gYearMonth
     - gYear
     - gMonthDay
     - gDay
     - gMonth
     - boolean
     - base64Binary
     - hexBinary
     - float
     - decimal
         - integer
         - nonPositiveInteger
             - negativeInteger
         - nonNegativeInteger
             - positiveInteger
             - unsignedLong
             - unsignedInt
             - unsignedShort
             - unsignedByte
         - long
             - int
                 - short
                     - byte
     - double
     - anyURI
     - NOTATION
     - string
          - normalizedString
              - language
              - Name
                  - NCName
                      - ID
                      - IDREF
                          - IDREFS [list]
                      - ENTITY
              - token
                  - NMTOKEN
                      - NMTOKENS [list]

=head1 OVERLOADED OPERATORS

Overloading is implemented via Class::Std's trait mechanism.

The following behaviours apply:

=over

=item * string context

All classes use the C<serialize> method for stringification.

=item * bool context

All classes derived from anySimpleType return their value in bool context

=item * numeric context

The boolean class returns 0 or 1 in numeric context.

decimal, float and double (and derived classes) return their value in
numeric context.

=item * arrayification (@{})

When accessed as a list ref, objects of all classes return a list ref with
the object itself as single element.

This is most useful for writing loops without additional conversions,
especially in mini-languages found in templating systems or the like, which
may not natively support converting to list refs.

Instead of writing something like

 my $value = $complexType->get_ELEMENT;
 $value = ref $value eq 'ARRAY' ? $value : [ $value ];
 for (@{ $value }) { ... }

you can just write

 for (@{ $complexType->get_ELEMENT }) {...}

Note that complexTypes with undef elements still return undef when accessing
an undefined element, so when an element may be empty you still have to write
something like:

 my $value = $complexType->get_ELEMENT();
 if (defined $value) {
     for (@{ $value }) {
         ...
     }
 }

=back

=head1 Subclasses

=head2 SOAP::WSDL::XSD::Typelib::Builtin::anyType

Base class for all types

=head2 SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType

Base class for all simple types

=head2 SOAP::WSDL::XSD::Typelib::Builtin::anyURI

Type representing URIs

=head2 SOAP::WSDL::XSD::Typelib::Builtin::boolean

Represents boolean data.

Serializes to "true" or "false".

Everything true in perl and not "false" is deserialized as true.

Returns true/false in boolean context.

Returns 1 / 0 in numeric context.

boolean objects have a special method for deleting their value, because
calling C<setl_value(undef)> results in the value being set to false.

 $obj->delete_value();

=head2 SOAP::WSDL::XSD::Typelib::Builtin::byte

byte integer objects.

=head2 SOAP::WSDL::XSD::Typelib::Builtin::date

date values are automatically converted into XML date strings during setting:

 YYYY-MM-DD+zz:zz

The time zone is set to the local time zone if not included.

All input variants supported by Date::Parse are supported. You may even pass
in dateTime strings - the time part will be ignored. Note that
set_value is around 100 times slower when setting non-XML-time strings

When setting dates before the beginning of the epoch (negative UNIX timestamp),
you should use the XML date string format for setting dates. The behaviour of
Date::Parse for dates before the epoch is system dependent.

=head2 SOAP::WSDL::XSD::Typelib::Builtin::dateTime

dateTime values are automatically converted into XML dateTime strings during setting:

 YYYY-MM-DDThh:mm:ss.nnnnnnn+zz:zz

The fraction of seconds (nnnnnnn) part is optional. Fractions of seconds may
be given with arbitrary precision

The fraction of seconds part is excluded in converted values, as it would always be 0.

All input variants supported by Date::Parse are supported. Note that
set_value is around 100 times slower when setting non-XML-time strings

=head2 SOAP::WSDL::XSD::Typelib::Builtin::decimal

decimal is the base of all non-float numbers

=head2 SOAP::WSDL::XSD::Typelib::Builtin::double

=head2 SOAP::WSDL::XSD::Typelib::Builtin::duration

=head2 SOAP::WSDL::XSD::Typelib::Builtin::ENTITY

=head2 SOAP::WSDL::XSD::Typelib::Builtin::float

=head2 SOAP::WSDL::XSD::Typelib::Builtin::gDay

=head2 SOAP::WSDL::XSD::Typelib::Builtin::gMonth

=head2 SOAP::WSDL::XSD::Typelib::Builtin::gMonthDay

=head2 SOAP::WSDL::XSD::Typelib::Builtin::gYear

=head2 SOAP::WSDL::XSD::Typelib::Builtin::gYearMonth

=head2 SOAP::WSDL::XSD::Typelib::Builtin::hexBinary

=head2 SOAP::WSDL::XSD::Typelib::Builtin::ID

=head2 SOAP::WSDL::XSD::Typelib::Builtin::IDREF

=head2 SOAP::WSDL::XSD::Typelib::Builtin::IDREFS

List of SOAP::WSDL::XSD::Typelib::Builtin::IDREF objects.

Derived by SOAP::WSDL::XSD::Typelib::Builtin::list.

=head2 SOAP::WSDL::XSD::Typelib::Builtin::int

=head2 SOAP::WSDL::XSD::Typelib::Builtin::integer

=head2 SOAP::WSDL::XSD::Typelib::Builtin::language

=head2 SOAP::WSDL::XSD::Typelib::Builtin::list

=head2 SOAP::WSDL::XSD::Typelib::Builtin::long

=head2 SOAP::WSDL::XSD::Typelib::Builtin::Name

=head2 SOAP::WSDL::XSD::Typelib::Builtin::NCName

=head2 SOAP::WSDL::XSD::Typelib::Builtin::negativeInteger

=head2 SOAP::WSDL::XSD::Typelib::Builtin::nonNegativeInteger

=head2 SOAP::WSDL::XSD::Typelib::Builtin::nonPositiveInteger

=head2 SOAP::WSDL::XSD::Typelib::Builtin::normalizedString

Tab, newline and carriage return characters are replaced by whitespace in
set_value.

=head2 SOAP::WSDL::XSD::Typelib::Builtin::NOTATION

=head2 SOAP::WSDL::XSD::Typelib::Builtin::positiveInteger

=head2 SOAP::WSDL::XSD::Typelib::Builtin::QName

=head2 SOAP::WSDL::XSD::Typelib::Builtin::short

=head2 SOAP::WSDL::XSD::Typelib::Builtin::string

String values are XML-escaped on serialization.

The following characters are escaped: <, >, &

=head2 SOAP::WSDL::XSD::Typelib::Builtin::time

time values are automatically converted into XML time strings during setting:

 hh:mm:ss.nnnnnnn+zz:zz
 hh:mm:ss+zz:zz

The time zone is set to the local time zone if not included. The optional
nanoseconds part is not included in converted values, as it would always be 0.

All input variants supported by Date::Parse are supported. You may even pass
in dateTime strings - the date part will be ignored. Note that
set_value is around 100 times slower when setting non-XML-time strings.

=head2 SOAP::WSDL::XSD::Typelib::Builtin::token

=head2 SOAP::WSDL::XSD::Typelib::Builtin::unsignedByte

=head2 SOAP::WSDL::XSD::Typelib::Builtin::unsignedInt

=head2 SOAP::WSDL::XSD::Typelib::Builtin::unsignedLong

=head2 SOAP::WSDL::XSD::Typelib::Builtin::unsignedShort

=head1 CAVEATS

=over

=item * set_value

In contrast to Class::Std-generated mutators (setters), set_value does
not return the last value.

This is for speed reasons: SOAP::WSDL never needs to know the last value
when calling set_calue, but calls it over and over again...

=back

=head1 BUGS AND LIMITATIONS

=over

=item * Thread safety

SOAP::WSDL::XSD::Typelib::Builtin uses Class::Std::Fast::Storable which uses
Class::Std. Class::Std is not thread safe, so
SOAP::WSDL::XSD::Typelib::Builtin is neither.

=item * XML Schema facets

No facets are implemented yet.

=back

=head1 AUTHOR

Replace whitespace by @ in e-mail address.

 Martin Kutter E<gt>martin.kutter fen-net.deE<lt>

=head1 LICENSE AND COPYRIGHT

Copyright 2004-2007 Martin Kutter.

This file is part of SOAP-WSDL. You may distribute/modify it under the
same terms as perl itself

=cut
