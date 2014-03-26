function matlab_example_callback
    import com.tinkerforge.IPConnection;
    import com.tinkerforge.BrickletMoisture;

    HOST = 'localhost';
    PORT = 4223;
    UID = 'kve'; % Change to your UID
    
    ipcon = IPConnection(); % Create IP connection
    m = BrickletMoisture(UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Set Period for moisture callback to 1s (1000ms)
    % Note: The moisture callback is only called every second if the 
    %       moisture has changed since the last call!
    m.setMoistureCallbackPeriod(1000);

    % Register moisture callback to function cb_moisture
    set(m, 'MoistureCallback', @(h, e)cb_moisture(e.moisture));

    input('\nPress any key to exit...\n', 's');
    ipcon.disconnect();
end

% Callback function for moisture value 
function cb_moisture(moisture)
    fprintf('Moisture Value: %g\n', moisture);
end
