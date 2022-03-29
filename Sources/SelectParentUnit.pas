//диалог выбора товарной группы
unit SelectParentUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, sTreeView, Vcl.Buttons,
  Vcl.ExtCtrls, sPanel, sSkinProvider, Vcl.StdCtrls, sButton,
  System.ImageList, Vcl.ImgList, acAlphaImageList;

type
  TformSelectParent = class(TForm)
    sPanel1: TsPanel;
    sPanel7: TsPanel;
    tvGoodsGroups: TsTreeView;
    sSkinProvider1: TsSkinProvider;
    btnSelectGroup: TsButton;
    btnCancel: TsButton;
    sAlphaImageList1: TsAlphaImageList;
    procedure FormCreate(Sender: TObject);
    procedure PanelResize(Sender: TObject);
    procedure btnSelectGroupClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure tvGoodsGroupsClick(Sender: TObject);
  private
    { Private declarations }
    procedure BuildTree(ParentNode: TTreeNode; ParentGroupCode: String);
  public
    { Public declarations }
    ParentDir: String;
  end;

var
  formSelectParent: TformSelectParent;

implementation

{$R *.dfm}

uses DBUnit, CommonUnit;

//строим дерево товарных групп
procedure TformSelectParent.BuildTree(ParentNode: TTreeNode; ParentGroupCode: String);
var
  Groups: TGoodsArray;
  i: Integer;
begin
  Groups := DM1.GetGoodsGroupChild(ParentGroupCode, True); //запрашиваем список папок по родителю
  for i := 0 to Length(Groups) - 1 do
    tvGoodsGroups.Items.AddChild(ParentNode, Groups[i].gCode + '. ' +  Groups[i].gName).StateIndex := 0; //добавл€ем новый узел

end;

//изменение ширины и положени€ кнопок на панел€х
procedure TformSelectParent.PanelResize(Sender: TObject);
begin
  AlignPanelControls(Sender as TsPanel)
end;

procedure TformSelectParent.tvGoodsGroupsClick(Sender: TObject);
var
  SelectedItem: TTreeNode;
begin
  SelectedItem := tvGoodsGroups.Selected;

  if (SelectedItem = nil) or SelectedItem.HasChildren then
    Exit;

  BuildTree(SelectedItem, Copy(SelectedItem.Text, 1, Pos('.', SelectedItem.Text) - 1));

  SelectedItem.Expand(False);
end;

procedure TformSelectParent.FormCreate(Sender: TObject);
begin
  ParentDir := ''
end;

//обработка нажатий клавиш клавиатуры
procedure TformSelectParent.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close
end;

procedure TformSelectParent.FormShow(Sender: TObject);
begin
  ScaleWindow(Self, 100); //масштабируем окно под текущее разрешение
  BuildTree(nil, '');  //выводим корневые товарные группы
end;

//выбрать родительскую группу
procedure TformSelectParent.btnSelectGroupClick(Sender: TObject);
begin
  if tvGoodsGroups.SelectionCount > 0 then
    ParentDir := tvGoodsGroups.Selected.Text  //запоминаем выделенный в дереве узел (товарна€ группа)
end;

end.

