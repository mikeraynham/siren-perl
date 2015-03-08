package Siren::Entity::Link;

use strict;
use warnings;

use Moo 2;
use namespace::clean;

with 'Siren::Role::ToJSON';
with 'Siren::Role::Class';
with 'Siren::Role::Rel';
with 'Siren::Role::HRef';
with 'Siren::Role::Type';

1;
