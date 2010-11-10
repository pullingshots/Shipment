#!/usr/bin/perl
package SOAP::WSDL::SAX::MessageHandler;
use strict;
use warnings;
use Scalar::Util qw(blessed);
use Class::Std::Storable;
use SOAP::WSDL::XSD::Typelib::Builtin;

my %characters_of :ATTR(:default<()>);
my %class_resolver_of :ATTR(:default<()> :name<class_resolver>);
my %current_of :ATTR(:default<()>);
my %ignore_of :ATTR(:default<()>);
my %list_of :ATTR(:default<()>);
my %namespace_of :ATTR(:default<()>);
my %path_of :ATTR(:default<()>);
my %data_of :ATTR(:default<()>);

{
    # we have to implement our own new - we need a blessed Hash ref as $self
    # for being able to inherit from XML::SAX::Base...
    no warnings qw(redefine);
    sub new {
        my $class = shift;
        my $self = {}; # $class->SUPER::new(@_);
        my $args = shift || {};

        die "arguments to new must be single hash ref"
            if @_ or ! ref $args eq 'HASH';

        # nasty, but for those who want to use XML::SAX::Base or similar
        # as parser factory
        if ($args->{base}) {
            # yup, naughty string eval
            eval "use base qw($args->{base})";  ## no critic qw(ProhibitStringyEval)
        }
        else {
            # create all those SAX methods...
            # ...we ignore em all...
            no strict qw(refs);
            foreach my $method ( qw(
                 processing_instruction
                 ignorable_whitespace
                 set_document_locator
                 start_prefix_mapping
                 end_prefix_mapping
                 skipped_entity
                 start_cdata
                 end_cdata
                 comment
                 entity_reference
                 notation_decl
                 unparsed_entity_decl
                 element_decl
                 attlist_decl
                 doctype_decl
                 xml_decl
                 entity_decl
                 attribute_decl
                 internal_entity_decl
                 external_entity_decl
                 resolve_entity
                 start_dtd
                 end_dtd
                 start_entity
                 end_entity
                 warning
            ) ) {
                *{ "$method" } = sub {};
            }
        }

        $class_resolver_of{ ident $self } = $args->{ class_resolver }
            if $args->{ class_resolver };

        return bless $self, $class;
    }
}

sub class_resolver {
    my $self = shift;
    $class_resolver_of{ ident $self } = shift;
}

sub start_document {
    my $ident = ident $_[0];
    $list_of{ $ident } = [];
    $current_of{ $ident } = '__STOP__';             # use as marker
    $namespace_of{ $ident } = {};
    $ignore_of{ $ident } = [ qw(Envelope Body) ];   # SOAP elements
    $path_of{ $ident } = [];
    $data_of{ $ident } = undef;   
}

sub start_element {
    # use $_[n] for performance
    my ($ident, $element) = (ident $_[0], $_[1]);

    # ignore top level elements
    if (@{ $ignore_of{ $ident } }
        && $element->{ LocalName } eq $ignore_of{ $ident }->[0]) {
        shift @{ $ignore_of{ $ident } };
        return;
    }

    # empty characters
    $characters_of{ $ident } = q{};

    push @{ $path_of{ $ident } }, $element->{ LocalName };  # step down...
    push @{ $list_of{ $ident } }, $current_of{ $ident };    # remember current

    # resolve class of this element
    my $class = $class_resolver_of{ $ident }->get_class( $path_of{ $ident } )
        or die "Cannot resolve class for "
            . join('/', @{ $path_of{ $ident } })
            . " via "
            . $class_resolver_of{ $ident };

    # Check whether we have a primitive - we implement them as classes
    # TODO replace with UNIVERSAL->isa()
    # match is a bit faster if the string does not match, but WAY slower 
    # if $class matches...
    # if (not $class=~m{^SOAP::WSDL::XSD::Typelib::Builtin}xms) {      
    if (index $class, 'SOAP::WSDL::XSD::Typelib::Builtin', 0 < 0) {

        # check wheter there is a CODE reference for $class::new.
        # If not, require it - all classes required here MUST
        # define new()
        # This is the same as $class->can('new'), but it's way faster  
        no strict qw(refs);
        *{ "$class\::new" }{ CODE } 
            or eval "require $class"   ## no critic qw(ProhibitStringyEval)
                or die $@;
    }
    # create object
    # set current object
    $current_of{ $ident } = $class->new({
        map { $_->{ Name } => $_->{ Value } }
            values %{ $element->{ Attributes } }
    });

    # remember top level element
    defined $data_of{ $ident } 
        or ($data_of{ $ident } = $current_of{ $ident }); 
}

