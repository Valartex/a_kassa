unit ScanMarkUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, sSkinProvider, Vcl.StdCtrls, System.Types,
  sButton, sLabel, Vcl.ExtCtrls, sPanel, CommonUnit;

type
  TformScanMark = class(TForm)
    sPanel1: TsPanel;
    labelMessage: TsLabel;
    Panel1: TsPanel;
    btnCancel: TsButton;
    sSkinProvider1: TsSkinProvider;
    labelMark: TsLabel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure BCScanerDataEvent(var scanerDataMessage: TScanerDataMessage); message WM_ScanerData;
  public
    { Public declarations }
    arrayOfMarks: TStringDynArray;
    markType    : Integer;
    mark        : String;
  end;

var
  formScanMark: TformScanMark;

implementation

{$R *.dfm}

uses DBUnit, MarkingUnit;

procedure TformScanMark.FormShow(Sender: TObject);
begin
  ScaleWindow(formScanMark, 100); // масштабируем окно под текущее разрешение
end;

// обработка считанного ШК
procedure TformScanMark.BCScanerDataEvent(var scanerDataMessage: TScanerDataMessage);
var
  i: Integer;
begin
  mark := scanerDataMessage.LParam;

  labelMark.Caption := mark;

  mark := Get1162(mark, markType);

  if mark = '' then
    begin
      labelMessage.Caption := 'Считанный штрихкод не похож на маркировку для данного типа товара. Попробуйте ещё раз.';
      Exit
    end;

  for i := 0 to Length(arrayOfMarks) - 1 do
    if arrayOfMarks[i] = mark then
      begin
        labelMessage.Caption := 'Такая марка уже есть в чеке.';
        mark := '';
        Exit
      end;

  Close
end;

end.
