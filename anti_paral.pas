var
    nickName: String;
    classId: Integer;
    skillId, skillLvl: Integer;
    position: Integer;
    objectId: Integer;

    procedure Init; //will be called on script initialization
    begin
    end;
    
    procedure Free; //This method calls when script don't need anymore
    begin
    end;

    procedure MessageSend(Msg:string);
    begin
        buf:=#$4A;
        WriteD(0);          // No sender
        WriteD(10);         // Announcement
        WriteS('');
        WriteS(Msg);
        SendToClient;
    end;

    procedure Whisper(FromId: Integer; From: string; Msg: string);
    begin
        buf:=#$4A;
        WriteD(FromId);
        WriteD(2);         // Whisper
        WriteS(From);
        WriteS(Msg);
        SendToClient;
    end;

begin

    if (FromServer) and (pck[1]=#$03) then begin // CharInfo
        objectId := ReadD(18);    // ID of a character
        position := 22; // start of nickname
        nickName := ReadS(position);
        classId := ReadD(position + 8);
        case classId of
            32: begin
                Whisper(objectId, nickName, 'class: Palus Knight');
            end;
            33: begin
                Whisper(objectId, nickName, 'class: Shillien Knight');
            end;
            106: begin
                Whisper(objectId, nickName, 'class: Shillien Templar');
            end;
        end;
    end;

    if (FromServer) and (pck[1]=#$48) then begin // MagicSkillUse
        objectId := ReadD(2);    // ID of a character
        skillId := ReadD(10);
        skillLvl := ReadD(14);
        case skillId of
            279: begin
                Whisper(objectId, 'Shillien Knight', 'Uses skill: Lightning Strike. Lvl: ' + IntToStr(skillLvl));
            end;
        end;
    end;

end.