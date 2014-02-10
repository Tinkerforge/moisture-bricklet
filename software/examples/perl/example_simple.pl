#!/usr/bin/perl  

use Tinkerforge::IPConnection;
use Tinkerforge::BrickletMoisture;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => '7xwQ9g'; # Change to your UID

my $ipcon = Tinkerforge::IPConnection->new(); # Create IP connection
my $m = Tinkerforge::BrickletMoisture->new(&UID, $ipcon); # Create device object

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Get current moisture value
my $moisture = $m->get_moisture_value();

print "\nMoisture Value: $moisture\n";

print "\nPress any key to exit...\n";
<STDIN>;
$ipcon->disconnect();

