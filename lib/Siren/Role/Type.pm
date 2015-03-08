package Siren::Role::Type;

use strict;
use warnings;

use Moo::Role 2;
use namespace::clean;

has 'type' => (
    is        => 'ro',
    predicate => 1,
);

1;
