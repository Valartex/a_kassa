unit FRDriverUnit;

interface

uses
  {Fptr10Lib_TLB, Vcl.OleServer,} //закоментировать в рабочем варианте приложения
  System.Win.ComObj, System.Variants, System.SysUtils, Dialogs, System.Types, System.StrUtils;

type
  TFRError = record
    ErrorCode: Integer;
    ErrorText: String;
  end;

  TOFDError = record
    NetworkError:     Longint;
    NetworkErrorText: String;
    OFDError:         Longint;
    OFDErrorText:     String;
    FNError:          Longint;
    FNErrorText:      String;
  end;

  TPosInfo = record
    gName: String;
    gCode: String;
    gPrice: Currency;
    gQuantity: Real;
    gTaxType: Integer;
    gDiscount: Real;
    gPPR: Integer;
    gMark: String;
  end;

  TFRDriver = class(TObject)
  private
    //CompReg1: TCompReg;
    //fptr: TFptr; //для удобства работы с кодом
    fptr    : OleVariant; //для рабочего варианта приложения
    Emulator: Boolean;
  public
    constructor Create(const Driver: Integer; const Emulator: Boolean);
    destructor Destroy; override;

    function Connection(Chanel, ComPortNumber, Baudrate: Integer; IP, MAC: String): TFRError; //подключение к ФР
    procedure Disconnect; //отключение от ФР

    function OpenSession(CashierName, CashierINN: String): Boolean; //открыть смену
    function CloseSession(CashierName, CashierINN: String): Boolean; //закрыть смену
    function GetSessionState: Integer; //состояние смены
    function IsSessionClosed: Boolean; //закрыта ли смена
    function IsSessionExpired: Boolean; //истекла ли смена

    function CashBoxSum: Currency; //сумма в ДЯ
    procedure OpenDrawer; //открыть ДЯ

    function CashIn(Sum: Currency): TFRError; //внесение
    function CashOut(Sum: Currency): TFRError; //выплата

    function CashierLogin(CashierName, CashierINN: String): TFRError; //регистрация кассира
    function OpenReceipt(ReceiptType, DigitalCopyAddress, CashierName, CashierINN, ParentDoc, ParentDocNum: String; DigitalReceipt: Boolean; ParentDocDate: TDateTime): TFRError; //открытие чека
    function OpenNonFiscalReceipt(CashierName, CashierINN: String): TFRError; //открытие нефискального чека
    function PosRegistration(posInfo: TPosInfo): TFRError; //регистрация позиции
    function PaymentRegistration(PaymentType: Integer; PaymentSum: Currency): TFRError; //регистрация оплаты
    function TotalRegistration(TotalSum: Currency): TFRError; //регистрация итога
    procedure CloseReceipt; //закрытие чека
    function CloseNonFiscalReceipt: TFRError; //закрытие нефискального чека
    procedure CancelReceipt; //отмена чека
    function GetReceiptState: Integer; //состояние чека
    function PrintStr(Str: String; Alignment, FontType: Integer; DblWidth, DblHeight: Boolean): TFRError; //печать строки

    function ReceiptTypeToInt(ReceiptType: String): Integer; //преобразование строкового названия типа чека в числовое значение
    function IntToReceiptType(ReceiptCode: Integer): String; //преобразование кода типа чека в осмысленное значение (продажа, возврат и т.п.)

    procedure LastDocumentCopy; //печать копии последнего документ
    procedure XReport; //X-отчёт

    function GetDateTime: TDateTime; //получить дату/время из ФР
    function SetDateTime: TFRError; //установить текущую дату/время в ФР

    function GetFNRemain: TDateTime; //срок действия ФН
    function GetOFDExchangeError: TOFDError; //ошибка обмена с ОФД
  end;

var
  frDriver: TFRDriver;

implementation

{ TFRDriver }

uses CommonUnit;

