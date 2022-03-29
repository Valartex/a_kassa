unit DBUnit;

interface

uses
  System.SysUtils, System.Classes, Vcl.Dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client, Data.DB, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DBXFirebird, FireDAC.Comp.DataSet,
  Data.SqlExpr, FireDAC.Phys.IBBase, CommonUnit, FireDAC.Comp.UI, System.Types, Vcl.Forms,
  Winapi.Windows, Winapi.Messages, System.IniFiles, Vcl.FileCtrl,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs;

type
  // ������ � ������
  TGoodsRecord = record
    gID             : Integer;
    gCode           : String;
    gParent         : String;
    gName           : String;
    gVendorcode     : String;
    gPicture        : String;
    gPrice          : Currency;
    gDepartment     : ShortInt;
    gPLU            : Integer;
    gPPR            : ShortInt;
    gType           : ShortInt;
    gTax            : Integer;
    gUnit           : Integer;
    gIsGroup        : Boolean;
    gFractional     : Boolean;
    gPriceRequest   : Boolean;
    gQuantityRequest: Boolean;
    gUnloadInScales : Boolean;
    gComposition    : String;
    gBarcodes       : TStringDynArray;//TStringList;
  end;

  TGoodsArray = array of TGoodsRecord; //������ ������ � �������

  // ������ � ��
  TBarcodeRecord = record
    barcode  : String;
    goodsCode: String;
  end;

  TBarcodeArray = array of TBarcodeRecord; // ������ ������ � �����-�����

  // ������ � ������
  TTaxRecord = record
    taxID   : Integer;
    taxValue: String;
    taxCode : Integer;
  end;

  TTaxArray = array of TTaxRecord; //������ ������ � �������

  // ������ � ������� ���������
  TUnitRecord = record
    uID          : Integer;
    uName        : String;
    uOKEI        : SmallInt;
    uAbbreviation: String;
  end;

  // ������ � �������� �������� �������
  TPPRRecord = record
    pprID  : Integer;
    pprName: String;
  end;

  // ����� ���������
  TCommonSettingsRecord = record
    // ��
    backupPath      : String;
    backupNumber    : Integer;
    delDocsAfterDays: Integer;
    // ����� �������
    exchangeFormat        : SmallInt;
    exchangePath          : String;
    exchangeDLFile        : String;
    exchangeULFile        : String;
    exchangeDLFileF       : String;
    exchangeULFileF       : String;
    exchangeULCloseSession: Boolean;
    // ��� � ��
    fnBufferAlert: Integer;
    fnEndAlert   : Integer;
    fnAlertEmail : String;
    // ����������
    roundMethod   : SmallInt;
    roundPrecision: Real;
    roundMin      : Real;
    // �����
    externalApp   : String;
    zReportEmail  : String;
    blockYesButton: Integer;
    // ���������� � ��������
    companyName   : String;
    shopName      : String;
    companyINN    : String;
    companyAddress: String;
    shopAddress   : String;
    companyEmail  : String;
    companyWeb    : String;
    companyPhone  : String;
  end;

  // ������������ ��������� ����������
  TNonVisualSettingsRecord = record
    dbVersion     : String;
    lastLabel     : String;
    lastPrinter   : String;
    lastCashier   : Integer;
    lastBackupDate: TDate;
    sessionIsOpen : Boolean;
    sessionNumber : Integer;
    barcodeCounter: Integer;
  end;

  // ��������� ��
  TFRSettingsRecord = record
    frStatus: Boolean;
    frModel: Integer;
    frAccessPassword: Integer;
    frOperatorPassword: Integer;
    frChanel: Integer;
    frPort: Integer;
    frSpeed: Integer;
    frIP: String;
    frMAC: String;
    frSynchroTime: Boolean;
    frTimeAlert: Integer;
    frReceiptPrint: Boolean;
    frManufacturer: Integer;
  end;

  // ��������� ��
  TDrawerSettingsRecord = record
    autoOpen, status: Boolean;
  end;

  // ��������� ������� ��
  TScanerSettingsRecord = record
    sStatus: Boolean;
    sChanel: Integer;
    sPort: Integer;
    sSpeed: Integer;
    sPrefix: String;
    sSufix: String;
    sSensitivity: Integer;
  end;

  // ������� ��
  TBCTemplateRecord = record
    bctID: Integer;
    bctName: String;
    bctTemplate: String;
  end;

  TBCTemplateArray = array of TBCTemplateRecord; //������ ������ � �������� ��

  // ������ � �������
  TCashierRecord = record
    cID: Integer;
    cName: String;
    cPosition: String;
    cProfile: Integer;
    cPhoto: String;
    cINN: String;
    cBarcode: String;
    cPassword: String;
  end;

  TCashierArray = array of TCashierRecord; //������ ������ � ��������

  // ������ � ������� �������
  TCashierProfileRecord = record
    cpCode: Integer;
    cpName: String;
    cpSettings: Boolean;
  end;

  TCashierProfileArray = array of TCashierProfileRecord; //������ ������ � �������� ��������

  // ������ � ������
  TDiscountRecord = record
    discID: Integer;
    discName: String;
    discValue: Real;
    discPosition: Boolean
  end;

  TDiscountArray = array of TDiscountRecord; //������ ������ � �������

  // ������ � �������
  TClientRecord = record
    clientID: Integer;
    cLientCode: Integer; //��� ������� �� ������� �������
    clientName: String;
    clientBirthday: TDate;
    clientSex: Boolean;
    clientCard: String; //��� ������������ ���������� �����
    clientDiscount: Currency; //�������� ������������ ������
    clientPhone: String;
    clientEmail: String;
    clientCounter: Currency; //����� ������� �������
  end;

  TClientArray = array of TClientRecord; //������ ������ � ��������

  // ������ � �������� � ����
  TReceiptPaymentsRecord = record
    rpID: Integer;
    rpReceiptID: Integer;
    rpType: Integer;
    rpValue: Currency;
  end;

  TReceiptPaymentsArray = array of TReceiptPaymentsRecord; //������ ������ �� ������� ����

  // ������ � ������� ����
  TReceiptPosRecord = record
    rpID: Integer;
    rpGoodsCode: String;
    rpDeleted: Boolean;
    rpGoodsName: String;
    rpGoodsVendorcode: String;
    rpReceiptID: Integer;
    rpPrice: Currency;
    rpSumm: Currency;
    rpDiscount: Currency;
    rpQuantity: Currency;
    rpTax: Integer;
    rpPPR: Integer;
    rpMark: String;
  end;

  TReceiptPosArray = array of TReceiptPosRecord; //������ ������� ����

  // ������ � ����
  TReceiptRecord = record
    receiptID: Integer;
    receiptType: SmallInt;
    receiptSumm: Currency;
    receiptCashierCode: Integer;
    receiptOpenDate: TDate;
    receiptOpenTime: TTime;
    receiptCloseDate: TDate;
    receiptCloseTime: TTime;
    receiptClientCode: Integer;
    receiptStatus: SmallInt;
    receiptSessionNumber: Integer;
    receiptNote: String;
    receiptDiscount: Currency;
    receiptContact: String;
  end;

  TReceiptsArray = array of TReceiptRecord; // ������ ������ � �����

  // ��� ������ � ����, ������� ������� � ������
  TReceiptAllDataRecord = record
    receiptRecord: TReceiptRecord;
    receiptPosArray: TReceiptPosArray;
    receiptPaymentsArray: TReceiptPaymentsArray;
  end;

  TDM1 = class(TDataModule)
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    FDTransaction1: TFDTransaction;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDCommand1: TFDCommand;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    FDSQLiteBackup1: TFDSQLiteBackup;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function GetDBPath: String;
    function ConnectToDB(dbPath: String): Boolean;
    procedure DisconnectDB;
    procedure ConvertDB(dbVersion: String);
    function FieldExist(dbTable, dbField: String): Boolean;

    procedure InactiveIndex(tableName: String); // ��������� ������� � �������
    procedure ActiveIndex(tableName: String);   // �������� ������� � �������

    procedure StartTransaction;  // ������ ���������� (������������ �� ������ ���������� ������������)
    procedure CommitTransaction; // ��������� ���������� (� ������ ������� ���������� ������������)

//    function SessionNuberGen: Integer;  // ��������� ������ ������ �����
    function BarcodeGen: String;        // ��������� ������ ��

    function GetNextGoodsId: Integer;
    function GetGoodsGroupChild(code: String; onlyGroups: Boolean): TGoodsArray;
    function GetAllGoodsGroupChild(code: String): TGoodsArray;                    // ��� �������� ������, ������� ����������� � ���������
    function GetAllGoods: TGoodsArray;                                            // ��� ������
    function IsGoodsGroup(code: String): Boolean;
    function GetGoodsData(code: String): TGoodsRecord;
    function FindGoods(parametr, field: String; similar: Boolean): TGoodsArray;   // ����� ������ �� ������������ ����
    function FindGoodsByBarcode(barcode: String): TGoodsArray;                    // ����� ������ �� ��
    function SaveGoods(goodsRecord: TGoodsRecord): String;
    function BatchSaveGoods(goodsArray: TGoodsArray): Boolean;                    // ���������� ������� �������
    procedure DeleteGoods(code: String);
    procedure DeleteAllGoods;

    function GetTaxData(ID: Integer): TTaxRecord; //�������� ������ �� ������
    function GetTaxes: TTaxArray; //�������� ������ �� ���� �������
    function GetTaxCodeByName(TaxName: String): Integer;
    procedure SaveTax(TR: TTaxRecord); //��������� �����
    procedure DeleteTax(ID: Integer); //������� �����
    procedure DeleteAllTaxes; //������� ��� ������

    function GetUnitData(ID: Integer): TUnitRecord;
    function GetUnitCodeByName(UName: String): Integer;
    procedure GetUnitsNames(var Units: TStringList);

    function GetPPRData(Code: Integer): TPPRRecord;
    function GetPPRCodeByName(PPRName: String): Integer;
    procedure GetPPRNames(var PPR: TStringList);

    function GetCashierData(ID: Integer): TCashierRecord;                 //�������� ������ �� �������
    function GetCashires: TCashierArray;                                  //�������� ������ �� ���� ��������
    procedure SaveCashier(CR: TCashierRecord);
    procedure DeleteCashier(ID: Integer);
    procedure DeleteAllCashiers;

    function GetCashierProfileData(Code: Integer): TCashierProfileRecord; //�������� ������ �� ������� �������
    function GetCashiersProfiles: TCashierProfileArray;                   //�������� ������ �� ���� �������� ��������
    function GetCashierProfileCodeByName(Profile: String): Integer;
    function GetNextCashiersProfileCode: Integer;
    function LinksToCashiersProfileExist(Code: Integer): Boolean;         //���������� �� ������ �� ������� �� ����������� ��������
    procedure GetCashierProfilesNames(var Profiles: TStringList);
    procedure AddCashiersProfile(CPR: TCashierProfileRecord);
    procedure UpdateCashiersProfile(CPR: TCashierProfileRecord; OldCode: Integer);
    procedure DeleteCashiersProfile(Code: Integer);


    function GetBCTemplates: TBCTemplateArray; //�������� ��� ������� ��
    function GetBCTemplateData(ID: Integer): TBCTemplateRecord; //�������� ������ � ������� �� �� ����

    function GetDiscountData(ID: Integer): TDiscountRecord; //�������� ������ � ������
    function GetDiscounts: TDiscountArray; //�������� ��� ������

