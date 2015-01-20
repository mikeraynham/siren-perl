package Siren::Role::ToJSON;

use Moo::Role;
use Safe::Isa;
use Scalar::Util qw(reftype);

sub TO_JSON {
    my $thing = shift;
    my $ref   = reftype $thing;

    if (not $ref) {
        $thing;
    }
    elsif ($ref eq 'ARRAY') {
        [map TO_JSON($_), @$thing];
    }
    elsif ($ref eq 'HASH') {
        +{map {$_ => TO_JSON($thing->{$_})} keys %$thing}
    }
    else {
        $thing->$_can('as_string') ? $thing->as_string : $thing;
    }
}

1;
