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

<link href="http://i.imgur.com/tlBJy.png" rel="icon" type="image/x-icon" />

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

<head>

<link href="http://i.imgur.com/tlBJy.png" rel="icon" type="image/x-icon" />

</head>

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

<head>

<link href="http://i.imgur.com/tlBJy.png" rel="icon" type="image/x-icon" />

</head>

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
use Robot::Perl::Utils;

my $SV = "SensorValue";

my $r = Robot::Perl::Utils->new(
    config => '/the/path/to/file.yaml'
);

$r->pragma( in => "in2", name => "button", type => "Touch" );

$r->start_void( "Drive" );
$r->motor( port => 2, speed => 127 );
$r->motor( port => 3, speed => 127 );
$r->end;

$r->start_task;
$r->start_while( "1" );
$r->call( "Drive" );
$r->end;
$r->end;

</textarea>

<textarea rows="40" cols="75" readonly="readonly" disabled="disabled">
#pragma config(Sensor, in2, button, sensorTouch);

bAutonomousMode = false;
bMotorReflected[port2] = true;

void Drive() {
    motor[port2] = 127;
    motor[port3] = 127;
}

task main() {
    while( 1 ){
        Drive();
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
use Robot::Perl::Utils;

my $SV = "SensorValue";

my $r = Robot::Perl::Utils->new(
    config => '/the/path/to/file.yaml'
);

$r->basic_movements;

$r->start_task;
$r->call( "drive" );
$r->start_while( 1 );
$r->call( "cont" );
$r->start_if( "$SV("button") == 1 );
$r->call( "turn_left" );
$r->end;
$r->end;
$r->end;

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
void cont() {
motor[port2] = vexRT[Ch3];
motor[port3] = vexRT[Ch2];
}
task main() {
while (true) {
cont();
if ( SensorValue(button) == 1 ) {
turn_left();
}
}
}

</textarea>

<p><code>RobotPerl is used mainly for its dynamic use and implicit function names.</code></p>

@@ docs.html.ep

<head>

<link href="http://i.imgur.com/tlBJy.png" rel="icon" type="image/x-icon" />

</head>

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

<ul id="index">
  <li><a href="#NAME">NAME</a></li>
  <li><a href="#SYNOPSIS">SYNOPSIS</a>
    <ul>
      <li><a href="#DESCRIPTION">DESCRIPTION</a></li>
    </ul>
  </li>
  <li><a href="#ROBOT::PERL">ROBOT::PERL</a></li>
  <li><a href="#THE-USE-OF-YAML-FILES">THE USE OF YAML FILES</a></li>
  <li><a href="#LIST-OF-FUNCTIONS">LIST OF FUNCTIONS</a>
    <ul>
      <li>
        <ul>
          <li>
            <ul>
              <li><a href="#start_void-name-">start_void($name)</a></li>
              <li><a href="#start_task-">start_task()</a></li>
              <li><a href="#start_if-condition-">start_if($condition)</a></li>
              <li><a href="#start_for-init-init-end-end-">start_for(init =&gt; $init, end =&gt; $end, )</a></li>
              <li><a href="#start_while-condition-">start_while($condition, )</a></li>
              <li><a href="#end-">end()</a></li>
              <li><a href="#var-type-num-name-name-value-value-">var(type =&gt; $num, name =&gt; $name, value =&gt; $value)</a></li>
              <li><a href="#battery-name-variable_name-">battery(name =&gt; $variable_name)</a></li>
              <li><a href="#kill-task-any_function-">kill(task =&gt; $any_function)</a></li>
              <li><a href="#mute-">mute()</a></li>
              <li><a href="#sound-freq-frequency-dur-duration-">sound(freq =&gt; $frequency, dur =&gt; $duration)</a></li>
              <li><a href="#tone-tone-beep-">tone(tone =&gt; &quot;beep&quot;)</a></li>
              <li><a href="#sound_power-bool-true-">sound_power(bool =&gt; &quot;true&quot;)</a></li>
              <li><a href="#if_sound-">if_sound()</a></li>
              <li><a href="#if_active-">if_active()</a></li>
              <li><a href="#pragma-in-in2-name-name-type-Touch-">pragma(in =&gt; &quot;in2&quot;, name =&gt; $name, type =&gt; &quot;Touch&quot;)</a></li>
              <li><a href="#reflect-port-port2-bool-true-">reflect(port =&gt; $port2, bool =&gt; &quot;true&quot;)</a></li>
              <li><a href="#auto-bool-true-">auto(bool =&gt; &quot;true&quot;)</a></li>
              <li><a href="#motor-port-port2-speed-speed-">motor(port =&gt; $port2, speed =&gt; $speed)</a></li>
              <li><a href="#speed_up-port-port2-speed-increment-">speed_up(port =&gt; $port2, speed =&gt; $increment)</a></li>
              <li><a href="#clear_time-">clear_time()</a></li>
              <li><a href="#time_while-what_time_to_stop-">time_while($what_time_to_stop, )</a></li>
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
          <li><a href="#AUTHORS">AUTHORS</a></li>
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
    use Robot::Perl::Utils;

    my $SV = &quot;SensorValue&quot;;

    my $r = Robot::Perl::Utils-&gt;new(
        config =&gt; &quot;/home/jbert/dev/RobotPerl/Robot/Perl/data.yaml&quot;
    );

    $r-&gt;basic_movements;
    $r-&gt;start_task;
    $r-&gt;call( &quot;drive&quot; );
    $r-&gt;start_while( &quot;true&quot; );
    $r-&gt;start_if( &quot;true&quot; );
    $r-&gt;call( &quot;turn_left&quot; );
    $r-&gt;end;
    $r-&gt;end;
    $r-&gt;end;</code></pre>

<h2 id="DESCRIPTION">DESCRIPTION</h2>

<h1 id="ROBOT::PERL">ROBOT::PERL</h1>

<pre><code>    The Robot::Perl base library has a series of functions that you can call which will spit out RobotC.
    Start by initiating it.

    use Robot::Perl;

    my $r = Robot::Perl-&gt;new(
        config =&gt; &#39;/the/path/to/the/yaml.yaml&#39;
    );</code></pre>

<h1 id="THE-USE-OF-YAML-FILES">THE USE OF YAML FILES</h1>

<pre><code>    When the constuctor is initiated, a config file (yaml file) must be defined as seen aboved. If the
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

    All values are inputted by the user (the only user input the program takes).</code></pre>

<h1 id="LIST-OF-FUNCTIONS">LIST OF FUNCTIONS</h1>

<h4 id="start_void-name-">start_void($name)</h4>

<pre><code>    Starts a void function. $name is the name of the function being declared.</code></pre>

<h4 id="start_task-">start_task()</h4>

<pre><code>    Starts the main task. This function must always be present in RobotPerl.</code></pre>

<h4 id="start_if-condition-">start_if($condition)</h4>

<pre><code>    Starts an if statement. $condition is, of course, the condition.</code></pre>

<h4 id="start_for-init-init-end-end-">start_for(init =&gt; $init, end =&gt; $end, )</h4>

<pre><code>    Starts a for loop. Takes two arguments: a start value ( usually 0 ), and an end value,</code></pre>

<h4 id="start_while-condition-">start_while($condition, )</h4>

<pre><code>    Starts a while loop. Takes the condition.</code></pre>

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

<h4 id="if_sound-">if_sound()</h4>

<pre><code>    Starts an if statement with a predeclared condition (if sound is available).</code></pre>

<h4 id="if_active-">if_active()</h4>

<pre><code>    Does the same thing as if_sound, but checks for controller activity.</code></pre>

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

<h4 id="time_while-what_time_to_stop-">time_while($what_time_to_stop, )</h4>

<pre><code>    Takes one argument: a time limit which makes the condition false.</code></pre>

<h4 id="wait-duration-">wait($duration)</h4>

<pre><code>    Pauses the robot for the given amount of seconds. ( yes, SECONDS! )</code></pre>

<h4 id="cont-port-port2-channel-Ch2-">cont(port =&gt; $port2, channel =&gt; $Ch2)</h4>

<pre><code>    Denotes a given motor port to a transmitter channel.</code></pre>

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

<h3 id="AUTHORS">AUTHORS</h3>

<pre><code>    James Albert &lt;james.albert72@gmail.com&gt;
    Casey Vega   &lt;casey.vega@gmail.com&gt;</code></pre>


</body>

</html>


