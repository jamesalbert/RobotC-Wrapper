#!/usr/bin/perl

use strict;
use warnings;
use Mojolicious::Lite;

get '/' => sub {
    my $self = shift;
    $self->stash(tab => );
    $self->render;
} => 'site';

get '/docs' => sub {
    my $self = shift;
    $self->render;
} => 'docs';

get '/contact' => sub {
    my $self = shift;
    $self->render;
} => 'contact';

get '/compare' => sub {
    my $self = shift;
    $self->render;
} => 'compare';

app->start;

__DATA__

@@ site.html.ep

<head>

<link href="http://i.imgur.com/13eid.png" rel="icon" type="image/x-icon" />

</head>

<a href="/"><img src="http://i.imgur.com/13eid.png" title="Hosted by imgur.com" alt="" height="36" width="130" /></a>

<p><code><i>A fully functional RobotC wrapper</i></code></p>

<style type="text/css">
body { background-color:F2F2F2; }
</style>

<table border="1">

<tr>
<td><a href="/docs" target="_blank">Documentation</a></td>
</tr>
<tr>
<td><a href="/compare" target="_blank">Compare the two</a></td>
</tr>
<tr>
<td><a href="/contact" target="_blank">Report a bug</a><br /></td>
</tr>
<tr>
<td><%= link_to 'https://github.com/jamesalbert/RobotPerl' => begin %>Fork us on Github<% end %></td>
</tr>

</table>

@@ contact.html.ep

<a href="/" target="_blank">Home</a><br />

<a href="/"><img src="http://i.imgur.com/13eid.png" title="Hosted by imgur.com" alt="" height="36" width="130" /></a>

<style type="text/css">
body { background-color:F2F2F2; }
</style>

<p><code>James Albert</code></p>
<%= link_to 'mailto:james.albert72@gmail.com' => begin %>Email<% end %><br />

<p><code>Casey Vega</code></p>
<%= link_to 'mailto:casey.vega@gmail.com' => begin %>Email<% end %>

@@ compare.html.ep

<a href="/" target="_blank">Home</a> <a href="/contact" target="_blank">Report a bug</a><br />

<a href="/"><img src="http://i.imgur.com/13eid.png" title="Hosted by imgur.com" alt="" height="36" width="130" /></a>

<h1>The Comparison</h1>

<p>
<code>
Size does vary depending on what kind of project you're working on.<br />
If you are working on a mostly autonomous robot, using the basic_movements()<br />
function will be the difference between 20 lines of code and only 1.
</code>
</p>

<h3>With custom functions</h3>
<br />
<textarea rows="40" cols="75" readonly="readonly" disabled="disabled">
#!/usr/bin/perl

use strict;
use warnings;
use Robot::Perl::Lead;

my $SV = "SensorValue";

my $r = Robot::Perl::Lead->new;

