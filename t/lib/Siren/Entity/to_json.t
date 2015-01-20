use strict;
use warnings FATAL => qw(all);

use Test::More;
use Test::Warnings;

use Siren::Entity;
use Siren::Link;
use Siren::Action;

my $entity = Siren::Entity->new(
    class => 'entity',
    properties => {
        property => 'value',
    },
    links => [
        Siren::Link->new(rel => 'self', href => 'http://localhost'),
        Siren::Link->new(rel => 'next', href => 'http://localhost/next'),
        Siren::Link->new(rel => 'prev', href => 'http://localhost/prev'),
    ],
    actions => [
        Siren::Action->new(name => 'foo', href => 'http::/localhost/foo'),
        Siren::Action->new(name => 'bar', href => 'http::/localhost/bar'),
    ],
);

is_deeply(
    $entity->TO_JSON,
    {
        class => ['entity'],
        properties => {property => 'value'},
        links      => [
            {rel => ['self'], href => 'http://localhost'},
            {rel => ['next'], href => 'http://localhost/next'},
            {rel => ['prev'], href => 'http://localhost/prev'},
        ],
        actions    => [
            {method => 'GET', href => 'http::/localhost/foo', name => 'foo'},
            {method => 'GET', href => 'http::/localhost/bar', name => 'bar'},
        ],
    },
    'struct ok'
);

done_testing;
