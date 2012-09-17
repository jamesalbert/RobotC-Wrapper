#!/usr/bin/perl -w

use strict;
use Robot::Perl::Lead;

my $SV = "SensorValue";

my $r = Robot::Perl::Lead->new;

$r->start_robot((
    $r->pragma( in => "in2", name => "button", type => "Touch"),
    $r->auto( "false" ),
    $r->reflect( port => "port3", bool => "true" ),
    $r->start_void( "cont", (
        $r->var( type => 1, name => "M_1", value => "motor[port1]"),
        $r->cont( port => "port2", channel => "Ch3"),
        $r->cont( port => "port3", channel => "Ch2"),
        $r->cont( port => "port4", channel => "Ch4"),
        $r->start_if( "M_1 > 0", (
            $r->motor( port => "port3", speed => "M_1"),
            $r->motor( port => "port2", speed => "-(M_1)")
        )),
        $r->start_if( "M_1 < 0", (
            $r->motor( port => "port2", speed => "M_1"),
            $r->motor( port => "port3", speed => "-(M_1)")
        ))
    )),
    $r->start_task((
        $r->start_while( "true", (
            $r->call( "cont" ),
            $r->start_if( "$SV(button) == 1", (
                $r->call( "halt" ),
                $r->call( "wait_5" )
            ))
        ))
    ))
));
