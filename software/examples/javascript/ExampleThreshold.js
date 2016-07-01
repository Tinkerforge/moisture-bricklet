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
        // Get threshold callbacks with a debounce time of 1 second (1000ms)
        m.setDebouncePeriod(1000);

        // Configure threshold for moisture value "greater than 200"
        m.setMoistureCallbackThreshold('>', 200, 0);
    }
);

// Register moisture value reached callback
m.on(Tinkerforge.BrickletMoisture.CALLBACK_MOISTURE_REACHED,
    // Callback function for moisture value reached callback
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
