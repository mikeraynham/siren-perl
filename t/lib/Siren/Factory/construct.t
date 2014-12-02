use strict;
use warnings FATAL => qw(all);

use Test::More;
use Siren::Factory;

my $factory = Siren::Factory
    ->new
    ->add_class('order')
    ->add_property(
        order_number => 42,
        item_count   =>  3,
        status       => 'pending',
    )
    ->add_action(
        name   => 'add-item',
        title  => 'Add Item',
        method => 'POST',
        href   => 'http://api.x.io/orders/42/items',
        type   => 'application/x-www-form-urlencoded',
    )
    ->add_action_field(
        name  => 'order_number',
        title => 'Order Number',
        type  => 'hidden',
        value => 42,
    )
    ->add_action_field(
        name  => 'product_code',
        type  => 'text',
    )
    ->add_action_field(
        name  => 'quantity',
        type  => 'number',
    )
    ->add_link(
        rel  => 'self',
        href => 'http://api.x.io/orders/42',
    )
    ->add_link(
        rel  => 'previous',
        href => 'http://api.x.io/orders/41',
    )
    ->add_link(
        rel  => 'next',
        href => 'http://api.x.io/orders/43',
    )
    ->add_sub_entity(
        Siren::Factory
            ->new
            ->add_class(qw(items collection))
            ->add_rel(qw(http://x.io/rels/order-items))
            ->add_href('http://api.x.io/orders/42/items'),

        Siren::Factory
            ->new
            ->add_class(qw(info customer))
            ->add_rel(qw(http://x.io/rels/customer))
            ->add_property(
                customer_id => 'pj123',
                name        => 'Peter Joseph',
            )
            ->add_link(
                rel  => 'self',
                href => 'http://api.x.io/customers/pj123',
            ),
    );

my $entity = $factory->construct;

isa_ok($entity, 'Siren::Entity');

is_deeply(
    $entity->to_struct,
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
                links => [
                    {
                        href => 'http://api.x.io/customers/pj123',
                        rel => ['self'],
                    },
                ],
                rel => ['http://x.io/rels/customer'],
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
