package SOAP::WSDL::Starter;
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
