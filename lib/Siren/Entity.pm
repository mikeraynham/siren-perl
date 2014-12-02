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

1;
