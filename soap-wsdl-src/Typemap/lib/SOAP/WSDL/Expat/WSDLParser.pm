package SOAP::WSDL::Expat::WSDLParser;
use strict;
use warnings;
use Carp;
use SOAP::WSDL::TypeLookup;
use base qw(SOAP::WSDL::Expat::Base);

use version; our $VERSION = qv('2.00.99_3');

#
# Import child elements of a WSDL / XML Schema tree into the current tree
#
# Set the targetNamespace of the imported nodes to $import_namespace
#
# SYNOPSIS
#
# $self->_import_children($name, $imported, $imported, $import_namespace)
#

sub _import_children {
    my ( $self, $name, $imported, $importer, $import_namespace ) = @_;

    my $targetNamespace   = $importer->get_targetNamespace();
    my $push_method       = "push_$name";
    my $get_method        = "get_$name";
    my $default_namespace = $imported->get_xmlns()->{'#default'};

    no strict qw(refs);
    my $value_ref = $imported->$get_method();
    if ($value_ref) {

        $value_ref = [$value_ref] if ( not ref $value_ref eq 'ARRAY' );

        for ( @{$value_ref} ) {

            # fixup namespace - new parent may be from different namespace
            if ( defined($default_namespace) ) {
                my $xmlns = $_->get_xmlns();

                # it's a hash ref, so we can just update values
                if ( !defined $xmlns->{'#default'} ) {
                    $xmlns->{'#default'} = $default_namespace;
                }
            }

            # fixup targetNamespace, but don't override
            $_->set_targetNamespace($import_namespace)
              if ( ( $import_namespace ne $targetNamespace )
                && !$_->get_targetNamespace );

            # update parent...
            $_->set_parent($importer);

            # push elements into importing WSDL
            $importer->$push_method($_);
        }
    }
}

sub _import_namespace_definitions {
    my $self     = shift;
    my $arg_ref  = shift;
    my $importer = $arg_ref->{importer};
    my $imported = $arg_ref->{imported};

    # import namespace definitions, too
    my $importer_ns_of = $importer->get_xmlns();
    my %xmlns_of       = %{$imported->get_xmlns()};

    # it's a hash ref, we can just add to.
    # TODO: check whether URI is the better key.
    while ( my ( $prefix, $url ) = each %xmlns_of ) {
        if ( exists( $importer_ns_of->{$prefix} ) ) {

            # warn "$prefix already exists";
            next;
        }
        $importer_ns_of->{$prefix} = $url;
    }
}

sub xml_schema_import {
    my $self             = shift;
    my $schema           = shift;
    my $parser           = $self->clone();
    my %attr_of          = @_;
    my $import_namespace = $attr_of{namespace};

    if ( not $attr_of{schemaLocation} ) {
        warn
"cannot import document for namespace >$import_namespace< without location";
        return;
    }

    if ( not $self->get_uri ) {
        die
"cannot import document from namespace >$import_namespace< without base uri. Use >parse_uri< or >set_uri< to set one.";
    }

    my $uri = URI->new_abs( $attr_of{schemaLocation}, $self->get_uri() );
    my $imported = $parser->parse_uri($uri);

    # might already be imported - parse_uri just returns in this case
    return if not defined $imported;

    $self->_import_namespace_definitions( {
            importer => $schema,
            imported => $imported,
    } );

    for my $name (qw(type element group attribute attributeGroup)) {
        $self->_import_children( $name, $imported, $schema,
            $import_namespace );
    }
}

sub wsdl_import {
    my $self             = shift;
    my $definitions      = shift;
    my $parser           = $self->clone();
    my %attr_of          = @_;
    my $import_namespace = $attr_of{namespace};

    if ( not $attr_of{location} ) {
        warn
"cannot import document for namespace >$import_namespace< without location";
        return;
    }

    if ( not $self->get_uri ) {
        die
"cannot import document from namespace >$import_namespace< without base uri. Use >parse_uri< or >set_uri< to set one.";
    }

    my $uri = URI->new_abs( $attr_of{location}, $self->get_uri() );

    my $imported = $parser->parse_uri($uri);

    # might already be imported - parse_uri just returns in this case
    return if not defined $imported;

    $self->_import_namespace_definitions( {
            importer => $definitions,
            imported => $imported,
    } );

    for my $name (qw(types message binding portType service)) {
        $self->_import_children( $name, $imported, $definitions,
            $import_namespace );
    }
}

