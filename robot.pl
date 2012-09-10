#!/usr/bin/perl

use strict;
use warnings;
use YAML qw/LoadFile/;
use Robot::Perl::Lead;

my $SV = "SensorValue";

my $r = Robot::Perl::Lead->new(
    config  => "/Robot/Perl/data.yaml",
);

$r->start_robot((
    $r->pragma( in => "in2", name => "button", type => "Touch"),
    $r->easy_start( "port2" ),
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
