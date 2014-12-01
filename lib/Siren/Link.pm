package Siren::Link;

use strict;
use warnings FATAL => qw(all);

use parent 'Siren';

use Object::Tiny qw(
    rel
    href
    title
    type
);

sub to_struct {
    my $self = shift;
    my $rel  = ref $self->rel eq 'ARRAY' ? $self->rel : [$self->rel];
    my %args = (
        rel => $rel,
        href => $self->href,
    );

    $args{title} = $self->title if $self->title;
    $args{type} = $self->type   if $self->type;

    +{%args};
}

1;
