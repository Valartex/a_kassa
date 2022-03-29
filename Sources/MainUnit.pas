unit MainUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, sSkinManager, Vcl.ComCtrls, sPageControl,
  sListView, Vcl.ExtCtrls, Vcl.StdCtrls, sButton, sEdit, Vcl.Buttons,
  sSpeedButton, sPanel, sLabel, sComboBox, Vcl.Menus, Vcl.Mask, sMaskEdit,
  sCustomComboEdit, sComboEdit, frxClass, frxPreview, frxBarcode,
  System.ImageList, Vcl.ImgList, acAlphaImageList, sComboBoxes, acImage,
  sCheckBox, sSpinEdit, sCurrEdit, sToolEdit, CommCtrl, sTreeView,
  TradeUnit_i, GoodsBaseUnit_i, LabelsUnit_i, ServiceUnit_i,
  SettingsUnit_i, Vcl.AppEvnts, sSkinProvider, acProgressBar, sBevel,
  sGroupBox, ReportsUnit, AboutUnit, Scaner_TLB, CommonUnit;

type

//  TsPageControl = class(sPageControl.TsPageControl) // Убирает отступы в sPageControl
//  private
//    procedure TCMAdjustRect(var Msg: TMessage); message TCM_ADJUSTRECT;
//  end;

  TScanThread = class(TThread)
  protected
    procedure Execute; override;
  end;

  TformMain = class(TForm)
    sPageControl1: TsPageControl;
    sTabSheet1: TsTabSheet;
    sTabSheet2: TsTabSheet;
    sTabSheet3: TsTabSheet;
    SkinManager1: TsSkinManager;
    sPanel3: TsPanel;
    Timer1: TTimer;
    DateTimeLabel: TsLabel;
    sTabSheet4: TsTabSheet;
    sTabSheet5: TsTabSheet;
    frameGoodsBase1: TframeGoodsBase;
    ApplicationEvents1: TApplicationEvents;
    btnLang: TsSpeedButton;
    sSkinProvider1: TsSkinProvider;
    ProgressBar1: TsProgressBar;
    btnAppVersion: TsSpeedButton;
    btnCashier: TsSpeedButton;
    sBevel1: TsBevel;
    sBevel2: TsBevel;
    sBevel3: TsBevel;
    sBevel4: TsBevel;
    sTabSheet6: TsTabSheet;
    frameReports1: TframeReports;
    frameSettings1: TframeSettings;
    frameService1: TframeService;
    sTabSheet7: TsTabSheet;
    frameAbout1: TframeAbout;
    frameLabels1: TframeLabels;
    frameTrade1: TframeTrade;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ApplicationEvents1Message(var Msg: tagMSG;
      var Handled: Boolean);
    procedure btnLangClick(Sender: TObject);
    procedure btnCashierClick(Sender: TObject);
  private
    { Private declarations }
    bcScaner: TScaner45;
    scanThread: TScanThread;
    procedure BCScanerDataEvent(Sender: TObject);
    procedure UpdGoodsList(var Msg: TMessage); message WM_USER + 1; // обновление списка товаров при загрузке из файла
    procedure UpdProgressBar(var Msg: TMessage); message WM_USER + 2; // обновление ProgressBar
    procedure SetProgressBarMax(var Msg: TMessage); message WM_USER + 3; // установка максимального значения для ProgressBar
    procedure ConnectScaner(var Msg: TMessage); message WM_ConnectScaner;
  public
    { Public declarations }
  end;

var
  formMain: TformMain;

implementation

{$R *.dfm}

uses DBUnit, SelectCashierUnit, BCScanerUnit;

//убираем отступы в PageControl
//procedure TsPageControl.TCMAdjustRect(var Msg: TMessage);
//begin
  //способ 1
//  if self.TabPosition = tpTop then
//  begin
//    PRect(Msg.LParam)^.Left := 0;
//    PRect(Msg.LParam)^.Right := self.ClientWidth;
//    Dec(PRect(Msg.LParam)^.Top, 4);
//    PRect(Msg.LParam)^.Bottom := self.ClientHeight;
//  end
//  else
//    inherited;

  //способ 2 (не убирает отступ сверху)
//  inherited;
//  if Msg.WParam = 0 then
//    InflateRect(PRect(Msg.LParam)^, 4, 4)
//  else
//    InflateRect(PRect(Msg.LParam)^, -4, -4);
//end;

procedure TformMain.FormCreate(Sender: TObject);
const
  BaseScreenWidth : Integer = 1024;
  BaseScreenHeight: Integer = 600;
var
  i, j: Integer;
  scanerSettings: TScanerSettingsRecord;