// преобразование строкового названия типа чека в числовое значение
function TFRDriver.ReceiptTypeToInt(ReceiptType: String): Integer;
begin
  if Emulator then
    Exit;

  ReceiptType := AnsiLowerCase(ReceiptType);

  if ReceiptType = 'продажа' then
    Result := fptr.LIBFPTR_RT_SELL
  else
  if ReceiptType = 'возврат' then
    Result := fptr.LIBFPTR_RT_SELL_RETURN
  else
  if ReceiptType = 'расход' then
    Result := fptr.LIBFPTR_RT_BUY
  else
  if ReceiptType = 'возврат расхода' then
    Result := fptr.LIBFPTR_RT_BUY_RETURN
  else
  if ReceiptType = 'коррекция прихода' then
    Result := fptr.LIBFPTR_RT_SELL_CORRECTION
  else
  if ReceiptType = 'коррекция расхода' then
    Result := fptr.LIBFPTR_RT_BUY_CORRECTION
  else
  if ReceiptType = 'коррекция возврата расхода' then
    Result := fptr.LIBFPTR_RT_BUY_RETURN_CORRECTION
  else
  if ReceiptType = 'коррекция возврата прихода' then
    Result := fptr.LIBFPTR_RT_SELL_RETURN_CORRECTION
  else
    Result := -1;
end;

// преобразование кода типа чека в осмысленное значение (продажа, возврат и т.п.)
function TFRDriver.IntToReceiptType(ReceiptCode: Integer): String;
begin
  if Emulator then
    Exit;

  if ReceiptCode = fptr.LIBFPTR_RT_SELL then
    Result := 'Продажа'
  else
  if ReceiptCode = fptr.LIBFPTR_RT_SELL_RETURN then
    Result := 'Возврат'
  else
  if ReceiptCode = fptr.LIBFPTR_RT_BUY then
    Result := 'Расход'
  else
  if ReceiptCode = fptr.LIBFPTR_RT_BUY_RETURN then
    Result := 'Возврат расхода'
  else
  if ReceiptCode = fptr.LIBFPTR_RT_SELL_CORRECTION then
    Result := 'Коррекция прихода'
  else
  if ReceiptCode = fptr.LIBFPTR_RT_BUY_CORRECTION then
    Result := 'Коррекция расхода'
  else
  if ReceiptCode = fptr.LIBFPTR_RT_BUY_RETURN_CORRECTION then
    Result := 'Коррекция возврата расхода'
  else
  if ReceiptCode = fptr.LIBFPTR_RT_SELL_RETURN_CORRECTION then
    Result := 'Коррекция возврата прихода'
  else
    Result := ''
end;

//регистрация кассира
function TFRDriver.CashierLogin(CashierName, CashierINN: String): TFRError;
begin
  if Emulator then
    begin
      Result.ErrorCode := 0;
      Exit;
    end;

  fptr.setParam(1021, CashierName);
//  if Trim(CashierINN) <> '' then
//    fptr.setParam(1203, CashierINN);
  fptr.operatorLogin;

  Result.ErrorCode := fptr.errorCode;
  Result.ErrorText := fptr.errorDescription;
end;

//открыть смену
function TFRDriver.OpenSession(CashierName, CashierINN: String): Boolean;
begin
  if Emulator then
    Exit;

  CashierLogin(CashierName, CashierINN);

  fptr.openShift;
  fptr.checkDocumentClosed;
end;

//закрыть смену
function TFRDriver.CloseSession(CashierName, CashierINN: String): Boolean;
begin
  if Emulator then
    Exit;

  CashierLogin(CashierName, CashierINN);

  fptr.setParam(fptr.LIBFPTR_PARAM_REPORT_TYPE, fptr.LIBFPTR_RT_CLOSE_SHIFT);
  fptr.report;

  fptr.checkDocumentClosed;
end;

//сумма в ДЯ
function TFRDriver.CashBoxSum: Currency;
begin
  if Emulator then
    Exit;

  fptr.setParam(fptr.LIBFPTR_PARAM_DATA_TYPE, fptr.LIBFPTR_DT_CASH_SUM);
  fptr.queryData;

  Result := fptr.getParamDouble(fptr.LIBFPTR_PARAM_SUM);
end;

//открыть ДЯ
procedure TFRDriver.OpenDrawer;
begin
  if Emulator then
    Exit;

  fptr.openDrawer;
end;

//состояние смены
//LIBFPTR_SS_CLOSED - смена закрыта
//LIBFPTR_SS_OPENED - смена открыта
//LIBFPTR_SS_EXPIRED - смена истекла (продолжительность смены больше 24 часов)
function TFRDriver.GetSessionState: Integer;
begin
  if Emulator then
    Exit;

  fptr.setParam(fptr.LIBFPTR_PARAM_DATA_TYPE, fptr.LIBFPTR_DT_SHIFT_STATE);
  fptr.queryData;

  Result := fptr.getParamInt(fptr.LIBFPTR_PARAM_SHIFT_STATE);
