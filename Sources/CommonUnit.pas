unit CommonUnit;

interface

uses
  System.SysUtils, Vcl.Controls, Winapi.Windows, YesNoUnit, SelectDirectoryUnit, SelectParentUnit, SelectFileUnit,
  Vcl.Printers, sListView, sPanel, Vcl.Forms, System.Math, System.Classes, System.Types, Winapi.Messages;

type
  StringL2 = String[2];
  TScanerDataMessage = packed record
    Msg: Cardinal;
    WParam: Integer;
    LParam: String;
    Result: LRESULT;
  end;

const
  atolDownload = 0;
  atolUpload   = 1;
  WM_ScanerData = WM_USER + 3;
  WM_ConnectScaner = WM_USER + 4;

function GetAppPath: String; // ���� �� ��������������� ���������� �� ������ �� �����
function YesNoDialog(MessageText: String; DialogType: SmallInt; Block: Boolean): Boolean; // ���������������� ������ "��/���"
function GetMarkDialog(arrayOfMarks: TStringDynArray; markType: Integer): String; // ������ ������� �����
function DelMarkDialog(arrayOfMarks: TStringDynArray; markType: Integer): Integer; // ������ �������� ����� �� ����
function ExchangeProcessDialog(exchangeType: Integer; exchangePath: String): Boolean; // ����������� �������� ������ �������
function SelectDirectoryDlg(DefPath: String): String; // ���������������� ������ ������ �����
function SelectFileDlg(DefPath: String): String; // ���������������� ������ ������ �����
function SelectParentDlg: String; // ������ ������ ������������ �������� ������
function GoodsSearchResultDlg(Parametr, Field: String): String; // ������ ������ ������ �� ����������� ������
function GoodsVisualSearchResultDlg: String; // ������ ������ ������ �� ����������� ������
function AbbrByLocale(LocID: LCID): String; // ������� ���� �����
procedure SetPrinterPageSize(PrinterName: String; PaperWidth, PaperLength: Integer); // ��������� ������� �������� ��� ��������
procedure LVScrollPage(ListView: TsListView; UpDown: Boolean); // ��������� LV �� ���� �������� ����� ��� ����
procedure AlignPanelControls(Panel: TsPanel); // ��������� ������ � ��������� ������ �� �������
procedure ScaleWindow(Form: TForm; Indent: Integer); // ��������������� ���� ��� ������� ����������
function RoundToEx(Value, Precision: Currency; Method: Integer): Currency; // ���������� �� �������� ��������� �������� ����� ��������� ������� (�������������, � ������� ���������� �������)
function BarcodeGen(Prefix: StringL2; Counter: String): String; // ��������� �� (Prefix - 2 ����� ��������; Counter - ������� ��� �� �� ��)
function IsCreatePossible(Path: String): Boolean; // �������� ����������� ������ �����
function StrToIntDefEx(inValue: String; defValue: Integer): Integer; // ����������� ������ � ����� �����, ���� �������� �������� ������� �� ���� ��� ������ ������
function StrToCurrDefEx(inValue: String; defValue: Currency): Currency; // ����������� ������ � Currency, ���� �������� �������� ������� �� ���� � ����������� ��� ������ ������
function StrToBoolDefEx(inValue: String; defValue: Boolean): Boolean;  // ����������� ������ � Boolean, ���� �������� �������� ������� �� 0, 1 ��� ������ ������

implementation

uses GoodsSearchResultUnit, GoodsVisualSearchUnit, ScanMarkUnit,
  DelMarkUnit, ExchangeProcessUnit;

// �������� ����������� ������ � �������
function IsCreatePossible(Path: String): Boolean;
var
  TFS: TFileStream;
begin
  Result := True;

  try
    TFS := TFileStream.Create(Path, fmCreate);
    TFS.Free;
  except
    Result := False
  end;
end;

// ���� �� ��������������� ���������� �� ������ �� �����
function GetAppPath: String;
begin
  Result := ExtractFilePath(ParamStr(0));
