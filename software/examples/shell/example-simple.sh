#!/bin/sh
# connects to localhost:4223 by default, use --host and --port to change it

# change to your UID
uid=XYZ

# get current moisture value 
tinkerforge call moisture-bricklet $uid get-moisture-value