//    procedure GetTaxesNames(var Taxes: TStringList);

    function GetReceipt(ReceiptID: Integer): TReceiptAllDataRecord; //�������� ��� ���������� � ����
    function GetReceipts(RType, RStatus: Integer): TReceiptsArray; //�������� ��� ���� ���������� ���� � �������
    function SaveReceipt(Receipt: TReceiptAllDataRecord): Boolean; //��������� ���
    procedure DeleteReceipts(DaysAgo: Integer); //������� ���� � ������� �������� ������� ������ N ����

    procedure SaveBarcode(GoodsCode: String; Barcode: String);
    procedure BatchSaveBarcode(barcodeArray: TBarcodeArray);
    procedure SaveBarcodeTemplate(BCTR: TBCTemplateRecord);
    procedure DeleteAllBarcodesOfGoods(GoodsCode: String);
    procedure DeleteBarcodeTemplate(ID: Integer);
    procedure DeleteAllBarcodes;

    procedure SaveDiscount(DR: TDiscountRecord);
    procedure DeleteDiscount(ID: Integer);

    procedure SaveCommonSettings(CSR: TCommonSettingsRecord); //��������� ����� ���������
    function GetCommonSettings: TCommonSettingsRecord; //�������� ����� ���������
    procedure SaveNonVisualSetting(NVSR: TNonVisualSettingsRecord); //��������� ������������ ���������
    function GetNonVisualSettings: TNonVisualSettingsRecord; //�������� ������������ ���������
    procedure SaveDigitalScaleSettings(Model, Port: SmallInt; Speed: Integer; Status: Boolean);
    procedure SaveFRSetting(FRSR: TFRSettingsRecord); //��������� ��������� ��
    function GetFRSetting: TFRSettingsRecord; //�������� ��������� ��
    procedure SaveLPScaleSettings(Model, Port, LogicalNumber, DecPoint: SmallInt; Speed: Integer; IP: String; Status: Boolean);
    procedure SaveDrawerSettings(DSR: TDrawerSettingsRecord); //��������� ��������� ��
    function GetDrawerSettings: TDrawerSettingsRecord; //�������� ��������� ��
    procedure SaveScanerSettings(SSR: TScanerSettingsRecord); //��������� ��������� ������� ��
    function GetScanerSettings: TScanerSettingsRecord; //�������� ��������� ������� ��

    function ReceiptTypeToInternalCode(ReceiptType: String): Integer; // �������������� ������������ ���� ���� � �������� ���
    function InternalCodeToReceiptType(ReceiptCode: Integer): String; // �������������� ��������� ���� � ������������ ���� ����

    procedure BackupDB;
  end;

const
  currentDBVersion = '2020.05.15';

var
  DM1: TDM1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

//uses CommonUnit;

{$R *.dfm}

procedure TDM1.DataModuleCreate(Sender: TObject);
var
  dbVersion: String;
begin
  if not ConnectToDB(GetDBPath) then
    begin
      MessageBox(Application.Handle, '�� ������� ������������ � ���� ������. ���������� ����� �������.', '������', MB_ICONERROR + MB_OK);
      Halt;
    end;

  dbVersion := GetNonVisualSettings.dbVersion;
  if dbVersion <> currentDBVersion then
    if MessageBox(Application.Handle, '������ ���� ������ �� ������������� ������ ���������. � ������� ������� ������ �� ����� ���� ����������.' + #13#10 +
                                      '��������� ����������� �� ���������� ������?', 'a_kassa', MB_ICONQUESTION + MB_YESNO) = ID_YES then
      begin
        ConvertDB(dbVersion);
      end
    else
      Halt
end;

// ���� � ��
function TDM1.GetDBPath: String;
var
  DBSettings: TIniFile;
  DB_Path: String;
//  FOD: TFileOpenDialog;
begin
  if not FileExists(GetAppPath + 'DBSettings.ini') then
    if not IsCreatePossible(GetAppPath + 'DBSettings.ini') then
      begin
        MessageBox(Application.Handle, '�� ������� ������� ���� ��������. ���������� ��������� ��������� �� ����� ��������������.', '������', MB_ICONERROR + MB_OK);
        Application.Terminate
      end;

  DBSettings := TIniFile.Create(GetAppPath + 'DBSettings.ini');

  DB_Path := Trim(DBSettings.ReadString('DB', 'DBPath', ''));

//  FOD := TFileOpenDialog.Create(nil);

  if (DB_Path = '') or (not FileExists(DB_Path + '\main.db')) then
    if SelectDirectory('������� ����� �������� ���� ������. �� ������������� ��� ���� ����� ������������ ������, �� ������� ����������� ������������ �������!', '', DB_Path, [sdNewUI, sdNewFolder], nil) then
    //if FOD.Execute then
      begin
        CopyFile(PWideChar(GetAppPath + 'emptydb\main.db'), PWideChar(DB_Path + '\main.db'), true); // �������� ����������� � ��������� ����� ������ �� (���� ��� ��� ���� ���� ��, �� ����������� �� ���������)
        if FileExists(DB_Path + '\main.db') then
          DBSettings.WriteString('DB', 'DBPath', DB_Path)
        else
          MessageBox(Application.Handle, '� ��������� �������� ���� ������ �� �������.', '������', MB_ICONERROR + MB_OK)
      end;

  //  FOD.Free;

  DBSettings.Free;

  Result := DB_Path
end;

// ���������� ��
function TDM1.ConnectToDB(dbPath: String): Boolean;
begin
//  FDPhysFBDriverLink1.VendorLib := GetAppPath + 'fbclient.dll';

  with FDConnection1 do
    begin
      LoginPrompt := False;
      Params.Database := dbPath + '\main.db';

      Connected := True; // ������-�� ����������� ���������� ���� ���� �� ���
      Result := FieldExist('nonvisualsettings', 'nvs_dbversion') // ������� ������������� ��������� ������������� ���� � ������� ��
    end;
end;

// ��������� ��
procedure TDM1.DisconnectDB;
begin
  FDConnection1.Connected := False
end;

// �������������� ����
procedure TDM1.ConvertDB(dbVersion: String);
var
  NVS: TNonVisualSettingsRecord;
  dbPath: String;
begin
  // ������ ����� ����� ��

  dbPath := GetDBPath;

  DisconnectDB;

  if not CopyFile(PWideChar(dbPath + '\main.db'), PWideChar(dbPath + '\main_old.db'), False) then
    begin
      MessageBox(Application.Handle, '�� ������� ������� ��������� ����� ����� ���� ������. ����������� �� ����� ���������. ���������� ����� �������.' + #13#10 +
                                     '��� ������� �������� ���������� ��������� ��������� �� ����� ��������������.', '������', MB_ICONERROR + MB_OK);
      Halt
    end;

  ConnectToDB(dbPath);

  NVS := GetNonVisualSettings;

  // ��������� �����������
  // ���� �� ����� �� ������ ��������� ������, ������� ����������� � ����� ������� ������� �������������� ��������� ��������� ����� ��

  with FDCommand1 do
    try

      // 2020.04.15 - ������ �� ����� � ����
      if dbVersion = '0' then
        begin

          // ������ ����� ���� ��
          CommandText.Text := 'ALTER TABLE nonvisualsettings ADD nvs_dbversion VARCHAR(10) CHARACTER SET UTF8 DEFAULT 0 NOT NULL';
          Active := True;
          CommandText.Text := 'ALTER TABLE goods ADD goods_type SMALLINT';
          Execute();
          CommandText.Text := 'ALTER TABLE receiptspos ADD receiptspos_mark VARCHAR(255) CHARACTER SET UTF8';
          Execute();
          Active := False;

          dbVersion := '2020.04.15';
          NVS.dbVersion := dbVersion
        end;

      SaveNonVisualSetting(NVS); // ���������� ����� ����� ������ � ��

    except
      on E: Exception do
        begin
          DisconnectDB;
          MessageBox(Application.Handle, PWideChar('�� ������� ��������������� ���� ������ �� ���������� ������. ���������� ����� �������.' + #13#10 +
                                                    #13#10 +
                                                   '����������� ����������: ' + E.Message), 'a_kassa', MB_ICONERROR + MB_OK);

          if not CopyFile(PWideChar(dbPath + '\main_old.db'), PWideChar(dbPath + '\main.db'), False) then
            MessageBox(Application.Handle, PWideChar('�� ������� ������������� ������������ ���� ���� ������ � ��������� �������������� �����������.' + #13#10 +
                                                     '�� ������ ������� ��� �������, ������� ���� ' + dbPath + '\main.db �� ���� ' + dbPath + '\main_old.db'), 'a_kassa', MB_ICONERROR + MB_OK);

          Halt
        end;
    end;

  MessageBox(Application.Handle, '���� ������ ������� ��������������� �� ���������� ������.', 'a_kassa', MB_OK)

end;

// ��������� ������������� ���� � �������
function TDM1.FieldExist(dbTable: string; dbField: string): Boolean;
begin
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'SELECT * FROM ' + dbTable + ' LIMIT 1';
      try
        OpenOrExecute;
        Result := FindField(dbField) <> nil;
      except
        Result := False;
      end;
      
    end;
end;

// ��������� ������� � �������
procedure TDM1.InactiveIndex(tableName: String);
var
  indexNames: array of String;
  i         : Integer;
begin
  if tableName = 'GOODS' then
    indexNames := ['PK_GOODS', 'FK_GOODS_1', 'FK_GOODS_2', 'FK_GOODS_3']
  else
  if tableName = 'BARCODES' then
    indexNames := ['PK_BARCODES'];

  with FDCommand1 do
    for i := 0 to Length(indexNames) do
      begin
        CommandText.Text                  := 'ALTER INDEX :indexname INACTIVE';
        ParamByName('indexname').AsString := indexNames[i];
        Active                            := True;
        Active                            := False;
      end;
end;

// �������� ������� � �������
procedure TDM1.ActiveIndex(tableName: String);
var
  indexNames: array of String;
  i         : Integer;
begin
  if tableName = 'GOODS' then
    indexNames := ['PK_GOODS', 'FK_GOODS_1', 'FK_GOODS_2', 'FK_GOODS_3']
  else
  if tableName = 'BARCODES' then
    indexNames := ['PK_BARCODES'];

  with FDCommand1 do
    for i := 0 to Length(indexNames) do
      begin
        CommandText.Text                  := 'ALTER INDEX :indexname ACTIVE';
        ParamByName('indexname').AsString := indexNames[i];
        Active                            := True;
        Active                            := False;
      end;

end;

// ������ ���������� (������������ �� ������ ���������� ������������)
procedure TDM1.StartTransaction;
begin
  FDTransaction1.StartTransaction
end;

// ��������� ���������� (� ������ ������� ���������� ������������)
procedure TDM1.CommitTransaction;
begin
  FDTransaction1.Commit
end;

// ��������� ������ ������ �����
//function TDM1.SessionNuberGen: Integer;
//var
//  NVS: TNonVisualSettingsRecord;
//begin
//  NVS := GetNonVisualSettings;
//
//  with FDQuery1 do
//    begin
//      Close;
//      SQL.Clear;
//      Params.Clear;
//
//      SQL.Text := 'SELECT MAX(nvs_sessionnumber) AS sessionnumber FROM nonvisualsettings'; // �������� ������� �������� ��������
//      OpenOrExecute;
//
//      try
//        NVS.sessionNumber := FieldByName('sessionnumber').AsInteger + 1;                   // ��������� �������� ��������
//      except
//        NVS.sessionNumber := 1                                                             // ���� ��� �� ����� �����
//      end;
//    end;
//
//  SaveNonVisualSetting(NVS);
//
//  Result := NVS.sessionNumber
//end;

// ��������� ������ ��
function TDM1.BarcodeGen: String;
var
  nonVisualSettings: TNonVisualSettingsRecord;
begin
  nonVisualSettings := DM1.GetNonVisualSettings;
  Inc(nonVisualSettings.barcodeCounter);
  DM1.SaveNonVisualSetting(nonVisualSettings);

  Result := IntToStr(nonVisualSettings.barcodeCounter)
end;