end;

// ���������������� ������ "��/���"
function YesNoDialog(MessageText: String; DialogType: SmallInt; Block: Boolean): Boolean;
begin
  formYesNo := TformYesNo.Create(nil);

  formYesNo.messageText := MessageText;
  formYesNo.dialogType := DialogType;
  formYesNo.block := Block;

  formYesNo.ShowModal;

  Result := formYesNo.ModalResult = mrYes;

  formYesNo.Free
end;

// ������ ������� �����
function GetMarkDialog(arrayOfMarks: TStringDynArray; markType: Integer): String;
begin
  formScanMark := TformScanMark.Create(nil);

  formScanMark.arrayOfMarks := arrayOfMarks;
  formScanMark.markType     := markType;

  formScanMark.ShowModal;

  Result := formScanMark.mark;

  formScanMark.Free;
end;

// ������ �������� ����� �� ����
function DelMarkDialog(arrayOfMarks: TStringDynArray; markType: Integer): Integer;
begin
  formDelMark := TformDelMark.Create(nil);
  formDelMark.arrayOfMarks := arrayOfMarks;
  formDelMark.markType     := markType;
  formDelMark.ShowModal;

  Result := formDelMark.markIndex;

  formDelMark.Free
end;

// ����������� �������� ������ �������
function ExchangeProcessDialog(exchangeType: Integer; exchangePath: String): Boolean;
begin
  formExchangeProcess              := TformExchangeProcess.Create(nil);
  formExchangeProcess.exchangeType := exchangeType;
  formExchangeProcess.exchangePath := exchangePath;
  formExchangeProcess.ShowModal;

  Result := formExchangeProcess.exchangeResult;

  formExchangeProcess.Free
end;

//���������������� ������ ������ �����
function SelectDirectoryDlg(DefPath: String): String;
begin
  formSelectDirectory := TformSelectDirectory.Create(nil);

  formSelectDirectory.Path := DefPath; //��� ����, ����� ����� ����� ���� ��� ������ �����

  formSelectDirectory.ShowModal;

  Result := formSelectDirectory.Path;

  formSelectDirectory.Free
end;

//���������������� ������ ������ �����
function SelectFileDlg(DefPath: String): String;
begin
  formSelectFile := TformSelectFile.Create(nil);

  formSelectFile.Hint := DefPath; //��� ����, ����� ����� ����� ���� ��� ������ �����

  formSelectFile.ShowModal;

  Result := formSelectFile.Hint;

  formSelectFile.Free
end;

//������ ������ ������������ �������� ������
function SelectParentDlg: String;
begin
  formSelectParent := TformSelectParent.Create(nil);
  formSelectParent.ShowModal;

  Result := formSelectParent.ParentDir;

  formSelectParent.Free
end;

//���������� ����� ������
function GoodsVisualSearchResultDlg: String;
begin
  formGoodsVisualSearch := TformGoodsVisualSearch.Create(nil);
  formGoodsVisualSearch.ShowModal;

  Result := formGoodsVisualSearch.SelectedCode;

  formGoodsVisualSearch.Free
end;

//������ ������ ������ �� ����������� ������
function GoodsSearchResultDlg(Parametr, Field: String): String;
begin
  formGoodsSearchResult := TformGoodsSearchResult.Create(nil);

  formGoodsSearchResult.Parametr := Parametr;
  formGoodsSearchResult.Field := Field;

  formGoodsSearchResult.ShowModal;

  Result := formGoodsSearchResult.SelectedCode;

  formGoodsSearchResult.Free;
end;

//������� ���� �����
function AbbrByLocale(LocID: LCID): String;
var
  Size, Res: Integer;
  Buf: PAnsiChar;
begin
  Size := GetLocaleInfoA(LocID, LOCALE_SABBREVLANGNAME, nil, 0);
  GetMem(Buf, Size);
  try
    Res := GetLocaleInfoA(LocID, LOCALE_SABBREVLANGNAME, Buf, Size);
    if Res = Size then
      Result := UpperCase(Copy(String(Buf), 1, 3))
    else
      Result := 'ERROR';
  finally
    FreeMem(Buf, Size);
  end;
