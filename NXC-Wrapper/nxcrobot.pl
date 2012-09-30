#!/usr/bin/env perl

use strict;
use warnings;
use NXC::Wrapper;

sub COLOR_SORT {
    my $r = shift;

    $r->start_void( "color_sort" );
        $r->start_if( "SENSOR_1 == 1" );
            $r->reverse(
                motors => "AC",
                speed  => 50
            );
            $r->wait(1);
        $r->end;
    $r->end;
};

sub MAIN_TASK {
    my $r = shift;

    $r->start_task;
        $r->touch_setup(1);
        $r->start_while( 1 );
            $r->call( "color_sort" );
            $r->end;
        $r->end;
    $r->end;
    return $r;
};

my $r = NXC::Wrapper->new;

COLOR_SORT( $r );
MAIN_TASK( $r );
