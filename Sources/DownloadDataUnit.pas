unit DownloadDataUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, sSkinProvider, Vcl.ComCtrls,
  acProgressBar, Vcl.ExtCtrls, Vcl.StdCtrls, sLabel;

type
  TformDownloadData = class(TForm)
    sSkinProvider1: TsSkinProvider;
    ProgressBar1: TsProgressBar;
    timerInit: TTimer;
    sLabel1: TsLabel;
    procedure FormCreate(Sender: TObject);
    procedure timerInitTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formDownloadData: TformDownloadData;

implementation

{$R *.dfm}

uses DBUnit, AtolExchangeUnit, CommonUnit;

{ TformProgress }

procedure TformDownloadData.FormCreate(Sender: TObject);
var
  BaseHeight, ScreenWidth: Integer;
  M: Real;
begin
  BaseHeight := Height;

  ScreenWidth := Screen.Width - 100; // -100 потому что окно диалога должно быть на 100 меньше основного окна (для красоты)

  M := ScreenWidth / Width; //узнаём коэффициент масштабирования интерфейса

  ScaleBy(ScreenWidth, Width);
  Height := Round(BaseHeight * M);
end;

procedure TformDownloadData.timerInitTimer(Sender: TObject);
var
  CSR: TCommonSettingsRecord;
  success: Boolean;
begin
  timerInit.Enabled := False;

  CSR := DM1.GetCommonSettings;
  success := False;

  if CSR.ExchangeFormat = 0 then //Атол
    success := AtolExchangeUnit.Download(CSR.ExchangePath + CSR.ExchangeDLFile);

  if success then
  begin
    SendMessage(Application.MainFormHandle, WM_USER + 1, 0, 0); //оповещаем главную форму об изменениях, а она уже вызовет функцию обновления списка товаров
    Close
  end
  else
  begin
    YesNoDialog('Не удалось загрузить файл с данными! Возможно он не найден по заданному пути или имеет неверный формат.', 1, False);
    Close
  end;

end;

end.
