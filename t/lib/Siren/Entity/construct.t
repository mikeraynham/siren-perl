use strict;
use warnings FATAL => qw(all);

use Test::More;
use Siren::Entity;

my $entity1 = Siren::Entity->new(class => 1);
my $entity2 = Siren::Entity->new(class => 2);
my $entity3 = Siren::Entity->new(class => 3);

isa_ok($entity1, 'Siren::Entity');

$entity1->add_entity($entity2);
$entity2->add_entity($entity3);

is_deeply(
    $entity1->to_struct,
    {
        class => 1,
        entities => [{
            class => 2,
            entities => [{class => 3}],
        }],
    },
    'nested entities look ok'
);

done_testing;
