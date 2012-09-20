#!/usr/bin/perl

use strict;
use warnings;
use Robot::Perl::Utils;

my $r = Robot::Perl::Utils->new(
    config => "/home/jbert/dev/RobotPerl/Robot/Perl/data.yaml"
);

$r->basic_movements;
