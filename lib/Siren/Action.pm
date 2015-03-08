package Siren::Action;

use strict;
use warnings;

use Siren::Utils qw(
    _to_upper
    _valid_str
    _obj_to_arrayref
    _obj_arrayref
);

use Moo 2;
use namespace::clean;

with 'Siren::Role::ToJSON';
with 'Siren::Role::Class';
with 'Siren::Role::HRef';
with 'Siren::Role::Name';
with 'Siren::Role::Title';
with 'Siren::Role::Type';

has method => (
    is       => 'ro',
    coerce   => _to_upper(),
    isa      => _valid_str(qw(
        OPTIONS
        GET
        HEAD
        POST
        PUT
        DELETE
        TRACE
        CONNECT
    )),
    default   => 'GET',
    predicate => 1,
);

has 'fields' => (
    is        => 'ro',
    coerce    => _obj_to_arrayref('Siren::Action::Field'),
    isa       => _obj_arrayref('Siren::Action::Field'),
    predicate => 1,
);

1;
