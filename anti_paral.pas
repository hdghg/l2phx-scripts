var
    nickName: String;
    classId: Integer;
    skillId, skillLvl: Integer;
    position: Integer;

    procedure Init; //will be called on script initialization
    begin
    end;
    
    procedure Free; //This method calls when script don't need anymore
    begin
    end;

    procedure MessageSend(Msg:string);
    begin
        buf:=#$4A;
        WriteD(0);
        WriteD(10);
        WriteS('');
        WriteS(Msg);
        SendToClient;
    end;

begin

    if (FromServer) and (pck[1]=#$03) then begin // CharInfo
        position := 22; // start of nickname
        nickName := ReadS(position);
        classId := ReadD(position + 8);
        case classId of
            32: begin
                MessageSend('' + nickName + ' class: Palus Knight');
            end;
            33: begin
                MessageSend('' + nickName + ' class: Shillien Knight');
            end;
            106: begin
                MessageSend('' + nickName + ' class: Shillien Templar');
            end;
            17: begin
                MessageSend('' + nickName + ' class: Prophet');
            end;
            43: begin
                MessageSend('' + nickName + ' class: Shillien Elder');
            end;
        end;
    end;

    if (FromServer) and (pck[1]=#$48) then begin // MagicSkillUse
        skillId := ReadD(10);
        skillLvl := ReadD(14);
        case skillId of
            1040: begin
                MessageSend('Uses skill: Shield. Lvl: ' + IntToStr(skillLvl));
            end;
            279: begin
                MessageSend('Uses skill: Lightning Strike. Lvl: ' + IntToStr(skillLvl));
            end;
        end;
    end;

end.