use strict;
use warnings FATAL => qw(all);

use Test::More;
use Test::Warnings;

use URI;
use Siren::Link;

my $link = Siren::Link->new(
    rel   => 'self',
    href  => URI->new('http://localhost'),
    title => 'Link to self',
    type  => 'application/json',
);

is_deeply(
    $link->TO_JSON,
    {
        rel   => ['self'],
        href  => 'http://localhost',
        title => 'Link to self',
        type  => 'application/json',
    },
    'to_json okay',
);

done_testing;
