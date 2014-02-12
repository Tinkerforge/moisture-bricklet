var IPConnection = require('Tinkerforge/IPConnection');
var BrickletMoisture = require('Tinkerforge/BrickletMoisture');

var HOST = 'localhost';
var PORT = 4223;
var UID = 'iB4';// Change to your UID

var ipcon = new IPConnection();// Create IP connection
var m = new BrickletMoisture(UID, ipcon);// Create device object

ipcon.connect(HOST, PORT,
    function(error) {
        console.log('Error: '+error);        
    }
);// Connect to brickd

// Don't use device before ipcon is connected
ipcon.on(IPConnection.CALLBACK_CONNECTED,
    function(connectReason) {
        // Set Period for moisture callback to 1s (1000ms)
        // Note: The moisture callback is only called every second if the 
        // moisture has changed since the last call!
        m.setMoistureCallbackPeriod(1000);
        // Get threshold callbacks with a debounce time of 1 seconds (1000ms)
        m.setDebouncePeriod(1000);
        // Configure threshold for "greater than 200"
        m.setMoistureCallbackThreshold('>', 200, 0);      
    }
);

// Register threshold reached callback
m.on(BrickletMoisture.CALLBACK_MOISTURE_REACHED,
    // Callback for moisture value greater than 200
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