end;

//��������� ������� �������� ��� ��������
procedure SetPrinterPageSize(PrinterName: String; PaperWidth, PaperLength: Integer);
var
  Device: array[0..255] of char;
  Driver: array[0..255] of char;
  Port: array[0..255] of char;
  hDMode: THandle;
  PDMode: PDEVMODE;
begin
  Printer.PrinterIndex := Printer.Printers.IndexOf(PrinterName);
  Printer.GetPrinter(Device, Driver, Port, hDMode);
  if hDMode <> 0 then
  begin
    pDMode := GlobalLock(hDMode);
    if pDMode <> nil then
    begin

     {Set to legal}
      pDMode^.dmFields := pDMode^.dmFields or dm_PaperSize;
      pDMode^.dmPaperSize := DMPAPER_LEGAL;

     {Set to custom size}
      pDMode^.dmFields := pDMode^.dmFields or
        DM_PAPERSIZE or
        DM_PAPERWIDTH or
        DM_PAPERLENGTH;
      pDMode^.dmPaperSize := DMPAPER_USER;
      pDMode^.dmPaperWidth := PaperWidth {SomeValueInTenthsOfAMillimeter};
      pDMode^.dmPaperLength := PaperLength {SomeValueInTenthsOfAMillimeter};

     {Set the bin to use}
      pDMode^.dmFields := pDMode^.dmFields or DMBIN_MANUAL;
      pDMode^.dmDefaultSource := DMBIN_MANUAL;

      GlobalUnlock(hDMode);
    end;
  end;
//  Printer.PrinterIndex := Printer.PrinterIndex;
//  Printer.BeginDoc;
//  Printer.Canvas.TextOut(100, 100, 'Test 1');
//  Printer.EndDoc;
end;

//��������� LV �� ���� �������� ����� ��� ����
procedure LVScrollPage(ListView: TsListView; UpDown: Boolean);
var
  ItemHeight: Integer;
begin
  ItemHeight := ListView.ClientHeight div ListView.VisibleRowCount; //��������������� ������ ����� ������

  LockWindowUpdate(ListView.Handle);

  if UpDown then
    ListView.Scroll(0, ItemHeight - ListView.ClientHeight) //�������� �� ������ ���������� ����� listview ������ ���������, �������� ������ ��������
  else
    ListView.Scroll(0, ListView.ClientHeight - ItemHeight); //�������� �� ������ ���������� ����� listview ������ ���������, �������� ������ ��������

  LockWindowUpdate(0);;
end;

//��������� ������ � ��������� ����������� �� �������
procedure AlignPanelControls(Panel: TsPanel);
var
  i, w: Integer;
begin
  w := Panel.Width div Panel.ControlCount - 1; //������ ������ ����� �� ���-�� ��������� � �� ����������� �������� �������� 1 ��� �������
  for i := 0 to Panel.ControlCount - 1 do
  begin
    Panel.Controls[i].Width := w;
    Panel.Controls[i].Left := (w + 1) * i;
  end;
  Panel.Controls[Panel.ControlCount - 1].Width := Panel.Width - Panel.Controls[Panel.ControlCount - 1].Left;
end;

//��������������� ���� ��� ������� ����������
procedure ScaleWindow(Form: TForm; Indent: Integer);
var
  M: Real;
  BaseScreenWidth, BaseScreenHeight, ScreenWidth, ScreenHeight: Integer;