end;

//закрыта ли смена
function TFRDriver.IsSessionClosed: Boolean;
begin
  if Emulator then
    Exit;

  Result := GetSessionState = fptr.LIBFPTR_SS_CLOSED
end;

//истекла ли смена
function TFRDriver.IsSessionExpired: Boolean;
begin
  if Emulator then
    Exit;

  Result := GetSessionState = fptr.LIBFPTR_SS_EXPIRED
end;

//внесение
function TFRDriver.CashIn(Sum: Currency): TFRError;
begin
  if Emulator then
    begin
      Result.ErrorCode := 0;
      Exit;
    end;

  fptr.setParam(fptr.LIBFPTR_PARAM_SUM, Sum);
  fptr.cashIncome;

  Result.ErrorCode := fptr.errorCode;
  Result.ErrorText := fptr.errorDescription;
end;

//выплата
function TFRDriver.CashOut(Sum: Currency): TFRError;
begin
  if Emulator then
    begin
      Result.ErrorCode := 0;
      Exit;
    end;

  fptr.setParam(fptr.LIBFPTR_PARAM_SUM, Sum);
  fptr.cashOutcome;

  Result.ErrorCode := fptr.errorCode;
  Result.ErrorText := fptr.errorDescription;
end;

//открытие чека
function TFRDriver.OpenReceipt(ReceiptType, DigitalCopyAddress, CashierName, CashierINN, ParentDoc, ParentDocNum: String; DigitalReceipt: Boolean; ParentDocDate: TDateTime): TFRError;
var
  rt: Integer;
  CorrectionInfo: Variant;
  Error: TFRError;
begin
  if Emulator then
    begin
      Result.ErrorCode := 0;
      Exit;
    end;

  Error := CashierLogin(CashierName, CashierINN);
  if Error.ErrorCode <> 0 then
    begin
      YesNoDialog(Error.ErrorText, 1, False);
      Exit
    end;

  rt := ReceiptTypeToInt(ReceiptType);
  if rt = -1 then
    begin
      YesNoDialog('Неизвестный тип чека.', 1, False);
      Exit
    end;

  if (rt = fptr.LIBFPTR_RT_BUY_RETURN_CORRECTION) or (rt = fptr.LIBFPTR_RT_SELL_RETURN_CORRECTION) or (rt = fptr.LIBFPTR_RT_SELL_CORRECTION) or (rt = fptr.LIBFPTR_RT_BUY_CORRECTION) then
    begin
  //    fptr.setParam(1177, ParentDoc);
  //    fptr.setParam(1178, ParentDocDate);
  //    fptr.setParam(1179, ParentDocNum);
  //    fptr.utilFormTlv;
  //    CorrectionInfo := fptr.getParamByteArray(fptr.LIBFPTR_PARAM_TAG_VALUE);
  //
  //    fptr.setParam(fptr.LIBFPTR_PARAM_RECEIPT_TYPE, rt);
  //    fptr.setParam(1173, 1);
  //    fptr.setParam(1174, CorrectionInfo);
    end
  else
    begin
      fptr.setParam(fptr.LIBFPTR_PARAM_RECEIPT_TYPE, rt);

      if DigitalCopyAddress <> '' then
        begin
          if DigitalReceipt then
            fptr.setParam(fptr.LIBFPTR_PARAM_RECEIPT_ELECTRONICALLY, True);
          fptr.setParam(1008, DigitalCopyAddress);
        end;
    end;

  fptr.openReceipt;

  Result.ErrorCode := fptr.errorCode;
  Result.ErrorText := fptr.errorDescription;
end;

//открытие нефискального чека
function TFRDriver.OpenNonFiscalReceipt(CashierName, CashierINN: String): TFRError;
var
  Error: TFRError;
begin
  if Emulator then
    begin
      Result.ErrorCode := 0;
      Exit;
    end;

  //регистрируем кассира
  Error := CashierLogin(CashierName, CashierINN);
  if Error.ErrorCode <> 0 then
    begin
      YesNoDialog(Error.ErrorText, 1, False);
      Exit
    end;

  fptr.beginNonfiscalDocument; //открываем нефискальный документ

  Result.ErrorCode := fptr.errorCode;
  Result.ErrorText := fptr.errorDescription;
end;