// ��������� ������ ID ������
function TDM1.GetNextGoodsId;
begin
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'SELECT MAX(goods_id) AS goodsid FROM goods'; // �������� ������� �������� ��������
      OpenOrExecute;

      try
        Result := FieldByName('goodsid').AsInteger + 1;         // ��������� �������� ��������
      except
        Result := 1                                             // ���� ��� �� ������ ������
      end;
    end;
end;

// �������� ��� �������� �������� �������� ������
function TDM1.GetGoodsGroupChild(code: String; onlyGroups: Boolean): TGoodsArray;
var
  i, j: Integer;
begin
  with FDQuery1 do
    begin
      if onlyGroups then //�������� ������ ������
        begin
          Close;
          SQL.Clear;
          Params.Clear;

          SQL.Text := 'SELECT * FROM goods WHERE goods_isgroup=true and goods_parent=:parent' + #13#10 +
                      'ORDER BY goods_name';

          ParamByName('parent').AsString := code;
          OpenOrExecute;
        end
    else //�������� ��� �������� ��������
      begin
        Close;
        SQL.Clear;
        Params.Clear;

        SQL.Text := 'SELECT * FROM goods' + #13#10 +
                    'WHERE goods_parent=:parent' + #13#10 +
                    'ORDER BY goods_isgroup=false, goods_name';

        ParamByName('parent').AsString := code;
        OpenOrExecute;
      end;

    i := 0;
    First;
    while not Eof do
      begin

        Inc(i);
        SetLength(Result, i);
        with Result[i-1] do
          begin

            gCode            := FieldByName('goods_code').AsString;
            gName            := FieldByName('goods_name').AsString;
            gParent          := FieldByName('goods_parent').AsString;
            gVendorcode      := FieldByName('goods_vendorcode').AsString;
            gPicture         := FieldByName('goods_picture').AsString;
            gIsGroup         := FieldByName('goods_isgroup').AsBoolean;
            gTax             := FieldByName('goods_tax').AsInteger;
            gPLU             := FieldByName('goods_plu').AsInteger;
            gUnit            := FieldByName('goods_unit').AsInteger;
            gPPR             := FieldByName('goods_ppr').AsInteger;
            gPrice           := FieldByName('goods_price').AsCurrency;
            gDepartment      := FieldByName('goods_department').AsInteger;
            gFractional      := FieldByName('goods_fractional').AsBoolean;
            gPriceRequest    := FieldByName('goods_pricerequest').AsBoolean;
            gQuantityRequest := FieldByName('goods_quantityrequest').AsBoolean;
            gUnloadInScales  := FieldByName('goods_unloadinscales').AsBoolean;
            gComposition     := FieldByName('goods_composition').AsString;

          end;

        Next

      end;

  end;
end;

// �������� ��� ������
function TDM1.GetAllGoods: TGoodsArray;
var
  i: Integer;
  bc: String;
begin
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'SELECT g.*,' + #13#10 +
                  '(SELECT FIRST 1 bc_barcode FROM barcodes b where b.bc_goodscode=g.goods_code) as bc_barcode' + #13#10 +
                  'FROM goods g' + #13#10 +
                  'WHERE g.goods_isgroup=false';

      OpenOrExecute;

      i := 0;
      First;
      while not Eof do
        begin
          Application.ProcessMessages;

          Inc(i);
          SetLength(Result, i);
          with Result[i-1] do
            begin
              gCode := FieldByName('goods_code').AsString;
              gName := FieldByName('goods_name').AsString;
              gParent := FieldByName('goods_parent').AsString;
              gVendorcode := FieldByName('goods_vendorcode').AsString;
              gPicture := FieldByName('goods_picture').AsString;
              gIsGroup := FieldByName('goods_isgroup').AsBoolean;
              gTax := FieldByName('goods_tax').AsInteger;
              gPLU := FieldByName('goods_plu').AsInteger;
              gUnit := FieldByName('goods_unit').AsInteger;
              gPPR := FieldByName('goods_ppr').AsInteger;
              gType := FieldByName('goods_type').AsInteger;
              gPrice := FieldByName('goods_price').AsCurrency;
              gDepartment := FieldByName('goods_department').AsInteger;
              gFractional := FieldByName('goods_fractional').AsBoolean;
              gPriceRequest := FieldByName('goods_pricerequest').AsBoolean;
              gQuantityRequest := FieldByName('goods_quantityrequest').AsBoolean;
              gUnloadInScales := FieldByName('goods_unloadinscales').AsBoolean;
              gComposition := FieldByName('goods_composition').AsString;

              bc := FieldByName('bc_barcode').AsString;
              if bc <> '' then
                begin
                  SetLength(gBarcodes, 1);
                  gBarcodes[0] := bc
                end;
            end;

          Next

        end;
    end
end;

// �������� ��� �������� ������, ������� ����������� � ���������
function TDM1.GetAllGoodsGroupChild(code: String): TGoodsArray;
var
  i: Integer;
  GA: TGoodsArray;
  FDQ: TFDQuery;
  bc: String;
begin
  FDQ := TFDQuery.Create(Self);
  FDQ.Connection := FDConnection1;

  with FDQ do
    begin

      SQL.Text := 'SELECT g.*,' + #13#10 +
                  '(SELECT bc_barcode FROM barcodes b where b.bc_goodscode=g.goods_code LIMIT 1) as bc_barcode' + #13#10 +
                  'FROM goods g' + #13#10 +
                  'WHERE g.goods_parent=:parent';

      ParamByName('parent').AsString := code;
      OpenOrExecute;

      First;
      SetLength(Result, 0);
      while not Eof do
        begin
          SendMessage(Application.MainFormHandle, WM_USER + 2, 1, 1); //��������� ProgressBar �� ������� �����

          if FieldByName('goods_isgroup').AsBoolean then
            begin
              GA := DM1.GetAllGoodsGroupChild(FieldByName('goods_code').AsString);

              Result := Concat(Result, GA);
            end
          else
            begin
              i := Length(Result) + 1;
              SetLength(Result, i);

              with Result[i-1] do
                begin
                  gCode := FieldByName('goods_code').AsString;
                  gName := FieldByName('goods_name').AsString;
                  gParent := FieldByName('goods_parent').AsString;
                  gVendorcode := FieldByName('goods_vendorcode').AsString;
                  gPicture := FieldByName('goods_picture').AsString;
                  gIsGroup := FieldByName('goods_isgroup').AsBoolean;
                  gTax := FieldByName('goods_tax').AsInteger;
                  gPLU := FieldByName('goods_plu').AsInteger;
                  gUnit := FieldByName('goods_unit').AsInteger;
                  gPPR := FieldByName('goods_ppr').AsInteger;
                  gType := FieldByName('goods_type').AsInteger;
                  gPrice := FieldByName('goods_price').AsCurrency;
                  gDepartment := FieldByName('goods_department').AsInteger;
                  gFractional := FieldByName('goods_fractional').AsBoolean;
                  gPriceRequest := FieldByName('goods_pricerequest').AsBoolean;
                  gQuantityRequest := FieldByName('goods_quantityrequest').AsBoolean;
                  gUnloadInScales := FieldByName('goods_unloadinscales').AsBoolean;
                  gComposition := FieldByName('goods_composition').AsString;

                  bc := FieldByName('bc_barcode').AsString;
                  if bc <> '' then
                    begin
                      SetLength(gBarcodes, 1);
                      gBarcodes[0] := bc
                    end;
                end;

            end;

          Next

        end;

      Close;

    end;

  FDQ.Free
end;

// ����� ��� ������
function TDM1.IsGoodsGroup(code: String): Boolean;
begin
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'SELECT goods_isgroup FROM goods WHERE goods_code=:code';
      ParamByName('code').AsString := code;
      OpenOrExecute;

      Result := FieldByName('goods_isgroup').AsBoolean
    end;
end;

// ������ � ������ �� ����
function TDM1.GetGoodsData(code: String): TGoodsRecord;
var
  i: Integer;
begin
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'SELECT * FROM goods WHERE goods_code=:code';
      ParamByName('code').AsString := code;
      OpenOrExecute;

      if RecordCount = 0 then
        begin
          Exit
        end;


      with Result do
        begin
          gCode := code;
          gName := FieldByName('goods_name').AsString;
          gParent := FieldByName('goods_parent').AsString;
          gVendorcode := FieldByName('goods_vendorcode').AsString;
          gPicture := FieldByName('goods_picture').AsString;
          gIsGroup := FieldByName('goods_isgroup').AsBoolean;
          gTax := FieldByName('goods_tax').AsInteger;
          gPLU := FieldByName('goods_plu').AsInteger;
          gUnit := FieldByName('goods_unit').AsInteger;
          gPPR := FieldByName('goods_ppr').AsInteger;
          gType := FieldByName('goods_type').AsInteger;
          gPrice := FieldByName('goods_price').AsCurrency;
          gDepartment := FieldByName('goods_department').AsInteger;
          gFractional := FieldByName('goods_fractional').AsBoolean;
          gPriceRequest := FieldByName('goods_pricerequest').AsBoolean;
          gQuantityRequest := FieldByName('goods_quantityrequest').AsBoolean;
          gUnloadInScales := FieldByName('goods_unloadinscales').AsBoolean;
          gComposition := FieldByName('goods_composition').AsString;
        end;

      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'SELECT bc_barcode FROM barcodes WHERE bc_goodscode=:goodscode';
      ParamByName('goodscode').AsString := code;
      OpenOrExecute;

  //    i := 0;
  //    First;
  //    while not EOF do
  //    begin
  //      Inc(i);
  //      SetLength(Result.GBarcodes, i);
  //      Result.GBarcodes[i-1] := FieldByName('bc_barcode').AsString;
  //      Next
  //    end;

      SetLength(Result.gBarcodes, RecordCount);
      i := 0;
      First;
      while not EOF do
        begin
          Result.gBarcodes[i] := FieldByName('bc_barcode').AsString;
          Next;
          Inc(i);
        end

    end;
end;

// ����� ������ �� ������������ ����
function TDM1.FindGoods(parametr, field: String; similar: Boolean): TGoodsArray;
var
  i: Integer;
begin
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      if similar then
        SQL.Text := 'SELECT * FROM goods WHERE goods_' + field +' LIKE ''%' + parametr + '%'' AND goods_isgroup=FALSE' + #13#10 +
                    'ORDER BY goods_name'
      else
        SQL.Text := 'SELECT * FROM goods WHERE goods_' + field +'=' + parametr + ' AND goods_isgroup=FALSE' + #13#10 +
                    'ORDER BY goods_name';
  //    ParamByName('param').AsString := Parametr;
      OpenOrExecute;

  //    if RecordCount = 0 then
  //    begin
  //      Exit
  //    end;

      i := 0;
      First;
      while not EOF do
        begin
          SetLength(Result, i + 1);

          with Result[i] do
            begin
              gCode := FieldByName('goods_code').AsString;
              gName := FieldByName('goods_name').AsString;
              gParent := FieldByName('goods_parent').AsString;
              gVendorcode := FieldByName('goods_vendorcode').AsString;
              gPicture := FieldByName('goods_picture').AsString;
              gIsGroup := FieldByName('goods_isgroup').AsBoolean;
              gTax := FieldByName('goods_tax').AsInteger;
              gPLU := FieldByName('goods_plu').AsInteger;
              gUnit := FieldByName('goods_unit').AsInteger;
              gPPR := FieldByName('goods_ppr').AsInteger;
              gType := FieldByName('goods_type').AsInteger;
              gPrice := FieldByName('goods_price').AsCurrency;
              gDepartment := FieldByName('goods_department').AsInteger;
              gFractional := FieldByName('goods_fractional').AsBoolean;
              gPriceRequest := FieldByName('goods_pricerequest').AsBoolean;
              gQuantityRequest := FieldByName('goods_quantityrequest').AsBoolean;
              gUnloadInScales := FieldByName('goods_unloadinscales').AsBoolean;
              gComposition := FieldByName('goods_composition').AsString;
            end;

          Next;
          Inc(i);
        end;

    end;
