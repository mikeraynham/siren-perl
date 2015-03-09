package Siren::Test;

use strict;
use warnings FATAL => qw(all);

use Moo 2;

sub _ref                   { $_[1] }
sub _entity                { shift; +{@_} }
sub _entity_link           { shift; +{@_} }
sub _entity_representation { shift; +{@_} }
sub _action                { shift; +{@_} }
sub _action_field          { shift; +{@_} }

sub _item {
    my $self = shift;
    my %args = @_;

    my %products = (
        S10_4757 => {
            price_each => 108.80,
            name       => '1972 Alfa Romeo GTA',
            scale      => '1:10',
        },
        S18_1662 => {
            price_each => 137.19,
            name       => '1980s Black Hawk Helicopter',
            scale      => '1:18',
        },
        S18_4409 => {
            price_each => 84.67,
            name       => '1932 Alfa Romeo 8C2300 Spider',
            scale      => '1:18',
        },
        S18_4933 => {
            price_each => 58.24,
            name       => '1957 Ford Thunderbird',
            scale      => '1:18',
        },
        S24_2766 => {
            price_each => 74.42,
            name       => '1949 Jaguar XK 120',
            scale      => '1:24',
        },
    );

    my $quantity     = $args{quantity};
    my $product_code = $args{product_code};
    my $product      = $products{$product_code};

    return $self->_entity_representation(
        class => $self->_ref('item'),
        rel   => $self->_ref('http://x.io/rel/item'),
        properties => {
            price_each => $product->{price_each},
            quantity   => $quantity,
        },
        entities => [
            $self->_entity_representation(
                class => $self->_ref('product'),
                rel   => $self->_ref('http://x.io/rel/product'),
                properties => {
                    product_code  => $product_code,
                    product_name  => $product->{name},
                    product_scale => $product->{scale},
                },
            ),
            $self->_entity_link(
                class => $self->_ref('product_detail'),
                rel   => $self->_ref('http://x.io/rel/product_detail'),
                href  => "http://api.x.io/product/$product_code",
            ),
        ],
    );
}

sub _complete_entity {
    my $self = shift;

    return {
        class      => $self->_ref('search'),
        properties => {
            date_from => 1425895200, 
            date_to   => 1425897000,
        },
        entities => [
            {
                class      => $self->_ref('customer'),
                rel        => $self->_ref('http://x.io/rel/customer'),
                properties => {
                    customer_id        => 489, 
                    customer_name      => "Double Decker Gift Stores, Ltd",
                    credit_limit       => 43300, 
                    contact_first_name => "Thomas", 
                    contact_last_name  => "Smith",
                },
                entities => [
                    {
                        class => $self->_ref('order'),
                        rel   => $self->_ref('http://x.io/order'),
                        properties => {
                            order_id   => 10186, 
                            order_date => 1421149322, 
                            status     => "shipped",
                        },
                        entities => [
                            $self->_item(
                                product_code => 'S10_4757',
                                quantity     => 26,
                            ),
                            $self->_item(
                                product_code => 'S18_1662',
                                quantity     => 32,
                            ),
                        ],
                    },
                    {
                        class => $self->_ref('order'),
                        rel   => $self->_ref('http://x.io/order'),
                        properties => {
                            order_id   => 10213, 
                            order_date => 1425130005, 
                            status     => "shipped",
                        },
                        entities => [
                            $self->_item(
                                product_code => 'S18_4409',
                                quantity     => 38,
                            ),
                            $self->_item(
                                product_code => 'S18_4933',
                                quantity     => 25,
                            ),
                        ],
                    }
                ],
            },
            {
                class      => $self->_ref('customer'),
                rel        => $self->_ref('http://x.io/rel/customer'),
                properties => {
                    customer_id        => 201, 
                    customer_name      => "UK Collectables, Ltd.",
                    credit_limit       => 92700, 
                    contact_first_name => "Elizabeth", 
                    contact_last_name  => "Devon",
                },
                entities => [
                    {
                        class => $self->_ref('order'),
                        rel   => $self->_ref('http://x.io/order'),
                        properties => {
                            order_id   => 10302, 
                            order_date => 1426177964, 
                            status     => "shipped",
                        },
                        entities => [
                            $self->_item(
                                product_code => 'S24_2766',
                                quantity     => 49,
                            ),
                        ],
                    },
                ],
            },
        ],
        links => [
            {
                rel  => $self->_ref('self'),
                href => 'http://api.x.io/search/1425895200',
            }, {
                rel  => $self->_ref('previous'),
                href => 'http://api.x.io/search/1425893400',
            }, {
                rel  => $self->_ref('next'),
                href => 'http://api.x.io/search/1425897000',
            },
        ],
        actions => [
            {
                name   => 'refine-search',
                title  => 'Refine search',
                method => 'POST',
                href   => 'http://api.x.io/search/',
                type   => 'application/x-www-form-urlencoded',
                fields => [
                    {
                        name  => 'start_date',
                        title => 'Start date',
                        type  => 'text',
                        value => 1425895200,
                    },
                    {
                        name  => 'end_date',
                        title => 'End date',
                        type  => 'text',
                        value => 1425896100,
                    },
                ],
            }
        ],
    };
}

sub complete_entity {
    my $self   = shift;
    return %{ $self->_complete_entity };
}

sub null_entity {
    {};
}

sub entity_class_only {
    my $self   = shift;
    my $entity = $self->_complete_entity;

    return (class => $entity->{class});
}

sub entity_properties_only {
    my $self   = shift;
    my $entity = $self->_complete_entity;

    return (properties => $entity->{properties});
}

sub entity_sub_entities {
    my $self   = shift;
    my $entity = $self->_complete_entity;

    return (entities => $entity->{entities});
}

sub entity_first_sub_entity {
    my $self       = shift;
    my $entity     = $self->_complete_entity;
    my $sub_entity = $entity->{entities}->[0];

    delete $sub_entity->{entities};
    return (entities => $sub_entity);
}

sub entity_top_level_sub_entities {
    my $self       = shift;
    my $entity     = $self->_complete_entity;
    my $sub_entity = $entity->{entities};

    delete $sub_entity->[0]->{entities};
    delete $sub_entity->[1]->{entities};

    return (entities => $sub_entity);
}

sub entity_links_only {
    my $self   = shift;
    my $entity = $self->_complete_entity;

    return (links => $entity->{links});
}

sub entity_actions_only {
    my $self   = shift;
    my $entity = $self->_complete_entity;

    return (actions => $entity->{actions});
}

1;

