#!/usr/bin/env python
# -*- coding: utf-8 -*-  

HOST = "localhost"
PORT = 4223
UID = "XYZ" # Change to your UID

from tinkerforge.ip_connection import IPConnection
from tinkerforge.bricklet_moisture import Moisture

# Callback function for moisture value 
def cb_moisture(moisture):
    print('Moisture Value: ' + str(moisture))

if __name__ == "__main__":
    ipcon = IPConnection() # Create IP connection
    m = Moisture(UID, ipcon) # Create device object

    ipcon.connect(HOST, PORT) # Connect to brickd
    # Don't use device before ipcon is connected

    # Set Period for moisture callback to 1s (1000ms)
    # Note: The moisture callback is only called every second if the 
    #       moisture has changed since the last call!
    m.set_moisture_callback_period(1000)

    # Register moisture callback to function cb_moisture
    m.register_callback(m.CALLBACK_MOISTURE, cb_moisture)

    raw_input('Press key to exit\n') # Use input() in Python 3
    ipcon.disconnect()
