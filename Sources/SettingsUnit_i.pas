unit SettingsUnit_i;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, sToolEdit, sSpinEdit,
  Vcl.Buttons, sSpeedButton, Vcl.ExtCtrls, sPanel, Vcl.ComCtrls, sListView,
  Vcl.Mask, sMaskEdit, sCustomComboEdit, Vcl.StdCtrls, sEdit, sComboBox, sLabel,
  sPageControl, sComboEdit, acImage, Vcl.ExtDlgs, sDialogs;

type
  TframeSettings = class(TFrame)
    sPageControl5: TsPageControl;
    sTabSheet13: TsTabSheet;
    sPageControl6: TsPageControl;
    sTabSheet19: TsTabSheet;
    sLabel14: TsLabel;
    sLabel15: TsLabel;
    sLabel16: TsLabel;
    sLabel17: TsLabel;
    sLabel18: TsLabel;
    sLabel19: TsLabel;
    sLabel20: TsLabel;
    sLabel49: TsLabel;
    cbFRStatus: TsComboBox;
    cbFRManufacturer: TsComboBox;
    cbFRModel: TsComboBox;
    cbFRBaudrate: TsComboBox;
    editFRIP: TsEdit;
    cbFRTimeSynchronize: TsComboBox;
    cbFRReceiptPrint: TsComboBox;
    sTabSheet20: TsTabSheet;
    sLabel21: TsLabel;
    sLabel22: TsLabel;
    cbDrawerStatus: TsComboBox;
    cbDrawerAutoopen: TsComboBox;
    sTabSheet21: TsTabSheet;
    sLabel23: TsLabel;
    sLabel24: TsLabel;
    sLabel25: TsLabel;
    cbScanerStatus: TsComboBox;
    cbScanerChanel: TsComboBox;
    cbScanerSpeed: TsComboBox;
    sTabSheet22: TsTabSheet;
    sLabel26: TsLabel;
    sLabel27: TsLabel;
    sLabel28: TsLabel;
    sLabel29: TsLabel;
    cbDigitalScaleStatus: TsComboBox;
    cbDigitalScaleModel: TsComboBox;
    cbDigitalScalePort: TsComboBox;
    cbDigitalScaleSpeed: TsComboBox;
    sTabSheet23: TsTabSheet;
    sLabel30: TsLabel;
    sLabel31: TsLabel;
    sLabel32: TsLabel;
    sLabel33: TsLabel;
    cbLPScaleStatus: TsComboBox;
    cbLPScaleModel: TsComboBox;
    editLPScaleIP: TsEdit;
    seLPScaleLogicalNumber: TsSpinEdit;
    sTabSheet24: TsTabSheet;
    sLabel34: TsLabel;
    sLabel35: TsLabel;
    sLabel36: TsLabel;
    sLabel37: TsLabel;
    cbBankStatus: TsComboBox;
    cbBankType: TsComboBox;
    sTabSheet14: TsTabSheet;
    sLabel38: TsLabel;
    sLabel39: TsLabel;
    sLabel40: TsLabel;
    seDBBackupNumber: TsSpinEdit;
    seDocAutoDeleteDays: TsSpinEdit;
    sTabSheet15: TsTabSheet;
    sPageControl7: TsPageControl;
    sTabSheet25: TsTabSheet;
    lvDiscounts: TsListView;
    sPanel10: TsPanel;
    btnAddDiscount: TsSpeedButton;
    btnDeleteDiscount: TsSpeedButton;
    sTabSheet26: TsTabSheet;
    sLabel41: TsLabel;
    sLabel42: TsLabel;
    sPanel11: TsPanel;
    btnSaveDiscount: TsSpeedButton;
    btnCancelDiscount: TsSpeedButton;
    cbDiscountType: TsComboBox;
    sTabSheet16: TsTabSheet;
    sLabel43: TsLabel;
    sLabel44: TsLabel;
    sLabel45: TsLabel;
    seFNBufferAlert: TsSpinEdit;
    seFNEndAlert: TsSpinEdit;
    editFNAlertEmail: TsEdit;
    ����������: TsTabSheet;
    sLabel46: TsLabel;
    sLabel47: TsLabel;
    sLabel48: TsLabel;
    cbRoundMethod: TsComboBox;
    seRoundPrecision: TsDecimalSpinEdit;
    seRoundMin: TsDecimalSpinEdit;
    sTabSheet17: TsTabSheet;
    sPageControl8: TsPageControl;
    sTabSheet27: TsTabSheet;
    sPageControl9: TsPageControl;
    sTabSheet29: TsTabSheet;
    lvBCTemplates: TsListView;
    sPanel12: TsPanel;
    btnAddBCTemplate: TsSpeedButton;
    btnEditBCTemplate: TsSpeedButton;
    btnDeleteBCTemplate: TsSpeedButton;
    sTabSheet30: TsTabSheet;
    sLabel63: TsLabel;
    sLabel64: TsLabel;
    sLabel65: TsLabel;
    sLabel66: TsLabel;
    sLabel67: TsLabel;
    sLabel68: TsLabel;
    btnAddBCTemplateElement: TsSpeedButton;
    sPanel13: TsPanel;
    btnSaveBarcodeTemplate: TsSpeedButton;
    btnCancelBarcodeTemplate: TsSpeedButton;
    editBCTemplateName: TsEdit;
    editBCTemplate: TsEdit;
    seBCTemplatePrefix: TsSpinEdit;
    cbBCTemplateElement: TsComboBox;
    seBCTemplateMultiplier: TsDecimalSpinEdit;
    seBCTemplateNumberOfDigits: TsSpinEdit;
    sTabSheet28: TsTabSheet;
    sPageControl10: TsPageControl;
    sTabSheet32: TsTabSheet;
    lvTaxes: TsListView;
    sPanel14: TsPanel;
    sTabSheet33: TsTabSheet;
    sLabel50: TsLabel;
    sLabel51: TsLabel;
    sPanel15: TsPanel;
    btnSaveTax: TsSpeedButton;
    btnCancelTax: TsSpeedButton;
    seTaxID: TsSpinEdit;
    sTabSheet31: TsTabSheet;
    sPageControl11: TsPageControl;
    sTabSheet34: TsTabSheet;
    lvCashiers: TsListView;
    sPanel16: TsPanel;
    btnAddCashier: TsSpeedButton;
    btnDeleteCashier: TsSpeedButton;
    sTabSheet35: TsTabSheet;
    sLabel53: TsLabel;
    sLabel54: TsLabel;
    sLabel55: TsLabel;
    sLabel56: TsLabel;
    sLabel57: TsLabel;
    sPanel17: TsPanel;
    btnSaveCashier: TsSpeedButton;
    btnCancelCashier: TsSpeedButton;
    editCashierName: TsEdit;
    editCashierPosition: TsEdit;
    editCashierINN: TsEdit;
    editCashierPass: TsEdit;
    editCashierBC: TsEdit;
    sTabSheet18: TsTabSheet;
    sLabel60: TsLabel;
    sLabel61: TsLabel;
    sLabel62: TsLabel;
    seYesButtonDisableTime: TsSpinEdit;
    editZReportEmail: TsEdit;
    sTabSheet1: TsTabSheet;
    sLabel1: TsLabel;
    cbExchangeFormat: TsComboBox;
    sLabel2: TsLabel;
    editExchangeDLFile: TsEdit;
    sLabel3: TsLabel;
    sLabel4: TsLabel;
    editExchangeDLFileF: TsEdit;
    sLabel5: TsLabel;
    editExchangeULFile: TsEdit;
    sLabel6: TsLabel;
    editExchangeULFileF: TsEdit;
    sLabel7: TsLabel;
    cbAutoULReport: TsComboBox;
    editExternalApp: TsEdit;
    editBankDBDirectory: TsEdit;
    editBankExchangeDirectory: TsEdit;
    editDBBackupDirectory: TsEdit;
    editExchangeDirectory: TsEdit;
    editDiscountName: TsEdit;
    sLabel9: TsLabel;
    timerInit: TTimer;
    sLabel10: TsLabel;
    editBCTemplateCode: TsEdit;
    btnEditTax: TsSpeedButton;
    sLabel11: TsLabel;
    cbCashierProfile: TsComboBox;
    sLabel12: TsLabel;
    btnEditCashier: TsSpeedButton;
    sLabel13: TsLabel;
    editCashierCode: TsEdit;
    imgCashierPhoto: TsImage;
    btnCashierPhotoDelete: TsSpeedButton;
    OpenPictureDialog1: TsOpenPictureDialog;
    btnSelectBankDBDirectory: TsSpeedButton;
    btnSelectBankExchangeDirectory: TsSpeedButton;
    btnSelectDBBackupDirectory: TsSpeedButton;
    btnSelectExchangeDirectory: TsSpeedButton;
    btnGenerateCashierBC: TsSpeedButton;
    btnSelectExternalApp: TsSpeedButton;
    sTabSheet2: TsTabSheet;
    sPageControl1: TsPageControl;
    sTabSheet3: TsTabSheet;
    sTabSheet4: TsTabSheet;
    lvCashiersProfiles: TsListView;
    sPanel1: TsPanel;
    btnAddCashierProfile: TsSpeedButton;
    btnDeleteCashierProfile: TsSpeedButton;
    btnEditCashierProfile: TsSpeedButton;
    sLabel69: TsLabel;
    sLabel70: TsLabel;
    editCashierProfileName: TsEdit;
    sLabel71: TsLabel;
    cbCashierProfileSettingsAccess: TsComboBox;
    sPanel2: TsPanel;
    btnSaveCashierProfile: TsSpeedButton;
    btnCancelCashierProfile: TsSpeedButton;
    seCashierProfileCode: TsSpinEdit;
    editDiscountCode: TsEdit;
    sLabel72: TsLabel;
    btnEditDiscount: TsSpeedButton;
    seDiscountValue: TsDecimalSpinEdit;
    btnSaveFR: TsSpeedButton;
    btnSaveDrawer: TsSpeedButton;
    btnSaveBCScaner: TsSpeedButton;
    btnSaveDigitalScale: TsSpeedButton;
    btnSaveLPScale: TsSpeedButton;
    btnSaveBank: TsSpeedButton;
    btnSaveDBSettings: TsSpeedButton;
    btnSaveExchangeSettings: TsSpeedButton;
    btnSaveOFDSettings: TsSpeedButton;
    btnSaveRoundSettings: TsSpeedButton;
    btnSaveCommonSettings: TsSpeedButton;
    sLabel73: TsLabel;
    seFRTimeAlert: TsSpinEdit;
    sTabSheet5: TsTabSheet;
    sLabel59: TsLabel;
    editCompanyName: TsEdit;
    sLabel74: TsLabel;
    editShopName: TsEdit;
    sLabel75: TsLabel;
    editCompanyAddress: TsEdit;
    sLabel76: TsLabel;
    editShopAddress: TsEdit;
    sLabel77: TsLabel;
    editCompanyINN: TsEdit;
    sLabel78: TsLabel;
    editCompanyPhone: TsEdit;
    sLabel79: TsLabel;
    editCompanyEmail: TsEdit;
    sLabel80: TsLabel;
    editCompanyWeb: TsEdit;
    btnSaveCompanyInfo: TsSpeedButton;
    btnFRConnectionTest: TsSpeedButton;
    cbFRConnectionChanel: TsComboBox;
    sLabel81: TsLabel;
    seFRComPortNumber: TsSpinEdit;
    sLabel82: TsLabel;
    editFRMAC: TsEdit;
    seTaxCode: TsSpinEdit;
    editTaxValue: TsEdit;
    sLabel52: TsLabel;
    seScanerComPortNumber: TsSpinEdit;
    sLabel83: TsLabel;
    editScanerPrefix: TsEdit;
    sLabel84: TsLabel;
    editScanerSufix: TsEdit;
    btnClearSufix: TsSpeedButton;
    btnClearPrefix: TsSpeedButton;
    sTabSheet6: TsTabSheet;
    sLabel58: TsLabel;
    cbMailService: TsComboBox;
    sLabel85: TsLabel;
    editMailLogin: TsEdit;
    sLabel86: TsLabel;
    editMailPassword: TsEdit;
    sLabel88: TsLabel;
    editMailSMTP: TsEdit;
    sLabel90: TsLabel;
    seMailSMTPPort: TsSpinEdit;
    sLabel91: TsLabel;
    cbMailEncryption: TsComboBox;
    btnSaveMailSettings: TsSpeedButton;
    sSpeedButton1: TsSpeedButton;
    procedure btnSaveDiscountClick(Sender: TObject); //��������� ������
    procedure btnCancelDiscountClick(Sender: TObject); //������ ��������� �� ������
    procedure btnAddDiscountClick(Sender: TObject); //�������� ����� ������
    procedure btnAddBCTemplateClick(Sender: TObject); //�������� ����� ������ ��
    procedure btnSaveBarcodeTemplateClick(Sender: TObject); //��������� ������ ��
    procedure btnCancelBarcodeTemplateClick(Sender: TObject); //������ ��������� �� ������� ��
    procedure btnSaveTaxClick(Sender: TObject); //��������� �����
    procedure btnCancelTaxClick(Sender: TObject); //������ ��������� �� ������
    procedure btnAddCashierClick(Sender: TObject); //�������� ������ �������
    procedure seBCTemplatePrefixChange(Sender: TObject);
    procedure cbBCTemplateElementChange(Sender: TObject);
    procedure btnAddBCTemplateElementClick(Sender: TObject);
    procedure btnSaveCashierClick(Sender: TObject); //��������� �������
    procedure btnCancelCashierClick(Sender: TObject); //������ ��������� �� �������
    procedure PanelResize(Sender: TObject);
    procedure btnDeleteBCTemplateClick(Sender: TObject); //������� ������ ��
    procedure timerInitTimer(Sender: TObject); //������������� ������
    procedure btnEditBCTemplateClick(Sender: TObject); //������������� ������ ��
    procedure btnEditTaxClick(Sender: TObject); //��������������� �����
    procedure imgCashierPhotoClick(Sender: TObject); //������� ���� �������
    procedure btnCashierPhotoDeleteClick(Sender: TObject); //������� ���� �������
    procedure btnAddCashierProfileClick(Sender: TObject);  //�������� ����� ������� ��������
    procedure btnEditCashierProfileClick(Sender: TObject); //��������������� ������� ��������
    procedure btnCancelCashierProfileClick(Sender: TObject); //������ ��������� � ������� ��������
    procedure btnSaveCashierProfileClick(Sender: TObject); //��������� ������� ��������
    procedure btnDeleteCashierProfileClick(Sender: TObject); //������� ������� ��������
    procedure btnEditCashierClick(Sender: TObject); //�������� �������
    procedure btnDeleteDiscountClick(Sender: TObject); //������� ������
    procedure btnEditDiscountClick(Sender: TObject); //�������� ������
    procedure btnSaveFRClick(Sender: TObject);
    procedure btnSelectDBBackupDirectoryClick(Sender: TObject);
    procedure btnSelectExchangeDirectoryClick(Sender: TObject);
    procedure btnSelectExternalAppClick(Sender: TObject);
    procedure btnSelectBankDBDirectoryClick(Sender: TObject);
    procedure btnSelectBankExchangeDirectoryClick(Sender: TObject);
    procedure SaveCommonSettingsClick(Sender: TObject);
    procedure btnFRConnectionTestClick(Sender: TObject);
    procedure btnSaveDrawerClick(Sender: TObject);
    procedure sPageControl6Change(Sender: TObject);
    procedure btnSaveBCScanerClick(Sender: TObject);
    procedure btnClearPrefixClick(Sender: TObject);
    procedure btnClearSufixClick(Sender: TObject);
    procedure editScanerPrefixKeyPress(Sender: TObject; var Key: Char);
    procedure editScanerSufixKeyPress(Sender: TObject; var Key: Char);
    procedure btnGenerateCashierBCClick(Sender: TObject);
    procedure cbCashierProfileChange(Sender: TObject);
    procedure cbMailServiceChange(Sender: TObject);
    procedure btnDeleteCashierClick(Sender: TObject);
  private
    { Private declarations }
    procedure BCTemplatesTableFill; //��������� ������� ������� � �������� ��
    procedure TaxesTableFill; //��������� ������� ������� � �������
    procedure CashiersTableFill; //��������� ������� ������� � ��������
    procedure CashiersProfilesFill; //��������� �������� ���������� ������� � �������� ��������
    procedure DiscountsTableFill; //��������� ������� ������� � �������
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses DBUnit, CommonUnit, FRDriverUnit;

