#!/usr/bin/perl -w

use strict;
use Robot::Perl::Lead;

my $SV = "SensorValue";

my $r = Robot::Perl::Lead->new;

$r->start_robot((
    $r->pragma( in => "in2", name => "button", type => "Touch"),
    $r->auto( "false" ),
    $r->reflect( port => "port3", bool => "true" ),
    $r->basic_movements,
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
