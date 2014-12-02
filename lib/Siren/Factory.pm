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
    bless {}, $class;
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
    push @{$self->{actions}}, {@_};
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

    my %map = (
        class      => sub { Siren::Class->new( @{$_[0]} ) },
        properties => sub { Siren::Property->new( @{$_[0]} ) },
        actions    => sub { [map { Siren::Action->new(%$_) } @{$_[0]}] },
        links      => sub { [map { Siren::Link->new(%$_) } @{$_[0]}] },
    );
        
    my %args;

    for my $attr (keys %map) {
        next unless exists $self->{$attr} && @{$self->{$attr}};
        $args{$attr} = $map{$attr}->($self->{$attr});
    }

    Siren::Entity->new(%args);
}

1;