end;

// ����� ������ �� ��
function TDM1.FindGoodsByBarcode(barcode: String): TGoodsArray; //����� ������ �� ��
var
  i, j: Integer;
  arrayOfGoodCodes: array of String;
begin
  with FDQuery1 do
    begin
      // ������� ��� ������, � ������� ���� ����� ��
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'SELECT bc_goodscode FROM barcodes WHERE bc_barcode=:barcode';
      ParamByName('barcode').AsString := barcode;
      OpenOrExecute;

      if RecordCount = 0 then
        begin
          Exit
        end;

      First;
      i := 0;

      while not Eof do
        begin
          Inc(i);
          SetLength(arrayOfGoodCodes, i);
          arrayOfGoodCodes[i-1] := FieldByName('bc_goodscode').AsString;
          Next
        end;

      //�������� ���������� �� ���� ��������� �������

      i := 0;

      for j := 0 to Length(arrayOfGoodCodes) - 1 do
        begin
          Close;
          SQL.Clear;
          Params.Clear;

          SQL.Text := 'SELECT * FROM goods WHERE goods_code=:goodscode LIMIT 1';
          ParamByName('goodscode').AsString := arrayOfGoodCodes[j];
          OpenOrExecute;

          Inc(i);
          SetLength(Result, i);
          with Result[i-1] do
            begin
              gCode := FieldByName('goods_code').AsString;
              gName := FieldByName('goods_name').AsString;
              gParent := FieldByName('goods_parent').AsString;
              gVendorcode := FieldByName('goods_vendorcode').AsString;
              gPicture := FieldByName('goods_picture').AsString;
              gIsGroup := FieldByName('goods_isgroup').AsBoolean;
              gTax := FieldByName('goods_tax').AsInteger;
              gPLU := FieldByName('goods_plu').AsInteger;
              gUnit := FieldByName('goods_unit').AsInteger;
              gPPR := FieldByName('goods_ppr').AsInteger;
              gType := FieldByName('goods_type').AsInteger;
              gPrice := FieldByName('goods_price').AsCurrency;
              gDepartment := FieldByName('goods_department').AsInteger;
              gFractional := FieldByName('goods_fractional').AsBoolean;
              gPriceRequest := FieldByName('goods_pricerequest').AsBoolean;
              gQuantityRequest := FieldByName('goods_quantityrequest').AsBoolean;
              gUnloadInScales := FieldByName('goods_unloadinscales').AsBoolean;
              gComposition := FieldByName('goods_composition').AsString;
            end;

        end;
    end;
end;

// ������ � ������ �� ����
function TDM1.GetTaxData(ID: Integer): TTaxRecord;
begin
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'SELECT * FROM taxes WHERE taxes_id=:id';
      ParamByName('id').AsInteger := ID;
      OpenOrExecute;

      with Result do
        begin
          taxValue := FieldByName('taxes_value').AsString;
          taxCode := FieldByName('taxes_code').AsInteger;
        end;
    end;
end;

// �������� ������ �� ���� �������
function TDM1.GetTaxes: TTaxArray;
var
  i: Integer;
begin
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'SELECT * FROM taxes ORDER BY taxes_id';
      OpenOrExecute;

      i := 0;
      First;
      while not Eof do
        begin
          Inc(i);
          SetLength(Result, i);
          Result[i-1].taxID := FieldByName('taxes_id').AsInteger;
          Result[i-1].taxValue := FieldByName('taxes_value').AsString;
          Result[i-1].taxCode := FieldByName('taxes_code').AsInteger;
          Next
        end;
    end;
end;

// ������ � ������� ��������� �� ����
function TDM1.GetUnitData(ID: Integer): TUnitRecord;
begin
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'SELECT * FROM units WHERE units_id=:id';
      ParamByName('id').AsInteger := ID;
      OpenOrExecute;

      with Result do
        begin
          uName := FieldByName('units_name').AsString;
          uOKEI := FieldByName('units_okei').AsInteger;
          uAbbreviation := FieldByName('units_abbreviation').AsString;
        end;
    end;
end;

// ������ � �������� �������� ������� �� ����
function TDM1.GetPPRData(Code: Integer): TPPRRecord;
begin
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'SELECT * FROM ppr WHERE ppr_code=:code';
      ParamByName('code').AsInteger := Code;
      OpenOrExecute;

      with Result do
        begin
          pprName := FieldByName('ppr_name').AsString;
        end;
    end;
end;

// ������ � �������
function TDM1.GetCashierData(ID: Integer): TCashierRecord;
begin
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text                    := 'SELECT * FROM cashiers WHERE cashiers_id=:id';
      ParamByName('id').AsInteger := ID;
      OpenOrExecute;

      with Result do
        begin
          cID       := ID;
          cName     := FieldByName('cashiers_name').AsString;
          cPosition := FieldByName('cashiers_position').AsString;
          cProfile  := FieldByName('cashiers_profile').AsInteger;
          cPhoto    := FieldByName('cashiers_photo').AsString;
          cINN      := FieldByName('cashiers_inn').AsString;
          cBarcode  := FieldByName('cashiers_barcode').AsString;
          cPassword := FieldByName('cashiers_password').AsString;
        end;
    end;
end;

// �������� ������ �� ���� ��������
function TDM1.GetCashires: TCashierArray;
var
  i: Integer;
begin
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'SELECT * FROM cashiers ORDER BY cashiers_name';
      OpenOrExecute;

      i := 0;
      First;
      while not Eof do
        begin
          Inc(i);
          SetLength(Result, i);
          Result[i-1].cID       := FieldByName('cashiers_id').AsInteger;
          Result[i-1].cName     := FieldByName('cashiers_name').AsString;
          Result[i-1].cPosition := FieldByName('cashiers_position').AsString;
          Result[i-1].cProfile  := FieldByName('cashiers_profile').AsInteger;
          Result[i-1].cPhoto    := FieldByName('cashiers_photo').AsString;
          Result[i-1].cINN      := FieldByName('cashiers_inn').AsString;
          Result[i-1].cBarcode  := FieldByName('cashiers_barcode').AsString;
          Result[i-1].cPassword := FieldByName('cashiers_password').AsString;
          Next
        end;
    end;
end;

// �������� ������ �� ������� �������
function TDM1.GetCashierProfileData(Code: Integer): TCashierProfileRecord;
begin
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'SELECT * FROM cashiersprofiles WHERE profiles_code=:code';

      ParamByName('code').AsInteger := Code;
      OpenOrExecute;

      with Result do
        begin
          cpName     := FieldByName('profiles_name').AsString;
          cpSettings := FieldByName('profiles_settings').AsBoolean;
        end;
    end;
end;

// �������� ������ �� ���� �������� ��������
function TDM1.GetCashiersProfiles: TCashierProfileArray;
var
  i: Integer;
begin
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'SELECT * FROM cashiersprofiles ORDER BY profiles_code';
      OpenOrExecute;

      i := 0;
      First;
      while not Eof do
        begin
          Inc(i);
          SetLength(Result, i);
          Result[i-1].cpCode     := FieldByName('profiles_code').AsInteger;
          Result[i-1].cpName     := FieldByName('profiles_name').AsString;
          Result[i-1].cpSettings := FieldByName('profiles_settings').AsBoolean;
          Next
        end;
    end;
end;

// �������� ��������� �������� ���� ������� ��������
function TDM1.GetNextCashiersProfileCode: Integer;
begin
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'SELECT MAX(profiles_code) AS profilecode FROM cashiersprofiles'; // �������� ������� �������� �������� (� ��������������������� ������ ��� ������ ������, ����� ������������ GEN_ID)
      OpenOrExecute;

      try
        Result := FieldByName('profilecode').AsInteger + 1;                         // ��������� �������� ��������
      except
        Result := 1                                                                 // ���� ��� ��������
      end;
    end;
end;

// ���������� �� ������ �� ������� �� ����������� ��������
function TDM1.LinksToCashiersProfileExist(Code: Integer): Boolean;
begin
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'SELECT * FROM cashiers WHERE cashiers_profile=:code';

      ParamByName('code').AsInteger := Code;
      OpenOrExecute;

      Result := RecordCount > 0;
    end;
end;

// ��� ������ �� ������������
function TDM1.GetTaxCodeByName(TaxName: String): Integer;
begin
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'SELECT taxes_id FROM taxes WHERE taxes_name=:name';
      ParamByName('name').AsString := TaxName;
      OpenOrExecute;

      Result := FieldByName('taxes_id').AsInteger;
    end;
end;

// ��� ������� ��������� �� ������������
function TDM1.GetUnitCodeByName(UName: string): Integer;
begin
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'SELECT units_id FROM units WHERE units_name=:name';
      ParamByName('name').AsString := UName;
      OpenOrExecute;

      Result := FieldByName('units_id').AsInteger;
    end;
end;

// ��� �������� �������� ������� �� ������������
function TDM1.GetPPRCodeByName(PPRName: string): Integer;
begin
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'SELECT ppr_code FROM ppr WHERE ppr_name=:name';
      ParamByName('name').AsString := PPRName;
      OpenOrExecute;

      Result := FieldByName('ppr_code').AsInteger;
    end;
end;

// ��� ������� �������� �� ������������
function TDM1.GetCashierProfileCodeByName(Profile: String): Integer;
begin
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'SELECT profiles_code FROM cashiersprofiles WHERE profiles_name=:name';
      ParamByName('name').AsString := Profile;
      OpenOrExecute;

      Result := FieldByName('profiles_code').AsInteger;
    end;
end;

// �������� ��� ������� ��
function TDM1.GetBCTemplates: TBCTemplateArray;
var
  i: Integer;
begin
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'SELECT * FROM barcodetemplates ORDER BY bct_name';
      OpenOrExecute;

      i := 0;
      First;
      while not Eof do
        begin
          Inc(i);
          SetLength(Result, i);
          Result[i-1].bctID := FieldByName('bct_id').AsInteger;
          Result[i-1].bctName := FieldByName('bct_name').AsString;
          Result[i-1].bctTemplate := FieldByName('bct_template').AsString;
          Next
        end;
    end;
end;

// �������� ������ � ������� �� �� ����
function TDM1.GetBCTemplateData(ID: Integer): TBCTemplateRecord;
begin
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'SELECT * FROM barcodetemplates WHERE bct_id=:id';
      ParamByName('id').AsInteger := ID;
      OpenOrExecute;

      with Result do
        begin
          bctName := FieldByName('bct_name').AsString;
          bctTemplate := FieldByName('bct_template').AsString;
        end;
    end;
end;

// �������� ��� ����� ������ ���������
procedure TDM1.GetUnitsNames(var Units: TStringList);
begin
  Units.Clear;

  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'SELECT units_name FROM units ORDER BY units_name';
      OpenOrExecute;

      First;
      while not Eof do
        begin
          Units.Add(FieldByName('units_name').AsString);
          Next
        end;
    end;
end;

//�������� ��� ����� ��������� ������
//procedure TDM1.GetTaxesNames(var Taxes: TStringList);
//begin
//  Taxes.Clear;
//
//  with FDQuery1 do
//  begin
//    Close;
//    SQL.Clear;
//    Params.Clear;
//
//    SQL.Text := 'SELECT taxes_name FROM taxes ORDER BY taxes_name';
//    OpenOrExecute;
//
//    First;
//    while not Eof do
//    begin
//      Taxes.Add(FieldByName('taxes_name').AsString);
//      Next
//    end;
//  end;
//end;

