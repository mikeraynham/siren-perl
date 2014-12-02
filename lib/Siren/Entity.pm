package Siren::Entity;

use strict;
use warnings FATAL => qw(all);

use parent 'Siren';

use Carp qw(confess);
use Safe::Isa;
use Object::Tiny qw(
    class
    properties
    entities
    links
    actions
    title
);

sub add_entity {
    my $self = shift;

    for my $entity (@_) {
        confess 'entity must be a Siren::Entity'
            unless $entity->$_isa('Siren::Entity');

        push @{$self->{entities}}, $entity;
    }

    return $self;
}

1;

