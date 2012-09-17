package Robot::Perl;

use strict;
use warnings;
use Switch;
use YAML qw/LoadFile/;

sub new {
    my ( $class, %opt ) = @_;
    my $self = {};
    return bless $self, $class;
};

sub start_void {
    my ( $self, $name, @tasks ) = @_;
    die "Name must not be comprised of integers." if $name =~ m/\d+/;
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
    my ( $self, %opt, @tasks ) = @_;
    return "for (int i = $opt{init}; i < $opt{end}; i++) {\n", @tasks, $self->end;
}

sub end {
    my ( $self, %opt ) = @_;
    return "}\n";
};

sub var {
    my ( $self, %opt ) = @_;
    my $t;
    switch ($opt{type}) {
        case 1 {$t = "int"}
        case 2 {$t = "char"}
        case 3 {$t = "long"}
    };
    return "$t $opt{name} = $opt{value};\n";
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
    my ( $self, @tasks ) = @_;
    return "if(bHasSoundDriver){\n", @tasks, $self->end;
}

sub if_active {
    my ( $self, @tasks ) = @_;
    return "if(bVEXNETActive = true){\n", @tasks, $self->end;
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
    my $self = shift;
    return "ClearTimer(T1);\n";
}

sub time_while {
    my ($self, $end, @tasks) = @_;
    return "while(Time1[T1] <= $end){\n", @tasks, $self->end;
}

sub wait {
    my ( $self, $dur ) = @_;
    return "wait1Msec(", $dur, "000);\n";
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

__END__

=pod

=head1 NAME

RobotPerl - An easy to read, fully functional RobotC for Vex wrapper.

=head1 SYNOPSIS

    #!/usr/bin/perl -w

    use strict;
    use Robot::Perl::Lead;

    my $SV = "SensorValue";

    my $r = Robot::Perl::Lead->new;

    $r->start_robot((
        $r->pragma( in => "in2", name => "button", type => "Touch"),
        $r->easy_start( "port2" ),
        $r->basic_movements,
        $r->start_void( "turn_around", (
            $r->motor( port => "port2", speed => 127 ),
            $r->motor( port => "port3", speed => -127 )
            $r->wait(1);
        )),
        $r->start_task((
            $r->start_while( "true", (
                $r->call( "cont" ),
                $r->start_if( "$SV(button) == 1", (
                        $r->call( "halt" ),
                        $r->call( "wait_5" )
                ))
            ))
        ))
    ));

=head2 DESCRIPTION

=head1 ROBOT::PERL

    The Robot::Perl base library has a series of functions that you can call which will spit out RobotC.
    Start by initiating it.

    use Robot::Perl;

    my $r = Robot::Perl->new;

=head1 LIST OF FUNCTIONS

=head4 start_robot(@tasks)

    Should be called as the first function after Robot::Perl::Whatever->new. This function
    prints everything.

    $r->start_robot(( task_1, task_2, task_3 ));

    Remember that all functions, loops, and statements in RobotPerl take an array as the last
    parameter so don't forget to close the array and parameter parenthesis and separate each
    function with commas.

=head4 start_void($name, @tasks)

    Starts a void function. $name is the name of the function being declared, and @tasks
    is a list of functions to be executed once called.

=head4 start_task(@tasks)

    Starts the main task. This function must always be present in RobotPerl.

=head4 start_if($condition, @tasks)

    Starts an if statement. $condition is, of course, the condition, and @tasks work the
    same way as any other start_* function.

=head4 start_for(init => $init, end => $end, @tasks)

    Starts a for loop. Takes three arguments: an start value ( usually 0 ), an end value,
    and a list of functions to call when true.

=head4 start_while($condition, @tasks)

    Starts a while loop. Takes two arguments: the condition and a list of tasks to execute once true.

=head4 end()

    Prints a brace "}" and starts a newline.

=head4 var(type => $num, name => $name, value => $value)

    Declares a new variable, takes three arguments: a number symbolizing data
    type ( 1-3; 1 => int, 2 => char, 3 => long ), name, and value.

=head4 battery(name => $variable_name)

    Declares a variable containing the current battery level, takes the variable
    name as the only argument.

=head4 kill(task => $any_function)

    Kills the function specified as a parameter.

=head4 mute()

    Turns off all tones and sounds.

=head4 sound(freq => $frequency, dur => $duration)

    Plays a tone, takes two arguments: frequency, and duration.

=head4 tone(tone => "beep")

    Plays tone, takes one parameter: must be "buzz", "beep", or "click".

=head4 sound_power(bool => "true")

    Turns sound on and off, true or false as a parameter.

=head4 if_sound(@tasks)

    Starts an if statement with a predeclared condition (if sound is available),
    and takes one argument which is a list of tasks to execute once true.

=head4 if_active(@tasks)

    Does the same thing as if_sound, but checks for controller activity.
    Still takes a list of tasks.

=head4 pragma(in => "in2", name => $name, type => "Touch")

    Sets up sensors. Should be the first thing called after start_robot.
    Takes three parameters: in port, name, and sensor type ("Touch, SONAR, etc").

=head4 reflect(port => $port2, bool => "true")

    Reflects a designated port, takes two parameters: port name ( "port2", "port3", etc ), and boolean ( most likely true ).

=head4 auto(bool => "true")

    Toggles autonomous mode depending on the boolean parameter.

=head4 motor(port => $port2, speed => $speed)

    Sets motor value, takes two parameters: port name and speed ( -127 - 127 ).

=head4 speed_up(port => $port2, speed => $increment)

    Speeds up to motors, takes two arguments: port name, and a number to be added to the current speed.

=head4 clear_time()

    Clears and starts a timer.

=head4 time_while($what_time_to_stop, @tasks)

    Takes two arguments: a time limit which makes the condition false, and a list of tasks to execute while true.

=head4 wait($duration)

    Pauses the robot for the given amount of seconds. ( yes, SECONDS! )

=head4 cont(port => $port2, channel => $Ch2)

    Donotes a given motor port to a transmitter channel.

=head4 call($function_name)

    Calls a given function.

=head1 THESE FUNCTIONS SHOULD BE USED AS VALUES

=head4 cos($var)

    Equal to the cosine of $var.

=head4 sin($var)

    Equal to the sin of var.

=head4 tan($var)

    Equal to the tangent of $var.

=head4 d_r($var)

    Converts parameter from degrees to radians

=head4 r_d($var)

    Converts parameter from radians to degrees

=head3 AUTHOR

    James Albert james.albert72@gmail.com

=cut
