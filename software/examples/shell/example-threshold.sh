#!/bin/sh
# connects to localhost:4223 by default, use --host and --port to change it

# change to your UID
uid=XYZ

# get threshold callbacks with a debounce time of 1 seconds (1000ms)
tinkerforge call moisture-bricklet $uid set-debounce-period 1000

# configure threshold for "greater than 200"
tinkerforge call moisture-bricklet $uid set-moisture-callback-threshold greater 200 0

# handle incoming moisture-reached callbacks
tinkerforge dispatch moisture-bricklet $uid moisture-reached
