package Siren::Role::Rel;

use Siren::Utils qw(
    _str_to_arrayref
    _arrayref
);

use Moo::Role;

has rel => (
    is        => 'ro',
    coerce    => _str_to_arrayref(),
    isa       => _arrayref(),
    required  => 1,
    predicate => 1,
);

1;