//��������� ������� ������� � �������� ��
procedure TframeSettings.BCTemplatesTableFill;
var
  BCTA: TBCTemplateArray;
  i: Integer;
  NewItem: TListItem;
begin
  BCTA := DM1.GetBCTemplates; //����������� ������ �� ���� �������� ��

  lvBCTemplates.Clear;

  for i := 0 to Length(BCTA) - 1 do
  begin
    NewItem := lvBCTemplates.Items.Add;
    NewItem.Caption := IntToStr(BCTA[i].bctID);
    NewItem.SubItems.Add(BCTA[i].bctName);
    NewItem.SubItems.Add(BCTA[i].bctTemplate);
  end;
end;

//��������� ������� ������� � �������
procedure TframeSettings.TaxesTableFill;
var
  TA: TTaxArray;
  i: Integer;
  NewItem: TListItem;
begin
  TA := DM1.GetTaxes; //����������� ������ �� �������

  lvTaxes.Clear;

  for i := 0 to Length(TA) - 1 do
  begin
    NewItem := lvTaxes.Items.Add;
    NewItem.Caption := IntToStr(TA[i].taxID);
    NewItem.SubItems.Add(TA[i].taxValue);
    NewItem.SubItems.Add(IntToStr(TA[i].taxCode));
  end;
