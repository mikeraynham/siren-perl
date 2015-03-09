use strict;
use warnings FATAL => qw(all);

use lib 't/helpers/lib';

use Test::More;
use Test::Warnings;

use Siren::Test::BuildArgs;
use Siren::Test::TO_JSON;

use Siren::Builder;

my $build_args = Siren::Test::BuildArgs->new;
my $to_json    = Siren::Test::TO_JSON->new;

my %args = (
    $build_args->complete_entity,
);

my $builder = Siren::Builder->new(%args);
my $entity  = $builder->construct;

isa_ok($entity, 'Siren::Entity');

use Data::Dumper; print Dumper($entity);

is_deeply(
    $entity->TO_JSON,
    {
        $to_json->complete_entity,
    },
    'entity struct is ok'
);

done_testing;
