use strict;
use warnings FATAL => qw(all);

use Test::More;
use Siren::Link;

my %args = (
    rel   => 'self',
    href  => 'http://api.x.io/orders/42',
    title => 'Link to self',
    type  => 'application/json',
);

my $link = Siren::Link->new(%args);

isa_ok($link->href, 'URI', 'href');

is_deeply(
    $link->TO_JSON,
    {%args, rel => ['self']},
    'struct ok'
);

done_testing;
