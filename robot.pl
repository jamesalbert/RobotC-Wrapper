#!/usr/bin/perl

use strict;
use warnings;
use Robot::Perl::Utils;
use Robot::Perl;

our $VERSION = 1.00;

my $pre = Robot::Perl->new;

sub SETUP {
    my $pre = shift;
    $pre->pragma(
        in   => "in1",
        name => "button",
        type => "Touch"
    );
    $pre->pragma(
        in   => "in2",
        name => "eyes",
        type => "SONAR"
    );
};

sub BASIC_SETUP {
    my $r = shift;
    $r->basic_movements;
};

sub KLAW_KONT {
    my $r = shift;

    $r->start_void( "klaw_kont");
        $r->int_var(
            name  => "C_5",
            value => "vexRT[Ch5]"
        );
        $r->int_var(
            name  => "C_6",
            value => "vexRT[Ch6]"
        );
        $r->start_if( "C_5 == 127");
            $r->motor(
                port  => 3,
                speed => 40
            );
            $r->motor(
                port  => 4,
                speed => 40
            );
        $r->end;
        $r->start_else_if( "C_5 == -127" );
            $r->motor(
            port  => 3,
            speed => -40
            );
            $r->motor(
                port  => 4,
                speed => -40
            );
        $r->end;
    $r->end;
};

sub MAIN_TASK {
    my $r = shift;

    $r->start_task;
        $r->int_var(
        name => "SV",
        value => "SensorValue(button)"
        );
        $r->call( "drive" );
        $r->start_while( "true" );
            $r->start_if( "SV == 1" );
                $r->call( "turn_left" );
            $r->end;
        $r->end;
    $r->end;
};

SETUP( $pre );

my $r = Robot::Perl::Utils->new(
    config => "/home/jbert/dev/RobotPerl/Robot/Perl/data.yaml"
);

BASIC_SETUP( $r );
KLAW_KONT( $r );
MAIN_TASK( $r );
