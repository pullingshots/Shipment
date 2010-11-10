package XML::id;
use strict; use warnings;
use base qw(SOAP::WSDL::XSD::Typelib::Attribute SOAP::WSDL::XSD::Typelib::Builtin::string);
sub get_xmlns { 'http://www.w3.org/XML/1998/namespace' };
__PACKAGE__->__set_name('id');

package main;
use strict;
use warnings;
use Test::More tests => 4; #qw(no_plan);

use_ok qw(SOAP::WSDL::XSD::Typelib::Attribute);
no strict qw(refs);
*{ 'SOAP::WSDL::XSD::Typelib::Attribute::get_xmlns' } = sub { 'urn:Test' };

is( SOAP::WSDL::XSD::Typelib::Attribute->start_tag(), '');
is(SOAP::WSDL::XSD::Typelib::Attribute->start_tag({ name => 'foo'}, 'bar'), q{ foo="});

my $id = XML::id->new({ value => 'foo' });
is( $id->serialize({ name => 'id' }), q{ xml:id="foo"});