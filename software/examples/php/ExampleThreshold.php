<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickletMoisture.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickletMoisture;

const HOST = 'localhost';
const PORT = 4223;
const UID = 'XYZ'; // Change to your UID

// Callback function for moisture value reached callback
function cb_moistureReached($moisture)
{
    echo "Moisture Value: $moisture\n";
}

$ipcon = new IPConnection(); // Create IP connection
$m = new BrickletMoisture(UID, $ipcon); // Create device object

$ipcon->connect(HOST, PORT); // Connect to brickd
// Don't use device before ipcon is connected

// Get threshold callbacks with a debounce time of 1 second (1000ms)
$m->setDebouncePeriod(1000);

// Register moisture value reached callback to function cb_moistureReached
$m->registerCallback(BrickletMoisture::CALLBACK_MOISTURE_REACHED, 'cb_moistureReached');

// Configure threshold for moisture value "greater than 200"
$m->setMoistureCallbackThreshold('>', 200, 0);

echo "Press ctrl+c to exit\n";
$ipcon->dispatchCallbacks(-1); // Dispatch callbacks forever

?>
