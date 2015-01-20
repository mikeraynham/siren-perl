package Siren::Role::Title;

use Moo::Role;

has title => (
    is        => 'ro',
    predicate => 1,
);

1;
