Imports System
Imports Tinkerforge

Module ExampleThreshold
    Const HOST As String = "localhost"
    Const PORT As Integer = 4223
    Const UID As String = "XYZ" ' Change XYZ to the UID of your Moisture Bricklet

    ' Callback subroutine for moisture value reached callback
    Sub MoistureReachedCB(ByVal sender As BrickletMoisture, ByVal moisture As Integer)
        Console.WriteLine("Moisture Value: " + moisture.ToString())
    End Sub

    Sub Main()
        Dim ipcon As New IPConnection() ' Create IP connection
        Dim m As New BrickletMoisture(UID, ipcon) ' Create device object

        ipcon.Connect(HOST, PORT) ' Connect to brickd
        ' Don't use device before ipcon is connected

        ' Get threshold callbacks with a debounce time of 1 second (1000ms)
        m.SetDebouncePeriod(1000)

        ' Register moisture value reached callback to subroutine MoistureReachedCB
        AddHandler m.MoistureReachedCallback, AddressOf MoistureReachedCB

        ' Configure threshold for moisture value "greater than 200"
        m.SetMoistureCallbackThreshold(">"C, 200, 0)

        Console.WriteLine("Press key to exit")
        Console.ReadLine()
        ipcon.Disconnect()
    End Sub
End Module
