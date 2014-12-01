package Siren::Property;

use strict;
use warnings FATAL => qw(all);

use parent 'Siren';

sub new {
    my $class = shift;
    bless {@_}, $class;
}

1;
