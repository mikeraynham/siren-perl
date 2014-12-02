package Siren::Utils;

use strict;
use warnings FATAL => qw(all);

use Carp ();
use Exporter qw(import);
use Safe::Isa;

our @EXPORT_OK = qw(
    _str_to_arrayref
    _obj_to_arrayref
    _str
    _arrayref
    _hashref
    _obj_arrayref
);

sub _str_to_arrayref {
    sub { ref($_[0]) eq '' ? [$_[0]] : $_[0] };
}

sub _obj_to_arrayref {
    my ($class) = @_;
    sub { $_[0]->$_isa($class) ? [$_[0]] : $_[0] };
}

sub _str {
    my ($attr) = @_;
    sub { ref($_[0]) eq '' or Carp::confess "$attr must be a string" };
}

sub _arrayref {
    my ($attr) = @_;
    sub { ref($_[0]) eq 'ARRAY' or Carp::confess "$attr must be an arrayref" };
}

sub _hashref {
    my ($attr) = @_;
    sub { ref($_[0]) eq 'HASH' or Carp::confess "$attr must be a hashref" };
}

sub _obj_arrayref {
    my ($attr, $class) = @_;
    my $msg = "$attr must be an arrayref of $class objects";
    sub {
        ref($_[0]) eq 'ARRAY' or Carp::confess $msg;
        @{$_[0]} > 0          or Carp::confess $msg;
        $_->$_isa($class)     or Carp::confess $msg for @{$_[0]};
        return 1;
    };
}

1;
