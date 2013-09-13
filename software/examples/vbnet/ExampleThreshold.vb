Imports Tinkerforge

Module ExampleThreshold
    Const HOST As String = "localhost"
    Const PORT As Integer = 4223
    Const UID As String = "XYZ" ' Change to your UID

    ' Callback for moisture value greater than 200
    Sub ReachedCB(ByVal sender As BrickletMoisture, ByVal moisture As Integer)
        System.Console.WriteLine("Moisture Value: " + moisture.ToString())
    End Sub

    Sub Main()
        Dim ipcon As New IPConnection() ' Create IP connection
        Dim m As New BrickletMoisture(UID, ipcon) ' Create device object

        ipcon.Connect(HOST, PORT) ' Connect to brickd
        ' Don't use device before ipcon is connected

        ' Get threshold callbacks with a debounce time of 1 seconds (1000ms)
        m.SetDebouncePeriod(1000)

        ' Register threshold reached callback to function ReachedCB
        AddHandler m.MoistureReached, AddressOf ReachedCB

        ' Configure threshold for "greater than 200"
        m.SetMoistureCallbackThreshold(">", 200, 0)

        System.Console.WriteLine("Press key to exit")
        System.Console.ReadKey()
        ipcon.Disconnect()
    End Sub
End Module
