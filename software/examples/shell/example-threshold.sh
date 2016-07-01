#!/bin/sh
# Connects to localhost:4223 by default, use --host and --port to change this

uid=XYZ # Change XYZ to the UID of your Moisture Bricklet

# Get threshold callbacks with a debounce time of 1 second (1000ms)
tinkerforge call moisture-bricklet $uid set-debounce-period 1000

# Handle incoming moisture value reached callbacks
tinkerforge dispatch moisture-bricklet $uid moisture-reached &

# Configure threshold for moisture value "greater than 200"
tinkerforge call moisture-bricklet $uid set-moisture-callback-threshold greater 200 0

echo "Press key to exit"; read dummy

kill -- -$$ # Stop callback dispatch in background
