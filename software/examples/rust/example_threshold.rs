use std::{error::Error, io, thread};
use tinkerforge::{ipconnection::IpConnection, moisture_bricklet::*};

const HOST: &str = "127.0.0.1";
const PORT: u16 = 4223;
const UID: &str = "XYZ"; // Change XYZ to the UID of your Moisture Bricklet

fn main() -> Result<(), Box<dyn Error>> {
    let ipcon = IpConnection::new(); // Create IP connection
    let moisture_bricklet = MoistureBricklet::new(UID, &ipcon); // Create device object

    ipcon.connect(HOST, PORT).recv()??; // Connect to brickd
                                        // Don't use device before ipcon is connected

    // Get threshold listeners with a debounce time of 1 second (1000ms)
    moisture_bricklet.set_debounce_period(1000);

    //Create listener for moisture value reached events.
    let moisture_reached_listener = moisture_bricklet.get_moisture_reached_receiver();
    // Spawn thread to handle received events. This thread ends when the moisture_bricklet
    // is dropped, so there is no need for manual cleanup.
    thread::spawn(move || {
        for event in moisture_reached_listener {
            println!("Moisture Value: {}", event);
        }
    });

    // Configure threshold for moisture value "greater than 200"
    moisture_bricklet.set_moisture_callback_threshold('>', 200, 0);

    println!("Press enter to exit.");
    let mut _input = String::new();
    io::stdin().read_line(&mut _input)?;
    ipcon.disconnect();
    Ok(())
}
