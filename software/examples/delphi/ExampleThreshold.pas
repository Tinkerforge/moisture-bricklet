program ExampleThreshold;

{$ifdef MSWINDOWS}{$apptype CONSOLE}{$endif}
{$ifdef FPC}{$mode OBJFPC}{$H+}{$endif}

uses
  SysUtils, IPConnection, BrickletMoisture;

type
  TExample = class
  private
    ipcon: TIPConnection;
    m: TBrickletMoisture;
  public
    procedure ReachedCB(sender: TBrickletMoisture; const moisture: word);
    procedure Execute;
  end;

const
  HOST = 'localhost';
  PORT = 4223;
  UID = 'XYZ'; { Change to your UID }

var
  e: TExample;

{ Callback for moisture value greater than 200 }
procedure TExample.ReachedCB(sender: TBrickletMoisture; const moisture: word);
begin
  WriteLn(Format('Moisture Value: %d', [moisture]));
end;

procedure TExample.Execute;
begin
  { Create IP connection }
  ipcon := TIPConnection.Create;

  { Create device object }
  m := TBrickletMoisture.Create(UID, ipcon);

  { Connect to brickd }
  ipcon.Connect(HOST, PORT);
  { Don't use device before ipcon is connected }

  { Get threshold callbacks with a debounce time of 1 seconds (1000ms) }
  m.SetDebouncePeriod(1000);

  { Register threshold reached callback to procedure ReachedCB }
  m.OnMoistureReached := {$ifdef FPC}@{$endif}ReachedCB;

  { Configure threshold for "greater than 200" }
  m.SetMoistureCallbackThreshold('>', 200, 0);

  WriteLn('Press key to exit');
  ReadLn;
  ipcon.Destroy; { Calls ipcon.Disconnect internally }
end;

begin
  e := TExample.Create;
  e.Execute;
  e.Destroy;
end.
