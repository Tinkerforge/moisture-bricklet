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

    //Create listener for moisture value events.
    let moisture_listener = moisture_bricklet.get_moisture_receiver();
    // Spawn thread to handle received events. This thread ends when the moisture_bricklet
    // is dropped, so there is no need for manual cleanup.
    thread::spawn(move || {
        for event in moisture_listener {
            println!("Moisture Value: {}", event);
        }
    });

    // Set period for moisture value listener to 1s (1000ms)
    // Note: The moisture value callback is only called every second
    //       if the moisture value has changed since the last call!
    moisture_bricklet.set_moisture_callback_period(1000);

    println!("Press enter to exit.");
    let mut _input = String::new();
    io::stdin().read_line(&mut _input)?;
    ipcon.disconnect();
    Ok(())
}
