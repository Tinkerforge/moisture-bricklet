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

# Get threshold callbacks with a debounce time of 1 second (1000ms)
m.set_debounce_period 1000

# Register moisture value reached callback
m.register_callback(BrickletMoisture::CALLBACK_MOISTURE_REACHED) do |moisture|
  puts "Moisture Value: #{moisture}"
end

# Configure threshold for moisture value "greater than 200"
m.set_moisture_callback_threshold '>', 200, 0

puts 'Press key to exit'
$stdin.gets
ipcon.disconnect
