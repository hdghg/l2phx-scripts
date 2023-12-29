var
    charId: Integer;
    sweepable: Integer;
    meId: Integer;
    meX, meY, meZ: Integer;

    procedure Init;
    begin
    end;
    procedure Free;
    begin
    end;

    procedure MessageSend(Msg:string);
    begin
        buf:=#$4A;
        WriteD(0);          // No sender
        WriteD(10);         // Announcement
        WriteS('');         // No nickname
        WriteS(Msg);
        SendToClient;
    end;

begin
    if FromClient and (pck[1] = #$01) then begin // MoveBackwardToLocation
        meId := 1;
        meX := ReadD(2);
        meY := ReadD(6);
        meZ := ReadD(10);
    end;

    if FromServer and (pck[1]=#$06) then begin // Die
         charId := ReadD(2);
         sweepable := ReadD(22);
         if (meId > 0) and (sweepable = 1) then begin
            buf := #$28; //TeleportToLocation
            WriteD(charId);
            WriteD(meX);
            WriteD(meY);
            WriteD(meZ);
            WriteS('');
            SendToClient;
         end
      end;
end.
