package main

import (
	"fmt"
	"github.com/tinkerforge/go-api-bindings/ipconnection"
	"github.com/tinkerforge/go-api-bindings/moisture_bricklet"
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

	// Get current moisture value.
	moisture, _ := m.GetMoistureValue()
	fmt.Printf("Moisture Value: \n", moisture)

	fmt.Print("Press enter to exit.")
	fmt.Scanln()

}