//подключение к ФР
function TFRDriver.Connection(Chanel, ComPortNumber, Baudrate: Integer; IP, MAC: String): TFRError;
begin
  if Emulator then
    begin
      Result.ErrorCode := 0;
      Exit;
    end;

  fptr.setSingleSetting(fptr.LIBFPTR_SETTING_MODEL, IntToStr(fptr.LIBFPTR_MODEL_ATOL_AUTO));
  fptr.setSingleSetting(fptr.LIBFPTR_SETTING_PORT, IntToStr(Chanel)); //fptr.LIBFPTR_PORT_COM
  fptr.setSingleSetting(fptr.LIBFPTR_SETTING_COM_FILE, 'COM' + IntToStr(ComPortNumber));
  fptr.setSingleSetting(fptr.LIBFPTR_SETTING_BAUDRATE, IntToStr(Baudrate)); //fptr.LIBFPTR_PORT_BR_115200
  fptr.setSingleSetting(fptr.LIBFPTR_SETTING_IPPORT, IP);
  fptr.setSingleSetting(fptr.LIBFPTR_SETTING_MACADDRESS, MAC);
  fptr.applySingleSettings;

  fptr.open;

  Result.ErrorCode := fptr.errorCode;
  Result.ErrorText := fptr.errorDescription;
end;

//отключение от ФР
procedure TFRDriver.Disconnect;
begin
  if Emulator then
    Exit;

  fptr.close
end;

// регистрация позиции
function TFRDriver.PosRegistration(posInfo: TPosInfo): TFRError;
var
  variantMark: Variant;
  arrayMark: TStringDynArray;
  i: Integer;
begin
  if Emulator then
    begin
      Result.ErrorCode := 0;
      Exit;
    end;

  fptr.setParam(fptr.LIBFPTR_PARAM_COMMODITY_NAME, posInfo.gName);
  fptr.setParam(fptr.LIBFPTR_PARAM_PRICE, posInfo.gPrice);
  fptr.setParam(fptr.LIBFPTR_PARAM_QUANTITY, posInfo.gQuantity);

  case posInfo.gTaxType of
    0: fptr.setParam(fptr.LIBFPTR_PARAM_TAX_TYPE, fptr.LIBFPTR_TAX_NO);
    1: fptr.setParam(fptr.LIBFPTR_PARAM_TAX_TYPE, fptr.LIBFPTR_TAX_VAT0);
    2: fptr.setParam(fptr.LIBFPTR_PARAM_TAX_TYPE, fptr.LIBFPTR_TAX_VAT10);
    3: fptr.setParam(fptr.LIBFPTR_PARAM_TAX_TYPE, fptr.LIBFPTR_TAX_VAT18);
    4: fptr.setParam(fptr.LIBFPTR_PARAM_TAX_TYPE, fptr.LIBFPTR_TAX_VAT110);
    5: fptr.setParam(fptr.LIBFPTR_PARAM_TAX_TYPE, fptr.LIBFPTR_TAX_VAT118);
  end;

  fptr.setParam(fptr.LIBFPTR_PARAM_TAX_SUM, 0); // сумма налога будет рассчитана автоматически

//  if Discount < 0 then
//    Discount := 0;
  fptr.setParam(fptr.LIBFPTR_PARAM_INFO_DISCOUNT_SUM, Abs(posInfo.gDiscount));

  fptr.setParam(1212, posInfo.gPPR); // признак предмета расчёта
//  fptr.setParam(1214, 0); //признак способа расчёта

  // если товар маркированный
  if posInfo.gMark <> '' then
    begin
      arrayMark := SplitString(posInfo.gMark, ' ');                 // получаем массив байт в текстовом формате

      variantMark := VarArrayCreate([0, high(arrayMark)], varByte); // создаём массив типа Variant с типом элементов Byte

      // помещаем в Variant-массив байты марки, при этом конвертируя их обратно в десятичную СС
      // видимо, драйвер Атола сам преобразует в 16-ю СС, но для совместимости с другими драйверами алгоритм формирования марки оставил в изначальном виде
      for i := VarArrayLowBound(variantMark, 1) to VarArrayHighBound(variantMark, 1) do
        VarArrayPut(variantMark, StrToInt('$' + arrayMark[i]), [i]);

      fptr.setParam(1162, variantMark);
    end;

  fptr.registration;

  Result.ErrorCode := fptr.errorCode;
  Result.ErrorText := fptr.errorDescription;
