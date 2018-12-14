package main

import (
	"fmt"
	"tinkerforge/ipconnection"
	"tinkerforge/moisture_bricklet"
)

const ADDR string = "localhost:4223"
const UID string = "XYZ" // Change XYZ to the UID of your Moisture Bricklet.

func main() {
	ipcon := ipconnection.New()
	defer ipcon.Close()
	m, _ := moisture_bricklet.New(UID, &ipcon) // Create device object.

	ipcon.Connect(ADDR) // Connect to brickd.
	defer ipcon.Disconnect()
	// Don't use device before ipcon is connected.

	// Get threshold receivers with a debounce time of 1 second (1000ms).
	m.SetDebouncePeriod(1000)

	m.RegisterMoistureReachedCallback(func(moisture uint16) {
		fmt.Printf("Moisture Value: %d\n", moisture)
	})

	// Configure threshold for moisture value "greater than 200".
	m.SetMoistureCallbackThreshold('>', 200, 0)

	fmt.Print("Press enter to exit.")
	fmt.Scanln()

}