sub characters {
    $characters_of{ ident $_[0] } .= $_[1]->{ Data };
}

sub end_element {
    # $_[n] used for performance
    my ($ident, $element) = (ident $_[0], $_[1]);
  
    # This one easily handles ignores for us, too...
    return if not ref $list_of{ $ident }->[-1];

    if ( $current_of{ $ident }
        ->isa('SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType') ) {
        $current_of{ $ident }->set_value( $characters_of{ $ident } );
    }

    # set appropriate attribute in last element
    # multiple values must be implemented in base class
    my $method = "add_$element->{ LocalName }";

    $list_of{ $ident }->[-1]->$method( $current_of{ $ident } );

    # step up in path
    pop @{ $path_of{ $ident } };
    
    # step up in object hierarchy...
    $current_of{ $ident } = pop @{ $list_of{ $ident } };
}

sub end_document {
    my $self = shift;
    my $ident = ident $self;

    # destroy all remains except data_of
    $list_of{ $ident } = ();
    $namespace_of{ $ident } = ();
    $ignore_of{ $ident } = ();
    $path_of{ $ident } = ();
    $characters_of{ $ident } = ();
}

sub get_data {
    my $self = shift;
    return $data_of{ ident $self };
}

sub fatal_error {
    my $self = shift;
    die "Fatal error parsing document: " , @_;
}

sub error {
    my $self = shift;
    die "Error parsing document: " , @_;
}


1;

=pod

=head1 NAME

SOAP::WSDL::SAX::MessageHandler - Convert SOAP messages to custom object trees

=head1 SYNOPSIS

 # this is the direct variant, recommended for performance
 use SOAP::WSDL::SAX::MessageHandler;
 use XML::LibXML;

 my $filter = SOAP::WSDL::SAX::MessageHandler->new( {
    class_resolver => FakeResolver->new()
 ), "Object creation");
 my $parser = XML::LibXML->new();
 $parser->set_handler( $filter );

 $parser->parse_string( $soap_message );

 my $object_tree = $filter->get_data();


 # This is the XML::ParserFactory variant - for those who want other
 # parsers than XML::Simple....
 use SOAP::WSDL::SAX::MessageHandler;
 use XML::SAX::ParserFactory;

 my $filter = SOAP::WSDL::SAX::MessageHandler->new( {
    class_resolver => FakeResolver->new(),
    base => 'XML::SAX::Base',
 ), "Object creation");
 my $parser = XML::SAX::ParserFactor->parser(
    Handler => $handler
 );
 $parser->parse_string( $soap_message );

 my $object_tree = $filter->get_data();

=head1 DESCRIPTION

SAX handler for parsing SOAP messages.

See L<SOAP::WSDL::Parser> for details.

=head1 Bugs and Limitations

=over

=item * Ignores all namespaces

=item * Does not handle mixed content

=item * The SOAP header is ignored

=back

=head1 AUTHOR

Replace the whitespace by @ for E-Mail Address.

 Martin Kutter E<lt>martin.kutter fen-net.deE<gt>

=head1 COPYING

This module may be used under the same terms as perl itself.

=head1 Repository information

 $ID: $

 $LastChangedDate: 2007-09-10 09:54:52 -0600 (Mon, 10 Sep 2007) $
 $LastChangedRevision: 214 $
 $LastChangedBy: kutterma $

 $HeadURL: https://soap-wsdl.svn.sourceforge.net/svnroot/soap-wsdl/SOAP-WSDL/branches/Typemap/attic/lib/SOAP/WSDL/SAX/MessageHandler.pm $

