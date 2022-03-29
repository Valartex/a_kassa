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

//загрузить данные в программу (товары и т.п.)
procedure TframeService.btnLoadDataClick(Sender: TObject);
var
  CSR: TCommonSettingsRecord;
  success: Boolean;
begin
  CSR := DM1.GetCommonSettings;
  success := False;

  if CSR.exchangeFormat = 0 then // Атол
    success := ExchangeProcessDialog(atolDownload, CSR.exchangePath + CSR.exchangeDLFile);
//    success := AtolExchangeUnit.Download(CSR.exchangePath + CSR.exchangeDLFile);

  if success then
    SendMessage(Application.MainFormHandle, WM_USER + 1, 0, 0) // оповещаем главную форму об изменениях, а она уже вызовет функцию обновления списка товаров
  else
    YesNoDialog('Не удалось загрузить файл с данными! Возможно он не найден по заданному пути, имеет неверный формат или был загружен ранее.', 1, False);

  SendMessage(Application.MainFormHandle, WM_USER + 2, 0, 0); // обнуляем ProgressBar на главной форме
end;

//запустить внешнее приложение
procedure TframeService.btnExternalAppClick(Sender: TObject);
var
  CSR: TCommonSettingsRecord;
begin
  CSR := DM1.GetCommonSettings;

  ShellExecute(Application.Handle, 'open', PWideChar(CSR.externalApp), nil, nil, SW_SHOWNORMAL)
end;

//закрыть программу
procedure TframeService.btnCloseProgramClick(Sender: TObject);
begin
  if YesNoDialog('Вы уверены, что хотите закрыть программу?', 0, True) then
  begin
    Application.MainForm.Close //или Application.Terminate
  end;
end;

// закрыть смену
procedure TframeService.btnCloseSessionClick(Sender: TObject);
var
  commonSettings   : TCommonSettingsRecord;
  nonVisualSettings: TNonVisualSettingsRecord;
  Cashier          : TCashierRecord;
  FNRemain         : TDateTime;
begin
  if not YesNoDialog('Подтверждаете закрытие смены?', 0, False) then
    Exit;

  commonSettings    := DM1.GetCommonSettings;
  nonVisualSettings := DM1.GetNonVisualSettings;

  // снимаем Z-отчёт, если подключен ФР
  if not frDriver.IsSessionClosed then
    begin
      Cashier := DM1.GetCashierData(nonVisualSettings.lastCashier); // получаем данные текущего кассира
      frDriver.CloseSession(Cashier.cName, Cashier.cINN);

      // открываем ДЯ
      if DM1.GetDrawerSettings.status and DM1.GetDrawerSettings.autoOpen then
        frDriver.OpenDrawer;
    end
  else
    YesNoDialog('В фискальном регистраторе смена уже закрыта.', 1, False);

  // предупреждаем, если нужно, о сроке окнчания ФН
  FNRemain := frDriver.GetFNRemain;
  if Now - FNRemain <= commonSettings.fnEndAlert then
    YesNoDialog('Дата завершения работы фискального накопителя: ' + DateTimeToStr(FNRemain), 1, False);


  // если программная смена открыта, то закрываем её и увеличиваем счётчик смен в БД
  if nonVisualSettings.sessionIsOpen then
    begin
      nonVisualSettings.sessionIsOpen := False;
      Inc(nonVisualSettings.sessionNumber);
      DM1.SaveNonVisualSetting(nonVisualSettings);
//      DM1.SessionNuberGen;
    end
  else
    YesNoDialog('В программе смена уже закрыта.', 1, False);

  // делаем бэкап БД
  DM1.BackupDB;

  // удаляем из БД старые документы
  if commonSettings.delDocsAfterDays > 0 then
    DM1.DeleteReceipts(commonSettings.delDocsAfterDays);
end;

//выключить компьютер
procedure TframeService.btnPowerOffClick(Sender: TObject);
var
  hToken: THandle;
  tkp: TTokenPrivileges;
  ReturnLength: Cardinal;
begin
  if YesNoDialog('Вы уверены, что хотите выключить компьютер?', 0, True) then
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

//синхронизировать время ФР с ПК
procedure TframeService.btnSynchroTimeClick(Sender: TObject);
var
  Error: TFRError;
  Cashier: TCashierRecord;
begin
  Cashier := DM1.GetCashierData(DM1.GetNonVisualSettings.lastCashier); //получаем данные текущего кассира

  if not frDriver.IsSessionClosed then
  begin
    if YesNoDialog('Смена открыта. Для установки даты\времени в ФР её нужно закрыть. Сделать это?', 0, False) then
      frDriver.CloseSession(Cashier.cName, Cashier.cINN)
    else
      Exit
  end;

  Error := frDriver.SetDateTime;

  if Error.ErrorCode <> 0 then
    YesNoDialog(Error.ErrorText, 1, False)
  else
    YesNoDialog('Время успешно синхронизировано: ' + DateTimeToStr(frDriver.GetDateTime), 1, False)
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
    YesNoDialog('Фискальный регистратор: ' + FRError.ErrorText, 1, False);
end;

procedure TframeService.FrameExit(Sender: TObject);
begin
  frDriver.Destroy
end;

end.