$r->start_robot((
    $r->pragma( in => "in2", name => "button", type => "Touch"),
    $r->auto( "false" ),
    $r->reflect( port => "port3", bool => "true" ),
    $r->start_void( "cont", (
        $r->var( type => 1, name => "MOTOR_1", value => "motor[port1]"),
        $r->cont( port => "port2", channel => "Ch3"),
        $r->cont( port => "port3", channel => "Ch2"),
        $r->cont( port => "port4", channel => "Ch4"),
        $r->start_if( "MOTOR_1 > 0", (
            $r->motor( port => "port3", speed => "MOTOR_1"),
            $r->motor( port => "port2", speed => "-(MOTOR_1)")
        )),
        $r->start_if( "MOTOR_1 < 0", (
            $r->motor( port => "port2", speed => "MOTOR_1"),
            $r->motor( port => "port3", speed => "-(MOTOR_1)")
        ))
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
</textarea>

<textarea rows="40" cols="75" readonly="readonly" disabled="disabled">
#pragma config(Sensor, in2, button, sensorTouch);
bVexAutonomousMode = false;
bMotorReflected[port3] = true;
void cont() {
int MOTOR_1 = motor[port1];
motor[port2] = vexRT[Ch3];
motor[port3] = vexRT[Ch2];
motor[port4] = vexRT[Ch4];
if ( MOTOR_1 > 0 ) {
motor[port3] = MOTOR_1;
motor[port2] = -(MOTOR_1);
}
if ( MOTOR_1 < 0 ) {
motor[port2] = MOTOR_1;
motor[port3] = -(MOTOR_1);
}
}
task main() {
while (true) {
cont();
if ( SensorValue(button) == 1 ) {
halt();
wait_5();
}
}
}
</textarea>

<br />

<h3>With prewritten functions such as drive() .. cont()</h3>

<br />

<textarea rows="40" cols="75" readonly="readonly" disabled="disabled">

#!/usr/bin/perl

use strict;
use warnings;
use Robot::Perl::Lead;

my $SV = "SensorValue";

my $r = Robot::Perl::Lead->new;

$r->start_robot((
    $r->pragma( in => "in2", name => "button", type => "Touch"),
    $r->auto( "false" ),
    $r->reflect( port => "port3", bool => "true" ),
    $r->basic_movements;
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

</textarea>

<textarea rows="40" cols="75" readonly="readonly" disabled="disabled">

#pragma config(Sensor, in2, button, sensorTouch);
bVexAutonomousMode = false;
bMotorReflected[port3] = true;
void drive() {
motor[port2] = 127;
motor[port3] = 127;
}
void turn_left() {
motor[port2] = -127;
motor[port3] = 127;
}
void turn_right() {
motor[port2] = 127;
motor[port3] = -127;
}
void halt() {
motor[port2] = 0;
motor[port3] = 0;
}
void wait_five() {
wait1Msec(5000);
}
void cont() {
motor[port2] = vexRT[Ch3];
motor[port3] = vexRT[Ch2];
}
task main() {
while (true) {
cont();
if ( SensorValue(button) == 1 ) {
halt();
wait_5();
}
}
}

</textarea>

<p><code>RobotPerl is used mainly for its dynamic use and explicit function names.</code></p>

@@ docs.html.ep

<a href="/" target="_blank">Home</a> <a href="/contact" target="_blank">Report a bug</a><br />

<a href="/"><img src="http://i.imgur.com/13eid.png" title="Hosted by imgur.com" alt="" height="36" width="130" /></a>

<style type="text/css">
html { background-color:F2F2F2; }
</style>

<?xml version="1.0" ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link rev="made" href="mailto:kevin@archlinux.org" />
</head>

<body>



<ul id="index">
  <li><a href="#NAME">NAME</a></li>
  <li><a href="#SYNOPSIS">SYNOPSIS</a>
    <ul>
      <li><a href="#DESCRIPTION">DESCRIPTION</a></li>
    </ul>
  </li>
  <li><a href="#ROBOT::PERL">ROBOT::PERL</a></li>
  <li><a href="#LIST-OF-FUNCTIONS">LIST OF FUNCTIONS</a>
    <ul>
      <li>
        <ul>
          <li>
            <ul>
              <li><a href="#start_robot-tasks-">start_robot(@tasks)</a></li>
              <li><a href="#start_void-name-tasks-">start_void($name, @tasks)</a></li>
              <li><a href="#start_task-tasks-">start_task(@tasks)</a></li>
              <li><a href="#start_if-condition-tasks-">start_if($condition, @tasks)</a></li>
              <li><a href="#start_for-init-init-end-end-tasks-">start_for(init =&gt; $init, end =&gt; $end, @tasks)</a></li>
              <li><a href="#start_while-condition-tasks-">start_while($condition, @tasks)</a></li>
              <li><a href="#end-">end()</a></li>
              <li><a href="#var-type-num-name-name-value-value-">var(type =&gt; $num, name =&gt; $name, value =&gt; $value)</a></li>
              <li><a href="#battery-name-variable_name-">battery(name =&gt; $variable_name)</a></li>
              <li><a href="#kill-task-any_function-">kill(task =&gt; $any_function)</a></li>
              <li><a href="#mute-">mute()</a></li>
              <li><a href="#sound-freq-frequency-dur-duration-">sound(freq =&gt; $frequency, dur =&gt; $duration)</a></li>
              <li><a href="#tone-tone-beep-">tone(tone =&gt; &quot;beep&quot;)</a></li>
              <li><a href="#sound_power-bool-true-">sound_power(bool =&gt; &quot;true&quot;)</a></li>
              <li><a href="#if_sound-tasks-">if_sound(@tasks)</a></li>
              <li><a href="#if_active-tasks-">if_active(@tasks)</a></li>
              <li><a href="#pragma-in-in2-name-name-type-Touch-">pragma(in =&gt; &quot;in2&quot;, name =&gt; $name, type =&gt; &quot;Touch&quot;)</a></li>
              <li><a href="#reflect-port-port2-bool-true-">reflect(port =&gt; $port2, bool =&gt; &quot;true&quot;)</a></li>
              <li><a href="#auto-bool-true-">auto(bool =&gt; &quot;true&quot;)</a></li>
              <li><a href="#motor-port-port2-speed-speed-">motor(port =&gt; $port2, speed =&gt; $speed)</a></li>
              <li><a href="#speed_up-port-port2-speed-increment-">speed_up(port =&gt; $port2, speed =&gt; $increment)</a></li>
              <li><a href="#clear_time-">clear_time()</a></li>
              <li><a href="#time_while-what_time_to_stop-tasks-">time_while($what_time_to_stop, @tasks)</a></li>
              <li><a href="#wait-duration-">wait($duration)</a></li>
              <li><a href="#cont-port-port2-channel-Ch2-">cont(port =&gt; $port2, channel =&gt; $Ch2)</a></li>
              <li><a href="#call-function_name-">call($function_name)</a></li>
            </ul>
          </li>
        </ul>
      </li>
    </ul>
  </li>
  <li><a href="#THESE-FUNCTIONS-SHOULD-BE-USED-AS-VALUES">THESE FUNCTIONS SHOULD BE USED AS VALUES</a>
    <ul>
      <li>
        <ul>
          <li>
            <ul>
              <li><a href="#cos-var-">cos($var)</a></li>
              <li><a href="#sin-var-">sin($var)</a></li>
              <li><a href="#tan-var-">tan($var)</a></li>
              <li><a href="#d_r-var-">d_r($var)</a></li>
              <li><a href="#r_d-var-">r_d($var)</a></li>
            </ul>
          </li>
          <li><a href="#AUTHOR">AUTHORS</a></li>
        </ul>
      </li>
    </ul>
  </li>
</ul>

<h1 id="NAME">NAME</h1>

<p>RobotPerl - An easy to read, fully functional RobotC for Vex wrapper.</p>

<h1 id="SYNOPSIS">SYNOPSIS</h1>

<pre><code>    #!/usr/bin/perl -w

    use strict;
    use Robot::Perl::Lead;

    my $SV = &quot;SensorValue&quot;;

    my $r = Robot::Perl::Lead-&gt;new;

    $r-&gt;start_robot((
        $r-&gt;pragma( in =&gt; &quot;in2&quot;, name =&gt; &quot;button&quot;, type =&gt; &quot;Touch&quot;),
        $r-&gt;easy_start( &quot;port2&quot; ),
        $r-&gt;basic_movements,
        $r-&gt;start_void( &quot;turn_around&quot;, (
            $r-&gt;motor( port =&gt; &quot;port2&quot;, speed =&gt; 127 ),
            $r-&gt;motor( port =&gt; &quot;port3&quot;, speed =&gt; -127 )
            $r-&gt;wait(1);
        )),
        $r-&gt;start_task((
            $r-&gt;start_while( &quot;true&quot;, (
                $r-&gt;call( &quot;cont&quot; ),
                $r-&gt;start_if( &quot;$SV(button) == 1&quot;, (
                        $r-&gt;call( &quot;halt&quot; ),
                        $r-&gt;call( &quot;wait_5&quot; )
                ))
            ))
        ))
    ));</code></pre>

<h2 id="DESCRIPTION">DESCRIPTION</h2>

<h1 id="ROBOT::PERL">ROBOT::PERL</h1>

<pre><code>    The Robot::Perl base library has a series of functions that you can call which will spit out RobotC.
    Start by initiating it.

    use Robot::Perl;

    my $r = Robot::Perl-&gt;new;</code></pre>

<h1 id="LIST-OF-FUNCTIONS">LIST OF FUNCTIONS</h1>

<h4 id="start_robot-tasks-">start_robot(@tasks)</h4>

<pre><code>    Should be called as the first function after Robot::Perl::Whatever-&gt;new. This function
    prints everything.

    $r-&gt;start_robot(( task_1, task_2, task_3 ));

    Remember that all functions, loops, and statements in RobotPerl take an array as the last
    parameter so don&#39;t forget to close the array and parameter parenthesis and separate each
    function with commas.</code></pre>

<h4 id="start_void-name-tasks-">start_void($name, @tasks)</h4>

<pre><code>    Starts a void function. $name is the name of the function being declared, and @tasks
    is a list of functions to be executed once called.</code></pre>

<h4 id="start_task-tasks-">start_task(@tasks)</h4>

<pre><code>    Starts the main task. This function must always be present in RobotPerl.</code></pre>

<h4 id="start_if-condition-tasks-">start_if($condition, @tasks)</h4>

<pre><code>    Starts an if statement. $condition is, of course, the condition, and @tasks work the
    same way as any other start_* function.</code></pre>

<h4 id="start_for-init-init-end-end-tasks-">start_for(init =&gt; $init, end =&gt; $end, @tasks)</h4>

<pre><code>    Starts a for loop. Takes three arguments: an start value ( usually 0 ), an end value,
    and a list of functions to call when true.</code></pre>

<h4 id="start_while-condition-tasks-">start_while($condition, @tasks)</h4>

<pre><code>    Starts a while loop. Takes two arguments: the condition and a list of tasks to execute once true.</code></pre>

<h4 id="end-">end()</h4>

<pre><code>    Prints a brace &quot;}&quot; and starts a newline.</code></pre>

<h4 id="var-type-num-name-name-value-value-">var(type =&gt; $num, name =&gt; $name, value =&gt; $value)</h4>

<pre><code>    Declares a new variable, takes three arguments: a number symbolizing data
    type ( 1-3; 1 =&gt; int, 2 =&gt; char, 3 =&gt; long ), name, and value.</code></pre>

<h4 id="battery-name-variable_name-">battery(name =&gt; $variable_name)</h4>

<pre><code>    Declares a variable containing the current battery level, takes the variable
    name as the only argument.</code></pre>

<h4 id="kill-task-any_function-">kill(task =&gt; $any_function)</h4>

<pre><code>    Kills the function specified as a parameter.</code></pre>

<h4 id="mute-">mute()</h4>

<pre><code>    Turns off all tones and sounds.</code></pre>

<h4 id="sound-freq-frequency-dur-duration-">sound(freq =&gt; $frequency, dur =&gt; $duration)</h4>

<pre><code>    Plays a tone, takes two arguments: frequency, and duration.</code></pre>

<h4 id="tone-tone-beep-">tone(tone =&gt; &quot;beep&quot;)</h4>

<pre><code>    Plays tone, takes one parameter: must be &quot;buzz&quot;, &quot;beep&quot;, or &quot;click&quot;.</code></pre>

<h4 id="sound_power-bool-true-">sound_power(bool =&gt; &quot;true&quot;)</h4>

<pre><code>    Turns sound on and off, true or false as a parameter.</code></pre>

<h4 id="if_sound-tasks-">if_sound(@tasks)</h4>

<pre><code>    Starts an if statement with a predeclared condition (if sound is available),
    and takes one argument which is a list of tasks to execute once true.</code></pre>

<h4 id="if_active-tasks-">if_active(@tasks)</h4>

<pre><code>    Does the same thing as if_sound, but checks for controller activity.
    Still takes a list of tasks.</code></pre>

<h4 id="pragma-in-in2-name-name-type-Touch-">pragma(in =&gt; &quot;in2&quot;, name =&gt; $name, type =&gt; &quot;Touch&quot;)</h4>

<pre><code>    Sets up sensors. Should be the first thing called after start_robot.
    Takes three parameters: in port, name, and sensor type (&quot;Touch, SONAR, etc&quot;).</code></pre>

<h4 id="reflect-port-port2-bool-true-">reflect(port =&gt; $port2, bool =&gt; &quot;true&quot;)</h4>

<pre><code>    Reflects a designated port, takes two parameters: port name ( &quot;port2&quot;, &quot;port3&quot;, etc ), and boolean ( most likely true ).</code></pre>

<h4 id="auto-bool-true-">auto(bool =&gt; &quot;true&quot;)</h4>

<pre><code>    Toggles autonomous mode depending on the boolean parameter.</code></pre>

<h4 id="motor-port-port2-speed-speed-">motor(port =&gt; $port2, speed =&gt; $speed)</h4>

<pre><code>    Sets motor value, takes two parameters: port name and speed ( -127 - 127 ).</code></pre>

<h4 id="speed_up-port-port2-speed-increment-">speed_up(port =&gt; $port2, speed =&gt; $increment)</h4>

<pre><code>    Speeds up to motors, takes two arguments: port name, and a number to be added to the current speed.</code></pre>

<h4 id="clear_time-">clear_time()</h4>

<pre><code>    Clears and starts a timer.</code></pre>

<h4 id="time_while-what_time_to_stop-tasks-">time_while($what_time_to_stop, @tasks)</h4>

<pre><code>    Takes two arguments: a time limit which makes the condition false, and a list of tasks to execute while true.</code></pre>

<h4 id="wait-duration-">wait($duration)</h4>

<pre><code>    Pauses the robot for the given amount of seconds. ( yes, SECONDS! )</code></pre>

<h4 id="cont-port-port2-channel-Ch2-">cont(port =&gt; $port2, channel =&gt; $Ch2)</h4>

<pre><code>    Donotes a given motor port to a transmitter channel.</code></pre>

<h4 id="call-function_name-">call($function_name)</h4>

<pre><code>    Calls a given function.</code></pre>

<h1 id="THESE-FUNCTIONS-SHOULD-BE-USED-AS-VALUES">THESE FUNCTIONS SHOULD BE USED AS VALUES</h1>

<h4 id="cos-var-">cos($var)</h4>

<pre><code>    Equal to the cosine of $var.</code></pre>

<h4 id="sin-var-">sin($var)</h4>

<pre><code>    Equal to the sin of var.</code></pre>

<h4 id="tan-var-">tan($var)</h4>

<pre><code>    Equal to the tangent of $var.</code></pre>

<h4 id="d_r-var-">d_r($var)</h4>

<pre><code>    Converts parameter from degrees to radians</code></pre>

<h4 id="r_d-var-">r_d($var)</h4>

<pre><code>    Converts parameter from radians to degrees</code></pre>

<h3 id="AUTHOR">AUTHORS</h3>

<pre><code>    James Albert james.albert72@gmail.com</code></pre>

<pre><code>    Casey Vega   casey.vega@gmail.com</code></pre>

</body>

</html>
