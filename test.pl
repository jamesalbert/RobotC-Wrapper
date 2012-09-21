#!/usr/bin/perl

use strict;
use warnings;
use Robot::Perl::Utils;

my $SV = "SensorValue";

my $r = Robot::Perl::Utils->new(
    config => '/home/jbert/dev/RobotPerl/Robot/Perl/data.yaml'
);

$r->pragma( in => "in2", name => "button", type => "Touch" );

$r->start_void( "Drive" );
$r->motor( port => 2, speed => 127 );
$r->motor( port => 3, speed => 127 );
$r->end;

$r->start_task;
$r->start_while( "1" );
$r->call( "Drive" );
$r->end;
$r->end;
