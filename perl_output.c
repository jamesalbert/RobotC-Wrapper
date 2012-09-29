#pragma config(Sensor, in1, "button", sensorTouch);
#pragma config(Sensor, in2, "eyes", sensorSONAR);
bVexAutonomousMode = false;
bMotorReflected[port2] = true;
void drive() {
motor[port1] = 127;
motor[port2] = 127;
}
void turn_left() {
motor[port1] = -127;
motor[port2] = 127;
}
void turn_right() {
motor[port1] = 127;
motor[port2] = -127;
}
void halt() {
motor[port1] = 0;
motor[port2] = 0;
}
void cont() {
motor[port1] = vexRT[Ch3];
motor[port2] = vexRT[Ch2];
}
void klaw_kont() {
int POS = 0;
int C_5 = vexRT[Ch5];
int C_6 = vexRT[Ch6];
if ( C_5 == 127 ) {
if ( POS <= 1 ) {
POS++;
motor[port3] = 40;
motor[port4] = 40;
wait1Msec(1000);
}
}
else if ( C_5 == -127 ) {
if ( POS >= 1 ) {
POS--;
motor[port3] = -40;
motor[port4] = -40;
wait1Msec(1000);
}
}
else if ( C_6 == 127 ) {
if ( POS == 0 ) {
POS++;
POS++;
motor[port3] = 40;
motor[port4] = 40;
wait1Msec(2000);
}
}
else if ( C_6 == -127 ) {
if ( POS == 2 ) {
POS--;
POS--;
motor[port3] = -40;
motor[port4] = -40;
wait1Msec(2000);
}
}
task main() {
while (1) {
cont();
klaw_kont();
}
}
}
