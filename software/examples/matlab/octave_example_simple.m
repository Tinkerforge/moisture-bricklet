function octave_example_simple()
    more off;

    HOST = "localhost";
    PORT = 4223;
    UID = "XYZ"; % Change XYZ to the UID of your Moisture Bricklet

    ipcon = java_new("com.tinkerforge.IPConnection"); % Create IP connection
    m = java_new("com.tinkerforge.BrickletMoisture", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get current moisture value
    moisture = m.getMoistureValue();
    fprintf("Moisture Value: %d\n", moisture);

    input("Press key to exit\n", "s");
    ipcon.disconnect();
end
