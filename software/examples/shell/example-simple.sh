#!/bin/sh
# Connects to localhost:4223 by default, use --host and --port to change this

uid=XYZ # Change XYZ to the UID of your Moisture Bricklet

# Get current moisture value
tinkerforge call moisture-bricklet $uid get-moisture-value
