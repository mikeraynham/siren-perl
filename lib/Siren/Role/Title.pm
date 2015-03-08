package Siren::Role::Title;

use strict;
use warnings;

use Moo::Role 2;
use namespace::clean;

has title => (
    is        => 'ro',
    predicate => 1,
);

1;
