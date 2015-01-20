package Siren::Role::Class;

use Moo::Role;

use Siren::Utils qw(
    _str_to_arrayref
    _arrayref
);

has class => (
    is        => 'ro',
    coerce    => _str_to_arrayref(),
    isa       => _arrayref(),
    predicate => 1,
);

1;