// �������� ��� ����� ��������� �������� �������
procedure TDM1.GetPPRNames(var PPR: TStringList);
begin
  PPR.Clear;

  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'SELECT ppr_name FROM ppr';
      OpenOrExecute;

      First;
      while not Eof do
        begin
          PPR.Add(FieldByName('ppr_name').AsString);
          Next
        end;
    end;
end;

// �������� ��� ����� �������� ��������
procedure TDM1.GetCashierProfilesNames(var Profiles: TStringList);
begin
  Profiles.Clear;

  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'SELECT profiles_name FROM cashiersprofiles';
      OpenOrExecute;

      First;
      while not Eof do
        begin
          Profiles.Add(FieldByName('profiles_name').AsString);
          Next
        end;
    end;
end;

// �������� ���������� � ����
function TDM1.GetReceipt(ReceiptID: Integer): TReceiptAllDataRecord;
var
  i: Integer;
begin
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'SELECT * FROM receipts WHERE receipts_id=:id';
      ParamByName('id').AsInteger := ReceiptID;
      OpenOrExecute;

      with Result.receiptRecord do
        begin
          receiptID := FieldByName('receipts_id').AsInteger;
          receiptType := FieldByName('receipts_type').AsInteger;
          receiptSumm := FieldByName('receipts_summ').AsCurrency;
          receiptCashierCode := FieldByName('receipts_cashiercode').AsInteger;
          receiptOpenDate := FieldByName('receipts_opendate').AsDateTime;
          receiptOpenTime := FieldByName('receipts_opentime').AsDateTime;;
          receiptCloseDate := FieldByName('receipts_closedate').AsDateTime;;
          receiptCloseTime := FieldByName('receipts_closetime').AsDateTime;;
          receiptClientCode := FieldByName('receipts_clientcode').AsInteger;
          receiptStatus := FieldByName('receipts_status').AsInteger;
          receiptSessionNumber := FieldByName('receipts_sessionnumber').AsInteger;
          receiptNote := FieldByName('receipts_note').AsString;
          receiptDiscount := FieldByName('receipts_discount').AsCurrency;
          receiptContact := FieldByName('receipts_contact').AsString;
        end;

      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'SELECT * FROM receiptspos WHERE receiptspos_receiptid=:id';
      ParamByName('id').AsInteger := ReceiptID;
      OpenOrExecute;

      i := 0;
      First;
      while not EOF do
        begin
          Inc(i);
          SetLength(Result.receiptPosArray, i);

          with Result.receiptPosArray[i-1] do
            begin
              rpID := FieldByName('receiptspos_id').AsInteger;
              rpGoodsCode := FieldByName('receiptspos_goodscode').AsString;
              rpDeleted := FieldByName('receiptspos_deleted').AsBoolean;
              rpGoodsName := FieldByName('receiptspos_goodsname').AsString;
              rpGoodsVendorcode := FieldByName('receiptspos_goodsvendorcode').AsString;
              rpReceiptID := ReceiptID;
              rpPrice := FieldByName('receiptspos_price').AsCurrency;
              rpSumm := FieldByName('receiptspos_summ').AsCurrency;
              rpDiscount := FieldByName('receiptspos_discount').AsCurrency;
              rpQuantity := FieldByName('receiptspos_quantity').AsCurrency;
            end;

          Next
        end;

      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'SELECT * FROM receiptspayments WHERE rpayments_receiptid=:id';
      ParamByName('id').AsInteger := ReceiptID;
      OpenOrExecute;

      i := 0;
      First;
      while not EOF do
        begin
          Inc(i);
          SetLength(Result.receiptPaymentsArray, i);

          with Result.receiptPaymentsArray[i-1] do
            begin
              rpID := FieldByName('rpayments_id').AsInteger;
              rpReceiptID := ReceiptID;
              rpType := FieldByName('rpayments_type').AsInteger;
              rpValue := FieldByName('rpayments_value').AsCurrency;
            end;

          Next
        end;
    end;

end;

// �������� ��� ���� ���������� ���� � �������
function TDM1.GetReceipts(RType, RStatus: Integer): TReceiptsArray;
var
  i: Integer;
  param: String;
begin
  param := '';

  //��������� ������ �� ����, ���� �����
  if RType <> -1 then
    param := #13#10 + 'WHERE receipts_type=' + IntToStr(RType);
  if RStatus <> -1 then
    param := #13#10 + 'WHERE receipts_status=' + IntToStr(RStatus);
  if (RType <> -1) and (RStatus <> -1) then
    param := #13#10 + 'WHERE receipts_type=' + IntToStr(RType) + ' AND receipts_status=' + IntToStr(RStatus);

  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'SELECT * FROM receipts' + param;
      OpenOrExecute;

      i := 0;
      First;
      while not EOF do
        begin
          Inc(i);
          SetLength(Result, i);

          with Result[i-1] do
            begin
              receiptID := FieldByName('receipts_id').AsInteger;
              receiptType := FieldByName('receipts_type').AsInteger;
              receiptSumm := FieldByName('receipts_summ').AsCurrency;
              receiptCashierCode := FieldByName('receipts_cashiercode').AsInteger;
              receiptOpenDate := FieldByName('receipts_opendate').AsDateTime;
              receiptOpenTime := FieldByName('receipts_opentime').AsDateTime;;
              receiptCloseDate := FieldByName('receipts_closedate').AsDateTime;;
              receiptCloseTime := FieldByName('receipts_closetime').AsDateTime;;
              receiptClientCode := FieldByName('receipts_clientcode').AsInteger;
              receiptStatus := FieldByName('receipts_status').AsInteger;
              receiptSessionNumber := FieldByName('receipts_sessionnumber').AsInteger;
              receiptNote := FieldByName('receipts_note').AsString;
              receiptDiscount := FieldByName('receipts_discount').AsCurrency;
              receiptContact := FieldByName('receipts_contact').AsString;
            end;

          Next
        end;
    end;
end;

// ��������� ���
function TDM1.SaveReceipt(Receipt: TReceiptAllDataRecord): Boolean;
var
  Code, i: Integer;
begin
  Code := Receipt.receiptRecord.receiptID;

  with FDQuery1 do
    begin
      if Code <= 0 then // ���� �������� ����� ���
        begin
          Close;
          SQL.Clear;
          Params.Clear;

          SQL.Text := 'SELECT MAX(receipts_id) AS receiptid FROM receipts'; // �������� ������� �������� �������� (� ��������������������� ������ ��� ������ ������, ����� ������������ GEN_ID)
          OpenOrExecute;

          try
            Code := FieldByName('receiptid').AsInteger + 1;                 // ��������� �������� ��������
          except
            Code := 1                                                       // ���� ��� ��������
          end;
        end;

      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'INSERT OR REPLACE INTO receipts ' +
                    '(receipts_id, receipts_type, receipts_summ, receipts_cashiercode, receipts_opendate, receipts_opentime, receipts_closedate, receipts_closetime, receipts_clientcode, ' +
                    'receipts_status, receipts_sessionnumber, receipts_note, receipts_discount, receipts_contact)' + #13#10 +
                  'VALUES ' +
                    '(:id, :type, :summ, :cashiercode, :opendate, :opentime, :closedate, :closetime, :clientcode, :status, :sessionnumber, :note, :discount, :contact)';

      ParamByName('id').AsInteger := Code;
      with Receipt.receiptRecord do
        begin
          ParamByName('type').AsInteger          := receiptType;
          ParamByName('summ').AsCurrency         := receiptSumm;
          ParamByName('cashiercode').AsInteger   := receiptCashierCode;
          ParamByName('opendate').AsDate         := receiptOpenDate;
          ParamByName('opentime').AsTime         := receiptOpenTime;
          ParamByName('closedate').AsDate        := receiptCloseDate;
          ParamByName('closetime').AsTime        := receiptCloseTime;
          ParamByName('clientcode').AsInteger    := receiptClientCode;
          ParamByName('status').AsInteger        := receiptStatus;
          ParamByName('sessionnumber').AsInteger := receiptSessionNumber;
          ParamByName('note').AsString           := receiptNote;
          ParamByName('discount').AsCurrency     := receiptDiscount;
          ParamByName('contact').AsString        := receiptContact;
        end;

      ExecSQL;

      // ������� ��� ������ ������� ����
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'DELETE FROM receiptspos WHERE receiptspos_receiptid=:receiptid';

      ParamByName('receiptid').AsInteger := Code;

      ExecSQL;

      // ���������� ������� ����
      for i := 0 to Length(Receipt.receiptPosArray) - 1 do
        with Receipt.receiptPosArray[i] do
          begin
            Close;
            SQL.Clear;
            Params.Clear;

            SQL.Text := 'INSERT INTO receiptspos ' +
                          '(receiptspos_goodscode, receiptspos_deleted, receiptspos_goodsname, receiptspos_goodsvendorcode, receiptspos_receiptid, ' +
                          'receiptspos_price, receiptspos_summ, receiptspos_discount, receiptspos_quantity)' + #13#10 +
                        'VALUES ' +
                          '(:goodscode, :deleted, :goodsname, :goodsvendorcode, :receiptid, :price, :summ, :discount, :quantity)';

            ParamByName('goodscode').AsString       := rpGoodsCode;
            ParamByName('deleted').AsBoolean        := rpDeleted;
            ParamByName('goodsname').AsString       := rpGoodsName;
            ParamByName('goodsvendorcode').AsString := rpGoodsVendorcode;
            ParamByName('receiptid').AsInteger      := Code;
            ParamByName('price').AsCurrency         := rpPrice;
            ParamByName('summ').AsCurrency          := rpSumm;
            ParamByName('discount').AsCurrency      := rpDiscount;
            ParamByName('quantity').AsCurrency      := rpQuantity;

            ExecSQL;
          end;

      // ������� ��� ������ ������ ����
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'DELETE FROM receiptspayments WHERE rpayments_receiptid=:receiptid';

      ParamByName('receiptid').AsInteger := Code;

      ExecSQL;

      // ���������� ������ ����
      for i := 0 to Length(Receipt.receiptPaymentsArray) - 1 do
        with Receipt.receiptPaymentsArray[i] do
          begin
            Close;
            SQL.Clear;
            Params.Clear;

            SQL.Text := 'INSERT INTO receiptspayments ' +
                          '(rpayments_receiptid, rpayments_type, rpayments_value)' + #13#10 +
                        'VALUES ' +
                          '(:receiptid, :type, :value)';

            ParamByName('receiptid').AsInteger := Code;
            ParamByName('type').AsInteger      := rpType;
            ParamByName('value').AsCurrency    := rpValue;

            ExecSQL;
          end;

    end;
end;

// ������� ���� � ������� �������� ������� ������ N ����
procedure TDM1.DeleteReceipts(DaysAgo: Integer);
begin
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'DELETE FROM receipts WHERE julianday(''now'') - julianday(receipts_closedate) >= :daysago';
      ParamByName('daysago').AsInteger := DaysAgo;
      ExecSQL
    end;
end;

// �������� ������ � ������
function TDM1.GetDiscountData(ID: Integer): TDiscountRecord;
begin
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'SELECT * FROM discounts WHERE disc_id=:id';
      ParamByName('id').AsInteger := ID;
      OpenOrExecute;

      with Result do
        begin
          discName := FieldByName('disc_name').AsString;
          discValue := FieldByName('disc_value').AsFloat;
          discPosition := FieldByName('disc_position').AsBoolean;
        end;
    end;
end;

//�������� ��� ������
function TDM1.GetDiscounts: TDiscountArray;
var
  i: Integer;
begin
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'SELECT * FROM discounts';
      OpenOrExecute;

      i := 0;
      First;
      while not Eof do
        begin
          Inc(i);
          SetLength(Result, i);
          Result[i-1].discID := FieldByName('disc_id').AsInteger;
          Result[i-1].discName := FieldByName('disc_name').AsString;
          Result[i-1].discValue := FieldByName('disc_value').AsFloat;
          Result[i-1].discPosition := FieldByName('disc_position').AsBoolean;
          Next
        end;
    end;
