package Siren::Role::Class;

use strict;
use warnings;

use Siren::Utils qw(
    _str_to_arrayref
    _arrayref
);

use Moo::Role 2;
use namespace::clean;

has class => (
    is        => 'ro',
    coerce    => _str_to_arrayref(),
    isa       => _arrayref(),
    predicate => 1,
);

1;
