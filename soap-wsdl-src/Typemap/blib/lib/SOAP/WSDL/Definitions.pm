package SOAP::WSDL::Definitions;
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

