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
    isa    => _arrayref(),
);

has properties => (
    is     => 'ro',
    isa    => _hashref(),
);

has entities => (
    is     => 'ro',
    coerce => _obj_to_arrayref('Siren::SubEntity'),
    isa    => _obj_arrayref('Siren::SubEntity'),
);

has links => (
    is     => 'ro',
    coerce => _obj_to_arrayref('Siren::Link'),
    isa    => _obj_arrayref('Siren::Link'),

);

has actions => (
    is     => 'ro',
    coerce => _obj_to_arrayref('Siren::Action'),
    isa    => _obj_arrayref('Siren::Action'),
);

has title => (
    is     => 'ro',
);

1;
