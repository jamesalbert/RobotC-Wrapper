package NXC::Wrapper;

use strict;
use warnings;
use Carp qw/croak/;
use YAML qw/LoadFile/;

our $VERSION = 0.01;

sub new {
    my ( $class, %opt ) = @_;
    my $self = {};
    return bless $self, $class;
};

sub start_void {
    my ( $self, $name ) = @_;
    return print "void $name() {\n";
};

sub start_task {
    my $self = shift;
    return print "task main() {\n";
};

sub start_if {
    my ( $self, $cond ) = @_;
    if ( $cond !~ m/((.+) > (.+)|(.+) >= (.+)|(.+) <= (.+)|(.+) < (.+)|(.+) == (.+)|(.+) != (.+)|(.*)|true|!(.*)|false)/ ) {
        croak "Incorrect condition syntax.";
    };
    return print "if ( $cond ) {\n";
};

sub start_else_if {
    my ( $self, $cond ) = @_;
    if ( $cond !~ m/((.+) > (.+)|(.+) >= (.+)|(.+) <= (.+)|(.+) < (.+)|(.+) == (.+)|(.+) != (.+)|(.*)|true|!(.*)|false)/ ) {
        croak "Incorrect condition syntax.";
    };
    return print "else if ( $cond ) {\n";
}

sub start_for {
    my ( $self, %opt ) = @_;
    return print "for (int i = $opt{init}; i < $opt{end}; i++) {\n";
}

sub end {
    my ( $self, %opt ) = @_;
    return print "}\n";
};

sub int_var {
    my ( $self, %opt ) = @_;
    if ( $opt{name} !~ m/(.+)/ ) {
        croak "Undefined variable name."
    };
    return print "int $opt{name} = $opt{value};\n";
}

sub char_var {
    my ( $self, %opt ) = @_;
    if ( $opt{name} !~ m/(.+)/ ) {
        croak "Undefined variable name."
    };
    return print "char $opt{name} = $opt{value};\n";
}

sub long_var {
    my ( $self, %opt ) = @_;
    if ( $opt{name} !~ m/(.+)/ ) {
        croak "Undefined variable name."
    };
    return print "in $opt{name} = $opt{value};\n";
}

sub start_while {
    my ( $self, $cond ) = @_;
    if ( $cond !~ m/((.+) > (.+)|(.+) >= (.+)|(.+) <= (.+)|(.+) < (.+)|(.+) == (.+)|(.+) != (.+)|(.*)|true|!(.*)|false)/ ) {
        croak "Incorrect condition syntax.";
    };
    return print "while ($cond) {\n";
}

sub inc_plus {
    my ( $self, $var ) = @_;
    if ( $var !~ m/(.+)/ ) {
        croak "Invalid variable name";
    }
    print "$var++;\n";
}

sub inc_minus {
    my ( $self, $var ) = @_;
    if ( $var !~ m/(.+)/ ) {
        croak "Invalid variable name";
    }
    print "$var--;\n";
}

sub define {
    my ( $self, %opt ) = @_;
    return print "#define $opt{var} $opt{value}\n";
}

sub forward {
    my ( $self, %opt ) = @_;
    return print "OnFwd(OUT_$opt{motors}, $opt{speed});\n";
}

sub reverse {
    my ( $self, %opt ) = @_;
    return print "OnRev(OUT_$opt{motors}, $opt{speed});\n";
}

sub suspend {
    my ( $self, %opt ) = @_;
    return print "Off(OUT_$opt{motors});";
}

sub display_text {
    my ( $self, %opt ) = @_;
    return print "TextOut($opt{x}, LCD_LINE$opt{y}, $opt{text}, true);\n";
}

sub display_number {
    my ( $self, %opt ) = @_;
    return print "NumOut($opt{x}, LCD_LINE$opt{y}, $opt{number});\n";
}

sub display_graphic {
    my ( $self, %opt ) = @_;
    return print "GraphicOut( $opt{x}, $opt{y},", '"' , "$opt{filename}", '"' , ");\n";
}

sub clear_screen {
    my ( $self, %opt ) = @_;
    return print "ClearScreen();\n";
}

sub reset_screen {
    my $self = shift;
    return print "ResetScreen();\n";
}

sub display_rect {
    my ( $self, %opt ) = @_;
    return print "RectOut($opt{x}, $opt{y}, $opt{width}, $opt{height});\n";
}

