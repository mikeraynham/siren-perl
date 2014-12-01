use strict;
use warnings FATAL => qw(all);

use Test::More;
use Siren::Property;

my %args = (
    order_number => 42, 
    item_count   => 3,
    status       => 'pending',
);

my $prop = Siren::Property->new(%args);

is_deeply(
    $prop->to_struct,
    {%args},
    'struct ok'
);


done_testing;
