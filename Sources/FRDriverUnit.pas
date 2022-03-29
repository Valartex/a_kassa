unit FRDriverUnit;

interface

uses
  {Fptr10Lib_TLB, Vcl.OleServer,} //��������������� � ������� �������� ����������
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
    //fptr: TFptr; //��� �������� ������ � �����
    fptr    : OleVariant; //��� �������� �������� ����������
    Emulator: Boolean;
  public
    constructor Create(const Driver: Integer; const Emulator: Boolean);
    destructor Destroy; override;

    function Connection(Chanel, ComPortNumber, Baudrate: Integer; IP, MAC: String): TFRError; //����������� � ��
    procedure Disconnect; //���������� �� ��

    function OpenSession(CashierName, CashierINN: String): Boolean; //������� �����
    function CloseSession(CashierName, CashierINN: String): Boolean; //������� �����
    function GetSessionState: Integer; //��������� �����
    function IsSessionClosed: Boolean; //������� �� �����
    function IsSessionExpired: Boolean; //������� �� �����

    function CashBoxSum: Currency; //����� � ��
    procedure OpenDrawer; //������� ��

    function CashIn(Sum: Currency): TFRError; //��������
    function CashOut(Sum: Currency): TFRError; //�������

    function CashierLogin(CashierName, CashierINN: String): TFRError; //����������� �������
    function OpenReceipt(ReceiptType, DigitalCopyAddress, CashierName, CashierINN, ParentDoc, ParentDocNum: String; DigitalReceipt: Boolean; ParentDocDate: TDateTime): TFRError; //�������� ����
    function OpenNonFiscalReceipt(CashierName, CashierINN: String): TFRError; //�������� ������������� ����
    function PosRegistration(posInfo: TPosInfo): TFRError; //����������� �������
    function PaymentRegistration(PaymentType: Integer; PaymentSum: Currency): TFRError; //����������� ������
    function TotalRegistration(TotalSum: Currency): TFRError; //����������� �����
    procedure CloseReceipt; //�������� ����
    function CloseNonFiscalReceipt: TFRError; //�������� ������������� ����
    procedure CancelReceipt; //������ ����
    function GetReceiptState: Integer; //��������� ����
    function PrintStr(Str: String; Alignment, FontType: Integer; DblWidth, DblHeight: Boolean): TFRError; //������ ������

    function ReceiptTypeToInt(ReceiptType: String): Integer; //�������������� ���������� �������� ���� ���� � �������� ��������
    function IntToReceiptType(ReceiptCode: Integer): String; //�������������� ���� ���� ���� � ����������� �������� (�������, ������� � �.�.)

    procedure LastDocumentCopy; //������ ����� ���������� ��������
    procedure XReport; //X-�����

    function GetDateTime: TDateTime; //�������� ����/����� �� ��
    function SetDateTime: TFRError; //���������� ������� ����/����� � ��

    function GetFNRemain: TDateTime; //���� �������� ��
    function GetOFDExchangeError: TOFDError; //������ ������ � ���
  end;

var
  frDriver: TFRDriver;

implementation

{ TFRDriver }

uses CommonUnit;

// �������������� ���������� �������� ���� ���� � �������� ��������
function TFRDriver.ReceiptTypeToInt(ReceiptType: String): Integer;
begin
  if Emulator then
    Exit;

  ReceiptType := AnsiLowerCase(ReceiptType);

  if ReceiptType = '�������' then
    Result := fptr.LIBFPTR_RT_SELL
  else
  if ReceiptType = '�������' then
    Result := fptr.LIBFPTR_RT_SELL_RETURN
  else
  if ReceiptType = '������' then
    Result := fptr.LIBFPTR_RT_BUY
  else
  if ReceiptType = '������� �������' then
    Result := fptr.LIBFPTR_RT_BUY_RETURN
  else
  if ReceiptType = '��������� �������' then
    Result := fptr.LIBFPTR_RT_SELL_CORRECTION
  else
  if ReceiptType = '��������� �������' then
    Result := fptr.LIBFPTR_RT_BUY_CORRECTION
  else
  if ReceiptType = '��������� �������� �������' then
    Result := fptr.LIBFPTR_RT_BUY_RETURN_CORRECTION
  else
  if ReceiptType = '��������� �������� �������' then
    Result := fptr.LIBFPTR_RT_SELL_RETURN_CORRECTION
  else
    Result := -1;
end;

