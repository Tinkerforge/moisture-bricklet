use std::{io, error::Error};
use std::thread;
use tinkerforge::{ip_connection::IpConnection, 
                  moisture_bricklet::*};


const HOST: &str = "localhost";
const PORT: u16 = 4223;
const UID: &str = "XYZ"; // Change XYZ to the UID of your Moisture Bricklet.

fn main() -> Result<(), Box<dyn Error>> {
    let ipcon = IpConnection::new(); // Create IP connection.
    let m = MoistureBricklet::new(UID, &ipcon); // Create device object.

    ipcon.connect((HOST, PORT)).recv()??; // Connect to brickd.
    // Don't use device before ipcon is connected.

     let moisture_receiver = m.get_moisture_callback_receiver();

        // Spawn thread to handle received callback messages. 
        // This thread ends when the `m` object
        // is dropped, so there is no need for manual cleanup.
        thread::spawn(move || {
            for moisture in moisture_receiver {           
                		println!("Moisture Value: {}", moisture);
            }
        });

		// Set period for moisture value receiver to 1s (1000ms).
		// Note: The moisture value callback is only called every second
		//       if the moisture value has changed since the last call!
		m.set_moisture_callback_period(1000);

    println!("Press enter to exit.");
    let mut _input = String::new();
    io::stdin().read_line(&mut _input)?;
    ipcon.disconnect();
    Ok(())
}