end;

// ��������� ������� ������� � ��������
procedure TframeSettings.CashiersTableFill;
var
  cashierArray: TCashierArray;
  i           : Integer;
  NewItem     : TListItem;
begin
  cashierArray := DM1.GetCashires; // ����������� ������ �� ��������

  lvCashiers.Clear;

  for i := 0 to Length(cashierArray) - 1 do
    begin
      NewItem         := lvCashiers.Items.Add;
      NewItem.Caption := IntToStr(cashierArray[i].cID);
      NewItem.SubItems.Add(cashierArray[i].cName);
      NewItem.SubItems.Add(DM1.GetCashierProfileData(cashierArray[i].cProfile).cpName);
    end;
end;

//��������� �������� ���������� ������� � �������� ��������
procedure TframeSettings.CashiersProfilesFill;
var
  CPA: TCashierProfileArray;
  i: Integer;
  NewItem: TListItem;
begin
  CPA := DM1.GetCashiersProfiles;

  lvCashiersProfiles.Clear;
  cbCashierProfile.Clear;

  for i := 0 to Length(CPA) - 1 do
  begin
    //��������� ������� �������� ��������
    NewItem := lvCashiersProfiles.Items.Add;
    NewItem.Caption := IntToStr(CPA[i].cpCode);
    NewItem.SubItems.Add(CPA[i].cpName);

    cbCashierProfile.Items.Add(CPA[i].cpName) //��������� ������ �������� �������� � ����� �������������� �������
  end;

