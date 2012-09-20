package Robot::Perl::Utils;

use strict;
use warnings;
use YAML qw/LoadFile/;
use Carp qw/croak/;

use parent qw/Robot::Perl/;

sub new {
    my ( $class, %opt ) = @_;

    if (!$opt{config}) {
        croak "you must provide a config/yaml file";
    }

    my $self = $class->SUPER::new;
    $self->{conf} = LoadFile( $opt{config} );

    return bless $self, $class;
}

sub easy_start {
    my $self = shift;
    $self->auto( $self->{conf}->{auto}->{state} );
    $self->reflect( port => $self->{conf}->{reflect}->{port}, bool => $self->{conf}->{reflect}->{state} );
}

sub drive {
    my $self = shift;
    $self->start_void( 'drive' );
        $self->motor( port  => $self->{conf}->{motor_port}->{0}, speed => $self->{conf}->{speed}->{forward} );
        $self->motor( port  => $self->{conf}->{motor_port}->{1}, speed => $self->{conf}->{speed}->{forward} );
    $self->end;
}

sub turn_left {
    my $self = shift;

    $self->start_void('turn_left');
        $self->motor( port  => $self->{conf}->{motor_port}->{0}, speed => $self->{conf}->{speed}->{reverse} );
        $self->motor( port  => $self->{conf}->{motor_port}->{1}, speed => $self->{conf}->{speed}->{forward} );
    $self->end;
}

sub halt {
    my $self = shift;
    $self->start_void( 'halt' );
        $self->motor( port => $self->{conf}->{motor_port}->{0}, speed => $self->{conf}->{speed}->{stopped} );
        $self->motor( port => $self->{conf}->{motor_port}->{1}, speed => $self->{conf}->{speed}->{stopped} );
    $self->end;
}

sub turn_right {
    my $self = shift;

    $self->start_void( 'turn_right' );
        $self->motor( port  => $self->{conf}->{motor_port}->{0}, speed => $self->{conf}->{speed}->{forward} );
        $self->motor( port  => $self->{conf}->{motor_port}->{1}, speed => $self->{conf}->{speed}->{reverse} );
    $self->end;
}

sub set_cont {
    my $self = shift;
    $self->start_void( 'cont' );
        $self->cont( port => $self->{conf}->{motor_port}->{0}, channel => $self->{conf}->{channel}->{2} );
        $self->cont( port => $self->{conf}->{motor_port}->{1}, channel => $self->{conf}->{channel}->{1} );
    $self->end;
}

sub basic_movements {
    my $self = shift;
    $self->drive;
    $self->turn_left;
    $self->turn_right;
    $self->halt;
    $self->set_cont;
}

1;
