package Siren::Test::TO_JSON;

use strict;
use warnings FATAL => qw(all);

use Moo 2;

extends 'Siren::Test';

sub _ref { ["$_[1]"] }

1;
