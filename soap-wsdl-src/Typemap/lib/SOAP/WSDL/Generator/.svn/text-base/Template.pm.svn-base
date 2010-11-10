package SOAP::WSDL::Generator::Template;
use strict; use warnings;
use Template 2.18;
use Class::Std::Fast::Storable;
use Carp;
use SOAP::WSDL::Generator::PrefixResolver;

use version; our $VERSION = qv('2.00.99_3');

my %tt_of               :ATTR(:get<tt>);
my %definitions_of      :ATTR(:name<definitions>        :default<()>);
my %server_prefix_of    :ATTR(:name<server_prefix>      :default<MyServer>);
my %interface_prefix_of :ATTR(:name<interface_prefix>   :default<MyInterfaces>);
my %typemap_prefix_of   :ATTR(:name<typemap_prefix>     :default<MyTypemaps>);
my %type_prefix_of      :ATTR(:name<type_prefix>        :default<MyTypes>);
my %element_prefix_of   :ATTR(:name<element_prefix>     :default<MyElements>);
my %attribute_prefix_of :ATTR(:name<attribute_prefix>   :default<MyAttributes>);
my %INCLUDE_PATH_of     :ATTR(:name<INCLUDE_PATH>       :default<()>);
my %EVAL_PERL_of        :ATTR(:name<EVAL_PERL>          :default<0>);
my %RECURSION_of        :ATTR(:name<RECURSION>          :default<0>);
my %OUTPUT_PATH_of      :ATTR(:name<OUTPUT_PATH>        :default<.>);

my %prefix_resolver_class_of    :ATTR(:name<prefix_resolver_class> :default<SOAP::WSDL::Generator::PrefixResolver>);

sub START {
    my ($self, $ident, $arg_ref) = @_;
}

sub _process :PROTECTED {
    my ($self, $template, $arg_ref, $output) = @_;
    my $ident = ident $self;

    # always create a new Template object to
    # force re-loading of plugins.
    my $tt = Template->new(
        DEBUG => 1,
        EVAL_PERL => $EVAL_PERL_of{ $ident },
        RECURSION => $RECURSION_of{ $ident },
        INCLUDE_PATH => $INCLUDE_PATH_of{ $ident },
        OUTPUT_PATH => $OUTPUT_PATH_of{ $ident },
        PLUGIN_BASE => 'SOAP::WSDL::Generator::Template::Plugin',
    )
        or die Template->error();

    $tt->process( $template,
    {
        context => {
            prefix_resolver_class => $prefix_resolver_class_of{ $$self },
            prefix_resolver => $prefix_resolver_class_of{ $$self }->new({
                namespace_prefix_map => {
                    'http://www.w3.org/2001/XMLSchema' => 'SOAP::WSDL::XSD::Typelib::Builtin',
                },
                namespace_map => {
                },
                prefix => {
                    interface => $self->get_interface_prefix,
                    element => $self->get_element_prefix,
                    attribute => $self->get_attribute_prefix,
                    server => $self->get_server_prefix,
                    type => $self->get_type_prefix,
                    typemap => $self->get_typemap_prefix,
                }
            }),
        },
        definitions => $self->get_definitions,
        NO_POD => delete $arg_ref->{ NO_POD } ? 1 : 0 ,
        %{ $arg_ref }
    },
    $output)
        or croak $INCLUDE_PATH_of{ $ident }, '\\', $template, ' ', $tt->error();
}

1;

=pod

=head1 NAME

SOAP::WSDL::Generator::Template - Template-based code generator

=head1 DESCRIPTION

SOAP::WSDL's template based code generator

Base class for writing template based generators

=head1 AUTHOR

Replace the whitespace by @ for E-Mail Address.

 Martin Kutter E<lt>martin.kutter fen-net.deE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright 2008, 2009 Martin Kutter.

This file is part of SOAP-WSDL. You may distribute/modify it under
the same terms as perl itself

=head1 Repository information

 $Id: WSDLParser.pm 770 2009-01-24 22:55:54Z kutterma $

 $LastChangedDate: 2009-01-24 23:55:54 +0100 (Sa, 24 Jan 2009) $
 $LastChangedRevision: 770 $
 $LastChangedBy: kutterma $

 $HeadURL: https://soap-wsdl.svn.sourceforge.net/svnroot/soap-wsdl/SOAP-WSDL/trunk/lib/SOAP/WSDL/Expat/WSDLParser.pm $

