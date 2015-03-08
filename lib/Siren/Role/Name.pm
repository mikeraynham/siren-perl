package Siren::Role::Name;

use strict;
use warnings;

use Moo::Role 2;
use namespace::clean;

has name => (
    is        => 'ro',
    required  => 1,
    predicate => 1,
);

1;