begin
  ScaleWindow(formMain, 0); // масштабируем окно под текущее разрешение

  // корректируем высоту кнопок выбора рядом с полями ввода (они почему-то получаются выше, чем поля)
  for i := 0 to ComponentCount - 1 do
    if Components[i] is TFrame then
      for j := 0 to (Components[i] as TFrame).ComponentCount - 1 do
        if (Components[i] as TFrame).Components[j] is TsSpeedButton then
          if ((Components[i] as TFrame).Components[j] as TsSpeedButton).Tag = 1 then
            ((Components[i] as TFrame).Components[j] as TsSpeedButton).Height := ((Components[i] as TFrame).Components[j] as TsSpeedButton).Height - 7;

  btnLang.Caption := AbbrByLocale(LoWord(GetKeyboardLayout(0))); // текущий язык ввода

  btnCashierClick(Sender); // выбрать кассира

  formMain.ActiveControl := frameTrade1.editMain;

  // подключение сканера ШК

  scanerSettings := DM1.GetScanerSettings;

  if scanerSettings.sStatus then
    begin
      bcScaner := TScaner45.Create(nil);
      bcScaner.OnDataEvent := BCScanerDataEvent;

      BCSConnection(bcScaner, scanerSettings.sChanel, scanerSettings.sPort, scanerSettings.sSpeed, scanerSettings.sPrefix, scanerSettings.sSufix);
    end;
end;

// обработка считанного ШК
procedure TformMain.BCScanerDataEvent(Sender: TObject);
begin
  // Отдельный поток нужен для того чтобы "развязать" сканирования, например, при последовательном считывании ШК и марки. Иначе получается, что одна процедура сканирования
  // ещё не завершилась, а уже начинается другая. В результате драйвер сканера не обрабатывает запросы.
  scanThread                 := TScanThread.Create(False);
  scanThread.FreeOnTerminate := True;
end;

procedure TScanThread.Execute;
var
  i, j: Integer;
begin
  inherited;

  for i := 0 to Screen.FormCount - 1 do
    with Screen.Forms[i] do
      if Active then
        begin
          if Screen.Forms[i] <> Application.MainForm then
            SendTextMessage(Handle, WM_ScanerData, 0, formMain.bcScaner.ScanData)
          else
            for j := 0 to ComponentCount - 1 do
              if Components[j] is TFrame then
                // пропускаем не видимые в данный момент фреймы
                if (Components[j] as TFrame).CanFocus then // либо IsWindowVisible(control.Handle)
                  begin
                    SendTextMessage((Components[j] as TFrame).Handle, WM_ScanerData, 0, formMain.bcScaner.ScanData);
                    Break
                  end;
        end;
end;

// переподключение сканера ШК
procedure TformMain.ConnectScaner(var Msg: TMessage);
var
  scanerSettings: TScanerSettingsRecord;
begin
  scanerSettings := DM1.GetScanerSettings;

  try
    bcScaner.Free
  except
  end;

  bcScaner := TScaner45.Create(nil);
  bcScaner.OnDataEvent := BCScanerDataEvent;

  BCSConnection(bcScaner, scanerSettings.sChanel, scanerSettings.sPort, scanerSettings.sSpeed, scanerSettings.sPrefix, scanerSettings.sSufix);
end;

//обновление списка товаров при загрузке данных из файла
procedure TformMain.UpdGoodsList(var Msg: TMessage);
begin
  frameGoodsBase1.frameGoodsTable1.UpdateGoodsList;
  frameLabels1.frameGoodsTable1.UpdateGoodsList;
  inherited
end;

// установка максимального значения для ProgressBar
procedure TformMain.SetProgressBarMax(var Msg: TMessage);
begin
  ProgressBar1.Max := Msg.WParam;
  inherited
end;

//обновление ProgressBar
procedure TformMain.UpdProgressBar(var Msg: TMessage);
begin
  if Msg.WParam = 0 then // если пришел сигнал о завершении операции
    ProgressBar1.Position := 0
  else
    ProgressBar1.Position := ProgressBar1.Position + 1;
  inherited
end;

procedure TformMain.ApplicationEvents1Message(var Msg: tagMSG;
  var Handled: Boolean);
begin
  // перехватываем событие переключения языка ввода
  if Msg.message = CM_INPUTLANGCHANGE then
    btnLang.Caption := AbbrByLocale(LoWord(GetKeyboardLayout(0)));
end;

// сменить кассира
procedure TformMain.btnCashierClick(Sender: TObject);
var
  NVSR: TNonVisualSettingsRecord;
begin
  if Length(DM1.GetCashires) < 1 then //
    begin
      YesNoDialog('Не найдено ни одного пользователя! Для их создания перейдите в Настройки -> Справочники -> Кассиры.', 1, False);
      Exit;
    end;

  formSelectCashier := TformSelectCashier.Create(Self);

  formSelectCashier.ShowModal;

  btnCashier.Tag     := formSelectCashier.Tag;                    // запоминаем код выбранного кассира
  btnCashier.Caption := DM1.GetCashierData(btnCashier.Tag).cName; // отображаем на кнопке имя выбранного кассира

  formSelectCashier.Free;

  NVSR             := DM1.GetNonVisualSettings;
  NVSR.lastCashier := btnCashier.Tag;                             // записываем в БД код последнего кассира

  DM1.SaveNonVisualSetting(NVSR);
end;

// переключаем язык ввода
procedure TformMain.btnLangClick(Sender: TObject);
begin
  ActivateKeyboardLayout(1, 0)
end;

// отображение времени
procedure TformMain.Timer1Timer(Sender: TObject);
begin
  DateTimeLabel.Caption := DateTimeToStr(Now);
end;

end.
