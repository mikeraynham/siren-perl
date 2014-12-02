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
    );

my $entity = $factory->construct;

isa_ok($entity, 'Siren::Entity');

is_deeply(
    $entity->to_struct,
    {
        properties => {
            order_number => 42,
            item_count   => 3,
            status       => 'pending',
        },
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
        class => ['order'],
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
