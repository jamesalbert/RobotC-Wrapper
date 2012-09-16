=pod

=head1 NAME

RobotPerl - An easy to read, fully functional RobotC for Vex wrapper.

=head1 Synopsis

#!/usr/bin/perl -w

use strict;
use Robot::Perl::Lead;

my $SV = "SensorValue";

my $r = Robot::Perl::Lead->new;

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

=head2 Description

=head1 Robot::Perl

The Robot::Perl base library has a series of functions that you can call which will spit out RobotC. Start by initiating it.

use Robot::Perl;

my $r = Robot::Perl->new;

=cut
