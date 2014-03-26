function matlab_example_threshold
    import com.tinkerforge.IPConnection;
    import com.tinkerforge.BrickletMoisture;

    HOST = 'localhost';
    PORT = 4223;
    UID = 'kve'; % Change to your UID
    
    ipcon = IPConnection(); % Create IP connection
    m = BrickletMoisture(UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get threshold callbacks with a debounce time of 1 seconds (1000ms)
    m.setDebouncePeriod(1000);

    % Register threshold reached callback to function cb_reached
    set(m, 'MoistureReachedCallback', @(h, e)cb_reached(e.moisture));

    % Configure threshold for "greater than 200"
    m.setMoistureCallbackThreshold('>', 200, 0);

    input('\nPress any key to exit...\n', 's');
    ipcon.disconnect();
end

% Callback for moisture value greater than 200
function cb_reached(moisture)
    fprintf('Moisture Value: %g\n', moisture);
end
