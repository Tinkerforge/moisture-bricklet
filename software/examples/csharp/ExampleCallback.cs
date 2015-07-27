using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "XYZ"; // Change to your UID

	// Callback function for moisture value callback
	static void MoistureCB(BrickletMoisture sender, int moisture)
	{
		System.Console.WriteLine("Moisture Value: " + moisture);
	}

	static void Main()
	{
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletMoisture m = new BrickletMoisture(UID, ipcon); // Create device object

		ipcon.Connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Set period for moisture value callback to 1s (1000ms)
		// Note: The moisture value callback is only called every second
		//       if the moisture value has changed since the last call!
		m.SetMoistureCallbackPeriod(1000);

		// Register moisture value callback to function MoistureCB
		m.Moisture += MoistureCB;

		System.Console.WriteLine("Press enter to exit");
		System.Console.ReadLine();
		ipcon.Disconnect();
	}
}
