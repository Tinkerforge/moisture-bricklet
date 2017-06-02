function octave_example_threshold()
    more off;

    HOST = "localhost";
    PORT = 4223;
    UID = "XYZ"; % Change XYZ to the UID of your Moisture Bricklet

    ipcon = javaObject("com.tinkerforge.IPConnection"); % Create IP connection
    m = javaObject("com.tinkerforge.BrickletMoisture", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get threshold callbacks with a debounce time of 1 second (1000ms)
    m.setDebouncePeriod(1000);

    % Register moisture value reached callback to function cb_moisture_reached
    m.addMoistureReachedCallback(@cb_moisture_reached);

    % Configure threshold for moisture value "greater than 200"
    m.setMoistureCallbackThreshold(">", 200, 0);

    input("Press key to exit\n", "s");
    ipcon.disconnect();
end

% Callback function for moisture value reached callback
function cb_moisture_reached(e)
    fprintf("Moisture Value: %d\n", e.moisture);
end
