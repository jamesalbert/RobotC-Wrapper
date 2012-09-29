#!/usr/bin/env python

import RobotPy

robot = RobotPy.new()

robot.pragma(2, "button", "Touch")

robot.reflect(3, "true")
robot.auto("false")

robot.start_void("drive")
robot.motor(3, 127)
robot.motor(2, 127)
robot.end()

robot.start_void("turn_left")
robot.motor(3, 127)
robot.motor(2, -127)
robot.wait(1)
robot.end()

robot.start_void("turn_right")
robot.motor(3, -127)
robot.motor(2, 127)
robot.wait(1)
robot.end()

robot.start_void("stop")
robot.motor(3, 0)
robot.motor(2, 0)
robot.end()

robot.start_void("set_cont")
robot.cont(3, 2)
robot.cont(2, 3)
robot.end()

robot.start_task()
robot.call("drive")
robot.start_while("true")
robot.start_if("SensorValue(button) == 1")
robot.call("stop")
robot.call("turn_right")
robot.end()
robot.end()
robot.end()
