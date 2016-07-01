var Tinkerforge = require('tinkerforge');

var HOST = 'localhost';
var PORT = 4223;
var UID = 'XYZ'; // Change XYZ to the UID of your Moisture Bricklet

var ipcon = new Tinkerforge.IPConnection(); // Create IP connection
var m = new Tinkerforge.BrickletMoisture(UID, ipcon); // Create device object

ipcon.connect(HOST, PORT,
    function (error) {
        console.log('Error: ' + error);
    }
); // Connect to brickd
// Don't use device before ipcon is connected

ipcon.on(Tinkerforge.IPConnection.CALLBACK_CONNECTED,
    function (connectReason) {
        // Set period for moisture value callback to 1s (1000ms)
        // Note: The moisture value callback is only called every second
        //       if the moisture value has changed since the last call!
        m.setMoistureCallbackPeriod(1000);
    }
);

// Register moisture value callback
m.on(Tinkerforge.BrickletMoisture.CALLBACK_MOISTURE,
    // Callback function for moisture value callback
    function (moisture) {
        console.log('Moisture Value: ' + moisture);
    }
);

console.log('Press key to exit');
process.stdin.on('data',
    function (data) {
        ipcon.disconnect();
        process.exit(0);
    }
);
