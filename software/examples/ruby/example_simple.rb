#!/usr/bin/env ruby
# -*- ruby encoding: utf-8 -*-

require 'tinkerforge/ip_connection'
require 'tinkerforge/bricklet_moisture'

include Tinkerforge

HOST = 'localhost'
PORT = 4223
UID = 'XYZ' # Change to your UID

ipcon = IPConnection.new # Create IP connection
m = BrickletMoisture.new UID, ipcon # Create device object

ipcon.connect HOST, PORT # Connect to brickd
# Don't use device before ipcon is connected

# Get current moisture value
moisture_value = m.get_moisture_value
puts "Moisture Value: #{moisture_value}"

puts 'Press key to exit'
$stdin.gets
ipcon.disconnect
