package Siren::Entity::Link;

use Moo;
use namespace::clean;

extends 'Siren::Entity';

with 'Siren::Role::Rel';
with 'Siren::Role::HRef';
with 'Siren::Role::Type';

1;
