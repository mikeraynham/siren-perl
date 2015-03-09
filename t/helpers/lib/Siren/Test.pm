package Siren::Test;

use strict;
use warnings FATAL => qw(all);

use Moo 2;

sub _entity {
    my $self = shift;

    return {
        class      => $self->_ref('search'),
        properties => {
            date_from => 1425895200, 
            date_to   => 1425897000,
        },
        entities => [{
            class      => $self->_ref('customer'),
            rel        => $self->_ref('http://x.io/rel/customer'),
            properties => {
                customer_id        => 489, 
                customer_name      => "Double Decker Gift Stores, Ltd",
                credit_limit       => 43300, 
                contact_first_name => "Thomas", 
                contact_last_name  => "Smith",
            },
            entities => [{
                class => $self->_ref('order'),
                rel   => $self->_ref('http://x.io/order'),
                properties => {
                    order_id   => 10186, 
                    order_date => 1421149322, 
                    status     => "shipped",
                },
                entities => [{
                    class => $self->_ref('item'),
                    rel   => $self->_ref('http://x.io/rel/item'),
                    properties => {
                        price_each => 108.80, 
                        quantity   => 26,
                    },
                    entities => [{
                        class => $self->_ref('product'),
                        rel   => $self->_ref('http://x.io/rel/product'),
                        properties => {
                            product_code  => "S10_4757", 
                            product_name  => "1972 Alfa Romeo GTA", 
                            product_scale => 70,
                        },
                    }, {
                        class => $self->_ref('product_detail'),
                        rel   => $self->_ref('http://x.io/rel/product_detail'),
                        href  => 'http://api.x.io/product/S10_4757',
                    }],
                }, {
                    class => $self->_ref('item'),
                    rel   => $self->_ref('http://x.io/rel/item'),
                    properties => {
                        price_each => 137.19, 
                        quantity   => 32, 
                    },
                    entities => [{
                        class => $self->_ref('product'),
                        rel   => $self->_ref('http://x.io/rel/product'),
                        properties => {
                            product_code  => "S18_1662", 
                            product_name  => "1980s Black Hawk Helicopter", 
                            product_scale => 78,
                        },
                    }, {
                        class => $self->_ref('product_detail'),
                        rel   => $self->_ref('http://x.io/rel/product_detail'),
                        href  => 'http://api.x.io/product/S18_1662',
                }],
                }],
            }, {
                class => $self->_ref('order'),
                rel   => $self->_ref('http://x.io/order'),
                properties => {
                    order_id   => 10213, 
                    order_date => 1425130005, 
                    status     => "shipped",
                },
                entities => [{
                    class => $self->_ref('item'),
                    rel   => $self->_ref('http://x.io/rel/item'),
                    properties => {
                        price_each => 84.67,
                        quantity   => 38, 
                    },
                    entities => [{
                        class => $self->_ref('product'),
                        rel   => $self->_ref('http://x.io/rel/product'),
                        properties => {
                            product_code  => "S18_4409", 
                            product_name  => "1932 Alfa Romeo 8C2300 Spider Sport", 
                            product_scale => 78,
                        },
                    }, {
                        class => $self->_ref('product_detail'),
                        rel   => $self->_ref('http://x.io/rel/product_detail'),
                        href  => 'http://api.x.io/product/S18_4409',
                    }],
                }, {
                    class => $self->_ref('item'),
                    rel   => $self->_ref('http://x.io/rel/item'),
                    properties => {
                        price_each => 58.24,
                        quantity   => 25, 
                    },
                    entities => [{
                        class => $self->_ref('product'),
                        rel   => $self->_ref('http://x.io/rel/product'),
                        properties => {
                            product_code  => "S18_4933", 
                            product_name  => "1957 Ford Thunderbird", 
                            product_scale => 78,
                        },
                    }, {
                        class => $self->_ref('product_detail'),
                        rel   => $self->_ref('http://x.io/rel/product_detail'),
                        href  => 'http://api.x.io/product/S18_4933',
                    }],
                }],
            }],
        }, {
            class      => $self->_ref('customer'),
            rel        => $self->_ref('http://x.io/rel/customer'),
            properties => {
                customer_id        => 201, 
                customer_name      => "UK Collectables, Ltd.",
                credit_limit       => 92700, 
                contact_first_name => "Elizabeth", 
                contact_last_name  => "Devon",
            },
            entities => [{
                class => $self->_ref('order'),
                rel   => $self->_ref('http://x.io/order'),
                properties => {
                    order_id   => 10302, 
                    order_date => 1426177964, 
                    status     => "shipped",
                },
                entities => [{
                    class => $self->_ref('item'),
                    rel   => $self->_ref('http://x.io/rel/item'),
                    properties => {
                        price_each => 74.42, 
                        quantity   => 49,
                    },
                    entities => [{
                        class => $self->_ref('product'),
                        rel   => $self->_ref('http://x.io/rel/product'),
                        properties => {
                            product_code  => "S24_2766", 
                            product_name  => "1949 Jaguar XK 120", 
                            product_scale => 84,
                        },
                    }, {
                        class => $self->_ref('product_detail'),
                        rel   => $self->_ref('http://x.io/rel/product_detail'),
                        href  => 'http://api.x.io/product/S24_2766',
                    }],
                }],
            }],
        }],
        links => [{
            rel  => $self->_ref('self'),
            href => 'http://api.x.io/search/1425895200',
        }, {
            rel  => $self->_ref('previous'),
            href => 'http://api.x.io/search/1425893400',
        }, {
            rel  => $self->_ref('next'),
            href => 'http://api.x.io/search/1425897000',
        }],
        actions => [{
            name   => 'refine-search',
            title  => 'Refine search',
            method => 'POST',
            href   => 'http://api.x.io/search/',
            type   => 'application/x-www-form-urlencoded',
            fields => [{
                name  => 'start_date',
                title => 'Start date',
                type  => 'text',
                value => 1425895200,
            }, {
                name  => 'end_date',
                title => 'End date',
                type  => 'text',
                value => 1425896100,
            }],
        }],
    };
}

sub complete_entity {
    my $self   = shift;
    return %{ $self->_entity };
}

sub null_entity {
    {};
}

sub entity_class_only {
    my $self   = shift;
    my $entity = $self->_entity;

    return (class => $entity->{class});
}

sub entity_properties_only {
    my $self   = shift;
    my $entity = $self->_entity;

    return (properties => $entity->{properties});
}

sub entity_sub_entities {
    my $self   = shift;
    my $entity = $self->_entity;

    return (entities => $entity->{entities});
}

sub entity_first_sub_entity {
    my $self       = shift;
    my $entity     = $self->_entity;
    my $sub_entity = $entity->{entities}->[0];

    delete $sub_entity->{entities};
    return (entities => $sub_entity);
}

sub entity_top_level_sub_entities {
    my $self       = shift;
    my $entity     = $self->_entity;
    my $sub_entity = $entity->{entities};

    delete $sub_entity->[0]->{entities};
    delete $sub_entity->[1]->{entities};

    return (entities => $sub_entity);
}

sub entity_links_only {
    my $self   = shift;
    my $entity = $self->_entity;

    return (links => $entity->{links});
}

sub entity_actions_only {
    my $self   = shift;
    my $entity = $self->_entity;

    return (actions => $entity->{actions});
}

1;

