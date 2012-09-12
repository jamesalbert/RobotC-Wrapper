#!/usr/bin/perl -w

use strict;
use Robot::Perl::Lead;

my $SV = "SensorValue";

my $r = Robot::Perl::Lead->new(
    config  => "/Robot/Perl/data.yaml",
);

my $bag = {};

bless($bag, 'Robot::Perl::Lead');

my $hat = Robot::Perl->new(
    config => "cat"
);

$bag->start_robot((
    $r->pragma( in => "in3", name => "button2", type => "Touch")
    )
);

sub hey_there {
    return "I dont know why i say hello\n";
}

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
