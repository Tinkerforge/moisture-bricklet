#!/usr/bin/env python
# -*- coding: utf-8 -*-  

HOST = "localhost"
PORT = 4223
UID = "XYZ" # Change to your UID

from tinkerforge.ip_connection import IPConnection
from tinkerforge.bricklet_moisture import Moisture

# Callback for moisture value greater than 200
def cb_reached(moisture):
    print('Moisture Value: ' + str(moisture))

if __name__ == "__main__":
    ipcon = IPConnection() # Create IP connection
    m = Moisture(UID, ipcon) # Create device object

    ipcon.connect(HOST, PORT) # Connect to brickd
    # Don't use device before ipcon is connected

    # Get threshold callbacks with a debounce time of 1 seconds (1000ms)
    m.set_debounce_period(1000)

    # Register threshold reached callback to function cb_reached
    m.register_callback(m.CALLBACK_MOISTURE_REACHED, cb_reached)

    # Configure threshold for "greater than 200"
    m.set_moisture_callback_threshold('>', 200, 0)

    raw_input('Press key to exit\n') # Use input() in Python 3
    ipcon.disconnect()
