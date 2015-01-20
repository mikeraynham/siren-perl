use strict;
use warnings FATAL => qw(all);

use Data::Dumper;
use Siren::Build qw(link);

my $events = Siren::Build->new(
    class      => 'level 1',
    properties => {
        property_1 => 'value 1',
        property_2 => 'value 2',
    },
    links => [
        link 'self', 'localhost',
        link 'bob', 'localhost',
    ],
);

print Dumper($events);
