use strict;
use warnings FATAL => qw(all);

use Test::More;
use Test::Warnings;
use Test::Fatal;

use Siren::Utils qw(
    _to_upper
    _to_lower
    _str_to_arrayref
    _str_to_uri
    _obj_to_arrayref
    _str
    _arrayref
    _hashref
    _obj_arrayref
    _valid_str
    _uri
);

my $foo = bless {}, 'Foo';
my $bar = bless {}, 'Bar';
my $str = 'x';
my $arf = [$str];
my $hrf = {$str => 1};

subtest 'coerce str to upper / lower case' => sub {

    is( _to_upper()->('upper'),
        'UPPER',
        'string coverted to upper case'
    );

    is( _to_lower()->('LOWER'),
        'lower',
        'string coverted to upper case'
    );
};

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

subtest 'coerce str_to_uri' => sub {

    my $uri = _str_to_uri()->('http://example.com');

    isa_ok($uri, 'URI');

    is(_str_to_uri()->($uri), $uri, 'existing URI objects not modified')
};


subtest 'coerce obj_to_arrayref' => sub {

    is_deeply(
        _obj_to_arrayref('Foo')->($foo),
        [$foo],
        'obj_to_arrayref returns an arrayref containing an object...'
    );

    is_deeply(
        _obj_to_arrayref('Foo')->([$foo]),
        [$foo],
        '...and it does the same when passed an arrayref...'
    );

    is_deeply(
        _obj_to_arrayref('Foo', 'Bar')->($bar),
        [$bar],
        '...it also allows multiple possible classes to be specified...'
    );

    is_deeply(
        _obj_to_arrayref('Bar')->($foo),
        $foo,
        '...but does not return an arrayref containing an incorrect object'
    );
};

subtest 'isa str' => sub {

    ok( _str('attr')->($str),
        'str okay when passed a string...'
    );

    like(
        exception { _str()->($foo) },
        qr/must be a string/,
        '...but it dies when passed an object'
    );
};

subtest 'isa arrayref' => sub {

    ok( _arrayref()->($arf),
        'arrayref okay when passed an arrayref...'
    );

    like(
        exception { _arrayref()->($foo) },
        qr/must be an arrayref/,
        '...but it dies when passed an object...'
    );

    like(
        exception { _arrayref()->($hrf) },
        qr/must be an arrayref/,
        '...or a hashref'
    );
};

subtest 'isa hashref' => sub {

    ok( _hashref()->($hrf),
        'hashref okay when passed a hashref...'
    );

    like(
        exception { _hashref()->($foo) },
        qr/must be a hashref/,
        '...but it dies when passed an object...'
    );

    like(
        exception { _hashref()->($arf) },
        qr/must be a hashref/,
        '...or an arrayref'
    );
};

subtest 'isa obj_arrayref' => sub {

    ok( _obj_arrayref('Foo')->([$foo, $foo]),
        'obj_arrayref okay when passed an arrayref of objects...'
    );

    ok( _obj_arrayref('Foo', 'Bar')->([$bar, $foo]),
        '...and when passed an arrayref of objects and a list of types...'
    );

    like(
        exception { _obj_arrayref('Foo')->([$foo, $bar]) },
        qr/must be an arrayref/,
        '...but it dies when passed an object of the wrong type...'
    );

    like(
        exception { _obj_arrayref('Foo')->($str) },
        qr/must be an arrayref/,
        '...or a string...'
    );

    like(
        exception { _obj_arrayref('Foo')->([]) },
        qr/must be an arrayref/,
        '...or an empty arrayref'
    );
};

subtest 'isa valid string' => sub {
    
    my @valid = qw(foo bar baz);

    for my $val (@valid) {
        ok(_valid_str(@valid)->($val), "$val is in validated list")
    }

    like(
        exception { _valid_str(@valid)->('qux') },
        qr/is not one of/,
        '...but qux is not'
    );
};

subtest 'isa URI instance' => sub {
    my $uri = bless {}, 'URI';

    ok( _uri()->($uri),
        'uri okay when passed a URI instance...'
    );

    like(
        exception { _uri()->($foo) },
        qr/must be a URI instance/,
        '...but it dies when passed an object of the wrong type...'
    );
};

done_testing;