end;

//��������� ������� ������� � �������
procedure TframeSettings.DiscountsTableFill;
var
  DA: TDiscountArray;
  i: Integer;
  NewItem: TListItem;
begin
  DA := DM1.GetDiscounts;

  lvDiscounts.Clear;

  for i := 0 to Length(DA) - 1 do
  begin
    NewItem := lvDiscounts.Items.Add;
    NewItem.Caption := IntToStr(DA[i].discID);
    NewItem.SubItems.Add(DA[i].discName);
    NewItem.SubItems.Add(FloatToStr(DA[i].discValue));
    if DA[i].discPosition then
      NewItem.SubItems.Add('�� �������')
    else
      NewItem.SubItems.Add('�� ���')
  end;
end;

//������������� ������
procedure TframeSettings.timerInitTimer(Sender: TObject);
var
  CSR: TCommonSettingsRecord;
  FRSR: TFRSettingsRecord;
  SSR: TScanerSettingsRecord;
begin
  timerInit.Enabled := False; //�.�. ������ ����������� ���� ���

  BCTemplatesTableFill; //��������� ������� �������� ��
  TaxesTableFill; //��������� ������� �������
  CashiersTableFill; //��������� ������� ��������
  CashiersProfilesFill; //��������� ��������� �������� �� �������� ����������, ��� ��� ������������
  DiscountsTableFill; //��������� ������� ������

  CSR := DM1.GetCommonSettings;

  with CSR do
  begin
    //��
    editDBBackupDirectory.Text := backupPath;
    seDBBackupNumber.Value := backupNumber;
    seDocAutoDeleteDays.Value := delDocsAfterDays;

    //����� �������
    cbExchangeFormat.ItemIndex := exchangeFormat;
    editExchangeDirectory.Text := exchangePath;
    editExchangeDLFile.Text := exchangeDLFile;
    editExchangeDLFileF.Text := exchangeULFile;
    editExchangeULFile.Text := exchangeDLFileF;
    editExchangeULFileF.Text := exchangeULFileF;
    cbAutoULReport.ItemIndex := Integer(exchangeULCloseSession);

    //��� � ��
    seFNBufferAlert.Value := fnBufferAlert;
    seFNEndAlert.Value := fnEndAlert;
    editFNAlertEmail.Text := fnAlertEmail;

    //����������
    cbRoundMethod.ItemIndex := roundMethod;
    seRoundPrecision.Value := roundPrecision;
    seRoundMin.Value := roundMin;

    //�����
    editExternalApp.Text := externalApp;
    editZReportEmail.Text := zReportEmail;
    seYesButtonDisableTime.Value := blockYesButton;

    //���������� � ��������
    editCompanyName.Text := companyName;
    editShopName.Text := shopName;
    editCompanyAddress.Text := companyAddress;
    editShopAddress.Text := shopAddress;
    editCompanyINN.Text := companyINN;
    editCompanyPhone.Text := companyPhone;
    editCompanyEmail.Text := companyEmail;
    editCompanyWeb.Text := companyWeb;
  end;

  FRSR := DM1.GetFRSetting;

  with FRSR do
  begin
    cbFRStatus.ItemIndex := Integer(frStatus);
    cbFRManufacturer.ItemIndex := frManufacturer;
    cbFRModel.ItemIndex := frModel;
    cbFRConnectionChanel.ItemIndex := frChanel;
    seFRComPortNumber.Value := frPort;
    cbFRBaudrate.ItemIndex := frSpeed;
    editFRIP.Text := frIP;
    editFRMAC.Text := frMAC;
    cbFRTimeSynchronize.ItemIndex := Integer(frSynchroTime);
    cbFRReceiptPrint.ItemIndex := Integer(frReceiptPrint);
    seFRTimeAlert.Value := frTimeAlert
  end;

  SSR := DM1.GetScanerSettings;

  with SSR do
    begin
      cbScanerStatus.ItemIndex := Integer(sStatus);
      cbScanerChanel.ItemIndex := sChanel;
      seScanerComPortNumber.Value := sPort;
      cbScanerSpeed.ItemIndex := sSpeed;
      editScanerPrefix.Text := sPrefix;
      editScanerSufix.Text := sSufix;
    end;
end;

//��������� ������ � ��������� ������ �� �������
procedure TframeSettings.PanelResize(Sender: TObject);
begin
  AlignPanelControls(Sender as TsPanel)
end;

//��� ��������� �������� �������� � ������� ��
procedure TframeSettings.seBCTemplatePrefixChange(Sender: TObject);
var
  s: String;
  p: Integer;
begin
  s := editBCTemplate.Text;
  p := Pos('�������', s);
  if p > 0 then
    s := Copy(s, Pos(']', s) + 1, Length(s) - Pos(']', s));
  editBCTemplate.Text := '[�������' + IntToStr(seBCTemplatePrefix.Value) + ']' + s;
end;

procedure TframeSettings.sPageControl6Change(Sender: TObject);
begin

