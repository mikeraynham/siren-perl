package Siren::Role::Rel;

use strict;
use warnings;

use Siren::Utils qw(
    _str_to_arrayref
    _arrayref
);

use Moo::Role 2;
use namespace::clean;

has rel => (
    is        => 'ro',
    coerce    => _str_to_arrayref(),
    isa       => _arrayref(),
    required  => 1,
    predicate => 1,
);

1;
