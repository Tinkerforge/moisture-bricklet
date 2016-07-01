function matlab_example_simple()
    import com.tinkerforge.IPConnection;
    import com.tinkerforge.BrickletMoisture;

    HOST = 'localhost';
    PORT = 4223;
    UID = 'XYZ'; % Change XYZ to the UID of your Moisture Bricklet

    ipcon = IPConnection(); % Create IP connection
    m = handle(BrickletMoisture(UID, ipcon), 'CallbackProperties'); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get current moisture value
    moisture = m.getMoistureValue();
    fprintf('Moisture Value: %i\n', moisture);

    input('Press key to exit\n', 's');
    ipcon.disconnect();
end
