package Siren::Action::Field;

use strict;
use warnings;

use Siren::Utils qw(
    _to_lower
    _valid_str
);

use Moo 2;
use namespace::clean;

with 'Siren::Role::ToJSON';
with 'Siren::Role::Name';
with 'Siren::Role::Title';

has type => (
    is       => 'ro',
    coerce   => _to_lower(),
    default  => 'text',
    isa      => _valid_str(qw(
        hidden
        text
        search
        tel
        url
        email
        password
        datetime
        date
        month
        week
        time
        datetime-local
        number
        range
        color
        checkbox
        radio
        file
        image
        button
    )),
    predicate => 1,
);

has value => (
    is        => 'ro',
    predicate => 1,
);

1;
