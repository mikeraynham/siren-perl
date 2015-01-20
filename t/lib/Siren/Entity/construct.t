use strict;
use warnings FATAL => qw(all);

use Test::More;
use Test::Warnings;
use Test::Fatal;

use Siren::Entity;
use Siren::Entity::Link;
use Siren::Link;
use Siren::Action;

isa_ok(
    Siren::Entity->new,
    'Siren::Entity'
);

subtest 'coercions' => sub {

    my %args = (
        class      => 'foo',
        title      => 'Foo',
        properties => {bar => 'baz'},
        entities   => Siren::Entity::Link->new(
            rel  => 'subentity',
            href => 'http://localhost',
        ),
        links => Siren::Link->new(
            rel  => 'item',
            href => 'http://localhost',
        ),
        actions => Siren::Action->new(
            name => 'foo',
            href => 'http://localhost',
        ),
    );

    my $entity = Siren::Entity->new(%args);

    for my $arg (qw(class entities links actions)) {

        is_deeply(
            $entity->$arg,
            [$args{$arg}],
            "$arg coerced to arrayref"
        );
    }
};

subtest 'constraints' => sub {

    my $foo = bless {}, 'Foo';

    like(
        exception { Siren::Entity->new(class => {}) },
        qr/must be an arrayref/,
        'exception thrown when class cannot be coerced into arrayref'
    );

    like(
        exception { Siren::Entity->new(properties => []) },
        qr/must be a hashref/,
        'exception thrown when properties is not a hashref'
    );

    my %class = (
        entities => 'Siren::SubEntity',
        links    => 'Siren::Link',
        actions  => 'Siren::Action',
    );

    for my $arg (sort keys %class) {
        my $class = $class{$arg};

        like(
            exception { Siren::Entity->new($arg => [$foo]) },
            qr/must be an arrayref/,
            "exception thrown when $arg is not a $class arrayref"
        );
    }

};

done_testing;
