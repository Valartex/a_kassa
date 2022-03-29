unit AtolExchangeUnit;

interface

uses
  System.SysUtils, System.Classes, System.StrUtils, System.Types, acProgressBar, Vcl.Forms, Winapi.Windows,
  Winapi.Messages;

function Download(fileName: String): Boolean;
function Upload(fileName: String): Boolean;

implementation

uses DBUnit, CommonUnit;

// �������� ������
function Download(fileName: String): Boolean;
const
  // $$$ADDQUANTITY - �������� ������ � ����������� ���������� �������
  // $$$REPLACEQUANTITY - �������� ������ � ���������� ���������� ������� � ��������� ������
  // $$$REPLACEQUANTITYWITHOUTSALE - �������� ������ � ���������� ���������� �������

  optionsForAdding: array[1..3] of String = ('$$$ADDQUANTITY', '$$$REPLACEQUANTITY', '$$$REPLACEQUANTITYWITHOUTSALE'); // �������� ���������� �������
var
  dlFile, logFile                : TStringList;
  startStr, i, j, n, taxCode     : Integer;
  goodsStr, flagsStr, barcodesStr: TStringDynArray;
  goodsRecord                    : TGoodsRecord;
  taxArray                       : TTaxArray;
begin
  Result := FileExists(fileName);
  if not Result then Exit;

  taxArray := DM1.GetTaxes; // �������� �� �� ������ �� ���� �������

  logFile := TStringList.Create;
  logFile.Append('������, ���������� ������:');

  dlFile := TStringList.Create;
  dlFile.LoadFromFile(fileName);

  if dlFile.count < 3 then Exit;

  Result := Trim(dlFile[0]) = '##@@&&'; // ������� ����� �������� �������
  if not Result then Exit;

  Result := Trim(dlFile[1]) = '#'; // ������� ����, ��� ���� ��� �� ����������
  if not Result then Exit;

  SendMessage(Application.MainFormHandle, WM_USER + 3, dlFile.Count, 1); // ��������� ������������� �������� ��� ProgressBar � ������� ����

  if dlFile.IndexOf('$$$DELETEALLWARES') > 0 then //������� ��� ������
    begin
      DM1.DeleteAllGoods
    end;

  if dlFile.IndexOf('$$$DELETEALLBARCODES') > 0 then //������� ��� ���������
    begin
      DM1.DeleteAllBarcodes
    end;

  if dlFile.IndexOf('$$$DELETEALLUSERS') > 0 then //������� ���� �������������
    begin
      DM1.DeleteAllCashiers
    end;

  if dlFile.IndexOf('$$$DELETEALLTAXRATES') > 0 then //������� ��� ��������� ������
    begin
      DM1.DeleteAllTaxes
    end;

  if dlFile.IndexOf('$$$DELETEALLCLIENTDISCS') > 0 then //������� ���� ��������
    begin

    end;

  if dlFile.IndexOf('$$$ADDUSERS') > 0 then //�������� �������������
    begin

    end;

  if dlFile.IndexOf('$$$ADDTAXRATES') > 0 then //�������� ��������� ������
    begin

    end;

  if dlFile.IndexOf('$$$ADDCLIENTDISCS') > 0 then //�������� ��������
    begin

    end;

  for j := 1 to Length(optionsForAdding) do
    begin

      DM1.StartTransaction;

      startStr := dlFile.IndexOf(optionsForAdding[j]); // ������� ��� �������� ���������� �������
      if startStr < 0 then Continue;

      i := startStr + 1;

      while (i < dlFile.Count) and (Copy(dlFile[i], 1, 3) <> '$$$') and (Trim(dlFile[i]) <> '') do // ���� �� ����� �� ����� ����� � �� ��������� �������
        begin
          SendMessage(Application.MainFormHandle, WM_USER + 2, 1, 1); // ��������� ProgressBar �� ������� �����

          try
            goodsStr    := SplitString(dlFile[i], ';');   // ��������� ������ � ����������� � ������ �� �����������
            flagsStr    := SplitString(goodsStr[7], ','); // ����� ������ (�����)
            barcodesStr := SplitString(goodsStr[1], ','); // �����-����

            with goodsRecord do
              begin
                // �������� �� ������������ ����� ����, �.�. �������. ������
                gCode       := goodsStr[0];   // ���
                if (Length(gCode) = 0) or (gCode[1] = ' ') then     // �.�. ��� ������������ ����
                  Abort;
                gName       := goodsStr[2];   // ������������
                gPicture    := goodsStr[30];  // ��������
                gVendorcode := goodsStr[25];  // �������
                gParent     := goodsStr[15];  // ��������
                gUnit       := 1;             // ������� ��������� �����

                // ��������� ������ (���� �� �������, �� ��� ���)
                gTax    := 0;
                taxCode := StrToIntDefEx(goodsStr[22], -1);
                if taxCode <> -1 then
                  for n := 0 to Length(taxArray) - 1 do
                    if taxArray[n].taxCode = taxCode then
                      begin
                        gTax := n;
                        Break
                      end;

                gPPR             := StrToIntDefEx(goodsStr[12], 1);         // ������� �������� ������� (���� �� ������, �� �����)
                gPLU             := StrToIntDefEx(goodsStr[24], 0);         // PLU (���� �� ������, �� 0)
                gDepartment      := StrToIntDefEx(goodsStr[36], 0);         // ������ ��� (���� �� �������, �� 0)
                gPrice           := StrToCurrDefEx(goodsStr[4], 0);         // ���� (���� �� �������, �� 0)
                gIsGroup         := not StrToBoolDefEx(goodsStr[16], True); // ������ ��� ����� (� ����� 1 - �����, 0 - ������, � ��� - ��������)
                gFractional      := StrToBoolDefEx(flagsStr[0], True);      // ������� ����������
                gUnloadInScales  := StrToIntDefEx(goodsStr[24], 0) > 0;     // ��������� � ����, ���� ������ PLU
                gPriceRequest    := StrToBoolDefEx(flagsStr[11], False);    // ������ ����
                gQuantityRequest := not StrToBoolDefEx(flagsStr[4], False); // ������ ���������� (� ����� ���� ���� ���������� "��� ����� ����������")
                gComposition     := goodsStr[49];                           // ������
                gType            := StrToIntDefEx(goodsStr[54], 0);         // ��� ������ (�������, �����, �����...)
                gBarcodes        := barcodesStr;                            // ������ ����������
              end;

            DM1.SaveGoods(goodsRecord);

          except
            logFile.Append(dlFile[i]);
          end;

          Inc(i);

        end;

      DM1.CommitTransaction;

    end;

 // �������� ���������
  startStr := dlFile.IndexOf('$$$ADDBARCODES');

  if startStr > 0 then
    begin
      DM1.StartTransaction;

      i := startStr + 1;

      while (i < dlFile.Count) and (Copy(dlFile[i], 1, 3) <> '$$$') and (Trim(dlFile[i]) <> '') do // ���� �� ����� �� ����� ����� � �� ��������� �������
        begin
          SendMessage(Application.MainFormHandle, WM_USER + 2, 1, 1); // ��������� ProgressBar �� ������� �����

          barcodesStr := SplitString(dlFile[i], ';');

          try
            DM1.SaveBarcode(barcodesStr[1], barcodesStr[0]);
          except
            logFile.Append(dlFile[i]);
          end;

          Inc(i);
        end;

      DM1.CommitTransaction;

    end;

  SendMessage(Application.MainFormHandle, WM_USER + 2, 0, 1); // �������� ProgressBar �� ������� �����

  logFile.SaveToFile(DM1.GetCommonSettings.exchangePath + 'LoadResult.txt');

  dlFile.Free;
  logFile.Free
end;

// �������� ������
function Upload(fileName: String): Boolean;
begin

end;

end.
