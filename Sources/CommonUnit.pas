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

function GetAppPath: String; // путь до местонахождения приложения со слешем на конце
function YesNoDialog(MessageText: String; DialogType: SmallInt; Block: Boolean): Boolean; // модифицированный диалог "Да/Нет"
function GetMarkDialog(arrayOfMarks: TStringDynArray; markType: Integer): String; // диалог запроса марки
function DelMarkDialog(arrayOfMarks: TStringDynArray; markType: Integer): Integer; // диалог удаления марки из чека
function ExchangeProcessDialog(exchangeType: Integer; exchangePath: String): Boolean; // отображение процесса обмена данными
function SelectDirectoryDlg(DefPath: String): String; // модифицированный диалог выбора папки
function SelectFileDlg(DefPath: String): String; // модифицированный диалог выбора файла
function SelectParentDlg: String; // диалог выбора родительской товарной группы
function GoodsSearchResultDlg(Parametr, Field: String): String; // диалог выбора товара из результатов поиска
function GoodsVisualSearchResultDlg: String; // диалог выбора товара из результатов поиска
function AbbrByLocale(LocID: LCID): String; // текущий язык ввода
procedure SetPrinterPageSize(PrinterName: String; PaperWidth, PaperLength: Integer); // установка размера страницы для принтера
procedure LVScrollPage(ListView: TsListView; UpDown: Boolean); // прокрутка LV на одну страницу вверх или вниз
procedure AlignPanelControls(Panel: TsPanel); // изменение ширины и положения кнопок на панелях
procedure ScaleWindow(Form: TForm; Indent: Integer); // масштабирование окна под текущее разрешение
function RoundToEx(Value, Precision: Currency; Method: Integer): Currency; // округление до кратного заданному значению числа выбранным методом (математически, в большую илименьшую сторону)
function BarcodeGen(Prefix: StringL2; Counter: String): String; // генерация ШК (Prefix - 2 цифры префикса; Counter - счётчик для ШК из БД)
function IsCreatePossible(Path: String): Boolean; // проверка доступности записи файла
function StrToIntDefEx(inValue: String; defValue: Integer): Integer; // конвертация строки в целое число, если исходное значение состоит из цифр или пустой строки
function StrToCurrDefEx(inValue: String; defValue: Currency): Currency; // конвертация строки в Currency, если исходное значение состоит из цифр и разделителя или пустой строки
function StrToBoolDefEx(inValue: String; defValue: Boolean): Boolean;  // конвертация строки в Boolean, если исходное значение состоит из 0, 1 или пустой строки

implementation

uses GoodsSearchResultUnit, GoodsVisualSearchUnit, ScanMarkUnit,
  DelMarkUnit, ExchangeProcessUnit;

// проверка доступности записи в каталог
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

// путь до местонахождения приложения со слешем на конце
function GetAppPath: String;
begin
  Result := ExtractFilePath(ParamStr(0));
end;

// модифицированный диалог "Да/Нет"
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

// диалог запроса марки
function GetMarkDialog(arrayOfMarks: TStringDynArray; markType: Integer): String;
begin
  formScanMark := TformScanMark.Create(nil);

  formScanMark.arrayOfMarks := arrayOfMarks;
  formScanMark.markType     := markType;

  formScanMark.ShowModal;

  Result := formScanMark.mark;

  formScanMark.Free;
end;

// диалог удаления марки из чека
function DelMarkDialog(arrayOfMarks: TStringDynArray; markType: Integer): Integer;
begin
  formDelMark := TformDelMark.Create(nil);
  formDelMark.arrayOfMarks := arrayOfMarks;
  formDelMark.markType     := markType;
  formDelMark.ShowModal;

  Result := formDelMark.markIndex;

  formDelMark.Free
end;

// отображение процесса обмена данными
function ExchangeProcessDialog(exchangeType: Integer; exchangePath: String): Boolean;
begin
  formExchangeProcess              := TformExchangeProcess.Create(nil);
  formExchangeProcess.exchangeType := exchangeType;
  formExchangeProcess.exchangePath := exchangePath;
  formExchangeProcess.ShowModal;

  Result := formExchangeProcess.exchangeResult;

  formExchangeProcess.Free
end;

//модифицированный диалог выбора папки
function SelectDirectoryDlg(DefPath: String): String;
begin
  formSelectDirectory := TformSelectDirectory.Create(nil);

  formSelectDirectory.Path := DefPath; //для того, чтобы знать какой путь был выбран ранее

  formSelectDirectory.ShowModal;

  Result := formSelectDirectory.Path;

  formSelectDirectory.Free
end;

//модифицированный диалог выбора файла
function SelectFileDlg(DefPath: String): String;
begin
  formSelectFile := TformSelectFile.Create(nil);

  formSelectFile.Hint := DefPath; //для того, чтобы знать какой путь был выбран ранее

  formSelectFile.ShowModal;

  Result := formSelectFile.Hint;

  formSelectFile.Free
end;

//диалог выбора родительской товарной группы
function SelectParentDlg: String;
begin
  formSelectParent := TformSelectParent.Create(nil);
  formSelectParent.ShowModal;

  Result := formSelectParent.ParentDir;

  formSelectParent.Free
end;

//визуальный поиск товара
function GoodsVisualSearchResultDlg: String;
begin
  formGoodsVisualSearch := TformGoodsVisualSearch.Create(nil);
  formGoodsVisualSearch.ShowModal;

  Result := formGoodsVisualSearch.SelectedCode;

  formGoodsVisualSearch.Free
end;

//диалог выбора товара из результатов поиска
function GoodsSearchResultDlg(Parametr, Field: String): String;
begin
  formGoodsSearchResult := TformGoodsSearchResult.Create(nil);

  formGoodsSearchResult.Parametr := Parametr;
  formGoodsSearchResult.Field := Field;

  formGoodsSearchResult.ShowModal;

  Result := formGoodsSearchResult.SelectedCode;

  formGoodsSearchResult.Free;
