package Siren::Entity::Link;

use Moo;
use namespace::clean;

with 'Siren::Role::ToJSON';
with 'Siren::Role::Class';
with 'Siren::Role::Rel';
with 'Siren::Role::HRef';
with 'Siren::Role::Type';

1;
