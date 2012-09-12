package Robot::Perl::Lead;

use strict;
use warnings;
use YAML qw/LoadFile/;
use Carp qw/croak/;

use parent qw/Robot::Perl/;

our $data = LoadFile('/home/jbert/dev/RobotPerl/Robot/Perl/data.yaml');

sub new {
    my ( $class, %opt ) = @_;
    my $self = {
        false => "false",
        true  => "true",
        port2 => "port2",
        port3 => "port3",
        fulls => 127,
        fullr => -127,
        stop  => 0,
        chan2 => "Ch2",
        chan3 => "Ch3"
    };

    return bless $self, $class;
}

sub easy_start {
    my ( $self, $port ) = @_;
    my $a = $self->SUPER::auto( "false" );
    my $r = $self->SUPER::reflect( port => "port3", bool => "true" );
    my $y = $self->SUPER::yams( "port2" );
    return $a, $r, $y;
}

sub wait_5 {
    my $self = shift;
    return $self->start_void( 'wait_5', (
        $self->wait( dur => 5000 )
    ));
}

sub drive {
    my $self = shift;
    return $self->start_void( 'drive', (
        $self->motor( port  => $self->{port2}, speed => $self->{fulls} ),
        $self->motor( port  => $self->{port3}, speed => $self->{fulls} )
    ));
}

sub turn_left {
    my $self = shift;

    return $self->start_void('turn_left',(
        $self->motor( port  => $self->{port2}, speed => $self->{fullr} ),
        $self->motor( port  => $self->{port3}, speed => $self->{fulls}  )
    ));
}

sub halt {
    my $self = shift;
    return $self->start_void( 'halt', (
        $self->motor( port => $self->{port2}, speed => $self->{stop} ),
        $self->motor( port => $self->{port3}, speed => $self->{stop} )
    ));
}

sub turn_right {
    my $self = shift;

    return $self->start_void( 'turn_right',(
        $self->motor( port  => $self->{port2}, speed => $self->{fulls}  ),
        $self->motor( port  => $self->{port3}, speed => $self->{fullr} )
    ));
}

sub set_cont {
    my $self = shift;
    return $self->start_void( 'cont',(
        $self->cont( port => $self->{port2}, channel => $self->{chan3} ),
        $self->cont( port => $self->{port3}, channel => $self->{chan2} )
    ));
}

sub basic_movements {
    my $self = shift;
    return $self->drive,
    $self->turn_left,
    $self->turn_right,
    $self->halt,
    $self->wait_5,
    $self->set_cont;
}

1;
