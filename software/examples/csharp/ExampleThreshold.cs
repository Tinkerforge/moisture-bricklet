using System;
using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "XYZ"; // Change XYZ to the UID of your Moisture Bricklet

	// Callback function for moisture value reached callback
	static void MoistureReachedCB(BrickletMoisture sender, int moisture)
	{
		Console.WriteLine("Moisture Value: " + moisture);
	}

	static void Main()
	{
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletMoisture m = new BrickletMoisture(UID, ipcon); // Create device object

		ipcon.Connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Get threshold callbacks with a debounce time of 1 second (1000ms)
		m.SetDebouncePeriod(1000);

		// Register moisture value reached callback to function MoistureReachedCB
		m.MoistureReached += MoistureReachedCB;

		// Configure threshold for moisture value "greater than 200"
		m.SetMoistureCallbackThreshold('>', 200, 0);

		Console.WriteLine("Press enter to exit");
		Console.ReadLine();
		ipcon.Disconnect();
	}
}
