#!/usr/bin/perl -Tw

use strict;
use warnings;
use Test::More tests => 2;

BEGIN {
    use_ok('Robot::Perl');
    use_ok('Robot::Perl::Utils');
}

diag('Tests Completed.');
