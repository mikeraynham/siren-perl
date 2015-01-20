use strict;
use warnings FATAL => qw(all);

use Test::More;
use Siren::Action;
use Siren::Action::Field;

my @fields = (
    Siren::Action::Field->new(
        name  => 'order_number',
        type  => 'hidden',
        value => 42,
    ),
    Siren::Action::Field->new(
        name => 'product_code',
        type => 'text',
    ),
    Siren::Action::Field->new(
        name => 'quantity',
        type => 'number',
    ),
);

my %args = (
    name   => 'add-item',
    title  => 'Add Item',
    method => 'POST',
    href   => 'http://api.x.io/orders/42/items',
    type   => 'application/x-www-form-urlencoded',
    fields => [@fields],
);

my $action = Siren::Action->new(%args);

is_deeply(
    $action->TO_JSON,
    {
        %args,
        fields => [{
            name  => 'order_number',
            type  => 'hidden',
            value => 42,
        }, {
            name => 'product_code',
            type => 'text',
        }, {
            name => 'quantity',
            type => 'number',
        }],
    },
    'struct ok'
);

done_testing;
