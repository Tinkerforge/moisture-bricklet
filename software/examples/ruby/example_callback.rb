#!/usr/bin/env ruby
# -*- ruby encoding: utf-8 -*-

require 'tinkerforge/ip_connection'
require 'tinkerforge/bricklet_moisture'

include Tinkerforge

HOST = 'localhost'
PORT = 4223
UID = 'XYZ' # Change XYZ to the UID of your Moisture Bricklet

ipcon = IPConnection.new # Create IP connection
m = BrickletMoisture.new UID, ipcon # Create device object

ipcon.connect HOST, PORT # Connect to brickd
# Don't use device before ipcon is connected

# Register moisture value callback
m.register_callback(BrickletMoisture::CALLBACK_MOISTURE) do |moisture|
  puts "Moisture Value: #{moisture}"
end

# Set period for moisture value callback to 1s (1000ms)
# Note: The moisture value callback is only called every second
#       if the moisture value has changed since the last call!
m.set_moisture_callback_period 1000

puts 'Press key to exit'
$stdin.gets
ipcon.disconnect
