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
    'entity with class only' => sub {
        class      => $_[0]->search_class,
    },
    'entity with properties only' => sub {
        properties => $_[0]->search_properties,
    },
    'entity with top-level sub-entities only' => sub {
        entities   => $_[0]->search_entities(0),
    },
    'entity with nested sub-entities only' => sub {
        entities   => $_[0]->search_entities(1),
    },
    'entity with links only' => sub {
        links      => $_[0]->search_links,
    },
    'entity with actions only (no action fields)' => sub {
        actions    => $_[0]->search_actions(0),
    },
    'entity with actions only (with action fields)' => sub {
        actions    => $_[0]->search_actions(1),
    },
    'complete entity' => sub {
        class      => $_[0]->search_class,
        properties => $_[0]->search_properties,
        entities   => $_[0]->search_entities(1),
        links      => $_[0]->search_links,
        actions    => $_[0]->search_actions(1),
    },
);

for my $test (pairs @tests) {
    my ($description, $monkey) = @$test;

    my %builder_args = $test_buildargs->$monkey;
    my %siren_args   = $test_siren->$monkey;
    my %json_struct  = $test_to_json->$monkey;

    subtest $description => sub {

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
