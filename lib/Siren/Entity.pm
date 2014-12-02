package Siren::Entity;

use strict;
use warnings FATAL => qw(all);

use Moo;
use Siren::Utils qw(
    _str_to_arrayref
    _obj_to_arrayref
    _str
    _arrayref
    _hashref
    _obj_arrayref
);

extends 'Siren';

has class => (
    is     => 'ro',
    coerce => _str_to_arrayref(),
    isa    => _arrayref('class'),
);

has properties => (
    is     => 'ro',
    isa    => _hashref('properties'),
);

has entities => (
    is     => 'ro',
    coerce => _obj_to_arrayref('Siren::SubEntity'),
    isa    => _obj_arrayref('entities', 'Siren::SubEntity'),
);

has links => (
    is     => 'ro',
    coerce => _obj_to_arrayref('Siren::Link'),
    isa    => _obj_arrayref('links', 'Siren::Link'),

);

has actions => (
    is     => 'ro',
    coerce => _obj_to_arrayref('Siren::Action'),
    isa    => _obj_arrayref('actions', 'Siren::Action'),
);

has title => (
    is     => 'ro',
);

1;