end;

//��������� ��������� ��
procedure TframeSettings.btnSaveFRClick(Sender: TObject);
var
  FRSR: TFRSettingsRecord;
begin
  with FRSR do
  begin
    frStatus := cbFRStatus.ItemIndex = 1;
    frManufacturer := cbFRManufacturer.ItemIndex;
    frModel := cbFRModel.ItemIndex;
    frChanel := cbFRConnectionChanel.ItemIndex;
    frPort := seFRComPortNumber.Value;
    frSpeed := StrToInt(cbFRBaudrate.Text);
    frIP := editFRIP.Text;
    frMAC := editFRMAC.Text;
    frSynchroTime := cbFRTimeSynchronize.ItemIndex = 1;
    frReceiptPrint := cbFRReceiptPrint.ItemIndex = 1;
    frTimeAlert := seFRTimeAlert.Value;
  end;

  DM1.SaveFRSetting(FRSR);
end;

//��������� ��������� ��
procedure TframeSettings.btnSaveDrawerClick(Sender: TObject);
var
  DSR: TDrawerSettingsRecord;
begin
  with DSR do
    begin
      status := cbDrawerStatus.ItemIndex = 1;
      autoOpen := cbDrawerAutoopen.ItemIndex = 1
    end;

  DM1.SaveDrawerSettings(DSR);
end;

//��������� ������� �� ������� � ���� ����� �������� ������� ��
procedure TframeSettings.editScanerPrefixKeyPress(Sender: TObject;
  var Key: Char);
begin
  editScanerPrefix.Text := editScanerPrefix.Text + '#' + IntToStr(Ord(Key)) + ' ';
  Key := #0
end;

//��������� ������� �� ������� � ���� ����� ������� ������� ��
procedure TframeSettings.editScanerSufixKeyPress(Sender: TObject;
  var Key: Char);
begin
  editScanerSufix.Text := editScanerSufix.Text + '#' + IntToStr(Ord(Key)) + ' ';
  Key := #0
end;

//�������� ������� ������� ��
procedure TframeSettings.btnClearPrefixClick(Sender: TObject);
begin
  editScanerPrefix.Clear
end;

//�������� ������ ������� ��
procedure TframeSettings.btnClearSufixClick(Sender: TObject);
begin
  editScanerSufix.Clear
end;

//��������� ��������� ������� ��
procedure TframeSettings.btnSaveBCScanerClick(Sender: TObject);
var
  SSR: TScanerSettingsRecord;
begin
  with SSR do
    begin
      sStatus := cbScanerStatus.ItemIndex = 1;
      sChanel := cbScanerChanel.ItemIndex;
      sPort := seScanerComPortNumber.Value;
      sSpeed := StrToInt(cbScanerSpeed.Text);
      sPrefix := editScanerPrefix.Text;
      sSufix := editScanerSufix.Text;
    end;

  DM1.SaveScanerSettings(SSR);
end;

//��������� ������ ��
procedure TframeSettings.btnSaveBarcodeTemplateClick(Sender: TObject);
var
  BCTR: TBCTemplateRecord;
  NewItem: TListItem;
  ID: Integer;
begin
  if (Trim(editBCTemplateName.Text) = '') or (Trim(editBCTemplate.Text) = '') then
  begin
    YesNoDialog('���� "�����������" � "������" �� ������ ���� �������!', 1, False);
    Exit
  end;

  //��������� ���������
  with BCTR do
  begin
    if editBCTemplateCode.Text = '' then
      bctID := 0
    else
      bctID := StrToInt(editBCTemplateCode.Text);
    bctName := editBCTemplateName.Text;
    bctTemplate := editBCTemplate.Text;
  end;

  DM1.SaveBarcodeTemplate(BCTR); //��������� ������ �� � ��

  BCTemplatesTableFill; //������������� ������� �������� ��

  sPageControl9.ActivePageIndex := 0
end;

//�������� ������ ��
procedure TframeSettings.btnEditBCTemplateClick(Sender: TObject);
var
  SelectedItem: TListItem;
begin
  SelectedItem := lvBCTemplates.Selected;

  if SelectedItem = nil then
    Exit;

  editBCTemplateCode.Text := SelectedItem.Caption;
  editBCTemplateName.Text := SelectedItem.SubItems[0];
  editBCTemplate.Text := SelectedItem.SubItems[1];

  seBCTemplatePrefix.Value := 0;
  cbBCTemplateElement.ItemIndex := 0;
  seBCTemplateMultiplier.Value := 0.001;
  seBCTemplateNumberOfDigits.Value := 0;

  sPageControl9.ActivePageIndex := 1
end;

//��������� �� �������
procedure TframeSettings.btnGenerateCashierBCClick(Sender: TObject);
var
  bc: String;
begin
  bc := BarcodeGen('29', DM1.BarcodeGen);
  if bc <> '' then
    editCashierBC.Text := bc;
end;

// ��������� �������
procedure TframeSettings.btnSaveCashierClick(Sender: TObject);
var
  cashierRecord: TCashierRecord;
begin
  if Trim(editCashierName.Text) = '' then
    begin
      YesNoDialog('�� ������� ��� �������', 1, False);
      Exit
    end;

  if cbCashierProfile.Text = '' then
    begin
      YesNoDialog('�� ������ ������� �������', 1, False);
      Exit
    end;

//  if Trim(editCashierINN.Text) = '' then
//    begin
//      YesNoDialog('�� ������ ��� �������', 1, False);
//      Exit
//    end;

  with cashierRecord do
    begin
      if editCashierCode.Text = '' then
        cID := 0
      else
        cID := StrToInt(editCashierCode.Text);

      // ��������� ��������� ������ � ������� �������
      cName     := Trim(editCashierName.Text);
      cProfile  := DM1.GetCashierProfileCodeByName(cbCashierProfile.Text);
      cPosition := Trim(editCashierPosition.Text);
      cINN      := Trim(editCashierINN.Text);
      cPassword := editCashierPass.Text;
      cBarcode  := editCashierBC.Text;
      cPhoto    := imgCashierPhoto.Hint
    end;

  DM1.SaveCashier(cashierRecord); // ��������� ������ � ������� � ��

  CashiersTableFill;              // ������������� ������� ��������

  sPageControl11.ActivePageIndex := 0