sub display_point {
    my ( $self, %opt ) = @_;
    return print "PointOut($opt{x}, $opt{y});\n";
}

sub display_circle {
    my ( $self, %opt ) = @_;
    return print "CircleOut($opt{x}, $opt{y}, $opt{radius});\n";
}

sub itself_plus {
    my ( $self, %opt ) = @_;
    return print "$opt{var} += $opt{value};\n";
}

sub itself_minus {
    my ( $self, %opt ) = @_;
    return print "$opt{var} -= $opt{value};\n";
}

sub until {
    my ( $self, $cond ) = @_;
    return print "until ($cond);\n";
}

sub touch_setup {
    my ( $self, $motor_port ) = @_;
    return print "SetSensorTouch(IN_$motor_port);\n";
}

sub light_setup {
    my ( $self, $motor_port ) = @_;
    return print "SetSensorLight(IN_$motor_port);\n";
}

sub sound_setup {
    my ( $self, $motor_port ) = @_;
    return print "SetSensorSound(IN_$motor_port);\n";
}

sub ultrasonic_setup {
    my ( $self, $motor_port ) = @_;
    return print "SetSensorLowspeed(IN_$motor_port);\n";
}

sub start_int {
    my ( $self, %opt ) = @_;
    return print "int %opt{name}() {\n";
}

sub tone {
    my ( $self, %opt ) = @_;
    return print "PlayToneEx($opt{frequency}, $opt{duration}, $opt{volume}, $opt{loop});\n";
}

sub rotate_motor {
    my ( $self, %opt ) = @_;
    return print "RotateMotor(OUT_$opt{motors}, $opt{speed}, $opt{degrees});\n";
}

sub reset {
    my ( $self, $count ) = @_;
    return print "repeat($count){\n"
}

sub wait {
    my ( $self, $dur ) = @_;
    return print "Wait(", $dur, "000);\n";
};

sub call {
    my ( $self, $call ) = @_;
    return print "$call();\n";
};

1;

__END__

=pod

=head1 NAME

NXP - An easy to read, fully functional NXC wrapper for NXT Mindstorm.

=head1 SYNOPSIS

    #!/usr/bin/perl -w

    use strict;
    use Robot::Perl::Utils;

    my $SV = "SensorValue";

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

=head2 DESCRIPTION

=head1 ROBOT::PERL

    The Robot::Perl base library has a series of functions that you can call which will spit out RobotC.
    Start by initiating it.

    use Robot::Perl;

    my $r = Robot::Perl->new(
        config => '/the/path/to/the/yaml.yaml'
    );

=head1 THE USE OF YAML FILES

    When the constuctor is initiated, a config file (yaml file) must be defined as seen aboved. If the
    path is not defined, an error will occur and compilation will fail. The yaml file should be formatted
    as such:

    ---
    motor_port:
        right:
        left:
        2:
        3:
        4:
        5:
    channel:
        0:
        1:
        2:
        3:
        4:
        5:
    speed:
        forward:
        reverse:
        stopped:
    auto:
        state:
    reflect:
        state:
        port:

    All values are inputted by the user (the only user input the program takes).

=head1 LIST OF FUNCTIONS

=head4 start_void($name)

    Starts a void function. $name is the name of the function being declared.

=head4 start_task()

    Starts the main task. This function must always be present in RobotPerl.

=head4 start_if($condition)

    Starts an if statement. $condition is, of course, the condition.

=head4 start_for(init => $init, end => $end, )

    Starts a for loop. Takes two arguments: a start value ( usually 0 ), and an end value,

=head4 start_while($condition, )

    Starts a while loop. Takes the condition.

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

=head4 if_sound()

    Starts an if statement with a predeclared condition (if sound is available).

=head4 if_active()

    Does the same thing as if_sound, but checks for controller activity.

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

=head4 time_while($what_time_to_stop, )

    Takes one argument: a time limit which makes the condition false.

=head4 wait($duration)

    Pauses the robot for the given amount of seconds. ( yes, SECONDS! )

=head4 cont(port => $port2, channel => $Ch2)

    Denotes a given motor port to a transmitter channel.

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

=head3 AUTHORS

    James Albert <james.albert72@gmail.com>
    Casey Vega   <casey.vega@gmail.com>

=cut
