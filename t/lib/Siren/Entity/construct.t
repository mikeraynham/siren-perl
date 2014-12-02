use strict;
use warnings FATAL => qw(all);

use Test::More;
use Siren::Entity;

my $entity = Siren::Entity->new(class => 1);

isa_ok($entity, 'Siren::Entity');

done_testing;
