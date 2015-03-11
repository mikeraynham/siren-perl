use strict;
use warnings FATAL => qw(all);

use lib 't/helpers/lib';

use Test::More;
use Test::Warnings;
use List::Util 1.33 qw(pairs);

use Siren::Test::BuildArgs;
use Siren::Test::Siren;
use Siren::Test::TO_JSON;

use Siren::Builder;

my $test_buildargs = Siren::Test::BuildArgs->new;
my $test_siren     = Siren::Test::Siren->new;
my $test_to_json   = Siren::Test::TO_JSON->new;

my @tests = (
    entity_class_only                  => 'class only',
    entity_properties_only             => 'properties only',
    entity_top_level_sub_entities_only => 'top-level sub-entities only',
    entity_nested_sub_entities_only    => 'nested sub-entities only',
    entity_links_only                  => 'links only',
    entity_actions_only_no_fields      => 'actions only (no fields)',
    entity_actions_only_with_fields    => 'actions only (with fields)',
    entity_complete                    => 'all parameters',
);

for my $test (pairs @tests) {
    my ($method, $description) = @$test;

    my %builder_args = $test_buildargs->$method;
    my %siren_args   = $test_siren->$method;
    my %json_struct  = $test_to_json->$method;

    subtest "entity with $description" => sub {

        my $siren = Siren::Builder->new(%builder_args)->construct;

        is_deeply(
            $siren,
            Siren::Entity->new(%siren_args),
            'Builder produces correct Siren object...'
        );

        is_deeply(
            $siren->TO_JSON,
            {%json_struct},
            '...which converts to correct intermediate JSON structure'
        );

    };
}

done_testing;
