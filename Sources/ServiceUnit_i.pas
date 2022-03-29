unit ServiceUnit_i;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, sSpeedButton,
  Winapi.ShellAPI, System.IniFiles;

type
  TframeService = class(TFrame)
    btnLoadLPScale: TsSpeedButton;
    btnExternalApp: TsSpeedButton;
    btnCloseProgram: TsSpeedButton;
    btnPowerOff: TsSpeedButton;
    btnUploadReport: TsSpeedButton;
    btnLoadData: TsSpeedButton;
    btnSynchroTime: TsSpeedButton;
    btnCloseSession: TsSpeedButton;
    procedure btnPowerOffClick(Sender: TObject);
    procedure btnCloseProgramClick(Sender: TObject);
    procedure btnLoadDataClick(Sender: TObject);
    procedure btnExternalAppClick(Sender: TObject);
    procedure btnSynchroTimeClick(Sender: TObject);
    procedure FrameEnter(Sender: TObject);
    procedure FrameExit(Sender: TObject);
    procedure btnCloseSessionClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses CommonUnit, AtolExchangeUnit, DBUnit, FRDriverUnit;

//��������� ������ � ��������� (������ � �.�.)
procedure TframeService.btnLoadDataClick(Sender: TObject);
var
  CSR: TCommonSettingsRecord;
  success: Boolean;
begin
  CSR := DM1.GetCommonSettings;
  success := False;

  if CSR.exchangeFormat = 0 then // ����
    success := ExchangeProcessDialog(atolDownload, CSR.exchangePath + CSR.exchangeDLFile);
//    success := AtolExchangeUnit.Download(CSR.exchangePath + CSR.exchangeDLFile);

  if success then
    SendMessage(Application.MainFormHandle, WM_USER + 1, 0, 0) // ��������� ������� ����� �� ����������, � ��� ��� ������� ������� ���������� ������ �������
  else
    YesNoDialog('�� ������� ��������� ���� � �������! �������� �� �� ������ �� ��������� ����, ����� �������� ������ ��� ��� �������� �����.', 1, False);

  SendMessage(Application.MainFormHandle, WM_USER + 2, 0, 0); // �������� ProgressBar �� ������� �����
end;

//��������� ������� ����������
procedure TframeService.btnExternalAppClick(Sender: TObject);
var
  CSR: TCommonSettingsRecord;
begin
  CSR := DM1.GetCommonSettings;

  ShellExecute(Application.Handle, 'open', PWideChar(CSR.externalApp), nil, nil, SW_SHOWNORMAL)
end;

//������� ���������
procedure TframeService.btnCloseProgramClick(Sender: TObject);
begin
  if YesNoDialog('�� �������, ��� ������ ������� ���������?', 0, True) then
  begin
    Application.MainForm.Close //��� Application.Terminate
  end;
end;

// ������� �����
procedure TframeService.btnCloseSessionClick(Sender: TObject);
var
  commonSettings   : TCommonSettingsRecord;
  nonVisualSettings: TNonVisualSettingsRecord;
  Cashier          : TCashierRecord;
  FNRemain         : TDateTime;
begin
  if not YesNoDialog('������������� �������� �����?', 0, False) then
    Exit;

  commonSettings    := DM1.GetCommonSettings;
  nonVisualSettings := DM1.GetNonVisualSettings;

  // ������� Z-�����, ���� ��������� ��
  if not frDriver.IsSessionClosed then
    begin
      Cashier := DM1.GetCashierData(nonVisualSettings.lastCashier); // �������� ������ �������� �������
      frDriver.CloseSession(Cashier.cName, Cashier.cINN);

      // ��������� ��
      if DM1.GetDrawerSettings.status and DM1.GetDrawerSettings.autoOpen then
        frDriver.OpenDrawer;
    end
  else
    YesNoDialog('� ���������� ������������ ����� ��� �������.', 1, False);

  // �������������, ���� �����, � ����� �������� ��
  FNRemain := frDriver.GetFNRemain;
  if Now - FNRemain <= commonSettings.fnEndAlert then
    YesNoDialog('���� ���������� ������ ����������� ����������: ' + DateTimeToStr(FNRemain), 1, False);


  // ���� ����������� ����� �������, �� ��������� � � ����������� ������� ���� � ��
  if nonVisualSettings.sessionIsOpen then
    begin
      nonVisualSettings.sessionIsOpen := False;
      Inc(nonVisualSettings.sessionNumber);
      DM1.SaveNonVisualSetting(nonVisualSettings);
//      DM1.SessionNuberGen;
    end
  else
    YesNoDialog('� ��������� ����� ��� �������.', 1, False);

  // ������ ����� ��
  DM1.BackupDB;

  // ������� �� �� ������ ���������
  if commonSettings.delDocsAfterDays > 0 then
    DM1.DeleteReceipts(commonSettings.delDocsAfterDays);
end;

//��������� ���������
procedure TframeService.btnPowerOffClick(Sender: TObject);
var
  hToken: THandle;
  tkp: TTokenPrivileges;
  ReturnLength: Cardinal;
begin
  if YesNoDialog('�� �������, ��� ������ ��������� ���������?', 0, True) then
  begin
    if not ExitWindowsEx(EWX_Force or EWX_PowerOff or EWX_ShutDown, 0) then
      if OpenProcessToken(GetCurrentProcess, TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY, hToken) then
      begin
        LookupPrivilegeValue(nil, 'SeShutdownPrivilege', tkp.Privileges[0].Luid);
        tkp.PrivilegeCount := 1;
        tkp.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
        if AdjustTokenPrivileges(hToken, False, tkp, 0, nil, ReturnLength) then
          ExitWindowsEx(EWX_SHUTDOWN or EWX_POWEROFF, 0);
      end;
  end;
end;

//���������������� ����� �� � ��
procedure TframeService.btnSynchroTimeClick(Sender: TObject);
var
  Error: TFRError;
  Cashier: TCashierRecord;
begin
  Cashier := DM1.GetCashierData(DM1.GetNonVisualSettings.lastCashier); //�������� ������ �������� �������

  if not frDriver.IsSessionClosed then
  begin
    if YesNoDialog('����� �������. ��� ��������� ����\������� � �� � ����� �������. ������� ���?', 0, False) then
      frDriver.CloseSession(Cashier.cName, Cashier.cINN)
    else
      Exit
  end;

  Error := frDriver.SetDateTime;

  if Error.ErrorCode <> 0 then
    YesNoDialog(Error.ErrorText, 1, False)
  else
    YesNoDialog('����� ������� ����������������: ' + DateTimeToStr(frDriver.GetDateTime), 1, False)
end;

procedure TframeService.FrameEnter(Sender: TObject);
var
  frSettings: TFRSettingsRecord;
  FRError: TFRError;
begin
  frSettings := DM1.GetFRSetting;

  frDriver := TfrDriver.Create(frSettings.frModel, not frSettings.frStatus);

  FRError := frDriver.Connection(frSettings.frChanel, frSettings.frPort, frSettings.frSpeed, frSettings.frIP, frSettings.frMAC);
  if FRError.ErrorCode <> 0 then
    YesNoDialog('���������� �����������: ' + FRError.ErrorText, 1, False);
end;

procedure TframeService.FrameExit(Sender: TObject);
begin
  frDriver.Destroy
end;

end.
