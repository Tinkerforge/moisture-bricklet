use std::{error::Error, io, thread};
use tinkerforge::{ip_connection::IpConnection, moisture_bricklet::*};

const HOST: &str = "localhost";
const PORT: u16 = 4223;
const UID: &str = "XYZ"; // Change XYZ to the UID of your Moisture Bricklet.

fn main() -> Result<(), Box<dyn Error>> {
    let ipcon = IpConnection::new(); // Create IP connection.
    let m = MoistureBricklet::new(UID, &ipcon); // Create device object.

    ipcon.connect((HOST, PORT)).recv()??; // Connect to brickd.
                                          // Don't use device before ipcon is connected.

    // Get threshold receivers with a debounce time of 1 second (1000ms).
    m.set_debounce_period(1000);

    // Create receiver for moisture value reached events.
    let moisture_reached_receiver = m.get_moisture_reached_receiver();

    // Spawn thread to handle received events. This thread ends when the `m` object
    // is dropped, so there is no need for manual cleanup.
    thread::spawn(move || {
        for moisture_reached in moisture_reached_receiver {
            println!("Moisture Value: {}", moisture_reached);
        }
    });

    // Configure threshold for moisture value "greater than 200".
    m.set_moisture_callback_threshold('>', 200, 0);

    println!("Press enter to exit.");
    let mut _input = String::new();
    io::stdin().read_line(&mut _input)?;
    ipcon.disconnect();
    Ok(())
}
