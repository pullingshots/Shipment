package SOAP::WSDL::Build;
{
    use strict;
    use warnings;
    use parent qw(Module::Build);

    use URI::file;
    use LWP::UserAgent;
    use SOAP::WSDL::Expat::WSDLParser;
    use SOAP::WSDL::Factory::Generator;

    our $VERSION = 2.01;

=pod

=head1 NAME

SOAP::WSDL::Build - Module::Build subclass for running wsdl2perl during build

=head1 SYNOPSIS

In your Build.PL:

 use SOAP::WSDL::Build;
 my $build = SOAP::WSDL::Build->new(
    wsdl2perl => {
        location => 'wsdl/foo.wsdl',
        prefix => 'SupaModule::',
    }
 );
 $build->generate_build_script();

On building/installing:

 perl Build.PL
 perl Build
 perl Build test
 perl Build install

=head1 DESCRIPTION

Module::Build subclass for running wsdl2perl during the build stage. This
allows shipping of distributions based on SOAP::WSDL, which do not include
generated code, but the WSDLs in question instead.

=head1 AUTHORING

To use SOAP::WSDL::Build in your Build.PL scripts, do the following:

=over

=item * Use SOAP::WSDL::Build instead of Module::Build

 use SOAP::WSDL::Build;
 my $build = SOAP::WSDL::Build->new(%options);
 $build->generate_build_script();

All standard Module::Build methods are still available.

=item * Add the wsdl2perl configuration under the options key wsdl2perl:

 my $build = SOAP::WSDL::Build->new(
    ...
    wsdl2perl => {
        location => 'path/to/wsdl',
        server => 1,
        client => 0,
        prefix => 'My::Project::'
    }
 );

=back

=head2 Options

SOAP::WSDL::Builder accepts the following options in the wsdl2perl hash
reference:

=over

=item * Frequently used options

=over 8

=item * location

Path to WSDL file. Required.

=item * prefix

Prefix to apply to all generated classes.

=item * client

Generate client interfaces. Defaults to 1 (true)

=item * server

Generate server interfaces. Defaults to 0 (false)

=item * types

Generate data classes. Defaults to 1 (true)

=item * silent

Don't tell what's being generated. Defaults to 0 (false)

=back

=item * Less frequently used options for the generation process

=over 8

=item * use_typemap

Generate a typemap based parser. This option is only for compatibility with
2.00.xx versions and should not be used in any other case. Defaults to 0
(false)

=item * typemap_include

Code snippet to include in typemap. This option is only for compatibility with
2.00.xx versions and should not be used in any other case. Defaults to q{}
(empty string)

=item * attribute_prefix

Individual attribute prefix. Defaults to "$prefix\Attributes"

=item * interface_prefix

Individual (client) interface prefix. Defaults to "$prefix\Interfaces"

=item * server_prefix

Individual server prefix. Defaults to "$prefix\Server"

=item * type_prefix

Individual (data) type prefix. Defaults to "$prefix\Types"

=item * element_prefix

Individual (data) element prefix. Defaults to "$prefix\Elements"

=item * typemap_prefix

Individual typemap prefix. Defaults to "$prefix\Typemaps"

=back

=item * Options controlling LWP::UserAgent

Use of these options is strongly discouraged for published distributions, as
it may make the distribution dependent on your environment

=over 8

=item * proxy

HTTP(s) proxy to use. Proxies can also be set ussing the HTTP_PROXY and
HTTPS_PROXY environment variables, which is generally a better choice for build
scripts.

=item * keepalive

Keppalive is only required in combination with NTLM authentication. It is not
recommended to create distributions which rely on protected documents, so
it's somewhat useless for use in Build scripts.

=back

=back

=head1 Build targets

=head2 build

SOAP::WSDL::Build modifies the standard "build" target (invoked when running
"perl Build") to include the target "webservice".

=cut

    sub ACTION_build {
        my $self = shift;
        $self->depends_on('code');
        $self->depends_on('webservice');
        $self->depends_on('docs');
    }

=pod

=head2 webservice

SOAP::WSDL::Build adds the new target webservice. This build target generates
perl classes from the WSDL definitions specified.

You may run this step separately by calling

 perl Build webservice

=cut

    sub ACTION_webservice {
        my $self = shift;
        $self->read_config();
        my $config = $self->{properties}->{wsdl2perl};
        warn "No wsdl2perl config key found in Build.PL ",
          "- did you forget to add one?\n"
          if not defined $config;
        $config = [$config] if ref $config ne 'ARRAY';

        my %default_config = (
            base_path => 'blib/lib',
            generator => 'XSD',
            silent    => 0,

            client => 1,
            server => 0,
            types  => 1,

            keep_alive => 0,
            proxy      => q{},

            typemap_include => q{},
            use_typemap     => 0,

            prefix           => q{My},
            attribute_prefix => q{},
            interface_prefix => q{},
            server_prefix    => q{},
            type_prefix      => q{},
            element_prefix   => q{},
            typemap_prefix   => q{},
        );

        foreach my $wsdl_config ( @{$config} ) {

            # the easiest way to merge two sets is
            # to just create a new set...
            $self->wsdl2perl( %default_config, %{$wsdl_config} );
        }
    }

=pod

=head1 METHODS

=head2 wsdl2perl

 $builder->wsdl2perl(%config);

=cut

    sub wsdl2perl {
        my $self = shift;
        my %opt  = @_;

        # resolve the default prefix options
        # If only prefix is given
        # and interface_prefix has not been set explicitely
        # make it "$prefix\Interfaces"
        map {
            my $opt_key = $_;
            if (
                $opt_key =~ / (\w+) _prefix $/xms    # relevant option
                && !$opt{$opt_key}   # that hasn't already been explicitly set
              ) {
                my $prefix_type = $1;
                $opt{$opt_key} = $opt{prefix} .    # My
                  ucfirst($prefix_type) .          # Typemap
                  ( $prefix_type eq 'server' ? '' : 's' );    # s
            }
        } keys %opt;

        # set environment proxies if given
        # makes sure existing environment proxies are regarded unless
        # overridden...
        local $ENV{HTTP_PROXY}  = $opt{proxy} if $opt{proxy};
        local $ENV{HTTPS_PROXY} = $opt{proxy} if $opt{proxy};

        my $lwp = LWP::UserAgent->new(
            $opt{keep_alive}
            ? ( keep_alive => 1 )
            : () );
        $lwp->env_proxy()
          ;    # get proxy from environment. Works for both http & https.
        $lwp->agent(qq[SOAP::WSDL $SOAP::WSDL::Expat::WSDLParser::VERSION]);

        my $parser =
          SOAP::WSDL::Expat::WSDLParser->new( {user_agent => $lwp,} );

        my $uri;
        if (-e $opt{location}) {
            $uri = URI::file->new_abs( $opt{location} );
        }
        else {
            warn "wsdl file $opt{location} not found\n"
                if ($opt{location} !~m{https?://}x);
            $uri = URI->new($opt{location});
        }


        my $definitions = $parser->parse_uri($uri);

        my %typemap = ();
        if ( $opt{typemap_include} ) {
            die "$opt{typemap_include} not found "
              if not -f $opt{typemap_include};
            %typemap = do $opt{typemap_include};
        }

        my $generator = SOAP::WSDL::Factory::Generator->get_generator(
            {type => $opt{'generator'}} );

        if (%typemap) {
            if ( $generator->can('set_typemap') ) {
                $generator->set_typemap( \%typemap );
            }
            else {
                warn "Typemap snippet given, but ",
                  "generator does not support it\n";
            }
        }

        $generator->set_attribute_prefix( $opt{attribute_prefix} )
          if $generator->can('set_attribute_prefix');
        $generator->set_type_prefix( $opt{type_prefix} )
          if $generator->can('set_type_prefix');
        $generator->set_typemap_prefix( $opt{typemap_prefix} )
          if $generator->can('set_typemap_prefix');
        $generator->set_element_prefix( $opt{element_prefix} )
          if $generator->can('set_element_prefix');
        $generator->set_interface_prefix( $opt{interface_prefix} )
          if $generator->can('set_interface_prefix');
        $generator->set_server_prefix( $opt{server_prefix} )
          if $generator->can('set_server_prefix');

        $generator->set_OUTPUT_PATH( $opt{base_path} )
          if $generator->can('set_OUTPUT_PATH');
        $generator->set_definitions($definitions)
          if $generator->can('set_definitions');

        $generator->set_use_typemap( $opt{use_typemap} )
          if $generator->can('set_use_typemap');

        $generator->set_silent( $opt{silent} );

        $generator->generate()           if $opt{types};
        $generator->generate_interface() if $opt{client};
        $generator->generate_server()    if $opt{server};
    }

}
1;

=pod

=head1 EXAMPLE

An example is located in the distribution's examples directory in

 examples/dist

=head1 LICENSE AND COPYRIGHT

Copyright 2004-2009 Martin Kutter.

This file is part of SOAP-WSDL. You may distribute/modify it under the same
terms as perl itself

=head1 AUTHOR

Martin Kutter E<lt>martin.kutter fen-net.deE<gt>

=head1 REPOSITORY INFORMATION

 $Rev: 849 $
 $LastChangedBy: kutterma $
 $Id: Build.pm 849 2009-05-15 21:39:29Z kutterma $
 $HeadURL: https://soap-wsdl.svn.sourceforge.net/svnroot/soap-wsdl/SOAP-WSDL/branches/Typemap/lib/SOAP/WSDL/Build.pm $

=cut
