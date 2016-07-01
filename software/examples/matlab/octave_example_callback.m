function octave_example_callback()
    more off;

    HOST = "localhost";
    PORT = 4223;
    UID = "XYZ"; % Change XYZ to the UID of your Moisture Bricklet

    ipcon = java_new("com.tinkerforge.IPConnection"); % Create IP connection
    m = java_new("com.tinkerforge.BrickletMoisture", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Register moisture value callback to function cb_moisture
    m.addMoistureCallback(@cb_moisture);

    % Set period for moisture value callback to 1s (1000ms)
    % Note: The moisture value callback is only called every second
    %       if the moisture value has changed since the last call!
    m.setMoistureCallbackPeriod(1000);

    input("Press key to exit\n", "s");
    ipcon.disconnect();
end

% Callback function for moisture value callback
function cb_moisture(e)
    fprintf("Moisture Value: %d\n", e.moisture);
end
