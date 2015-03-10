package Siren::Test;

use strict;
use warnings FATAL => qw(all);

use Moo 2;

sub _ref                   { $_[1] }
sub _entity                { +{@_[1 .. $#_]} }
sub _entity_link           { +{@_[1 .. $#_]} }
sub _entity_representation { +{@_[1 .. $#_]} }
sub _action                { +{@_[1 .. $#_]} }
sub _action_field          { +{@_[1 .. $#_]} }

sub _search_properties {
    return {
        date_from => 1425895200, 
        date_to   => 1425897000,
    };
}

sub _search_links {
    my $self = shift;

    return [
        $self->_entity_link(
            rel  => $self->_ref('self'),
            href => 'http://api.x.io/search/1425895200',
        ),
        $self->_entity_link(
            rel  => $self->_ref('previous'),
            href => 'http://api.x.io/search/1425893400',
        ),
        $self->_entity_link(
            rel  => $self->_ref('next'),
            href => 'http://api.x.io/search/1425897000',
        ),
    ];
}

sub _search_actions {
    my $self = shift;

    return [
        $self->_action(
            name   => 'refine-search',
            title  => 'Refine search',
            method => 'POST',
            href   => 'http://api.x.io/search/',
            type   => 'application/x-www-form-urlencoded',
            fields => [
                $self->_action_field(
                    name  => 'start_date',
                    title => 'Start date',
                    type  => 'text',
                    value => 1425895200,
                ),
                $self->_action_field(
                    name  => 'end_date',
                    title => 'End date',
                    type  => 'text',
                    value => 1425896100,
                ),
            ],
        ),
    ];
}

sub _customer_properties {
    my $self        = shift;
    my $customer_id = shift;

    my %customers = (
        489 => {
            customer_id        => 489, 
            customer_name      => "Double Decker Gift Stores, Ltd",
            credit_limit       => 43300, 
            contact_first_name => "Thomas", 
            contact_last_name  => "Smith",
        },
        201 => {
            customer_id        => 201, 
            customer_name      => "UK Collectables, Ltd.",
            credit_limit       => 92700, 
            contact_first_name => "Elizabeth", 
            contact_last_name  => "Devon",
        },
    );

    return $customers{$customer_id};
}

sub _order_item {
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

sub _order_entities {
    my $self     = shift;
    my $order_id = shift;

    my %orders = (
        10186 => {
            order_date => 1421149322, 
            status     => "shipped",
            products   => [
                {
                    product_code => 'S10_4757',
                    quantity     => 26,
                },
                {
                    product_code => 'S18_1662',
                    quantity     => 32,
                },
            ],
        },
        10213 => {
            order_date => 1425130005, 
            status     => "shipped",
            products   => [
                {
                    product_code => 'S18_4409',
                    quantity     => 38,
                },
                {
                    product_code => 'S18_4933',
                    quantity     => 25,
                },
            ],
        },
        10302 => {
            order_date => 1425130005, 
            status     => "shipped",
            products   => [
                {
                    product_code => 'S24_2766',
                    quantity     => 49,
                },
            ],
        },
    );

    my $order = $orders{$order_id};

    return $self->_entity_representation(
        class => $self->_ref('order'),
        rel   => $self->_ref('http://x.io/order'),
        properties => {
            order_id   => $order_id,
            order_date => $order->{order_date}, 
            status     => $order->{status},
        },
        entities => [
            map { $self->_order_item(%$_) } @{$order->{products}},
        ],
    );
}

sub _search_entities {
    my $self         = shift;
    my $sub_entities = shift;

    my @customers = (
        {
            class      => $self->_ref('customer'),
            rel        => $self->_ref('http://x.io/rel/customer'),
            properties => $self->_customer_properties(489),
        },
        {
            class      => $self->_ref('customer'),
            rel        => $self->_ref('http://x.io/rel/customer'),
            properties => $self->_customer_properties(201),
        },
    );

    if ($sub_entities) {
        $customers[0]->{entities} = [
            $self->_order_entities(10186),
            $self->_order_entities(10213),
        ];

        $customers[1]->{entities} = [
            $self->_order_entities(10302),
        ];
    }

    return [map { $self->_entity_representation(%$_) } @customers];
}

sub entity_null_entity {
    ();
}

sub entity_complete {
    my $self = shift;

    return (
        class      => $self->_ref('search'),
        properties => $self->_search_properties,
        entities   => $self->_search_entities,
        links      => $self->_search_links,
        actions    => $self->_search_actions,
    );
}

sub entity_class_only {
    my $self = shift;

    return (
        class => $self->_ref('search'),
    );
}

sub entity_properties_only {
    my $self = shift;

    return (
        properties => $self->_search_properties,
    );
}

sub entity_top_level_sub_entities_only {
    my $self = shift;

    return (
        entities => $self->_search_entities(0),
    );
}

sub entity_sub_entities_only {
    my $self = shift;

    return (
        entities => $self->_search_entities(1),
    );
}

sub entity_links_only {
    my $self = shift;

    return (
        links => $self->_search_links,
    );
}

sub entity_actions_only {
    my $self = shift;

    return (
        actions => $self->_search_actions,
    );
}

1;

