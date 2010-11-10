package SOAP::WSDL::SAX::WSDLHandler;
use strict;
use warnings;
use Carp;
use Class::Std::Storable;
use SOAP::WSDL::TypeLookup;

my %tree_of :ATTR(:name<tree> :default<{}>);
my %order_of :ATTR(:name<order> :default<[]>);
my %targetNamespace_of :ATTR(:name<targetNamespace> :default<()>);
my %current_of :ATTR(:name<current> :default<()>);
my %characters_of :ATTR();

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
                error
            ) ) {
                *{ "$method" } = sub {};
            }
        }

        return bless $self, $class;
    }
};

sub start_document {
    my $ident = ident $_[0];
    $tree_of{ $ident } = {};
    $order_of{ $ident } = [];
    $targetNamespace_of{ $ident } = undef;
    $current_of{ $ident } = undef;
}

sub start_element {
    my ($self, $element) = @_;
    my $ident = ident $self;

    my $action = SOAP::WSDL::TypeLookup->lookup(
        $element->{ NamespaceURI },
        $element->{ LocalName }
    );

    $characters_of{ $ident } = q{};
    return if not $action;
    
    if ($action->{ type } eq 'CLASS') {
        eval "require $action->{ class }";
        croak $@, $tree_of{ $ident } if ($@);

        my $class = $action->{ class };
        my $obj = $class->new({ parent => $current_of{ $ident } })->init(
            values %{ $element->{ Attributes } }
        );

        # set element in parent
        if ($current_of{ $ident }) {
            # inherit namespace, but don't override
            $obj->set_targetNamespace(
                $current_of{ $ident }->get_targetNamespace() )
                    if not $obj->get_targetNamespace();

            # push on name list
            my $method = "push_$element->{ LocalName }";
            no strict qw(refs);
            $current_of{ $ident }->$method( $obj );

            # remember element for stepping back
            push @{ $order_of{ $ident } }, $current_of{ $ident };
        }
        else {
            $tree_of{ $ident } = $obj;
        }
        # set new element (step down)
        $current_of{ $ident } = $obj;
    }
    elsif ($action->{ type } eq 'PARENT') {
        $current_of{ $ident }->init( values %{ $element->{ Attributes } }	);
    }
    elsif ($action->{ type } eq 'METHOD') {
        my $method = $action->{ method } || $element->{ LocalName };

        no strict qw(refs);
        # call method with
        # - default value ($action->{ value } if defined,
        #   dereferencing lists
        # - the values of the elements Attributes hash
        $current_of{ $ident }->$method( defined $action->{ value }
            ? ref $action->{ value }
                ? @{ $action->{ value } }
                : ($action->{ value })
            : values %{ $element->{ Attributes } } );
    }
}

sub characters {
    $characters_of{ ident $_[0] } .= $_[1]->{ Data };
}

sub end_element {
    my ($self, $element) = @_;
    my $ident = ident $self;

    my $action = SOAP::WSDL::TypeLookup->lookup(
        $element->{ NamespaceURI },
        $element->{ LocalName }
    ) || {};

    return if not ($action->{ type });
    if ( $action->{ type } eq 'CLASS' )	{
	$current_of{ $ident } = pop @{ $order_of{ $ident } };
    }
    elsif ($action->{ type } eq 'CONTENT' ) {
        my $method = $action->{ method };
        no strict qw(refs);
        # strip of leading and trailing whitespace
        $characters_of{ $ident } =~s{ ^ \s+ (.+) \s+ $ }{$1}xms;
        # replace multi whitespace by one
        $characters_of{ $ident } =~s{ \s+ }{ }xmsg;
        $current_of{ $ident }->$method( $characters_of{ $ident } );
    }
}

sub fatal_error {
    die @_;
}

sub get_data {
    my $self = shift;
    return $tree_of{ ident $self };
}
1;
