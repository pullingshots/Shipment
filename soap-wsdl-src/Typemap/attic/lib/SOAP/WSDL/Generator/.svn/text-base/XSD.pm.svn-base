package SOAP::WSDL::Generator::XSD;
use strict;
use warnings;
use Class::Std::Storable;
use Data::Dumper;
use File::Path qw(mkpath);
use File::Basename;

use SOAP::WSDL::Generator::Visitor::Typemap;
use SOAP::WSDL::Generator::Visitor::Code;

use SOAP::WSDL::Generator::Iterator::Code;

my %definitions_of      :ATTR(:name<definitions>    :default<()>);
my %typemap_prefix_of   :ATTR(:name<typemap_prefix> :default<()>);
my %type_prefix_of      :ATTR(:name<type_prefix>    :default<()>);
my %element_prefix_of   :ATTR(:name<element_prefix> :default<()>);
my %base_path_of        :ATTR(:name<base_path>      :default<.>);

sub START {
    my ($self, $ident, $arg_ref) = @_;   
    $typemap_prefix_of{ $ident } ||= 'MyTypemap::';
}

sub create_typemap {
    my ($self, $ident, $service, $fh) = ($_[0], ident $_[0], $_[1], $_[2]);
   
    my $visitor = SOAP::WSDL::Generator::Visitor::Typemap->new({
        type_prefix => $self->get_type_prefix(),
        element_prefix => $self->get_element_prefix(),
        definitions => $self->get_definitions(),
        typemap => {
            'Fault' => 'SOAP::WSDL::SOAP::Typelib::Fault11',
            'Fault/faultcode' => 'SOAP::WSDL::XSD::Typelib::Builtin::anyURI',
            'Fault/faultactor' => 'SOAP::WSDL::XSD::Typelib::Builtin::TOKEN',
            'Fault/faultstring' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
            'Fault/detail' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',           
        }
    });

    my $service_name = $service->get_name();
    $service_name =~s{\.}{\:\:}xmsg;
  
    # visit service with visitor
    $service->_accept( $visitor );

    my $typemap = Data::Dumper->new( [$visitor->get_typemap()] )
                    ->Purity(1)->Terse(1)->Indent(1)->Dump();
    
    my $source = qq{package $typemap_prefix_of{ $ident }$service_name;
use strict; use warnings;
my \$typemap = $typemap;

sub get_class { 
  my \$name = join '/', \@{ \$_[1] };
  exists \$typemap->{ \$name } or die "Cannot resolve \$name via " . __PACKAGE__;
  return \$typemap->{ \$name };
}

1;
};
    my $file_name = 
        "$base_path_of{ $ident }/$typemap_prefix_of{ $ident }$service_name.pm";
    $file_name =~s{::}{/}gms;

    return $self->_create_file($file_name, $source, $fh);
}

sub _create_file {
    my ($self, $file_name, $source, $fh) = @_;

    # make path (if does not exist);
    mkpath dirname $file_name;

    $fh || open( $fh, '>', $file_name ) or die "cannot open $file_name"; 
    # set file to UTF8 - may include unicode characters
    binmode $fh, ':utf8'    or die "cannot set utf8 mode on $file_name";
    print $fh $source       or die "cannot print to $file_name";
    close $fh               or die "cannot close $file_name";
    return $file_name;   
}

sub create_interface {
    my ($self, $service) = @_;
    
    my $visitor = SOAP::WSDL::Generator::Visitor::Code->new({
        definitions => $definitions_of{ ident $self }
    });
    my $iterator = SOAP::WSDL::Generator::Iterator::Code->new({
        visitor => $visitor,
    });
    $iterator->walk( $definitions_of{ ident $self } );
    
    $Data::Dumper::Terse = 1;
    while (my ($name, $value) = each %{ $visitor->get_class }) {
        print "            
package $name; 
use strict; use warnings;
use Class::Std::Storable;
use base qw(SOAP::WSDL::Client);

sub START {
    \$_[0]->set_proxy('$value->{location}') if not \$_[2]->{proxy};
    \$_[0]->set_class_resolver('$value->{class_resolver}')
        if not \$_[2]->{class_resolver};
}
";

       while (my ($operation, $info) = each %{ $value->{ operations }}) {
            print "
sub $operation {
    my (\$self, \$body, \$header) = \@_;
    # call SUPER to allow 'call' as method name
    return \$self->SUPER::call(" . Dumper($info) . "
    \$body, \$header);
}
";
        }
    
        print qq{
1;
__END__

=pod

=head1 NAME 

$name - SOAP Interface for $name

SOAP Interface class for the Webservice at $value->{location}. 


        };
    }
   
}



1;