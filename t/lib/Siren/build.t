use strict;
use warnings FATAL => qw(all);

use Test::More;
use Siren::Entity;
use Siren::Action;
use Siren::Action::Field;
use Siren::Link;

my $entity = Siren::Entity->new(
    class => 'order',
    properties => {
        order_number => 42,
        item_count   =>  3,
        status       => 'pending',
    },
    actions => [
        Siren::Action->new(
            name   => 'add-item',
            title  => 'Add Item',
            method => 'POST',
            href   => 'http://api.x.io/orders/42/items',
            type   => 'application/x-www-form-urlencoded',
            fields => [
                Siren::Action::Field->new(
                    name  => 'order_number',
                    title => 'Order Number',
                    type  => 'hidden',
                    value => 42,
                ),
                Siren::Action::Field->new(
                    name  => 'product_code',
                    type  => 'text',
                ),
                Siren::Action::Field->new(
                    name  => 'quantity',
                    type  => 'number',
                ),
            ],
        ),
    ],
    links => [
        Siren::Link->new(
            rel  => 'self',
            href => 'http://api.x.io/orders/42',
        ),
        Siren::Link->new(
            rel  => 'previous',
            href => 'http://api.x.io/orders/41',
        ),
        Siren::Link->new(
            rel  => 'next',
            href => 'http://api.x.io/orders/43',
        ),
    ],
);

pass();

done_testing;
