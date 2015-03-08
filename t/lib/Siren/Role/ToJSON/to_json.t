use strict;
use warnings FATAL => qw(all);

use Test::More;
use Test::Warnings;

use Siren::Entity;
use Siren::Entity::Link;
use Siren::Entity::Representation;
use Siren::Link;
use Siren::Action;
use Siren::Action::Field;

my $siren = Siren::Entity->new(
    class => 'entity_foo',
    properties => {
        foo => 'bar',
        bar => 'baz',
    },
    entities => [
        Siren::Entity::Representation->new(
            class => ['entity', 'representation'],
            rel   => 'items',
            properties => {
                foo => 'bar',
                bar => 'baz',
            },
            links => [
                Siren::Link->new(
                    rel => 'self',
                    href => 'http://localhost/self',
                    title => 'Self',
                ),
            ],
        ),
        Siren::Entity::Link->new(
            class => ['entity', 'link'],
            rel   => 'items',
            href  => 'http://localhost/items',
            type  => 'application/x-www-form-urlencoded',
        ),
    ],
    actions => [
        Siren::Action->new(
            name   => 'action_foo',
            title  => 'Action Foo',
            method => 'POST',
            href   => 'http://localhost/foo',
            type   => 'application/x-www-form-urlencoded',
            fields => [
                Siren::Action::Field->new(
                    name => 'field_foo',
                    type => 'hidden',
                    value => 'foo',
                ),
            ],
        ),
    ],
    links => [
        Siren::Link->new(
            rel => 'self',
            href => 'http://localhost/self',
            title => 'Self',
        ),
        Siren::Link->new(
            rel => 'prev',
            href => 'http://localhost/prev',
            title => 'Prev',
        ),
        Siren::Link->new(
            rel => 'next',
            href => 'http://localhost/next',
            title => 'Next',
        ),
    ],
);

is_deeply(
    $siren->TO_JSON,
    {
        class => ['entity_foo'],
        properties => {
            foo => 'bar',
            bar => 'baz',
        },
        entities => [
            {
                class => ['entity', 'representation'],
                rel   => ['items'],
                properties => {
                    foo => 'bar',
                    bar => 'baz',
                },
                links => [{
                    rel => ['self'],
                    href => 'http://localhost/self',
                    title => 'Self',
                }],
            },
            {
                class => ['entity', 'link'],
                rel   => ['items'],
                href  => 'http://localhost/items',
                type  => 'application/x-www-form-urlencoded',
            }
        ],
        actions => [
            {
                name   => 'action_foo',
                title  => 'Action Foo',
                method => 'POST',
                href   => 'http://localhost/foo',
                type   => 'application/x-www-form-urlencoded',
                fields => [
                    {
                        name => 'field_foo',
                        type => 'hidden',
                        value => 'foo',
                    },
                ],
            },
        ],
        links => [
            {
                rel => ['self'],
                href => 'http://localhost/self',
                title => 'Self',
            },
            {
                rel => ['prev'],
                href => 'http://localhost/prev',
                title => 'Prev',
            },
            {
                rel => ['next'],
                href => 'http://localhost/next',
                title => 'Next',
            },
        ],
    },
    'struct ok'
);

done_testing;