end;

//��������� ������� �������
procedure TframeSettings.btnSaveCashierProfileClick(Sender: TObject);
var
  CPR: TCashierProfileRecord;
begin
  if Trim(editCashierProfileName.Text) = '' then
  begin
    YesNoDialog('�� ������� ��� ������� ��������', 1, False);
    Exit
  end;

  with CPR do
  begin
    if (DM1.GetCashierProfileData(seCashierProfileCode.Value).cpName <> '') and (seCashierProfileCode.Tag <> seCashierProfileCode.Value) then //���� ������� � ����� ����� � ���� ��� ���� � ��� �� ��� �������, ������� �� �����������
    begin
      YesNoDialog('������� � ����� ����� ��� ����', 1, False);
      Exit
    end
    else
      cpCode := seCashierProfileCode.Value;

    cpName := editCashierProfileName.Text;
    cpSettings := cbCashierProfileSettingsAccess.ItemIndex = 1
  end;

  if seCashierProfileCode.Tag = -1 then
    DM1.AddCashiersProfile(CPR) //��������� ����� ������� � ��
  else
    DM1.UpdateCashiersProfile(CPR, seCashierProfileCode.Tag); //�������� ������������ �������

  CashiersProfilesFill; //������������� �� �������� ����������, ��� ������������ ������� ��������

  sPageControl1.ActivePageIndex := 0
end;

//��������� ������
procedure TframeSettings.btnSaveDiscountClick(Sender: TObject);
var
  DR: TDiscountRecord;
begin
  if editDiscountName.Text = '' then
  begin
    YesNoDialog('�� ������� �������� ������!', 1, False);
    Exit
  end;

  if editDiscountName.Text = '' then
  begin
    YesNoDialog('�������� ������ �� ������ ���� �������!', 1, False);
    Exit
  end;

  with DR do
  begin
    if editDiscountCode.Text = '' then
      discID := 0
    else
      discID := StrToInt(editDiscountCode.Text);
    discName := Trim(editDiscountName.Text);
    discValue := seDiscountValue.Value;
    discPosition := cbDiscountType.ItemIndex = 1;
  end;

  DM1.SaveDiscount(DR); //��������� ������ � ������ � ��

  DiscountsTableFill; //������������� ������� ������

  sPageControl7.ActivePageIndex := 0
end;

//��������� �����
procedure TframeSettings.btnSaveTaxClick(Sender: TObject);
var
  TR: TTaxRecord;
begin
  //��������� ��������� ������ � ������
  with TR do
  begin
    taxID := seTaxID.Value;
    taxValue := editTaxValue.Text;
    taxCode := seTaxCode.Value;
  end;

  DM1.SaveTax(TR); //��������� ����� � ��

  TaxesTableFill; //������������� ������� �������

  sPageControl10.ActivePageIndex := 0
end;

//�������� ������ ��
procedure TframeSettings.btnAddBCTemplateClick(Sender: TObject);
begin
  editBCTemplateCode.Text := '';
  editBCTemplateName.Text := '';
  editBCTemplate.Text := '';
  seBCTemplatePrefix.Value := 0;
  cbBCTemplateElement.ItemIndex := 0;
  seBCTemplateMultiplier.Value := 0.001;
  seBCTemplateNumberOfDigits.Value := 0;

  sPageControl9.ActivePageIndex := 1
end;

// �������� �������
procedure TframeSettings.btnAddCashierClick(Sender: TObject);
begin
  // ������� ����
  editCashierCode.Text           := '';
  editCashierName.Text           := '';
  cbCashierProfile.ItemIndex     := 0;
  editCashierPosition.Text       := '';
  editCashierINN.Text            := '';
  editCashierPass.Text           := '';
  editCashierBC.Text             := '';
  imgCashierPhoto.Picture        := nil;
  imgCashierPhoto.Hint           := '';

  sPageControl11.ActivePageIndex := 1
end;

// �������� �������
procedure TframeSettings.btnEditCashierClick(Sender: TObject);
var
  SelectedItem: TListItem;
  CR: TCashierRecord;
begin
  SelectedItem := lvCashiers.Selected;

  if SelectedItem = nil then
    Exit;

  CR := DM1.GetCashierData(StrToInt(SelectedItem.Caption));

  editCashierCode.Text := SelectedItem.Caption;
  editCashierName.Text := CR.cName;
  cbCashierProfile.ItemIndex := cbCashierProfile.IndexOf(DM1.GetCashierProfileData(CR.cProfile).cpName);
  editCashierPosition.Text := CR.cPosition;
  editCashierINN.Text := CR.cINN;
  editCashierPass.Text := CR.cPassword;
  editCashierBC.Text := CR.cBarcode;
  if FileExists(CR.cPhoto) then
    imgCashierPhoto.Picture.LoadFromFile(CR.cPhoto);
  imgCashierPhoto.Hint := CR.cPhoto;

  sPageControl11.ActivePageIndex := 1
end;

// ������� �������
procedure TframeSettings.btnDeleteCashierClick(Sender: TObject);
var
  SelectedItem: TListItem;
begin
  SelectedItem := lvCashiers.Selected;

  if SelectedItem = nil then
    Exit;

  if not YesNoDialog('�� �������, ��� ������ ������� ����� �������?', 0, False) then
    Exit;

  DM1.DeleteCashier(StrToInt(SelectedItem.Caption));

  SelectedItem.Delete
end;


// �������� ������� �������
procedure TframeSettings.btnAddCashierProfileClick(Sender: TObject);
begin
  // ����� ��������� �������� ����� �����
  seCashierProfileCode.Value               := DM1.GetNextCashiersProfileCode;
  editCashierProfileName.Text              := '';
  cbCashierProfileSettingsAccess.ItemIndex := 1;

  seCashierProfileCode.Tag                 := -1; // ������� ����, ��� ��� ����� �������

  sPageControl1.ActivePageIndex            := 1;
end;

