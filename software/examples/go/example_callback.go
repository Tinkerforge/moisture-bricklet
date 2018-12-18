package main

import (
	"fmt"
	"github.com/Tinkerforge/go-api-bindings/ipconnection"
	"github.com/Tinkerforge/go-api-bindings/moisture_bricklet"
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

	m.RegisterMoistureCallback(func(moisture uint16) {
		fmt.Printf("Moisture Value: %d\n", moisture)
	})

	// Set period for moisture value receiver to 1s (1000ms).
	// Note: The moisture value callback is only called every second
	//       if the moisture value has changed since the last call!
	m.SetMoistureCallbackPeriod(1000)

	fmt.Print("Press enter to exit.")
	fmt.Scanln()

}
