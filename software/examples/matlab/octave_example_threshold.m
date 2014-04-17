function octave_example_threshold
    more off;
    
    HOST = "localhost";
    PORT = 4223;
    UID = "kve"; % Change to your UID

    ipcon = java_new("com.tinkerforge.IPConnection"); % Create IP connection
    m = java_new("com.tinkerforge.BrickletMoisture", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get threshold callbacks with a debounce time of 1 seconds (1000ms)
    m.setDebouncePeriod(1000);

    % Register threshold reached callback to function cb_reached
    m.addMoistureReachedCallback(@cb_reached);

    % Configure threshold for "greater than 200"
    m.setMoistureCallbackThreshold(">", 200, 0);

    input("Press any key to exit...\n", "s");
    ipcon.disconnect();
end

% Callback for moisture value greater than 200
function cb_reached(e)
    fprintf("Moisture Value: %g\n", e.moisture);
end