//�������� ������� �������
procedure TframeSettings.btnEditCashierProfileClick(Sender: TObject);
var
  SelectedItem: TListItem;
  CPR: TCashierProfileRecord;
begin
  SelectedItem := lvCashiersProfiles.Selected;

  if SelectedItem = nil then
    Exit;

  CPR := DM1.GetCashierProfileData(StrToInt(SelectedItem.Caption));

  seCashierProfileCode.Value := StrToInt(SelectedItem.Caption);
  editCashierProfileName.Text := CPR.cpName;
  cbCashierProfile.ItemIndex := Integer(CPR.cpSettings);

  seCashierProfileCode.Tag := seCashierProfileCode.Value; //���������� ��� �������������� �������, �.�. �� ���� ����� ���� ��������������

  sPageControl1.ActivePageIndex := 1;
end;

//�������� ������
procedure TframeSettings.btnEditDiscountClick(Sender: TObject);
var
  SelectedItem: TListItem;
  DR: TDiscountRecord;
begin
  SelectedItem := lvDiscounts.Selected;

  if SelectedItem = nil then
    Exit;

  DR := DM1.GetDiscountData(StrToInt(SelectedItem.Caption)); //�������� ������ � ������ �� ��

  with DR do
  begin
    editDiscountCode.Text := SelectedItem.Caption;
    editDiscountName.Text := discName;
    seDiscountValue.Value := discValue;
    cbDiscountType.ItemIndex := Integer(discPosition);
  end;

  sPageControl7.ActivePageIndex := 1
end;

//�������� ������
procedure TframeSettings.btnAddDiscountClick(Sender: TObject);
begin
  //������� ����
  editDiscountCode.Text := '';
  editDiscountName.Text := '';
  seDiscountValue.Value := 0.00;
  cbDiscountType.ItemIndex := 0;

  sPageControl7.ActivePageIndex := 1
end;

//������� ������
procedure TframeSettings.btnDeleteDiscountClick(Sender: TObject);
var
  SelectedItem: TListItem;
begin
  SelectedItem := lvDiscounts.Selected;

  if SelectedItem = nil then
    Exit;

  if not YesNoDialog('�� �������, ��� ������ ������� ��� ������?', 0, False) then
    Exit;

  DM1.DeleteDiscount(StrToInt(SelectedItem.Caption));

  SelectedItem.Delete
end;

//�������� �����
procedure TframeSettings.btnEditTaxClick(Sender: TObject);
var
  SelectedItem: TListItem;
begin
  SelectedItem := lvTaxes.Selected;

  if SelectedItem = nil then
    Exit;

  seTaxID.Value := StrToInt(SelectedItem.Caption);
  editTaxValue.Text := SelectedItem.SubItems[0];
  seTaxCode.Value := StrToInt(SelectedItem.SubItems[1]);

  sPageControl10.ActivePageIndex := 1
end;

//���� ����� � ��
procedure TframeSettings.btnFRConnectionTestClick(Sender: TObject);
var
  frDriver: TFRDriver;
begin
  frDriver := TFRDriver.Create(cbFRModel.ItemIndex, False);

  YesNoDialog(frDriver.Connection(cbFRConnectionChanel.ItemIndex, seFRComPortNumber.Value, StrToInt(cbFRBaudrate.Text), editFRIP.Text, editFRMAC.Text).ErrorText, 1, False);

  frDriver.Free
end;

//�� ��������� ������ ��
procedure TframeSettings.btnCancelBarcodeTemplateClick(Sender: TObject);
begin
  sPageControl9.ActivePageIndex := 0
end;

//�� ��������� �������
procedure TframeSettings.btnCancelCashierClick(Sender: TObject);
begin
  sPageControl11.ActivePageIndex := 0
end;

//�� ��������� ������� �������
procedure TframeSettings.btnCancelCashierProfileClick(Sender: TObject);
begin
  sPageControl1.ActivePageIndex := 0
end;

//�� ��������� ������
procedure TframeSettings.btnCancelDiscountClick(Sender: TObject);
begin
  sPageControl7.ActivePageIndex := 0
end;

//�� ��������� �����
procedure TframeSettings.btnCancelTaxClick(Sender: TObject);
begin
  sPageControl10.ActivePageIndex := 0
end;

//������� ������ ��
procedure TframeSettings.btnDeleteBCTemplateClick(Sender: TObject);
var
  SelectedItem: TListItem;
begin
  SelectedItem := lvBCTemplates.Selected;

  if SelectedItem = nil then
    Exit;

  if not YesNoDialog('�� �������, ��� ������ ������� ���� ������?', 0, False) then
    Exit;

  DM1.DeleteBarcodeTemplate(StrToInt(SelectedItem.Caption));
  lvBCTemplates.DeleteSelected
end;

// ������� ������� ��������
procedure TframeSettings.btnDeleteCashierProfileClick(Sender: TObject);
var
  SelectedItem: TListItem;
begin
  SelectedItem := lvCashiersProfiles.Selected;

  if SelectedItem = nil then
    Exit;

  if not YesNoDialog('�� �������, ��� ������ ������� ���� �������?', 0, False) then
    Exit;

  if DM1.LinksToCashiersProfileExist(StrToInt(SelectedItem.Caption)) then
  begin
    YesNoDialog('������ ������� ���� �������, �.�. �� ������������.', 1, False);
    Exit
  end;

  DM1.DeleteCashiersProfile(StrToInt(SelectedItem.Caption));

  CashiersProfilesFill;
  //lvCashiersProfiles.DeleteSelected
end;

//��������/�������� ������� ������� ��
procedure TframeSettings.btnAddBCTemplateElementClick(Sender: TObject);
var
  keyword, element, digits, multiplier, template: String;
  keywordpos: Integer;