// �������������� ���� ���� ���� � ����������� �������� (�������, ������� � �.�.)
function TFRDriver.IntToReceiptType(ReceiptCode: Integer): String;
begin
  if Emulator then
    Exit;

  if ReceiptCode = fptr.LIBFPTR_RT_SELL then
    Result := '�������'
  else
  if ReceiptCode = fptr.LIBFPTR_RT_SELL_RETURN then
    Result := '�������'
  else
  if ReceiptCode = fptr.LIBFPTR_RT_BUY then
    Result := '������'
  else
  if ReceiptCode = fptr.LIBFPTR_RT_BUY_RETURN then
    Result := '������� �������'
  else
  if ReceiptCode = fptr.LIBFPTR_RT_SELL_CORRECTION then
    Result := '��������� �������'
  else
  if ReceiptCode = fptr.LIBFPTR_RT_BUY_CORRECTION then
    Result := '��������� �������'
  else
  if ReceiptCode = fptr.LIBFPTR_RT_BUY_RETURN_CORRECTION then
    Result := '��������� �������� �������'
  else
  if ReceiptCode = fptr.LIBFPTR_RT_SELL_RETURN_CORRECTION then
    Result := '��������� �������� �������'
  else
    Result := ''
end;

//����������� �������
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

//������� �����
function TFRDriver.OpenSession(CashierName, CashierINN: String): Boolean;
begin
  if Emulator then
    Exit;

  CashierLogin(CashierName, CashierINN);

  fptr.openShift;
  fptr.checkDocumentClosed;
end;

//������� �����
function TFRDriver.CloseSession(CashierName, CashierINN: String): Boolean;
begin
  if Emulator then
    Exit;

  CashierLogin(CashierName, CashierINN);

  fptr.setParam(fptr.LIBFPTR_PARAM_REPORT_TYPE, fptr.LIBFPTR_RT_CLOSE_SHIFT);
  fptr.report;

  fptr.checkDocumentClosed;
end;

//����� � ��
function TFRDriver.CashBoxSum: Currency;
begin
  if Emulator then
    Exit;

  fptr.setParam(fptr.LIBFPTR_PARAM_DATA_TYPE, fptr.LIBFPTR_DT_CASH_SUM);
  fptr.queryData;

  Result := fptr.getParamDouble(fptr.LIBFPTR_PARAM_SUM);
end;

//������� ��
procedure TFRDriver.OpenDrawer;
begin
  if Emulator then
    Exit;

  fptr.openDrawer;
end;

//��������� �����
//LIBFPTR_SS_CLOSED - ����� �������
//LIBFPTR_SS_OPENED - ����� �������
//LIBFPTR_SS_EXPIRED - ����� ������� (����������������� ����� ������ 24 �����)
function TFRDriver.GetSessionState: Integer;
begin
  if Emulator then
    Exit;

  fptr.setParam(fptr.LIBFPTR_PARAM_DATA_TYPE, fptr.LIBFPTR_DT_SHIFT_STATE);
  fptr.queryData;

  Result := fptr.getParamInt(fptr.LIBFPTR_PARAM_SHIFT_STATE);
end;

//������� �� �����
function TFRDriver.IsSessionClosed: Boolean;
begin
  if Emulator then
    Exit;

  Result := GetSessionState = fptr.LIBFPTR_SS_CLOSED
end;

//������� �� �����
function TFRDriver.IsSessionExpired: Boolean;
begin
  if Emulator then
    Exit;

  Result := GetSessionState = fptr.LIBFPTR_SS_EXPIRED
end;

//��������
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

//�������
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

//�������� ����
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
      YesNoDialog('����������� ��� ����.', 1, False);
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

//�������� ������������� ����
function TFRDriver.OpenNonFiscalReceipt(CashierName, CashierINN: String): TFRError;
var
  Error: TFRError;
begin
  if Emulator then
    begin
      Result.ErrorCode := 0;
      Exit;
    end;

  //������������ �������
  Error := CashierLogin(CashierName, CashierINN);
  if Error.ErrorCode <> 0 then
    begin
      YesNoDialog(Error.ErrorText, 1, False);
      Exit
    end;

  fptr.beginNonfiscalDocument; //��������� ������������ ��������

  Result.ErrorCode := fptr.errorCode;
  Result.ErrorText := fptr.errorDescription;
end;

//����������� � ��
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

//���������� �� ��
procedure TFRDriver.Disconnect;
begin
  if Emulator then
    Exit;

  fptr.close
end;

// ����������� �������
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

  fptr.setParam(fptr.LIBFPTR_PARAM_TAX_SUM, 0); // ����� ������ ����� ���������� �������������

//  if Discount < 0 then
//    Discount := 0;
  fptr.setParam(fptr.LIBFPTR_PARAM_INFO_DISCOUNT_SUM, Abs(posInfo.gDiscount));

  fptr.setParam(1212, posInfo.gPPR); // ������� �������� �������
