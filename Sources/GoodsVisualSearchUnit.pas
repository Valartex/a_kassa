unit GoodsVisualSearchUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sSpeedButton,
  Vcl.ExtCtrls, sPanel, sSkinProvider, GoodsTableUnit, Vcl.ComCtrls,
  Vcl.Buttons, sEdit, CommonUnit;

type
  TformGoodsVisualSearch = class(TForm)
    sSkinProvider1: TsSkinProvider;
    sPanel1: TsPanel;
    frameGoodsTable1: TframeGoodsTable;
    panelButtons: TsPanel;
    btnSelect: TsSpeedButton;
    btnClose: TsSpeedButton;
    btnUp: TsSpeedButton;
    btnDown: TsSpeedButton;
    sPanel2: TsPanel;
    btnSearch: TsSpeedButton;
    btnClearSearch: TsSpeedButton;
    editSearch: TsEdit;
    procedure btnSelectClick(Sender: TObject);
    procedure btnUpClick(Sender: TObject);
    procedure btnDownClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure PanelResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure btnClearSearchClick(Sender: TObject);
  private
    { Private declarations }
  public
    SelectedCode: String;
  end;

var
  formGoodsVisualSearch: TformGoodsVisualSearch;

implementation

{$R *.dfm}

uses DBUnit;

procedure TformGoodsVisualSearch.FormShow(Sender: TObject);
begin
  ScaleWindow(Self, 100); //������������ ���� ��� ������� ����������
end;

//��������� ������ � ��������� ������ �� �������
procedure TformGoodsVisualSearch.PanelResize(Sender: TObject);
begin
  AlignPanelControls(Sender as TsPanel)
end;

//����� ����� �� �������� ������
procedure TformGoodsVisualSearch.btnSearchClick(Sender: TObject);
var
  GoodsData: TGoodsArray;
  NewItem: TListItem;
  i: Integer;
begin
  GoodsData := DM1.FindGoods(editSearch.Text, 'name', True);

  frameGoodsTable1.lvGoods.Clear;

  for i := 0 to Length(GoodsData) - 1 do
    begin
      NewItem := frameGoodsTable1.lvGoods.Items.Add;
      NewItem.StateIndex := 2; //�����
      NewItem.SubItems.Append(GoodsData[i].gCode);  //���
      NewItem.SubItems.Append(GoodsData[i].gName); //������������
      NewItem.SubItems.Append(CurrToStrF(GoodsData[i].gPrice, ffFixed, 2)); //����
    end
end;

//�������� ������ ������
procedure TformGoodsVisualSearch.btnClearSearchClick(Sender: TObject);
begin
  editSearch.Clear;
  frameGoodsTable1.UpdateGoodsList
end;

//���������� �� ���� �������� �����
procedure TformGoodsVisualSearch.btnUpClick(Sender: TObject);
begin
  LVScrollPage(frameGoodsTable1.lvGoods, True);
end;

//���������� �� ���� �������� ����
procedure TformGoodsVisualSearch.btnDownClick(Sender: TObject);
begin
  LVScrollPage(frameGoodsTable1.lvGoods, False);
end;

//������� �����
procedure TformGoodsVisualSearch.btnSelectClick(Sender: TObject);
var
  SelectedItem: TListItem;
begin
  SelectedItem := frameGoodsTable1.lvGoods.Selected;

  if SelectedItem = nil then
  begin
    YesNoDialog('�������� �������, ������� ������ �������� ���.', 1, False);
    Exit
  end;

  if frameGoodsTable1.lvGoods.Selected.StateIndex = 2 then //���� �����, �� ��������� ��� � ���
  begin
    SelectedCode := frameGoodsTable1.lvGoods.Selected.SubItems[0];
    Close
  end;
end;

//������
procedure TformGoodsVisualSearch.btnCloseClick(Sender: TObject);
begin
  Close
end;

end.
