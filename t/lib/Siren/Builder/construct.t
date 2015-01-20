use strict;
use warnings FATAL => qw(all);

use Test::More;
use Test::Warnings;

use Siren::Builder;

my %args = (
    class => 'order',
    properties => {
        order_number => 42,
        item_count   =>  3,
        status       => 'pending',
    },
    entities => [{
        class => [qw(items collection)],
        rel   => 'http://x.io/rels/order-items',
        href  => 'http://api.x.io/orders/42/items',
    }, {
        class => [qw(info customer)],
        rel   => 'http://x.io/rels/customer',
        properties => {
            customer_id => 'pj123',
            name        => 'Peter Joseph',
        },
        links => [{
            rel  => 'self',
            href => 'http://api.x.io/customers/pj123',
        }],
    }],
    actions => [{
        name   => 'add-item',
        title  => 'Add Item',
        method => 'POST',
        href   => 'http://api.x.io/orders/42/items',
        type   => 'application/x-www-form-urlencoded',
        fields => [{
            name  => 'order_number',
            title => 'Order Number',
            type  => 'hidden',
            value => 42,
        }, {
            name  => 'product_code',
            type  => 'text',
        }, {
            name  => 'quantity',
            type  => 'number',
        }],
    }],
    links => [{
        rel  => 'self',
        href => 'http://api.x.io/orders/42',
    }, {
        rel  => 'previous',
        href => 'http://api.x.io/orders/41',
    }, {
        rel  => 'next',
        href => 'http://api.x.io/orders/43',
    }],
);

my $builder = Siren::Builder->new(%args);
my $entity  = $builder->construct;

isa_ok($entity, 'Siren::Entity');

is_deeply(
    $entity->TO_JSON,
    {
        class => ['order'],
        properties => {
            order_number => 42,
            item_count   => 3,
            status       => 'pending',
        },
        entities => [
            {
                class => ['items', 'collection'],
                href  => 'http://api.x.io/orders/42/items',
                rel   => ['http://x.io/rels/order-items'],
            },
            {
                class => ['info', 'customer'],
                rel   => ['http://x.io/rels/customer'],
                links => [
                    {
                        href => 'http://api.x.io/customers/pj123',
                        rel => ['self'],
                    },
                ],
                properties => {
                    name => 'Peter Joseph',
                    customer_id => 'pj123'
                },
            },
        ],
        actions => [
            {
                name   => 'add-item',
                title  => 'Add Item',
                method => 'POST',
                href   => 'http://api.x.io/orders/42/items',
                type   => 'application/x-www-form-urlencoded',
                fields => [
                    {
                        type  => 'hidden',
                        value => 42,
                        title => 'Order Number',
                        name  => 'order_number'
                    },
                    {
                        name => 'product_code',
                        type => 'text'
                    },
                    {
                        name => 'quantity',
                        type => 'number'
                    },
                ],
            },
        ],
        links => [
            {
                rel  => ['self'],
                href => 'http://api.x.io/orders/42',
            },
            {
                rel  => ['previous'],
                href => 'http://api.x.io/orders/41'
            },
            {
                rel  => ['next'],
                href => 'http://api.x.io/orders/43',
            },
        ],
    },
    'entity struct is ok'
);

done_testing;
