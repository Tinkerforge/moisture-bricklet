import com.tinkerforge.IPConnection;
import com.tinkerforge.BrickletMoisture;

public class ExampleSimple {
	private static final String HOST = "localhost";
	private static final int PORT = 4223;

	// Change XYZ to the UID of your Moisture Bricklet
	private static final String UID = "XYZ";

	// Note: To make the example code cleaner we do not handle exceptions. Exceptions
	//       you might normally want to catch are described in the documentation
	public static void main(String args[]) throws Exception {
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletMoisture m = new BrickletMoisture(UID, ipcon); // Create device object

		ipcon.connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Get current moisture value
		int moisture = m.getMoistureValue(); // Can throw com.tinkerforge.TimeoutException
		System.out.println("Moisture Value: " + moisture);

		System.out.println("Press key to exit"); System.in.read();
		ipcon.disconnect();
	}
}
