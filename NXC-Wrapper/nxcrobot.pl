#!/usr/bin/env perl

use strict;
use warnings;
use NXC::Wrapper;

sub FORWARD {
    my $r = shift;

    $r->start_void("forward");
        $r->forward(
            motors => "AC",
            speed  => 50
        );
    $r->end;
};

sub REVERSE {
    my $r = shift;

    $r->start_void("reverse");
        $r->reverse(
            motors => "AC",
            speed  => 50
        );
    $r->end;
};

sub TURN_LEFT {
    my ( $r, $dur ) = @_;

    $r->start_void("turn_left");
        $r->forward(
            motors => "A",
            speed  => 50
        );
        $r->reverse(
            motors => "C",
            speed  => 50
        );
        $r->wait($dur);
    $r->end;
};

sub TURN_RIGHT {
    my ( $r, $dur ) = @_;

    $r->start_void("turn_right");
        $r->reverse(
            motors => "A",
            speed  => 50
        );
        $r->forward(
            motors => "C",
            speed  => 50
        );
        $r->wait($dur);
    $r->end;
};

sub COLOR_SORT {
    my $r = shift;

    $r->start_void( "color_sort" );
        $r->start_if( "SENSOR_1 == 1" );
            $r->call( "reverse");
            $r->until( "SENSOR_1 == 0" );
            $r->call( "turn_left" );
            $r->call( "forward" );
        $r->end;
    $r->end;
};

sub MAIN_TASK {
    my $r = shift;

    $r->start_task;
        $r->call("forward");
        $r->touch_setup(1);
        $r->start_while( 1 );
            $r->call( "color_sort" );
            $r->end;
        $r->end;
    $r->end;
    return $r;
};

my $r = NXC::Wrapper->new;
FORWARD( $r );
REVERSE( $r );
TURN_LEFT( $r, 2 );
TURN_RIGHT( $r, 2 );
COLOR_SORT( $r );
MAIN_TASK( $r );
