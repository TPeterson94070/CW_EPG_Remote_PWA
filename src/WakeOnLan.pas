unit WakeOnLan;

interface

implementation

uses
  System.SysUtils,
  System.StrUtils
// , Web, JS, System.NetEncoding
  ;

procedure SendWakeOnLAN(const MACAddress: string; const Destination: string; const Port: Integer);
var
  MagicBytes : array of Byte;
  RawBytes   : array of Byte;
//  UDPClient  : TIdUDPClient;
  MACBytes   : array[0..5] of Byte;
  I, J       : Integer;
  MACParts   : TArray<string>;
begin
  // Parse MAC address
  MACParts := MACAddress.Split([':','-']);
//  if Length(MACParts) <> 6 then
//    raise Exception.Create('Invalid MAC address format');

  for I := 0 to 5 do
    MACBytes[I] := StrToInt('$' + MACParts[I]);

  // Build Magic Packet
  // 6 bytes of 0xFF followed by 16 repetitions of the MAC address
  SetLength(MagicBytes, 102); // 6 + (16 * 6) = 102 bytes

  // First 6 bytes: 0xFF
  for I := 0 to 5 do
    MagicBytes[I] := $FF;

  // Next 96 bytes: MAC address repeated 16 times
  for I := 0 to 15 do
    for J := 0 to 5 do
      MagicBytes[6 + (I * 6) + J] := MACBytes[J];

  // Copy to RawBytes for Indy
  SetLength(RawBytes, Length(MagicBytes));
  for I := 0 to High(MagicBytes) do
    RawBytes[I] := MagicBytes[I];



//  SendViaUDP(Destination, Port, RawBytes);

  // Send via UDP
//  UDPClient :=  TIdUDPClient.Create(nil);
//  try
//    UDPClient.BroadcastEnabled := True;
//    UDPClient.Host             := Destination;
//    UDPClient.Port             := Port;
//    UDPClient.Active           := True;
//    UDPClient.SendBuffer(TIdBytes(RawBytes), Length(RawBytes));
//  finally
//    UDPClient.Active := False;
//    UDPClient.Free;
//  end;

// WebRTC is the closest browser equivalent but needs signaling server
{$IfDef PAS2JS}
asm
  // JavaScript interop for WebRTC
  var pc = new RTCPeerConnection();
  var dc = pc.createDataChannel('udp-like', {
    ordered: false,      // UDP-like: no ordering
    maxRetransmits: 0    // UDP-like: no retransmission
  });
  dc.send(data);
end;
{$EndIf}

(************* Complete Code ***************
Here's the completed code with
proper Pascal/PAS2JS structure:

```pascal
procedure
SendDataViaWebRTC(const data: string);
var
  pc: JSValue;
  dc:
JSValue;
begin
{$IfDef PAS2JS}
  asm
    // JavaScript interop for WebRTC
    var config =
    {
      iceServers: [
        { urls: 'stun:stun.l.google.com:19302' }

      ]
    };

    // Create RTCPeerConnection with configuration
    var pc = new RTCPeerConnection(config);

    // Create DataChannel with UDP-like settings
    var dc = pc.createDataChannel('udp-like', {
      ordered: false,       // UDP-like: no ordering
      maxRetransmits: 0     // UDP-like: no retransmission
    });

    // Handle DataChannel events
    dc.onopen = function() {
      console.log('DataChannel opened');
      try {
        // Send data when channel is open
        dc.send(data);

    console.log('Data sent:', data);
      } catch(e) {

    console.error('Error sending data:', e);
      }
    };

    dc.onclose = function() {
      console.log('DataChannel closed');
    };

    dc.onerror = function(error) {
      console.error('DataChannel error:', error);

    };

    dc.onmessage = function(event) {
      console.log('Received message:', event.data);
    };

    // Handle ICE candidates

    pc.onicecandidate = function(event) {
      if (event.candidate) {

      console.log('New ICE candidate:', event.candidate);
      }
    };

    // Handle connection state changes
    pc.onconnectionstatechange = function() {

      console.log('Connection state:', pc.connectionState);

      switch(pc.connectionState) {
        case 'connected':

      console.log('WebRTC Connected');
          break;
        case 'disconnected':
          console.log('WebRTC Disconnected');

          break;
        case 'failed':
          console.error('WebRTC Connection Failed');
          pc.close();
          break;
        case 'closed':

          console.log('WebRTC Connection Closed');
          break;
      }
    };


// Create and set local description (offer)
    pc.createOffer()

    .then(function(offer) {
        return pc.setLocalDescription(offer);

})
      .then(function() {
        console.log('Local description set successfully');
      })
      .catch(function(error) {

        console.error('Error creating offer:', error);
      });

  end;
end;

//
Example usage procedure
procedure InitializeWebRTC;
begin
  asm
    // Check if WebRTC is supported
    if (typeof RTCPeerConnection === 'undefined') {

    console.error('WebRTC is not supported in this browser');
      return;
    }
    console.log('WebRTC is supported');
  end;

  // Call the send procedure
  SendDataViaWebRTC('Hello WebRTC');
end;

{$EndIf}
```

Key features of this completed code:

1. **Proper Pascal Procedure**: Wrapped the ASM block in a proper Pascal procedure

2. **RTCPeerConnection Configuration**: Added STUN server configuration for ICE candidate gathering

3. **Event Handlers**:
   - `onopen`: Sends data when channel is ready
   - `onclose`: Handles channel closure
   - `onerror`: Handles errors
   - `onmessage`: Handles incoming messages

4. **ICE Handling**: Added `onicecandidate` handler for WebRTC connection establishment

5. **Connection State Management**:
    Added `onconnectionstatechange` to monitor connection status

6. **Offer Creation**: Added `createOffer()` chain for WebRTC signaling

7. **Error Handling**: Added try-catch blocks and promise error handling

8. **Browser Support Check**: Added WebRTC support detection in `InitializeWebRTC`

> **Note**: For a complete WebRTC implementation,
*)




end;

end.
