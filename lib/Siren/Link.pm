package Siren::Link;

use strict;
use warnings;

use Siren::Utils qw(
    _str_to_arrayref
    _arrayref
);

use Moo 2;
use namespace::clean;

with 'Siren::Role::ToJSON';
with 'Siren::Role::HRef';
with 'Siren::Role::Title';
with 'Siren::Role::Type';

has rel => (
    is        => 'ro',
    coerce    => _str_to_arrayref(),
    isa       => _arrayref(),
    required  => 1,
    predicate => 1,
);

1;
