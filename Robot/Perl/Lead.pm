package Robot::Perl::Lead;

use strict;
use warnings;
use YAML qw/LoadFile/;
use Carp qw/croak/;

use parent qw/Robot::Perl/;

#printf("Config file directory: ");

#my $input = <>;

#$input =~ s/\s//g if $input =~ m/\s/g;
#croak "Must specify a config file." if (!$input);

our $data = LoadFile('/home/jbert/dev/Robot/Perl/data.yaml');

sub new {
    my ( $class, %opt ) = @_;

    #if ( !$opt{config} ) {
    #    croak "you must specify a config file";
    #}

    #our $data = LoadFile('/home/jbert/dev/Robot/Perl/data.yaml');

    my $self = $class->SUPER::new(
        config => $opt{config}
    );

    return bless $self, $class;
}

sub easy_start {
    my ( $self, $port ) = @_;
    return $self->auto( "false" ),
    $self->reflect( port => $data->{port3}, bool => $data->{true} );
}

sub wait_5 {
    my ( $self ) = shift;
    return $self->start_void( 'wait_5', (
        $self->wait( dur => 5000 )
    ));
}

sub drive {
    my ( $self ) = shift;
    return $self->start_void( 'drive', (
        $self->motor( port  => $data->{port2}, speed => $data->{f_speed} ),
        $self->motor( port  => $data->{port3}, speed => $data->{f_speed} )
    ));
}

sub turn_left {
    my ( $self ) = shift;

    return $self->start_void('turn_left',(
        $self->motor( port  => $data->{port2}, speed => $data->{rf_speed} ),
        $self->motor( port  => $data->{port3}, speed => $data->{f_speed}  )
    ));
}

sub halt {
    my $self = shift;
    return $self->start_void( 'halt', (
        $self->motor( port => $data->{port2}, speed => $data->{stop} ),
        $self->motor( port => $data->{port3}, speed => $data->{stop} )
    ));
}

sub turn_right {
    my ( $self ) = shift;

    return $self->start_void( 'turn_right',(
        $self->motor( port  => $data->{port2}, speed => $data->{f_speed}  ),
        $self->motor( port  => $data->{port3}, speed => $data->{rf_speed} )
    ));
}

sub set_cont {
    my ( $self ) = shift;
    return $self->start_void( 'cont',(
        $self->cont( port => $data->{port2}, channel => $data->{ch3} ),
        $self->cont( port => $data->{port3}, channel => $data->{ch2} )
    ));
}

sub basic_movements {
    my ( $self ) = shift;
    return $self->drive,
    $self->turn_left,
    $self->turn_right,
    $self->halt,
    $self->wait_5,
    $self->set_cont;
}

1;
