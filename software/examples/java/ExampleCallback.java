import com.tinkerforge.IPConnection;
import com.tinkerforge.BrickletMoisture;

public class ExampleCallback {
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

		// Add moisture value listener
		m.addMoistureListener(new BrickletMoisture.MoistureListener() {
			public void moisture(int moisture) {
				System.out.println("Moisture Value: " + moisture);
			}
		});

		// Set period for moisture value callback to 1s (1000ms)
		// Note: The moisture value callback is only called every second
		//       if the moisture value has changed since the last call!
		m.setMoistureCallbackPeriod(1000);

		System.out.println("Press key to exit"); System.in.read();
		ipcon.disconnect();
	}
}
