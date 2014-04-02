#!/usr/bin/perl  

use Tinkerforge::IPConnection;
use Tinkerforge::BrickletMoisture;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => '7xwQ9g'; # Change to your UID

my $ipcon = Tinkerforge::IPConnection->new(); # Create IP connection
my $m = Tinkerforge::BrickletMoisture->new(&UID, $ipcon); # Create device object

# Callback function for moisture value 
sub cb_moisture
{
    my ($moisture) = @_;

    print "Moisture Value: $moisture\n";
}

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Set Period for moisture callback to 1s (1000ms)
# Note: The moisture callback is only called every second if the 
#       moisture has changed since the last call!
$m->set_moisture_callback_period(1000);

# Register moisture callback to function cb_moisture
$m->register_callback($m->CALLBACK_MOISTURE, 'cb_moisture');

print "Press any key to exit...\n";
<STDIN>;
$ipcon->disconnect();

