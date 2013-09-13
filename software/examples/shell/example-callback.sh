#!/bin/sh
# connects to localhost:4223 by default, use --host and --port to change it

# change to your UID
uid=XYZ

# set period for moisture callback to 1s (1000ms)
# note: the moisture callback is only called every second if the
#       moisture value has changed since the last call!
tinkerforge call moisture-bricklet $uid set-moisture-callback-period 1000

# handle incoming moisture callbacks
tinkerforge dispatch moisture-bricklet $uid moisture
