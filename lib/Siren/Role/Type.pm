package Siren::Role::Type;

use Moo::Role;

has 'type' => (
    is        => 'ro',
    predicate => 1,
);

1;
