unit ReportsUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ComCtrls, sComboBoxes, sPageControl, Vcl.Buttons, sSpeedButton;

type
  TframeReports = class(TFrame)
    sPageControl2: TsPageControl;
    sTabSheet7: TsTabSheet;
    sTabSheet8: TsTabSheet;
    btnXReport: TsSpeedButton;
    FileOpenDialog1: TFileOpenDialog;
    procedure btnXReportClick(Sender: TObject);
    procedure FrameEnter(Sender: TObject);
    procedure FrameExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses FRDriverUnit, DBUnit, CommonUnit;

procedure TframeReports.FrameEnter(Sender: TObject);
var
  frSettings: TFRSettingsRecord;
  FRError: TFRError;
begin
  frSettings := DM1.GetFRSetting;

  frDriver := TFRDriver.Create(frSettings.frModel, not frSettings.frStatus);

  FRError := frDriver.Connection(frSettings.frChanel, frSettings.frPort, frSettings.frSpeed, frSettings.frIP, frSettings.frMAC);
  if FRError.ErrorCode <> 0 then
    YesNoDialog('Фискальный регистратор: ' + FRError.ErrorText, 1, False);
end;

procedure TframeReports.FrameExit(Sender: TObject);
begin
  frDriver.Destroy
end;

//X-отчёт
procedure TframeReports.btnXReportClick(Sender: TObject);
begin
  frDriver.XReport;
end;

end.
