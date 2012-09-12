package Robot::Perl;

use strict;
use warnings;
use YAML qw/LoadFile/;

sub new {
    my ( $class, %opt ) = @_;
    my $self = {
        test => "cat"
    };
    return bless $self, $class;
};

sub yams {
    my ( $self, $val ) = @_;
    my $yaml = LoadFile('/home/jbert/dev/RobotPerl/Robot/Perl/data.yaml');
    return ("$yaml->{$val}\n");
}

=head1 NAME
WHOS
=cut

sub start_void {
    my ( $self, $name, @tasks ) = @_;
    return "void $name() {\n", @tasks, $self->end;
};

sub start_task {
    my ($self, @tasks) = @_;
    return "task main() {\n", @tasks, $self->end;
};

sub start_if {
    my ( $self, $cond, @tasks ) = @_;
    return "if ( $cond ) {\n", @tasks, $self->end;
};

sub start_for {
    my ( $self, %opt ) = @_;
    return "for (int i = $opt{init}; i < $opt{end}; i++) {\n";
}

sub end {
    my ( $self, %opt ) = @_;
    return "}\n";
};

sub var {
    my ( $self, %opt ) = @_;
    return "var $opt{name} = $opt{value};\n";
}

sub battery {
    my ( $self, %opt ) = @_;
    return "int $opt{name} = nImmediateBatteryLevel;\n";
}

sub cos {
    my ( $self, %opt ) = @_;
    return "cos($opt{radians});\n";
}

sub sin {
    my ( $self, %opt ) = @_;
    return "sin($opt{radians});\n";
}

sub tan {
    my ( $self, %opt ) = @_;
    return "tan($opt{radians});\n";
}

sub d_r {
    my ( $self, %opt ) = @_;
    return "degreesToRadians($opt{degrees});\n";
}

sub r_d {
    my ( $self, %opt ) = @_;
    return "radiansToDegrees($opt{radians});\n";
}

sub kill {
    my ( $self, %opt ) = @_;
    return "StopTask($opt{task});\n";
}

sub mute {
    my $self = shift;
    return "ClearSounds();\n";
}

sub sound {
    my ( $self, %opt ) = @_;
    return "PlayImmediateTone($opt{freq},$opt{dur});\n";
}

sub tone {
    my ( $self, %opt ) = @_;
    die "Must be 'buzz', 'beep', or 'click'" if $opt{tone} =! m/(buzz|beep|click)/;
    return "PlaySound($opt{tone});\n";
}

sub sound_power {
    my ( $self, %opt ) = @_;
    return "bPlaySounds = $opt{bool};\n";
}

sub start_while {
    my ( $self, $cond, @tasks ) = @_;
    return "while ($cond) {\n", @tasks, $self->end;
}

sub start_robot {
    my ( $self, @tasks ) = @_;
    foreach my $task (@tasks){
        print $task;
    }
}

sub if_sound {
    my ( $self, %opt ) = @_;
    return "if(bHasSoundDriver){\n";
}

sub if_active {
    my $self = shift;
    return "if(bVEXNETActive = true){\n";
}

sub pragma {
    my ( $self, %opt ) = @_;
    return "#pragma config(Sensor, $opt{in}, $opt{name}, sensor$opt{type});\n";
};

sub reflect {
    my ( $self, %opt ) = @_;
    return "bMotorReflected[$opt{port}] = $opt{bool};\n";
};

sub auto {
    my ( $self, $bool ) = @_;
    return "bVexAutonomousMode = $bool;\n";
};

sub motor {
    my ( $self, %opt ) = @_;
    return "motor[$opt{port}] = $opt{speed};\n";
};

sub speed_up {
    my ( $self, %opt ) = @_;
    return "motor[$opt{port}] += $opt{speed};\n";
}

sub clear_time {
    my ($self, $timer ) = @_;
    return "ClearTimer($timer);\n";
}

sub time_while {
    my ($self, %opt) = @_;
    return "while(Time1[$opt{timer}] <= $opt{stop}){\n";
}

sub wait {
    my ( $self, %opt ) = @_;
    return "wait1Msec($opt{dur});\n";
};

sub cont {
    my ( $self, %opt ) = @_;
    return "motor[$opt{port}] = vexRT[$opt{channel}];\n";
};

sub call {
    my ( $self, $call ) = @_;
    return "$call();\n";
};

1;
