Imports System
Imports Tinkerforge

Module ExampleCallback
    Const HOST As String = "localhost"
    Const PORT As Integer = 4223
    Const UID As String = "XYZ" ' Change to your UID

    ' Callback subroutine for moisture value callback
    Sub MoistureCB(ByVal sender As BrickletMoisture, ByVal moisture As Integer)
        Console.WriteLine("Moisture Value: " + moisture.ToString())
    End Sub

    Sub Main()
        Dim ipcon As New IPConnection() ' Create IP connection
        Dim m As New BrickletMoisture(UID, ipcon) ' Create device object

        ipcon.Connect(HOST, PORT) ' Connect to brickd
        ' Don't use device before ipcon is connected

        ' Register moisture value callback to subroutine MoistureCB
        AddHandler m.Moisture, AddressOf MoistureCB

        ' Set period for moisture value callback to 1s (1000ms)
        ' Note: The moisture value callback is only called every second
        '       if the moisture value has changed since the last call!
        m.SetMoistureCallbackPeriod(1000)

        Console.WriteLine("Press key to exit")
        Console.ReadLine()
        ipcon.Disconnect()
    End Sub
End Module
