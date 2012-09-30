#!/usr/bin/env python

import RobotPy

robot = RobotPy.new()

def SETUP():
    robot.pragma(2, "button", "Touch")

    robot.reflect(2, "true")
    robot.auto("false")

def FORWARD():
    robot.start_void("forward")
    robot.motor(2, 127)
    robot.motor(1, 127)
    robot.end()

def REVERSE():
    robot.start_void("reverse")
    robot.motor(2, -127)
    robot.motor(1, -127)
    robot.end()

def TURN_LEFT():
    robot.start_void("turn_left")
    robot.motor(2, 127)
    robot.motor(1, -127)
    robot.wait(1)
    robot.end()

def TURN_RIGHT():
    robot.start_void("turn_right")
    robot.motor(2, -127)
    robot.motor(1, 127)
    robot.wait(1)
    robot.end()

def SUSPEND():
    robot.start_void("stop")
    robot.motor(2, 0)
    robot.motor(1, 0)
    robot.end()

def SET_CONT():
    robot.start_void("set_cont")
    robot.cont(2, 2)
    robot.cont(1, 3)
    robot.end()

def KLAW_KONT():
    robot.start_void("klaw_kont")
    robot.int_var("POS", 0)
    robot.int_var("C_5", "vexRT[Ch5]")
    robot.int_var("C_6", "vexRT[Ch6]")
    robot.start_if("C_5 == 127")
    robot.start_if("POS <= 1")
    robot.inc_plus("POS")
    robot.motor(3, 40)
    robot.motor(4, 40)
    robot.wait(1)
    robot.end()
    robot.end()
    robot.start_else_if("C_5 == -127")
    robot.start_if("POS >= 1")
    robot.inc_minus("POS")
    robot.motor(3, -40)
    robot.motor(4, -40)
    robot.wait(1)
    robot.end()
    robot.end()
    robot.start_else_if("C_6 == 127")
    robot.start_if("POS == 0")
    robot.inc_plus("POS")
    robot.inc_plus("POS")
    robot.motor(3, 40)
    robot.motor(4, 40)
    robot.wait(2)
    robot.end()
    robot.end()
    robot.start_else_if("C_6 == -127")
    robot.start_if("POS == 2")
    robot.inc_minus("POS")
    robot.inc_minus("POS")
    robot.motor(3, -40)
    robot.motor(4, -40)
    robot.wait(2)
    robot.end()
    robot.end()

def MAIN_TASK():
    robot.start_task()
    robot.start_while("true")
    robot.call("set_cont")
    robot.call("klaw_kont")
    robot.end()
    robot.end()
    robot.end()

SETUP()
FORWARD()
REVERSE()
TURN_LEFT()
TURN_RIGHT();
SUSPEND()
SET_CONT()
KLAW_KONT()
MAIN_TASK()
