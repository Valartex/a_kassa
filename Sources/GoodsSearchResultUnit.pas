unit GoodsSearchResultUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, sListView,
  sSkinProvider, Vcl.ExtCtrls, sPanel, Vcl.Buttons, Vcl.StdCtrls, sSpeedButton;

type
  TformGoodsSearchResult = class(TForm)
    sSkinProvider1: TsSkinProvider;
    sPanel1: TsPanel;
    lvGoods: TsListView;
    sPanel2: TsPanel;
    btnClose: TsSpeedButton;
    btnUp: TsSpeedButton;
    btnDown: TsSpeedButton;
    btnSelect: TsSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure PanelResize(Sender: TObject);
    procedure btnUpClick(Sender: TObject);
    procedure btnDownClick(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private

  public
    Parametr, Field, SelectedCode: String;
  end;

var
  formGoodsSearchResult: TformGoodsSearchResult;

implementation

{$R *.dfm}

uses CommonUnit, DBUnit;

//изменение ширины и положения кнопок на панелях
procedure TformGoodsSearchResult.PanelResize(Sender: TObject);
begin
  AlignPanelControls(Sender as TsPanel) //изменение ширины и положения кнопок на панелях
end;

//прокрутить на одну страницу вниз
procedure TformGoodsSearchResult.btnDownClick(Sender: TObject);
begin
  LVScrollPage(lvGoods, False);
end;

//прокрутить на одну страницу вверх
procedure TformGoodsSearchResult.btnUpClick(Sender: TObject);
begin
  LVScrollPage(lvGoods, True);
end;

procedure TformGoodsSearchResult.FormShow(Sender: TObject);
var
  GA: TGoodsArray;
  LI: TListItem;
  i: Integer;
begin
  ScaleWindow(Self, 100); //масштабируем окно под текущее разрешение

  SelectedCode := '';

  if Field = 'barcode' then
    GA := DM1.FindGoodsByBarcode(Parametr)
  else
    GA := DM1.FindGoods(Parametr, Field, False);

  for i := 0 to Length(GA) - 1 do
  begin
    LI := lvGoods.Items.Add;
    LI.Caption := GA[i].gCode;
    LI.SubItems.Add(GA[i].gVendorcode);
    LI.SubItems.Add(GA[i].gName);
    LI.SubItems.Add(CurrToStrF(GA[i].gPrice, ffFixed, 2));
  end;

end;

//выбрать позицию
procedure TformGoodsSearchResult.btnSelectClick(Sender: TObject);
var
  SelectedItem: TListItem;
begin
  SelectedItem := lvGoods.Selected;

  if SelectedItem = nil then
  begin
    YesNoDialog('Укажите ту позицию, которую хотите добавить в чек.', 1, False);
    Exit
  end;

  SelectedCode := SelectedItem.Caption;

  Close
end;

//отмена
procedure TformGoodsSearchResult.btnCloseClick(Sender: TObject);
begin
  Close
end;

end.
