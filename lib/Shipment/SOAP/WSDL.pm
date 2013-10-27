package Shipment::SOAP::WSDL;

BEGIN {
my %fatpacked;

$fatpacked{"5.10/version.pm"} = <<'5.10_VERSION';
  #!perl -w
  package
    version;
  
  use 5.005_04;
  use strict;
  
  use vars qw(@ISA $VERSION $CLASS $STRICT $LAX *declare *qv);
  
  $VERSION = 0.82;
  
  $CLASS = 'version';
  
  #--------------------------------------------------------------------------#
  # Version regexp components
  #--------------------------------------------------------------------------#
  
  # Fraction part of a decimal version number.  This is a common part of
  # both strict and lax decimal versions
  
  my $FRACTION_PART = qr/\.[0-9]+/;
  
  # First part of either decimal or dotted-decimal strict version number.
  # Unsigned integer with no leading zeroes (except for zero itself) to
  # avoid confusion with octal.
  
  my $STRICT_INTEGER_PART = qr/0|[1-9][0-9]*/;
  
  # First part of either decimal or dotted-decimal lax version number.
  # Unsigned integer, but allowing leading zeros.  Always interpreted
  # as decimal.  However, some forms of the resulting syntax give odd
  # results if used as ordinary Perl expressions, due to how perl treats
  # octals.  E.g.
  #   version->new("010" ) == 10
  #   version->new( 010  ) == 8
  #   version->new( 010.2) == 82  # "8" . "2"
  
  my $LAX_INTEGER_PART = qr/[0-9]+/;
  
  # Second and subsequent part of a strict dotted-decimal version number.
  # Leading zeroes are permitted, and the number is always decimal.
  # Limited to three digits to avoid overflow when converting to decimal
  # form and also avoid problematic style with excessive leading zeroes.
  
  my $STRICT_DOTTED_DECIMAL_PART = qr/\.[0-9]{1,3}/;
  
  # Second and subsequent part of a lax dotted-decimal version number.
  # Leading zeroes are permitted, and the number is always decimal.  No
  # limit on the numerical value or number of digits, so there is the
  # possibility of overflow when converting to decimal form.
  
  my $LAX_DOTTED_DECIMAL_PART = qr/\.[0-9]+/;
  
  # Alpha suffix part of lax version number syntax.  Acts like a
  # dotted-decimal part.
  
  my $LAX_ALPHA_PART = qr/_[0-9]+/;
  
  #--------------------------------------------------------------------------#
  # Strict version regexp definitions
  #--------------------------------------------------------------------------#
  
  # Strict decimal version number.
  
  my $STRICT_DECIMAL_VERSION =
      qr/ $STRICT_INTEGER_PART $FRACTION_PART? /x;
  
  # Strict dotted-decimal version number.  Must have both leading "v" and
  # at least three parts, to avoid confusion with decimal syntax.
  
  my $STRICT_DOTTED_DECIMAL_VERSION =
      qr/ v $STRICT_INTEGER_PART $STRICT_DOTTED_DECIMAL_PART{2,} /x;
  
  # Complete strict version number syntax -- should generally be used
  # anchored: qr/ \A $STRICT \z /x
  
  $STRICT =
      qr/ $STRICT_DECIMAL_VERSION | $STRICT_DOTTED_DECIMAL_VERSION /x;
  
  #--------------------------------------------------------------------------#
  # Lax version regexp definitions
  #--------------------------------------------------------------------------#
  
  # Lax decimal version number.  Just like the strict one except for
  # allowing an alpha suffix or allowing a leading or trailing
  # decimal-point
  
  my $LAX_DECIMAL_VERSION =
      qr/ $LAX_INTEGER_PART (?: \. | $FRACTION_PART $LAX_ALPHA_PART? )?
  	|
  	$FRACTION_PART $LAX_ALPHA_PART?
      /x;
  
  # Lax dotted-decimal version number.  Distinguished by having either
  # leading "v" or at least three non-alpha parts.  Alpha part is only
  # permitted if there are at least two non-alpha parts. Strangely
  # enough, without the leading "v", Perl takes .1.2 to mean v0.1.2,
  # so when there is no "v", the leading part is optional
  
  my $LAX_DOTTED_DECIMAL_VERSION =
      qr/
  	v $LAX_INTEGER_PART (?: $LAX_DOTTED_DECIMAL_PART+ $LAX_ALPHA_PART? )?
  	|
  	$LAX_INTEGER_PART? $LAX_DOTTED_DECIMAL_PART{2,} $LAX_ALPHA_PART?
      /x;
  
  # Complete lax version number syntax -- should generally be used
  # anchored: qr/ \A $LAX \z /x
  #
  # The string 'undef' is a special case to make for easier handling
  # of return values from ExtUtils::MM->parse_version
  
  $LAX =
      qr/ undef | $LAX_DECIMAL_VERSION | $LAX_DOTTED_DECIMAL_VERSION /x;
  
  #--------------------------------------------------------------------------#
  
  eval "use version::vxs $VERSION";
  if ( $@ ) { # don't have the XS version installed
      eval "use version::vpp $VERSION"; # don't tempt fate
      die "$@" if ( $@ );
      push @ISA, "version::vpp";
      local $^W;
      *version::qv = \&version::vpp::qv;
      *version::declare = \&version::vpp::declare;
      *version::_VERSION = \&version::vpp::_VERSION;
      if ($] > 5.009001 && $] < 5.010000) {
  	no strict 'refs';
  	*version::stringify = \&version::vpp::stringify;
  	*{'version::(""'} = \&version::vpp::stringify;
  	*version::new = \&version::vpp::new;
      }
      elsif ($] == 5.010000 || $] == 5.010001) {
  	no strict 'refs';
  	*version::stringify = \&version::vpp::stringify;
  	*{'version::(""'} = \&version::vpp::stringify;
  	*version::new = \&version::vpp::new;
  	*version::parse = \&version::vpp::parse;
      }
  }
  else { # use XS module
      push @ISA, "version::vxs";
      local $^W;
      *version::declare = \&version::vxs::declare;
      *version::qv = \&version::vxs::qv;
      *version::_VERSION = \&version::vxs::_VERSION;
      if ($] > 5.009001 && $] < 5.010000) {
  	no strict 'refs';
  	*version::stringify = \&version::vxs::stringify;
  	*{'version::(""'} = \&version::vxs::stringify;
      }
      elsif ($] == 5.010000 || $] == 5.010001) {
  	no strict 'refs';
  	*version::stringify = \&version::vxs::stringify;
  	*{'version::(""'} = \&version::vxs::stringify;
  	*version::new = \&version::vxs::new;
  	*version::parse = \&version::vxs::parse;
      }
  
  }
  
  # Preloaded methods go here.
  sub import {
      no strict 'refs';
      my ($class) = shift;
  
      # Set up any derived class
      unless ($class eq 'version') {
  	local $^W;
  	*{$class.'::declare'} =  \&version::declare;
  	*{$class.'::qv'} = \&version::qv;
      }
  
      my %args;
      if (@_) { # any remaining terms are arguments
  	map { $args{$_} = 1 } @_
      }
      else { # no parameters at all on use line
      	%args = 
  	(
  	    qv => 1,
  	    'UNIVERSAL::VERSION' => 1,
  	);
      }
  
      my $callpkg = caller();
      
      if (exists($args{declare})) {
  	*{$callpkg.'::declare'} = 
  	    sub {return $class->declare(shift) }
  	  unless defined(&{$callpkg.'::declare'});
      }
  
      if (exists($args{qv})) {
  	*{$callpkg.'::qv'} =
  	    sub {return $class->qv(shift) }
  	  unless defined(&{$callpkg.'::qv'});
      }
  
      if (exists($args{'UNIVERSAL::VERSION'})) {
  	local $^W;
  	*UNIVERSAL::VERSION 
  		= \&version::_VERSION;
      }
  
      if (exists($args{'VERSION'})) {
  	*{$callpkg.'::VERSION'} = \&version::_VERSION;
      }
  
      if (exists($args{'is_strict'})) {
  	*{$callpkg.'::is_strict'} = 
  	    sub {return $class->is_strict(shift)}
  	  unless defined(&{$callpkg.'::is_strict'});
      }
  
      if (exists($args{'is_lax'})) {
  	*{$callpkg.'::is_lax'} = 
  	    sub {return $class->is_lax(shift)}
  	  unless defined(&{$callpkg.'::is_lax'});
      }
  }
  
  sub is_strict	{ defined $_[0] && $_[0] =~ qr/ \A $STRICT \z /x }
  sub is_lax	{ defined $_[0] && $_[0] =~ qr/ \A $LAX \z /x }
  
  1;
5.10_VERSION

$fatpacked{"5.10/version/vxs.pm"} = <<'5.10_VERSION_VXS';
  #!perl -w
  package
    version::vxs;
  
  use 5.005_03;
  use strict;
  
  use vars qw(@ISA $VERSION $CLASS );
  
  $VERSION = 0.82;
  
  $CLASS = 'version::vxs';
  
  eval {
      require XSLoader;
      local $^W; # shut up the 'redefined' warning for UNIVERSAL::VERSION
      XSLoader::load('version::vxs', $VERSION);
      1;
  } or do {
      require DynaLoader;
      push @ISA, 'DynaLoader'; 
      local $^W; # shut up the 'redefined' warning for UNIVERSAL::VERSION
      bootstrap version::vxs $VERSION;
  };
  
  # Preloaded methods go here.
  
  1;
5.10_VERSION_VXS

$fatpacked{"SOAP/WSDL.pm"} = <<'SOAP_WSDL';
  package
    SOAP::WSDL;
  use strict;
  use warnings;
  
  use 5.008;  # require at least perl 5.8
  
  our $Trace = 0;
  our $Debug = 0;
  
  use version; our $VERSION = qv('2.00.99_3');
  
  sub import {
      my $self = shift;
      for (@_) {
          $Trace = 9 if $_ eq 'trace';
      }
  }
  1;
  
  __END__
  
SOAP_WSDL

$fatpacked{"SOAP/WSDL/Base.pm"} = <<'SOAP_WSDL_BASE';
  package
    SOAP::WSDL::Base;
  use SOAP::WSDL;
  use strict; use warnings;
  use Class::Std::Fast::Storable;
  use List::Util;
  use Scalar::Util;
  use Carp qw(croak carp confess);
  
  use version; our $VERSION = qv('2.00.99_3');
  
  my %id_of               :ATTR(:name<id> :default<()>);
  my %lang_of             :ATTR(:name<lang> :default<()>);
  my %name_of             :ATTR(:name<name> :default<()>);
  my %namespace_of        :ATTR(:name<namespace> :default<()>);
  my %documentation_of    :ATTR(:name<documentation> :default<()>);
  my %annotation_of       :ATTR(:name<annotation> :default<()>);
  my %targetNamespace_of  :ATTR(:name<targetNamespace> :default<"">);
  my %xmlns_of            :ATTR(:name<xmlns> :default<{}>);
  my %parent_of           :ATTR(:get<parent> :default<()>);
  
  my %namespaces_of       :ATTR(:default<{}>);
  
  sub namespaces {
      return shift->get_xmlns();
  }
  
  sub BUILD {
      my ($self, $ident, $arg_ref) = @_;
      if (defined $arg_ref->{ parent }) {
          $parent_of{ $ident } = delete $arg_ref->{ parent },
          Scalar::Util::weaken($parent_of{ $ident });
      }
  }
  
  sub START {
      my ($self, $ident, $arg_ref) = @_;
      $xmlns_of{ $ident }->{ 'xml' } = 'http://www.w3.org/XML/1998/namespace';
      $namespaces_of{ $ident }->{ '#default' } = $self->get_xmlns()->{ '#default' };
      $namespaces_of{ $ident }->{ 'xml' } = 'http://www.w3.org/XML/1998/namespace';
  }
  
  #
  # set_parent is hand-implemented to break up (weaken) the circular reference
  # between an object and it's parent
  #
  sub set_parent {
      $parent_of{ ${ $_[0]} } = $_[1];
      Scalar::Util::weaken($parent_of{ ${ $_[0]} });
  }
  
  # _accept is here to be called by visitor.
  # The visitor pattern is a level of indirection - here the visitor calls
  # $object->_accept($visitor) on each object, which in turn calls
  # $visitor->visit_$class( $object ) where $class is the object's class.
  #
  sub _accept {
      my $self = shift;
      my $class = ref $self;
      $class =~ s{ \A SOAP::WSDL:: }{}xms;
      $class =~ s{ (:? :: ) }{_}gxms;
      my $method = "visit_$class";
      no strict qw(refs);
      return shift->$method( $self );
  }
  
  # unfortunately, AUTOMETHOD is SLOW.
  # Re-implement in derived package wherever speed is an issue...
  #
  sub AUTOMETHOD {
      my ($self, $ident, @values) = @_;
      my $subname = $_;   # Requested subroutine name is passed via $_
  
      # we're called as $self->push_something(@values);
      if ($subname =~s{^push_}{}xms) {
          my $getter = "get_$subname";
          my $setter = "set_$subname";
          # Checking here is paranoid - will fail fatally if there is no setter.
          # And we would have to check getters, too.
          # Maybe do it the Conway way via the Symbol table...
          # ... can is way slow...
          return sub {
              no strict qw(refs);
              my $old_value = $self->$getter();
              # Listify if not a list ref
              $old_value = $old_value ? [ $old_value ] : [] if not ref $old_value;
  
              push @$old_value , @values;
              $self->$setter( $old_value );
          };
      }
  
      # we're called as $obj->find_something($ns, $key)
      elsif ($subname =~s {^find_}{get_}xms) {
          @values = @{ $values[0] } if ref $values[0] eq 'ARRAY';
          return sub {
              return List::Util::first {
                  $_->get_targetNamespace() eq $values[0] &&
                  $_->get_name() eq $values[1]
              }
              @{ $self->$subname() };
          }
      }
      elsif ($subname =~s {^first_}{get_}xms) {
          return sub {
              my $result_ref = $self->$subname();
              return if not $result_ref;
              return $result_ref if (not ref $result_ref eq 'ARRAY');
              return $result_ref->[0];
          };
      }
  
      return;
  }
  
  sub init {
      my ($self, @args) = @_;
      print "Creating new node" . ident($self) . "\n" if $SOAP::WSDL::Trace;
      foreach my $value (@args) {
          croak @args if (not defined ($value->{ Name }));
  
          print "\tAttribute $value->{ Name } = $value->{ Value }\n" if $SOAP::WSDL::Trace;
  
          if ($value->{ Name } =~m{^xmlns\:}xms) {
              # add namespaces
              print "\tbind prefix $value->{ LocalName } to $value->{ Value }\n" if $SOAP::WSDL::Trace;
              $xmlns_of{ ident $self }->{ $value->{ LocalName } } = $value->{ Value };
              next;
          }
  
          # check for namespae-qualified attributes.
          # neither XML Schema, nor WSDL1.1, nor the SOAP binding allow
          # namespace-qualified attribute names
          my ($ns, $localname) = split /\|/, $value->{ Name };
          if ($ns) {
              warn "found unrecognised attribute \{$ns}$localname (ignored)";
              next;
          }
  
          my $name = $value->{ LocalName };
          my $method = "set_$name";
          $self->$method( $value->{ Value } );
      }
      
      return $self;
  }
  
  sub expand {
      my ($self, $qname) = @_;
      my $ns_of = $xmlns_of{ ident $self };
      my $parent;
      print "Resolving name for $qname in ", $self, " (", ident($self), ")\n" if $SOAP::WSDL::Trace;
      if (not $qname=~m{:}xm) {
          if (defined $ns_of->{ '#default' }) {
              # TODO check. Returning the targetNamespace for the default ns
              # is probably wrong
              #return $self->get_targetNamespace(), $qname;
              return $ns_of->{ '#default' }, $qname;
          }
          if ($parent = $self->get_parent()) {
              return $parent->expand($qname);
          }
          die "un-prefixed element name <$qname> found, but no default namespace set\n"
      }
  
      my ($prefix, $localname) = split /:/x, $qname;
      return ($ns_of->{ $prefix }, $localname) if ($ns_of->{ $prefix });
      if ($parent = $self->get_parent()) {
          return $parent->expand($qname);
      }
      croak "unbound prefix $prefix found for $prefix:$localname. Bound prefixes are "
          . join(', ', keys %{ $ns_of });
  }
  sub _expand;
  *_expand = \&expand;
  
  sub schema {
      my $parent = $_[0]->get_parent();
      return if ! defined $parent;
      return $parent if $parent->isa('SOAP::WSDL::XSD::Schema');
      return $parent->schema();
  }
  
  1;
  
  __END__
  
  # REPOSITORY INFORMATION
  #
  # $Rev: 332 $
  # $LastChangedBy: kutterma $
  # $Id: WSDL.pm 332 2007-10-19 07:29:03Z kutterma $
  # $HeadURL: http://soap-wsdl.svn.sourceforge.net/svnroot/soap-wsdl/SOAP-WSDL/trunk/lib/SOAP/WSDL.pm $
  #
  
SOAP_WSDL_BASE

$fatpacked{"SOAP/WSDL/Binding.pm"} = <<'SOAP_WSDL_BINDING';
  package
    SOAP::WSDL::Binding;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable;
  
  use base qw(SOAP::WSDL::Base);
  
  use version; our $VERSION = qv('2.00.99_3');
  
  my %operation_of    :ATTR(:name<operation> :default<()>);
  my %type_of         :ATTR(:name<type> :default<()>);
  my %transport_of    :ATTR(:name<transport> :default<()>);
  my %style_of        :ATTR(:name<style> :default<()>);
  
  1;
SOAP_WSDL_BINDING

$fatpacked{"SOAP/WSDL/Build.pm"} = <<'SOAP_WSDL_BUILD';
  package
    SOAP::WSDL::Build;
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
SOAP_WSDL_BUILD

