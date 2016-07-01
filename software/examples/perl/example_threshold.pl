#!/usr/bin/perl

use Tinkerforge::IPConnection;
use Tinkerforge::BrickletMoisture;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => 'XYZ'; # Change XYZ to the UID of your Moisture Bricklet

# Callback subroutine for moisture value reached callback
sub cb_moisture_reached
{
    my ($moisture) = @_;

    print "Moisture Value: $moisture\n";
}

my $ipcon = Tinkerforge::IPConnection->new(); # Create IP connection
my $m = Tinkerforge::BrickletMoisture->new(&UID, $ipcon); # Create device object

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Get threshold callbacks with a debounce time of 1 second (1000ms)
$m->set_debounce_period(1000);

# Register moisture value reached callback to subroutine cb_moisture_reached
$m->register_callback($m->CALLBACK_MOISTURE_REACHED, 'cb_moisture_reached');

# Configure threshold for moisture value "greater than 200"
$m->set_moisture_callback_threshold('>', 200, 0);

print "Press key to exit\n";
<STDIN>;
$ipcon->disconnect();
