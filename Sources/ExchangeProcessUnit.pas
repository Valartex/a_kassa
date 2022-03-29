unit ExchangeProcessUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, sSkinProvider, Vcl.StdCtrls,
  sButton, sLabel, Vcl.ExtCtrls, sPanel;

type
  TExchangeThread = class(TThread)
  protected
    procedure Execute; override;
  end;

  TformExchangeProcess = class(TForm)
    sPanel1: TsPanel;
    labelMessage: TsLabel;
    labelMark: TsLabel;
    sSkinProvider1: TsSkinProvider;
    timerInit: TTimer;
    procedure timerInitTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    ExchangeThread: TExchangeThread;
    canCloseDialog: Boolean;
  public
    { Public declarations }
    exchangeType  : Integer;
    exchangePath  : String;
    exchangeResult: Boolean;
  end;

var
  formExchangeProcess: TformExchangeProcess;

implementation

{$R *.dfm}

uses AtolExchangeUnit, CommonUnit;

{ TExchangeThread }

procedure TformExchangeProcess.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := canCloseDialog
end;

procedure TformExchangeProcess.FormCreate(Sender: TObject);
begin
  canCloseDialog := False;
  if exchangeType = atolDownload then
    labelMessage.Caption := 'Загрузка товаров...'
end;

procedure TformExchangeProcess.FormShow(Sender: TObject);
begin
  ScaleWindow(formExchangeProcess, 100); // масштабируем окно под текущее разрешение
end;

procedure TExchangeThread.Execute;
begin
  inherited;

  with formExchangeProcess do
    case exchangeType of
      atolDownload:
        exchangeResult := AtolExchangeUnit.Download(exchangePath);
    end;

  formExchangeProcess.canCloseDialog := True;
  formExchangeProcess.Close
end;

procedure TformExchangeProcess.timerInitTimer(Sender: TObject);
begin
  timerInit.Enabled := False;

  ExchangeThread                 := TExchangeThread.Create(False);
  ExchangeThread.FreeOnTerminate := True;
end;

end.
