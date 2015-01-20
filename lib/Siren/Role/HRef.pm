package Siren::Role::HRef;

use Moo::Role;

use Siren::Utils qw(
    _str_to_uri
    _uri
);

has href => (
    is        => 'ro',
    coerce    => _str_to_uri(),
    isa       => _uri(),
    required  => 1,
    predicate => 1,
);

sub _href_canonical {
    $_[0]->href->as_string;
}

1;
