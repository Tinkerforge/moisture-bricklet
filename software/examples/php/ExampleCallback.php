<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickletMoisture.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickletMoisture;

const HOST = 'localhost';
const PORT = 4223;
const UID = 'XYZ'; // Change to your UID

// Callback function for moisture value
function cb_moisture($moisture)
{
    echo "Moisture Value: " . $moisture . "\n";
}

$ipcon = new IPConnection(); // Create IP connection
$m = new BrickletMoisture(UID, $ipcon); // Create device object

$ipcon->connect(HOST, PORT); // Connect to brickd
// Don't use device before ipcon is connected

// Set Period for moisture callback to 1s (1000ms)
// Note: The moisture callback is only called every second if the
//       moisture value has changed since the last call!
$m->setMoistureCallbackPeriod(1000);

// Register moisture callback to function cb_moisture
$m->registerCallback(BrickletMoisture::CALLBACK_MOISTURE, 'cb_moisture');

echo "Press ctrl+c to exit\n";
$ipcon->dispatchCallbacks(-1); // Dispatch callbacks forever

?>
