function matlab_example_simple()
    import com.tinkerforge.IPConnection;
    import com.tinkerforge.BrickletMoisture;

    HOST = 'localhost';
    PORT = 4223;
    UID = 'XYZ'; % Change to your UID

    ipcon = IPConnection(); % Create IP connection
    m = BrickletMoisture(UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get current moisture value
    moisture = m.getMoistureValue();
    fprintf('Moisture Value: %i\n', moisture);

    input('Press key to exit\n', 's');
    ipcon.disconnect();
end
