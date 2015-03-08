package Siren::Entity;

use Siren::Utils qw(
    _hashref
    _obj_to_arrayref
    _obj_arrayref
);

use Moo 2;
use namespace::clean;

my @SubEntity = qw(
    Siren::Entity::Link
    Siren::Entity::Representation
);

with 'Siren::Role::ToJSON';
with 'Siren::Role::Class';

has properties => (
    is        => 'ro',
    isa       => _hashref(),
    predicate => 1,
);

has entities => (
    is        => 'ro',
    coerce    => _obj_to_arrayref(@SubEntity),
    isa       => _obj_arrayref(@SubEntity),
    predicate => 1,
);

has links => (
    is        => 'ro',
    coerce    => _obj_to_arrayref('Siren::Link'),
    isa       => _obj_arrayref('Siren::Link'),
    predicate => 1,
);

has actions => (
    is        => 'ro',
    coerce    => _obj_to_arrayref('Siren::Action'),
    isa       => _obj_arrayref('Siren::Action'),
    predicate => 1,
);

1;