end;

//текущий язык ввода
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

//установка размера страницы для принтера
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

//прокрутка LV на одну страницу вверх или вниз
procedure LVScrollPage(ListView: TsListView; UpDown: Boolean);
var
  ItemHeight: Integer;
begin
  ItemHeight := ListView.ClientHeight div ListView.VisibleRowCount; //приблизительная высота одной строки

  LockWindowUpdate(ListView.Handle);

  if UpDown then
    ListView.Scroll(0, ItemHeight - ListView.ClientHeight) //вычитаем из высоты клиентской части listview высоту заголовка, получаем размер страницы
  else
    ListView.Scroll(0, ListView.ClientHeight - ItemHeight); //вычитаем из высоты клиентской части listview высоту заголовка, получаем размер страницы

  LockWindowUpdate(0);;
end;

//изменение ширины и положения компонентов на панелях
procedure AlignPanelControls(Panel: TsPanel);
var
  i, w: Integer;
begin
  w := Panel.Width div Panel.ControlCount - 1; //ширину панели делим на кол-во контролов и из полученного значения вычитаем 1 для отступа
  for i := 0 to Panel.ControlCount - 1 do
  begin
    Panel.Controls[i].Width := w;
    Panel.Controls[i].Left := (w + 1) * i;
  end;
  Panel.Controls[Panel.ControlCount - 1].Width := Panel.Width - Panel.Controls[Panel.ControlCount - 1].Left;
end;

//масштабирование окна под текущее разрешение
procedure ScaleWindow(Form: TForm; Indent: Integer);
var
  M: Real;
  BaseScreenWidth, BaseScreenHeight, ScreenWidth, ScreenHeight: Integer;
begin
  with Form do
  begin
    Scaled := True; //информируем ОС о том, что масштабируем окно своими силами

    BaseScreenWidth := Width;
    BaseScreenHeight := Height;

    //новый размер окна равный разрешению экрана минус отступ
    ScreenWidth := Screen.Width - Indent;
    ScreenHeight := Screen.Height - Indent;

    if (ScreenWidth <> BaseScreenWidth) or (ScreenHeight <> BaseScreenHeight) then
    begin
      M := ScreenWidth / BaseScreenWidth; //узнаём коэффициент масштабирования интерфейса
      if (Height * M) > ScreenHeight then //если после масштабирования, форма по высоте будет больше экрана, то нужно масштабировать её относительно высоты, иначе компоненты не влезают по высоте и наползают друг на друга
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

//округление
function RoundToEx(Value, Precision: Currency; Method: Integer): Currency;
begin
  case Method of
    2: SetRoundMode(rmDown); //в меньшую сторону
    3: SetRoundMode(rmUp); //в большую сторону
  else
    SetRoundMode(rmNearest); //математически
  end;

  if Precision > 0 then
    Result := Round(Value / Precision) * Precision
  else
    Result := Value

end;

//генерация ШК
function BarcodeGen(Prefix: StringL2; Counter: String): String;
var
  CheckDigit, i, n: Integer;
  bc: String;
begin
  if Length(Counter) > 10 then
    begin
      YesNoDialog('Не возможно сформировать новый штрихкод, т.к. достигнут максимальный предел.', 1, False);
      Result := '';
      Exit
    end;

  bc := Prefix + Format('%10.10d', [StrToInt(Counter)]); //добавляем нули

  (*** расчёт контрольного разряда ***)

  { 1. Суммировать цифры на четных позициях;
    2. Результат пункта 1 умножить на 3;
    3. Суммировать цифры на нечетных позициях;
    4. Суммировать результаты пунктов 2 и 3;
    5. Контрольное число — разница между окончательной суммой и ближайшим к ней наибольшим числом, кратным 10-ти. }

  i := 0;
  n := 0;

  //суммируем четные цифры
  repeat
    Inc(i, 2);
    n := n + StrToInt(bc[i]);
  until i >= 12;

  //результат умножаем на 3
  CheckDigit := n * 3;

  i := -1;
  n := 0;

  //суммируем нечетные цифры
  repeat
    Inc(i, 2);
    n := n + StrToInt(bc[i]);
  until i >= 11;

  //складываем результаты
  CheckDigit := CheckDigit + n;

  i := CheckDigit;

  //ищем ближайшее большее число кратное 10
  while i mod 10 <> 0 do
    Inc(i);

  CheckDigit := i - CheckDigit;

  (*** закончили расчёт контрольного разряда ***)

  Result := bc + IntToStr(CheckDigit);
end;

// конвертация строки в число, если исходное значение состоит из цифр или пустой строки
function StrToIntDefEx(inValue: String; defValue: Integer): Integer;
begin
  if inValue = '' then
    Result := defValue
  else
    Result := StrToInt(inValue) // если inValue состоит не из цифр, то будет exception, и так и должно быть
end;

// конвертация строки в Currency, если исходное значение состоит из цифр и разделителя или пустой строки
function StrToCurrDefEx(inValue: String; defValue: Currency): Currency;
begin
  if inValue = '' then
    Result := defValue
  else
    Result := StrToCurr(inValue) // если inValue состоит не из цифр и разделителя или пустой строки, то будет exception, и так и должно быть
end;

// конвертация строки в Boolean, если исходное значение состоит из 0, 1 или пустой строки
function StrToBoolDefEx(inValue: String; defValue: Boolean): Boolean;
begin
  if inValue = '' then
    Result := defValue
  else
    Result := StrToBool(inValue) // если inValue состоит не из 0, 1 или пустой строки, то будет exception, и так и должно быть
end;

end.
