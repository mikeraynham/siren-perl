package Siren::Utils;

use strict;
use warnings FATAL => qw(all);

use Carp ();
use Exporter qw(import);
use List::Util 1.33 qw(any);
use Safe::Isa;
use URI;

our @EXPORT_OK = qw(
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

my $_is_any = sub {
    my $obj = shift;
    $obj->$_call_if_object(isa => $_) && return $obj for @_;
};

sub _to_upper {
    sub { defined $_[0] && ref $_[0] eq '' ? uc $_[0] : $_[0] }
}

sub _to_lower {
    sub { defined $_[0] && ref $_[0] eq '' ? lc $_[0] : $_[0] }
}

sub _str_to_arrayref {
    sub { defined $_[0] && ref($_[0]) eq '' ? [$_[0]] : $_[0] };
}

sub _str_to_uri {
    sub { $_[0]->$_isa('URI') ? $_[0] : URI->new($_[0]) };
}

sub _obj_to_arrayref {
    my @classes = @_;
    sub { $_[0]->$_is_any(@classes) ? [$_[0]] : $_[0] };
}

sub _str {
    sub {
        defined $_[0] && ref($_[0]) eq ''
            or Carp::confess 'must be a string';
    };
}

sub _arrayref {
    sub {
        defined $_[0] && ref($_[0]) eq 'ARRAY'
            or Carp::confess 'must be an arrayref';
    };
}

sub _hashref {
    sub {
        defined $_[0] && ref($_[0]) eq 'HASH'
            or Carp::confess 'must be a hashref';
    };
}

sub _obj_arrayref {
    my @classes = @_;
    my $msg = sprintf
        "must be an arrayref of %s objects",
        join(' or ', @classes);

    sub {
        defined $_[0]          or Carp::confess $msg;
        ref($_[0]) eq 'ARRAY'  or Carp::confess $msg;
        @{$_[0]} > 0           or Carp::confess $msg;
        $_->$_is_any(@classes) or Carp::confess $msg for @{$_[0]};
        return 1;
    };
}

sub _valid_str {
    my @valid = @_;
    sub {
        any { defined $_[0] && ref($_[0]) eq '' && $_[0] eq $_ } @valid
            or Carp::confess 'is not one of: ' . join(', ', @valid);
    };
}

sub _uri {
    sub { $_[0]->$_isa('URI') or Carp::confess 'must be a URI instance' };
}

1;
