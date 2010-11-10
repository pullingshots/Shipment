package Typelib::Base;
use Class::Std::Fast::Storable;

sub mk_add_mutators {
    my $class = shift;
    my $attributes = shift;
    for my $method ( keys %{$ attributes }) {
       *{ "$class\::add_$method" } = sub {
           my ($self, $value) = @_;
           my $ident = ${ $self };
           
           # we're the first value
           return $attributes->{ $method }->{ $ident } = $value
                if not defined $attributes->{ $method }->{ $ident };

           # we're the second value
           return $attributes->{ $method }->{ $ident } = [
                $attributes->{ $method }->{ $ident }, $value ]
                    if not ref $attributes->{ $method }->{ $ident } eq 'ARRAY';

           # we're third or later
           push @{ $attributes->{ $method }->{ $ident } }, $value;
           return $attributes->{ $method }->{ $ident }; 
       } 
    }
}

1;