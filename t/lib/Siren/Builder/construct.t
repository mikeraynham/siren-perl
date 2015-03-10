use strict;
use warnings FATAL => qw(all);

use lib 't/helpers/lib';

use Test::More;
use Test::Warnings;

use Siren::Test::BuildArgs;
use Siren::Test::Siren;
use Siren::Test::TO_JSON;

use Siren::Builder;

my $test_args  = Siren::Test::BuildArgs->new;
my $test_siren = Siren::Test::Siren->new;
my $test_json  = Siren::Test::TO_JSON->new;

my @tests = qw(
    entity_null_entity
    entity_complete
    entity_class_only
    entity_properties_only
    entity_top_level_sub_entities_only
    entity_sub_entities_only
    entity_links_only
    entity_actions_only
);

for my $method (@tests) {
    my $description = $method;
    $description =~ s/^entity_//;
    $description =~ tr/_/ /;

    subtest $description => sub {
        my $siren = Siren::Builder->new($test_args->$method)->construct;

        is_deeply(
            $siren,
            {$test_siren->$method},
            "Siren object ok"
        );

        is_deeply(
            $siren->TO_JSON,
            {$test_json->$method},
            "Intermediate JSON structure ok"
        );
    };
}

done_testing;
