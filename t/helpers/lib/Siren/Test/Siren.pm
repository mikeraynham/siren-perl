package Siren::Test::Siren;

use strict;
use warnings FATAL => qw(all);

use Moo 2;

extends 'Siren::Test';

use Siren::Entity;
use Siren::Entity::Link;
use Siren::Entity::Representation;
use Siren::Action;
use Siren::Action::Field;
use Siren::Link;

sub _ref                   { ["$_[1]"] }
sub _entity                { Siren::Entity->new(@_[1 .. $#_]) }
sub _entity_link           { Siren::Entity::Link->new(@_[1 .. $#_]) }
sub _entity_representation { Siren::Entity::Representation->new(@_[1 .. $#_]) }
sub _action                { Siren::Action->new(@_[1 .. $#_]) }
sub _action_field          { Siren::Action::Field->new(@_[1 .. $#_]) }
sub _link                  { Siren::Link->new(@_[1 .. $#_]) }

1;
