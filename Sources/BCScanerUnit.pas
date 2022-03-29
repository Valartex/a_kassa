unit BCScanerUnit;

interface

uses
  Scaner_TLB, System.Types, System.StrUtils, System.SysUtils;

procedure BCSConnection(scaner451: TScaner45; chanel, comPortNumber, baudrate: Integer; prefix, sufix: String);

implementation

//uses CommonUnit;

procedure BCSConnection(scaner451: TScaner45; chanel, comPortNumber, baudrate: Integer; prefix, sufix: String);
var
  prefixArray, sufixArray: TStringDynArray;
  prefixStr, sufixStr: String;
  i: Integer;
begin
  if chanel = 1 then //USB
    scaner451.PortNumber := 100
  else
    scaner451.PortNumber := comPortNumber;

  scaner451.BaudRate := baudrate;

  prefixArray := SplitString(prefix, ' ');
  sufixArray := SplitString(sufix, ' ');

  for i := 0 to Length(prefixArray) - 1 do
    prefixStr := prefixStr + Char(StrToInt(Copy(prefixArray[i], 2, Length(prefixArray[i]))));

  for i := 0 to Length(sufixArray) - 1 do
    sufixStr := sufixStr + Char(StrToInt(Copy(sufixArray[i], 2, Length(sufixArray[i]))));

  scaner451.Prefix := prefixStr;
  scaner451.Suffix := sufixStr;

  scaner451.DeviceEnabled := True;
end;

end.
