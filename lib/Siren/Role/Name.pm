package Siren::Role::Name;

use Moo::Role;

has name => (
    is        => 'ro',
    required  => 1,
    predicate => 1,
);

1;
