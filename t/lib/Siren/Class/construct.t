use strict;
use warnings FATAL => qw(all);

use Test::More;
use Siren::Class;

my @args  = qw(items collection);
my $class = Siren::Class->new(@args);

is_deeply(
    $class->to_struct,
    [@args],
    'struct ok'
);

done_testing;
