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

ipcon.on(IPConnection.CALLBACK_CONNECTED,
    function(connectReason) {
        // Get current moisture value
        m.getMoistureValue(
            function(moisture) {
                console.log('Moisture: '+moisture);
            },
            function(error) {
                console.log('Error: '+error);
            }
        );
    }
);

console.log("Press any key to exit ...");
process.stdin.on('data',
    function(data) {
        ipcon.disconnect();
        process.exit(0);
    }
);