$fatpacked{"SOAP/WSDL/Client.pm"} = <<'SOAP_WSDL_CLIENT';
  package
    SOAP::WSDL::Client;
  use strict;
  use warnings;
  use Carp;
  
  use Class::Std::Fast::Storable;
  use Scalar::Util qw(blessed);
  
  use SOAP::WSDL::Factory::Deserializer;
  use SOAP::WSDL::Factory::Serializer;
  use SOAP::WSDL::Factory::Transport;
  use SOAP::WSDL::Expat::MessageParser;
  
  use version; our $VERSION = qv('2.00.99_3');
  
  my %class_resolver_of   :ATTR(:name<class_resolver> :default<()>);
  my %no_dispatch_of      :ATTR(:name<no_dispatch>    :default<()>);
  my %prefix_of           :ATTR(:name<prefix>         :default<()>);
  my %outputxml_of        :ATTR(:name<outputxml>      :default<()>);
  my %transport_of        :ATTR(:name<transport>      :default<()>);
  my %endpoint_of         :ATTR(:name<endpoint>       :default<()>);
  
  my %soap_version_of     :ATTR(:get<soap_version>    :init_attr<soap_version> :default<1.1>);
  
  my %on_action_of        :ATTR(:name<on_action>      :default<()>);
  my %content_type_of     :ATTR(:name<content_type>   :default<text/xml; charset=utf-8>);  #/#trick editors
  my %encoding_of         :ATTR(:name<encoding>       :default<utf-8>);
  my %serializer_of       :ATTR(:name<serializer>     :default<()>);
  my %deserializer_of     :ATTR(:name<deserializer>   :default<()>);
  my %deserializer_args_of   :ATTR(:name<deserializer_args>   :default<{}>);
  
  sub BUILD {
      my ($self, $ident, $attrs_of_ref) = @_;
  
      if (exists $attrs_of_ref->{ proxy }) {
          $self->set_proxy( $attrs_of_ref->{ proxy } );
          delete $attrs_of_ref->{ proxy };
      }
      return;
  }
  
  sub get_proxy {                         ## no critic RequireArgUnpacking
      return $_[0]->get_transport();
  }
  
  sub set_proxy {
      my ($self, @args_from) = @_;
      my $ident = ${ $self };
  
      # remember old value to return it later - Class::Std does so, too
      my $old_value = $transport_of{ $ident };
  
      # accept both list and list ref args
      @args_from =  @{ $args_from[0] } if ref $args_from[0];
  
      # remember endpoint
      $endpoint_of{ $ident } = $args_from[0];
  
      # set transport - SOAP::Lite works similar...
      $transport_of{ $ident } =  SOAP::WSDL::Factory::Transport
        ->get_transport( @args_from );
  
      return $old_value;
  }
  
  sub set_soap_version {
      my $ident = ${ $_[0] };
  
      # remember old value to return it later - Class::Std does so, too
      my $soap_version = $soap_version_of{ $ident };
  
      # re-setting the soap version invalidates the
      # serializer object
      delete $serializer_of{ $ident };
      delete $deserializer_of{ $ident };
  
      $soap_version_of{ $ident } = $_[1];
  
      return $soap_version;
  }
  
  # Mimic SOAP::Lite's behaviour for getter/setter routines
  SUBFACTORY: {
      for (qw(class_resolver no_dispatch outputxml proxy prefix)) {
          my $setter = "set_$_";
          my $getter = "get_$_";
          no strict qw(refs);     ## no critic ProhibitNoStrict
          *{ $_ } = sub { my $self = shift;
              if (@_) {
                  $self->$setter(@_);
                  return $self;
              }
              return $self->$getter()
          };
      }
  }
  
  sub call {
      my ($self, $method, @data_from) = @_;
      my $ident = ${ $self };
  
      # the only valid idiom for calling a method with both a header and a body
      # is
      # ->call($method, $body_ref, $header_ref);
      #
      # These other idioms all assume an empty header:
      # ->call($method, %body_of);    # %body_of is a hash
      # ->call($method, $body);       # $body is a scalar
      my ($data, $header) = ref $data_from[0]
        ? ($data_from[0], $data_from[1] )
        : (@data_from>1)
            ? ( { @data_from }, undef )
            : ( $data_from[0], undef );
  
      # get operation name and soap_action
      my ($operation, $soap_action) = (ref $method eq 'HASH')
          ? ( $method->{ operation }, $method->{ soap_action } )
          : (blessed $data
              && $data->isa('SOAP::WSDL::XSD::Typelib::Builtin::anyType'))
              ? ( $method , (join q{/}, $data->get_xmlns(), $method) )
              : ( $method, q{} );
      $serializer_of{ $ident } ||= SOAP::WSDL::Factory::Serializer->get_serializer({
          soap_version => $soap_version_of{ $ident },
      });
  
      my $envelope = $serializer_of{ $ident }->serialize({
          method => $operation,
          body => $data,
          header => $header,
          options => {prefix => $prefix_of{ $ident }},
      });

      ## output raw request XML  
      warn "Request\n" . $envelope if $Shipment::SOAP::WSDL::Debug;

      return $envelope if $no_dispatch_of{ $ident };
  
      # always quote SOAPAction header.
      # WS-I BP 1.0 R1109
      if ($soap_action) {
          $soap_action =~s{\A(:?"|')?}{"}xms;
          $soap_action =~s{(:?"|')?\Z}{"}xms;
      }
      else {
          $soap_action = q{""};
      }
  
      # get response via transport layer.
      # Normally, SOAP::Lite's transport layer is used, though users
      # may provide their own.
      my $response = $transport_of{ $ident }->send_receive(
         endpoint => $self->get_endpoint(),
         content_type => $content_type_of{ $ident },
         encoding => $encoding_of{ $ident },
         envelope => $envelope,
         action => $soap_action,
         # on_receive_chunk => sub {}     # optional, may be used for parsing large responses as they arrive.
      );
  
      return $response if ($outputxml_of{ $ident } );
  
      # get deserializer
      use Data::Dumper;
      $deserializer_of{ $ident } ||= SOAP::WSDL::Factory::Deserializer->get_deserializer({
          soap_version => $soap_version_of{ $ident },
          %{ $deserializer_args_of{ $ident } },
      });
  
      # initialize deserializer from caller
      $deserializer_of{ $ident }->init_from_caller( $self, $method )
          if $deserializer_of{ $ident }->can('init_from_caller');
  
      # Try deserializing response - there may be some,
      # even if transport did not succeed (got a 500 response)
      if ( $response ) {
          # as our faults are false, returning a success marker is the only
          # reliable way of determining whether the deserializer succeeded.
          # Custom deserializers may return an empty list, or undef,
          # and $@ is not guaranteed to be undefined.
          my ($success, $result_body, $result_header) = eval {
              (1, $deserializer_of{ $ident }->deserialize( $response ));
          };
          if (defined $success) {
              return wantarray
                  ? ($result_body, $result_header)
                  : $result_body;
          }
          elsif (blessed $@) { #}&& $@->isa('SOAP::WSDL::SOAP::Typelib::Fault11')) {
              return $@;
          }
          else {
              return $deserializer_of{ $ident }->generate_fault({
                  code => 'soap:Server',
                  role => 'urn:localhost',
                  message => "Error deserializing message: $@. \n"
                      . "Message was: \n$response"
              });
          }
      };
  
      # if we had no success (Transport layer error status code)
      # or if transport layer failed
      if ( ! $transport_of{ $ident }->is_success() ) {
  
          # generate & return fault if we cannot serialize response
          # or have none...
          return $deserializer_of{ $ident }->generate_fault({
              code => 'soap:Server',
              role => 'urn:localhost',
              message => 'Error sending / receiving message: '
                  . $transport_of{ $ident }->message()
          });
      }
  } ## end sub call
  
  1;
  
  __END__
  
  =pod
  
  =head1 NAME
  
  SOAP::WSDL::Client - SOAP::WSDL's SOAP Client
  
  =head1 SYNOPSIS
  
   use SOAP::WSDL::Client;
   my $soap = SOAP::WSDL::Client->new({
       proxy => 'http://www.example.org/webservice/test'
   });
   $soap->call( \%method, $body, $header);
  
  =head1 METHODS
  
  =head2 call
  
   $soap->call( \%method, \@parts );
  
  %method is a hash with the following keys:
  
   Name           Description
   ----------------------------------------------------
   operation      operation name
   soap_action    SOAPAction HTTP header to use
   style          Operation style. One of (document|rpc)
   use            SOAP body encoding. One of (literal|encoded)
  
  The style and use keys have no influence yet.
  
  @parts is a list containing the elements of the message parts.
  
  For backward compatibility, call may also be called as below:
  
   $soap->call( $method, \@parts );
  
  In this case, $method is the SOAP operation name, and the SOAPAction header
  is guessed from the first part's namespace and the operation name (which is
  mostly correct, but may fail). Operation style and body encoding are assumed to
  be document/literal
  
  =head2 Configuration methods
  
  =head3 outputxml
  
   $soap->outputxml(1);
  
  When set, call() returns the raw XML of the SOAP Envelope.
  
  =head3 set_content_type
  
   $soap->set_content_type('application/xml; charset: utf8');
  
  Sets the content type and character encoding.
  
  You probably should not use a character encoding different from utf8:
  SOAP::WSDL::Client will not convert the request into a different encoding
  (yet).
  
  To leave out the encoding, just set the content type without appending charset
  like this:
  
    $soap->set_content_type('text/xml');
  
  Default:
  
   text/xml; charset: utf8
  
  =head3 set_prefix
  
   $soap->set_prefix('ns2');
  
  If set, alters the serialization of the request XML such that the supplied value is used as a namespace prefix for SOAP method calls. By way of example, the default XML serialization returns something like this:
  
      <?xml version="1.0"?>
      <SOAP-ENV:Envelope
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/">
        <SOAP-ENV:Body>
          <getElementId xmlns="http://services.exmaple.org/">
            <elementId>12345</elementId>
          </getElementId>
        </SOAP-ENV:Body>
      </SOAP-ENV:Envelope>
  
  If the sample set_prefix() call above is used prior to calling your SOAP method, the XML serialization returns this instead:
  
      <?xml version="1.0"?>
      <SOAP-ENV:Envelope
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
          xmlns:ns2="http://services.example.org/">
        <SOAP-ENV:Body>
          <ns2:getElementId>
            <elementId>12345</elementId>
          </ns2:getElementId>
        </SOAP-ENV:Body>
      </SOAP-ENV:Envelope>
  
  This is useful in cases where, for instance, one is communicating with a JAX L<https://jax-ws.dev.java.net/> webservice, which tends to understand the latter but not the former. Note that this implementation is currently limited to a single additional namespace; if you require multiple custom namespaces, you should probably look into creating your own serializer.
  
  =head2 Features different from SOAP::Lite
  
  SOAP::WSDL does not aim to be a complete replacement for SOAP::Lite - the
  SOAP::Lite module has its strengths and weaknesses and SOAP::WSDL is
  designed as a cure for the weakness of little WSDL support - nothing more,
  nothing less.
  
  Nonetheless SOAP::WSDL mimics part of SOAP::Lite's API and behaviour,
  so SOAP::Lite users can switch without looking up every method call in the
  documentation.
  
  A few things are quite different from SOAP::Lite, though:
  
  =head3 SOAP request data
  
  SOAP request data may either be given as message object, or as a hash ref (in
  which case it will automatically be encoded into a message object).
  
  =head3 Return values
  
  The result from call() is not a SOAP::SOM object, but a message object.
  
  Message objects' classes may be generated from WSDL definitions automatically
  - see SOAP::WSDL::Generator::Typelib on how to generate your own WSDL based
  message class library.
  
  =head3 Fault handling
  
  SOAP::WSDL::Client returns a fault object on errors, even on transport layer
  errors.
  
  The fault object is a SOAP1.1 fault object of the following
  C<SOAP::WSDL::SOAP::Typelib::Fault11>.
  
  SOAP::WSDL::SOAP::Typelib::Fault11 objects are false in boolean context, so
  you can just do something like:
  
   my $result = $soap->call($method, $data);
  
   if ($result) {
      # handle result
   }
   else {
      die $result->faultstring();
   }
  
  =head3 outputxml
  
  SOAP::Lite returns only the content of the SOAP body when outputxml is set
  to true. SOAP::WSDL::Client returns the complete XML response.
  
  =head3 Auto-Dispatching
  
  SOAP::WSDL::Client B<does not> support auto-dispatching.
  
  This is on purpose: You may easily create interface classes by using
  SOAP::WSDL::Client and implementing something like
  
   sub mySoapMethod {
       my $self = shift;
       $soap_wsdl_client->call( mySoapMethod, @_);
   }
  
  You may even do this in a class factory - see L<wsdl2perl.pl> for creating
  such interfaces.
  
  =head1 TROUBLESHOOTING
  
  =head2 Accessing protected web services
  
  Accessing protected web services is very specific for the transport
  backend used.
  
  In general, you may pass additional arguments to the set_proxy method (or
  a list ref of the web service address and any additional arguments to the
  new method's I<proxy> argument).
  
  Refer to the appropriate transport module for documentation.
  
  =head1 LICENSE AND COPYRIGHT
  
  Copyright 2004-2007 Martin Kutter.
  
  This file is part of SOAP-WSDL. You may distribute/modify it under the same
  terms as perl itself
  
  =head1 AUTHOR
  
  Martin Kutter E<lt>martin.kutter fen-net.deE<gt>
  
  =head1 REPOSITORY INFORMATION
  
   $Rev: 861 $
   $LastChangedBy: kutterma $
   $Id: Client.pm 861 2010-03-28 10:41:26Z kutterma $
   $HeadURL: https://soap-wsdl.svn.sourceforge.net/svnroot/soap-wsdl/SOAP-WSDL/branches/Typemap/lib/SOAP/WSDL/Client.pm $
  
  =cut
  
SOAP_WSDL_CLIENT

$fatpacked{"SOAP/WSDL/Client/Base.pm"} = <<'SOAP_WSDL_CLIENT_BASE';
  package
    SOAP::WSDL::Client::Base;
  use strict;
  use warnings;
  use base 'SOAP::WSDL::Client';
  use Scalar::Util qw(blessed);
  
  use version; our $VERSION = qv('2.00.99_3');
  
  sub call {
      my ($self, $method, $body, $header) = @_;
  
      # Treat non-objects special
      if (not blessed $body) {
  
          # make sure there's something sensible in our body data
          $body = {} if not defined $body;
          $body = ref $body eq 'ARRAY' ? $body : [ $body ];
  
          my @body_from = @{ $body }; # make a copy
  
          # build list of parts as objects initialized with
          # parameters given
          my @part_from = ();
          foreach my $class (@{ $method->{ body }->{ parts } }) {
              eval "require $class" || die $@;    ## no critic (ProhibitStringyEval)
              push @part_from, $class->new(shift(@body_from) || {});
          }
  
          # it's either the first part or a list ref with all parts...
          $body = $#part_from ? \@part_from : $part_from[0];
      }
  
      # if we have a header
      if (%{ $method->{ header } }) {
  
          # treat non object special - as above, but only for one
          if (not blessed $header) {
              my $class = $method->{ header }->{ parts }->[0];
              eval "require $class" || die $@;    ## no critic (ProhibitStringyEval)
              $header = $class->new($header);
          }
      }
      return $self->SUPER::call($method, $body, $header);
  }
  
  1;
  
  __END__
  
SOAP_WSDL_CLIENT_BASE

$fatpacked{"SOAP/WSDL/Definitions.pm"} = <<'SOAP_WSDL_DEFINITIONS';
  package
    SOAP::WSDL::Definitions;
  use strict;
  use warnings;
  use List::Util qw(first);
  use Class::Std::Fast::Storable;
  use base qw(SOAP::WSDL::Base);
  
  use version; our $VERSION = qv('2.00.99_3');
  
  my %types_of        :ATTR(:name<types>      :default<[]>);
  my %message_of      :ATTR(:name<message>    :default<[]>);
  my %portType_of     :ATTR(:name<portType>   :default<[]>);
  my %binding_of      :ATTR(:name<binding>    :default<[]>);
  my %service_of      :ATTR(:name<service>    :default<[]>);
  my %namespace_of    :ATTR(:name<namespace>  :default<()>);
  
  # must be attr for Class::Std::Fast::Storable
  #my %attributes_of :ATTR();
  my %attributes_of = (
      binding     => \%binding_of,
      message     => \%message_of,
      portType    => \%portType_of,
      service     => \%service_of,
  );
  
  # Function factory - we could be writing this method for all %attribute
  # keys, too, but that's just C&P (eehm, Copy & Paste...)
  BLOCK: {
    foreach my $method(keys %attributes_of ) {
    no strict qw/refs/;               ## no critic ProhibitNoStrict
        *{ "find_$method" } = sub {
            my ($self, @args_from) = @_;
            @args_from = @{ $args_from[0] } if ref $args_from[0] eq 'ARRAY';
            return first {
                    $_->get_targetNamespace() eq $args_from[0]
                    && $_->get_name() eq $args_from[1]
                }
                @{ $attributes_of{ $method }->{ ident $self } };
        };
    }
  }
  
  
  1;
  
  =pod
  
  =head1 NAME
  
  SOAP::WSDL::Definitions - model a WSDL E<gt>definitionsE<lt> element
  
  =head1 DESCRIPTION
  
  =head1 METHODS
  
  =head2 first_service get_service set_service push_service
  
  Accessors/Mutators for accessing / setting the E<gt>serviceE<lt> child
  element(s).
  
  =head2 find_service
  
  Returns the service matching the namespace/localname pair passed as arguments.
  
   my $service = $wsdl->find_service($namespace, $localname);
  
  =head2 first_binding get_binding set_binding push_binding
  
  Accessors/Mutators for accessing / setting the E<gt>bindingE<lt> child
  element(s).
  
  =head2 find_binding
  
  Returns the binding matching the namespace/localname pair passed as arguments.
  
   my $binding = $wsdl->find_binding($namespace, $localname);
  
  =head2 first_portType get_portType set_portType push_portType
  
  Accessors/Mutators for accessing / setting the E<gt>portTypeE<lt> child
  element(s).
  
  =head2 find_portType
  
  Returns the portType matching the namespace/localname pair passed as arguments.
  
   my $portType = $wsdl->find_portType($namespace, $localname);
  
  =head2 first_message get_message set_message push_message
  
  Accessors/Mutators for accessing / setting the E<gt>messageE<lt> child
  element(s).
  
  =head2 find_message
  
  Returns the message matching the namespace/localname pair passed as arguments.
  
   my $message = $wsdl->find_message($namespace, $localname);
  
  =head2 first_types get_types set_types push_types
  
  Accessors/Mutators for accessing / setting the E<gt>typesE<lt> child
  element(s).
  
  =head1 LICENSE AND COPYRIGHT
  
  Copyright 2004-2007 Martin Kutter.
  
  This file is part of SOAP-WSDL. You may distribute/modify it under
  the same terms as perl itself
  
  =head1 AUTHOR
  
  Martin Kutter E<lt>martin.kutter fen-net.deE<gt>
  
  =head1 REPOSITORY INFORMATION
  
   $Rev: 861 $
   $LastChangedBy: kutterma $
   $Id: Definitions.pm 861 2010-03-28 10:41:26Z kutterma $
   $HeadURL: https://soap-wsdl.svn.sourceforge.net/svnroot/soap-wsdl/SOAP-WSDL/branches/Typemap/lib/SOAP/WSDL/Definitions.pm $
  
  =cut
  
SOAP_WSDL_DEFINITIONS

$fatpacked{"SOAP/WSDL/Deserializer/Hash.pm"} = <<'SOAP_WSDL_DESERIALIZER_HASH';
  package
    SOAP::WSDL::Deserializer::Hash;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable;
  use SOAP::WSDL::SOAP::Typelib::Fault11;
  use SOAP::WSDL::Expat::Message2Hash;
  
  use SOAP::WSDL::Factory::Deserializer;
  SOAP::WSDL::Factory::Deserializer->register( '1.1', __PACKAGE__ );
  
  use version; our $VERSION = qv('2.00.99_3');
  
  sub BUILD {
      my ($self, $ident, $args_of_ref) = @_;
  
      # ignore all options
      for (keys %{ $args_of_ref }) {
          delete $args_of_ref->{ $_ }
      }
  }
  
  sub deserialize {
      my ($self, $content) = @_;
  
      my $parser = SOAP::WSDL::Expat::Message2Hash->new();
      eval { $parser->parse_string( $content ) };
      if ($@) {
          die $self->generate_fault({
              code => 'soap:Server',
              role => 'urn:localhost',
              message => "Error deserializing message: $@. \n"
                  . "Message was: \n$content"
          });
      }
      return $parser->get_data();
  }
  
  sub generate_fault {
      my ($self, $args_from_ref) = @_;
      return SOAP::WSDL::SOAP::Typelib::Fault11->new({
              faultcode => $args_from_ref->{ code } || 'SOAP-ENV:Client',
              faultactor => $args_from_ref->{ role } || 'urn:localhost',
              faultstring => $args_from_ref->{ message } || "Unknown error"
      });
  }
  
  1;
  
  =head1 NAME
  
  SOAP::WSDL::Deserializer::Hash - Deserializer SOAP messages into perl hash refs
  
  =head1 SYNOPSIS
  
   use SOAP::WSDL;
   use SOAP::WSDL::Deserializer::Hash;
  
  =head1 DESCRIPTION
  
  Deserializer for creating perl hash refs as result of a SOAP call.
  
  =head2 Output structure
  
  The XML structure is converted into a perl data structure consisting of
  hash and or list references. List references are used for holding array data.
  
  SOAP::WSDL::Deserializer::Hash creates list references always at the maximum
  depth possible.
  
  Examples:
  
   XML:
   <MyDataArray>
      <MyData>1</MyData>
      <MyData>1</MyData>
   </MyDataArray>
  
   Perl:
   {
       MyDataArray => {
           MyData => [ 1, 1 ]
       }
   }
  
   XML:
   <DeepArray>
      <MyData><int>1<int>/MyData>
      <MyData><int>1<int>/MyData>
   </DeepArray>
  
   Perl:
   {
       MyDataArray => {
           MyData => [
              { int => 1 },
              { int => 1 }
           ]
       }
   }
  
  List reference creation is triggered by the second occurance of an element.
  XML Array types with one element only will not be represented as list
  references.
  
  =head1 USAGE
  
  All you need to do is to use SOAP::WSDL::Deserializer::Hash.
  
  SOAP::WSDL::Deserializer::Hash autoregisters itself for SOAP1.1 messages
  
  You may register SOAP::WSDLDeserializer::Hash for other SOAP Versions by
  calling
  
   SOAP::Factory::Deserializer->register('1.2',
      SOAP::WSDL::Deserializer::Hash)
  
  =head1 Limitations
  
  =over
  
  =item * Namespaces
  
  All namespaces are ignored.
  
  =item * XML attributes
  
  All XML attributes are ignored.
  
  =back
  
  =head2 Differences from other SOAP::WSDL::Deserializer classes
  
  =over
  
  =item * generate_fault
  
  SOAP::WSDL::Deserializer::Hash will die with a SOAP::WSDL::Fault11 object when
  a parse error appears
  
  =back
  
  =head1 METHODS
  
  =head2 deserialize
  
  Deserializes the message.
  
  =head2 generate_fault
  
  Generates a L<SOAP::WSDL::SOAP::Typelib::Fault11|SOAP::WSDL::SOAP::Typelib::Fault11>
  object and returns it.
  
  =head1 LICENSE AND COPYRIGHT
  
  Copyright 2004-2008 Martin Kutter.
  
  This file is part of SOAP-WSDL. You may distribute/modify it under
  the same terms as perl itself.
  
  =head1 AUTHOR
  
  Martin Kutter E<lt>martin.kutter fen-net.deE<gt>
  
  =head1 REPOSITORY INFORMATION
  
   $Rev: 861 $
   $LastChangedBy: kutterma $
   $Id: Hash.pm 861 2010-03-28 10:41:26Z kutterma $
   $HeadURL: https://soap-wsdl.svn.sourceforge.net/svnroot/soap-wsdl/SOAP-WSDL/branches/Typemap/lib/SOAP/WSDL/Deserializer/Hash.pm $
  
  =cut
SOAP_WSDL_DESERIALIZER_HASH

$fatpacked{"SOAP/WSDL/Deserializer/SOM.pm"} = <<'SOAP_WSDL_DESERIALIZER_SOM';
  package
    SOAP::WSDL::Deserializer::SOM;
  use strict;
  use warnings;
  
  use version; our $VERSION = qv('2.00.99_3');
  our @ISA;
  
  eval {
      require SOAP::Lite;
      push @ISA, 'SOAP::Deserializer';
  }
  or die "Cannot load SOAP::Lite.
  Cannot deserialize to SOM object without SOAP::Lite.
  Please install SOAP::Lite.";
  
  sub deserialize {
      my $self = shift;
      my $result = eval { $self->SUPER::deserialize(@_) };
      if ($@) {
          return SOAP::Fault->new(
              faultactor => 'SOAP-ENV:Server',
              faultstring => $@,
          );
      }
      return $result;
  }
  
  sub generate_fault {
      my ($self, $args_from_ref) = @_;
      # code, message, detail, actor
      die SOAP::Fault->new(
          faultcode => $args_from_ref->{ code },
          faultstring => $args_from_ref->{ message },
          faultactor => $args_from_ref->{ role },
      );
  }
  
  1;
  
  __END__
  
  =head1 NAME
  
  SOAP::WSDL::Deserializer::SOM - Deserializer SOAP messages into SOM objects
  
  =head1 SYNOPSIS
  
   use SOAP::WSDL;
   use SOAP::WSDL::Deserializer::SOM;
   use SOAP::WSDL::Factory::Deserializer;
   SOAP::WSDL::Factory::Deserializer->register( '1.1', __PACKAGE__ );
  
  =head1 DESCRIPTION
  
  Deserializer for creating SOAP::Lite's SOM object as result of a SOAP call.
  
  This package is here for two reasons:
  
  =over
  
  =item * Compatibility
  
  You don't have to change the rest of your SOAP::Lite based app when switching
  to SOAP::WSDL, but can just use SOAP::WSDL::Deserializer::SOM to get back the
  same objects as you were used to.
  
  =item * Completeness
  
  SOAP::Lite covers much more of the SOAP specification than SOAP::WSDL.
  
  SOAP::WSDL::Deserializer::SOM can be used for content which cannot be
  deserialized by L<SOAP::WSDL::Deserializer::SOAP11|SOAP::WSDL::Deserializer::SOAP11>.
  This may be XML including mixed content, attachements and other XML data not
  (yet) handled by L<SOAP::WSDL::Deserializer::SOAP11|SOAP::WSDL::Deserializer::SOAP11>.
  
  =back
  
  SOAP::WSDL::Deserializer::SOM is a subclass of L<SOAP::Deserializer|SOAP::Deserializer>
  from the L<SOAP::Lite|SOAP::Lite> package.
  
  =head1 METHODS
  
  =head2 deserialize
  
  Deserializes a XML sting into a SOAP::SOM object. Returns a SOAP::Fault object
  on deserialization errors.
  
  =head2 generate_fault
  
  Dies with a SOAP::Fault object.
  
  =head1 USAGE
  
  SOAP::WSDL::Deserializer will not autoregister itself - to use it for a particular
  SOAP version just use the following lines:
  
   my $soap_version = '1.1'; # or '1.2', further versions may appear.
  
   use SOAP::WSDL::Deserializer::SOM;
   use SOAP::WSDL::Factory::Deserializer;
   SOAP::WSDL::Factory::Deserializer->register( $soap_version, __PACKAGE__ );
  
  =head1 DIFFERENCES FROM OTHER CLASSES
  
  =head2 Differences from SOAP::Lite
  
  =over
  
  =item * No on_fault handler
  
  You cannot specify what to do when an error occurs - SOAP::WSDL will return
  a SOAP::Fault object on transport errors.
  
  =back
  
  =head2 Differences from other SOAP::WSDL::Deserializer classes
  
  =over
  
  =item * generate_fault
  
  SOAP::WSDL::Deserializer::SOM will die with a SOAP::Fault object on calls
  to generate_fault.
  
  This also means that a SOAP::Fault may be thrown as exception when using
  
  
  =back
  
  =head1 LICENSE AND COPYRIGHT
  
  Copyright 2004-2007 Martin Kutter.
  
  This file is part of SOAP-WSDL. You may distribute/modify it under
  the same terms as perl itself.
  
  =head1 AUTHOR
  
  Martin Kutter E<lt>martin.kutter fen-net.deE<gt>
  
  =head1 REPOSITORY INFORMATION
  
   $Rev: 861 $
   $LastChangedBy: kutterma $
   $Id: SOM.pm 861 2010-03-28 10:41:26Z kutterma $
   $HeadURL: https://soap-wsdl.svn.sourceforge.net/svnroot/soap-wsdl/SOAP-WSDL/branches/Typemap/lib/SOAP/WSDL/Deserializer/SOM.pm $
  
  =cut
SOAP_WSDL_DESERIALIZER_SOM

$fatpacked{"SOAP/WSDL/Deserializer/XSD.pm"} = <<'SOAP_WSDL_DESERIALIZER_XSD';
  package
    SOAP::WSDL::Deserializer::XSD;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable;
  use SOAP::WSDL::SOAP::Typelib::Fault11;
  use SOAP::WSDL::Expat::MessageParser;
  
  use version; our $VERSION = qv('2.00.99_3');
  
  my %class_resolver_of        :ATTR(:name<class_resolver>        :default<()>);
  my %response_header_parts_of :ATTR(:name<response_header_parts> :default<()>);
  my %response_body_parts_of   :ATTR(:name<response_body_parts>   :default<()>);
  my %strict_of                :ATTR(:get<strict> :init_arg<strict> :default<1>);
  my %parser_of                :ATTR();
  
  sub set_strict {
      undef $parser_of{${$_[0]}};
      $strict_of{${$_[0]}} = $_[1];
  }
  
  # TODO cleanup
  #
  # init_from_caller is currently in a pretty ugly state, due to a late
  # introduction os some kind of inversion of control.
  #
  # init_from_caller transfers control over the initialization process from
  # the SOAP::WSDL::Client to the deserializer, which can grab the information
  # required from the (passed) calling object.
  #
  # The inversion of control is currently incomplete, because the deserializer
  # cannot get the method info from the client (this is not implemented yet)
  # and therefor gets passed the method info hash ref.
  #
  # Moreover, method names for retrieving class and name resolver are
  # somewhat mixed up.
  #
  # Unfortunately, we cannot just change the implementataion, as it would
  # require users to re-generate their interfaces.
  
  sub init_from_caller {
      my ($self, $caller, $method) = @_;
  
      my $parser
          = $parser_of{ ${ $self } }
        ||= SOAP::WSDL::Expat::MessageParser->new();
  
      # old style
      $parser->class_resolver( $caller->get_class_resolver() )
          if $caller->can('get_class_resolver');
  
      # new style
      $parser->set_name_resolver( $caller->_get_name_resolver() )
          if $caller->can('get_name_resolver');
  
      if ( ref $method ) {
          # set class resolver if serializer supports it
          if ( $caller->isa('SOAP::WSDL::Client') ) {
              $parser->set_header_parts( $method->{header}->{response}->{parts} );
              $parser->set_body_parts( $method->{body}->{response}->{parts} );
          }
          else {
              $parser->set_header_parts( $method->{header}->{parts} );
              $parser->set_body_parts( $method->{body}->{parts} );
          }
      }
  }
  
  sub deserialize {
      my ($self, $content) = @_;
  
      $parser_of{ ${ $self } } = SOAP::WSDL::Expat::MessageParser->new({
          strict => $strict_of{ ${ $self } },
          # old style init variant
          (defined $class_resolver_of{${ $self }}
          ? (class_resolver => $class_resolver_of{${ $self }})
          : () )
      })
          if not $parser_of{ ${ $self } };
  
      eval { $parser_of{ ${ $self } }->parse_string( $content ) };
      if ($@) {
          return $self->generate_fault({
              code => 'SOAP-ENV:Server',
              role => 'urn:localhost',
              message => "Error deserializing message: $@. \n"
                         . "Message was: \n$content"
          });
      }
      return ( $parser_of{ ${ $self } }->get_data(), $parser_of{ ${ $self } }->get_header() );
  }
  
  sub generate_fault {
      my ($self, $args_from_ref) = @_;
      return SOAP::WSDL::SOAP::Typelib::Fault11->new({
              faultcode => $args_from_ref->{ code } || 'SOAP-ENV:Client',
              faultactor => $args_from_ref->{ role } || 'urn:localhost',
              faultstring => $args_from_ref->{ message } || "Unknown error"
      });
  }
  
  1;
  
  __END__
  
  =head1 NAME
  
  SOAP::WSDL::Deserializer::XSD - Deserializer SOAP messages into SOAP::WSDL::XSD::Typelib:: objects
  
  =head1 DESCRIPTION
  
  Default deserializer for SOAP::WSDL::Client and interface classes generated by
  SOAP::WSDL. Converts SOAP messages to SOAP::WSDL::XSD::Typlib:: based objects.
  
  Needs a class_resolver typemap either passed by the generated interface
  or user-provided.
  
  SOAP::WSDL::Deserializer classes implement the API described in
  L<SOAP::WSDL::Factory::Deserializer>.
  
  =head1 USAGE
  
  Usually you don't need to do anything to use this package - it's the default
  deserializer for SOAP::WSDL::Client and interface classes generated by
  SOAP::WSDL.
  
  If you want to use the XSD serializer from SOAP::WSDL, set the outputtree()
  property and provide a class_resolver.
  
  =head1 OPTIONS
  
  =over
  
  =item * strict
  
  Enables/disables strict XML processing. Strict processing is enabled by
  default. To disable strict XML processing pass the following to the
  constructor or use the C<set_strict> method:
  
   strict => 0
  
  =back
  
  =head1 METHODS
  
  =head2 deserialize
  
  Deserializes the message.
  
  =head2 generate_fault
  
  Generates a L<SOAP::WSDL::SOAP::Typelib::Fault11|SOAP::WSDL::SOAP::Typelib::Fault11>
  object and returns it.
  
  =head2 set_strict
  
  Enable/disable strict XML parsing. Default is enabled.
  
  =head1 LICENSE AND COPYRIGHT
  
  Copyright 2004-2007 Martin Kutter.
  
  This file is part of SOAP-WSDL. You may distribute/modify it under
  the same terms as perl itself.
  
  =head1 AUTHOR
  
  Martin Kutter E<lt>martin.kutter fen-net.deE<gt>
  
  =head1 REPOSITORY INFORMATION
  
   $Rev: 861 $
   $LastChangedBy: kutterma $
   $Id: XSD.pm 861 2010-03-28 10:41:26Z kutterma $
   $HeadURL: https://soap-wsdl.svn.sourceforge.net/svnroot/soap-wsdl/SOAP-WSDL/branches/Typemap/lib/SOAP/WSDL/Deserializer/XSD.pm $
  
  =cut
SOAP_WSDL_DESERIALIZER_XSD

$fatpacked{"SOAP/WSDL/Expat/Base.pm"} = <<'SOAP_WSDL_EXPAT_BASE';
  package
    SOAP::WSDL::Expat::Base;
  use strict;
  use warnings;
  use URI;
  use XML::Parser::Expat;
  
  # TODO: convert to Class::Std::Fast based class - hash based classes suck.
  
  use version; our $VERSION = qv('2.00.99_3');
  
  sub new {
      my ($class, $arg_ref) = @_;
      my $self = {
          data => undef,
      };
      bless $self, $class;
  
      $self->set_user_agent($arg_ref->{ user_agent })
          if $arg_ref->{ user_agent };
      $self->{ parsed } = $arg_ref->{ parsed } if $arg_ref->{ parsed };
  
      return $self;
  }
  
  sub clone {
      my $self = shift;
      my $class = ref $self;
      my $clone = $class->new($self);
      return $clone;
  }
  
  sub set_uri { $_[0]->{ uri } = $_[1]; }
  sub get_uri { return $_[0]->{ uri }; }
  
  sub set_user_agent { $_[0]->{ user_agent } = $_[1]; }
  sub get_user_agent { return $_[0]->{ user_agent }; }
  
  # Mark a URI as "already parsed"
  sub set_parsed {
      my ($self, $uri) = @_;
      $self->{ parsed }->{ $uri } = 1;
      return;
  }
  
  
  # returns true if a specific URI has already been parsed
  sub is_parsed {
      my ($self, $uri) = @_;
      return exists $self->{ parsed }->{ $uri };
  }
  
  
  # parse a URI. This is the preferred parsing method for WSDL files, as it's
  # the only one allowing automatic import resolution
  sub parse_uri {
      my $self = shift;
      my $uri = shift;
  
      if ($self->is_parsed($uri)){
          warn "$uri already imported; ignoring it.\n";
          return;
      }
      $self->set_parsed($uri);
  
      $self->set_uri( $uri );
  
      if (not $self->{ user_agent }) {
          require LWP::UserAgent;
          $self->{ user_agent } = LWP::UserAgent->new();
      }
  
      my $response = $self->{ user_agent }->get($uri);
      die $response->message() if $response->code() ne '200';
      return $self->parse( $response->content() );
  }
  
  sub parse {
      eval {
          $_[0]->_initialize( XML::Parser::Expat->new( Namespaces => 1 )  )->parse( $_[1] );
          $_[0]->{ parser }->release();
      };
      $_[0]->{ parser }->xpcroak( $@ ) if $@;
      delete $_[0]->{ parser };
      return $_[0]->{ data };
  }
  
  sub parsefile {
      eval {
          $_[0]->_initialize( XML::Parser::Expat->new(Namespaces => 1) )->parsefile( $_[1] );
          $_[0]->{ parser }->release();
      };
      $_[0]->{ parser }->xpcroak( $@ ) if $@;
      delete $_[0]->{ parser };
      return $_[0]->{ data };
  }
  
  # SAX-like aliases
  sub parse_string;
  *parse_string = \&parse;
  
  sub parse_file;
  *parse_file = \&parsefile;
  
  sub get_data {
      return $_[0]->{ data };
  }
  
  1;
  
  =pod
  
  =head1 NAME
  
  SOAP::WSDL::Expat::Base - Base class for XML::Parser::Expat based XML parsers
  
  =head1 DESCRIPTION
  
  Base class for XML::Parser::Expat based XML parsers. All XML::SAX::Expat based
  parsers in SOAP::WSDL inherit from this class.
  
  =head1 AUTHOR
  
  Replace the whitespace by @ for E-Mail Address.
  
   Martin Kutter E<lt>martin.kutter fen-net.deE<gt>
  
  =head1 LICENSE AND COPYRIGHT
  
  Copyright 2004-2007 Martin Kutter.
  
  This file is part of SOAP-WSDL. You may distribute/modify it under
  the same terms as perl itself
  
  =head1 Repository information
  
   $Id: $
  
   $LastChangedDate: 2007-09-10 18:19:23 +0200 (Mo, 10 Sep 2007) $
   $LastChangedRevision: 218 $
   $LastChangedBy: kutterma $
  
   $HeadURL: https://soap-wsdl.svn.sourceforge.net/svnroot/soap-wsdl/SOAP-WSDL/trunk/lib/SOAP/WSDL/Expat/MessageParser.pm $
SOAP_WSDL_EXPAT_BASE

$fatpacked{"SOAP/WSDL/Expat/Message2Hash.pm"} = <<'SOAP_WSDL_EXPAT_MESSAGE2HASH';
  #!/usr/bin/perl
  package
    SOAP::WSDL::Expat::Message2Hash;
  use strict;
  use warnings;
  use base qw(SOAP::WSDL::Expat::Base);
  
  use version; our $VERSION = qv('2.00.99_3');
  
  sub _initialize {
      my ($self, $parser) = @_;
      $self->{ parser } = $parser;
      delete $self->{ data };             # remove potential old results
  
      my $characters;
      my $current = {};
      my $list = [];                      # node list
      my $current_part = q{};             # are we in header or body ?
      $self->{ data } = $current;
  
      # use "globals" for speed
      my ($_element, $_method,
          $_class, $_parser, %_attrs) = ();
  
      # no strict qw(refs);
      $parser->setHandlers(
          Start => sub {
              push @$list, $current;
             #If our element exists and is a list ref, add to it
              if ( exists $current->{ $_[1] }
                && ( ref ($current->{ $_[1] }) eq 'ARRAY')
              )  {
                  push @{ $current->{ $_[1] } }, {};
                  $current = $current->{ $_[1] }->[-1];
              }
              elsif ( exists $current->{ $_[1] } )
              {
                  $current->{ $_[1] } = [ $current->{ $_[1] }, {} ];
                  $current = $current->{ $_[1] }->[-1];
              }
              else {
                  $current->{ $_[1] } = {};
                  $current = $current->{ $_[1] };
              }
              return;
          },
  
          Char => sub {
              $characters .= $_[1] if $_[1] !~m{ \A \s* \z}xms;
              return;
          },
  
          End => sub {
              $_element = $_[1];
  
              # This one easily handles ignores for us, too...
              # return if not ref $$list[-1];
  
              if (length $characters) {
                  if (ref $list->[-1]->{ $_element } eq 'ARRAY') {
                      $list->[-1]->{ $_element }->[-1] = $characters ;
                  }
                  else {
                      $list->[-1]->{ $_element } = $characters;
                  }
              }
              $characters = q{};
              $current = pop @$list;           # step up in object hierarchy...
              return;
          }
      );
      return $parser;
  }
  
  1;
  
  =pod
  
  =head1 NAME
  
  SOAP::WSDL::Expat::Message2Hash - Convert SOAP messages to perl hash refs
  
  =head1 SYNOPSIS
  
   my $parser = SOAP::WSDL::Expat::MessageParser->new({
      class_resolver => 'My::Resolver'
   });
   $parser->parse( $xml );
   my $obj = $parser->get_data();
  
  =head1 DESCRIPTION
  
  Real fast expat based SOAP message parser.
  
  See L<SOAP::WSDL::Manual::Parser> for details.
  
  =head1 Bugs and Limitations
  
  =over
  
  =item * Ignores all namespaces
  
  =item * Ignores all attributes
  
  =item * Does not handle mixed content
  
  =item * The SOAP header is ignored
  
  =back
  
  =head1 AUTHOR
  
  Replace the whitespace by @ for E-Mail Address.
  
   Martin Kutter E<lt>martin.kutter fen-net.deE<gt>
  
  =head1 LICENSE AND COPYRIGHT
  
  Copyright 2004-2007 Martin Kutter.
  
  This file is part of SOAP-WSDL. You may distribute/modify it under
  the same terms as perl itself
  
  =head1 Repository information
  
   $Id: $
  
   $LastChangedDate: 2007-09-10 18:19:23 +0200 (Mo, 10 Sep 2007) $
   $LastChangedRevision: 218 $
   $LastChangedBy: kutterma $
  
   $HeadURL: https://soap-wsdl.svn.sourceforge.net/svnroot/soap-wsdl/SOAP-WSDL/trunk/lib/SOAP/WSDL/Expat/MessageParser.pm $
  
SOAP_WSDL_EXPAT_MESSAGE2HASH

$fatpacked{"SOAP/WSDL/Expat/MessageParser.pm"} = <<'SOAP_WSDL_EXPAT_MESSAGEPARSER';
  #!/usr/bin/perl
  package
    SOAP::WSDL::Expat::MessageParser;
  use strict; use warnings;
  
  use SOAP::WSDL::Generator::PrefixResolver;
  use SOAP::WSDL::XSD::Typelib::Builtin;
  use SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType;
  use SOAP::WSDL::XSD::Typelib::ComplexType;
  use base qw(SOAP::WSDL::Expat::Base);
  
  BEGIN { require Class::Std::Fast };
  
  our $VERSION = 2.01;
  
  # GLOBALS
  my $OBJECT_CACHE_REF = Class::Std::Fast::OBJECT_CACHE_REF();
  my $CLASSES_OF_REF = $SOAP::WSDL::XSD::Typelib::ComplexType::___classes_of_ref;
  
  # keep track of classes loaded
  my %LOADED_OF = ();
  
  sub new {
      my ($class, $args) = @_;
      my $self = {
          prefix_resolver => $args->{ prefix_resolver } || SOAP::WSDL::Generator::PrefixResolver->new(),
          class_resolver  => $args->{ class_resolver },
          body_parts      => $args->{ body_parts }   || [],
          header_parts    => $args->{ header_parts } || [],
          strict          => exists $args->{ strict } ? $args->{ strict } : 1,
      };
  
      bless $self, $class;
  
      $self->load_classes()
          if $args->{ class_resolver }
             && ! exists $LOADED_OF{ $self->{ class_resolver } };
  
      return $self;
  }
  
  sub set_header_parts {
      $_[0]->{ header_parts } = $_[1];
  }
  
  sub set_body_parts {
      $_[0]->{ body_parts } = $_[1];
  }
  
  sub class_resolver {
      my $self = shift;
      if ( @_ ) {
          $self->{ class_resolver } = shift
              or return;
          $self->load_classes() if ! exists $LOADED_OF{ $self->{ class_resolver } };
      }
      return $self->{ class_resolver };
  }
  
  sub load_classes {
      my $self = shift;
  
      return if $LOADED_OF{ $self->{ class_resolver } }
             || ! $self->{ class_resolver }->can('get_typemap');
  
      # requires sorting to make sub-packages load after their parent
      for ( sort values %{ $self->{ class_resolver }->get_typemap() } ) {
          no strict qw(refs);
          my $class = $_;
  
          # ignore __SKIP__
          next if $class eq '__SKIP__';
  
          # check if namespace exists
          next if defined *{ "$class\::" }; # bad test - know a better one?
  
          # Require takes a bareword or a file name - we have to take
          # the filname road here...
          $class =~s{ :: }{/}xmsg;
          require "$class.pm";
      }
      $LOADED_OF{ $self->{ class_resolver } } = 1;
  }
  
  sub get_type_class {
      my ($self, $name) = @_;
      my ($prefix,$localname) = split m{:}x , $name;
      my $namespace;
      if ($localname) {
          $namespace = $self->{ parser }->expand_ns_prefix($prefix);
      }
      else {
          $namespace = $self->{ parser }->expand_ns_prefix('#default');
          $localname = $name;
      }
  
      return "SOAP::WSDL::XSD::Typelib::Builtin::$localname"
          if ($namespace eq 'http://www.w3.org/2001/XMLSchema');
  
      # resolve perl prefix
      my $perl_prefix = $self->{ prefix_resolver }->resolve_prefix('type', $namespace);
  
      # TODO build a perl name from >type< prefix and name using the prefix resolver
      return "$perl_prefix$localname";
  }
  
  sub _initialize {
      my ($self, $parser) = @_;
      $self->{ parser } = $parser;
  
      delete $self->{ data };                     # remove potential old results
      delete $self->{ header };
  
      # Note: $current MUST be undef - it is used as sentinel
      # on the object stack via if (! defined $list->[-1])
      # DON'T set it to anything else !
      my $current = undef;
  
      my ($list, $path)  = ([], []); # node list (object stack) and path
      my ($skip, $depth) = (0, 0);   # skip elements, depth
  
      # use "globals" for speed
      my ($_prefix, $_method, $_class, $_leaf, $characters, $_current_classes_of_ref, $handling_multiple_parts) = ();
      my (@_attr_from, %_xsi_attr_of) = ();
  
      my %parts_of = (
          body => {
             map {
                  exists $LOADED_OF{ $_ }
                      || eval "require $_" and $LOADED_OF{ $_ } = undef;
                  $_->__get_name() => $_
             } @{ $self->{ body_parts } }
          },
          header => {
              map {
                  exists $LOADED_OF{ $_ }
                      || eval "require $_" and $LOADED_OF{ $_ } = undef;
                  eval "require $_"; $_->__get_name() => $_
              } @{ $self->{ header_parts } }
          }
      );
  
      my %content_check = (
          0 => sub {
              die "Bad top node $_[1]" if $_[1] ne 'Envelope';
              die "Bad namespace for SOAP envelope: " . $_[0]->recognized_string()
                  if $_[0]->namespace($_[1]) ne 'http://schemas.xmlsoap.org/soap/envelope/';
              $depth++;
          },
          1 => sub {
              $depth++;
              if ($_[1] eq 'Body') {
                  if ( exists $self->{data} ) { # there was header data
                      $self->{ header } = delete $self->{ data };
                      $list = [];
                      $path = [];
                      undef $current;
                  }
                  $handling_multiple_parts = @{ $self->{body_parts} } > 1;
                  $_current_classes_of_ref = $parts_of{ body };
              }
              elsif ($_[1] eq 'Header') {
                  $handling_multiple_parts = @{ $self->{header_parts} } > 1;
                  $_current_classes_of_ref = $parts_of{ header };
              }
          },
      );
      # bypass checking wheter namespaces are OK in non-strict mode
      if (! $self->{strict}) {
  	    $content_check{0} = sub { $depth++ };
      }
      my $char_handler = sub {
          return if ! $_leaf;    # we only want characters in leaf nodes
          $characters .= $_[1];  # add to characters
          return;                # return void
      };
  
      my $start_handler = sub {
          # my ($parser, $element, %attrs) = @_;
          $_leaf = 1;     # believe we're a leaf node until we see an end
  
          # call methods without using their parameter stack. That's slightly
          # faster than $content_check{ $depth }->() and we don't have to pass
          # $_[1] to the method.
          return &{$content_check{ $depth }} if exists $content_check{ $depth };
  
          $depth++;
          return if ($skip);
          # handle attributes
          # Attribute names must not be converted into hash keys - they're
          # dual-valued scalars, and loose their second value when converted
          # to a hash key...
          %_xsi_attr_of = ();
          if (@_ > 2) {
              @_attr_from = @_[2..$#_];
  
              # handle xsi attributes
              # looks pretty C-ish - but those dual vars don't leave much choice
              my $i = 0;
              while ($i < @_attr_from) {
                  if ( ( $_[0]->namespace($_attr_from[$i]) || q{} ) eq 'http://www.w3.org/2001/XMLSchema-instance') {
                      $_xsi_attr_of{$_attr_from[$i]} = $_attr_from[$i + 1];
                      splice @_attr_from, $i, 2;
                  }
                  $i += 2;
              }
          }
  
          # we only need to set $_current_classes_of if we may have child nodes
          # set new class resolver
  
          # get class from current complexType
          $_class = exists $_xsi_attr_of{type}
              ? $self->get_type_class($_xsi_attr_of{type})
              : ( $_current_classes_of_ref->{ $_[1] });
  
          # When no class is found: throw error in strict mode
          # and enable skipping in lax mode. Be sure not to move
          # this block not below pushing stuff on @{ $list } - the
          # list contains a sentinel used as stop marker for
          # returning content (instead of adding it to a parent)
          if (! defined($_class) ) {
              if ($self->{ strict }) {
                  die "Cannot resolve class for element " . $_[1];
              }
              $skip = $depth;
              $_[0]->setHandlers( Char => undef );
              return;
          }
  
          # step down in tree
          # on the first object (after skipping Envelope/Body), $current
          # is undef.  We put it on the stack, anyway, and use it as sentinel
          # when  going through the closing tags in the End handler
          push @{ $list }, $current;                  # remember current
          push @{ $path }, $_current_classes_of_ref;  # remember class map
  
          # all Builtins are simple types
          # complexTypes need to look up their child's element map...
          COMPLEX: {
              if ( $_class !~ m{ SOAP::WSDL::XSD::Typelib::Builtin:: }x ) {
                  if ( exists $CLASSES_OF_REF->{ $_class } ) {
                      $_current_classes_of_ref = $CLASSES_OF_REF->{ $_class };
                      last COMPLEX;
                  }
  
                  # try parent classes - walk through isa
                  # only elements need to walk through @ISA
                  $_class->isa('SOAP::WSDL::XSD::Typelib::Element')
                      or last COMPLEX;
  
                  # follow @ISA depth first
                  no strict qw(refs);
                  my @isa = @{ "$_class\::ISA" };
                  ISA: {
                      do {
                          if ( exists $CLASSES_OF_REF->{ $isa[0] } ) {
                              $_current_classes_of_ref = $CLASSES_OF_REF->{ $isa[0] };
                              last ISA;
                          }
  
                          unshift @isa, @{ shift(@isa) . '::ISA'};
                      } until ($#isa < 0);
                  }
              }
          }
  
          # cleanup
          undef $current; # help profilers find real hot spots
          $characters = q{};
  
          # Create and set new objects using Class::Std::Fast's object cache
          # if possible, or blessing directly into the class in question
          # (circumventing constructor) here. That's dirty, but fast.
          #
          # TODO: check whether this is faster under all perls - there's
          # strange benchmark results...
          #
          # The alternative would read:
          # $current = $_class->new({ @_[2..$#_] });
  
          $current = pop @{ $OBJECT_CACHE_REF->{ $_class } };
          if ( ! defined $current ) {
              $current = bless \Class::Std::Fast::ID(), $_class;
          }
  
          # ahm - ain't this better off in a end handler?
          if ( $_xsi_attr_of{nil} && $_xsi_attr_of{nil} ne 'false' ) {
              undef $characters;
          }
  
          # set attributes if there are any
          $current->attr({ @_attr_from }) if @_attr_from;
  #        $depth++;
  
          # return is only half as fast as no statement - however,
          # XML::Parser::Expat accidentally calls the callbacks in
          # scalar (instead of void) context, making return faster
          return;
      };
  
      # compatibility start handler for use with typemaps
      my $start_handler_typemap = sub {
          # my ($parser, $element, %attrs) = @_;
  
          $_leaf = 1;  # believe we're a leaf node until we see an end
  
          # call methods without using their parameter stack
          # That's slightly faster than $content_check{ $depth }->()
          # and we don't have to pass $_[1] to the method.
          # Yup, that's dirty.
          return &{$content_check{ $depth }}
              if exists $content_check{ $depth };
  
          push @{ $path }, $_[1];        # step down in path
          return if $skip;               # skip inside __SKIP__
  
          # resolve class of this element
          $_class = $self->{ class_resolver }->get_class( $path );
  
          if (! defined($_class) and $self->{ strict }) {
              die "Cannot resolve class for element "
                  . join('/', @{ $path }) . " via " . $self->{ class_resolver };
          }
  
          if (! defined($_class) or ($_class eq '__SKIP__') ) {
              $skip = scalar @{ $path };
              $_[0]->setHandlers( Char => undef );
              return;
          }
  
          # step down in tree (remember current)
          #
          # on the first object (after skipping Envelope/Body), $current
          # is undef.
          # We put it on the stack, anyway, and use it as sentinel when
          # going through the closing tags in the End handler
          #
          push @{$list}, $current;
  
          # cleanup.
          undef $current;     # help profilers find the real hot spots
          $characters = q{};  # reset characters read
  
          # Create and set new objects using Class::Std::Fast's object cache
          # if possible, or blessing directly into the class in question
          # (circumventing constructor) here.
          # That's dirty, but fast.
          #
          # TODO: check whether this is faster under all perls - there's
          # strange benchmark results...
          #
          # The alternative would read:
          # $current = $_class->new({ @_[2..$#_] });
          #
          $current = pop @{ $OBJECT_CACHE_REF->{ $_class } };
          if ( ! defined $current ) {
              $current = bless \Class::Std::Fast::ID(), $_class;
          }
  
          # set attributes if there are any
          ATTR: {
              my %attr = @_[2..$#_];
  
              if ( %attr ) {
                  if ( my $nil = delete $attr{nil} ) {
                      # TODO: check namespace
                      if ($nil && $nil ne 'false') {
                          undef $characters;
                          last ATTR if ! %attr;
                      }
                  }
                  $current->attr(\%attr);
              }
          }
          $depth++;
  
          return; # Speed up XML::Parser::Expat - see above for why
      };
  
      my $end_handler = sub {
          # operate on @_ for performance
  
          $_current_classes_of_ref = pop @{ $path };  # step up in path
          $depth--;
  
          # check $skip - do we have to come back?
          #
          # Skip is a marker for the depth of the element to skip.
          # If depth ever drops below this, remove marker
          # be sure not to move the $depth-- below this block
          if ($skip) {
              return if $skip < $depth;
              $skip = 0;
              $_[0]->setHandlers( Char => $char_handler );
              return;
          }
  
          # we only set character values in leaf nodes
          # Use dirty but fast access via global variables.
          # The normal way (via method) would be this:
          # $current->set_value( $characters ) if (length($characters));
          $SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType::___value
              ->{ ${$current} } = $characters
                  if $_leaf && defined $characters && defined $current;
  
          # empty characters
          $characters = q{};
  
          # stop believing we're a leaf node
          undef $_leaf;
  
          # return if there's only one elment - can't set it in parent ;-)
          # but set as root element if we don't have one already.
          if ( defined $list->[-1] ) {
              # set appropriate attribute in last element
              # multiple values must be implemented in base class
              # TODO check if hash access is faster
              # $_method = "add_$_localname";
              $_method = "add_$_[1]";
  
              # fixup XML names for perl names
              $_method =~ s{\.}{__}xg;
              $_method =~ s{\-}{_}xg;
              $list->[-1]->$_method( $current );
  
              $current = pop @{$list}; # step up in object hierarchy
  
              undef $_leaf; # stop believing we're a leaf node
          }
          else {
              if ( $handling_multiple_parts ) {
                  push @{$self->{data} ||= []}, $current;
                  $current = ();
              }
              elsif ( ! exists $self->{ data } ) {
                  $self->{data} = $current;
              }
              # TODO: Skip content of anyType / any stuff
          }
  
          return; # Speed up XML::Parser::Expat - see above for why
      };
  
      my $end_handler_typemap = sub {
          pop @{ $path };                     # step up in path
          # check __SKIP__
          if ($skip) {
              return if $skip < scalar @{ $path };
              $skip = 0;
              $_[0]->setHandlers( Char => $char_handler );
              return;
          }
  
          $depth--;
  
          # we only set character values in leaf nodes
          if (defined $_leaf) {
              # Use dirty but fast access via global variables.
              # The normal way (via method) would be this:
              # $current->set_value( $characters ) if (length($characters));
              $SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType::___value
                  ->{ $$current } = $characters
                      if defined $characters && defined $current; # =~m{ [^\s] }xms;
          }
  
          # empty characters
          $characters = q{};
  
          # stop believing we're a leaf node
          undef $_leaf;
  
          # return if there's only one elment - can't set it in parent ;-)
          # but set as root element if we don't have one already.
          if ( ! defined $list->[-1] ) {
              $self->{ data } = $current if ! exists $self->{ data };
              return;
          };
  
          # set appropriate attribute in last element
          # multiple values must be implemented in base class
          # TODO check if hash access is faster
          # $_method = "add_$_localname";
          $_method = "add_$_[1]";
  
          # fixup XML names for perl names
          $_method =~s{\.}{__}xg;
          $_method =~s{\-}{_}xg;
          $list->[-1]->$_method( $current );
  
          # step up in object hierarchy
          $current = pop @$list;
  
          # Speed up XML::Parser::Expat - calls handlers in scalar context...
          return;
      };
  
      no strict qw(refs);
      $parser->setHandlers(
          Start => @{ $self->{ body_parts } }
              ? $start_handler
              : $start_handler_typemap,
          Char  => $char_handler,
          End   => @{ $self->{ body_parts } }
              ? $end_handler
              : $end_handler_typemap,
      );
  
      return $parser;
  }
  
  sub get_header {
      return $_[0]->{ header };
  }
  
  1;
  
  =pod
  
  =head1 NAME
  
  SOAP::WSDL::Expat::MessageParser - Convert SOAP messages to custom object trees
  
  =head1 SYNOPSIS
  
   my $parser = SOAP::WSDL::Expat::MessageParser->new({
      class_resolver => 'My::Resolver'
   });
   $parser->parse( $xml );
   my $obj = $parser->get_data();
  
  =head1 DESCRIPTION
  
  Real fast expat based SOAP message parser.
  
  See L<SOAP::WSDL::Manual::Parser> for details.
  
  =head2 Skipping unwanted items
  
  Skipping unwanted items only works with typemaps.
  
  The use of typemaps is discouraged from SOAP::WSDL 2.01 on. The typemap
  mechanism will become deprecated and eventually dropped in future versions of
  SOAP::WSDL.
  
  The information below is just there for completeness.
  
  Sometimes there's unneccessary information transported in SOAP messages.
  
  To skip XML nodes (including all child nodes), just edit the type map for
  the message, set the type map entry to '__SKIP__', and comment out all
  child elements you want to skip.
  
  =head1 Bugs and Limitations
  
  =over
  
  =item * Ignores all namespaces
  
  =item * Does not handle mixed content
  
  =item * The SOAP header is ignored
  
  =back
  
  =head1 AUTHOR
  
  Replace the whitespace by @ for E-Mail Address.
  
   Martin Kutter E<lt>martin.kutter fen-net.deE<gt>
  
  =head1 LICENSE AND COPYRIGHT
  
  Copyright 2004-2008 Martin Kutter.
  
  This file is part of SOAP-WSDL. You may distribute/modify it under
  the same terms as perl itself
  
  =head1 Repository information
  
   $Id: MessageParser.pm 840 2009-03-09 20:17:15Z kutterma $
  
   $LastChangedDate: 2009-03-09 14:17:15 -0600 (Mon, 09 Mar 2009) $
   $LastChangedRevision: 840 $
   $LastChangedBy: kutterma $
  
   $HeadURL: https://soap-wsdl.svn.sourceforge.net/svnroot/soap-wsdl/SOAP-WSDL/branches/Typemap/lib/SOAP/WSDL/Expat/MessageParser.pm $
  
SOAP_WSDL_EXPAT_MESSAGEPARSER

$fatpacked{"SOAP/WSDL/Expat/MessageStreamParser.pm"} = <<'SOAP_WSDL_EXPAT_MESSAGESTREAMPARSER';
  #!/usr/bin/perl
  package
    SOAP::WSDL::Expat::MessageStreamParser;
  use strict;
  use warnings;
  use XML::Parser::Expat;
  use SOAP::WSDL::Expat::MessageParser;
  use base qw(SOAP::WSDL::Expat::MessageParser);
  
  use version; our $VERSION = qv('2.00.99_3');
  
  sub parse_start {
      my $self = shift;
      $self->{ parser } = $_[0]->_initialize( XML::Parser::ExpatNB->new( Namespaces => 1 ) );
  }
  sub init;
  *init = \&parse_start;
  
  sub parse_more {
      $_[0]->{ parser }->parse_more( $_[1] );
  }
  
  sub parse_done {
      $_[0]->{ parser }->parse_done();
      $_[0]->{ parser }->release();
  }
  
  1;
  
  =pod
  
  =head1 NAME
  
  SOAP::WSDL::Expat::MessageStreamParser - Convert SOAP messages to custom object trees
  
  =head1 SYNOPSIS
  
   my $lwp = LWP::UserAgent->new();
  
   my $parser = SOAP::WSDL::Expat::MessageParser->new({
      class_resolver => 'My::Resolver'
   });
   my $chunk_parser = $parser->init();
   # process response while it comes in, trying to read 32k chunks.
   $lwp->request( $request, sub { $chunk_parser->parse_more($_[0]) } , 32468 );
   $chunk_parser->parse_done();
  
   my $obj = $parser->get_data();
  
  =head1 DESCRIPTION
  
  ExpatNB based parser for parsing huge documents.
  
  See L<SOAP::WSDL::Manual::Parser> for details.
  
  =head1 Bugs and Limitations
  
  See SOAP::WSDL::Expat::MessageParser
  
  =head1 AUTHOR
  
  Martin Kutter E<lt>martin.kutter fen-net.deE<gt>
  
  =head1 LICENSE AND COPYRIGHT
  
  Copyright 2007 Martin Kutter.
  
  This file is part of SOAP-WSDL. You may distribute/modify it under
  the same terms as perl itself
  
  =head1 REPOSITORY INFORMATION
  
   $Rev: 861 $
   $LastChangedBy: kutterma $
   $Id: MessageStreamParser.pm 861 2010-03-28 10:41:26Z kutterma $
   $HeadURL: https://soap-wsdl.svn.sourceforge.net/svnroot/soap-wsdl/SOAP-WSDL/branches/Typemap/lib/SOAP/WSDL/Expat/MessageStreamParser.pm $
  
  =cut
SOAP_WSDL_EXPAT_MESSAGESTREAMPARSER

$fatpacked{"SOAP/WSDL/Expat/WSDLParser.pm"} = <<'SOAP_WSDL_EXPAT_WSDLPARSER';
  package
    SOAP::WSDL::Expat::WSDLParser;
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
  
SOAP_WSDL_EXPAT_WSDLPARSER

$fatpacked{"SOAP/WSDL/Factory/Deserializer.pm"} = <<'SOAP_WSDL_FACTORY_DESERIALIZER';
  package
    SOAP::WSDL::Factory::Deserializer;
  use strict;
  use warnings;
  
  use version; our $VERSION = qv('2.00.99_3');
  
  my %DESERIALIZER = (
      '1.1' => 'SOAP::WSDL::Deserializer::XSD',
  );
  
  # class method
  sub register {
      my ($class, $ref_type, $package) = @_;
      $DESERIALIZER{ $ref_type } = $package;
  }
  
  sub get_deserializer {
      my ($self, $args_of_ref) = @_;
      $args_of_ref->{ soap_version } ||= '1.1';
      # sanity check
      die "no deserializer registered for SOAP version $args_of_ref->{ soap_version }"
          if not exists ($DESERIALIZER{ $args_of_ref->{ soap_version } });
  
      # load module
      eval "require $DESERIALIZER{ $args_of_ref->{ soap_version } }"
          or die "Cannot load serializer $DESERIALIZER{ $args_of_ref->{ soap_version } }", $@;
  
      return $DESERIALIZER{ $args_of_ref->{ soap_version } }->new($args_of_ref);
  }
  
  1;
  
SOAP_WSDL_FACTORY_DESERIALIZER

$fatpacked{"SOAP/WSDL/Factory/Generator.pm"} = <<'SOAP_WSDL_FACTORY_GENERATOR';
  package
    SOAP::WSDL::Factory::Generator;
  use strict;
  use warnings;
  
  use version; our $VERSION = qv('2.00.99_3');
  
  my %GENERATOR = (
      'XSD' => 'SOAP::WSDL::Generator::Template::XSD',
  );
  
  # class method
  sub register {
      my ($class, $ref_type, $package) = @_;
      $GENERATOR{ $ref_type } = $package;
  }
  
  sub get_generator {
      my ($self, $args_of_ref) = @_;
  
      # sanity check
  #    die "no generator registered for generation method $args_of_ref->{ type }"
  #
      my $generator_class = (exists ($GENERATOR{ $args_of_ref->{ type } }))
          ? $GENERATOR{ $args_of_ref->{ type } }
          : $args_of_ref->{ type };
  
      # load module
      eval "require $generator_class"
          or die "Cannot load generator $generator_class", $@;
  
      return $generator_class->new();
  }
  
  1;
  
SOAP_WSDL_FACTORY_GENERATOR

$fatpacked{"SOAP/WSDL/Factory/Serializer.pm"} = <<'SOAP_WSDL_FACTORY_SERIALIZER';
  package
    SOAP::WSDL::Factory::Serializer;
  use strict;
  use warnings;
  
  use version; our $VERSION = qv('2.00.99_3');
  
  my %SERIALIZER = (
      '1.1' => 'SOAP::WSDL::Serializer::XSD',
  );
  
  # class method
  sub register {
      my ($class, $ref_type, $package) = @_;
      $SERIALIZER{ $ref_type } = $package;
  }
  
  sub get_serializer {
      my ($self, $args_of_ref) = @_;
      $args_of_ref->{ soap_version } ||= '1.1';
      # sanity check
      die "no serializer registered for SOAP version $args_of_ref->{ soap_version }"
          if not exists ($SERIALIZER{ $args_of_ref->{ soap_version } });
  
      # load module
      eval "require $SERIALIZER{ $args_of_ref->{ soap_version } }"
          or die "Cannot load serializer $SERIALIZER{ $args_of_ref->{ soap_version } }", $@;
  
      return $SERIALIZER{ $args_of_ref->{ soap_version } }->new();
  }
  
  1;
  
SOAP_WSDL_FACTORY_SERIALIZER

$fatpacked{"SOAP/WSDL/Factory/Transport.pm"} = <<'SOAP_WSDL_FACTORY_TRANSPORT';
  package
    SOAP::WSDL::Factory::Transport;
  use strict;
  use warnings;
  use version; our $VERSION = qv('2.00.99_3');
  
  my %registered_transport_of = ();
  
  # Local constants
  # Could be made readonly, but that's just for the paranoid...
  my %SOAP_LITE_TRANSPORT_OF = (
      ftp => 'SOAP::Transport::FTP',
      http => 'SOAP::Transport::HTTP',
      https => 'SOAP::Transport::HTTP',
      mailto => 'SOAP::Transport::MAILTO',
      'local' => 'SOAP::Transport::LOCAL',
      jabber => 'SOAP::Transport::JABBER',
      mq => 'SOAP::Transport::MQ',
  );
  
  my %SOAP_WSDL_TRANSPORT_OF = (
      http => 'SOAP::WSDL::Transport::HTTP',
      https => 'SOAP::WSDL::Transport::HTTP',
  );
  
  # class methods only
  sub register {
      my ($class, $scheme, $package) = @_;
      die "Cannot use reference as scheme" if ref $scheme;
      $registered_transport_of{ $scheme } = $package;
  }
  
  sub get_transport {
      my ($class, $url, %attrs) = @_;
  
  
      my $scheme = $url;
      $scheme =~s{ \:.+$ }{}xm;
  
  
      if (defined $registered_transport_of{ $scheme }) {
          no strict qw(refs);
          $registered_transport_of{ $scheme }->can('new') or
              eval "require $registered_transport_of{ $scheme }"
                  or die "Cannot load transport class $registered_transport_of{ $scheme } : $@";
  
          # try "foo::Client" class first - SOAP::Tranport always requires
          # a package withoug the ::Client appended, and then
          # instantiates a ::Client object...
          # ... pretty weird ...
          # ... must be from some time when the max number of files was a
          # sparse resource ...
          # ... but we've decided to mimic SOAP::Lite...
  
          return $registered_transport_of{ $scheme }->new( %attrs );
      }
  
      # try SOAP::Lite's Transport module - just skip if not require'able
      SOAP_Lite: {
          if (exists $SOAP_LITE_TRANSPORT_OF{ $scheme }) {
              no strict qw(refs);
              # behaves interestingly different under different versions of perl
              # maybe true even if it's not available
              my $protocol_class = $SOAP_LITE_TRANSPORT_OF{ $scheme } . '::Client';
              $protocol_class->can('new')
                  or eval "require $SOAP_LITE_TRANSPORT_OF{ $scheme }"
                      or last SOAP_Lite;
  
              # may fail if it's not available
              my $transport = eval { $protocol_class->new( %attrs ) }
                  or last SOAP_Lite;
              return $transport;
          }
      }
  
      if (exists $SOAP_WSDL_TRANSPORT_OF{ $scheme }) {
          no strict qw(refs);
          $SOAP_WSDL_TRANSPORT_OF{ $scheme }->can('new')
              or eval "require $SOAP_WSDL_TRANSPORT_OF{ $scheme }"
                  or die "Cannot load transport class $SOAP_WSDL_TRANSPORT_OF{ $scheme } : $@";
          return $SOAP_WSDL_TRANSPORT_OF{ $scheme }->new( %attrs );
      }
  
      die "no transport class found for scheme <$scheme>";
  }
  
  1;
  
SOAP_WSDL_FACTORY_TRANSPORT

$fatpacked{"SOAP/WSDL/Generator/Iterator/WSDL11.pm"} = <<'SOAP_WSDL_GENERATOR_ITERATOR_WSDL11';
  package
    SOAP::WSDL::Generator::Iterator::WSDL11;
  use strict; use warnings;
  use Class::Std::Fast;
  
  use version; our $VERSION = qv('2.00.99_3');
  
  my %definitions_of  :ATTR(:name<definitions>    :default<[]>);
  my %nodes_of        :ATTR(:name<nodes>          :default<[]>);
  
  # memoization attributes
  my %portType_of     :ATTR();
  my %types_of        :ATTR();
  
  my %METHOD_OF = (
      'SOAP::WSDL::Definitions'   => 'get_service',
      'SOAP::WSDL::Service'       => 'get_port',
      'SOAP::WSDL::Port'          => sub {
          my ($self, $node) = @_;
          return if ! $node->first_address()
              or ! $node->first_address()->isa('SOAP::WSDL::SOAP::Address');
  
          return [ $self->get_definitions()
              ->find_binding( $node->expand( $node->get_binding() ) ) || () ];
      },
  
      'SOAP::WSDL::Binding'       => sub {
          my ($self, $node) = @_;
  
          # remember referenced portType
          $portType_of{ ident $self } = $self->get_definitions()
              ->find_portType( $node->expand( $node->get_type ) )
              or return [];
  
          return $node->get_operation();
      },
  
      'SOAP::WSDL::Operation'     => sub {
          my ($self, $node) = @_;
  
          my $name = $node->get_name();
  
          # get the equally named operation from the portType
          my ($op) = grep { $_->get_name() eq $name }
              @{ $portType_of{ ident $self }->get_operation() }
              or return [];
  
          return [ @{ $op->get_input }, @{ $op->get_output }, @{ $op->get_fault } ]
      },
  
      'SOAP::WSDL::OpMessage' => sub {
          my ($self, $node) = @_;
          return if ( ref $node->get_parent() eq 'SOAP::WSDL::Binding' );    # we're in binding
  
          # TODO maybe allow more messages && overloading by specifying name
  
          return [ $self->get_definitions()->find_message(
              $node->expand( $node->get_message() )
          ) || () ];
      },
  
      'SOAP::WSDL::Message'       => 'get_part',
  
      'SOAP::WSDL::Part'          => sub {
          my ($self, $node) = @_;
          my $ident = ident $self;
          my $types = $types_of{ $ident } = $definitions_of{ $ident }->get_types()->[0]
              or return [];
          return [
              # If we have a type, this type is to be used in document/literal
              # as global type. However this is forbidden, at least by WS-I.
              # We should store the style/encoding somewhere, and regard it.
              # TODO: auto-generate element for RPC bindings
              $node->get_type()
                  ? do {
                      die "unsupported global type <"
                          . $node->get_type . "> found in part <". $node->get_name() . ">\n"
                          . "Looks like a rpc/literal WSDL, which is not supported by SOAP::WSDL\n";
                      ## use this once we can auto-generate an element for RPC bindings
                      # $types->find_type( $node->expand($node->get_type) )
                  }
                  : (),
              $node->get_element()
                  ? $types->find_element( $node->expand($node->get_element) )
                  : (),
          ];
      },
  );
  
  sub init {
      my ($self, $arg_of) = @_;
      my $ident = ident $self;
      undef $portType_of{ $ident };
      undef $types_of{ $ident };
      $nodes_of{ $ident } = [
          exists($arg_of->{ node })
              ? $arg_of->{ node }
              : $definitions_of{ ident $self }
          ];
  }
  
  sub get_next {
      my $self = shift;
      my $ident = ident $self;
  
      my $node = shift @{ $nodes_of{ $ident }};
      return if ! defined $node;
  
      unshift @{ $nodes_of{ $ident }}, @{ $self->get_nextNodes( $node ) || [] };
  
      return $node;
  }
  
  sub get_nextNodes {
      my ($self, $node) = @_;
  
      my $method = $METHOD_OF{ ref $node }
          or return [];
  
      return (ref($method) eq 'CODE')
          ? $method->( $self, $node )
          : $node->can($method)->( $node );
  }
  
  1;
  
  __END__
  
  =pod
  
  =head1 NAME
  
  SOAP::WSDL::Generator::Iterator::WSDL11 - WSDL 1.1 Iterator
  
  =head1 SYNOPSIS
  
   my $iter = SOAP::WSDL::Generator::Iterator::WSDL11->new({
       definitions => $wsdl
   });
   $iter->init();
   while (my $node = $iter->get_next()) {
       # do something with node - possibly call _accept with a visitor on it...
   }
  
  =head1 DESCRIPTION
  
  Iterator for walking a WSDL 1.1 definition.
  
  The iterator performs a depth-first search along the following path:
  
   service
   port
   binding
   operation
   input/output/fault of operation in portType
   message
   part
   type/element in XML schema
  
  If you wonder about this path: This is how to look up which XML Schema element
  is associated with a operation from a service/port.
  
  =head2 Example
  
  The nodes are returned in the order denoted in the following example:
  
   <?xml version="1.0" encoding="UTF-8"?>
   <!-- 1 -->
   <definitions xmlns:http="http://schemas.xmlsoap.org/wsdl/http/"
     xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/"
     xmlns:s="http://www.w3.org/2001/XMLSchema" xmlns:s0="urn:HelloWorld"
     targetNamespace="urn:HelloWorld"
     xmlns="http://schemas.xmlsoap.org/wsdl/">
     <types>
       <s:schema elementFormDefault="qualified" targetNamespace="urn:HelloWorld">
         <!-- 9 -->
         <s:element name="sayHello">
           <s:complexType>
              <s:sequence>
                <s:element minOccurs="0" maxOccurs="1" name="name" type="s:string" />
                <s:element minOccurs="0" maxOccurs="1" name="givenName" type="s:string" nillable="1" />
              </s:sequence>
              <s:attribute name="testAttr" type="s:string" use="optional"></s:attribute>
            </s:complexType>
          </s:element>
  
          <!-- 13 -->
          <s:element name="sayHelloResponse">
            <s:complexType>
              <s:sequence>
                <s:element minOccurs="0" maxOccurs="1"
                  name="sayHelloResult" type="s:string" />
             </s:sequence>
           </s:complexType>
         </s:element>
       </s:schema>
     </types>
  
     <!-- 7 -->
     <message name="sayHelloSoapIn">
       <!-- 8 -->
       <part name="parameters" element="s0:sayHello" />
     </message>
  
     <!-- 11 -->
     <message name="sayHelloSoapOut">
       <!-- 12 -->
       <part name="parameters" element="s0:sayHelloResponse" />
     </message>
  
     <portType name="Service1Soap">
       <operation name="sayHello">
       <!-- 6 -->
       <input message="s0:sayHelloSoapIn" />
       <!-- 10 -->
       <output message="s0:sayHelloSoapOut" />
     </operation>
    </portType>
  
      <!-- 4 -->
      <binding name="Service1Soap" type="s0:Service1Soap">
          <soap:binding transport="http://schemas.xmlsoap.org/soap/http"
              style="document" />
  
          <!-- 5 -->
          <operation name="sayHello">
              <soap:operation soapAction="urn:HelloWorld#sayHello"
                  style="document" />
  
              <input>
                  <soap:body use="literal" />
              </input>
  
              <output>
                  <soap:body use="literal" />
              </output>
          </operation>
      </binding>
  
      <!-- 2 -->
      <service name="Service1">
          <!-- 3 -->
          <port name="Service1Soap" binding="s0:Service1Soap">
              <soap:address
                  location="http://localhost:81/soap-wsdl-test/helloworld.pl" />
          </port>
      </service>
   </definitions>
  
  You should not rely too much on this order - it may change. Even though the
  current order will probably remain, the nodes currently skipped might
  be returned somewhere along the path.
  
  
  =head1 LICENSE AND COPYRIGHT
  
  Copyright 2004-2008 Martin Kutter.
  
  This file is part of SOAP-WSDL. You may distribute/modify it under
  the same terms as perl itself
  
  =head1 AUTHOR
  
  Martin Kutter E<lt>martin.kutter fen-net.deE<gt>
  
  =head1 REPOSITORY INFORMATION
  
   $Rev: 239 $
   $LastChangedBy: kutterma $
   $Id: Client.pm 239 2007-09-11 09:45:42Z kutterma $
   $HeadURL: https://soap-wsdl.svn.sourceforge.net/svnroot/soap-wsdl/SOAP-WSDL/trunk/lib/SOAP/WSDL/Client.pm $
  
  =cut
SOAP_WSDL_GENERATOR_ITERATOR_WSDL11

$fatpacked{"SOAP/WSDL/Generator/PrefixResolver.pm"} = <<'SOAP_WSDL_GENERATOR_PREFIXRESOLVER';
  package
    SOAP::WSDL::Generator::PrefixResolver;
  use strict; use warnings;
  
  use Class::Std::Fast::Storable;
  
  use version; our $VERSION = qv('2.00.99_3');
  
  my %namespace_prefix_map_of :ATTR(:name<namespace_prefix_map>   :default<{}>);
  my %namespace_map_of        :ATTR(:name<namespace_map>          :default<{}>);
  my %prefix_of               :ATTR(:name<prefix> :default<{}>);
  
  sub resolve_prefix {
      my ($self, $type, $namespace, $element) = @_;
      my $prefix;
      if (not defined($namespace)) {
          $prefix = $prefix_of{ $$self }->{ $type }
      }
      else {
          $prefix = $namespace_prefix_map_of{ $$self }->{ $namespace }
              || ( ($namespace_map_of{ $$self }->{ $namespace })
                  ? join ('::', $prefix_of{ $$self }->{ $type }, $namespace_map_of{ $$self }->{ $namespace })
                  : $prefix_of{ $$self }->{ $type }
              );
      }
      return "${prefix}::";
  }
  
  1;
  
  __END__

SOAP_WSDL_GENERATOR_PREFIXRESOLVER

$fatpacked{"SOAP/WSDL/Generator/Template.pm"} = <<'SOAP_WSDL_GENERATOR_TEMPLATE';
  package
    SOAP::WSDL::Generator::Template;
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
  
SOAP_WSDL_GENERATOR_TEMPLATE

$fatpacked{"SOAP/WSDL/Generator/Template/Plugin/XSD.pm"} = <<'SOAP_WSDL_GENERATOR_TEMPLATE_PLUGIN_XSD';
  package
    SOAP::WSDL::Generator::Template::Plugin::XSD;
  use strict;
  use warnings;
  use Carp qw(confess);
  use Class::Std::Fast::Storable constructor => 'none';
  use Scalar::Util qw(blessed);
  use version; our $VERSION = qv('2.00.99_3');
  
  my %namespace_prefix_map_of :ATTR(:name<namespace_prefix_map>   :default<{}>);
  my %namespace_map_of        :ATTR(:name<namespace_map>          :default<{}>);
  my %prefix_of               :ATTR(:name<prefix>                 :default<()>);
  my %prefix_resolver_of      :ATTR(:name<prefix_resolver>        :default<()>);
  
  my %prefix_resolver_class_of    :ATTR(:name<prefix_resolver_class>  :default<()>);
  
  my %definitions_of          :ATTR(:name<definitions>            :default<()>);
  
  # create a singleton
  sub load {              # called as MyPlugin->load($context)
      my ($class, $context, @arg_from) = @_;
      my $stash = $context->stash();
      my $self = bless \do { my $o = Class::Std::Fast::ID() }, $class;
      $self->set_prefix_resolver_class( $stash->{ context }->{ prefix_resolver_class });
      $self->set_prefix_resolver( $stash->{ context }->{ prefix_resolver });
      $self->set_definitions( $stash->{ definitions });
      return $self;       # returns 'MyPlugin'
  }
  
  sub new {
      return shift if ref $_[0];
  
      my ($class, $arg_ref) = @_;
  
      my $self = bless \do { my $o = Class::Std::Fast::ID() }, $class;
      $self->set_prefix_resolver( $arg_ref->{ prefix_resolver });
      $self->set_definitions( $arg_ref->{ definitions });
      return $self;       # returns 'MyPlugin'
  }
  
  sub _get_prefix {
      my ($self, $type, $node) = @_;
      my $namespace = defined ($node)
          ? ref($node)
              ? $node->get_targetNamespace()
              : $node
          : undef;
      return $self->get_prefix_resolver()->resolve_prefix(
          $type,
          $namespace,
          ref($node)
              ? $node
              : undef
       );
  }
  
  sub create_xsd_name {
      my ($self, $node) = @_;
      confess "no node $node" if not defined($node)
          or $node eq "";
      my $name = $self->_resolve_prefix($node) #. '::'
          . $node->get_name();
      return $self->perl_name( $name );
  }
  
  sub create_typemap_name {
      my ($self, $node) = @_;
      my $name = $self->_get_prefix('typemap') #. '::'
          . $node->get_name();
      return $self->perl_name( $name );
  }
  
  sub create_server_name {
      my ($self, $server, $port) = @_;
      my $port_name = $port->get_name();
      $port_name =~s{\A (?:.+)\. ([^\.]+) \z}{$1}x;
      my $name = join( q{},
          $self->_get_prefix('server', $server),
           join( '::', $server->get_name(), $port_name)
      );
      return $self->perl_name( $name );
  }
  
  sub create_interface_name {
      my ($self, $server, $port) = @_;
      my $port_name = $port->get_name();
      $port_name =~s{\A (?:.+)\. ([^\.]+) \z}{$1}x;
      my $name = join( q{},
          $self->_get_prefix('interface', $server),
          join( '::', $server->get_name(), $port_name )
      );
      return $self->perl_name( $name );
  }
  
  sub _resolve_prefix {
      my ($self, $node) = @_;
  
      if ($node->isa('SOAP::WSDL::XSD::Builtin')) {
          return $self->_get_prefix('type', $node)
      }
      if ( $node->isa('SOAP::WSDL::XSD::SimpleType')
          or $node->isa('SOAP::WSDL::XSD::ComplexType')
      ) {
          return $self->_get_prefix('type', $node);
      }
      if ( $node->isa('SOAP::WSDL::XSD::Element') ) {
          return $self->_get_prefix('element', $node);
      }
      if ( $node->isa('SOAP::WSDL::XSD::Attribute') ) {
          return $self->_get_prefix('attribute', $node);
      }
  }
  
  sub perl_name {
      my $self = shift;
      my $name = shift;
      $name =~s{\-}{_}xmsg;
      $name =~s{\.}{::}xmsg;
      return $name;
  }
  
  sub perl_var_name {
      my $self = shift;
      my $name = shift;
      $name =~s{\-}{_}xmsg;
      $name =~s{\.}{__}xmsg;
      return $name;
  }
  
  sub create_subpackage_name {
      my $self        = shift;
      my $arg_ref     = shift;
      my $type        = ref $arg_ref eq 'HASH' ? $arg_ref->{ value } : $arg_ref;
  
      my @name_from = $type->get_name() || (); ;
  
      # search for top node in tree (the one directly below the Schema)
  	my $parent = $type;
  	my $top_node = $parent;
      if (! $parent->get_parent()->isa('SOAP::WSDL::XSD::Schema') ) {
          NAMES: while ($parent = $parent->get_parent()) {
              $top_node = $parent;
              last NAMES if $parent->get_parent()->isa('SOAP::WSDL::XSD::Schema');
              # skip empty names - atomic types have no name...
              unshift @name_from, $parent->get_name()
                  if $parent->get_name();
          }
      }
      # create name for top node
      die "No top node found" if not defined $top_node;
      my $top_node_name = $self->create_xsd_name($top_node);
      my $package_name = join('::_', $top_node_name , (@name_from) ? join('::', @name_from) : () );
  
      # replace dots by :: in name - subpackage names may include dots, too
      $package_name =~s{\.}{::}xg;
  
      return $package_name;
  }
  
  sub create_xmlattr_name {
      return join '::', shift->create_subpackage_name(shift), 'XmlAttr';
  }
  
  sub element_name {
      my $self = shift;
      my $element = shift;
  
      confess "no element object" unless blessed $element;
  
      my $name = $element->get_name();
      if (! $name) {
          while (my $ref = $element->get_ref()) {
  			# print "looking for: {", join('}', $element->expand( $ref )), "\n";
              $element = $self->get_definitions()->first_types()
                  ->find_element($element->expand( $ref ) );
  			# print $self->get_definitions()->first_types()->_DUMP;
  			# for (@{$self->get_definitions()->first_types()->get_schema}) {
  			#	print $_->_DUMP;
  			# }
  			$name = $element->get_name();
              last if ($name);
          }
      }
      return $name;
  }
  
  1;
  
  =pod
  
  =head1 NAME
  
  SOAP::WSDL::Generator::Template::Plugin::XSD - Template plugin for the XSD generator
  
  =head1 METHODS
  
  =head2 perl_name
  
   XSD.perl_name(element.get_name);
  
  Converts a XML name into a valid perl name (valid for subroutines, variables
  or the like).
  
  perl_name takes a crude approach by just replacing . and - (dot and dash)
  with a underscore. This may or may not be sufficient, and may or may not
  provoke collisions in your XML names.
  
  =head1 LICENSE AND COPYRIGHT
  
  Copyright 2008 Martin Kutter.
  
  This file is part of SOAP-WSDL. You may distribute/modify it under the same
  terms as perl itself
  
  =head1 AUTHOR
  
  Martin Kutter E<lt>martin.kutter fen-net.deE<gt>
  
  =head1 REPOSITORY INFORMATION
  
   $Rev: 564 $
   $LastChangedBy: kutterma $
   $Id: ComplexType.pm 564 2008-02-23 13:31:39Z kutterma $
   $HeadURL: http://soap-wsdl.svn.sourceforge.net/svnroot/soap-wsdl/SOAP-WSDL/trunk/lib/SOAP/WSDL/XSD/Typelib/ComplexType.pm $
  
  =cut
  
SOAP_WSDL_GENERATOR_TEMPLATE_PLUGIN_XSD

$fatpacked{"SOAP/WSDL/Generator/Template/XSD.pm"} = <<'SOAP_WSDL_GENERATOR_TEMPLATE_XSD';
  package
    SOAP::WSDL::Generator::Template::XSD;
  use strict; use warnings;
  use Template 2.18;
  use Class::Std::Fast::Storable;
  use File::Basename;
  use File::Spec;
  
  use version; our $VERSION = qv('2.00.99_3');
  
  use SOAP::WSDL::Generator::Visitor::Typemap;
  use SOAP::WSDL::Generator::Template::Plugin::XSD;
  use base qw(SOAP::WSDL::Generator::Template);
  
  my %output_of                   :ATTR(:name<output>         :default<()>);
  my %typemap_of                  :ATTR(:name<typemap>        :default<({})>);
  my %use_typemap_of              :ATTR(:name<use_typemap>    :default<0>);
  my %silent_of                   :ATTR(:name<silent>         :default<0>);
  
  sub BUILD {
      my ($self, $ident, $arg_ref) = @_;
      $self->set_EVAL_PERL(1);
      $self->set_RECURSION(1);
      $self->set_INCLUDE_PATH( exists $arg_ref->{INCLUDE_PATH}
          ? $arg_ref->{INCLUDE_PATH}
          : do {
              # ignore uninitialized warnings - File::Spec warns about
              # uninitialized values, probably because we have no filename
              local $SIG{__WARN__} = sub {
                  return if ($_[0]=~m{\buninitialized\b});
                  CORE::warn @_;
              };
  
              # makeup path for the OS we're running on
              my ($volume, $dir, $file) = File::Spec->splitpath(
                  File::Spec->rel2abs( dirname __FILE__  )
              );
              $dir = File::Spec->catdir($dir, $file, 'XSD');
              # return path put together...
              my $path = File::Spec->catpath( $volume, $dir , q{});
  
              # Fixup path for windows - / works fine, \ does
              # not...
              if ( eval { &Win32::BuildNumber } ) {
                  $path =~s{\\}{/}g;
              }
              $path;
          }
      );
  }
  
  # construct object on call to allow late binding of prefix_resolver class
  # and namespace maps (not used yet)
  sub get_name_resolver {
      my $self = shift;
      return SOAP::WSDL::Generator::Template::Plugin::XSD->new({
          prefix_resolver_class => $self->get_prefix_resolver_class(),
          prefix_resolver => $self->get_prefix_resolver_class()->new({
              namespace_prefix_map => {
                  'http://www.w3.org/2001/XMLSchema' => 'SOAP::WSDL::XSD::Typelib::Builtin',
              },
              namespace_map => {
              },
              prefix => {
                  attribute   =>  $self->get_attribute_prefix,
                  interface   =>  $self->get_interface_prefix,
                  element     =>  $self->get_element_prefix,
                  server      =>  $self->get_server_prefix,
                  type        =>  $self->get_type_prefix,
                  typemap     =>  $self->get_typemap_prefix,
              }
          })
      });
  }
  
  sub generate {
      my $self = shift;
      my $opt = shift;
      $self->generate_typelib( $opt );
      $self->generate_typemap( $opt )
          if $self->get_use_typemap();
  }
  
  sub generate_typelib {
      my ($self, $arg_ref) = @_;
      my @schema = exists $arg_ref->{ schema }
          ? @{ $arg_ref->{schema} }
          : @{ $self->get_definitions()->first_types()->get_schema() };
      for my $type (map {
              @{ $_->get_type() } ,
              @{ $_->get_element() },
              @{ $_->get_attribute() }
          } @schema[1..$#schema] ) {
          $type->_accept( $self );
      }
      return;
  }
  
  sub _generate_interface {
      my $self = shift;
      my $arg_ref = shift;
      my $template_name = delete $arg_ref->{ template_name };
      my $name_method = delete $arg_ref->{ name_method };
      for my $service (@{ $self->get_definitions->get_service }) {
          for my $port (@{ $service->get_port() }) {
              # Skip ports without (known) address
              next if not $port->first_address;
              next if not $port->first_address->isa('SOAP::WSDL::SOAP::Address');
  
              my $port_name = $port->get_name;
              $port_name =~s{ \A .+\. }{}xms;
              my $output = $arg_ref->{ output }
                  ? $arg_ref->{ output }
                  : $self->_generate_filename(
                      $self->get_name_resolver()->can($name_method)->(
                          $self->get_name_resolver(),
                          $service,
                          $port,
                  ));
              print "Creating interface class $output\n"
                  if not $silent_of{ident $self};
  
              $self->_process($template_name,
              {
                  service     => $service,
                  port        => $port,
                  NO_POD      => $arg_ref->{ NO_POD } ? 1 : 0 ,
                  USE_TYPEMAP => $self->get_use_typemap(),
               },
              $output, binmode => ':utf8');
          }
      }
  }
  
  sub generate_server {
      my ($self, $arg_ref) = @_;
      $arg_ref->{ template_name } = 'Server.tt';
      $arg_ref->{ name_method } = 'create_server_name';
      $self->_generate_interface($arg_ref);
  }
  
  sub generate_client {
      my ($self, $arg_ref) = @_;
      $arg_ref->{ template_name } = 'Interface.tt';
      $arg_ref->{ name_method } = 'create_interface_name';
      $self->_generate_interface($arg_ref);
  }
  sub generate_interface;
  *generate_interface = \&generate_client;
  
  sub generate_typemap {
      my ($self, $arg_ref) = @_;
  
      my $visitor = SOAP::WSDL::Generator::Visitor::Typemap->new({
          type_prefix => $self->get_type_prefix(),
          element_prefix => $self->get_element_prefix(),
          definitions => $self->get_definitions(),
          typemap => {
              'Fault' => 'SOAP::WSDL::SOAP::Typelib::Fault11',
              'Fault/faultcode' => 'SOAP::WSDL::XSD::Typelib::Builtin::anyURI',
              'Fault/faultactor' => 'SOAP::WSDL::XSD::Typelib::Builtin::token',
              'Fault/faultstring' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
              'Fault/detail' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
              %{ $typemap_of{ident $self }},
          },
          resolver => $self->get_name_resolver(),
      });
  
      use SOAP::WSDL::Generator::Iterator::WSDL11;
      my $iterator  = SOAP::WSDL::Generator::Iterator::WSDL11->new({
          definitions => $self->get_definitions });
  
      for my $service (@{ $self->get_definitions->get_service }) {
              $iterator->init({ node => $service });
              while (my $node = $iterator->get_next()) {
                  $node->_accept( $visitor );
              }
  
              my $output = $arg_ref->{ output }
                  ? $arg_ref->{ output }
                  : $self->_generate_filename( $self->get_name_resolver()->create_typemap_name($service) );
              print "Creating typemap class $output\n"
                  if not $silent_of{ident $self};
              $self->_process('Typemap.tt',
              {
                  service => $service,
                  typemap => $visitor->get_typemap(),
                  NO_POD => $arg_ref->{ NO_POD } ? 1 : 0 ,
              },
              $output);
      }
  }
  
  sub _generate_filename :PRIVATE {
      my ($self, $name) = @_;
      $name =~s{ \. }{::}xmsg;
      $name =~s{ \- }{_}xmsg;
      $name =~s{ :: }{/}xmsg;
      return "$name.pm";
  }
  
  sub visit_XSD_Attribute {
      my ($self, $attribute) = @_;
      my $output = defined $output_of{ ident $self }
          ? $output_of{ ident $self }
          : $self->_generate_filename( $self->get_name_resolver()->create_xsd_name($attribute) );
      $self->_process('attribute.tt', { attribute => $attribute } , $output);
  }
  
  sub visit_XSD_Element {
      my ($self, $element) = @_;
      my $output = defined $output_of{ ident $self }
          ? $output_of{ ident $self }
          : $self->_generate_filename( $self->get_name_resolver()->create_xsd_name($element) );
      warn "Creating element class $output \n"
          if not $silent_of{ ident $self};
      $self->_process('element.tt', { element => $element } , $output);
  }
  
  sub visit_XSD_SimpleType {
      my ($self, $type) = @_;
      my $output = defined $output_of{ ident $self }
          ? $output_of{ ident $self }
          : $self->_generate_filename( $self->get_name_resolver()->create_xsd_name($type) );
      warn "Creating simpleType class $output \n"
          if not $silent_of{ ident $self};
      $self->_process('simpleType.tt', { simpleType => $type } , $output);
  }
  
  sub visit_XSD_ComplexType {
      my ($self, $type) = @_;
      my $output = defined $output_of{ ident $self }
          ? $output_of{ ident $self }
          : $self->_generate_filename( $self->get_name_resolver()->create_xsd_name($type) );
      warn "Creating complexType class $output \n"
          if not $silent_of{ ident $self};
      $self->_process('complexType.tt', { complexType => $type } , $output);
  }
  
  1;
  
  =pod
  
  =head1 NAME
  
  SOAP::WSDL::Generator::Template::XSD - XSD code generator
  
  =head1 DESCRIPTION
  
  SOAP::WSDL's XSD code generator
  
  =head1 SYNOPSIS
  
  See L<wsdl2perl.pl|wsdl2perl.pl> for an example on how to use this class.
  
  =head1 METHODS
  
  =head2 new
  
  Constructor.
  
  Options (Options can also be set via set_OPTION methods):
  
  =over
  
  =item * silent
  
  Suppress warnings about what's being generated
  
  =back
  
  =head2 generate
  
  Shortcut for calling L<generate_typelib> and L<generate_client>
  
  =head2 generate_client
  
  Generates a client interface
  
  =head2 generate_server
  
  Generates a server class
  
  =head2 generate_typelib
  
  Generates type and element classes
  
  =head2 generate_typemap
  
  Generate a typemap class required by SOAP::WSDL's MessageParser
  
  =head2 generate_interface
  
  (Deprecated) alias for generate_client
  
  =head2 get_name_resolver
  
  Returns a name resolver template plugin
  
  =head2 visit_XSD_Attribute
  
  Visitor method for SOAP::WSDL::XSD::Attribute. Should be factored out into
  visitor class.
  
  =head2 visit_XSD_ComplexType
  
  Visitor method for SOAP::WSDL::XSD::ComplexType. Should be factored out into
  visitor class.
  
  =head2 visit_XSD_Element
  
  Visitor method for SOAP::WSDL::XSD::Element. Should be factored out into
  visitor class.
  
  =head2 visit_XSD_SimpleType
  
  Visitor method for SOAP::WSDL::XSD::SimpleType. Should be factored out into
  visitor class.
  
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
  
SOAP_WSDL_GENERATOR_TEMPLATE_XSD

$fatpacked{"SOAP/WSDL/Generator/Visitor.pm"} = <<'SOAP_WSDL_GENERATOR_VISITOR';
  package
    SOAP::WSDL::Generator::Visitor;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable;
  
  use version; our $VERSION = qv('2.00.99_3');
  
  my %definitions_of :ATTR(:name<definitions> :default<()>);
  my %type_prefix_of :ATTR(:name<type_prefix> :default<()>);
  my %element_prefix_of :ATTR(:name<element_prefix> :default<()>);
  
  sub START {
      my ($self, $ident, $arg_ref) = @_;
      $type_prefix_of{ $ident } = 'MyType' if not exists
          $arg_ref->{ 'type_prefix' };
      $element_prefix_of{ $ident } = 'MyElement' if not exists
          $arg_ref->{ 'element_prefix' };
  
  }
  
  
  # WSDL stuff
  sub visit_Definitions {}
  sub visit_Binding {}
  sub visit_Message {}
  sub visit_Operation {}
  sub visit_OpMessage {}
  sub visit_Part {}
  sub visit_Port {}
  sub visit_PortType {}
  sub visit_Service {}
  sub visit_SoapOperation {}
  sub visit_Types {}
  
  # XML Schema stuff
  sub visit_XSD_Schema {}
  sub visit_XSD_ComplexType {}
  sub visit_XSD_Element {}
  sub visit_XSD_SimpleType {}
  
  1;
  
  __END__
  

SOAP_WSDL_GENERATOR_VISITOR

$fatpacked{"SOAP/WSDL/Generator/Visitor/Typemap.pm"} = <<'SOAP_WSDL_GENERATOR_VISITOR_TYPEMAP';
  package
    SOAP::WSDL::Generator::Visitor::Typemap;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable;
  
  use base qw(SOAP::WSDL::Generator::Visitor);
  
  use version; our $VERSION = qv('2.00.99_3');
  
  my %path_of             :ATTR(:name<path>           :default<[]>);
  my %typemap_of          :ATTR(:name<typemap>        :default<()>);
  my %resolver_of         :ATTR(:name<resolver>       :default<()>);
  
  sub START {
      my ($self, $ident, $arg_ref) = @_;
      $resolver_of { $ident } = $arg_ref->{ resolver };
  }
  
  sub set_typemap_entry {
      my ($self, $value) = @_;
      # warn join( q{/}, @{ $path_of{ ident $self } }) . " => $value";
      $typemap_of{ ident $self }->{
          join( q{/}, @{ $path_of{ ident $self } } )
      } = $value;
  }
  
  sub add_element_path {
      my ($self, $element) = @_;
  
      # Swapping out this lines against the ones below generates
      # a namespace-sensitive typemap.
      # Well almost: Class names are not constructed in a namespace-sensitive
      # manner, yet - there should be some facility to allow binding a (perl)
      # prefix to a namespace...
  
      if (my $ref = $element->get_ref() ) {
          $element = $self->get_definitions()->first_types()->find_element(
              $element->expand($ref) );
      }
      my $name = $element->get_name();
  
      push @{ $path_of{ ident $self } }, $name;
  }
  
  sub process_referenced_type {
      my ( $self, $ns, $localname ) = @_;
  
      my $ident = ident $self;
  
      # get type's class name
      # Caveat: visits type if it's a referenced type from the
      # a ? b : c operation.
      my ($type, $typeclass);
      $type = $self->get_definitions()->first_types()->find_type( $ns, $localname );
      $typeclass = $self->get_resolver()->create_xsd_name($type);
  
      # set before to allow it to be used from inside _accept
      $self->set_typemap_entry($typeclass);
  
      $type->_accept($self) if ($ns ne 'http://www.w3.org/2001/XMLSchema');
  
      # set afterwards again (just to be sure...)
      $self->set_typemap_entry($typeclass);
      return $self;
  }
  
  sub visit_XSD_Element {
      my ( $self, $ident, $element ) = ( $_[0], ident $_[0], $_[1] );
  
      # warn "simpleType " . $element->get_name();
      my @path = @{ $path_of{ ${ $self } } };
      my $path = join '/', @path;
      my $parent = $typemap_of{ ${ $self } }->{ $path };
  
      # step down in tree
      $self->add_element_path( $element );
  
      # now call all possible variants.
      # They all just return if no argument is given,
      # and return $self on success.
      SWITCH: {
          my $name = $element->get_name();
  
          if ($element->get_type) {
              $self->process_referenced_type( $element->expand( $element->get_type() ) );
              last SWITCH;
          }
  
          # atomic simpleType typemap rule:
          # if we have a parent, use parent's sub-package.
          # if not, use element package.
          if ($element->get_simpleType()) {
              # warn "simpleType " . $element->get_name();
              my @path = @{ $path_of{ ${ $self } } };
              my $typeclass = $self->get_resolver()->create_subpackage_name($element);
              $self->set_typemap_entry($typeclass);
              $typeclass =~s{\.}{::}g;
              $typeclass =~s{\-}{_}g;
              last SWITCH;
          }
  
          # for atomic and complex types , and ref elements
          my $typeclass = $self->get_resolver()->create_subpackage_name($element);
          $self->set_typemap_entry($typeclass);
  
          if (my $complexType = $element->first_complexType()) {
              $complexType->_accept($self);
              last SWITCH;
          }
  
          # element ref handling
          if (my $ref = $element->get_ref()) {
              $element = $self->get_definitions()->first_types()->find_element(
                  $element->expand($ref) );
              # we added a path too much - we should add the path of this
              # element instead.
              pop @{ $path_of{$ident} };
              $element->_accept($self);
              # and we must not pop it off now - thus, just return
              return;
          }
          die "Neither type nor ref in element >". $element->get_name ."<. Don't know what to do."
      };
  
      # Safety measure. If someone defines a top-level element with
      # a normal (not atomic) type, we just override it here
      if (not defined($parent)) {
          # for atomic and complex types , and ref elements
          my $typeclass = $self->get_resolver()->create_xsd_name($element);
          $self->set_typemap_entry($typeclass);
      }
  
      # step up in hierarchy
      pop @{ $path_of{$ident} };
  }
  
  sub visit_XSD_ComplexType {
      my ($self, $ident, $type) = ($_[0], ident $_[0], $_[1] );
      my $variety = $type->get_variety();
      my $derivation = $type->get_derivation();
      my $content_model = $type->get_contentModel;
      return if not $variety; # empty complexType
      return if ($content_model eq 'simpleContent');
  
      if ( grep { $_ eq $variety} qw(all sequence choice) )
      {
          # visit child elements
          for (@{ $type->get_element() || [] }) {
              $_->_accept( $self );
          }
      }
      # Only continue for derived types
      # Saves a uninitialized warning.
      return if not $derivation;
  
      if ($derivation eq 'restriction' ) {
          # TODO check and probably correct - this includes
          # all base type's elements in a restriction derivation.
          # Probably wrong.
          #
          # resolve base / get atomic type and run on elements
          if (my $type_name = $type->get_base()) {
              my $subtype = $self->get_definitions()
                  ->first_types()->find_type( $type->expand($type_name) );
              # visit child elements
              for (@{ $subtype->get_element() || [] }) {
                  $_->_accept( $self );
              }
          }
      }
      elsif ($derivation eq 'extension' ) {
          # resolve base / get atomic type and run on elements
          while (my $type_name = $type->get_base()) {
              $type = $self->get_definitions()
                  ->first_types()->find_type( $type->expand($type_name) );
              # visit child elements
              for (@{ $type->get_element() || [] }) {
                  $_->_accept( $self );
              }
          }
      }
  }
  
  1;
  
  __END__
  
  =pod
  
  =head1 NAME
  
  SOAP::WSDL::Generator::Visitor::Typemap - Visitor class for generating typemaps
  
  =head1 DESCRIPTION
  
  Visitor used by SOAP::WSDL's XSD generator for creating typemaps
  
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
  
SOAP_WSDL_GENERATOR_VISITOR_TYPEMAP

$fatpacked{"SOAP/WSDL/Message.pm"} = <<'SOAP_WSDL_MESSAGE';
  package
    SOAP::WSDL::Message;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable;
  use base qw(SOAP::WSDL::Base);
  
  use version; our $VERSION = qv('2.00.99_3');
  
  my %part_of :ATTR(:name<part> :default<[]>);
  
  1;
SOAP_WSDL_MESSAGE

$fatpacked{"SOAP/WSDL/OpMessage.pm"} = <<'SOAP_WSDL_OPMESSAGE';
  package
    SOAP::WSDL::OpMessage;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable;
  use base qw(SOAP::WSDL::Base);
  
  use version; our $VERSION = qv('2.00.99_3');
  
  my %body_of         :ATTR(:name<body>           :default<[]>);
  my %header_of       :ATTR(:name<header>         :default<[]>);
  my %headerfault_of  :ATTR(:name<headerfault>    :default<[]>);
  my %message_of      :ATTR(:name<message>        :default<()>);
  
  1;
SOAP_WSDL_OPMESSAGE

$fatpacked{"SOAP/WSDL/Operation.pm"} = <<'SOAP_WSDL_OPERATION';
  package
    SOAP::WSDL::Operation;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable;
  use base qw(SOAP::WSDL::Base);
  
  use version; our $VERSION = qv('2.00.99_3');
  
  my %operation_of :ATTR(:name<operation> :default<()>);
  my %input_of :ATTR(:name<input> :default<[]>);
  my %output_of :ATTR(:name<output> :default<[]>);
  my %fault_of :ATTR(:name<fault> :default<[]>);
  my %type_of :ATTR(:name<type> :default<()>);
  my %style_of :ATTR(:name<style> :default<()>);
  my %transport_of :ATTR(:name<transport> :default<()>);
  my %parameterOrder_of :ATTR(:name<parameterOrder> :default<()>);
  
  1;
SOAP_WSDL_OPERATION

$fatpacked{"SOAP/WSDL/Part.pm"} = <<'SOAP_WSDL_PART';
  package
    SOAP::WSDL::Part;
  use strict;
  use warnings;
  use Carp qw(croak);
  use Class::Std::Fast::Storable;
  
  use base qw(SOAP::WSDL::Base);
  
  use version; our $VERSION = qv('2.00.99_3');
  
  my %element_of  :ATTR(:name<element>    :default<()>);
  my %type_of     :ATTR(:name<type>       :default<()>);
  
  sub serialize
  {
      my $self = shift;
      my $name = shift;
      my $data = shift;
      my $opt = shift;
      my $typelib = $opt->{ typelib } || die "No typelib";
      my %ns_map = %{ $opt->{ namespace } };
  
      my $item_name;
      if ($item_name = $self->get_type() ) {
          # resolve type
          my ($prefix, $localname) = split /:/ , $item_name, 2;
          my $type = $typelib->find_type( $ns_map{ $prefix }, $localname)
            or die "type $item_name , $ns_map{ $prefix } not found";
  
          my $name = $self->get_name();
          return $type->serialize( $name, $data->{ $name }, $opt );
      }
      elsif ( $item_name = $self->get_element() ) {
          my ($prefix, $localname) = split /:/ , $item_name, 2;
          my $element = $typelib->find_element(
              $ns_map{ $prefix },
              $localname
          )
              or die "element $item_name , $ns_map{ $prefix } not found";
          $opt->{ qualify } = 1;
          return $element->serialize( undef, $data->{ $element->get_name() }, $opt );
      }
      die "Neither type nor element - don't know what to do";
  }
  
  1;
SOAP_WSDL_PART

$fatpacked{"SOAP/WSDL/Port.pm"} = <<'SOAP_WSDL_PORT';
  package
    SOAP::WSDL::Port;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable;
  use base qw(SOAP::WSDL::Base);
  
  use version; our $VERSION = qv('2.00.99_3');
  
  my %binding_of :ATTR(:name<binding> :default<()>);
  my %address_of :ATTR(:name<address> :default<()>);
  
  1;
SOAP_WSDL_PORT

$fatpacked{"SOAP/WSDL/PortType.pm"} = <<'SOAP_WSDL_PORTTYPE';
  package
    SOAP::WSDL::PortType;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable;
  use List::Util;
  use base qw(SOAP::WSDL::Base);
  
  use version; our $VERSION = qv('2.00.99_3');
  
  my %operation_of :ATTR(:name<operation> :default<()>);
  
  #
  #=head2 find_operation
  #
  #$port_type->find_operation($namespace, $name)
  #
  #Returns the PortType's operation object matching the given namespace and
  #name
  #
  
  sub find_operation {
      return List::Util::first {
          ( $_->get_targetNamespace() eq $_[1] ) && ( $_->get_name() eq $_[2] )
      } @{ $operation_of{ ${ $_[0] } } };
  };
  
  1;
SOAP_WSDL_PORTTYPE

$fatpacked{"SOAP/WSDL/SOAP/Address.pm"} = <<'SOAP_WSDL_SOAP_ADDRESS';
  package
    SOAP::WSDL::SOAP::Address;
  use strict;
  use warnings;
  use base qw(SOAP::WSDL::Base);
  use Class::Std::Fast::Storable;
  
  use version; our $VERSION = qv('2.00.99_3');
  
  my %location   :ATTR(:name<location> :default<()>);
  1;
SOAP_WSDL_SOAP_ADDRESS

$fatpacked{"SOAP/WSDL/SOAP/Body.pm"} = <<'SOAP_WSDL_SOAP_BODY';
  package
    SOAP::WSDL::SOAP::Body;
  use strict;
  use warnings;
  use base qw(SOAP::WSDL::Base);
  use Class::Std::Fast::Storable;
  
  use version; our $VERSION = qv('2.00.99_3');
  
  my %use_of              :ATTR(:name<use>            :default<q{}>);
  my %namespace_of        :ATTR(:name<namespace>      :default<q{}>);
  my %encodingStyle_of    :ATTR(:name<encodingStyle>  :default<q{}>);
  my %parts_of            :ATTR(:name<parts>          :default<q{}>);
  
  1;
SOAP_WSDL_SOAP_BODY

$fatpacked{"SOAP/WSDL/SOAP/Header.pm"} = <<'SOAP_WSDL_SOAP_HEADER';
  package
    SOAP::WSDL::SOAP::Header;
  use strict;
  use warnings;
  use base qw(SOAP::WSDL::Base);
  use Class::Std::Fast::Storable;
  
  use version; our $VERSION = qv('2.00.99_3');
  
  my %use_of              :ATTR(:name<use>            :default<q{}>);
  my %namespace_of        :ATTR(:name<namespace>      :default<q{}>);
  my %encodingStyle_of    :ATTR(:name<encodingStyle>  :default<q{}>);
  my %message_of          :ATTR(:name<message>        :default<()>);
  my %part_of             :ATTR(:name<part>          :default<q{}>);
  
  
  1;
SOAP_WSDL_SOAP_HEADER

$fatpacked{"SOAP/WSDL/SOAP/HeaderFault.pm"} = <<'SOAP_WSDL_SOAP_HEADERFAULT';
  package
    SOAP::WSDL::SOAP::HeaderFault;
  use strict;
  use warnings;
  use base qw(SOAP::WSDL::Header);
  
  use version; our $VERSION = qv('2.00.99_3');
  
  1;
SOAP_WSDL_SOAP_HEADERFAULT

$fatpacked{"SOAP/WSDL/SOAP/Operation.pm"} = <<'SOAP_WSDL_SOAP_OPERATION';
  package
    SOAP::WSDL::SOAP::Operation;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable;
  use base qw(SOAP::WSDL::Base);
  
  use version; our $VERSION = qv('2.00.99_3');
  
  my %style_of :ATTR(:name<style> :default<()>);
  my %soapAction_of :ATTR(:name<soapAction> :default<()>);
  
  1;
SOAP_WSDL_SOAP_OPERATION

$fatpacked{"SOAP/WSDL/SOAP/Typelib/Fault.pm"} = <<'SOAP_WSDL_SOAP_TYPELIB_FAULT';
  package
    SOAP::WSDL::SOAP::Typelib::Fault;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'none';
  
  use version; our $VERSION = qv('2.00.99_3');
  
  1;
SOAP_WSDL_SOAP_TYPELIB_FAULT

$fatpacked{"SOAP/WSDL/SOAP/Typelib/Fault11.pm"} = <<'SOAP_WSDL_SOAP_TYPELIB_FAULT11';
  package
    SOAP::WSDL::SOAP::Typelib::Fault11;
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
  
  package
    SOAP::WSDL::SOAP::Typelib::Fault11Detail;
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
  
SOAP_WSDL_SOAP_TYPELIB_FAULT11

$fatpacked{"SOAP/WSDL/Serializer/XSD.pm"} = <<'SOAP_WSDL_SERIALIZER_XSD';
  #!/usr/bin/perl -w
  package
    SOAP::WSDL::Serializer::XSD;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable;
  use Scalar::Util qw(blessed);
  
  use version; our $VERSION = qv('2.00.99_3');
  
  use SOAP::WSDL::Factory::Serializer;
  
  my $SOAP_NS = 'http://schemas.xmlsoap.org/soap/envelope/';
  my $XML_INSTANCE_NS = 'http://www.w3.org/2001/XMLSchema-instance';
  my $XML_SCHEMA_NS = 'http://www.w3.org/2001/XMLSchema';
  
  sub serialize {
      my ($self, $args_of_ref) = @_;
  
      my $opt = $args_of_ref->{ options };
  
      if (not $opt->{ namespace }->{ $SOAP_NS })
      {
          $opt->{ namespace }->{ $SOAP_NS } = 'SOAP-ENV';
      }
  
      if (not $opt->{ namespace }->{ $XML_INSTANCE_NS })
      {
          $opt->{ namespace }->{ $XML_INSTANCE_NS } = 'xsi';
      }
  
      if (not $opt->{ namespace }->{ $XML_SCHEMA_NS })
      {
          $opt->{ namespace }->{ $XML_SCHEMA_NS } = 'xs';
      }
      my $soap_prefix = $opt->{ namespace }->{ $SOAP_NS };
  
      # envelope start with namespaces
      my $xml = "<$soap_prefix\:Envelope ";
  
      while (my ($uri, $prefix) = each %{ $opt->{ namespace } })
      {
          $xml .= "xmlns:$prefix=\"$uri\" ";
      }
      #
      # add namespace for user-supplied prefix if needed
      $xml .= "xmlns:$opt->{prefix}=\"" . $args_of_ref->{ body }->get_xmlns() . "\" "
          if $opt->{prefix};
  
      # TODO insert encoding
      $xml.='>';
      $xml .= $self->serialize_header($args_of_ref->{ method }, $args_of_ref->{ header }, $opt);
      $xml .= $self->serialize_body($args_of_ref->{ method }, $args_of_ref->{ body }, $opt);
      $xml .= '</' . $soap_prefix .':Envelope>';
      return $xml;
  }
  
  sub serialize_header {
      my ($self, $method, $data, $opt) = @_;
  
      # header is optional. Leave out if there's no header data
      return q{} if not $data;
      return join ( q{},
          "<$opt->{ namespace }->{ $SOAP_NS }\:Header>",
          blessed $data ? $data->serialize_qualified : (),
          "</$opt->{ namespace }->{ $SOAP_NS }\:Header>",
      );
  }
  
  sub serialize_body {
      my ($self, $method, $data, $opt) = @_;
  
      # TODO This one wipes out the old class' XML name globally
      # Fix in some more appropriate place...
      $data->__set_name("$opt->{prefix}:" . $data->__get_name() ) if $opt->{prefix};
  
      # Body is NOT optional. Serialize to empty body
      # if we have no data.
      return join ( q{},
          "<$opt->{ namespace }->{ $SOAP_NS }\:Body>",
          defined $data
              ? ref $data eq 'ARRAY'
                  ? join q{}, map { blessed $_ ? $_->serialize_qualified() : () } @{ $data }
                  : blessed $data
                      ? $opt->{prefix}
                          ? $data->serialize()
                          : $data->serialize_qualified()
                      : ()
              : (),
          "</$opt->{ namespace }->{ $SOAP_NS }\:Body>",
      );
  }
  
  __END__
  
  =pod
  
  =head1 NAME
  
  SOAP:WSDL::Serializer::XSD - Serializer for SOAP::WSDL::XSD::Typelib:: objects
  
  =head1 DESCRIPTION
  
  This is the default serializer for SOAP::WSDL::Client and Interface classes
  generated by SOAP::WSDL
  
  It may be used as a template for creating custom serializers.
  
  See L<SOAP::WSDL::Factory::Serializer|SOAP::WSDL::Factory::Serializer> for
  details on that.
  
  =head1 METHODS
  
  =head2 serialize
  
  Creates a SOAP envelope based on the body and header arguments passed.
  
  Sets SOAP namespaces.
  
  =head2 serialize_body
  
  Serializes a message body to XML
  
  =head2 serialize_header
  
  Serializes a message header to XML
  
  =head1 LICENSE AND COPYRIGHT
  
  Copyright (c) 2007 Martin Kutter. All rights reserved.
  
  This file is part of SOAP-WSDL. You may distribute/modify it under
  the same terms as perl itself
  
  =head1 AUTHOR
  
  Martin Kutter E<lt>martin.kutter fen-net.deE<gt>
  
  =head1 REPOSITORY INFORMATION
  
   $Rev: 861 $
   $LastChangedBy: kutterma $
   $Id: XSD.pm 861 2010-03-28 10:41:26Z kutterma $
   $HeadURL: https://soap-wsdl.svn.sourceforge.net/svnroot/soap-wsdl/SOAP-WSDL/branches/Typemap/lib/SOAP/WSDL/Serializer/XSD.pm $
  
  =cut
  
SOAP_WSDL_SERIALIZER_XSD

$fatpacked{"SOAP/WSDL/Server.pm"} = <<'SOAP_WSDL_SERVER';
  package
    SOAP::WSDL::Server;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable;
  use Scalar::Util qw(blessed);
  use SOAP::WSDL::Factory::Deserializer;
  use SOAP::WSDL::Factory::Serializer;
  
  use version; our $VERSION = qv('2.00.99_3');
  
  my %dispatch_to_of      :ATTR(:name<dispatch_to>    :default<()>);
  my %action_map_ref_of   :ATTR(:name<action_map_ref> :default<{}>);
  my %method_map_ref_of   :ATTR(:name<method_map_ref> :default<{}>);
  my %class_resolver_of   :ATTR(:name<class_resolver> :default<()>);
  my %deserializer_of     :ATTR(:name<deserializer>   :default<()>);
  my %serializer_of       :ATTR(:name<serializer>     :default<()>);
  my %soap_version_of     :ATTR(:name<soap_veraion>   :default<1.1>);
  
  sub handle {
      my $self    = shift;
      my $request = shift; # this involves copying the request... once
      my $ident   = ident $self;
  
  
      # we only support 1.1 now...
      $deserializer_of{ $ident } ||= SOAP::WSDL::Factory::Deserializer->get_deserializer({
          soap_version => $soap_version_of{ $ident },
      });
      $serializer_of{ $ident } ||= SOAP::WSDL::Factory::Serializer->get_serializer({
          soap_version => $soap_version_of{ $ident },
      });
  
      # lookup method name by SOAPAction
      # TODO: factor out dispatcher logic into dispatcher factory + dispatcher
      # classes
      #    $dispatcher_of{ $ident } ||= SOAP::WSDL::Factory::Dispatcher->get_dispatcher({});
  
      my $soap_action = $request->header('SOAPAction');
      $soap_action = '' if ! defined $soap_action;
      $soap_action =~s{ \A(?:"|')(.+)(?:"|') \z }{$1}xms;
      my $method_name = $action_map_ref_of{ $ident }->{ $soap_action };
  
      if ( ! $dispatch_to_of{ $ident } ) {
          die $deserializer_of{ $ident }->generate_fault({
                  code => 'SOAP-ENV:Server',
                  role => 'urn:localhost',
                  message => "No handler registered",
              });
      };
  
      if ( ! defined $request->header('SOAPAction') ) {
          die $deserializer_of{ $ident }->generate_fault({
                  code => 'SOAP-ENV:Server',
                  role => 'urn:localhost',
                  message => "Not found: No SOAPAction given",
              });
      };
  
      if ( ! defined $method_name) {
          die $deserializer_of{ $ident }->generate_fault({
                  code => 'SOAP-ENV:Server',
                  role => 'urn:localhost',
                  message => "Not found: No method found for the SOAPAction '$soap_action'",
              });
      };
  
      # initialize deserializer from caller
      if ( $method_map_ref_of{$ident} && $deserializer_of{ $ident }->can('init_from_caller') ) {
          $deserializer_of{ $ident }->init_from_caller(
              $self, $method_map_ref_of{ $ident }->{ $method_name }
          );
      }
      else {
          # for compatibility only
          $deserializer_of{ $ident }->set_class_resolver( $class_resolver_of{ $ident } )
              if ( $deserializer_of{ $ident }->can('set_class_resolver') );
  
          $deserializer_of{ $ident }->set_body_parts(
              $method_map_ref_of{ $ident }->{ $method_name }->{ body }->{ parts }
          ) if ( $deserializer_of{ $ident }->can('set_body_parts') );
  
          $deserializer_of{ $ident }->set_header_parts(
              $method_map_ref_of{ $ident }->{ $method_name }->{ header }->{ parts }
          ) if ( $deserializer_of{ $ident }->can('set_header_parts') );
      }
  
      # Try deserializing response
      my ($body, $header) = eval {
         $deserializer_of{ $ident }->deserialize( $request->content() );
      };
      if ($@) {
          die $deserializer_of{ $ident }->generate_fault({
                  code => 'soap:Server',
                  role => 'urn:localhost',
                  message => "Error deserializing message: $@. \n"
              });
      };
      if ( blessed($body) && $body->isa('SOAP::WSDL::SOAP::Typelib::Fault11') ) {
          die $body;
      }
  
  #    $dispatcher_of{ $ident }->dispatch({
  #        soap_action => $soap_action,
  #        request_body => $body,
  #        request_header => $header,
  #    });
  
      # find method in handling class/object
      my $method_ref = $dispatch_to_of{ $ident }->can($method_name);
  
      if ( ! $method_ref) {
          die $deserializer_of{ $ident }->generate_fault({
                  code => 'SOAP-ENV:Server',
                  role => 'urn:localhost',
                  message => "Not implemented: The handler does not implement the method $method_name",
              });
      };
  
      my ($response_body, $response_header) = $method_ref->($dispatch_to_of{ $ident }, $body, $header );
  
      return $serializer_of{ $ident }->serialize({
          body   => $response_body,
          header => $response_header,
      });
  }
  
  1;
  
  =pod
  
  =head1 NAME
  
  SOAP::WSDL::Server - WSDL based SOAP server base class
  
  =head1 SYNOPSIS
  
  Don't use directly, use the SOAP::WSDL::Server::* subclasses
  instead.
  
  =head1 DESCRIPTION
  
  SOAP::WSDL::Server basically follows the architecture sketched below
  (though dispatcher classes are not implemented yet)
  
   SOAP Request           SOAP Response
         |                     ^
         V                     |
    ------------------------------------------
   |       SOAP::WSDL::Server                 |
   |  --------------------------------------  |
   | | Transport Class                      | |
   | |--------------------------------------| |
   | | Deserializer       | Serializer      | |
   | |--------------------------------------| |
   | | Dispatcher                           | |
   |  --------------------------------------  |
    ------------------------------------------
        | calls                 ^
        v                       | returns
     -------------------------------------
    |   Handler                           |
     -------------------------------------
  
  All of the components (Transport class, deserializer, dispatcher and
  serializer) are implemented as plugins.
  
  The architecture is not implemented as planned yet, but the dispatcher is
  currently part of SOAP::WSDL::Server, which aggregates serializer and
  deserializer, and is subclassed by transport classes (of which
  SOAP::WSDL::Server::CGI is the only implemented one yet).
  
  The dispatcher is currently based on the SOAPAction header. This does not
  comply to the WS-I basic profile, which declares the SOAPAction as optional.
  
  The final dispatcher will be based on wire signatures (i.e. the classes
  of the deserialized messages).
  
  A hash-based dispatcher could be implemented by examining the top level
  hash keys.
  
  =head1 EXCEPTION HANDLING
  
  =head2 Builtin exceptions
  
  SOAP::WSDL::Server handles the following errors itself:
  
  In case of errors, a SOAP Fault containing an appropriate error message
  is returned.
  
  =over
  
  =item * XML parsing errors
  
  =item * Configuration errors
  
  =back
  
  =head2 Throwing exceptions
  
  The proper way to throw a exception is just to die -
  SOAP::WSDL::Server::CGI catches the exception and sends a SOAP Fault
  back to the client.
  
  If you want more control over the SOAP Fault sent to the client, you can
  die with a SOAP::WSDL::SOAP::Fault11 object - or just let the
  SOAP::Server's deserializer create one for you:
  
   my $soap = MyServer::SomeService->new();
  
   die $soap->get_deserializer()->generate_fault({
      code => 'SOAP-ENV:Server',
      role => 'urn:localhost',
      message => "The error message to pas back",
      detail => "Some details on the error",
   });
  
  You may use any other object as exception, provided it has a
  serialize() method which returns the object's XML representation.
  
  =head2 Subclassing
  
  To write a transport-specific SOAP Server, you should subclass
  SOAP::WSDL::Server.
  
  See the C<SOAP::WSDL::Server::*> modules for examples.
  
  A SOAP Server must call the following method to actually handle the request:
  
  =head3 handle
  
  Handles the SOAP request.
  
  Returns the response message as XML.
  
  Expects a C<HTTP::Request> object as only parameter.
  
  You may use any other object as parameter, as long as it implements the
  following methods:
  
  =over
  
  =item * header
  
  Called as header('SOAPAction'). Must return the corresponding HTTP header.
  
  =item * content
  
  Returns the request message
  
  =back
  
  =head1 LICENSE AND COPYRIGHT
  
  Copyright 2004-2008 Martin Kutter.
  
  This file is part of SOAP-WSDL. You may distribute/modify it under the same
  terms as perl itself
  
  =head1 AUTHOR
  
  Martin Kutter E<lt>martin.kutter fen-net.deE<gt>
  
  =head1 REPOSITORY INFORMATION
  
   $Rev: 391 $
   $LastChangedBy: kutterma $
   $Id: Client.pm 391 2007-11-17 21:56:13Z kutterma $
   $HeadURL: https://soap-wsdl.svn.sourceforge.net/svnroot/soap-wsdl/SOAP-WSDL/trunk/lib/SOAP/WSDL/Client.pm $
  
  =cut
SOAP_WSDL_SERVER

$fatpacked{"SOAP/WSDL/Server/CGI.pm"} = <<'SOAP_WSDL_SERVER_CGI';
  package
    SOAP::WSDL::Server::CGI;
  use strict;
  use warnings;
  use Encode;
  use Encode;
  
  use HTTP::Request;
  use HTTP::Response;
  use HTTP::Status;
  use HTTP::Headers;
  use Scalar::Util qw(blessed);
  
  use Class::Std::Fast::Storable;
  
  use base qw(SOAP::WSDL::Server);
  
  use version; our $VERSION = qv('2.00.99_3');
  
  # mostly copied from SOAP::Lite. Unfortunately we can't use SOAP::Lite's CGI
  # server directly - we would have to swap out it's base class...
  #
  # This should be a warning for us: We should not handle methods via inheritance,
  # but via some plugin mechanism, to allow alternative handlers to be plugged
  # in.
  
  sub handle {
      my $self = shift;
      my $response;
      my $length = $ENV{'CONTENT_LENGTH'} || 0;
  
      if (!$length) {
          $response = HTTP::Response->new(411); # LENGTH REQUIRED
          $self->_output($response);
          return;
      }
  
      if (exists $ENV{EXPECT} && $ENV{EXPECT} =~ /\b100-Continue\b/i) {
          print "HTTP/1.1 100 Continue\r\n\r\n";
      }
  
      my $content = q{};
      my $buffer;
  
      # do we need to use bytes; here ?
      binmode(STDIN);
      while (read(STDIN,$buffer,$length - length($content))) {
          $content .= $buffer;
      }
  
      my $request = HTTP::Request->new(
          $ENV{'REQUEST_METHOD'} || '' => $ENV{'SCRIPT_NAME'},
          HTTP::Headers->new(
              map {
                      (/^HTTP_(.+)/i
                          ? ($1=~m/SOAPACTION/)
                              ?('SOAPAction')
                              :($1)
                          : $_
                       ) => $ENV{$_}
              } keys %ENV),
          $content,
      );
  
      # we copy the response message around here.
      # Passing by reference would be much better...
      my $response_message = eval { $self->SUPER::handle($request) };
      # caveat: SOAP::WSDL::SOAP::Typelib::Fault11 is false in bool context...
      if ($@ || blessed $@) {
          my $exception = $@;
          $response = HTTP::Response->new(500);
          $response->header('Content-type' => 'text/xml; charset="utf-8"');
          if (blessed($exception)) {
              $response->content( $self->get_serializer->serialize({
                      body => $exception
                  })
              );
          }
          else {
              $response->content($exception);
          }
      }
      else {
          $response = HTTP::Response->new(200);
          $response->header('Content-type' => 'text/xml; charset="utf-8"');
          $response->content( encode('utf8', $response_message ) );
          {
              use bytes;
              $response->header('Content-length', length $response_message);
          }
      }
  
      $self->_output($response);
      return;
  }
  
  sub _output :PRIVATE {
      my ($self, $response) = @_;
      # imitate nph- cgi for IIS (pointed by Murray Nesbitt)
      my $status = defined($ENV{'SERVER_SOFTWARE'}) && $ENV{'SERVER_SOFTWARE'}=~/IIS/
          ? $ENV{SERVER_PROTOCOL} || 'HTTP/1.0'
          : 'Status:';
  
      my $code = $response->code;
      binmode(STDOUT);
      print STDOUT "$status $code ", HTTP::Status::status_message($code)
          , "\015\012", $response->headers_as_string("\015\012")
          , "\015\012", $response->content;
  }
  
  1;
  
  =pod
  
  =head1 NAME
  
  SOAP::WSDL::Server::CGI - CGI based SOAP server
  
  =head1 SYNOPSIS
  
   use MyServer::TestService::TestPort;
   my $server = MyServer::TestService::TestPort->new({
      dispatch_to => 'main',
      transport_class => 'SOAP::WSDL::Server::CGI',   # optional, default
   });
   $server->handle();
  
  =head1 USAGE
  
  To use SOAP::WSDL::Server::CGI efficiently, you should first create a server
  interface using L<wsdl2perl.pl|wsdl2perl.pl>.
  
  SOAP::WSDL::Server dispatches all calls to appropriately named methods in the
  class or object set via C<dispatch_to>.
  
  See the generated server class on details.
  
  =head1 DESCRIPTION
  
  Lightweight CGI based SOAP server. SOAP::WSDL::Server::CGI does not provide
  the fancier things of CGI handling, like URL parsing, parameter extraction
  or the like, but provides a basic SOAP server using SOAP::WSDL::Server.
  
  =head1 METHODS
  
  =head2 handle
  
  See synopsis above.
  
  =head1 LICENSE AND COPYRIGHT
  
  Copyright 2004-2008 Martin Kutter.
  
  This file is part of SOAP-WSDL. You may distribute/modify it under the same
  terms as perl itself
  
  =head1 AUTHOR
  
  Martin Kutter E<lt>martin.kutter fen-net.deE<gt>
  
  =head1 REPOSITORY INFORMATION
  
   $Rev: 391 $
   $LastChangedBy: kutterma $
   $Id: Client.pm 391 2007-11-17 21:56:13Z kutterma $
   $HeadURL: https://soap-wsdl.svn.sourceforge.net/svnroot/soap-wsdl/SOAP-WSDL/trunk/lib/SOAP/WSDL/Client.pm $
  
  =cut
SOAP_WSDL_SERVER_CGI

$fatpacked{"SOAP/WSDL/Server/Mod_Perl2.pm"} = <<'SOAP_WSDL_SERVER_MOD_PERL2';
  package
    SOAP::WSDL::Server::Mod_Perl2;
  use strict;
  use warnings;
  use base qw(SOAP::WSDL::Server);
  use Scalar::Util qw(blessed);
  
  use HTTP::Request       ();
  use Apache2::RequestIO  (); # $r->read()
  use Apache2::RequestRec (); # $r->headers_in
  use Apache2::RequestUtil(); # $r->dir_config()
  use APR::Table          (); # $r->headers_in->get()
  use Apache2::Log        (); # $r->log
  use Apache2::Const -compile => qw(
                                      OK
                                      SERVER_ERROR
                                      HTTP_LENGTH_REQUIRED
                                  );
  
  use version; our $VERSION = qv('2.00.99_3');
  
  my %LOADED_OF = ();
  
  sub handler {
      my $r       = shift;
      my $rlog    = $r->log();
  
      #
      # Set up section; import requested modules, throwing errors if we're
      # unable to do so. For maximum performance, this should be re-worked
      # to use perl-based Apache directives rather than dir_config(), since
      # the former happens at startup time and the latter at request time.
  
      #
      # dispatch_to
      my $dispatch_to     = $r->dir_config('dispatch_to');
      if (! $dispatch_to) {
          $rlog->error("No 'dispatch_to' variable set in httpd.conf");
          return Apache2::Const::SERVER_ERROR;
      }
  
      if (! exists $LOADED_OF{$dispatch_to}) {
          eval "require $dispatch_to";
          if ($@) {
              $rlog->error("Failed to require [$dispatch_to]: $@");
              return Apache2::Const::SERVER_ERROR;
          }
          $LOADED_OF{$dispatch_to} = undef;
      }
  
      #
      # SOAP service
      my $soap_service_package    = $r->dir_config('soap_service');
      if (! $soap_service_package) {
          $rlog->error("No 'soap_service' variable set in httpd.conf");
          return Apache2::Const::SERVER_ERROR;
      }
  
      if (! exists $LOADED_OF{$soap_service_package}) {
          eval "require $soap_service_package";
          if ($@) {
              $rlog->error("Failed to require [$soap_service_package]: $@");
              return Apache2::Const::SERVER_ERROR;
          }
          $LOADED_OF{$soap_service_package} = undef;
      }
  
      #
      # transport_class (optional)
      my $transport_class = $r->dir_config('transport_class');
      if ($transport_class) {
          eval "require $transport_class";
          if ($@) {
              $rlog->error("Failed to require [$transport_class]: $@");
              return Apache2::Const::SERVER_ERROR;
          }
      }
      else {
          #
          # if no transport class was specified, use this package's handle()
          # method
          $transport_class = __PACKAGE__;
      }
  
      #
      # instantiate SOAP server object
      my $server  = $soap_service_package->new({
              dispatch_to     => $dispatch_to,        # methods
              transport_class => $transport_class,    # handle() call
      });
  
      my $response_msg    = $server->handle($r);
      if ($response_msg =~ /^\d{3}$/) {
          #
          # a 3-digit number is presumed to be an HTTP return status; since
          # we got this and not a SOAP response, it's presumed to be an
          # error; pass it back to the client as-is
          $rlog->error("Dispatcher returned HTTP $response_msg");
          return $response_msg;
      }
  
      if ($response_msg) {
          $r->content_type('text/xml; charset="utf-8"');
          $r->print($response_msg);
          return Apache2::Const::OK;
      }
      else {
          $rlog->error("No response returned from dispatcher");
          return Apache2::Const::SERVER_ERROR;
      }
  }
  
  sub handle {
      my ($self, $r)  = @_;
      my $rlog        = $r->log();
  
      my $length  = $r->headers_in->get('content-length');
      if (! $length) {
          $rlog->error("No content-length provided");
          # TODO maybe throw instead of returning a HTTP code?
          # ... it's an exception, anyway...
          return Apache2::Const::HTTP_LENGTH_REQUIRED;
      }
  
      # read may return less than requested - read until there's no more...
      # TODO: We should note that LimitRequestBody is a must in apache config
      my ($buffer, $read_length);
      my $content = q{};
      while ($read_length = $r->read($buffer, $length)) {
          $content .= $buffer;
      }
  
      if ($length != length $content) {
          $rlog->error("Read length mismatch; read [" . length($content) . "] bytes but received [$length] bytes");
          return Apache2::Const::SERVER_ERROR;
      }
  
      # Shamelessly copied (with mild tweaks) from SOAP::WSDL::Server::CGI
      # ... which was as shamelessly copied from SOAP::Transport::HTTP...
      my $request = HTTP::Request->new(
                      $r->method  => $r->uri,
                      HTTP::Headers->new(
                          SOAPAction => $r->headers_in()->get('SOAPAction'),
                      ),
                      $content,
      );
  
      my $response_message   = eval { $self->SUPER::handle($request) };
  
      # TODO return response if @$ is a SOAP::WSDL::XSD::Typelib::Builtin::anyType object
      if ($@ || blessed($@)) {
          $rlog->error("Failed to handle request: $@");
          return Apache2::Const::SERVER_ERROR;
      }
      else {
          return $response_message;
      }
  }
  
  1;
  
  __END__
  
  =pod
  
  =head1 NAME
  
  SOAP::WSDL::Server::Mod_Perl2 - mod_perl based SOAP server using SOAP::WSDL
  
  =head1 DESCRIPTION
  
  Perl module providing a mod_perl2-based SOAP server using SOAP::WSDL
  
  =head1 CONFIGURATION
  
  Configuration is managed through the use of PerlSetVar directives.
  The following variables are available:
  
  =head2 dispatch_to
  
  Takes as a single argument the package name of the module which contains
  the methods which handle SOAP requests.
  
   PerlSetVar dispatch_to "WebPackage::SOAPMethods"
  
  =head2 soap_service
  
  Takes as a single argument the package name of the Server module
  generated by SOAP::WSDL using
  
   wsdl2perl.pl --server file:///path/to/your/wsdl
  
  By default, the name of the package is MyServer::$SERVICENAME::$PORTTYPE.
  
  EXAMPLE: Given this sample WSDL which wsdl2perl.pl was run against to generate
  perl packages:
  
      <wsdl:portType name="WebServiceSoap">
          [...]
      </wsdl:portType>
  
      [...]
  
      <wsdl:service name="WebService">
          <wsdl:port name="WebServiceSoap" binding="tns:WebServiceSoap">
              <soap:address location="http://www.example.com/WebService"/>
          </wsdl:port>
      </wsdl:service>
  
  The following directive would be correct:
  
      PerlSetVar soap_service "MyServer::WebService::WebServiceSoap"
  
  =head2 transport_class [OPTIONAL]
  
  Takes as a single argument the package name of the perl module containing a
  handle() method used to assemble the HTTP request which will be passed to the
  methods in your L<dispatch_to> module (see above). A default handle() method
  is supplied in this module which should handle most common cases.
  
  handle() is called with the following parameters:
  
   $r - Apache::RequestRec object
  
  =head1 EXAMPLES
  
  The following snippet added to httpd.conf will enable a SOAP server at
  /WebService on your webserver:
  
      <Location /WebService>
          SetHandler perl-script
          PerlResponseHandler SOAP::WSDL::Server::Mod_Perl2
          PerlSetVar dispatch_to "WebPackage::SOAPMethods"
          PerlSetVar soap_service "MyServer::WebService::WebServiceSoap"
      </Location>
  
  =head1 PERFORMANCE
  
  On my machine, a simple SOAP server (the HelloWorld service from the examples)
  needs around 20s to process 300 requests to a CGI script implemented with
  SOAP::WSDL::Server::CGI, around 4.5s to the same CGI with mod_perl enabled,
  and around 3.2s with SOAP::WSDL::Server::Mod_Perl2. All these figures
  include the time for creating the request and parsing the response.
  
  As general advice, using mod_perl is highly recommended in high-performance
  environments. Using SOAP::WSDL::Server::Mod_Perl2 yields an extra 20% speedup
  compared with mod_perl enabled CGI scripts - and it allows one to configure
  SOAP servers in the Apache config.
  
  =head1 THREAD SAFETY
  
  SOAP::WSDL uses Class::Std::Fast, which is not guaranteed to be threadsafe
  yet. Thread safety in Class::Std::Fast is dependent on whether
  
   my $foo = $bar++;
  
  is an atomic operation. I haven't found out yet.
  
  A load test on a single CPU machine with 4 clients using the worker mpm
  did not reveal any threading issues - but that does not mean there are none.
  
  =head1 CREDITS
  
  Contributed (along with lots of other little improvements) by Noah Robin.
  
  Thanks!
  
  =head1 LICENSE AND COPYRIGHT
  
  This file is part of SOAP-WSDL. You may distribute/modify it under
  the same terms as perl itself
  
  =head1 AUTHOR
  
  Noah Robin E<lt>noah.robin gmail.comE<gt>
  
  Based on SOAP::WSDL::Server::CGI, by Martin Kutter E<lt>martin.kutter fen-net.deE<gt>
  
  =head1 REPOSITORY INFORMATION
  
   $Rev: 583 $
   $LastChangedBy: kutterma $
   $Id: $
   $HeadURL: $
  
  =cut
SOAP_WSDL_SERVER_MOD_PERL2

$fatpacked{"SOAP/WSDL/Server/Simple.pm"} = <<'SOAP_WSDL_SERVER_SIMPLE';
  package
    SOAP::WSDL::Server::Simple;
  use strict;
  use warnings;
  
  use Encode;
  
  use HTTP::Request;
  use HTTP::Response;
  use HTTP::Status;
  use HTTP::Headers;
  use Scalar::Util qw(blessed);
  
  use Class::Std::Fast::Storable;
  
  use base qw(SOAP::WSDL::Server);
  
  use version; our $VERSION = qv('2.00.99_3');
  
  # mostly copied from SOAP::Lite. Unfortunately we can't use SOAP::Lite's CGI
  # server directly - we would have to swap out it's base class...
  #
  # This should be a warning for us: We should not handle methods via inheritance,
  # but via some plugin mechanism, to allow alternative handlers to be plugged
  # in.
  
  sub handle {
      my ($self, $cgi) = @_;
  
      my $response;
  
      my $content = $cgi->param('POSTDATA');
  
      my $request = HTTP::Request->new(
          $ENV{'REQUEST_METHOD'} || '' => $ENV{'SCRIPT_NAME'},
          HTTP::Headers->new(
              map {
                      (/^HTTP_(.+)/i
                          ? ($1=~m/SOAPACTION/)
                              ?('SOAPAction')
                              :($1)
                          : $_
                       ) => $ENV{$_}
              } keys %ENV),
          $content,
      );
  
      # we copy the response message around here.
      # Passing by reference would be much better...
      my $response_message = eval { $self->SUPER::handle($request) };
  
      # caveat: SOAP::WSDL::SOAP::Typelib::Fault11 is false in bool context...
      if ($@ || blessed $@) {
          my $exception = $@;
          $response = HTTP::Response->new(500);
          $response->header('Content-type' => 'text/xml; charset="utf-8"');
          if (blessed($exception)) {
              $response->content( $self->get_serializer->serialize({
                      body => $exception
                  })
              );
          }
          else {
              $response->content($exception);
          }
      }
      else {
          $response = HTTP::Response->new(200);
          $response->header('Content-type' => 'text/xml; charset="utf-8"');
          $response->content( encode('utf8', $response_message ) );
          {
              use bytes;
              $response->header('Content-length', length $response_message);
          }
      }
  
      $self->_output($response);
      return;
  }
  
  sub _output :PRIVATE {
      my ($self, $response) = @_;
      my $code = $response->code;
      binmode(STDOUT);
      print STDOUT "HTTP/1.0 $code ", HTTP::Status::status_message($code)
          , "\015\012", $response->headers_as_string("\015\012")
          , "\015\012", $response->content;
  
      warn "HTTP/1.0 $code ", HTTP::Status::status_message($code)
          , "\015\012", $response->headers_as_string("\015\012")
          , $response->content, "\n\n";
  }
  
  1;
  
SOAP_WSDL_SERVER_SIMPLE

$fatpacked{"SOAP/WSDL/Service.pm"} = <<'SOAP_WSDL_SERVICE';
  package
    SOAP::WSDL::Service;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable;
  use base qw(SOAP::WSDL::Base);
  
  use version; our $VERSION = qv('2.00.99_3');
  
  my %port_of    :ATTR(:name<port>   :default<[]>);
  
  1;
SOAP_WSDL_SERVICE

$fatpacked{"SOAP/WSDL/Starter.pm"} = <<'SOAP_WSDL_STARTER';
  package
    SOAP::WSDL::Starter;
  {
      use strict;
      use warnings;
      use parent qw(Module::Starter::Simple);
      our $VERSION = 2.01;
  
      sub create_build {
          my $self        = shift;
          my $builder     = q{Module::Build};
          my $builder_set = Module::Starter::BuilderSet->new();
  
          # compile some build instructions, create a list of files generated
          # by the builders' create_* methods, and call said methods
  
          my @build_instructions;
          my @files;
  
          push @build_instructions,
            'To install this module, run the following commands:',
            join( "\n",
              map { "\t$_" } $builder_set->instructions_for_builder($builder) )
            ;
  
          push( @files, $builder_set->file_for_builder($builder) );
  
          my $build_method = $builder_set->method_for_builder($builder);
          $self->$build_method( $self->{main_module} );
  
          mkdir "$self->{basedir}/wsdl" or warn $!;
  
          return (
              files        => [@files],
              instructions => join( "\n\n", @build_instructions ),
          );
      }
  
      sub Build_PL_guts {
      my $self = shift;
      my $main_module = shift;
      my $main_pm_file = shift;
  
      (my $author = "$self->{author} <$self->{email}>") =~ s/'/\'/g;
  
      return <<"HERE";
  use strict;
  use warnings;
  use SOAP::WSDL::Build;
  
  my \$builder = SOAP::WSDL::Build->new(
      module_name         => '$main_module',
      license             => '$self->{license}',
      dist_author         => '$author',
      dist_version_from   => '$main_pm_file',
      build_requires => {
          'Test::More' => 0,
          'SOAP::WSDL::Build' => 2.01,
      },
      requires => {
          'SOAP::WSDL'    => 2.01
      },
      wsdl2perl => [
          {
              location    => 'wsdl/Add_WSDL_here',
              prefix      => '$main_module\::SOAP',
          }
      ],
      add_to_cleanup      => [ '$self->{distro}-*' ],
      create_makefile_pl => 'small',
  );
  
  \$builder->create_build_script();
  HERE
      }
  }
  
  1;
SOAP_WSDL_STARTER

$fatpacked{"SOAP/WSDL/Transport/HTTP.pm"} = <<'SOAP_WSDL_TRANSPORT_HTTP';
  package
    SOAP::WSDL::Transport::HTTP;
  use strict; use warnings;
  use base qw(LWP::UserAgent);
  
  use version; our $VERSION = qv('2.00.99_3');
  
  # create methods normally inherited from SOAP::Client
  SUBFACTORY: {
      no strict qw(refs);
      foreach my $method ( qw(code message status is_success) ) {
          *{ $method } = sub {
              my $self = shift;
              return $self->{ $method } if not @_;
              return $self->{ $method } = shift;
          };
      }
  }
  
  sub _agent {
      return qq[SOAP::WSDL $VERSION];
  }
  
  sub send_receive {
      my ($self, %parameters) = @_;
      my ($envelope, $soap_action, $endpoint, $encoding, $content_type) =
          @parameters{qw(envelope action endpoint encoding content_type)};
  
      $encoding = defined($encoding)
          ? lc($encoding)
          : 'utf-8';
  
      $content_type = "text/xml; charset=$encoding"
          if not defined($content_type);
      # what's this all about?
      # unfortunately combination of LWP and Perl 5.6.1 and later has bug
      # in sending multibyte characters. LWP uses length() to calculate
      # content-length header and starting 5.6.1 length() calculates chars
      # instead of bytes. 'use bytes' in THIS file doesn't work, because
      # it's lexically scoped. Unfortunately, content-length we calculate
      # here doesn't work either, because LWP overwrites it with
      # content-length it calculates (which is wrong) AND uses length()
      # during syswrite/sysread, so we are in a bad shape anyway.
      #
      # what to do? we calculate proper content-length (using
      # bytelength() function from SOAP::Utils) and then drop utf8 mark
      # from string (doing pack with 'C0A*' modifier) if length and
      # bytelength are not the same
  
      # use bytes is lexically scoped
      my $bytelength = do { use bytes; length $envelope };
      $envelope = pack('C0A*', $envelope)
          if length($envelope) != $bytelength;
  
      my $request = HTTP::Request->new( 'POST',
          $endpoint,
          [   'Content-Type', "$content_type",
              'Content-Length', $bytelength,
              'SOAPAction', $soap_action,
          ],
          $envelope );
  
      my $response = $self->request( $request );
  
      $self->code( $response->code);
      $self->message( $response->message);
      $self->is_success($response->is_success);
      $self->status($response->status_line);
  
      return $response->content();
  }
  
  1;
  
  =pod
  
  =head1 NAME
  
  SOAP::WSDL::Transport::HTTP - Fallback http(s) transport class
  
  =head1 DESCRIPTION
  
  Provides a thin transport class used by SOAP::WSDL::Transport when
  SOAP::Lite is not available.
  
  =head1 LICENSE AND COPYRIGHT
  
  Copyright (c) 2007 Martin Kutter. All rights reserved.
  
  This file is part of SOAP-WSDL. You may distribute/modify it under
  the same terms as perl itself
  
  =head1 AUTHOR
  
  Martin Kutter E<lt>martin.kutter fen-net.deE<gt>
  
  =head1 REPOSITORY INFORMATION
  
   $Rev: 861 $
   $LastChangedBy: kutterma $
   $Id: HTTP.pm 861 2010-03-28 10:41:26Z kutterma $
   $HeadURL: https://soap-wsdl.svn.sourceforge.net/svnroot/soap-wsdl/SOAP-WSDL/branches/Typemap/lib/SOAP/WSDL/Transport/HTTP.pm $
  
  =cut
  
SOAP_WSDL_TRANSPORT_HTTP

$fatpacked{"SOAP/WSDL/Transport/Loopback.pm"} = <<'SOAP_WSDL_TRANSPORT_LOOPBACK';
  package
    SOAP::WSDL::Transport::Loopback;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'basic';
  use SOAP::WSDL::Factory::Transport;
  
  use version; our $VERSION = qv('2.00.99_3');
  
  # register on loading
  SOAP::WSDL::Factory::Transport->register( http => __PACKAGE__ );
  SOAP::WSDL::Factory::Transport->register( https => __PACKAGE__ );
  
  my %code_of         :ATTR(:name<code>           :default<()>);
  my %status_of       :ATTR(:name<status>         :default<()>);
  my %message_of      :ATTR(:name<message>        :default<()>);
  my %is_success_of   :ATTR(:name<is_success>     :default<()>);
  
  # create methods normally inherited from SOAP::Client
  SUBFACTORY: {
      no strict qw(refs);
      foreach my $method ( qw(code message status is_success) ) {
          *{ $method } = *{ "get_$method" };
      }
  }
  
  sub send_receive {
      my ($self, %parameters) = @_;
      return $parameters{envelope};
  }
  
  Class::Std::initialize();
  
  
  1;
  
  =head1 NAME
  
  SOAP::WSDL::Transport::Test - Loopback transport class for SOAP::WSDL
  
  =head1 SYNOPSIS
  
   use SOAP::WSDL::Client;
   use SOAP::WSDL::Transport::Loopback;
  
   my $soap = SOAP::WSDL::Client->new()
   $soap->get_transport->set_base_dir('.');
   $soap->call('method', \%body, \%header);
  
  =head1 DESCRIPTION
  
  SOAP::WSDL::Transport::Loopback is a loopback test transport backend for
  SOAP::WSDL.
  
  When SOAP::WSDL::Transport::Loopback is used as transport backend, the
  request is returned as response. No data ever goes over the wire.
  This is particularly useful for testing SOAP::WSDL plugins and applications.
  
  =head1 LICENSE AND COPYRIGHT
  
  Copyright (c) 2007 Martin Kutter. All rights reserved.
  
  This file is part of SOAP-WSDL. You may distribute/modify it under
  the same terms as perl itself
  
  =head1 AUTHOR
  
  Martin Kutter E<lt>martin.kutter fen-net.deE<gt>
  
  =head1 REPOSITORY INFORMATION
  
   $Rev: 218 $
   $LastChangedBy: kutterma $
   $Id: HTTP.pm 218 2007-09-10 16:19:23Z kutterma $
   $HeadURL: https://soap-wsdl.svn.sourceforge.net/svnroot/soap-wsdl/SOAP-WSDL/trunk/lib/SOAP/WSDL/Transport/HTTP.pm $
  
  =cut
SOAP_WSDL_TRANSPORT_LOOPBACK

$fatpacked{"SOAP/WSDL/Transport/Test.pm"} = <<'SOAP_WSDL_TRANSPORT_TEST';
  package
    SOAP::WSDL::Transport::Test;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable;
  use SOAP::WSDL::Factory::Transport;
  
  use version; our $VERSION = qv('2.00.99_3');
  
  SOAP::WSDL::Factory::Transport->register( http => __PACKAGE__ );
  SOAP::WSDL::Factory::Transport->register( https => __PACKAGE__ );
  
  my %code_of :ATTR(:name<code>           :default<()>);
  my %status_of :ATTR(:name<status>       :default<()>);
  my %message_of :ATTR(:name<message>     :default<()>);
  my %is_success_of :ATTR(:name<is_success> :default<()>);
  my %base_dir_of :ATTR(:name<base_dir> :init_arg<base_dir> :default<.>);
  
  # create methods normally inherited from SOAP::Client
  SUBFACTORY: {
      no strict qw(refs);
      foreach my $method ( qw(code message status is_success) ) {
          *{ $method } = *{ "get_$method" };
      }
  }
  
  sub send_receive {
      my ($self, %parameters) = @_;
      my ($envelope, $soap_action, $endpoint, $encoding, $content_type) =
          @parameters{qw(envelope action endpoint encoding content_type)};
  
      my $filename = $soap_action;
      $filename =~s{ \A(:?'|") }{}xms;
      $filename =~s{ (:?'|")\z }{}xms;
      $filename =~s{ \A [^:]+ : (:? /{2})? }{}xms;
  
      $filename = join '/', $base_dir_of{ ${ $self } }, "$filename.xml";
  
      if (not -r $filename) {
          warn "cannot access $filename";
          $self->set_code( 500 );
          $self->set_message( "Failed" );
          $self->set_is_success(0);
          $self->set_status("500 Failed");
          return;
      }
  
      open my $fh, '<', $filename or die "cannot open $filename: $!";
      binmode $fh;
      my $response = <$fh>;
      close $fh or die "cannot close $filename: $!";
  
      $self->set_code( 200 );
      $self->set_message( "OK" );
      $self->set_is_success(1);
      $self->set_status("200 OK");
      return $response;
  }
  
  1;
  
  =head1 NAME
  
  SOAP::WSDL::Transport::Test - Test transport class for SOAP::WSDL
  
  =head1 SYNOPSIS
  
   use SOAP::WSDL::Client;
   use SOAP::WSDL::Transport::Test;
  
   my $soap = SOAP::WSDL::Client->new()
   $soap->get_transport->set_base_dir('.');
   $soap->call('method', \%body, \%header);
  
  =head1 DESCRIPTION
  
  SOAP::WSDL::Transport::Test is a file-based test transport backend for
  SOAP::WSDL.
  
  When SOAP::WSDL::Transport::Test is used as transport backend, the reponse is
  read from a XML file and the request message is discarded. This is
  particularly useful for testing SOAP::WSDL plugins.
  
  =head2 Filename resolution
  
  SOAP::WSDL::Transport makes up the response XML file name from the SOAPAction
  of the request. The following filename is used:
  
   base_dir / soap_action .xml
  
  The protocol scheme (e.g. http:) and two heading slashes (//) are stripped from
  the soap_action.
  
  base_dir defaults to '.'
  
  Examples:
  
   SOAPAction: http://somewhere.over.the.rainbow/webservice/webservice.asmx
   Filename: ./somewhere.over.the.rainbow/webservice/webservice.asmx.xml
  
   SOAPAction: uri:MyWickedService/test
   Filename: ./MyWickedService/test.xml
  
  
  =head1 METHODS
  
  =head2 set_base_dir
  
  Sets the base directory SOAP::WSDL::Transport::Test should look for response
  files.
  
  =head1 LICENSE AND COPYRIGHT
  
  Copyright (c) 2007 Martin Kutter. All rights reserved.
  
  This file is part of SOAP-WSDL. You may distribute/modify it under
  the same terms as perl itself
  
  =head1 AUTHOR
  
  Martin Kutter E<lt>martin.kutter fen-net.deE<gt>
  
  =head1 REPOSITORY INFORMATION
  
   $Rev: 218 $
   $LastChangedBy: kutterma $
   $Id: HTTP.pm 218 2007-09-10 16:19:23Z kutterma $
   $HeadURL: https://soap-wsdl.svn.sourceforge.net/svnroot/soap-wsdl/SOAP-WSDL/trunk/lib/SOAP/WSDL/Transport/HTTP.pm $
  
  =cut
SOAP_WSDL_TRANSPORT_TEST

$fatpacked{"SOAP/WSDL/TypeLookup.pm"} = <<'SOAP_WSDL_TYPELOOKUP';
  package
    SOAP::WSDL::TypeLookup;
  use strict;
  use warnings;
  
  use version; our $VERSION = qv('2.00.99_3');
  
  my %TYPE_FROM = (
      # wsdl:
      'http://schemas.xmlsoap.org/wsdl/' => {
          'import' => {
              type => 'HANDLER',
              method => 'wsdl_import',
          },
          binding => {
              type => 'CLASS',
              class => 'SOAP::WSDL::Binding',
          },
          definitions => {
              type => 'CLASS',
              class => 'SOAP::WSDL::Definitions',
          },
          portType => {
              type => 'CLASS',
              class => 'SOAP::WSDL::PortType',
          },
          message => {
              type => 'CLASS',
              class => 'SOAP::WSDL::Message',
          },
          part => {
              type => 'CLASS',
              class => 'SOAP::WSDL::Part',
          },
          service => {
              type => 'CLASS',
              class => 'SOAP::WSDL::Service',
          },
          port => {
              type => 'CLASS',
              class => 'SOAP::WSDL::Port',
          },
          operation => {
              type => 'CLASS',
              class => 'SOAP::WSDL::Operation',
          },
          input => {
              type => 'CLASS',
              class => 'SOAP::WSDL::OpMessage',
          },
          output => {
              type => 'CLASS',
              class => 'SOAP::WSDL::OpMessage',
          },
          fault => {
              type => 'CLASS',
              class => 'SOAP::WSDL::OpMessage',
          },
          types => {
              type => 'CLASS',
              class => 'SOAP::WSDL::Types',
          },
          documentation => {
              type => 'CONTENT',
              method => 'set_documentation',
          }
      },
      # soap:
      'http://schemas.xmlsoap.org/wsdl/soap/' => {
          operation => {
              type => 'CLASS',
              class => 'SOAP::WSDL::SOAP::Operation',
          },
          binding => {
              type => 'PARENT',
          },
          body => {
              type => 'CLASS',
              class => 'SOAP::WSDL::SOAP::Body',
          },
          header => {
              type => 'CLASS',
              class => 'SOAP::WSDL::SOAP::Header',
          },
          address => {
              type => 'CLASS',
              class => 'SOAP::WSDL::SOAP::Address',
          }
      },
      'http://www.w3.org/2001/XMLSchema' => {
          'import' => {
              type => 'HANDLER',
              method => 'xml_schema_import',
          },
          schema => {
              type => 'CLASS',
              class => 'SOAP::WSDL::XSD::Schema',
          },
          attribute => {
              type => 'CLASS',
              class => 'SOAP::WSDL::XSD::Attribute',
          },
          attributeGroup  => {
              type => 'CLASS',
              class => 'SOAP::WSDL::XSD::AttributeGroup',
          },
          key => {
              type => 'SKIP',     # not implemented yet
          },
          keyref => {
              type => 'SKIP',     # not implemented yet
          },
          unique => {
              type => 'SKIP',     # not implemented yet
          },
          notation => {
              type => 'SKIP',     # not implemented yet
          },
          annotation => {
              type => 'CLASS',     # not implemented yet
              class => 'SOAP::WSDL::XSD::Annotation',
          },
          documentation => {
              type => 'CONTENT',
              method => 'set_documentation',
          },
          appinfo => {
              type => 'SKIP',     # not implemented yet
          },
          description => {
              type => 'SKIP',     # not implemented yet
          },
          element => {
              type => 'CLASS',
              class => 'SOAP::WSDL::XSD::Element',
          },
          simpleType => {
              type => 'CLASS',
              class => 'SOAP::WSDL::XSD::SimpleType',
          },
          complexType => {
              type => 'CLASS',
              class => 'SOAP::WSDL::XSD::ComplexType',
          },
          simpleContent => {
              type => 'METHOD',
              method => 'set_contentModel',
              value => 'simpleContent'
          },
          complexContent => {
              type => 'METHOD',
              method => 'set_contentModel',
              value => 'complexContent'
          },
          restriction => {
              type => 'METHOD',
              method => 'set_restriction',
          },
          extension => {
              type => 'METHOD',
              method => 'set_extension',
          },
          list => {
              type => 'METHOD',
              method => 'set_list',
          },
          union => {
              type => 'METHOD',
              method => 'set_union',
          },
          enumeration => {
              type => 'CLASS',
              class => 'SOAP::WSDL::XSD::Enumeration',
          },
          group => {
              type => 'CLASS',
              class => 'SOAP::WSDL::XSD::Group',
          },
          all => {
              type => 'METHOD',
              method => 'set_variety',
              value => 'all',
          },
          choice => {
              type => 'METHOD',
              method => 'set_variety',
              value => 'choice',
          },
          sequence => {
              type => 'METHOD',
              method => 'set_variety',
              value => 'sequence',
          },
          value => {
              type => 'SKIP',
          },
          minExclusive => {
              type => 'CLASS',
              class => 'SOAP::WSDL::XSD::MinExclusive',
          },
          maxExclusive => {
              type => 'CLASS',
              class => 'SOAP::WSDL::XSD::MaxExclusive',
          },
          minInclusive => {
              type => 'CLASS',
              class => 'SOAP::WSDL::XSD::MinInclusive',
          },
          maxInclusive => {
              type => 'CLASS',
              class => 'SOAP::WSDL::XSD::MaxInclusive',
          },
          maxLength => {
              type => 'CLASS',
              class => 'SOAP::WSDL::XSD::MaxLength',
          },
          minLength => {
              type => 'CLASS',
              class => 'SOAP::WSDL::XSD::MinLength',
          },
          totalDigits => {
              type => 'CLASS',
              class => 'SOAP::WSDL::XSD::TotalDigits',
          },
          fractionDigits => {
              type => 'CLASS',
              class => 'SOAP::WSDL::XSD::FractionDigits',
          },
      },
  );
  
  $TYPE_FROM{ 'http://www.w3.org/2000/10/XMLSchema' } = $TYPE_FROM{ 'http://www.w3.org/2001/XMLSchema' };
  
  sub lookup {
      my ($self, $namespace, $name) = @_;
      return $TYPE_FROM{ $namespace }->{ $name };
  }
  
  1;
SOAP_WSDL_TYPELOOKUP

$fatpacked{"SOAP/WSDL/Types.pm"} = <<'SOAP_WSDL_TYPES';
  package
    SOAP::WSDL::Types;
  use strict;
  use warnings;
  use SOAP::WSDL::XSD::Schema::Builtin;
  use Class::Std::Fast::Storable;
  use base qw(SOAP::WSDL::Base);
  
  use version; our $VERSION = qv('2.00.99_3');
  
  my %schema_of :ATTR(:name<schema> :default<[]>);
  
  sub START {
      my ($self, $ident, $args_of) = @_;
      $self->push_schema( SOAP::WSDL::XSD::Schema::Builtin->new() );
      return $self;
  }
  
  sub find_type {
      my ($self, $ns, $name) = @_;
      ($ns, $name) = @{ $ns } if ref $ns;     # allow passing list refs
      print "Looking for type {$ns}$name\n" if ($SOAP::WSDL::Trace);
      foreach my $schema (@{ $schema_of{ ident $self } }) {
          my $type = $schema->find_type($ns, $name);
          return $type if $type;
      }
      return;
  }
  
  sub find_attribute {
      my ($self, $ns, $name) = @_;
      ($ns, $name) = @{ $ns } if ref $ns;     # allow passing list refs
      print "Looking for attribute {$ns}$name\n" if ($SOAP::WSDL::Trace);
      foreach my $schema (@{ $schema_of{ ident $self } }) {
          my $type = $schema->find_attribute($ns, $name);
          return $type if $type;
      }
      return;
  }
  
  sub find_element {
      my ($self, $ns, $name) = @_;
      ($ns, $name) = @{ $ns } if ref $ns;     # allow passing list refs
      print "Looking for element {$ns}$name\n" if ($SOAP::WSDL::Trace);
      foreach my $schema (@{ $schema_of{ ident $self } }) {
          print "\tin schema ", $schema->get_targetNamespace() ,"\n" if ($SOAP::WSDL::Trace);
          my $type = $schema->find_element($ns, $name);
          return $type if $type;
      }
      return;
  }
  
  1;
SOAP_WSDL_TYPES

$fatpacked{"SOAP/WSDL/XSD/Annotation.pm"} = <<'SOAP_WSDL_XSD_ANNOTATION';
  package
    SOAP::WSDL::XSD::Annotation;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'none';
  use base qw(SOAP::WSDL::Base);
  
  use version; our $VERSION = qv('2.00.99_3');
  
  #<enumeration value="">
  
  # id provided by Base
  # name provided by Base
  # annotation provided by Base
  
  # may be defined as atomic simpleType
  my %appinfo_of        :ATTR(:name<appinfo> :default<()>);
  
  # documentation provided by Base
  
  1;
SOAP_WSDL_XSD_ANNOTATION

$fatpacked{"SOAP/WSDL/XSD/Attribute.pm"} = <<'SOAP_WSDL_XSD_ATTRIBUTE';
  package
    SOAP::WSDL::XSD::Attribute;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'none';
  use base qw(SOAP::WSDL::Base);
  
  use version; our $VERSION = qv('2.00.99_3');
  
  #<attribute
  #  default = string
  #  fixed = string
  #  form = (qualified | unqualified)
  #  id = ID
  #  name = NCName
  #  ref = QName
  #  type = QName
  #  use = (optional | prohibited | required) : optional
  #  {any attributes with non-schema namespace . . .}>
  #  Content: (annotation?, (simpleType?))
  #</attribute>
  
  # id provided by Base
  # name provided by Base
  # annotation provided by Base
  
  my %default_of      :ATTR(:name<default>    :default<()>);
  my %fixed_of        :ATTR(:name<fixed>      :default<()>);
  my %form_of         :ATTR(:name<form>       :default<()>);
  
  my %type_of         :ATTR(:name<type>       :default<()>);
  my %use_of          :ATTR(:name<use>        :default<()>);
  my %ref_of          :ATTR(:name<ref>        :default<()>);
  
  # may be defined as atomic simpleType
  my %simpleType_of   :ATTR(:name<simpleType> :default<()>);
  
  1;
SOAP_WSDL_XSD_ATTRIBUTE

$fatpacked{"SOAP/WSDL/XSD/AttributeGroup.pm"} = <<'SOAP_WSDL_XSD_ATTRIBUTEGROUP';
  package
    SOAP::WSDL::XSD::AttributeGroup;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'none';
  use base qw(SOAP::WSDL::Base);
  
  use version; our $VERSION = qv('2.00.99_3');
  
  #<attributeGroup
  #  id = ID
  #  name = NCName
  #  ref = QName
  #  {any attributes with non-schema namespace . . .}>
  #  Content: (annotation?, ((attribute | attributeGroup)*, anyAttribute?))
  #</attributeGroup>
  
  # id provided by Base
  # name provided by Base
  # annotation provided by Base
  
  my %ref_of          :ATTR(:name<ref>        :default<()>);
  
  # may be defined as atomic simpleType
  my %attribute_of        :ATTR(:name<attribute> :default<()>);
  my %attributeGroup_of   :ATTR(:name<attributeGroup> :default<()>);
  
  1;
SOAP_WSDL_XSD_ATTRIBUTEGROUP

$fatpacked{"SOAP/WSDL/XSD/Builtin.pm"} = <<'SOAP_WSDL_XSD_BUILTIN';
  package
    SOAP::WSDL::XSD::Builtin;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable;
  use base qw(SOAP::WSDL::Base);
  
  use version; our $VERSION = qv('2.00.99_3');
  
  # only used in SOAP::WSDL - will be obsolete once SOAP::WSDL uses the
  # generative approach, too
  
  sub serialize {
      my ($self, $name, $value, $opt) = @_;
      my $xml;
      $opt->{ indent } ||= "";
      $opt->{ attributes } ||= [];
  
      $xml .= $opt->{ indent } if ($opt->{ readable });
      $xml .= '<' . join ' ', $name, @{ $opt->{ attributes } };
      if ( $opt->{ autotype }) {
          my $ns = $self->get_targetNamespace();
          my %prefix_of = reverse %{ $opt->{ namespace } };
          my $prefix = $prefix_of{ $ns }
              || die 'No prefix found for namespace '. $ns;
          $xml .= ' type="' . $prefix . ':'
            . $self->get_name() . '"';
      }
  
      if (defined $value) {
          $xml .= '>';
          $xml .= "$value";
          $xml .= '</' . $name . '>' ;
      }
      else {
          $xml .= '/>';
      }
      $xml .= "\n" if ($opt->{ readable });
      return $xml;
  }
  
  1;
SOAP_WSDL_XSD_BUILTIN

$fatpacked{"SOAP/WSDL/XSD/ComplexType.pm"} = <<'SOAP_WSDL_XSD_COMPLEXTYPE';
  package
    SOAP::WSDL::XSD::ComplexType;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable;
  use Scalar::Util qw(blessed);
  use base qw(SOAP::WSDL::Base);
  
  use version; our $VERSION = qv('2.00.99_3');
  
  # id provided by Base
  # name provided by Base
  # annotation provided by Base
  my %length_of           :ATTR(:name<length>         :default<[]>);
  my %minLength_of        :ATTR(:name<minLength>      :default<[]>);
  my %maxLength_of        :ATTR(:name<maxLength>      :default<[]>);
  my %pattern_of          :ATTR(:name<pattern>        :default<[]>);
  my %enumeration_of      :ATTR(:name<enumeration>    :default<[]>);
  my %whiteSpace_of       :ATTR(:name<whiteSpace>     :default<[]>);
  my %totalDigits_of      :ATTR(:name<totalDigits>    :default<[]>);
  my %fractionDigits_of   :ATTR(:name<fractionDigits>    :default<[]>);
  my %minExclusive        :ATTR(:name<minExclusive>   :default<[]>);
  my %minInclusive        :ATTR(:name<minInclusive>   :default<[]>);
  my %maxExclusive        :ATTR(:name<maxExclusive>   :default<[]>);
  my %maxInclusive        :ATTR(:name<maxInclusive>   :default<[]>);
  
  
  my %attribute_of    :ATTR(:name<attribute>  :default<()>);
  my %element_of      :ATTR(:name<element>    :default<[]>);
  my %group_of        :ATTR(:name<group>      :default<()>);
  my %variety_of      :ATTR(:name<variety>    :default<()>);
  my %base_of         :ATTR(:name<base>       :default<()>);
  my %itemType_of     :ATTR(:name<itemType>   :default<()>);
  my %abstract_of     :ATTR(:name<abstract>   :default<()>);
  my %final_of        :ATTR(:name<final>      :default<()>);
  my %mixed_of        :ATTR(:name<mixed>      :default<()>);      # default is false
  
  my %derivation_of   :ATTR(:name<derivation> :default<()>);
  
  # is set to simpleContent/complexContent
  my %content_model_of    :ATTR(:name<contentModel>   :default<NONE>);
  
  sub get_flavor; *get_flavor = \&get_variety;
  
  sub push_element {
      my $self = shift;
      my $element = shift;
      if ($variety_of{ ident $self } eq 'all')
      {
          $element->set_minOccurs(0) if not defined ($element->get_minOccurs);
          $element->set_maxOccurs(1) if not defined ($element->get_maxOccurs);
      }
      elsif ($variety_of{ ident $self } eq 'sequence')
      {
          $element->set_minOccurs(1) if not defined ($element->get_minOccurs);
          $element->set_maxOccurs(1) if not defined ($element->get_maxOccurs);
      }
      push @{ $element_of{ ident $self } }, $element;
  }
  
  sub set_restriction {
      my $self = shift;
      my $element = shift;
      $variety_of{ ident $self } = 'restriction';
      $derivation_of{ ident $self } = 'restriction';
      $base_of{ ident $self } = $element->{ Value };
  }
  
  sub set_extension {
      my $self = shift;
      my $element = shift;
      $variety_of{ ident $self } = 'extension';
      $derivation_of{ ident $self } = 'extension';
      $base_of{ ident $self } = $element->{ Value };
  }
  
  sub init {
      my $self = shift;
      my @args = @_;
      $self->SUPER::init( @args );
  }
  
  sub serialize {
      my ($self, $name, $value, $opt) = @_;
  
      $opt->{ indent } ||= q{};
      $opt->{ attributes } ||= [];
      my $variety = $self->get_variety();
      my $xml = ($opt->{ readable }) ? $opt->{ indent } : q{};    # add indentation
  
      if ( $opt->{ qualify } ) {
          $opt->{ attributes } = [ ' xmlns="' . $self->get_targetNamespace .'"' ];
          delete $opt->{ qualify };
      }
  
      $xml .= join q{ } , "<$name" , @{ $opt->{ attributes } };
      delete $opt->{ attributes };                                # don't propagate...
  
      if ( $opt->{ autotype }) {
          my $ns = $self->get_targetNamespace();
          # reverse namespace by prefix hash
          my %prefix_of = reverse %{ $opt->{ namespace } };
          my $prefix = $prefix_of{ $ns }
              || die 'No prefix found for namespace '. $ns;
          $xml .= join q{}, " type=\"$prefix:", $self->get_name(), '" '
              if ($self->get_name() );
      }
      $xml .= '>';
      $xml .= "\n" if ( $opt->{ readable } );                 # add linebreak
  
      if ($self->schema) {
          if ($self->schema()->get_elementFormDefault() ne "qualified") {
              push @{$opt->{ attributes } }, q{xmlns=""}
                  if ($self->get_targetNamespace() ne "");
          }
      }
      if ( ($variety eq "sequence") or ($variety eq "all") ) {
          $opt->{ indent } .= "\t";
          for my $element (@{ $self->get_element() }) {
              # resolve element ref
              #
              # Basic algorithm is like this:
              # If on serialization, we meet a element whose get_ref method
              # returns a true value, lookup the element from the <types>
              # definitions instead, and serialize this element.
              #
              if (my $ref = $element->get_ref()) {
                  $element = $opt->{ typelib }->find_element(
                      $element->expand($ref)
                  );
              }
  
              # might be list - listify
              $value = [ $value ] if not ref $value eq 'ARRAY';
  
              for my $single_value (@{ $value }) {
                  my $element_value;
                  if (blessed $single_value) {
                      my $method = 'get_' . $element->get_name();
                      $element_value = $single_value->$method();
                  }
                  else {
                      $element_value = $single_value->{ $element->get_name() };
                  }
                  $element_value = [ $element_value ]
                      if not ref $element_value eq 'ARRAY';
  
                  $xml .= join q{}
                      , map { $element->serialize( undef, $_, $opt ) }
                         @{ $element_value };
              }
          }
          $opt->{ indent } =~s/\t$//;
      }
      else {
          die "sorry, we just handle all and sequence types yet...";
      }
      $xml .= $opt->{ indent } if ( $opt->{ readable } ); # add indentation
      $xml .= '</' . $name . '>';
      $xml .= "\n" if ($opt->{ readable } );              # add linebreak
      return $xml;
  }
  
  1;
  
SOAP_WSDL_XSD_COMPLEXTYPE

$fatpacked{"SOAP/WSDL/XSD/Element.pm"} = <<'SOAP_WSDL_XSD_ELEMENT';
  package
    SOAP::WSDL::XSD::Element;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable;
  use base qw(SOAP::WSDL::Base);
  
  use version; our $VERSION = qv('2.00.99_3');
  
  # id provided by Base
  # name provided by Base
  # annotation provided by Base
  my %simpleType_of   :ATTR(:name<simpleType> :default<()>);
  my %complexType_of  :ATTR(:name<complexType> :default<()>);
  my %facet_of        :ATTR(:name<facet>      :default<()>);
  my %type_of         :ATTR(:name<type>       :default<()>);
  my %abstract_of     :ATTR(:name<abstract>   :default<()>);
  my %block_of        :ATTR(:name<block>      :default<()>);
  my %default_of      :ATTR(:name<default>    :default<()>);
  my %final_of        :ATTR(:name<final>      :default<()>);
  my %fixed_of        :ATTR(:name<fixed>      :default<()>);
  my %form_of         :ATTR(:name<form>       :default<()>);
  my %maxOccurs_of    :ATTR(:name<maxOccurs>  :default<()>);
  my %minOccurs_of    :ATTR(:name<minOccurs>  :default<()>);
  my %nillable_of     :ATTR(:name<nillable>   :default<()>);
  my %ref_of          :ATTR(:name<ref>        :default<()>);
  my %substitutionGroup_of :ATTR(:name<substitutionGroup> :default<()>);
  
  sub first_simpleType {
      my $result_ref = $simpleType_of{ ident shift };
      return if not $result_ref;
      return $result_ref if (not ref $result_ref eq 'ARRAY');
      return $result_ref->[0];
  }
  
  sub first_complexType {
      my $result_ref = $complexType_of{ ident shift };
      return if not $result_ref;
      return $result_ref if (not ref $result_ref eq 'ARRAY');
      return $result_ref->[0];
  }
  
  # serialize type instead...
  sub serialize {
      my ($self, $name, $value, $opt) = @_;
      my $type;
      my $typelib = $opt->{ typelib };
      my %ns_map = %{ $opt->{ namespace } };
      my $ident = ident $self;
  
      # abstract elements may only be serialized via ref - and then we have a
      # name...
      die "cannot serialize abstract element" if $abstract_of{ $ident }
          and not $name;
  
      # TODO: implement final and substitutionGroup - maybe never implement
      # substitutionGroup ?
  
      $name = $self->get_name() if not ($name);
  
      if ( $opt->{ qualify } ) {
          $opt->{ attributes } = [ ' xmlns="' . $self->get_targetNamespace .'"' ];
      }
  
  
      # set default and fixed - fixed overrides everything,
      # default only empty (undefined) values
      if (not defined $value)     {
        $value = $default_of{ ident $self } if $default_of{ ident $self };
      }
      $value = $fixed_of{ ident $self } if $fixed_of{ ident $self };
  
      # TODO check nillable and serialize empty data correctly
  
      # return if minOccurs is 0 and we have no value
      if (defined $minOccurs_of{ ident $self }
          and $minOccurs_of{ ident $self } == 0) {
          return q{} if not defined $value;
      }
  
      # handle direct simpleType and complexType here
      if ($type = $self->first_simpleType() ) {             # simpleType
          return $type->serialize( $name, $value, $opt );
      }
      elsif ($type = $self->first_complexType() ) {           # complexType
          return $type->serialize( $name, $value, $opt );
      }
      elsif (my $ref_name = $ref_of{ $ident }) {              # ref
          my ($prefix, $localname) = split /:/ , $ref_name;
          my $ns = $ns_map{ $prefix };
          $type = $typelib->find_element( $ns, $localname );
          die "no element for ref $prefix:$localname" if (not $type);
          return $type->serialize( $name, $value, $opt );
      }
  
      # lookup type
      my ($prefix, $localname) = split /:/ , $self->get_type();
      my $ns = $ns_map{ $prefix };
      $type = $typelib->find_type(
          $ns, $localname
      );
  
      # safety check
      die "no type for $prefix:$localname $ns_map{$prefix}" if (not $type);
  
      return $type->serialize( $name, $value, $opt );
  }
  
  1;
  
SOAP_WSDL_XSD_ELEMENT

$fatpacked{"SOAP/WSDL/XSD/Enumeration.pm"} = <<'SOAP_WSDL_XSD_ENUMERATION';
  package
    SOAP::WSDL::XSD::Enumeration;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'none';
  use base qw(SOAP::WSDL::Base);
  
  use version; our $VERSION = qv('2.00.99_3');
  
  #<enumeration value="">
  
  # id provided by Base
  # name provided by Base
  # annotation provided by Base
  
  # may be defined as atomic simpleType
  my %value_of        :ATTR(:name<value> :default<()>);
  
  1;
SOAP_WSDL_XSD_ENUMERATION

$fatpacked{"SOAP/WSDL/XSD/FractionDigits.pm"} = <<'SOAP_WSDL_XSD_FRACTIONDIGITS';
  package
    SOAP::WSDL::XSD::FractionDigits;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'none';
  use base qw(SOAP::WSDL::Base);
  
  use version; our $VERSION = qv('2.00.99_3');
  #<pattern value="">
  
  # id provided by Base
  # name provided by Base
  # annotation provided by Base
  
  # may be defined as atomic simpleType
  my %value_of        :ATTR(:name<value> :default<()>);
  
  1;
SOAP_WSDL_XSD_FRACTIONDIGITS

$fatpacked{"SOAP/WSDL/XSD/Group.pm"} = <<'SOAP_WSDL_XSD_GROUP';
  package
    SOAP::WSDL::XSD::Group;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'none';
  use base qw(SOAP::WSDL::Base);
  
  use version; our $VERSION = qv('2.00.99_3');
  
  #<xs:group name="myModelGroup">
  # <xs:sequence>
  #  <xs:element ref="someThing"/>
  #  . . .
  # </xs:sequence>
  #</xs:group>
  #
  #<xs:complexType name="trivial">
  # <xs:group ref="myModelGroup"/>
  # <xs:attribute .../>
  #</xs:complexType>
  #
  #<xs:complexType name="moreSo">
  # <xs:choice>
  #  <xs:element ref="anotherThing"/>
  #  <xs:group ref="myModelGroup"/>
  # </xs:choice>
  # <xs:attribute .../>
  #</xs:complexType>
  
  my %ref_of          :ATTR(:name<ref>      :default<()>);
  
  my %maxOccurs_of    :ATTR(:name<maxOccurs>  :default<()>);
  my %minOccurs_of    :ATTR(:name<minOccurs>  :default<()>);
  my %annotation_of   :ATTR(:name<annotation> :default<()>);
  my %element_of      :ATTR(:name<element>    :default<()>);
  my %group_of        :ATTR(:name<group>      :default<()>);
  my %variety_of      :ATTR(:name<variety>    :default<()>);
  
  1;
SOAP_WSDL_XSD_GROUP

$fatpacked{"SOAP/WSDL/XSD/Length.pm"} = <<'SOAP_WSDL_XSD_LENGTH';
  package
    SOAP::WSDL::XSD::Length;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'none';
  use base qw(SOAP::WSDL::Base);
  
  use version; our $VERSION = qv('2.00.99_3');
  
  #<minExclusive value="">
  
  # id provided by Base
  # name provided by Base
  # annotation provided by Base
  
  # may be defined as atomic simpleType
  my %value_of        :ATTR(:name<value> :default<()>);
  
  1;
SOAP_WSDL_XSD_LENGTH

$fatpacked{"SOAP/WSDL/XSD/MaxExclusive.pm"} = <<'SOAP_WSDL_XSD_MAXEXCLUSIVE';
  package
    SOAP::WSDL::XSD::MaxExclusive;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'none';
  use base qw(SOAP::WSDL::Base);
  
  use version; our $VERSION = qv('2.00.99_3');
  
  #<minExclusive value="">
  
  # id provided by Base
  # name provided by Base
  # annotation provided by Base
  
  # may be defined as atomic simpleType
  my %value_of        :ATTR(:name<value> :default<()>);
  
  1;
SOAP_WSDL_XSD_MAXEXCLUSIVE

$fatpacked{"SOAP/WSDL/XSD/MaxInclusive.pm"} = <<'SOAP_WSDL_XSD_MAXINCLUSIVE';
  package
    SOAP::WSDL::XSD::MaxInclusive;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'none';
  use base qw(SOAP::WSDL::Base);
  
  use version; our $VERSION = qv('2.00.99_3');
  
  #<minExclusive value="">
  
  # id provided by Base
  # name provided by Base
  # annotation provided by Base
  
  # may be defined as atomic simpleType
  my %value_of        :ATTR(:name<value> :default<()>);
  
  1;
SOAP_WSDL_XSD_MAXINCLUSIVE

$fatpacked{"SOAP/WSDL/XSD/MaxLength.pm"} = <<'SOAP_WSDL_XSD_MAXLENGTH';
  package
    SOAP::WSDL::XSD::MaxLength;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'none';
  use base qw(SOAP::WSDL::Base);
  
  use version; our $VERSION = qv('2.00.99_3');
  
  #<maxLength value="">
  
  # id provided by Base
  # name provided by Base
  # annotation provided by Base
  
  # may be defined as atomic simpleType
  my %value_of        :ATTR(:name<value> :default<()>);
  my %fixed_of        :ATTR(:name<fixed> :default<()>);
  
  1;
SOAP_WSDL_XSD_MAXLENGTH

$fatpacked{"SOAP/WSDL/XSD/MinExclusive.pm"} = <<'SOAP_WSDL_XSD_MINEXCLUSIVE';
  package
    SOAP::WSDL::XSD::MinExclusive;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'none';
  use base qw(SOAP::WSDL::Base);
  
  use version; our $VERSION = qv('2.00.99_3');
  
  #<minExclusive value="">
  
  # id provided by Base
  # name provided by Base
  # annotation provided by Base
  
  # may be defined as atomic simpleType
  my %value_of        :ATTR(:name<value> :default<()>);
  
  1;
SOAP_WSDL_XSD_MINEXCLUSIVE

$fatpacked{"SOAP/WSDL/XSD/MinInclusive.pm"} = <<'SOAP_WSDL_XSD_MININCLUSIVE';
  package
    SOAP::WSDL::XSD::MinInclusive;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'none';
  use base qw(SOAP::WSDL::Base);
  
  use version; our $VERSION = qv('2.00.99_3');
  
  #<minExclusive value="">
  
  # id provided by Base
  # name provided by Base
  # annotation provided by Base
  
  # may be defined as atomic simpleType
  my %value_of        :ATTR(:name<value> :default<()>);
  
  1;
SOAP_WSDL_XSD_MININCLUSIVE

$fatpacked{"SOAP/WSDL/XSD/MinLength.pm"} = <<'SOAP_WSDL_XSD_MINLENGTH';
  package
    SOAP::WSDL::XSD::MinLength;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'none';
  use base qw(SOAP::WSDL::Base);
  
  use version; our $VERSION = qv('2.00.99_3');
  
  #<minExclusive value="">
  
  # id provided by Base
  # name provided by Base
  # annotation provided by Base
  
  # may be defined as atomic simpleType
  my %value_of        :ATTR(:name<value> :default<()>);
  
  1;
SOAP_WSDL_XSD_MINLENGTH

$fatpacked{"SOAP/WSDL/XSD/Pattern.pm"} = <<'SOAP_WSDL_XSD_PATTERN';
  package
    SOAP::WSDL::XSD::Pattern;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'none';
  use base qw(SOAP::WSDL::Base);
  
  use version; our $VERSION = qv('2.00.99_3');
  
  #<pattern value="">
  
  # id provided by Base
  # name provided by Base
  # annotation provided by Base
  
  # may be defined as atomic simpleType
  my %value_of        :ATTR(:name<value> :default<()>);
  
  1;
SOAP_WSDL_XSD_PATTERN

$fatpacked{"SOAP/WSDL/XSD/Schema.pm"} = <<'SOAP_WSDL_XSD_SCHEMA';
  package
    SOAP::WSDL::XSD::Schema;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable;
  use base qw(SOAP::WSDL::Base);
  
  use version; our $VERSION = qv('2.00.99_3');
  
  # child elements
  my %attributeGroup_of   :ATTR(:name<attributeGroup>  :default<[]>);
  my %attribute_of        :ATTR(:name<attribute>       :default<[]>);
  my %element_of          :ATTR(:name<element>         :default<[]>);
  my %group_of            :ATTR(:name<group>           :default<[]>);
  my %type_of             :ATTR(:name<type>            :default<[]>);
  
  # attributes
  my %attributeFormDefault_of :ATTR(:name<attributeFormDefault> :default<unqualified>);
  my %blockDefault_of         :ATTR(:name<blockDefault>         :default<()>);
  my %elementFormDefault_of   :ATTR(:name<elementFormDefault>   :default<unqualified>);
  my %finalDefault_of         :ATTR(:name<finalDefault>         :default<()>);
  my %version_of              :ATTR(:name<version>              :default<()>);
  
  # id
  # name
  # targetNamespace inherited from Base
  # xmlns
  
  #
  #  attributeFormDefault = (qualified | unqualified) : unqualified
  #  blockDefault = (#all | List of (extension | restriction | substitution))  : ''
  #  elementFormDefault = (qualified | unqualified) : unqualified
  #  finalDefault = (#all | List of (extension | restriction | list | union))  : ''
  #  id = ID
  #  targetNamespace = anyURI
  #  version = token
  #  xml:lang = language
  #
  #
  # alias type with all variants
  # AUTOMETHOD is WAY too slow..
  {
      no strict qw(refs);
      for my $name (qw(simpleType complexType) ) {
          *{ "set_$name" }  = \&set_type;
          *{ "get_$name" }  = \&get_type;
          *{ "push_$name" } = \&push_type;
          *{ "find_$name" } = \&find_type;
      }
  }
  
  sub push_type {
      # use $_[n] for performance -
      # we're called on each and every type inside WSDL
      push @{ $type_of{ ident $_[0]} }, $_[1];
  }
  
  sub find_element {
      my ($self, @args) = @_;
      print "Looking for element $args[1] in ", $self->get_targetNamespace(), "\n" if $SOAP::WSDL::Trace;
      for (@{ $element_of{ ident $self } }) {
          print "\t{" . $_->get_targetNamespace() . "}" . $_->get_name()."\n" if $SOAP::WSDL::Trace;
          next if $_->get_targetNamespace() ne $args[0];
          return $_ if $_->get_name() eq $args[1];
      }
      return;
  }
  
  sub find_type {
      my ($self, @args) = @_;
      print "Looking for type $args[1] in ", $self->get_targetNamespace(), "\n" if $SOAP::WSDL::Trace;
      for (@{ $type_of{ ident $self } }) {
          print "\t{" . $_->get_targetNamespace() . "}" . $_->get_name()."\n" if $SOAP::WSDL::Trace;
          next if $_->get_targetNamespace() ne $args[0];
          return $_ if $_->get_name() eq $args[1];
      }
      return;
  }
  
  1;
SOAP_WSDL_XSD_SCHEMA

$fatpacked{"SOAP/WSDL/XSD/Schema/Builtin.pm"} = <<'SOAP_WSDL_XSD_SCHEMA_BUILTIN';
  package
    SOAP::WSDL::XSD::Schema::Builtin;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable;
  use SOAP::WSDL::XSD::Schema;
  use SOAP::WSDL::XSD::Builtin;
  use base qw(SOAP::WSDL::XSD::Schema);
  
  use version; our $VERSION = qv('2.00.99_3');
  
  # all builtin types - add validation (e.g. content restrictions) later...
  my %BUILTINS = (
      'anyType'           => {},
      'anySimpleType'     => {},
      'anyURI'            => {},
      'boolean'           => {},
      'base64Binary'      => {},
      'byte'              => {},
      'date'              => {},
      'dateTime'          => {},
      'decimal'           => {},
      'double'            => {},
      'duration'          => {},
      'ENTITY'            => {},
      'float'             => {},
      'gDay'              => {},
      'gMonth'            => {},
      'gMonthDay'         => {},
      'gYearMonth'        => {},
      'gYear'             => {},
      'hexBinary'         => {},
      'ID'                => {},
      'IDREF'             => {},
      'IDREFS'            => {},
      'int'               => {},
      'integer'           => {},
      'language'          => {},
      'long'              => {},
      'negativeInteger'   => {},
      'nonPositiveInteger' => {},
      'nonNegativeInteger' => {},
      'normalizedString'  => {},
      'Name'              => {},
      'NCName'            => {},
      'NMTOKEN'           => {},
      'NOTATION'          => {},
      'positiveInteger'   => {},
      'QName'             => {},
      'short'             => {},
      'string'            => {},
      'time'              => {},
      'token'             => {},
      'unsignedByte'      => {},
      'unsignedInt'       => {},
      'unsignedLong'      => {},
      'unsignedShort'     => {},
  );
  
  sub START {
      my $self = shift;
      my @args = @_;
  
      while (my ($name, $value) = each %BUILTINS )
      {
          $self->push_type( SOAP::WSDL::XSD::Builtin->new({
                  name => $name,
                  targetNamespace => 'http://www.w3.org/2001/XMLSchema',
                  xmlns => {
                      '#default' => 'http://www.w3.org/2001/XMLSchema',
                  }
              } )
          );
      }
      $self->set_targetNamespace('http://www.w3.org/2001/XMLSchema');
      return $self;
  }
  
  1;
  
  
  =pod
  
  =head1 NAME
  
  SOAP:WSDL::XSD::Schema::Builtin - Provides builtin XML Schema datatypes for parsing WSDL
  
  =head1 DESCRIPTION
  
  Used internally by SOAP::WSDL's WSDL parser.
  
  See <SOAP::WSDL::XSD::Typelib::Builtin|SOAP::WSDL::XSD::Typelib::Builtin> for
  SOAP::WSDL::XSD's builtin XML Schema datatypes.
  
  =head1 LICENSE AND COPYRIGHT
  
  Copyright (c) 2007 Martin Kutter. All rights reserved.
  
  This file is part of SOAP-WSDL. You may distribute/modify it under
  the same terms as perl itself
  
  =head1 AUTHOR
  
  Martin Kutter E<lt>martin.kutter fen-net.deE<gt>
  
  =head1 REPOSITORY INFORMATION
  
   $Rev: 861 $
   $LastChangedBy: kutterma $
   $Id: Builtin.pm 861 2010-03-28 10:41:26Z kutterma $
   $HeadURL: https://soap-wsdl.svn.sourceforge.net/svnroot/soap-wsdl/SOAP-WSDL/branches/Typemap/lib/SOAP/WSDL/XSD/Schema/Builtin.pm $
  
  =cut
  
SOAP_WSDL_XSD_SCHEMA_BUILTIN

$fatpacked{"SOAP/WSDL/XSD/SimpleType.pm"} = <<'SOAP_WSDL_XSD_SIMPLETYPE';
  package
    SOAP::WSDL::XSD::SimpleType;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable;
  use base qw(SOAP::WSDL::Base);
  
  use version; our $VERSION = qv('2.00.99_3');
  
  my %length_of           :ATTR(:name<length>         :default<[]>);
  my %minLength_of        :ATTR(:name<minLength>      :default<[]>);
  my %maxLength_of        :ATTR(:name<maxLength>      :default<[]>);
  my %pattern_of          :ATTR(:name<pattern>        :default<[]>);
  my %enumeration_of      :ATTR(:name<enumeration>    :default<[]>);
  my %whiteSpace_of       :ATTR(:name<whiteSpace>     :default<[]>);
  my %totalDigits_of      :ATTR(:name<totalDigits>    :default<[]>);
  my %fractionDigits_of   :ATTR(:name<fractionDigits>    :default<[]>);
  my %minExclusive        :ATTR(:name<minExclusive>   :default<[]>);
  my %minInclusive        :ATTR(:name<minInclusive>   :default<[]>);
  my %maxExclusive        :ATTR(:name<maxExclusive>   :default<[]>);
  my %maxInclusive        :ATTR(:name<maxInclusive>   :default<[]>);
  
  my %nillable_of         :ATTR(:name<nillable>       :default<()>);
  my %fixed               :ATTR(:name<fixed>          :default<[]>);
  
  my %annotation_of       :ATTR(:name<annotation>     :default<()>);
  my %base_of             :ATTR(:name<base>           :default<()>);
  my %itemType_of         :ATTR(:name<itemType>       :default<()>);
  
  
  # TODO rename flavor to variety to be consistent with the XML Schema
  # specs - though flavor is the cooler name..
  # set to restriction|list|union|enumeration
  my %flavor_of       :ATTR(:name<flavor>         :default<()>);
  
  # for simpleType containing atomic simple types
  my %type_of         :ATTR(:name<type>           :default<()>);
  
  sub get_simpleType; *get_simpleType = \&get_type;
  sub set_simpleType; *set_simpleType = \&set_type;
  
  sub get_variety; *get_variety = \&get_flavor;
  
  sub set_restriction {
      my $self = shift;
      my @attributes = @_;
      $self->set_flavor( 'restriction' );
  
      for (@attributes) {
          next if (not $_->{ LocalName } eq 'base');
          $self->set_base( $_->{ Value } );
      }
  }
  
  sub set_list {
      my $self = shift;
      my @attributes = @_;
      $self->set_flavor( 'list' );
      for (@attributes) {
          next if (not $_->{ LocalName } eq 'itemType');
          $self->set_itemType( $_->{ Value } );
      }
  }
  
  sub set_union {
      my $self = shift;
      my @attributes = @_;
      $self->set_flavor( 'union' );
      for (@attributes) {
          next if (not $_->{ LocalName } eq 'memberTypes');
          $self->set_base( [ split /\s/, $_->{ Value } ] );
      }
  }
  
  sub serialize {
      my $self = shift;
      my $name = shift;
      my $value = shift;
      my $opt = shift;
      my $ident = ident $self;
  
      $opt->{ attributes } ||= [];
      $opt->{ indent } ||= q{};
  
      return $self->_serialize_single($name, $value , $opt)
        if ( $flavor_of{ $ident } eq 'restriction'
          or $flavor_of{ $ident } eq 'union'
          or $flavor_of{ $ident } eq 'enumeration');
  
      if ($flavor_of{ $ident } eq 'list' )
      {
          $value ||= [];
          $value = [ $value ] if ( ref( $value) ne 'ARRAY' );
          return $self->_serialize_single($name, join( q{ }, @{ $value } ), $opt);
      }
  }
  
  sub _serialize_single {
      my ($self, $name, $value, $opt) = @_;
      my $xml = '';
      $xml .= $opt->{ indent } if ($opt->{ readable });       # add indentation
      $xml .= '<' . join ' ', $name, @{ $opt->{ attributes } };
      if ( $opt->{ autotype }) {
          # reverse namespace by prefix hash
          my %prefix_of = reverse %{ $opt->{ namespace } };
          my $ns = $self->get_targetNamespace();
          my $prefix = $prefix_of{ $ns }
             || die 'No prefix found for namespace '. $ns;
          $xml .= ' type="' . $prefix . ':' . $self->get_name() .'"';
      }
  
      # nillabel ?
      return $xml .'/>' if not defined $value;
  
      $xml .= join q{}, '>' , $value , '</' , $name , '>';
      $xml .= "\n" if ($opt->{ readable });
      return $xml;
  }
  
  1;
SOAP_WSDL_XSD_SIMPLETYPE

$fatpacked{"SOAP/WSDL/XSD/TotalDigits.pm"} = <<'SOAP_WSDL_XSD_TOTALDIGITS';
  package
    SOAP::WSDL::XSD::TotalDigits;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'none';
  use base qw(SOAP::WSDL::Base);
  
  use version; our $VERSION = qv('2.00.99_3');
  
  #<totalDigits value="">
  
  # id provided by Base
  # name provided by Base
  # annotation provided by Base
  
  # may be defined as atomic simpleType
  my %value_of        :ATTR(:name<value> :default<()>);
  my %fixed_of        :ATTR(:name<fixed> :default<()>);
  1;
SOAP_WSDL_XSD_TOTALDIGITS

$fatpacked{"SOAP/WSDL/XSD/Typelib/Attribute.pm"} = <<'SOAP_WSDL_XSD_TYPELIB_ATTRIBUTE';
  package
    SOAP::WSDL::XSD::Typelib::Attribute;
  use strict;
  use warnings;
  
  use base qw(SOAP::WSDL::XSD::Typelib::Element);
  
  use version; our $VERSION = qv('2.00.99_3');
  
  sub start_tag {
      # my ($self, $opt, $value) = @_;
      return q{} if (@_ < 3);
      my $ns = $_[0]->get_xmlns();
      if ($ns eq 'http://www.w3.org/XML/1998/namespace') {
          return qq{ xml:$_[1]->{ name }="};
      }
      return qq{ $_[1]->{ name }="};
  }
  
  sub end_tag {
      return q{"};
  }
  
  1;
SOAP_WSDL_XSD_TYPELIB_ATTRIBUTE

$fatpacked{"SOAP/WSDL/XSD/Typelib/AttributeSet.pm"} = <<'SOAP_WSDL_XSD_TYPELIB_ATTRIBUTESET';
  package
    SOAP::WSDL::XSD::Typelib::AttributeSet;
  use strict;
  use warnings;
  use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);
  
  use version; our $VERSION = qv('2.00.99_3');
  
  sub serialize {
      # we work on @_ for performance.
      # $_[1] ||= {};                                   # $option_ref
      # TODO: What about namespaces?
      return ${ $_[0]->_serialize({ attr => 1 }) };
  }
  
  
  1;
SOAP_WSDL_XSD_TYPELIB_ATTRIBUTESET

$fatpacked{"SOAP/WSDL/XSD/Typelib/Builtin.pm"} = <<'SOAP_WSDL_XSD_TYPELIB_BUILTIN';
  package
    SOAP::WSDL::XSD::Typelib::Builtin;
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
  
SOAP_WSDL_XSD_TYPELIB_BUILTIN

$fatpacked{"SOAP/WSDL/XSD/Typelib/Builtin/ENTITY.pm"} = <<'SOAP_WSDL_XSD_TYPELIB_BUILTIN_ENTITY';
  package
    SOAP::WSDL::XSD::Typelib::Builtin::ENTITY;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'none', cache => 1;
  use base qw(SOAP::WSDL::XSD::Typelib::Builtin::NCName);
  Class::Std::initialize();
  1;
SOAP_WSDL_XSD_TYPELIB_BUILTIN_ENTITY

$fatpacked{"SOAP/WSDL/XSD/Typelib/Builtin/ID.pm"} = <<'SOAP_WSDL_XSD_TYPELIB_BUILTIN_ID';
  package
    SOAP::WSDL::XSD::Typelib::Builtin::ID;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'none', cache => 1;
  use base qw(SOAP::WSDL::XSD::Typelib::Builtin::NCName);
  
  1;
SOAP_WSDL_XSD_TYPELIB_BUILTIN_ID

$fatpacked{"SOAP/WSDL/XSD/Typelib/Builtin/IDREF.pm"} = <<'SOAP_WSDL_XSD_TYPELIB_BUILTIN_IDREF';
  package
    SOAP::WSDL::XSD::Typelib::Builtin::IDREF;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'none', cache => 1;
  use base qw(SOAP::WSDL::XSD::Typelib::Builtin::ID);
  
  1;
SOAP_WSDL_XSD_TYPELIB_BUILTIN_IDREF

$fatpacked{"SOAP/WSDL/XSD/Typelib/Builtin/IDREFS.pm"} = <<'SOAP_WSDL_XSD_TYPELIB_BUILTIN_IDREFS';
  package
    SOAP::WSDL::XSD::Typelib::Builtin::IDREFS;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'none', cache => 1;
  use base qw(
      SOAP::WSDL::XSD::Typelib::Builtin::list
      SOAP::WSDL::XSD::Typelib::Builtin::IDREF);
  
  1;
SOAP_WSDL_XSD_TYPELIB_BUILTIN_IDREFS

$fatpacked{"SOAP/WSDL/XSD/Typelib/Builtin/NCName.pm"} = <<'SOAP_WSDL_XSD_TYPELIB_BUILTIN_NCNAME';
  package
    SOAP::WSDL::XSD::Typelib::Builtin::NCName;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'none', cache => 1;
  use base qw(SOAP::WSDL::XSD::Typelib::Builtin::Name);
  Class::Std::initialize();
  1;
SOAP_WSDL_XSD_TYPELIB_BUILTIN_NCNAME

$fatpacked{"SOAP/WSDL/XSD/Typelib/Builtin/NMTOKEN.pm"} = <<'SOAP_WSDL_XSD_TYPELIB_BUILTIN_NMTOKEN';
  package
    SOAP::WSDL::XSD::Typelib::Builtin::NMTOKEN;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'none', cache => 1;
  use base qw(SOAP::WSDL::XSD::Typelib::Builtin::token);
  Class::Std::initialize();
  1;
SOAP_WSDL_XSD_TYPELIB_BUILTIN_NMTOKEN

$fatpacked{"SOAP/WSDL/XSD/Typelib/Builtin/NMTOKENS.pm"} = <<'SOAP_WSDL_XSD_TYPELIB_BUILTIN_NMTOKENS';
  package
    SOAP::WSDL::XSD::Typelib::Builtin::NMTOKENS;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'none', cache => 1;
  
  use base qw(SOAP::WSDL::XSD::Typelib::Builtin::list
        SOAP::WSDL::XSD::Typelib::Builtin::NMTOKEN);
  
  Class::Std::initialize();
  
  1;
SOAP_WSDL_XSD_TYPELIB_BUILTIN_NMTOKENS

$fatpacked{"SOAP/WSDL/XSD/Typelib/Builtin/NOTATION.pm"} = <<'SOAP_WSDL_XSD_TYPELIB_BUILTIN_NOTATION';
  package
    SOAP::WSDL::XSD::Typelib::Builtin::NOTATION;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'none', cache => 1;
  use base qw(SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType);
  
  1;
SOAP_WSDL_XSD_TYPELIB_BUILTIN_NOTATION

$fatpacked{"SOAP/WSDL/XSD/Typelib/Builtin/Name.pm"} = <<'SOAP_WSDL_XSD_TYPELIB_BUILTIN_NAME';
  package
    SOAP::WSDL::XSD::Typelib::Builtin::Name;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'none', cache => 1;
  use base qw(SOAP::WSDL::XSD::Typelib::Builtin::token);
  Class::Std::initialize();
  1;
SOAP_WSDL_XSD_TYPELIB_BUILTIN_NAME

$fatpacked{"SOAP/WSDL/XSD/Typelib/Builtin/QName.pm"} = <<'SOAP_WSDL_XSD_TYPELIB_BUILTIN_QNAME';
  package
    SOAP::WSDL::XSD::Typelib::Builtin::QName;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'none', cache => 1;
  use base qw(SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType);
  
  1;
  
SOAP_WSDL_XSD_TYPELIB_BUILTIN_QNAME

$fatpacked{"SOAP/WSDL/XSD/Typelib/Builtin/anySimpleType.pm"} = <<'SOAP_WSDL_XSD_TYPELIB_BUILTIN_ANYSIMPLETYPE';
  package
    SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'none', cache => 1;
  use SOAP::WSDL::XSD::Typelib::Builtin::anyType;
  use base qw(SOAP::WSDL::XSD::Typelib::Builtin::anyType);
  
  my %value_of :ATTR(:get<value> :init_arg<value> :default<()>);
  
  # don't you never dare to play with this !
  our $___value = \%value_of;
  
  sub get_xmltype { 
      my $class = ref $_[0];
      if ($class =~s{^SOAP::WSDL::XSD::Typelib::Builtin::}{}x) {
          return $class;
      }
      else {
          die "You must override get_xmltype in $class";
      }
  }
  
  ## use $_[n] for speed - we get called zillions of times...
  # and we don't need to return the last value...
  sub set_value { $value_of{ ${ $_[0] } } = $_[1] }
  
  # Default attribute handling
  # TODO add something for handling default attributes
  sub attr {
  }
  
  # use $_[n] for speed.
  # This is less readable, but notably faster.
  #
  # use postfix-if for speed. This is slightly faster, as it saves
  # perl from creating a pad (variable context).
  #
  # The methods below may get called zillions of times, so
  # every little statement matters...
  
  sub serialize {
      $_[1] ||= {};
      if (not defined $value_of{ ${$_[0]} }) {
          return $_[0]->start_tag({ %{ $_[1] },  nil => 1 }, undef);
      }
      return join q{}
          , $_[0]->start_tag($_[1], $value_of{ ${$_[0]} })
          , $value_of{ ${$_[0]} }
          , $_[0]->end_tag($_[1]);
  }
  
  sub as_string :STRINGIFY {
      return defined($value_of { ${ $_[0] } }) ? $value_of { ${ $_[0] } } : q{};
  }
  
  sub as_bool :BOOLIFY {
      return $value_of { ${ $_[0] } };
  }
  
  my $OBJECT_CACHE_REF = Class::Std::Fast::OBJECT_CACHE_REF();
  
  sub new {
      my $self = pop @{ $OBJECT_CACHE_REF->{ $_[0] } };
      $self = bless \(my $o = Class::Std::Fast::ID()), $_[0]
          if not defined $self;
      $value_of{ $$self } = $_[1]->{ value }
          if (($#_) && exists $_[1]->{ value });
      return $self;
  }
  
  Class::Std::initialize();   # make :BOOLIFY overloading serializable
  
  1;
SOAP_WSDL_XSD_TYPELIB_BUILTIN_ANYSIMPLETYPE

$fatpacked{"SOAP/WSDL/XSD/Typelib/Builtin/anyType.pm"} = <<'SOAP_WSDL_XSD_TYPELIB_BUILTIN_ANYTYPE';
  package
    SOAP::WSDL::XSD::Typelib::Builtin::anyType;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'none';
  
  use version; our $VERSION = qv('2.00.99_3');
  
  sub get_xmlns { 'http://www.w3.org/2001/XMLSchema' };
  
  sub get_xmltype { "xs:anyType" }
  
  # start_tag creates a XML start tag either for a XML element or a attribute.
  # The method is highly optimized for performance:
  # - operates on @_
  # - uses no private variables
  # - uses no blocks
  
  sub start_tag {
      # return empty string if no second argument ($opt) or no name
      return q{} if (! $#_);
      return q{} if (! exists $_[1]->{ name });
      # return attribute start if it's an attribute
      return qq{ $_[1]->{name}="} if $_[1]->{ attr };
      # return with xsi:nil="true" if it is nil
      return join
          q{} ,
          "<$_[1]->{ name }" ,
          # xsi:type
          (defined $_[1]->{ derived }) ? qq{ xsi:type="} . $_[0]->get_xmltype . q{"} : (),
          # xmlns=
          (defined $_[1]->{ xmlns }) ? qq{ xmlns="$_[1]->{ xmlns }"} : (),
          # attributes
          $_[0]->serialize_attr($_[1]) ,
          q{ xsi:nil="true"/>}
              if ($_[1]->{ nil });
      # return "empty" start tag if it's empty
      return join
          q{},
          "<$_[1]->{ name }",
          # xsi:type
          (defined $_[1]->{ derived }) ? qq{ xsi:type="} . $_[0]->get_xmltype . q{"} : (),
          # xmlns=
          (defined $_[1]->{ xmlns }) ? qq{ xmlns="$_[1]->{ xmlns }"} : (),
          $_[0]->serialize_attr($_[1]) ,
          '/>'
          if ($_[1]->{ empty });
      # return XML element start tag
      return join
          q{},
          "<$_[1]->{ name }",
          # xsi:type
          (defined $_[1]->{ derived }) ? qq{ xsi:type="} . $_[0]->get_xmltype . q{"} : (),
          # xmlns=
          (defined $_[1]->{ xmlns }) ? qq{ xmlns="$_[1]->{ xmlns }"} : (),
          , $_[0]->serialize_attr($_[1])
          , '>';
  }
  
  # start_tag creates a XML end tag either for a XML element or a attribute.
  # The method is highly optimized for performance:
  # - operates on @_
  # - uses no private variables
  # - uses no blocks
  sub end_tag {
      # return empty string if no second argument ($opt) or no name
      return q{} if (! $#_);
      return q{} if (! exists $_[1]->{ name });
      return q{"} if $_[1]->{ attr };
      return "</$_[1]->{name}>";
  };
  
  sub serialize_attr {};
  
  sub serialize_qualified :STRINGIFY {
      return $_[0]->serialize( { qualified => 1 } );
  }
  
  sub as_list :ARRAYIFY {
      return [ $_[0] ];
  }
  
  Class::Std::initialize();           # make :STRINGIFY overloading work
  
  1;
  
SOAP_WSDL_XSD_TYPELIB_BUILTIN_ANYTYPE

$fatpacked{"SOAP/WSDL/XSD/Typelib/Builtin/anyURI.pm"} = <<'SOAP_WSDL_XSD_TYPELIB_BUILTIN_ANYURI';
  package
    SOAP::WSDL::XSD::Typelib::Builtin::anyURI;
  use strict;
  use warnings;
  
  use Class::Std::Fast::Storable constructor => 'none', cache => 1;
  use base qw(SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType);
  
  1;
SOAP_WSDL_XSD_TYPELIB_BUILTIN_ANYURI

$fatpacked{"SOAP/WSDL/XSD/Typelib/Builtin/base64Binary.pm"} = <<'SOAP_WSDL_XSD_TYPELIB_BUILTIN_BASE64BINARY';
  package
    SOAP::WSDL::XSD::Typelib::Builtin::base64Binary;
  use strict;
  use warnings;
  
  use Class::Std::Fast::Storable constructor => 'none', cache => 1;
  use base qw(SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType);
  
  1;
  
SOAP_WSDL_XSD_TYPELIB_BUILTIN_BASE64BINARY

$fatpacked{"SOAP/WSDL/XSD/Typelib/Builtin/boolean.pm"} = <<'SOAP_WSDL_XSD_TYPELIB_BUILTIN_BOOLEAN';
  package
    SOAP::WSDL::XSD::Typelib::Builtin::boolean;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'none', cache => 1;
  
  use version; our $VERSION = qv('2.00.99_3');
  
  use base qw(SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType);
  
  sub serialize {
      $_[1] ||= {};
      my $value =$_[0]->get_value();
      return $_[0]->start_tag({ %{$_[1]}, nil => 1})
              if not defined $value;
      return join q{}
          , $_[0]->start_tag($_[1])
          , $value && $value ne 'false' ? 'true' : 'false'
          , $_[0]->end_tag($_[1]);
  }
  
  sub as_string :STRINGIFY {
      my $value = $_[0]->get_value();
      return q{} if not defined $value;
      return ($value && $value ne 'false') ? 1 : 0;
  }
  
  sub as_num :NUMERIFY :BOOLIFY {
      my $value = $_[0]->get_value();
      return ($value && $value ne 'false') ? 1 : 0;
  }
  
  sub set_value {
      $_[0]->SUPER::set_value( defined $_[1]
          ? ($_[1] ne 'false' && ($_[1]) )
              ? 1 : 0
          : 0);
  }
  
  sub delete_value { $_[0]->SUPER::set_value(undef) }
  
  Class::Std::Fast::initialize();   # make :BOOLIFY overloading serializable
  
  1;
SOAP_WSDL_XSD_TYPELIB_BUILTIN_BOOLEAN

$fatpacked{"SOAP/WSDL/XSD/Typelib/Builtin/byte.pm"} = <<'SOAP_WSDL_XSD_TYPELIB_BUILTIN_BYTE';
  package
    SOAP::WSDL::XSD::Typelib::Builtin::byte;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'none', cache => 1;
  use base qw(SOAP::WSDL::XSD::Typelib::Builtin::short);
  Class::Std::initialize();
  1;
SOAP_WSDL_XSD_TYPELIB_BUILTIN_BYTE

$fatpacked{"SOAP/WSDL/XSD/Typelib/Builtin/date.pm"} = <<'SOAP_WSDL_XSD_TYPELIB_BUILTIN_DATE';
  package
    SOAP::WSDL::XSD::Typelib::Builtin::date;
  use strict;
  use warnings;
  use Date::Parse;
  use Date::Format;
  
  use Class::Std::Fast::Storable constructor => 'none', cache => 1;
  use base qw(SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType);
  
  sub set_value {
      # use set_value from base class if we have a XML-DateTime format
      #2037-12-31+01:00
      if (
          $_[1] =~ m{ ^\d{4} \- \d{2} \- \d{2}
              (:? [\+\-] \d{2} \: \d{2} )$
          }xms
      ) {
          $_[0]->SUPER::set_value($_[1])
      }
      # converting a date is hard work: It needs a timezone, because
      # 2007-12-30+12:00 and 2007-12-31-12:00 mean the same day - just in
      # different locations.
      # strftime actually prints out the correct date, but always prints the
      # local timezone with %z.
      # So, if our timezone is not 0, we strftime it without timezone and
      # append it by hand by the following formula:
      # The timezone hours are the int (timesone seconds / 3600)
      # The timezone minutes (if someone ever specifies something like that)
      # are int( (seconds % 3600) / 60 )
      # say, int( (seconds modulo 3600) / 60 )
      #
      # If we have no timezone (meaning the timezone is
      else {
          # strptime sets empty values to undef - and strftime doesn't like that...
          my @time_from =  strptime($_[1]);
          my $time_zone_seconds = $time_from[6];
          @time_from = map { (! defined $_) ? 0 : $_ } @time_from;
  #        use Data::Dumper;
  #        warn Dumper \@time_from, sprintf('%+03d%02d', $time_from[6] / 3600, $time_from[6] % 60 );
          my $time_str;
          if (defined $time_zone_seconds) {
              $time_str = sprintf('%04d-%02d-%02d%+03d:%02d', $time_from[5]+1900, $time_from[4]+1, $time_from[3], int($time_from[6] / 3600), int($time_from[6] % 3600) / 60);
          }
          else {
              $time_str = strftime( '%Y-%m-%d%z', @time_from );
              substr $time_str, -2, 0, ':';
          }
  
  #          ? strftime( '%Y-%m-%d', @time_from )
  #            . sprintf('%+03d%02d', int($time_from[6] / 3600), int ( ($time_from[6] % 3600) / 60 ) )
  #          : do {
  #              strftime( '%Y-%m-%d%z', @time_from );
  #          };
  #        substr $time_str, -2, 0, ':';
          $_[0]->SUPER::set_value($time_str);
      }
  }
  
  1;
  
SOAP_WSDL_XSD_TYPELIB_BUILTIN_DATE

$fatpacked{"SOAP/WSDL/XSD/Typelib/Builtin/dateTime.pm"} = <<'SOAP_WSDL_XSD_TYPELIB_BUILTIN_DATETIME';
  package
    SOAP::WSDL::XSD::Typelib::Builtin::dateTime;
  
  use strict;
  use warnings;
  
  use Date::Parse;
  use Date::Format;
  
  
  use Class::Std::Fast::Storable constructor => 'none', cache => 1;
  use base qw(SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType);
  
  sub set_value {
  
      # use set_value from base class if we have a XML-DateTime format
      #2037-12-31T00:00:00.0000000+01:00
      return $_[0]->SUPER::set_value( $_[1] ) if not defined $_[1];
      return $_[0]->SUPER::set_value( $_[1] )
        if (
          $_[1] =~ m{ ^\d{4} \- \d{2} \- \d{2}
              T \d{2} \: \d{2} \: \d{2} (:? \. \d{1,7} )?
              [\+\-] \d{2} \: \d{2} $
          }xms
        );
  
      # strptime sets empty values to undef - and strftime doesn't like that...
      my @time_from = strptime( $_[1] );
  
      die "Illegal date" if not defined $time_from[5];
  
      # strftime doesn't like undefs
      @time_from = map { !defined $_ ? 0 : $_ } @time_from;
  
      my $time_str;
      if ( $time_from[-1] ) {
          $time_str = sprintf(
              '%04d-%02d-%02dT%02d:%02d:%02d.0000000%+03d:%02d',
              $time_from[5] + 1900,
              $time_from[4] + 1,
              $time_from[3],
              $time_from[2],
              $time_from[1],
              $time_from[0],
              int( $time_from[6] / 3600 ),
              int( $time_from[6] % 3600 ) / 60
          );
      }
      else {
          $time_str = strftime( '%Y-%m-%dT%H:%M:%S%z', @time_from );
          substr $time_str, -2, 0, ':';
      }
  
      $_[0]->SUPER::set_value($time_str);
  }
  
  1;
SOAP_WSDL_XSD_TYPELIB_BUILTIN_DATETIME

$fatpacked{"SOAP/WSDL/XSD/Typelib/Builtin/decimal.pm"} = <<'SOAP_WSDL_XSD_TYPELIB_BUILTIN_DECIMAL';
  package
    SOAP::WSDL::XSD::Typelib::Builtin::decimal;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'none', cache => 1;
  use base qw(SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType);
  
  sub as_num :NUMERIFY :BOOLIFY {
      return $_[0]->get_value();
  }
  
  Class::Std::Fast::initialize();   # make :NUMERIFY :BOOLIFY overloading serializable
  
  1;
SOAP_WSDL_XSD_TYPELIB_BUILTIN_DECIMAL

$fatpacked{"SOAP/WSDL/XSD/Typelib/Builtin/double.pm"} = <<'SOAP_WSDL_XSD_TYPELIB_BUILTIN_DOUBLE';
  package
    SOAP::WSDL::XSD::Typelib::Builtin::double;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'none', cache => 1;
  use base qw(SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType);
  
  sub as_num :NUMERIFY {
      return $_[0]->get_value();
  }
  
  Class::Std::initialize();   # make :NUMERIFY overloading serializable
  
  1;
SOAP_WSDL_XSD_TYPELIB_BUILTIN_DOUBLE

$fatpacked{"SOAP/WSDL/XSD/Typelib/Builtin/duration.pm"} = <<'SOAP_WSDL_XSD_TYPELIB_BUILTIN_DURATION';
  package
    SOAP::WSDL::XSD::Typelib::Builtin::duration;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'none', cache => 1;
  use base qw(SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType);
  
  1;
SOAP_WSDL_XSD_TYPELIB_BUILTIN_DURATION

$fatpacked{"SOAP/WSDL/XSD/Typelib/Builtin/float.pm"} = <<'SOAP_WSDL_XSD_TYPELIB_BUILTIN_FLOAT';
  package
    SOAP::WSDL::XSD::Typelib::Builtin::float;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'none', cache => 1;
  use base qw(SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType);
  
  sub as_num :NUMERIFY {
      return $_[0]->get_value();
  }
  
  Class::Std::initialize();   # make :NUMERIFY overloading serializable
  
  1;
  
SOAP_WSDL_XSD_TYPELIB_BUILTIN_FLOAT

$fatpacked{"SOAP/WSDL/XSD/Typelib/Builtin/gDay.pm"} = <<'SOAP_WSDL_XSD_TYPELIB_BUILTIN_GDAY';
  package
    SOAP::WSDL::XSD::Typelib::Builtin::gDay;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'none', cache => 1;
  use base qw(SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType);
  
  1;
SOAP_WSDL_XSD_TYPELIB_BUILTIN_GDAY

$fatpacked{"SOAP/WSDL/XSD/Typelib/Builtin/gMonth.pm"} = <<'SOAP_WSDL_XSD_TYPELIB_BUILTIN_GMONTH';
  package
    SOAP::WSDL::XSD::Typelib::Builtin::gMonth;
  use strict;
  use warnings;
  
  # Speed up. Class::Std::new is slow - and we don't need it's functionality...
  use Class::Std::Fast::Storable constructor => 'none', cache => 1;
  use base qw(SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType);
  
  1;
SOAP_WSDL_XSD_TYPELIB_BUILTIN_GMONTH

$fatpacked{"SOAP/WSDL/XSD/Typelib/Builtin/gMonthDay.pm"} = <<'SOAP_WSDL_XSD_TYPELIB_BUILTIN_GMONTHDAY';
  package
    SOAP::WSDL::XSD::Typelib::Builtin::gMonthDay;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'none', cache => 1;
  use base qw(SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType);
  
  1;
SOAP_WSDL_XSD_TYPELIB_BUILTIN_GMONTHDAY

$fatpacked{"SOAP/WSDL/XSD/Typelib/Builtin/gYear.pm"} = <<'SOAP_WSDL_XSD_TYPELIB_BUILTIN_GYEAR';
  package
    SOAP::WSDL::XSD::Typelib::Builtin::gYear;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'none', cache => 1;
  use base qw(SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType);
  
  1;
SOAP_WSDL_XSD_TYPELIB_BUILTIN_GYEAR

$fatpacked{"SOAP/WSDL/XSD/Typelib/Builtin/gYearMonth.pm"} = <<'SOAP_WSDL_XSD_TYPELIB_BUILTIN_GYEARMONTH';
  package
    SOAP::WSDL::XSD::Typelib::Builtin::gYearMonth;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'none', cache => 1;
  use base qw(SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType);
  
  1;
SOAP_WSDL_XSD_TYPELIB_BUILTIN_GYEARMONTH

$fatpacked{"SOAP/WSDL/XSD/Typelib/Builtin/hexBinary.pm"} = <<'SOAP_WSDL_XSD_TYPELIB_BUILTIN_HEXBINARY';
  package
    SOAP::WSDL::XSD::Typelib::Builtin::hexBinary;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'none', cache => 1;
  use base qw(SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType);
  
  1;
SOAP_WSDL_XSD_TYPELIB_BUILTIN_HEXBINARY

$fatpacked{"SOAP/WSDL/XSD/Typelib/Builtin/int.pm"} = <<'SOAP_WSDL_XSD_TYPELIB_BUILTIN_INT';
  package
    SOAP::WSDL::XSD::Typelib::Builtin::int;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'none', cache => 1;
  use base qw(SOAP::WSDL::XSD::Typelib::Builtin::long);
  
  1;
SOAP_WSDL_XSD_TYPELIB_BUILTIN_INT

$fatpacked{"SOAP/WSDL/XSD/Typelib/Builtin/integer.pm"} = <<'SOAP_WSDL_XSD_TYPELIB_BUILTIN_INTEGER';
  package
    SOAP::WSDL::XSD::Typelib::Builtin::integer;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'none', cache => 1;
  use base qw(SOAP::WSDL::XSD::Typelib::Builtin::decimal);
  
  1;
SOAP_WSDL_XSD_TYPELIB_BUILTIN_INTEGER

$fatpacked{"SOAP/WSDL/XSD/Typelib/Builtin/language.pm"} = <<'SOAP_WSDL_XSD_TYPELIB_BUILTIN_LANGUAGE';
  package
    SOAP::WSDL::XSD::Typelib::Builtin::language;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable;
  use base qw(SOAP::WSDL::XSD::Typelib::Builtin::token);
  
  1;
SOAP_WSDL_XSD_TYPELIB_BUILTIN_LANGUAGE

$fatpacked{"SOAP/WSDL/XSD/Typelib/Builtin/list.pm"} = <<'SOAP_WSDL_XSD_TYPELIB_BUILTIN_LIST';
  package
    SOAP::WSDL::XSD::Typelib::Builtin::list;
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
SOAP_WSDL_XSD_TYPELIB_BUILTIN_LIST

$fatpacked{"SOAP/WSDL/XSD/Typelib/Builtin/long.pm"} = <<'SOAP_WSDL_XSD_TYPELIB_BUILTIN_LONG';
  package
    SOAP::WSDL::XSD::Typelib::Builtin::long;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'none', cache => 1;
  use base qw(SOAP::WSDL::XSD::Typelib::Builtin::integer);
  
  1;
SOAP_WSDL_XSD_TYPELIB_BUILTIN_LONG

$fatpacked{"SOAP/WSDL/XSD/Typelib/Builtin/negativeInteger.pm"} = <<'SOAP_WSDL_XSD_TYPELIB_BUILTIN_NEGATIVEINTEGER';
  package
    SOAP::WSDL::XSD::Typelib::Builtin::negativeInteger;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'none', cache => 1;
  use base qw(SOAP::WSDL::XSD::Typelib::Builtin::nonPositiveInteger);
  
  1;
SOAP_WSDL_XSD_TYPELIB_BUILTIN_NEGATIVEINTEGER

$fatpacked{"SOAP/WSDL/XSD/Typelib/Builtin/nonNegativeInteger.pm"} = <<'SOAP_WSDL_XSD_TYPELIB_BUILTIN_NONNEGATIVEINTEGER';
  package
    SOAP::WSDL::XSD::Typelib::Builtin::nonNegativeInteger;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'none', cache => 1;
  use base qw(SOAP::WSDL::XSD::Typelib::Builtin::integer);
  
  1;
SOAP_WSDL_XSD_TYPELIB_BUILTIN_NONNEGATIVEINTEGER

$fatpacked{"SOAP/WSDL/XSD/Typelib/Builtin/nonPositiveInteger.pm"} = <<'SOAP_WSDL_XSD_TYPELIB_BUILTIN_NONPOSITIVEINTEGER';
  package
    SOAP::WSDL::XSD::Typelib::Builtin::nonPositiveInteger;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'none', cache => 1;
  use base qw(SOAP::WSDL::XSD::Typelib::Builtin::integer);
  
  1;
SOAP_WSDL_XSD_TYPELIB_BUILTIN_NONPOSITIVEINTEGER

$fatpacked{"SOAP/WSDL/XSD/Typelib/Builtin/normalizedString.pm"} = <<'SOAP_WSDL_XSD_TYPELIB_BUILTIN_NORMALIZEDSTRING';
  package
    SOAP::WSDL::XSD::Typelib::Builtin::normalizedString;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'none', cache => 1;
  use base qw(SOAP::WSDL::XSD::Typelib::Builtin::string);
  
  # replace all \t, \r, \n by \s
  sub set_value {
      my $value = $_[1];
      $value =~ s{ [\r\n\t]+ }{ }xmsg if defined($value);
      $_[0]->SUPER::set_value($value);
  }
  Class::Std::initialize();
  1;
SOAP_WSDL_XSD_TYPELIB_BUILTIN_NORMALIZEDSTRING

$fatpacked{"SOAP/WSDL/XSD/Typelib/Builtin/positiveInteger.pm"} = <<'SOAP_WSDL_XSD_TYPELIB_BUILTIN_POSITIVEINTEGER';
  package
    SOAP::WSDL::XSD::Typelib::Builtin::positiveInteger;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'none', cache => 1;
  use base qw(SOAP::WSDL::XSD::Typelib::Builtin::nonNegativeInteger);
  
  1;
SOAP_WSDL_XSD_TYPELIB_BUILTIN_POSITIVEINTEGER

$fatpacked{"SOAP/WSDL/XSD/Typelib/Builtin/short.pm"} = <<'SOAP_WSDL_XSD_TYPELIB_BUILTIN_SHORT';
  package
    SOAP::WSDL::XSD::Typelib::Builtin::short;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'none', cache => 1;
  use base qw(SOAP::WSDL::XSD::Typelib::Builtin::int);
  
  1;
SOAP_WSDL_XSD_TYPELIB_BUILTIN_SHORT

$fatpacked{"SOAP/WSDL/XSD/Typelib/Builtin/string.pm"} = <<'SOAP_WSDL_XSD_TYPELIB_BUILTIN_STRING';
  package
    SOAP::WSDL::XSD::Typelib::Builtin::string;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'none', cache => 1;
  use base qw(SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType);
  
  my %char2entity = (
      q{&} => q{&amp;},
      q{<} => q{&lt;},
      q{>} => q{&gt;},
      q{"} => q{&quot;},
      q{'} => q{&apos;},
  );
  
  # sub get_xmltype { "xs:string" }
  
  sub serialize {
      $_[1] ||= {};
  
      my $value = $_[0]->get_value();
  
      return $_[0]->start_tag({ %{ $_[1] }, nil => 1})
          if not defined $value;
  
      # HTML::Entities does the same - and more, thus it's around 1/3 slower...
      $value =~ s{([&<>"'])}{$char2entity{$1}}xgmso;
  
      return join q{}, $_[0]->start_tag($_[1], $value)
          #, encode_entities( $value, q{&<>"'} )
          , $value
          , $_[0]->end_tag($_[1]);
  }
  
  sub as_bool :BOOLIFY {
      return $_[0]->get_value();
  }
  
  Class::Std::initialize();
  1;
SOAP_WSDL_XSD_TYPELIB_BUILTIN_STRING

$fatpacked{"SOAP/WSDL/XSD/Typelib/Builtin/time.pm"} = <<'SOAP_WSDL_XSD_TYPELIB_BUILTIN_TIME';
  package
    SOAP::WSDL::XSD::Typelib::Builtin::time;
  use strict;
  use warnings;
  use Date::Parse;
  use Date::Format;
  use Class::Std::Fast::Storable constructor => 'none', cache => 1;
  use base qw(SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType);
  
  use version; our $VERSION = qv('2.00.99_3');
  
  sub set_value {
      # use set_value from base class if we have a XML-Time format
      # 00:00:00.0000000+01:00
      if (
          $_[1] =~ m{ ^ \d{2} \: \d{2} \: \d{2} (:? \. \d{1,7} )?
              [\+\-] \d{2} \: \d{2} $
          }xms
      ) {
          $_[0]->SUPER::set_value($_[1])
      }
      # use a combination of strptime and strftime for converting the date
      # Unfortunately, strftime outputs the time zone as [+-]0000, whereas XML
      # whants it as [+-]00:00
      # We leave out the optional nanoseconds part, as it would always be empty.
      else {
          # strptime sets empty values to undef - and strftime doesn't like that...
          # we even need to set it to 1 to prevent a "Day '0' out of range 1..31" warning..
  
          # we need to set the current date for correct TZ conversion -
          # could be daylight savings time
          my @now = localtime;
          my @time_from = map { my $alternative = shift @now;
              ! defined $_
                  ? $alternative
                  : $_ } strptime($_[1]);
          undef $time_from[-1];
          my $time_str = strftime( '%H:%M:%S%z', @time_from );
          substr $time_str, -2, 0, ':';
          $_[0]->SUPER::set_value($time_str);
      }
  }
  
  1;
SOAP_WSDL_XSD_TYPELIB_BUILTIN_TIME

$fatpacked{"SOAP/WSDL/XSD/Typelib/Builtin/token.pm"} = <<'SOAP_WSDL_XSD_TYPELIB_BUILTIN_TOKEN';
  package
    SOAP::WSDL::XSD::Typelib::Builtin::token;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'none', cache => 1;
  use base qw(SOAP::WSDL::XSD::Typelib::Builtin::normalizedString);
  Class::Std::initialize();
  1;
SOAP_WSDL_XSD_TYPELIB_BUILTIN_TOKEN

$fatpacked{"SOAP/WSDL/XSD/Typelib/Builtin/unsignedByte.pm"} = <<'SOAP_WSDL_XSD_TYPELIB_BUILTIN_UNSIGNEDBYTE';
  package
    SOAP::WSDL::XSD::Typelib::Builtin::unsignedByte;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'none', cache => 1;
  use base qw(SOAP::WSDL::XSD::Typelib::Builtin::unsignedShort);
  
  1;
SOAP_WSDL_XSD_TYPELIB_BUILTIN_UNSIGNEDBYTE

$fatpacked{"SOAP/WSDL/XSD/Typelib/Builtin/unsignedInt.pm"} = <<'SOAP_WSDL_XSD_TYPELIB_BUILTIN_UNSIGNEDINT';
  package
    SOAP::WSDL::XSD::Typelib::Builtin::unsignedInt;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'none', cache => 1;
  use base qw(SOAP::WSDL::XSD::Typelib::Builtin::unsignedLong);
  
  1;
SOAP_WSDL_XSD_TYPELIB_BUILTIN_UNSIGNEDINT

$fatpacked{"SOAP/WSDL/XSD/Typelib/Builtin/unsignedLong.pm"} = <<'SOAP_WSDL_XSD_TYPELIB_BUILTIN_UNSIGNEDLONG';
  package
    SOAP::WSDL::XSD::Typelib::Builtin::unsignedLong;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'none', cache => 1;
  use base qw(SOAP::WSDL::XSD::Typelib::Builtin::nonNegativeInteger);
  
  1;
SOAP_WSDL_XSD_TYPELIB_BUILTIN_UNSIGNEDLONG

$fatpacked{"SOAP/WSDL/XSD/Typelib/Builtin/unsignedShort.pm"} = <<'SOAP_WSDL_XSD_TYPELIB_BUILTIN_UNSIGNEDSHORT';
  package
    SOAP::WSDL::XSD::Typelib::Builtin::unsignedShort;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'none', cache => 1;
  use base qw(SOAP::WSDL::XSD::Typelib::Builtin::unsignedInt);
  
  1;
SOAP_WSDL_XSD_TYPELIB_BUILTIN_UNSIGNEDSHORT

$fatpacked{"SOAP/WSDL/XSD/Typelib/ComplexType.pm"} = <<'SOAP_WSDL_XSD_TYPELIB_COMPLEXTYPE';
  #!/usr/bin/perl
  package
    SOAP::WSDL::XSD::Typelib::ComplexType;
  use strict;
  use warnings;
  use Carp;
  use SOAP::WSDL::XSD::Typelib::Builtin;
  use Scalar::Util qw(blessed);
  use Data::Dumper;
  require Class::Std::Fast::Storable;
  
  use base qw(SOAP::WSDL::XSD::Typelib::Builtin::anyType);
  
  use version; our $VERSION = qv('2.00.99_3');
  
  # remove in 2.1
  our $AS_HASH_REF_WITHOUT_ATTRIBUTES = 0;
  
  my %ELEMENT_FORM_QUALIFIED_OF;  # denotes whether elements are qualified
  my %ELEMENTS_FROM;      # order of elements in a class
  my %ATTRIBUTES_OF;      # references to value hashes
  my %CLASSES_OF;         # class names of elements in a class
  my %NAMES_OF;           # XML names of elements in a class
  
  
  # XML Attribute handling
  my %xml_attr_of     :ATTR();
  
  # Namespace handling
  my %xmlns_of        :ATTR();
  
  our $MAY_HAVE_CHILDREN = 1;
  
  # don't you ever dare to use this !
  our $___classes_of_ref = \%CLASSES_OF;
  our $___attributes_of_ref = \%ATTRIBUTES_OF;
  our $___xml_attribute_of_ref = \%xml_attr_of;
  
  # STORABLE_ methods for supporting Class::Std::Fast::Storable.
  # We could also handle them via AUTOMETHOD,
  # but AUTOMETHOD should always croak...
  # Actually, AUTOMETHOD is faster (~1%) if Class::Std::Fast is loaded
  # properly, and slower (~10%) if not.
  # Hmmm. Trade 1% for 10?
  
  my %STORABLE_METHODS = (
      STORABLE_freeze_pre => undef,
      STORABLE_freeze_post => undef,
      STORABLE_thaw_pre => undef,
      STORABLE_thaw_post => undef,
  );
  
  # for error reporting. Eases working with data objects...
  sub AUTOMETHOD {
      # return before unpacking @_ for speed reasons
      return if exists $STORABLE_METHODS{$_};
  
      my ($self, $ident, @args_from) = @_;
      my $class = ref $self || $self or die "Cannot call AUTOMETHOD as function";
  
      # Test whether we're called from ->can()
      my @caller = caller(1);
  
      # return if not called by AUTOLOAD - caller must be something like can()
      # Unfortunately we cannot test for "UNIVERSAL::can", as it gets overwritten
      # by both Class::Std and Class::Std::Fast, and we don't know the loading
      # order (Class::Std::Fast should be loaded before for maximum speedup)
      return if $caller[3] ne 'Class::Std::AUTOLOAD';
  
      confess "Can't locate object method \"$_\" via package \"$class\". \n"
          . "Valid methods are: "
          . join(', ', map { ("get_$_" , "set_$_") } keys %{ $ATTRIBUTES_OF{ $class } })
          . "\n"
  }
  
  sub attr {
      # We're working on @_ for speed.
      # Normally, the first line would look like this:
      # my $self = shift;
  
      my $class = $_[0]->__get_attr_class()
          or return;
  
      # pass arguments to attributes constructor (if any);
      # lets attr($foo) work as setter
      if ($_[1]) {
          return $xml_attr_of{ ${$_[0]} } = $class->new($_[1]);
      }
      return $xml_attr_of{ ${$_[0]} } if exists $xml_attr_of{ ${$_[0]} };
      return $xml_attr_of{ ${$_[0]} } = $class->new();
  }
  
  sub serialize_attr {
      return q{} if not $xml_attr_of{ ${ $_[0] } };
      return $xml_attr_of{ ${ $_[0] } }->serialize();
  }
  
  # TODO: are complextypes are always true ?
  sub as_bool :BOOLIFY { 1 }
  
  sub as_hash_ref {
      # we're working on $_[0] for speed (as always...)
      #
      # Normally the first line would read:
      # my ($self, $ignore_attributes) = @_;
      #
      my $attributes_ref = $ATTRIBUTES_OF{ ref $_[0] };
  
      my $hash_of_ref = {};
      if ($_[0]->isa('SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType')) {
          $hash_of_ref->{ value } = $_[0]->get_value();
      }
      else {
          foreach my $attribute (keys %{ $attributes_ref }) {
              next if not defined $attributes_ref->{ $attribute }->{ ${ $_[0] } };
              my $value = $attributes_ref->{ $attribute }->{ ${ $_[0] } };
  
              $hash_of_ref->{ $attribute } = blessed $value
                  ? $value->isa('SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType')
                      ? $value->get_value()
                      : $value->as_hash_ref($_[1])
                  : ref $value eq 'ARRAY'
                      ? [
                          map {
                              $_->isa('SOAP::WSDL::XSD::Typelib::Builtin::anySimpleType')
                                  ? $_->get_value()
                                  : $_->as_hash_ref($_[1])
                          } @{ $value }
                      ]
                      : die "Neither blessed obj nor list ref";
          };
      }
  
      # $AS_HASH_REF_WITHOUT_ATTRIBUTES is deprecated by NOW and will be removed
      # in 2.1
      return $hash_of_ref if $_[1] or $AS_HASH_REF_WITHOUT_ATTRIBUTES;
  
  
      if (exists $xml_attr_of{ ${ $_[0] } }) {
          $hash_of_ref->{ xmlattr } = $xml_attr_of{ ${ $_[0] } }->as_hash_ref();
      }
  
      return $hash_of_ref;
  }
  
  # we store per-class elements.
  # call as __PACKAGE__->_factory
  sub _factory {
      my $class = shift;
      $ELEMENTS_FROM{ $class }    = shift;
      $ATTRIBUTES_OF{ $class }    = shift;
      $CLASSES_OF{ $class }       = shift;
      $NAMES_OF{ $class }         = shift;
  
      no strict qw(refs);
      no warnings qw(redefine);
  
      while (my ($name, $attribute_ref) = each %{ $ATTRIBUTES_OF{ $class } } ) {
          my $type = $CLASSES_OF{ $class }->{ $name }
              or croak "No class given for $name";
  
          # require all types here
          $type->isa('UNIVERSAL')
              or eval "require $type"
                  or croak $@;
  
          # check now, so we don't need to do it later.
          # $is_list is used in the methods created. Filling it now means
          # we don't have to check it every time the method is called, but
          # can just use $is_list, which will hold the value assigned to
          # it when the method was created.
          my $is_list = $type->isa('SOAP::WSDL::XSD::Typelib::Builtin::list');
  
          # The set_$name method below looks rather weird,
          # but is optimized for performance.
          #
          #  We could use sub calls for sure, but these are much slower. And
          # the logic is not that easy:
          #
          #  we accept:
          #  a) objects
          #  b) scalars
          #  c) list refs
          #  d) hash refs
          #  e) mixed stuff of all of the above, so we have to set our child to
          #    a) value if it's an object
          #    b) New object of expected class with value for simple values
          #    c 1) New object with value for list values and list type
          #    c 2) List ref of new objects with value for list values and
          #         non-list type
          #    c + e 1) List ref of objects for list values (list of objects)
          #             and non-list type
          #    c + e 2) List ref of new objects for list values (list of hashes)
          #             and non-list type where the hash ref is passed to new as
          #             argument
          #    d) New object with values passed to new for HASH references
          #
          #  We throw an error on
          #  a) list refs of list refs - don't know what to do with this (maybe
          #     use for lists of list types ?)
          #  b) wrong object types
          #  c) non-blessed non-ARRAY/HASH references - if you can define semantics
          #     for GLOB or SCALAR references, feel free to add them.
          #  d) we should also die for non-blessed non-ARRAY/HASH references in
          #     lists but don't do yet - oh my !
  
          # keep in sync with Generator::Template::Plugin::XSD - maybe use
          # function to allow substituting via symbol table...
          my $method_name = $name;
          $method_name =~s{[\.\-]}{_}xmsg;
          *{ "$class\::set_$method_name" } = sub {
              if (not $#_) {
                  delete $attribute_ref->{ ${ $_[0] } };
                  return;
              };
              my $is_ref = ref $_[1];
              $attribute_ref->{ ${ $_[0] } } = ($is_ref)
                  ? ($is_ref eq 'ARRAY')
                      ? $is_list                             # remembered from outside closure
                          ? $type->new({ value => $_[1] })   # it's a list element - can take list ref as value
                          : [ map {                          # it's not a list element - set value to list of objects
                              ref $_
                                ? ref $_ eq 'HASH'
                                    ? $type->new($_)
                                    : ref $_ eq $type
                                        ? $_
                                        : croak "cannot use " . ref($_) . " reference as value for $name - $type required"
                                : $type->new({ value => $_ })
                              } @{ $_[1] }
                           ]
                      : $is_ref eq 'HASH'
                          ?  $type->new( $_[1] )
                          # neither ARRAY nor HASH - probably an object... -
                          # do we need to test for it being blessed?
                          :  blessed $_[1] && $_[1]->isa($type)              # of required type ?
                              ? $_[1]                         # use it
                              : die croak "cannot use $is_ref reference as value for $name - $type required"
  
                  # not $is_ref
                  : defined $_[1] ? $type->new({ value => $_[1] }) : () ;
              return;
          };
  
          *{ "$class\::add_$method_name" } = sub {
              warn "attempting to add empty value to " . ref $_[0]
                  if not defined $_[1];
  
              # first call
              # test for existance, not for definedness
              if (not exists $attribute_ref->{ ${ $_[0]} }) {
                  $attribute_ref->{ ${ $_[0]} } = $_[1];
                  return;
              }
  
              if (not ref $attribute_ref->{ ${ $_[0]} } eq 'ARRAY') {
                  # second call: listify previous value if it's no list and add current
                  $attribute_ref->{ ${ $_[0]} } = [  $attribute_ref->{ ${ $_[0]} }, $_[1] ];
                  return;
              }
  
              # second and following: add to list
              push @{ $attribute_ref->{ ${ $_[0]} } }, $_[1];
              return;
          };
      }
  
      # TODO Could be moved as normal method into base class, e.g. here.
      # Hmm. let's see...
      *{ "$class\::new" } = sub {
          # We're working on @_ for speed.
          # Normally, the first line would look like this:
          # my ($class, $args_of) = @_;
          #
          # The hanging side comment show you what would be there, then.
  
          # Read as:
          # my $self = bless \(my $o = Class::Std::Fast::ID()), $class;
          my $self = bless \(my $o = Class::Std::Fast::ID()), $_[0];
  
          # Set attributes if passed via { xmlattr => \%attributes }
          #
          # This works just because
          #    a) xmlattr cannot be used as valid XML identifier (it starts
          #       with "xml" which is banned by the XML schema standard)
          #    b) $o->attr($attribute_ref) passes $attribute_ref to the
          #       attribute object's constructor
          #    c) we are in the object's constructor here (which means that)
          #       no attributes object can have been legally constructed
          #       before.
          if (exists $_[1]->{xmlattr}) {                      # $args_of->{xmlattr}
              $self->attr(delete $_[1]->{xmlattr});
          }
  
          # iterate over keys of arguments
          # and call set appropriate field in clase
          map { ($ATTRIBUTES_OF{ $class }->{ $_ })
              ? do {
                  my $method = "set_$_";
  
                  # keep in sync with Generator::Template::Plugin::XSD - maybe use
                  # function to allow substituting via symbol table...
                  $method =~s{[\.\-]}{_}xmsg;
  
                  $self->$method( $_[1]->{ $_ } );               # ( $args_of->{ $_ } );
             }
             : $_ =~ m{ \A              # beginning of string
                        xmlns           # xmlns
                  }xms        # get_elements is inlined for performance.
                  ? ()
                  : do {
                       croak "unknown field $_ in $class. Valid fields are:\n"
                       . join(', ', @{ $ELEMENTS_FROM{ $class } }) . "\n"
                       . "Structure given:\n" . Dumper @_ };
          } keys %{ $_[1] };                                      # %$args_of;
          return $self;
      };
  
      # this _serialize method works fine for <all> and <sequence>
      # complextypes, as well as for <restriction><all> or
      # <restriction><sequence>, and attribute sets.
      #
      # But what about choice, extension ?
      #
      # Triggers XML attribute serialization if the options hash ref contains
      # a attr element with a true value.
      *{ "$class\::_serialize" } = sub {
          my $ident = ${ $_[0] };
          my $option_ref = $_[1];
          
          # return concatenated return value of serialize call of all
          # elements retrieved from get_elements expanding list refs.
          return \join q{} , map {
              my $element = $ATTRIBUTES_OF{ $class }->{ $_ }->{ $ident };
  
              # do we have some content
              if (defined $element) {
                  $element = [ $element ] if not ref $element eq 'ARRAY';
                  # from 2.00.09 on $NAMES_OF is filled - use || $_; for
                  # backward compatibility
                  my $name = $NAMES_OF{$class}->{$_} || $_;
  
                  # get element's class for comparing with elements
                  my $element_class = $CLASSES_OF{$class}->{$_};
  
                  my $target_namespace = $_[0]->get_xmlns();
                  map {
                      my %type_info = ($element_class ne ref $_)
                          ? (derived => 1)
                          : ();
  
                      # serialize element elements with their own serializer
                      # but name them like they're named here.
                      # TODO: check. element ref="" has a name???
                      if ( $_->isa( 'SOAP::WSDL::XSD::Typelib::Element' ) ) {
                              # serialize elements of different namespaces
                              # with namespace declaration
                              ($target_namespace ne $_->get_xmlns())
                                  ? $_->serialize({ name => $name, qualified => 1, %type_info })
                                  : $_->serialize({ name => $name
                                      , %type_info
                                  });
                      }
                      # serialize complextype elments (of other types) with their
                      # serializer, but add element tags around.
                      else {
                          # TODO: check whether we have to handle
                          # types from different namespaces special, too
                          if (!defined $ELEMENT_FORM_QUALIFIED_OF{ $class }
                              or $ELEMENT_FORM_QUALIFIED_OF{ $class }
                          ) {
                              # handle types from different namespaces
                              #
                              # serialize with last namespace put on stack
                              # if the last namespace is a change from the
                              # before-last
                              #
                              if (
                                  exists $option_ref->{ xmlns_stack } 
                                  && (scalar @{ $option_ref->{ xmlns_stack } } >= 2) 
                                  && ($option_ref->{ xmlns_stack }->[-1] ne $option_ref->{ xmlns_stack }->[-2])) {
                                  # warn "New namespace: ", $option_ref->{ xmlns_stack }->[-1]; 
                                  join q{}, $_->start_tag({ name => $name , 
                                      xmlns => $option_ref->{ xmlns_stack }->[-1], 
                                      %{ $option_ref }, %type_info })
                                      , $_->serialize({ %{ $option_ref }, %type_info })
                                      , $_->end_tag({ name => $name , %{ $option_ref } });
                              }
                              else {
                                  # hack to get UPS wsdl files working
                                  # the commom:Request element uses <Request> for all subtags
                                  # Andrew Baerg - Oct 6, 2010
                                  if ($name && $option_ref->{name}) {
                                    #warn "deleting option_ref->{name} for $name: [$option_ref->{name}]";
                                    delete $option_ref->{name};
                                  }
  
                                  join q{}, $_->start_tag({ name => $name , %{ $option_ref }, %type_info })
                                      , $_->serialize({ %{ $option_ref }, %type_info })
                                      , $_->end_tag({ name => $name , %{ $option_ref } });
                              }
                          }
                          else {
                              # in elementFormDefault="unqualified" mode,
                              # the serialize method has to set
                              # xmnlns="" on all elements inside a ComplexType
                              #
                              # Other serializers usually use prefixes 
                              # for "unqualified" and just omit all prefixes
                              # for inner elements 
                              
                              # check whether we "had" a xmlns around
                              my $set_xmlns = delete $option_ref->{xmlns};
                              
                              # serialize start tag with xmlns="" if out parent
                              # did not do that
                              join q{}, $_->start_tag({
                                      name => $name,
                                      %{ $option_ref },
                                      %type_info,
                                      (! defined $set_xmlns)
                                          ? (xmlns => "")
                                          : ()
                                  })
                                  # add xmlns = "" to child serialize options
                                  # to avoid putting xmlns="" everywhere
                                  , $_->serialize({ %{$option_ref}, xmlns => "" })
                                  , $_->end_tag({ name => $name , %{ $option_ref } });
                          }
                      }
                  } @{ $element }
              }
              else {
                   q{};
              }
          } (@{ $ELEMENTS_FROM{ $class } });
      };
  
      # put hidden complex serializer into class
      # ... but not for AttributeSet classes
      if ( ! $class->isa('SOAP::WSDL::XSD::Typelib::AttributeSet')) {
          *{ "$class\::serialize" } = \&__serialize_complex;
      };
  }
  
  sub _set_element_form_qualified {
      $ELEMENT_FORM_QUALIFIED_OF{ $_[0] } = $_[1];
  }
  
  # Just as fallback: return no attribute set class as default.
  # Subclasses may override
  sub __get_attr_class {};
  
  # hidden complex serializer
  sub __serialize_complex {
      # we work on @_ for performance.
      $_[1] ||= {};                                   # $option_ref
      
      push @{ $_[1]->{ xmlns_stack } }, $_[0]->get_xmlns();
      
      # get content first (pass by reference to avoid copying)
      my $content_ref = $_[0]->_serialize($_[1]);     # option_ref
  
      pop @{ $_[1]->{ xmlns_stack } };
  
      # do we have a empty element ?
      return $_[0]->start_tag({ %{ $_[1] }, empty => 1 })
          if not length ${ $content_ref };
  
      return join q{}, $_[0]->start_tag($_[1]), ${ $content_ref }, $_[0]->end_tag();
  }
  
  sub get_xmlns {
      return q{}
  }
  
  1;
  
  __END__
  
SOAP_WSDL_XSD_TYPELIB_COMPLEXTYPE

$fatpacked{"SOAP/WSDL/XSD/Typelib/Element.pm"} = <<'SOAP_WSDL_XSD_TYPELIB_ELEMENT';
  package
    SOAP::WSDL::XSD::Typelib::Element;
  use strict; use warnings;
  use Class::Std::Fast::Storable constructor => 'none';
  
  use version; our $VERSION = qv('2.00.99_3');
  
  my %NAME;
  my %NILLABLE;
  my %REF;
  my %MIN_OCCURS;
  my %MAX_OCCURS;
  
  # TODO replace by generated methods?
  #
  # Class data - remember, we're the base class for a class factory or for
  # generated code...
  # use BLOCK: for scoping
  BLOCK: {
      my %method_lookup = (
          _name => \%NAME,
          _nillable => \%NILLABLE,
          _ref => \%REF,
          _minOccurs => \%MIN_OCCURS,
          _maxOccurs => \%MAX_OCCURS,
      );
  
      # create getters / setters for all elements' class data
      no strict qw(refs);
      while (my ($name, $value) = each %method_lookup ) {
          *{ "__set$name" } = sub {
              @_ or die "Cannot call __set$name without parameter";
              my $class = ref $_[0] || $_[0];
              $value->{ $class } = $_[1];
          };
          *{ "__get$name" } = sub {
              @_ or die "Cannot call __set$name as function";
              my $class = ref $_[0] || $_[0];
              return $value->{ $class };
          };
      }
  };
  
  
  # use $_[0] and $_[1] for speed.
  
  sub start_tag {
      # my ($self, $opt, $value) = @_;
      my $ending = ($_[1]->{ empty }) ? '/>' : '>';
      my @attr_from = ();
  
      if ($_[1]->{ nil }) {
          return q{} if not $NILLABLE{ ref $_[0] };
          push @attr_from, q{ xsi:nil="true"};
          $ending = '/>';
      }
  
      # add xmlns if requested
      if (delete $_[1]->{qualified}) {
          push @attr_from, q{ xmlns="} . $_[0]->get_xmlns() . q{"};
      }
  
      # add xsi:type if requested
      if (delete $_[1]->{derived}) {
          push @attr_from, q{ xsi:type="} . $_[0]->get_xmltype() . q{"};
      }
  
      push @attr_from, $_[0]->serialize_attr();
  
      # do we need to check for name ? Element ref="" should have it's own
      # start_tag. If we don't need to check, we can speed things up
      return join q{}, "<$_[1]->{ name }" , @attr_from , $ending if $_[1]->{ name };
      return join q{}, "<$NAME{ ref $_[0]}" , @attr_from , $ending;
  }
  
  # use $_[0] and $_[1] for speed.
  #
  # read it as:
  #
  # my ($self, $opt)  = @_;
  # my $class = ref $self;
  # return "</$opt->{name}>" if $opt->{name};
  # return "</"$NAME{$class}>";
  #
  # do we need to check for name ? Element ref="" should have it's own
  # end_tag. If we don't need to check, we can speed things up by defining
  # end tag with () prototype - perl will inline it for us if we do...
  sub end_tag {
      return "</$_[1]->{name}>" if $_[1]->{name};
      return "</$NAME{ ref $_[0] }>";
  }
  
  1;
  

  
SOAP_WSDL_XSD_TYPELIB_ELEMENT

$fatpacked{"SOAP/WSDL/XSD/Typelib/SimpleType.pm"} = <<'SOAP_WSDL_XSD_TYPELIB_SIMPLETYPE';
  package
    SOAP::WSDL::XSD::Typelib::SimpleType;
  use strict; use warnings;
  use SOAP::WSDL::XSD::Typelib::Builtin;
  
  use version; our $VERSION = qv('2.00.99_3');
  
  package
    SOAP::WSDL::XSD::Typelib::SimpleType::restriction;
  use strict;
  use SOAP::WSDL::XSD::Typelib::Builtin;
  use base qw(SOAP::WSDL::XSD::Typelib::SimpleType);
  
  use version; our $VERSION = qv('2.00.99_3');
  
  1;
  __END__
  
  
SOAP_WSDL_XSD_TYPELIB_SIMPLETYPE

$fatpacked{"SOAP/WSDL/XSD/WhiteSpace.pm"} = <<'SOAP_WSDL_XSD_WHITESPACE';
  package
    SOAP::WSDL::XSD::WhiteSpace;
  use strict;
  use warnings;
  use Class::Std::Fast::Storable constructor => 'none';
  use base qw(SOAP::WSDL::Base);
  
  use version; our $VERSION = qv('2.00.99_3');
  
  #<pattern value="">
  
  # id provided by Base
  # name provided by Base
  # annotation provided by Base
  
  # may be defined as atomic simpleType
  my %value_of        :ATTR(:name<value> :default<()>);
  
  1;
SOAP_WSDL_XSD_WHITESPACE

s/^  //mg for values %fatpacked;

unshift @INC, sub {
  if (my $fat = $fatpacked{$_[1]}) {
    open my $fh, '<', \$fat
      or die "FatPacker error loading $_[1] (could be a perl installation issue?)";
    return $fh;
  }
  return
};

}

use SOAP::WSDL '2.00.99_3';

1;
