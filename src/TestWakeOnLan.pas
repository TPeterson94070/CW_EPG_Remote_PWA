unit TestWakeOnLan;
//
//program TestWakeOnLan;

//{$APPTYPE CONSOLE}
interface

implementation
uses
  System.StrUtils,
  System.SysUtils,
  System.RegularExpressions,
  IdUDPClient,
  IdGlobal;

  //------------------------------------------------------------------------------
  // Six FF bytes followed by sixteen copies of the six-byte MAC address.
  //------------------------------------------------------------------------------
function CreateMagicPacket(const MacAddress: string): TBytes;
var
  Pairs : TArray<string>;
  Mac   : TBytes;
  Packet: TBytes;
  I     : Integer;
  Offset: Integer;
begin
  // Validate MAC address format
  if (MacAddress = '') or
    not TRegEx.IsMatch(MacAddress, '(?i)^[0-9a-f]{2}([:\-])[0-9a-f]{2}(\1[0-9a-f]{2}){4}$')} then
    raise EArgumentException.Create('MAC address must contain six hexadecimal pairs, e.g. 02:00:00:00:00:01');

  // Split into six hex pairs
  Pairs := TRegEx.Split(MacAddress, '[:\-]');
  if Length(Pairs) <> 6 then
    raise EArgumentException.Create('MAC address must contain six hexadecimal pairs, e.g. 02:00:00:00:00:01');

  // Parse each hex pair into a byte
  SetLength(Mac, 6);
  for I := 0 to 5 do
    Mac[I] := Byte(StrToInt('$' + Pairs[I]));

  // Build the 102-byte magic packet
  //   Bytes  0..5   : six 0xFF bytes
  //   Bytes  6..101 : sixteen copies of the six-byte MAC
  SetLength(Packet, 102);

  for I := 0 to 5 do
    Packet[I] := $FF;

  Offset := 6;
  while Offset < Length(Packet) do
  begin
    for I := 0 to 5 do
      Packet[Offset + I] := Mac[I];
    Inc(Offset, 6);
  end;

  Result := Packet;
end;

//------------------------------------------------------------------------------
// Main entry point
//------------------------------------------------------------------------------
var
  Destination: string;
  Mac        : string;
  Port       : Integer;
  MagicBytes : TBytes;
  UDPClient  : TIdUDPClient;
  RawBytes   : TIdBytes;
  I          : Integer;
begin
try
// Parse command-line arguments (ParamStr(0) is the executable name)
  if ParamCount > 3 then
    raise EArgumentException.Create('Usage: TestWakeOnLan [destination address] [MAC address] [UDP port]');

  Destination := IfThen(ParamCount >= 1, ParamStr(1), '127.0.0.1');
  Mac         := IfThen(ParamCount >= 2, ParamStr(2), '02:00:00:00:00:01');

  if ParamCount >= 3 then
    Port := StrToIntDef(ParamStr(3), -1)
  else
    Port := 9;

  if (Port < 1) or (Port > 65535) then
    raise EArgumentException.Create('UDP port must be between 1 and 65535');

// Build the magic packet
  MagicBytes := CreateMagicPacket(Mac);

// Convert TBytes to TIdBytes for Indy
  SetLength(RawBytes, Length(MagicBytes));
  for I := 0 to High(MagicBytes) do
    RawBytes[I] := MagicBytes[I];

// Send via UDP
  UDPClient := TIdUDPClient.Create(nil);
  try
    UDPClient.BroadcastEnabled := True;
    UDPClient.Host             := Destination;
    UDPClient.Port             := Port;
    UDPClient.Active           := True;
    UDPClient.SendBuffer(TIdBytes(RawBytes), Length(RawBytes));
  finally
    UDPClient.Active := False;
    UDPClient.Free;
  end;
finally

end;
(************* Complete Code ***************
Here's the completed
code:

```pascal
  SetLength(RawBytes, Length(MagicBytes));
  for I := 0 to
High(MagicBytes) do
    RawBytes[I] := MagicBytes[I];

  // Send via UDP

UDPClient := TIdUDPClient.Create(nil);
  try
    UDPClient.BroadcastEnabled := True;
    UDPClient.Host             := Destination;
    UDPClient.Port := Port;
    UDPClient.Active           := True;

UDPClient.SendBuffer(TIdBytes(RawBytes), Length(RawBytes));
  finally

UDPClient.Active := False;
    UDPClient.Free;
  end;
```

Here's a more
complete version with full context for a Wake-on-LAN (WOL)
implementation:

```pascal
procedure SendWakeOnLAN(const MACAddress: string;
const Destination: string; const Port: Integer);
var
  MagicBytes : array of
Byte;
  RawBytes   : array of Byte;
  UDPClient  : TIdUDPClient;
  MACBytes
: array[0..5] of Byte;
  I, J       : Integer;
  MACParts   :
TArray<string>;
begin
  // Parse MAC address
  MACParts :=
MACAddress.Split([':','-']);
  if Length(MACParts) <> 6 then
    raise
Exception.Create('Invalid MAC address format');

  for I := 0 to 5 do

MACBytes[I] := StrToInt('$' + MACParts[I]);

  // Build Magic Packet
  // 6
bytes of 0xFF followed by 16 repetitions of the MAC address

SetLength(MagicBytes, 102); // 6 + (16 * 6) = 102 bytes

  // First 6 bytes:
0xFF
  for I := 0 to 5 do
    MagicBytes[I] := $FF;

  // Next 96 bytes: MAC
address repeated 16 times
  for I := 0 to 15 do
    for J := 0 to 5 do

MagicBytes[6 + (I * 6) + J] := MACBytes[J];

  // Copy to RawBytes

SetLength(RawBytes, Length(MagicBytes));
  for I := 0 to High(MagicBytes) do

RawBytes[I] := MagicBytes[I];

  // Send via UDP
  UDPClient :=
TIdUDPClient.Create(nil);
  try
    UDPClient.BroadcastEnabled := True;

UDPClient.Host             := Destination;
    UDPClient.Port             :=
Port;
    UDPClient.Active           := True;

UDPClient.SendBuffer(TIdBytes(RawBytes), Length(RawBytes));
  finally

UDPClient.Active := False;
    UDPClient.Free;
  end;
end;

// Example
usage:
// SendWakeOnLAN('AA:BB:CC:DD:EE:FF', '255.255.255.255', 9);
```

Key
points about this implementation:

1. **Magic Packet Structure**:
   - Starts
with 6 bytes of `0xFF`
   - Followed by the target MAC address repeated 16
times
   - Total of 102 bytes

2. **UDP Settings**:
   - `BroadcastEnabled`
is set to `True` for broadcast support
   - Common ports used are `7` or `9`

- Destination can be a broadcast address like `255.255.255.255`

3.
**Cleanup**:
   - Uses `try/finally` to ensure the UDP client is properly
closed and freed

4. **Requirements**:
   - Uses **Indy** components
(`TIdUDPClient`)
   - Include `IdUDPClient` in your uses clause
*)


end.