begin
  template := editBCTemplate.Text;
  keyword := cbBCTemplateElement.Text;
  digits := IntToStr(seBCTemplateNumberOfDigits.Value);
  multiplier := FloatToStr(seBCTemplateMultiplier.Value);

  if (keyword = '����������') or (keyword = '����') or (keyword = '�����') then
    element := '[' + keyword + digits + '*' + multiplier + ']'
  else
    element := '[' + keyword + digits + ']';

  keywordpos := Pos(keyword, template);

  if (digits = '0') and (keywordpos > 0) then
    template := StringReplace(template, Copy(template, keywordpos - 1, Pos(']', template, keywordpos) - keywordpos + 2), '', [])
  else
  if digits <> '0' then
  begin
    if keywordpos = 0 then
      template := template + element
    else
      template := StringReplace(template, Copy(template, keywordpos - 1, Pos(']', template, keywordpos) - keywordpos + 2), element, []);
  end;

  editBCTemplate.Text := template
end;

//����� �������� ������� ��
procedure TframeSettings.cbBCTemplateElementChange(Sender: TObject);
begin
  seBCTemplateMultiplier.Enabled := (cbBCTemplateElement.Text = '����������') or (cbBCTemplateElement.Text =  '����') or (cbBCTemplateElement.Text = '�����');
end;

procedure TframeSettings.cbCashierProfileChange(Sender: TObject);
begin

end;

//��� ����� ��������� ������ ����������� ��������� ��-���������
procedure TframeSettings.cbMailServiceChange(Sender: TObject);
begin
  case cbMailService.ItemIndex of
    0: //Gmail
      begin
        editMailLogin.Text := '����_�����@gmail.com';
        editMailSMTP.Text := 'smtp.gmail.com';
        seMailSMTPPort.Value := 465;
        cbMailEncryption.ItemIndex := 0;
      end;
    1: //Mail.ru
      begin
        editMailLogin.Text := '����_�����@mail.ru';
        editMailSMTP.Text := 'smtp.mail.ru';
        seMailSMTPPort.Value := 465;
        cbMailEncryption.ItemIndex := 0;
      end;
    2: //Rambler
      begin
        editMailLogin.Text := '����_�����@rambler.ru';
        editMailSMTP.Text := 'smtp.rambler.ru';
        seMailSMTPPort.Value := 465;
        cbMailEncryption.ItemIndex := 0;
      end;
    3: //Yandex
      begin
        editMailLogin.Text := '';
        editMailSMTP.Text := 'smtp.yandex.ru';
        seMailSMTPPort.Value := 465;
        cbMailEncryption.ItemIndex := 0;
      end;
  end;
end;

//�������� ���������� ��� �������
procedure TframeSettings.imgCashierPhotoClick(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
  begin
    imgCashierPhoto.Picture.LoadFromFile(OpenPictureDialog1.FileName);
    imgCashierPhoto.Hint := OpenPictureDialog1.FileName //���������� � hint ���� � ����� ��� ������������ ���������� � ��
  end;

end;

//������ ���������� �������
procedure TframeSettings.btnCashierPhotoDeleteClick(Sender: TObject);
begin
  imgCashierPhoto.Picture := nil;
  imgCashierPhoto.Hint := ''
end;

//������� ������� ��� ������� ��
procedure TframeSettings.btnSelectDBBackupDirectoryClick(Sender: TObject);
var
  path: String;
begin
  path := SelectDirectoryDlg(editDBBackupDirectory.Text);
  if path <> '' then
    editDBBackupDirectory.Text := path
end;

//������� ������� ��� ������ �������
procedure TframeSettings.btnSelectExchangeDirectoryClick(Sender: TObject);
var
  path: String;
begin
  path := SelectDirectoryDlg(editExchangeDirectory.Text);
  if path <> '' then
    editExchangeDirectory.Text := path
end;

//������� ������� ����������
procedure TframeSettings.btnSelectExternalAppClick(Sender: TObject);
var
  path: String;
begin
  path := SelectFileDlg(editExternalApp.Text);
  if path <> '' then
    editExternalApp.Text := path
end;

//������� ������� �� ��� ����������� ���������
procedure TframeSettings.btnSelectBankDBDirectoryClick(Sender: TObject);
var
  path: String;
begin
  path := SelectDirectoryDlg(editBankDBDirectory.Text);
  if path <> '' then
    editBankDBDirectory.Text := path
end;

//������� ������� ������ ��� ����������� ���������
procedure TframeSettings.btnSelectBankExchangeDirectoryClick(
  Sender: TObject);
var
  path: String;
begin
  path := SelectDirectoryDlg(editBankExchangeDirectory.Text);
  if path <> '' then
    editBankExchangeDirectory.Text := path
end;

// ��������� ����� ���������
procedure TframeSettings.SaveCommonSettingsClick(Sender: TObject);
var
  CSR: TCommonSettingsRecord;
begin
  with CSR do
    begin
      // ��
      backupPath       := editDBBackupDirectory.Text;
      backupNumber     := seDBBackupNumber.Value;
      delDocsAfterDays := seDocAutoDeleteDays.Value;

      // ����� �������
      exchangeFormat         := cbExchangeFormat.ItemIndex;
      exchangePath           := editExchangeDirectory.Text;
      exchangeDLFile         := editExchangeDLFile.Text;
      exchangeULFile         := editExchangeDLFileF.Text;
      exchangeDLFileF        := editExchangeULFile.Text;
      exchangeULFileF        := editExchangeULFileF.Text;
      exchangeULCloseSession := cbAutoULReport.ItemIndex = 1;

      // ��� � ��
      fnBufferAlert := seFNBufferAlert.Value;
      fnEndAlert    := seFNEndAlert.Value;
      fnAlertEmail  := editFNAlertEmail.Text;

      // ����������
      roundMethod    := cbRoundMethod.ItemIndex;
      roundPrecision := seRoundPrecision.Value;
      roundMin       := seRoundMin.Value;

      // �����
      externalApp    := editExternalApp.Text;
      zReportEmail   := editZReportEmail.Text;
      blockYesButton := seYesButtonDisableTime.Value;

      // ���������� � ��������
      companyName    := editCompanyName.Text;
      shopName       := editShopName.Text;
      companyAddress := editCompanyAddress.Text;
      shopAddress    := editShopAddress.Text;
      companyINN     := editCompanyINN.Text;
      companyPhone   := editCompanyPhone.Text;
      companyEmail   := editCompanyEmail.Text;
      companyWeb     := editCompanyWeb.Text;
    end;

  DM1.SaveCommonSettings(CSR);
end;


end.
