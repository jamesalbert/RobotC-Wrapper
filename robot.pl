#!/usr/bin/perl

use strict;
use warnings;
use Robot::Perl::Utils;

my $r = Robot::Perl::Utils->new(
    config => "/home/jbert/dev/RobotPerl/Robot/Perl/data.yaml"
);

$r->basic_movements;
$r->start_task;
$r->call( "drive" );
$r->start_while( "true" );
$r->start_if( "true" );
$r->call( "turn_left" );
$r->end;
$r->end;
$r->end;
