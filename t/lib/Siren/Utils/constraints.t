use strict;
use warnings FATAL => qw(all);

use Test::More;
use Test::Fatal;

use Siren::Utils qw(
    _str_to_arrayref
    _obj_to_arrayref
    _str
    _arrayref
    _hashref
    _obj_arrayref
);

my $foo = bless {}, 'Foo';
my $bar = bless {}, 'Bar';
my $str = 'x';
my $arf = [$str];
my $hrf = {$str => 1};

subtest 'coerce str_to_arrayref' => sub {

    is_deeply(
        _str_to_arrayref()->($str),
        $arf,
        'str_to_arrayref returns an arrayref containing a string...'
    );

    is_deeply(
        _str_to_arrayref()->($foo),
        $foo,
        '...but does not return an arrayref containing an object'
    );
};

subtest 'coerce obj_to_arrayref' => sub {

    is_deeply(
        _obj_to_arrayref('Foo')->($foo),
        [$foo],
        'obj_to_arrayref returns an arrayref containing an object...'
    );

    is_deeply(
        _obj_to_arrayref('Bar')->($foo),
        $foo,
        '...but does not return an arrayref containing incorrect object'
    );
};

subtest 'isa str' => sub {

    ok( _str('attr')->($str),
        'str okay when passed a string...'
    );

    like(
        exception { _str('attr')->($foo) },
        qr/attr must be a string/,
        '...but it dies when passed an object'
    );
};

subtest 'isa arrayref' => sub {

    ok( _arrayref('attr')->($arf),
        'arrayref okay when passed an arrayref...'
    );

    like(
        exception { _arrayref('attr')->($foo) },
        qr/attr must be an arrayref/,
        '...but it dies when passed an object...'
    );

    like(
        exception { _arrayref('attr')->($hrf) },
        qr/attr must be an arrayref/,
        '...or a hashref'
    );
};

subtest 'isa hashref' => sub {

    ok( _hashref('attr')->($hrf),
        'hashref okay when passed a hashref...'
    );

    like(
        exception { _hashref('attr')->($foo) },
        qr/attr must be a hashref/,
        '...but it dies when passed an object...'
    );

    like(
        exception { _hashref('attr')->($arf) },
        qr/attr must be a hashref/,
        '...or an arrayref'
    );
};

subtest 'isa obj_arrayref' => sub {

    ok( _obj_arrayref('attr', 'Foo')->([$foo, $foo]),
        'obj_arrayref okay when passed an arrayref of objects...'
    );

    like(
        exception { _obj_arrayref('attr', 'Foo')->([$foo, $bar]) },
        qr/attr must be an arrayref/,
        '...but it dies when passed an object of the wrong type...'
    );

    like(
        exception { _obj_arrayref('attr', 'Foo')->($str) },
        qr/attr must be an arrayref/,
        '...or a string...'
    );

    like(
        exception { _obj_arrayref('attr', 'Foo')->([]) },
        qr/attr must be an arrayref/,
        '...or an empty arrayref'
    );

};

done_testing;