end;

//�������� �����
function TDM1.SaveGoods(goodsRecord: TGoodsRecord): String;
var
  i   : Integer;
  code: String;
begin
  code := goodsRecord.gCode;

  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      // ���� ������� ������ ���, �� ��� �������� ������ �� ����� ���������
      if code = '' then
        begin
          goodsRecord.gID := GetNextGoodsId;

          code := IntToStr(goodsRecord.gID);
        end
      else
        // ��� ��������� ������, ����� ��� ��������
        begin
          // ����� id ������ �� ����
          SQL.Text                     := 'SELECT goods_id FROM goods WHERE goods_code=:code';
          ParamByName('code').AsString := code;
          OpenOrExecute;

          // ���� �� ���� ������ ID, �� ��� ���������� ������������ ������, ����� - �������� ����� ������ �� �����
          if RecordCount > 0 then
            goodsRecord.gID := FieldByName('goods_id').AsInteger
          else
            goodsRecord.gID := GetNextGoodsId;
        end;

      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'INSERT OR REPLACE INTO goods ' +
                    '(goods_id, goods_code, goods_name, goods_parent, goods_isgroup, goods_tax, goods_picture, goods_unit, goods_fractional, goods_pricerequest, ' +
                    'goods_quantityrequest, goods_unloadinscales, goods_ppr, goods_type, goods_vendorcode, goods_plu, goods_price, goods_department, goods_composition)' + #13#10 +
                  'VALUES ' +
                    '(:id, :code, :name, :parent, :isgroup, :tax, :picture, :unit, :fractional, :pricerequest, :quantityrequest, :unloadinscales, :ppr, :type, :vendorcode, :plu, :price, :department, :composition)';

      ParamByName('id').AsInteger              := goodsRecord.gID;
      ParamByName('code').AsString             := code;
      ParamByName('name').AsString             := goodsRecord.gName;
      ParamByName('parent').AsString           := goodsRecord.gParent;
      ParamByName('isgroup').AsBoolean         := goodsRecord.gIsGroup;
      ParamByName('tax').AsInteger             := goodsRecord.gTax;
      ParamByName('picture').AsString          := goodsRecord.gPicture;
      ParamByName('unit').AsInteger            := goodsRecord.gUnit;
      ParamByName('ppr').AsInteger             := goodsRecord.gPPR;
      ParamByName('type').AsInteger            := goodsRecord.gType;
      ParamByName('fractional').AsBoolean      := goodsRecord.gFractional;
      ParamByName('pricerequest').AsBoolean    := goodsRecord.gPriceRequest;
      ParamByName('quantityrequest').AsBoolean := goodsRecord.gQuantityRequest;
      ParamByName('unloadinscales').AsBoolean  := goodsRecord.gUnloadInScales;
      ParamByName('vendorcode').AsString       := goodsRecord.gVendorcode;
      ParamByName('plu').AsInteger             := goodsRecord.gPLU;
      ParamByName('price').AsCurrency          := goodsRecord.gPrice;
      ParamByName('department').AsSmallInt     := goodsRecord.gDepartment;
      ParamByName('composition').AsString      := goodsRecord.gComposition;
      ExecSQL;
    end;

  DeleteAllBarcodesOfGoods(code); // ������� ��� ��, ��������� � �������

  // ���������� ����� ��
  for i := 0 to Length(goodsRecord.gBarcodes) - 1 do
    SaveBarcode(code, goodsRecord.gBarcodes[i]);

  Result := code // ��� ���������� ������ � �������� ���������� �������

end;

// ���������� ������� �������
function TDM1.BatchSaveGoods(goodsArray: TGoodsArray): Boolean;
var
  i, j, sizeOfArray, numOfBarcodes: Integer;
  barcodeArray                    : TBarcodeArray;
begin
  sizeOfArray   := Length(goodsArray);
  numOfBarcodes := 0;

  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      // ������ �������

      SQL.Text := 'INSERT OR REPLACE INTO goods ' +
                    '(goods_id, goods_code, goods_name, goods_parent, goods_isgroup, goods_tax, goods_picture, goods_unit, goods_fractional, goods_pricerequest, ' +
                    'goods_quantityrequest, goods_unloadinscales, goods_ppr, goods_type, goods_vendorcode, goods_plu, goods_price, goods_department, goods_composition)' + #13#10 +
                  'VALUES ' +
                    '(:id, :code, :name, :parent, :isgroup, :tax, :picture, :unit, :fractional, :pricerequest, :quantityrequest, :unloadinscales, :ppr, :type, :vendorcode, :plu, :price, :department, :composition)';

      Params.ArraySize := sizeOfArray;

      for i := 0 to sizeOfArray - 1 do
        begin
          ParamByName('id').AsIntegers[i]              := GetNextGoodsId;
          ParamByName('code').AsStrings[i]             := goodsArray[i].gCode;
          ParamByName('name').AsStrings[i]             := goodsArray[i].gName;
          ParamByName('parent').AsStrings[i]           := goodsArray[i].gParent;
          ParamByName('isgroup').AsBooleans[i]         := goodsArray[i].gIsGroup;
          ParamByName('tax').AsIntegers[i]             := goodsArray[i].gTax;
          ParamByName('picture').AsStrings[i]          := goodsArray[i].gPicture;
          ParamByName('unit').AsIntegers[i]            := goodsArray[i].gUnit;
          ParamByName('ppr').AsIntegers[i]             := goodsArray[i].gPPR;
          ParamByName('type').AsIntegers[i]            := goodsArray[i].gType;
          ParamByName('fractional').AsBooleans[i]      := goodsArray[i].gFractional;
          ParamByName('pricerequest').AsBooleans[i]    := goodsArray[i].gPriceRequest;
          ParamByName('quantityrequest').AsBooleans[i] := goodsArray[i].gQuantityRequest;
          ParamByName('unloadinscales').AsBooleans[i]  := goodsArray[i].gUnloadInScales;
          ParamByName('vendorcode').AsStrings[i]       := goodsArray[i].gVendorcode;
          ParamByName('plu').AsIntegers[i]             := goodsArray[i].gPLU;
          ParamByName('price').AsCurrencys[i]          := goodsArray[i].gPrice;
          ParamByName('department').AsSmallInts[i]     := goodsArray[i].gDepartment;
          ParamByName('composition').AsStrings[i]      := goodsArray[i].gComposition;

          // ��������� ������ �����-�����
          for j := 0 to Length(goodsArray[i].gBarcodes) - 1 do
            begin
              Inc(numOfBarcodes);
              SetLength(barcodeArray, numOfBarcodes);
              barcodeArray[numOfBarcodes - 1].goodsCode := goodsArray[i].gCode;
              barcodeArray[numOfBarcodes - 1].barcode   := goodsArray[i].gBarcodes[j];
            end;
        end;

      Execute(sizeOfArray, 0);

      // �������� ����������

      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'DELETE FROM barcodes WHERE bc_goodscode=:goodscode';

      Params.ArraySize := sizeOfArray;

      for i := 0 to sizeOfArray - 1 do
        ParamByName('goodscode').AsStrings[i] := goodsArray[i].gCode;

      Execute(sizeOfArray, 0);

      // ������ ����� ����������

      DM1.BatchSaveBarcode(barcodeArray);
    end;
end;

// ������� �����
procedure TDM1.DeleteGoods(code: String);
var
  GA: TGoodsArray;
  i: Integer;
begin
  if IsGoodsGroup(code) then //���� ��� ������
    begin
      GA := GetGoodsGroupChild(code, False); //�������� ������ �������� ���������
      for i := 0 to Length(GA) - 1 do
        DeleteGoods(GA[i].gCode); //������� ��� �������� ��������
    end;

  //������� ����� ��� ������
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'DELETE FROM goods WHERE goods_code=:code';
      ParamByName('code').AsString := code;
      ExecSQL
    end;

  //������� ��, ��������� � �������
  DeleteAllBarcodesOfGoods(code);
end;

// ������� ��� ������
procedure TDM1.DeleteAllGoods;
begin
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'DELETE FROM goods';
      ExecSQL
    end;
end;

// �������� ��
procedure TDM1.SaveBarcode(GoodsCode: String; Barcode: String);
begin
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;
      SQL.Text := 'INSERT INTO barcodes (bc_goodscode, bc_barcode) ' +
                  'VALUES (:goodscode, :barcode)';
      ParamByName('goodscode').AsString := GoodsCode;
      ParamByName('barcode').AsString := Barcode;
      ExecSQL
    end;
end;

// �������� ���������� ��
procedure TDM1.BatchSaveBarcode(barcodeArray: TBarcodeArray);
var
  sizeOfArray, i: Integer;
begin
  sizeOfArray := Length(barcodeArray);

  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'INSERT INTO barcodes (bc_goodscode, bc_barcode) ' +
                  'VALUES (:goodscode, :barcode)';

      Params.ArraySize := sizeOfArray;

      for i := 0 to sizeOfArray - 1 do
        begin
          ParamByName('goodscode').AsStrings[i] := barcodeArray[i].goodsCode;
          ParamByName('barcode').AsStrings[i]   := barcodeArray[i].barcode;
        end;

      Execute(sizeOfArray, 0);
    end;
end;

// ������� ��� �� ������������ ������
procedure TDM1.DeleteAllBarcodesOfGoods(GoodsCode: String);
begin
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'DELETE FROM barcodes WHERE bc_goodscode=:goodscode';
      ParamByName('goodscode').AsString := GoodsCode;
      ExecSQL
    end;
end;

//������� ��� ��
procedure TDM1.DeleteAllBarcodes;
begin
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'DELETE FROM barcodes';
      ExecSQL
    end;
end;

// �������� ������ ��
procedure TDM1.SaveBarcodeTemplate(BCTR: TBCTemplateRecord);
begin
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      if BCTR.bctID = 0 then //����� �������
        SQL.Text := 'INSERT INTO barcodetemplates (bct_name, bct_template) ' +
                    'VALUES (:name, :template)'
      else
        begin
          SQL.Text := 'UPDATE barcodetemplates ' +
                      'SET bct_name=:name, bct_template=:template ' +
                      'WHERE bct_id=:id';

          ParamByName('id').AsInteger := BCTR.bctID;
        end;

      ParamByName('name').AsString := BCTR.bctName;
      ParamByName('template').AsString := BCTR.bctTemplate;

      ExecSQL
    end;
end;

// ������� ������ ��
procedure TDM1.DeleteBarcodeTemplate(ID: Integer);
begin
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;
      SQL.Text := 'DELETE FROM barcodetemplates WHERE bct_id=:id';
      ParamByName('id').AsInteger := ID;
      ExecSQL
    end;
end;

// ��������� �������
procedure TDM1.SaveCashier(CR: TCashierRecord);
begin
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      if CR.cID <= 0 then
        begin
          SQL.Text := 'SELECT MAX(cashiers_id) AS cashierid FROM cashiers'; // �������� ������� �������� ��������
          OpenOrExecute;

          try
            CR.cID := FieldByName('cashierid').AsInteger + 1;               // ��������� �������� ��������
          except
            CR.cID := 1                                                     // ���� ��� �� ������ �������
          end;
        end;

      SQL.Text := 'INSERT OR REPLACE INTO cashiers (cashiers_id, cashiers_inn, cashiers_name, cashiers_barcode, cashiers_password, cashiers_position, cashiers_profile, cashiers_photo)' + #13#10 +
                  'VALUES (:id, :inn, :name, :barcode, :password, :position, :profile, :photo)';


      ParamByName('id').AsInteger      := CR.cID;
      ParamByName('inn').AsString      := CR.cINN;
      ParamByName('name').AsString     := CR.cName;
      ParamByName('barcode').AsString  := CR.cBarcode;
      ParamByName('password').AsString := CR.cPassword;
      ParamByName('position').AsString := CR.cPosition;
      ParamByName('profile').AsInteger := CR.cProfile;
      ParamByName('photo').AsString    := CR.cPhoto;
      ExecSQL
    end;
