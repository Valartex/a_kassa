program a_kassa;

uses
  Vcl.Forms,
  MainUnit in 'MainUnit.pas' {formMain},
  YesNoUnit in 'YesNoUnit.pas' {formYesNo},
  DBUnit in 'DBUnit.pas' {DM1: TDataModule},
  CommonUnit in 'CommonUnit.pas',
  TradeUnit_i in 'TradeUnit_i.pas' {frameTrade: TFrame},
  GoodsBaseUnit_i in 'GoodsBaseUnit_i.pas' {frameGoodsBase: TFrame},
  LabelsUnit_i in 'LabelsUnit_i.pas' {frameLabels: TFrame},
  ServiceUnit_i in 'ServiceUnit_i.pas' {frameService: TFrame},
  SettingsUnit_i in 'SettingsUnit_i.pas' {frameSettings: TFrame},
  AtolExchangeUnit in 'AtolExchangeUnit.pas',
  SelectParentUnit in 'SelectParentUnit.pas' {formSelectParent},
  SelectDirectoryUnit in 'SelectDirectoryUnit.pas' {formSelectDirectory},
  SelectFileUnit in 'SelectFileUnit.pas' {formSelectFile},
  GoodsTableUnit in 'GoodsTableUnit.pas' {frameGoodsTable: TFrame},
  FRDriverUnit in 'FRDriverUnit.pas',
  ReportsUnit in 'ReportsUnit.pas' {frameReports: TFrame},
  SelectCashierUnit in 'SelectCashierUnit.pas' {formSelectCashier},
  GoodsSearchResultUnit in 'GoodsSearchResultUnit.pas' {formGoodsSearchResult},
  GoodsVisualSearchUnit in 'GoodsVisualSearchUnit.pas' {formGoodsVisualSearch},
  SelectCheqTypeUnit in 'SelectCheqTypeUnit.pas' {formSelectCheqType},
  DocumentsUnit in 'DocumentsUnit.pas' {formDocuments},
  CorrectionInfoUnit in 'CorrectionInfoUnit.pas' {formCorrectionInfo},
  BCScanerUnit in 'BCScanerUnit.pas',
  AboutUnit in 'AboutUnit.pas' {frameAbout: TFrame},
  ScanMarkUnit in 'ScanMarkUnit.pas' {formScanMark},
  DelMarkUnit in 'DelMarkUnit.pas' {formDelMark},
  ExchangeProcessUnit in 'ExchangeProcessUnit.pas' {formExchangeProcess},
  MarkingUnit in 'MarkingUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM1, DM1);
  Application.CreateForm(TformMain, formMain);
  Application.CreateForm(TformExchangeProcess, formExchangeProcess);
  Application.Run;
end.
