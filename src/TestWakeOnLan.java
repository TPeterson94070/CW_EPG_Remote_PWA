package com.cwepg.test;

import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.util.Arrays;

/**
 * Sends one magic packet to test WakeOnLanListener. Run as a Java Application.
 * Arguments: [destination address] [MAC address] [UDP port].
 * Defaults: 127.0.0.1 02:00:00:00:00:01 9.
 * For a real wakeup, supply the LAN broadcast address and target computer's MAC.
 */
public class TestWakeOnLan {
    public static void main(String[] args) throws IOException {
        if (args.length > 3) {
            throw new IllegalArgumentException(
                    "Usage: TestWakeOnLan [destination address] [MAC address] [UDP port]");
        }
        String destination = args.length > 0 ? args[0] : "127.0.0.1";
        String mac = args.length > 1 ? args[1] : "02:00:00:00:00:01";
        int port = args.length > 2 ? Integer.parseInt(args[2]) : 9;
        if (port < 1 || port > 65535) {
            throw new IllegalArgumentException("UDP port must be between 1 and 65535");
        }
        byte[] bytes = createMagicPacket(mac);
        DatagramPacket packet = new DatagramPacket(bytes, bytes.length,
                InetAddress.getByName(destination), port);
        try (DatagramSocket socket = new DatagramSocket()) {
            socket.setBroadcast(true);
            socket.send(packet);
        }
        System.out.println("Sent " + bytes.length + " byte Wake-on-LAN packet for "
                + mac + " to " + destination + ":" + port);
    }

    /** Six FF bytes followed by sixteen copies of the six-byte MAC address. */
    public static byte[] createMagicPacket(String macAddress) {
        if (macAddress == null || !macAddress.matches(
                "(?i)[0-9a-f]{2}([:-])[0-9a-f]{2}(\\1[0-9a-f]{2}){4}")) {
            throw new IllegalArgumentException(
                    "MAC address must contain six hexadecimal pairs, e.g. 02:00:00:00:00:01");
        }
        String[] pairs = macAddress.split("[:-]");
        byte[] mac = new byte[6];
        for (int i = 0; i < mac.length; i++) {
            mac[i] = (byte) Integer.parseInt(pairs[i], 16);
        }
        byte[] packet = new byte[102];
        Arrays.fill(packet, 0, 6, (byte) 0xff);
        for (int offset = 6; offset < packet.length; offset += mac.length) {
            System.arraycopy(mac, 0, packet, offset, mac.length);
        }
        return packet;
    }
}
(************* Copied from AI Chat Window ***************
program TestWakeOnLan;

{$APPTYPE CONSOLE}

uses
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
                           not TRegEx.IsMatch(MacAddress,
                                  '(?i)^[0-9a-f]{2}([:\-])[0-9a-f]{2}(\1[0-9a-f]{2}){4}$') then
                                      raise EArgumentException.Create(
                                            'MAC address must contain six hexadecimal pairs, e.g.
                                            02:00:00:00:00:01');

                                              // Split into six hex pairs
                                                Pairs := TRegEx.Split(MacAddress, '[:\-]');
                                                  if Length(Pairs) <> 6 then
                                                      raise EArgumentException.Create(
                                                            'MAC address must contain six hexadecimal pairs, e.g. 02:00:00:00:00:01');

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
                                                                                                            // Main entry
                                                                                                            point
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
                                                                                                                                          raise EArgumentException.Create(
                                                                                                                                                  'Usage: TestWakeOnLan [destination address] [MAC address] [UDP port]');

                                                                                                                                                      Destination := IfThen(ParamCount >= 1, ParamStr(1), '127.0.0.1');
                                                                                                                                                          Mac         := IfThen(ParamCount >= 2, ParamStr(2), '02:00:00:00:00:01');

                                                                                                                                                              if ParamCount >= 3 then
                                                                                                                                                                    Port := StrToIntDef(ParamStr(3), -1)
                                                                                                                                                                        else
                                                                                                                                                                              Port := 9;

                                                                                                                                                                                  if (Port < 1) or (Port > 65535) then
                                                                                                                                                                                        raise EArgumentException.Create('UDP port must be between 1 and
                                                                                                                                                                                        65535');

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


                                                                                                                                                                                                                                                      *)