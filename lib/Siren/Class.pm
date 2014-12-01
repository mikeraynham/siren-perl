package Siren::Class;

use strict;
use warnings FATAL => qw(all);

use parent 'Siren';

sub new {
    my $class = shift;
    bless [@_], $class;
}

sub to_struct {
    [@{$_[0]}];
}

1;
