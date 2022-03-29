unit DelMarkUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sButton, sLabel, System.Types,
  Vcl.ExtCtrls, sPanel, sSkinProvider, CommonUnit;

type
  TformDelMark = class(TForm)
    sSkinProvider1: TsSkinProvider;
    sPanel1: TsPanel;
    labelMessage: TsLabel;
    labelMark: TsLabel;
    Panel1: TsPanel;
    btnCancel: TsButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure BCScanerDataEvent(var scanerDataMessage: TScanerDataMessage); message WM_ScanerData;
  public
    { Public declarations }
    arrayOfMarks: TStringDynArray;
    markIndex, markType: Integer;
  end;

var
  formDelMark: TformDelMark;

implementation

{$R *.dfm}

uses DBUnit, MarkingUnit;

procedure TformDelMark.FormCreate(Sender: TObject);
begin
  markIndex := -1
end;

procedure TformDelMark.FormShow(Sender: TObject);
begin
  ScaleWindow(formDelMark, 100); // масштабируем окно под текущее разрешение
end;

// обработка считанного ШК
procedure TformDelMark.BCScanerDataEvent(var scanerDataMessage: TScanerDataMessage);
var
  i: Integer;
  mark: String;
begin
  mark := scanerDataMessage.LParam;

  labelMark.Caption := mark;

  mark := Get1162(mark, markType);

  if mark = '' then
    begin
      labelMessage.Caption := 'Считанный штрихкод не похож на маркировку для данного типа товара. Попробуйте ещё раз.';
      mark := '';
      Exit
    end;

  for i := 0 to Length(arrayOfMarks) - 1 do
    if arrayOfMarks[i] = mark then
      begin
        markIndex := i;
        Close
      end;

  labelMessage.Caption := 'Такой марки нет в чеке.'
end;

end.