sub _initialize {
    my ( $self, $parser ) = @_;

    # init object data
    $self->{parser} = $parser;
    delete $self->{data};

    # setup local variables for keeping temp data
    my $characters           = undef;
    my $current              = undef;
    my $list                 = [];    # node list
    my $elementFormQualified = 1;     # default for WSDLs, schema may override

    # TODO skip non-XML Schema namespace tags
    $parser->setHandlers(
        Start => sub {

            # handle attrs as list - expat uses dual-vars for looking
            # up namespace information, and hash keys don't allow dual vars...
            my ( $parser, $localname, @attrs ) = @_;
            $characters = q{};

            my $action =
              SOAP::WSDL::TypeLookup->lookup( $parser->namespace($localname),
                $localname );

            return if not $action;

            if ( $action->{type} eq 'CLASS' ) {
                eval "require $action->{ class }";
                croak $@ if ($@);

                my $obj = $action->{class}->new( {
                        parent    => $current,
                        namespace => $parser->namespace($localname),
                        defined($current)
                        # make a copy of xmlns - don't let it be changed
                        ? ( xmlns => { %{ $current->get_xmlns() } } )
                        : ()} )->init( _fixup_attrs( $parser, @attrs ) );

                if ($current) {
                    if ( defined $list->[-1]
                        && $list->[-1]->isa('SOAP::WSDL::XSD::Schema') ) {
                        $elementFormQualified =
                          $list->[-1]->get_elementFormDefault() eq
                          'qualified';
                    }

                    # inherit namespace, but don't override
                    if ($elementFormQualified) {
                        $obj->set_targetNamespace(
                            $current->get_targetNamespace() )
                          if not $obj->get_targetNamespace();
                    }

                    # push on parent's element/type list
                    my $method = "push_$localname";

                    no strict qw(refs);
                    $current->$method($obj);

                    # remember element for stepping back
                    push @{$list}, $current;
                }

                # set new element (step down)
                $current = $obj;
            }
            elsif ( $action->{type} eq 'PARENT' ) {
                $current->init( _fixup_attrs( $parser, @attrs ) );
            }
            elsif ( $action->{type} eq 'METHOD' ) {
                my $method = $action->{method};

                no strict qw(refs);

                # call method with
                # - default value ($action->{ value } if defined,
                #   dereferencing lists
                # - the values of the elements Attributes hash
                # TODO: add namespaces declared to attributes.
                # Expat consumes them, so we have to re-add them here.
                $current->$method(
                      defined $action->{value}
                    ? ref $action->{value}
                          ? @{$action->{value}}
                          : ( $action->{value} )
                    : _fixup_attrs( $parser, @attrs ) );
            }
            elsif ( $action->{type} eq 'HANDLER' ) {
                my $method = $self->can( $action->{method} );
                $method->( $self, $current, @attrs );
            }
            else {

                # TODO replace by hash lookup of known namespaces.
                my $namespace = $parser->namespace($localname) || q{};
                my $part =
                  $namespace eq 'http://schemas.xmlsoap.org/wsdl/'
                  ? 'WSDL 1.1'
                  : 'XML Schema';

                warn "$part element <$localname> is not implemented yet"
                  if ( $localname !~
                    m{ \A (:? annotation | documentation ) \z }xms );
            }

            return;
        },

        Char => sub { $characters .= $_[1]; return; },

        End => sub {
            my ( $parser, $localname ) = @_;

            my $action =
              SOAP::WSDL::TypeLookup->lookup( $parser->namespace($localname),
                $localname )
              || {};

            if ( !defined $list->[-1] ) {
                $self->{data} = $current;
                return;
            }


            return if not( $action->{type} );
            if ( $action->{type} eq 'CLASS' ) {
                $current = pop @{$list};
                if ( defined $list->[-1] && $list->[-1]->isa('SOAP::WSDL::XSD::Schema') ) {
                    $elementFormQualified = 1;
                }
            }
            elsif ( $action->{type} eq 'CONTENT' ) {
                my $method = $action->{method};

                # normalize whitespace
                $characters =~ s{ ^ \s+ (.+) \s+ $ }{$1}xms;
                $characters =~ s{ \s+ }{ }xmsg;

                no strict qw(refs);
                $current->$method($characters);
            }
            return;
        } );
    return $parser;
}

# make attrs SAX style
sub _fixup_attrs {
    my ( $parser, @attrs ) = @_;

    my @attr_key_from   = ();
    my @attr_value_from = ();

    while (@attrs) {
        push @attr_key_from,   shift @attrs;
        push @attr_value_from, shift @attrs;
    }

    my @attrs_from;

    # add xmlns: attrs. expat eats them.
    #
    # add namespaces before attributes: Attributes may be namespace-qualified
    #
    push @attrs_from, map { {
            Name      => "xmlns:$_",
            Value     => $parser->expand_ns_prefix($_),
            LocalName => $_
        }
    } $parser->new_ns_prefixes();

    push @attrs_from, map { {
            Name => defined $parser->namespace($_)
            ? $parser->namespace($_) . '|' . $_
            : '|' . $_,
            Value     => shift @attr_value_from,    # $attrs_of{ $_ },
            LocalName => $_
        }
    } @attr_key_from;

    return @attrs_from;
}

1;

=pod

=head1 NAME

SOAP::WSDL::Expat::WSDLParser - Parse WSDL files into object trees

=head1 SYNOPSIS

 my $parser = SOAP::WSDL::Expat::WSDLParser->new();
 $parser->parse( $xml );
 my $obj = $parser->get_data();

=head1 DESCRIPTION

WSDL parser used by SOAP::WSDL.

=head1 AUTHOR

Replace the whitespace by @ for E-Mail Address.

 Martin Kutter E<lt>martin.kutter fen-net.deE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright 2004-2007 Martin Kutter.

This file is part of SOAP-WSDL. You may distribute/modify it under
the same terms as perl itself

=head1 Repository information

 $Id: WSDLParser.pm 861 2010-03-28 10:41:26Z kutterma $

 $LastChangedDate: 2010-03-28 04:41:26 -0600 (Sun, 28 Mar 2010) $
 $LastChangedRevision: 861 $
 $LastChangedBy: kutterma $

 $HeadURL: https://soap-wsdl.svn.sourceforge.net/svnroot/soap-wsdl/SOAP-WSDL/branches/Typemap/lib/SOAP/WSDL/Expat/WSDLParser.pm $

