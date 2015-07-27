using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "XYZ"; // Change to your UID

	// Callback function for moisture value greater than 200
	static void MoistureReachedCB(BrickletMoisture sender, int moisture)
	{
		System.Console.WriteLine("Moisture Value: " + moisture);
	}

	static void Main()
	{
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletMoisture m = new BrickletMoisture(UID, ipcon); // Create device object

		ipcon.Connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Get threshold callbacks with a debounce time of 1 second (1000ms)
		m.SetDebouncePeriod(1000);

		// Register threshold reached callback to function MoistureReachedCB
		m.MoistureReached += MoistureReachedCB;

		// Configure threshold for "greater than 200"
		m.SetMoistureCallbackThreshold('>', 200, 0);

		System.Console.WriteLine("Press enter to exit");
		System.Console.ReadLine();
		ipcon.Disconnect();
	}
}