end;

//печать строки
function TFRDriver.PrintStr(Str: String; Alignment, FontType: Integer; DblWidth, DblHeight: Boolean): TFRError;
begin
  if Emulator then
    begin
      Result.ErrorCode := 0;
      Exit;
    end;

  fptr.setParam(fptr.LIBFPTR_PARAM_TEXT, Str);
  case Alignment of
    1: fptr.setParam(fptr.LIBFPTR_PARAM_ALIGNMENT, fptr.LIBFPTR_ALIGNMENT_LEFT);
    2: fptr.setParam(fptr.LIBFPTR_PARAM_ALIGNMENT, fptr.LIBFPTR_ALIGNMENT_CENTER);
    3: fptr.setParam(fptr.LIBFPTR_PARAM_ALIGNMENT, fptr.LIBFPTR_ALIGNMENT_RIGHT);
  end;
  fptr.setParam(fptr.LIBFPTR_PARAM_FONT, FontType);
  fptr.setParam(fptr.LIBFPTR_PARAM_FONT_DOUBLE_WIDTH, DblWidth);
  fptr.setParam(fptr.LIBFPTR_PARAM_FONT_DOUBLE_HEIGHT, DblHeight);
  fptr.setParam(fptr.LIBFPTR_PARAM_TEXT_WRAP, True);
  fptr.printText;

  Result.ErrorCode := fptr.errorCode;
  Result.ErrorText := fptr.errorDescription;
end;

//регистрация оплаты
function TFRDriver.PaymentRegistration(PaymentType: Integer; PaymentSum: Currency): TFRError;
begin
  if Emulator then
    begin
      Result.ErrorCode := 0;
      Exit;
    end;

  fptr.setParam(fptr.LIBFPTR_PARAM_PAYMENT_TYPE, PaymentType);
  fptr.setParam(fptr.LIBFPTR_PARAM_PAYMENT_SUM, PaymentSum);
  fptr.payment;

  Result.ErrorCode := fptr.errorCode;
  Result.ErrorText := fptr.errorDescription;
end;

//регистрация итога
function TFRDriver.TotalRegistration(TotalSum: Currency): TFRError;
begin
  if Emulator then
    begin
      Result.ErrorCode := 0;
      Exit;
    end;

  fptr.setParam(fptr.LIBFPTR_PARAM_SUM, TotalSum);
  fptr.receiptTotal;

  Result.ErrorCode := fptr.errorCode;
  Result.ErrorText := fptr.errorDescription;
end;

//печать копии последнего документа
procedure TFRDriver.LastDocumentCopy;
begin
  if Emulator then
    Exit;

  fptr.setParam(fptr.LIBFPTR_PARAM_REPORT_TYPE, fptr.LIBFPTR_RT_LAST_DOCUMENT);
  fptr.report;
end;

// закрытие чека
procedure TFRDriver.CloseReceipt;
begin
  if Emulator then
    Exit;

  fptr.closeReceipt;

  while fptr.checkDocumentClosed <> 0 do
    YesNoDialog('Не удалось проверить состояние документа в фискальном регистраторе из-за ошибки:' + #13#10 +
                '"' + fptr.errorDescription + '".' + #13#10 +
                'Устраните проблему и после этого нажмите кнопку "OK".', 1, False);

  if not fptr.getParamBool(fptr.LIBFPTR_PARAM_DOCUMENT_CLOSED) then
    begin
      // Документ не закрылся. Требуется его отменить (если это чек) и сформировать заново
      fptr.cancelReceipt;
      YesNoDialog('Чек был отменён в фискальном регистраторе. Попытайтесь заново закрыть чек.', 1, False);
      Exit;
    end;

  if not fptr.getParamBool(fptr.LIBFPTR_PARAM_DOCUMENT_PRINTED) then
    begin
      // Можно сразу вызвать метод допечатывания документа, он завершится с ошибкой, если это невозможно
      while fptr.continuePrint <> 0 do
        YesNoDialog('Не удалось напечатать документ из-за ошибки:' + #13#10 +
                    '"' + fptr.errorDescription + '".' + #13#10 +
                    'Устраните проблему и после этого нажмите кнопку "OK".', 1, False);
    end;
end;

