
use strict;
use warnings;

use ExtUtils::MakeMaker 6.63;

my %WriteMakefileArgs = (
  'ABSTRACT' => 'A RobotC wrapper written for the Vex PIC',
  'AUTHOR' => 'James Albert',
  'BUILD_REQUIRES' => {},
  'CONFIGURE_REQUIRES' => {
    'ExtUtils::MakeMaker' => '6.63'
  },
  'DISTNAME' => 'Robot-Perl',
  'EXE_FILES' => [],
  'LICENSE' => 'perl',
  'NAME' => 'Robot::Perl',
  #'PREREQ_PM' => {
  #  'LWP::UserAgent' => '6.00',
  #  'URI::Escape' => '3.30'
  #},
  'VERSION' => '0.01',
  'test' => {
    'TESTS' => 't/*.t'
  }
);

WriteMakefile(%WriteMakefileArgs);
