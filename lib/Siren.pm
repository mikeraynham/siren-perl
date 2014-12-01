package Siren;

use strict;
use warnings FATAL => qw(all);

use Object::Tiny;

use JSON::XS qw(encode_json);
use Safe::Isa;
use Data::Rmap qw(rmap_to ARRAY HASH);
use Data::Dumper;

sub to_json {
    JSON::XS->new->convert_blessed->pretty->encode($_[0]->to_struct);
}

sub to_struct {
    my %struct = %{$_[0]};
    rmap_to {
        $_ = $_->to_struct if $_->$_can('to_struct');
    } ARRAY|HASH, \%struct;
    +{%struct};
}

1;
