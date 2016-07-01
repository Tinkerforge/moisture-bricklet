#!/bin/sh
# Connects to localhost:4223 by default, use --host and --port to change this

uid=XYZ # Change XYZ to the UID of your Moisture Bricklet

# Handle incoming moisture value callbacks
tinkerforge dispatch moisture-bricklet $uid moisture &

# Set period for moisture value callback to 1s (1000ms)
# Note: The moisture value callback is only called every second
#       if the moisture value has changed since the last call!
tinkerforge call moisture-bricklet $uid set-moisture-callback-period 1000

echo "Press key to exit"; read dummy

kill -- -$$ # Stop callback dispatch in background
