package Siren::SubEntity;

use strict;
use warnings FATAL => qw(all);

use parent 'Siren::Entity';

use Carp qw(confess);
use Safe::Isa;
use Object::Tiny qw(
    rel
    href
    type
);

1;
