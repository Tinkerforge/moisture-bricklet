<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickletMoisture.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickletMoisture;

const HOST = 'localhost';
const PORT = 4223;
const UID = 'XYZ'; // Change to your UID

$ipcon = new IPConnection(); // Create IP connection
$m = new BrickletMoisture(UID, $ipcon); // Create device object

$ipcon->connect(HOST, PORT); // Connect to brickd
// Don't use device before ipcon is connected

// Get current moisture value
$moisture = $m->getMoistureValue();

echo "Moisture Value: $moisture\n";

echo "Press key to exit\n";
fgetc(fopen('php://stdin', 'r'));
$ipcon->disconnect();

?>
