#!/usr/bin/perl  

use Tinkerforge::IPConnection;
use Tinkerforge::BrickletMoisture;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => '7xwQ9g'; # Change to your UID

# Callback for moisture value greater than 200
sub cb_reached
{
    my ($moisture) = @_;
    print "\nMoisture Value: $moisture\n";
}

my $ipcon = Tinkerforge::IPConnection->new(); # Create IP connection
my $m = Tinkerforge::BrickletMoisture->new(&UID, $ipcon); # Create device object

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Get threshold callbacks with a debounce time of 1 seconds (1000ms)
$m->set_debounce_period(1000);

# Register threshold reached callback to function cb_reached
$m->register_callback($m->CALLBACK_MOISTURE_REACHED, 'cb_reached');

# Configure threshold for "greater than 200"
$m->set_moisture_callback_threshold('>', 200, 0);

print "\nPress any key to exit...\n";
<STDIN>;
$ipcon->disconnect();