end;

// ������� �������
procedure TDM1.DeleteCashier(ID: Integer);
begin
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text                    := 'DELETE FROM cashiers WHERE cashiers_id=:id';
      ParamByName('id').AsInteger := ID;
      ExecSQL
    end;
end;

// ������� ���� ��������
procedure TDM1.DeleteAllCashiers;
begin
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'DELETE FROM cashiers';
      ExecSQL
    end;
end;

// ������� ������� ��������
procedure TDM1.DeleteCashiersProfile(Code: Integer);
begin
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text                      := 'DELETE FROM cashiersprofiles WHERE profiles_code=:code';
      ParamByName('code').AsInteger := Code;
      ExecSQL
    end;
end;

// �������� ������� �������
procedure TDM1.AddCashiersProfile(CPR: TCashierProfileRecord);
begin
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'INSERT INTO cashiersprofiles (profiles_code, profiles_name, profiles_settings) ' +
                  'VALUES (:code, :name, :settings)';

      with CPR do
        begin
          ParamByName('code').AsInteger     := cpCode;
          ParamByName('name').AsString      := cpName;
          ParamByName('settings').AsBoolean := cpSettings;
        end;

      ExecSQL;
    end;
end;

// �������� ������� �������
procedure TDM1.UpdateCashiersProfile(CPR: TCashierProfileRecord; OldCode: Integer);
begin
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'UPDATE cashiersprofiles SET profiles_code=:code, profiles_name=:name, profiles_settings=:settings ' +
                  'WHERE profiles_code=:oldcode';

      with CPR do
        begin
          ParamByName('code').AsInteger     := cpCode;
          ParamByName('name').AsString      := cpName;
          ParamByName('settings').AsBoolean := cpSettings;
          ParamByName('oldcode').AsInteger  := OldCode;
        end;

      ExecSQL;
    end;
end;

// ��������� �����
procedure TDM1.SaveTax(TR: TTaxRecord);
begin
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'INSERT OR REPLACE INTO taxes (taxes_id, taxes_value, taxes_code) ' +
                  'VALUES (:id, :value, :code)';

      ParamByName('id').AsInteger   := TR.taxID;
      ParamByName('value').AsString := TR.taxValue;
      ParamByName('code').AsInteger := TR.taxCode;

      ExecSQL
    end;
end;

// ������� ��� ������
procedure TDM1.DeleteAllTaxes;
begin
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'DELETE FROM taxes';
      ExecSQL
    end;
end;

// ������� �����
procedure TDM1.DeleteTax(ID: Integer);
begin
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'DELETE FROM taxes WHERE taxes_id=:id';
      ParamByName('id').AsInteger := ID;
      ExecSQL
    end;
end;

// �������� ������
procedure TDM1.SaveDiscount(DR: TDiscountRecord);
begin
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      if DR.discID = 0 then //����� �������
        SQL.Text := 'INSERT INTO discounts (disc_name, disc_value, disc_position) ' +
                    'VALUES (:name, :value, :position)'
      else
        begin
          SQL.Text := 'UPDATE discounts ' +
                      'SET disc_name=:name, disc_value=:value, disc_position=:position ' +
                      'WHERE disc_id=:id';

          ParamByName('id').AsInteger := DR.discID;
        end;

      ParamByName('name').AsString      := DR.discName;
      ParamByName('value').AsFloat      := DR.discValue;
      ParamByName('position').AsBoolean := DR.discPosition;
      ExecSQL
    end;
end;

// ������� ������
procedure TDM1.DeleteDiscount(ID: Integer);
begin
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'DELETE FROM discounts WHERE disc_id=:id';
      ParamByName('id').AsInteger := ID;
      ExecSQL
    end;
end;

// ��������� ����� ���������
procedure TDM1.SaveCommonSettings(CSR: TCommonSettingsRecord);
begin
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'INSERT OR REPLACE INTO settings ' +
                    '(sett_id, ' +
                    'sett_backuppath, sett_backupnumber, sett_deldocsafterdays, ' +
                    'sett_exchangeformat, sett_exchangepath, sett_exchangedlfile, sett_exchangeulfile, sett_exchangedlfilef, sett_exchangeulfilef, sett_exchangeulclosesession, ' +
                    'sett_fnbufferalert, sett_fnendalert, sett_fnalertemail, ' +
                    'sett_roundmethod, sett_roundprecision, sett_roundmin, ' +
                    'sett_externalapp, sett_zreportemail, sett_blockyesbutton, ' +
                    'sett_companyname, sett_shopname, sett_companyinn, sett_companyaddress, sett_shopaddress, sett_companyemail, sett_companyweb, sett_companyphone) ' + #13#10 +
                  'VALUES ' +
                    '(1, ' +
                    ':backuppath, :backupnumber, :deldocsafterdays, ' +
                    ':exchangeformat, :exchangepath, :exchangedlfile, :exchangeulfile, :exchangedlfilef, :exchangeulfilef, :exchangeulclosesession, ' +
                    ':fnbufferalert, :fnendalert, :fnalertemail, ' +
                    ':roundmethod, :roundprecision, :roundmin, ' +
                    ':externalapp, :zreportemail, :blockyesbutton, ' +
                    ':companyname, :shopname, :companyinn, :companyaddress, :shopaddress, :companyemail, :companyweb, :companyphone)';

      with CSR do
        begin
          ParamByName('backuppath').AsString        := backupPath;
          ParamByName('backupnumber').AsInteger     := backupNumber;
          ParamByName('deldocsafterdays').AsInteger := delDocsAfterDays;

          ParamByName('exchangeformat').AsSmallInt        := exchangeFormat;
          ParamByName('exchangepath').AsString            := exchangePath;
          ParamByName('exchangedlfile').AsString          := exchangeDLFile;
          ParamByName('exchangeulfile').AsString          := exchangeULFile;
          ParamByName('exchangedlfilef').AsString         := exchangeDLFileF;
          ParamByName('exchangeulfilef').AsString         := exchangeULFileF;
          ParamByName('exchangeulclosesession').AsBoolean := exchangeULCloseSession;

          ParamByName('fnbufferalert').AsInteger := fnBufferAlert;
          ParamByName('fnendalert').AsInteger    := fnEndAlert;
          ParamByName('fnalertemail').AsString   := fnAlertEmail;

          ParamByName('roundmethod').AsSmallInt := roundMethod;
          ParamByName('roundprecision').AsFloat := roundPrecision;
          ParamByName('roundmin').AsFloat       := roundMin;

          ParamByName('externalapp').AsString     := externalApp;
          ParamByName('zreportemail').AsString    := zReportEmail;
          ParamByName('blockyesbutton').AsInteger := blockYesButton;

          ParamByName('companyname').AsString    := companyName;
          ParamByName('shopname').AsString       := shopName;
          ParamByName('companyinn').AsString     := companyINN;
          ParamByName('companyaddress').AsString := companyAddress;
          ParamByName('shopaddress').AsString    := shopAddress;
          ParamByName('companyemail').AsString   := companyEmail;
          ParamByName('companyweb').AsString     := companyWeb;
          ParamByName('companyphone').AsString   := companyPhone;
        end;

      ExecSQL
    end;
end;

// �������� ����� ���������
function TDM1.GetCommonSettings: TCommonSettingsRecord;
begin
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'SELECT * FROM settings';
      OpenOrExecute;

      if RecordCount > 0 then
        with Result do
          begin
            First;

            backupPath       := FieldByName('sett_backuppath').AsString;
            backupNumber     := FieldByName('sett_backupnumber').AsInteger;
            delDocsAfterDays := FieldByName('sett_deldocsafterdays').AsInteger;

            exchangeFormat         := FieldByName('sett_exchangeformat').AsInteger;
            exchangePath           := FieldByName('sett_exchangepath').AsString;
            exchangeDLFile         := FieldByName('sett_exchangedlfile').AsString;
            exchangeULFile         := FieldByName('sett_exchangeulfile').AsString;
            exchangeDLFileF        := FieldByName('sett_exchangedlfilef').AsString;
            exchangeULFileF        := FieldByName('sett_exchangeulfilef').AsString;
            exchangeULCloseSession := FieldByName('sett_exchangeulclosesession').AsBoolean;

            fnBufferAlert := FieldByName('sett_fnbufferalert').AsInteger;
            fnEndAlert    := FieldByName('sett_fnendalert').AsInteger;
            fnAlertEmail  := FieldByName('sett_fnalertemail').AsString;

            roundMethod    := FieldByName('sett_roundmethod').AsInteger;
            roundPrecision := FieldByName('sett_roundprecision').AsFloat;
            roundMin       := FieldByName('sett_roundmin').AsFloat;

            externalApp    := FieldByName('sett_externalapp').AsString;
            zReportEmail   := FieldByName('sett_zreportemail').AsString;
            blockYesButton := FieldByName('sett_blockyesbutton').AsInteger;

            companyName    := FieldByName('sett_companyname').AsString;
            shopName       := FieldByName('sett_shopname').AsString;
            companyINN     := FieldByName('sett_companyinn').AsString;
            companyAddress := FieldByName('sett_companyaddress').AsString;
            shopAddress    := FieldByName('sett_shopaddress').AsString;
            companyEmail   := FieldByName('sett_companyemail').AsString;
            companyWeb     := FieldByName('sett_companyweb').AsString;
            companyPhone   := FieldByName('sett_companyphone').AsString;
          end
      else // ���� � �� ��� ������ � ���������� (������������ �� ��� �� ���� �� ��������)
        with Result do
          begin
            backupPath       := '';
            backupNumber     := 0;
            delDocsAfterDays := 0;

            exchangeFormat         := 0;
            exchangePath           := '';
            exchangeDLFile         := '';
            exchangeULFile         := '';
            exchangeDLFileF        := '';
            exchangeULFileF        := '';
            exchangeULCloseSession := False;

            fnBufferAlert := 0;
            fnEndAlert    := 0;
            fnAlertEmail  := '';

            roundMethod    := 0;
            roundPrecision := 0;
            roundMin       := 0;

            externalApp    := '';
            zReportEmail   := '';
            blockYesButton := 0;

            companyName    := '';
            shopName       := '';
            companyINN     := '';
            companyAddress := '';
            shopAddress    := '';
            companyEmail   := '';
            companyWeb     := '';
            companyPhone   := '';
          end;
    end;
end;

// ��������� ������������ ���������
procedure TDM1.SaveNonVisualSetting(NVSR: TNonVisualSettingsRecord);
begin
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'INSERT OR REPLACE INTO nonvisualsettings ' +
                    '(nvs_id, nvs_dbversion, nvs_lastlabel, nvs_lastprinter, nvs_lastcashier, nvs_lastbackupdate, nvs_sessionisopen, nvs_sessionnumber, nvs_barcodecounter)' + #13#10 +
                  'VALUES ' +
                    '(1, :dbversion, :lastlabel, :lastprinter, :lastcashier, :lastbackupdate, :sessionisopen, :sessionnumber, :barcodecounter)';

      with NVSR do
        begin
          ParamByName('dbversion').AsString        := dbVersion;
          ParamByName('lastlabel').AsString        := lastLabel;
          ParamByName('lastprinter').AsString      := lastPrinter;
          ParamByName('lastcashier').AsInteger     := lastCashier;
          ParamByName('lastbackupdate').AsDateTime := lastBackupDate;
          ParamByName('sessionisopen').AsBoolean   := sessionIsOpen;
          ParamByName('sessionnumber').AsInteger   := sessionNumber;
          ParamByName('barcodecounter').AsInteger  := barcodeCounter;
        end;

      ExecSQL
    end;
