package Siren::Factory;

use strict;
use warnings FATAL => qw(all);

use Siren::Class;
use Siren::Property;
use Siren::Link;
use Siren::Action;
use Siren::Action::Field;
use Siren::Entity;

sub new {
    my $class = shift;
    bless {
        class      => [],
        properties => [],
        links      => [],
        actions    => [],
        entities   => [],
    }, $class;
}

sub add_class {
    my $self = shift;
    push @{$self->{class}}, @_;
    return $self;
}

sub add_property {
    my $self = shift;
    push @{$self->{properties}}, @_;
    return $self;
}

sub add_link {
    my $self = shift;
    push @{$self->{links}}, {@_};
    return $self;
}

sub add_action {
    my $self = shift;
    push @{$self->{actions}}, {action => {@_}, fields => []};
    return $self;
}

sub add_action_field {
    my $self = shift;
    my $action = @{$self->{actions}}[-1];
    push @{$action->{fields}}, {@_};
    return $self;
}

sub construct {
    my $self = shift;

}

1;