begin
  with Form do
  begin
    Scaled := True; //����������� �� � ���, ��� ������������ ���� ������ ������

    BaseScreenWidth := Width;
    BaseScreenHeight := Height;

    //����� ������ ���� ������ ���������� ������ ����� ������
    ScreenWidth := Screen.Width - Indent;
    ScreenHeight := Screen.Height - Indent;

    if (ScreenWidth <> BaseScreenWidth) or (ScreenHeight <> BaseScreenHeight) then
    begin
      M := ScreenWidth / BaseScreenWidth; //����� ����������� ��������������� ����������
      if (Height * M) > ScreenHeight then //���� ����� ���������������, ����� �� ������ ����� ������ ������, �� ����� �������������� � ������������ ������, ����� ���������� �� ������� �� ������ � ��������� ���� �� �����
      begin
        ScaleBy(ScreenHeight, BaseScreenHeight);
        Width := ScreenWidth;
      end
      else
      begin
        ScaleBy(ScreenWidth, BaseScreenWidth);
        Height := ScreenHeight;
      end;
    end;

  end;
end;

//����������
function RoundToEx(Value, Precision: Currency; Method: Integer): Currency;
begin
  case Method of
    2: SetRoundMode(rmDown); //� ������� �������
    3: SetRoundMode(rmUp); //� ������� �������
  else
    SetRoundMode(rmNearest); //�������������
  end;

  if Precision > 0 then
    Result := Round(Value / Precision) * Precision
  else
    Result := Value

end;

//��������� ��
function BarcodeGen(Prefix: StringL2; Counter: String): String;
var
  CheckDigit, i, n: Integer;
  bc: String;
begin
  if Length(Counter) > 10 then
    begin
      YesNoDialog('�� �������� ������������ ����� ��������, �.�. ��������� ������������ ������.', 1, False);
      Result := '';
      Exit
    end;

  bc := Prefix + Format('%10.10d', [StrToInt(Counter)]); //��������� ����

  (*** ������ ������������ ������� ***)

  { 1. ����������� ����� �� ������ ��������;
    2. ��������� ������ 1 �������� �� 3;
    3. ����������� ����� �� �������� ��������;
    4. ����������� ���������� ������� 2 � 3;
    5. ����������� ����� � ������� ����� ������������� ������ � ��������� � ��� ���������� ������, ������� 10-��. }

  i := 0;
  n := 0;

  //��������� ������ �����
  repeat
    Inc(i, 2);
    n := n + StrToInt(bc[i]);
  until i >= 12;

  //��������� �������� �� 3
  CheckDigit := n * 3;

  i := -1;
  n := 0;

  //��������� �������� �����
  repeat
    Inc(i, 2);
    n := n + StrToInt(bc[i]);
  until i >= 11;

  //���������� ����������
  CheckDigit := CheckDigit + n;

  i := CheckDigit;

  //���� ��������� ������� ����� ������� 10
  while i mod 10 <> 0 do
    Inc(i);

  CheckDigit := i - CheckDigit;

  (*** ��������� ������ ������������ ������� ***)

  Result := bc + IntToStr(CheckDigit);
end;

// ����������� ������ � �����, ���� �������� �������� ������� �� ���� ��� ������ ������
function StrToIntDefEx(inValue: String; defValue: Integer): Integer;
begin
  if inValue = '' then
    Result := defValue
  else
    Result := StrToInt(inValue) // ���� inValue ������� �� �� ����, �� ����� exception, � ��� � ������ ����
end;

// ����������� ������ � Currency, ���� �������� �������� ������� �� ���� � ����������� ��� ������ ������
function StrToCurrDefEx(inValue: String; defValue: Currency): Currency;
begin
  if inValue = '' then
    Result := defValue
  else
    Result := StrToCurr(inValue) // ���� inValue ������� �� �� ���� � ����������� ��� ������ ������, �� ����� exception, � ��� � ������ ����
end;

// ����������� ������ � Boolean, ���� �������� �������� ������� �� 0, 1 ��� ������ ������
function StrToBoolDefEx(inValue: String; defValue: Boolean): Boolean;
begin
  if inValue = '' then
    Result := defValue
  else
    Result := StrToBool(inValue) // ���� inValue ������� �� �� 0, 1 ��� ������ ������, �� ����� exception, � ��� � ������ ����
end;

end.