//  fptr.setParam(1214, 0); //������� ������� �������

  // ���� ����� �������������
  if posInfo.gMark <> '' then
    begin
      arrayMark := SplitString(posInfo.gMark, ' ');                 // �������� ������ ���� � ��������� �������

      variantMark := VarArrayCreate([0, high(arrayMark)], varByte); // ������ ������ ���� Variant � ����� ��������� Byte

      // �������� � Variant-������ ����� �����, ��� ���� ����������� �� ������� � ���������� ��
      // ������, ������� ����� ��� ����������� � 16-� ��, �� ��� ������������� � ������� ���������� �������� ������������ ����� ������� � ����������� ����
      for i := VarArrayLowBound(variantMark, 1) to VarArrayHighBound(variantMark, 1) do
        VarArrayPut(variantMark, StrToInt('$' + arrayMark[i]), [i]);

      fptr.setParam(1162, variantMark);
    end;

  fptr.registration;

  Result.ErrorCode := fptr.errorCode;
  Result.ErrorText := fptr.errorDescription;
end;

//������ ������
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

//����������� ������
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

//����������� �����
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

//������ ����� ���������� ���������
procedure TFRDriver.LastDocumentCopy;
begin
  if Emulator then
    Exit;

  fptr.setParam(fptr.LIBFPTR_PARAM_REPORT_TYPE, fptr.LIBFPTR_RT_LAST_DOCUMENT);
  fptr.report;
end;

// �������� ����
procedure TFRDriver.CloseReceipt;
begin
  if Emulator then
    Exit;

  fptr.closeReceipt;

  while fptr.checkDocumentClosed <> 0 do
    YesNoDialog('�� ������� ��������� ��������� ��������� � ���������� ������������ ��-�� ������:' + #13#10 +
                '"' + fptr.errorDescription + '".' + #13#10 +
                '��������� �������� � ����� ����� ������� ������ "OK".', 1, False);

  if not fptr.getParamBool(fptr.LIBFPTR_PARAM_DOCUMENT_CLOSED) then
    begin
      // �������� �� ��������. ��������� ��� �������� (���� ��� ���) � ������������ ������
      fptr.cancelReceipt;
      YesNoDialog('��� ��� ������ � ���������� ������������. ����������� ������ ������� ���.', 1, False);
      Exit;
    end;

  if not fptr.getParamBool(fptr.LIBFPTR_PARAM_DOCUMENT_PRINTED) then
    begin
      // ����� ����� ������� ����� ������������� ���������, �� ���������� � �������, ���� ��� ����������
      while fptr.continuePrint <> 0 do
        YesNoDialog('�� ������� ���������� �������� ��-�� ������:' + #13#10 +
                    '"' + fptr.errorDescription + '".' + #13#10 +
                    '��������� �������� � ����� ����� ������� ������ "OK".', 1, False);
    end;
end;

//�������� ������������� ����
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

//������ ����
procedure TFRDriver.CancelReceipt;
begin
  if Emulator then
    Exit;

  fptr.cancelReceipt;
end;

//��������� ����
//LIBFPTR_RT_CLOSED - ��� ������
function TFRDriver.GetReceiptState: Integer;
begin
  if Emulator then
    Exit;

  fptr.setParam(fptr.LIBFPTR_PARAM_DATA_TYPE, fptr.LIBFPTR_DT_RECEIPT_STATE);
  fptr.queryData;

  Result := fptr.getParamInt(fptr.LIBFPTR_PARAM_RECEIPT_TYPE);
end;

//X-�����
procedure TFRDriver.XReport;
begin
  if Emulator then
    Exit;

  fptr.setParam(fptr.LIBFPTR_PARAM_REPORT_TYPE, fptr.LIBFPTR_RT_X);
  fptr.report;
end;

//�������� ����/����� �� ��
function TFRDriver.GetDateTime: TDateTime;
begin
  if Emulator then
    Exit;

  fptr.setParam(fptr.LIBFPTR_PARAM_DATA_TYPE, fptr.LIBFPTR_DT_DATE_TIME);
  fptr.queryData;

  Result := fptr.getParamDateTime(fptr.LIBFPTR_PARAM_DATE_TIME);
end;

//���������� ������� ����/����� � ��
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

//���� �������� ��
function TFRDriver.GetFNRemain: TDateTime;
begin
  if Emulator then
    Exit;

  fptr.setParam(fptr.LIBFPTR_PARAM_FN_DATA_TYPE, fptr.LIBFPTR_FNDT_VALIDITY);
  fptr.fnQueryData;

  Result := fptr.getParamInt(fptr.LIBFPTR_PARAM_REGISTRATIONS_REMAIN);
end;

//������ ������ � ���
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
    //fptr := TFptr.Create(nil); //������� � ������� �������� ����������

    fptr := CreateOleObject('AddIn.Fptr10'); //���������������� � ������� �������� ����������
  except
    YesNoDialog('�� ������� ����� ������� ��� ����������� ������������!', 1, False);
    Exit
  end;
end;

destructor TFRDriver.Destroy;
begin
  if Emulator then
    Exit;

  //fptr.Free; //������� � ������� �������� ����������

  fptr := Unassigned; //���������������� � ������� �������� ����������
  inherited;
end;

end.
