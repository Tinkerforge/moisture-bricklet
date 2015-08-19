#!/usr/bin/perl

use Tinkerforge::IPConnection;
use Tinkerforge::BrickletMoisture;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => 'XYZ'; # Change to your UID

my $ipcon = Tinkerforge::IPConnection->new(); # Create IP connection
my $m = Tinkerforge::BrickletMoisture->new(&UID, $ipcon); # Create device object

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Get current moisture value
my $moisture_value = $m->get_moisture_value();
print "Moisture Value: " . $moisture_value . "\n";

print "Press any key to exit...\n";
<STDIN>;
$ipcon->disconnect();