end;

// �������� ������������ ���������
function TDM1.GetNonVisualSettings: TNonVisualSettingsRecord;
begin
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'SELECT * FROM nonvisualsettings';
      OpenOrExecute;

      if RecordCount > 0 then
        with Result do
          begin
            First;

            if FindField('nvs_dbversion') <> nil then // � ������ ������ �� �� ���� ����� ����
              dbVersion := FieldByName('nvs_dbversion').AsString
            else
              dbVersion := '0';
            lastLabel      := FieldByName('nvs_lastlabel').AsString;
            lastPrinter    := FieldByName('nvs_lastprinter').AsString;
            lastCashier    := FieldByName('nvs_lastcashier').AsInteger;
            lastBackupDate := FieldByName('nvs_lastbackupdate').AsDateTime;
            sessionIsOpen  := FieldByName('nvs_sessionisopen').AsBoolean;
            sessionNumber  := FieldByName('nvs_sessionnumber').AsInteger;
            barcodeCounter := FieldByName('nvs_barcodecounter').AsInteger;
          end
      else //���� � �� ��� ������ � ����������
        with Result do
          begin
            dbVersion      := '0';
            lastLabel      := '';
            lastPrinter    := '';
            lastCashier    := 0;
            //LastBackupDate :=
            sessionIsOpen  := False;
            sessionNumber  := 0;
            barcodeCounter := 0;
          end;
    end;
end;

// ��������� ��������� ����������� �����
procedure TDM1.SaveDigitalScaleSettings(Model, Port: SmallInt; Speed: Integer; Status: Boolean);
var
  RecCount: Integer;
begin
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'INSERT OR REPLACE INTO digitalscalesettings (dss_id, dss_model, dss_port, dss_speed, dss_status) ' +
                  'VALUES (1, :model, :port, :speed, :status)';

      ParamByName('model').AsSmallInt := Model;
      ParamByName('port').AsSmallInt  := Port;
      ParamByName('speed').AsInteger  := Speed;
      ParamByName('status').AsBoolean := Status;
      ExecSQL
    end;
end;

// ��������� ��������� ��
procedure TDM1.SaveFRSetting(FRSR: TFRSettingsRecord);
begin
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'INSERT OR REPLACE INTO frsettings ' +
                    '(frs_id, frs_model, frs_accesspassword, frs_operatorpassword, frs_port, frs_speed, frs_ip, frs_status, frs_synchrotime, frs_timealert, frs_printreceipt, frs_manufacturer, frs_chanel, frs_mac)' + #13#10 +
                  'VALUES ' +
                    '(1, :model, :accesspassword, :operatorpassword, :port, :speed, :ip, :status, :synchrotime, :timealert, :printreceipt, :manufacturer, :chanel, :mac)';

      ParamByName('model').AsSmallInt           := FRSR.frModel;
      ParamByName('accesspassword').AsInteger   := FRSR.frAccessPassword;
      ParamByName('operatorpassword').AsInteger := FRSR.frOperatorPassword;
      ParamByName('port').AsSmallInt            := FRSR.frPort;
      ParamByName('speed').AsInteger            := FRSR.frSpeed;
      ParamByName('ip').AsString                := FRSR.frIP;
      ParamByName('status').AsBoolean           := FRSR.frStatus;
      ParamByName('synchrotime').AsBoolean      := FRSR.frSynchroTime;
      ParamByName('timealert').AsInteger        := FRSR.frTimeAlert;
      ParamByName('printreceipt').AsBoolean     := FRSR.frReceiptPrint;
      ParamByName('manufacturer').AsInteger     := FRSR.frManufacturer;
      ParamByName('chanel').AsInteger           := FRSR.frChanel;
      ParamByName('mac').AsString               := FRSR.frMAC;
      ExecSQL
    end;
end;

// �������� ��������� ��
function TDM1.GetFRSetting: TFRSettingsRecord;
begin
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'SELECT * FROM frsettings';
      OpenOrExecute;

      if RecordCount > 0 then
      with Result do
        begin
          First;

          frModel := FieldByName('frs_model').AsInteger;
          frAccessPassword := FieldByName('frs_accesspassword').AsInteger;
          frOperatorPassword := FieldByName('frs_operatorpassword').AsInteger;
          frPort := FieldByName('frs_port').AsInteger;
          frSpeed := FieldByName('frs_speed').AsInteger;
          frIP := FieldByName('frs_ip').AsString;
          frStatus := FieldByName('frs_status').AsBoolean;
          frSynchroTime := FieldByName('frs_synchrotime').AsBoolean;
          frTimeAlert := FieldByName('frs_timealert').AsInteger;
          frReceiptPrint := FieldByName('frs_printreceipt').AsBoolean;
          frManufacturer := FieldByName('frs_manufacturer').AsInteger;
          frChanel := FieldByName('frs_chanel').AsInteger;
          frMAC := FieldByName('frs_mac').AsString;
        end
      else //���� � �� ��� ������ � ����������
        with Result do
          begin
            frModel := 0;
            frAccessPassword := 0;
            frOperatorPassword := 0;
            frPort := 0;
            frSpeed := 4800;
            frIP := '';
            frStatus := False;
            frSynchroTime := True;
            frTimeAlert := 0;
            frReceiptPrint := True;
            frManufacturer := 0;
            frChanel := 0;
            frMAC := '';
          end;

    end;
end;

// ��������� ��������� ����� � ��
procedure TDM1.SaveLPScaleSettings(Model, Port, LogicalNumber, DecPoint: SmallInt; Speed: Integer; IP: String; Status: Boolean);
var
  RecCount: Integer;
begin
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'INSERT OR REPLACE INTO lpscalesettings (lpss_id, lpss_model, lpss_port, lpss_logicalnumber, lpss_decpoint, lpss_speed, lpss_ip, lpss_status) ' +
                  'VALUES (1, :model, :port, :logicalnumber, :decpoint, :speed, :ip, :status)';

      ParamByName('model').AsSmallInt         := Model;
      ParamByName('port').AsSmallInt          := Port;
      ParamByName('logicalnumber').AsSmallInt := LogicalNumber;
      ParamByName('decpoint').AsSmallInt      := DecPoint;
      ParamByName('speed').AsInteger          := Speed;
      ParamByName('ip').AsString              := IP;
      ParamByName('status').AsBoolean         := Status;
      ExecSQL
    end;
end;

// ��������� ��������� ��
procedure TDM1.SaveDrawerSettings(DSR: TDrawerSettingsRecord);
begin
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'INSERT OR REPLACE INTO moneyboxsettings (mbs_id, mbs_autoopen, mbs_status) ' +
                  'VALUES (1, :autoopen, :status)';

      ParamByName('autoopen').AsBoolean := DSR.autoOpen;
      ParamByName('status').AsBoolean   := DSR.status;
      ExecSQL
    end;
end;

// �������� ��������� ��
function TDM1.GetDrawerSettings: TDrawerSettingsRecord;
begin
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'SELECT * FROM moneyboxsettings';
      OpenOrExecute;

      if RecordCount > 0 then
        with Result do
          begin
            First;

            status := FieldByName('mbs_status').AsBoolean;
            autoOpen := FieldByName('mbs_autoopen').AsBoolean;
          end
      else // ���� � �� ��� ������ � ����������
        with Result do
          begin
            status := False;
            autoOpen := False
          end;
    end;
end;

// ��������� ��������� ������� ��
procedure TDM1.SaveScanerSettings(SSR: TScanerSettingsRecord);
begin
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'INSERT OR REPLACE INTO bcscanersettings (bcss_id, bcss_chanel, bcss_port, bcss_speed, bcss_sensitivity, bcss_prefix, bcss_sufix, bcss_status) ' +
                  'VALUES (1, :chanel, :port, :speed, :sensitivity, :prefix, :sufix, :status)';
      with SSR do
        begin
          ParamByName('status').AsBoolean      := sStatus;
          ParamByName('chanel').AsInteger      := sChanel;
          ParamByName('port').AsInteger        := sPort;
          ParamByName('speed').AsInteger       := sSpeed;
          ParamByName('sensitivity').AsInteger := sSensitivity;
          ParamByName('prefix').AsString       := sPrefix;
          ParamByName('sufix').AsString        := sSufix;
        end;

      ExecSQL
    end;
end;

// �������� ��������� ������� ��
function TDM1.GetScanerSettings: TScanerSettingsRecord;
begin
  with FDQuery1 do
    begin
      Close;
      SQL.Clear;
      Params.Clear;

      SQL.Text := 'SELECT * FROM bcscanersettings';
      OpenOrExecute;

      if RecordCount > 0 then
        with Result do
          begin
            First;

            sStatus := FieldByName('bcss_status').AsBoolean;
            sChanel := FieldByName('bcss_chanel').AsInteger;
            sPort := FieldByName('bcss_port').AsInteger;
            sSpeed := FieldByName('bcss_speed').AsInteger;
            sSensitivity := FieldByName('bcss_sensitivity').AsInteger;
            sPrefix := FieldByName('bcss_prefix').AsString;
            sSufix := FieldByName('bcss_sufix').AsString;

          end
        else //���� � �� ��� ������ � ����������
          with Result do
            begin
              sStatus := False;
              sChanel := 1;
              sPort := 0;
              sSpeed := 1200;
              sSensitivity := 30;
              sPrefix := '';
              sSufix := '#13';
            end;

    end;
end;

// �������������� ������������ ���� ���� � �������� ���
function TDM1.ReceiptTypeToInternalCode(ReceiptType: String): Integer;
begin
  ReceiptType := AnsiLowerCase(ReceiptType);

  if ReceiptType = '�������' then
    Result := 1
  else
  if ReceiptType = '�������' then
    Result := 2
  else
  if ReceiptType = '������' then
    Result := 3
  else
  if ReceiptType = '������� �������' then
    Result := 4
  else
  if ReceiptType = '��������� �������' then
    Result := 5
  else
  if ReceiptType = '��������� �������' then
    Result := 6
  else
  if ReceiptType = '��������� �������� �������' then
    Result := 7
  else
  if ReceiptType = '��������� �������� �������' then
    Result := 8
  else
    Result := -1;
end;

// �������������� ��������� ���� � ������������ ���� ����
function TDM1.InternalCodeToReceiptType(ReceiptCode: Integer): String;
begin
  case ReceiptCode of
    1: Result := '�������';
    2: Result := '�������';
    3: Result := '������';
    4: Result := '������� �������';
    5: Result := '��������� �������';
    6: Result := '��������� �������';
    7: Result := '��������� �������� �������';
    8: Result := '��������� �������� �������'
  else
    Result := ''
  end;
end;

procedure TDM1.BackupDB;
var
  commonSettings: TCommonSettingsRecord;
  timeStamp     : String;
  i             : Integer;
begin
  commonSettings := DM1.GetCommonSettings;

  if commonSettings.backupPath = '' then
    begin
      YesNoDialog('� ���������� ��������� �� ������ ������� �������� ��������� ����� ���� ������. ��������� ����� �� �������.', 1, False);
      Exit
    end;

  if not DirectoryExists(commonSettings.backupPath) then
    begin
      YesNoDialog('�� ������ ������� �������� ��������� ����� ���� ������. ��������� ����� �� �������.', 1, False);
      Exit
    end;

  timeStamp := DateTimeToStr(Now);

  for i := 1 to Length(timeStamp) do
    try
      StrToInt(timeStamp[i]);
    except
      timeStamp[i] := '_';
    end;

  with FDSQLiteBackup1 do
    begin
      DatabaseObj  := FDConnection1.CliObj;
      DestDatabase := commonSettings.backupPath + 'main_' + TimeStamp + '.db';
      Backup
    end;
end;

end.
