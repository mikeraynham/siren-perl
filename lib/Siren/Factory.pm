package Siren::Factory;

use strict;
use warnings FATAL => qw(all);

use Siren::Link;
use Siren::Action;
use Siren::Action::Field;
use Siren::Entity;
use Siren::SubEntity;

sub new {
    my $class = shift;
    bless {}, $class;
}

sub add_class {
    my $self = shift;
    push @{$self->{class}}, _flatten(@_);
    return $self;
}

sub add_rel {
    my $self = shift;
    push @{$self->{rel}}, _flatten(@_);
    return $self;
}

sub add_href {
    my $self = shift;
    $self->{href} = $_[0];
    return $self;
}
sub add_property {
    my $self = shift;
    my %args = @_;
    $self->{properties}->{$_} = $args{$_} for keys %args;
    return $self;
}

sub add_link {
    my $self = shift;
    my %args = @_;
    $args{rel} = [_flatten($args{rel})];
    push @{$self->{links}}, +{%args};
    return $self;
}

sub add_action {
    my $self = shift;
    my %args = @_;
    push @{$self->{actions}}, +{%args};
    return $self;
}

sub add_action_field {
    my $self = shift;
    my %args = @_;
    my $action = @{$self->{actions}}[-1];
    push @{$action->{fields}}, +{%args};
    return $self;
}

sub add_sub_entity {
    my $self = shift;
    push @{$self->{entities}}, @_;
    return $self;
}

sub construct {
    my $self = shift;
    my $entity_class = shift || 'Siren::Entity';

    my %map = (
        class      => sub { $_[0] },
        rel        => sub { $_[0] },
        href       => sub { $_[0] },
        properties => sub { $_[0] },
        actions    => sub { [
            map {
                for my $field (@{$_->{fields}}) {
                    $field = Siren::Action::Field->new(%$field);
                }
                Siren::Action->new(%$_)
            } @{$_[0]}
        ] },
        links      => sub { [map { Siren::Link->new(%$_) } @{$_[0]}] },
        entities   => sub { [map { construct($_, 'Siren::SubEntity') } @{$_[0]}] },
    );
        
    my %args;

    for my $attr (keys %map) {
        next unless exists $self->{$attr};
        $args{$attr} = $map{$attr}->($self->{$attr});
    }

    $entity_class->new(%args);
}

sub _flatten {
    map { ref($_) ? _flatten(@{$_}) : ($_) } @_;
}

1;
