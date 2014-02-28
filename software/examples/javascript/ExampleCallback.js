var Tinkerforge = require('tinkerforge');

var HOST = 'localhost';
var PORT = 4223;
var UID = 'iB4'; // Change to your UID

var ipcon = new Tinkerforge.IPConnection(); // Create IP connection
var m = new Tinkerforge.BrickletMoisture(UID, ipcon); // Create device object

ipcon.connect(HOST, PORT,
    function(error) {
        console.log('Error: '+error);
    }
); // Connect to brickd
// Don't use device before ipcon is connected

ipcon.on(Tinkerforge.IPConnection.CALLBACK_CONNECTED,
    function(connectReason) {
        // Set Period for moisture callback to 1s (1000ms)
        // Note: The moisture callback is only called every second if the
        // moisture has changed since the last call!
        m.setMoistureCallbackPeriod(1000);
    }
);

// Register moisture callback
m.on(Tinkerforge.BrickletMoisture.CALLBACK_MOISTURE,
    // Callback function for moisture value
    function(moisture) {
        console.log('Moisture Value: '+moisture);
    }
);

console.log("Press any key to exit ...");
process.stdin.on('data',
    function(data) {
        ipcon.disconnect();
        process.exit(0);
    }
);
