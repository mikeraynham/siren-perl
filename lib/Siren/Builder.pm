package Siren::Builder;

use strict;
use warnings;

use List::Util 1.33 qw(pairs);

use Siren::Link;
use Siren::Action;
use Siren::Action::Field;
use Siren::Entity;
use Siren::Entity::Link;
use Siren::Entity::Representation;

sub new {
    my $class = shift;
    my %args  = @_;
    bless {%args}, $class;
}

sub construct {
    my $self = shift;
    my $entity_class = shift || 'Siren::Entity';

    my %map = (
        class      => sub { $_[0] },
        rel        => sub { $_[0] },
        href       => sub { $_[0] },
        properties => sub { $_[0] },
        links      => sub { [map { Siren::Link->new(%$_) } @{$_[0]}] },
        entities   => sub { [
            map {
                construct(
                    $_,
                    exists $_->{href}
                        ? 'Siren::Entity::Link'
                        : 'Siren::Entity::Representation',
                )
            } @{$_[0]}
        ] },
        actions => sub { [
            map {
                for my $field (@{$_->{fields}}) {
                    $field = Siren::Action::Field->new(%$field);
                }
                Siren::Action->new(%$_)
            } @{$_[0]}
        ] },
    );
        
    my %args;

    for my $attr (keys %map) {
        next unless exists $self->{$attr};
        $args{$attr} = $map{$attr}->($self->{$attr});
    }

    $entity_class->new(%args);
}

sub _flatten {
    map { ref($_) ? _flatten(@{$_}) : ($_) } @_;
}

1;
