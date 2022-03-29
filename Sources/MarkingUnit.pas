unit MarkingUnit;

interface

uses
  System.SysUtils;

function Get1162(scanData: String; markType: Integer): String;

implementation

function Get1162(scanData: String; markType: Integer): String;
var
  markTypeCode, gtinTemp, gtin, serialTemp, serial, addBytes: String;
  gtinStart, gtinCount, serialStart, serialCount, i: Integer;
begin
  Result := '';

  case markType of
    1: // ��������
      begin
        Exit
      end;
    2: // ���
      begin
        Exit
      end;
    3: // ���������
      begin
        Exit
      end;
    4: // �����
      begin
        if Length(scanData) <> 29 then
          Exit;

        markTypeCode := '44 4D';
        gtinStart    := 1;
        gtinCount    := 14;
        serialStart  := 15;
        serialCount  := 11;
        addBytes     := '20 20';
      end;
    5: // �����
      begin
        if (Copy(scanData, 1, 2) <> '01') or (Pos('21', scanData) = 0) then
          Exit;

        markTypeCode := '44 4D';
        gtinStart    := 3;
        gtinCount    := 14;
        serialStart  := Pos('21', scanData) + 2;
        serialCount  := 13;
        addBytes     := '';
      end;
    6: // �������
      begin
        Exit
      end;
    7: // ���� ������������� ���������
      begin
        case Length(scanData) of
          8:
            begin
              markTypeCode := '45 08';
              gtinStart    := 1;
              gtinCount    := 8;
              serialStart  := 1;
              serialCount  := 0;
              addBytes     := '';
            end;
          13:
            begin
              markTypeCode := '45 0D';
              gtinStart    := 1;
              gtinCount    := 13;
              serialStart  := 1;
              serialCount  := 0;
              addBytes     := '';
            end;
        else
          Exit
        end;
      end;
  else
    Exit
  end;

  gtinTemp   := Copy(scanData, gtinStart, gtinCount);     // �������� GTIN
  serialTemp := Copy(scanData, serialStart, serialCount); // ������� serial

  try
    gtinTemp := IntToHex(StrToInt(gtinTemp), 12); // ����������� GTIN � 16-�������� ������� ���������; ������ - 12 �������� (6 ����)
  except
    Exit
  end;

  // ��������� � ������� ������� " "
  gtin := '';
  i := 1;
  repeat
    gtin := gtin + Copy(gtinTemp, i, 2) + ' ';
    i := i + 2;
  until i >= Length(gtinTemp);

  // �������� ���������� ����� ������� ������� � ASCII � ������������ ��� � HEX, �������� " " � ������� �������
  serial := '';
  for i := 1 to Length(serialTemp) do
    serial := serial + IntToHex(Ord(serialTemp[i]), 2) + ' ';

  Result := TrimLeft(markTypeCode + ' ' + gtin + serial + addBytes); // �������� ��� 1162; Trim ��� ���� ����� ������ ������ ����� GTIN, ���� Serial �����������
end;

end.