//закрытие нефискального чека
function TFRDriver.CloseNonFiscalReceipt: TFRError;
begin
  if Emulator then
    begin
      Result.ErrorCode := 0;
      Exit;
    end;

  fptr.endNonfiscalDocument;

  Result.ErrorCode := fptr.errorCode;
  Result.ErrorText := fptr.errorDescription;
end;

//отмена чека
procedure TFRDriver.CancelReceipt;
begin
  if Emulator then
    Exit;

  fptr.cancelReceipt;
end;

//состояние чека
//LIBFPTR_RT_CLOSED - чек закрыт
function TFRDriver.GetReceiptState: Integer;
begin
  if Emulator then
    Exit;

  fptr.setParam(fptr.LIBFPTR_PARAM_DATA_TYPE, fptr.LIBFPTR_DT_RECEIPT_STATE);
  fptr.queryData;

  Result := fptr.getParamInt(fptr.LIBFPTR_PARAM_RECEIPT_TYPE);
end;

//X-отчёт
procedure TFRDriver.XReport;
begin
  if Emulator then
    Exit;

  fptr.setParam(fptr.LIBFPTR_PARAM_REPORT_TYPE, fptr.LIBFPTR_RT_X);
  fptr.report;
end;

//получить дату/время из ФР
function TFRDriver.GetDateTime: TDateTime;
begin
  if Emulator then
    Exit;

  fptr.setParam(fptr.LIBFPTR_PARAM_DATA_TYPE, fptr.LIBFPTR_DT_DATE_TIME);
  fptr.queryData;

  Result := fptr.getParamDateTime(fptr.LIBFPTR_PARAM_DATE_TIME);
end;

//установить текущую дату/время в ФР
function TFRDriver.SetDateTime: TFRError;
begin
  if Emulator then
    begin
      Result.ErrorCode := 0;
      Exit;
    end;

  fptr.setParam(fptr.LIBFPTR_PARAM_DATE_TIME, Now);
  fptr.writeDateTime;

  Result.ErrorCode := fptr.errorCode;
  Result.ErrorText := fptr.errorDescription;
end;

//срок действия ФН
function TFRDriver.GetFNRemain: TDateTime;
begin
  if Emulator then
    Exit;

  fptr.setParam(fptr.LIBFPTR_PARAM_FN_DATA_TYPE, fptr.LIBFPTR_FNDT_VALIDITY);
  fptr.fnQueryData;

  Result := fptr.getParamInt(fptr.LIBFPTR_PARAM_REGISTRATIONS_REMAIN);
end;

//ошибка обмена с ОФД
function TFRDriver.GetOFDExchangeError: TOFDError;
begin
  if Emulator then
    begin
      Result.FNError := 0;
      Exit;
    end;

  fptr.setParam(fptr.LIBFPTR_PARAM_FN_DATA_TYPE, fptr.LIBFPTR_FNDT_ERRORS);
  fptr.fnQueryData;

  Result.NetworkError     := fptr.getParamInt(fptr.LIBFPTR_PARAM_NETWORK_ERROR);
  Result.NetworkErrorText := fptr.getParamString(fptr.LIBFPTR_PARAM_NETWORK_ERROR_TEXT);

  Result.OFDError         := fptr.getParamInt(fptr.LIBFPTR_PARAM_OFD_ERROR);
  Result.OFDErrorText     := fptr.getParamString(fptr.LIBFPTR_PARAM_OFD_ERROR_TEXT);

  Result.FNError          := fptr.getParamInt(fptr.LIBFPTR_PARAM_FN_ERROR);
  Result.FNErrorText      := fptr.getParamString(fptr.LIBFPTR_PARAM_FN_ERROR_TEXT);
end;

constructor TFRDriver.Create(const Driver: Integer; const Emulator: Boolean);
begin
//  inherited;

  Self.Emulator := Emulator;

  if Emulator then
    Exit;

  try
    //fptr := TFptr.Create(nil); //удалить в рабочем варианте приложения

    fptr := CreateOleObject('AddIn.Fptr10'); //раскоментировать в рабочем варианте приложения
  except
    YesNoDialog('Не удалось найти драйвер для фискального регистратора!', 1, False);
    Exit
  end;
end;

destructor TFRDriver.Destroy;
begin
  if Emulator then
    Exit;

  //fptr.Free; //удалить в рабочем варианте приложения

  fptr := Unassigned; //раскоментировать в рабочем варианте приложения
  inherited;
end;

end.
