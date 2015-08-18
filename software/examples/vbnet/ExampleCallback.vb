Imports Tinkerforge

Module ExampleCallback
    Const HOST As String = "localhost"
    Const PORT As Integer = 4223
    Const UID As String = "XYZ" ' Change to your UID

    ' Callback function for moisture value callback
    Sub MoistureCB(ByVal sender As BrickletMoisture, ByVal moisture As Integer)
        System.Console.WriteLine("Moisture Value: " + moisture.ToString())
    End Sub

    Sub Main()
        Dim ipcon As New IPConnection() ' Create IP connection
        Dim m As New BrickletMoisture(UID, ipcon) ' Create device object

        ipcon.Connect(HOST, PORT) ' Connect to brickd
        ' Don't use device before ipcon is connected

        ' Set period for moisture value callback to 1s (1000ms)
        ' Note: The moisture value callback is only called every second
        '       if the moisture value has changed since the last call!
        m.SetMoistureCallbackPeriod(1000)

        ' Register moisture value callback to function MoistureCB
        AddHandler m.Moisture, AddressOf MoistureCB

        System.Console.WriteLine("Press key to exit")
        System.Console.ReadLine()
        ipcon.Disconnect()
    End Sub
End Module
