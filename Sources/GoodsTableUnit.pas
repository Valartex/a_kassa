unit GoodsTableUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList,
  Vcl.ImgList, acAlphaImageList, Vcl.ComCtrls, sListView, Vcl.ExtCtrls;

type
  TframeGoodsTable = class(TFrame)
    lvGoods: TsListView;
    sAlphaImageList1: TsAlphaImageList;
    timerInit: TTimer;
    procedure lvGoodsClick(Sender: TObject);
    procedure lvGoodsCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure timerInitTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure UpdateGoodsList;
    procedure SelectGoods(Code: String);
  end;

implementation

{$R *.dfm}

uses DBUnit;

//������������� ������
procedure TframeGoodsTable.timerInitTimer(Sender: TObject);
begin
  timerInit.Enabled := False; //�.�. ������ ��������� ���� ��� ��� �������� ������

  UpdateGoodsList; //��������� ListView ������� �� ����������� �������

  //�������� ������ ������ ������/����� � ����������� �� ������ �������
  sAlphaImageList1.Width := lvGoods.Columns[0].Width - 2;
  sAlphaImageList1.Height := sAlphaImageList1.Width;
end;

//��������� ������ � ������
procedure TframeGoodsTable.SelectGoods(Code: String);
var
  GA: TGoodsArray;
  GR: TGoodsRecord;
  i: Integer;
  NewItem: TListItem;
begin
  GR := DM1.GetGoodsData(Code); //�������� ������ �������� ������
  GA := DM1.GetGoodsGroupChild(GR.gParent, False); // �������� ��� �������� �������� ������, � ������ ��������� ������� �����

  lvGoods.Hint := GR.gParent; //���������� � hint ��� �������� ������, ��� ���� ����� ����� ���� ���������� ����� �������� �����������

  lvGoods.Items.BeginUpdate; //��������� ����������� ����������

  lvGoods.Clear;

  while GR.gParent <> '' do
    begin
      GR := DM1.GetGoodsData(GR.gParent); //�������� ������ ������������ ������

      NewItem := lvGoods.Items.Insert(0); //��������� ���������� �������� � ������ �������
      NewItem.SubItems.Append(GR.gCode); //���
      NewItem.SubItems.Append(GR.gName); //������������
      NewItem.StateIndex := 1; //�������� ������
    end;

  //��������� �������� �������� ������
  for i := 0 to Length(GA) - 1 do
  begin
    NewItem := lvGoods.Items.Add;
    NewItem.SubItems.Append(GA[i].gCode); //���
    NewItem.SubItems.Append(GA[i].gName); //������������

    if GA[i].gIsGroup then
      NewItem.StateIndex := 0 //�������� ������
    else
    begin
      NewItem.StateIndex := 2; //�����
      NewItem.SubItems.Append(CurrToStrF(GA[i].gPrice, ffFixed, 2)); //����
    end
  end;

  //�������� ������� �����
  for i := 0 to lvGoods.Items.Count - 1 do
    if lvGoods.Items[i].SubItems[0] = Code then
      begin
        lvGoods.SelectItem(i);
        Break
      end;

  lvGoods.Selected.MakeVisible(False);

  lvGoods.Items.EndUpdate; //�������� �����������
end;

//������������� ������ �������
procedure TframeGoodsTable.UpdateGoodsList;
var
  GoodsData: TGoodsArray;
  i: Integer;
  NewItem: TListItem;
begin
  GoodsData := DM1.GetGoodsGroupChild('', False); //�������� ������ �������� ��������� �����

  lvGoods.Clear;

  for i := 0 to Length(GoodsData) - 1 do //��������� �������� �������� ������
  begin
    NewItem := lvGoods.Items.Add;
    NewItem.SubItems.Append(GoodsData[i].gCode);  //���
    NewItem.SubItems.Append(GoodsData[i].gName); //������������

    if GoodsData[i].gIsGroup then
      NewItem.StateIndex := 0 //�������� ������
    else
    begin
      NewItem.StateIndex := 2; //�����
      NewItem.SubItems.Append(CurrToStrF(GoodsData[i].gPrice, ffFixed, 2)); //����
    end
  end;

  //��������� �������� (������ ����������� � �������, ���� ���-�� �� ���, �� ������������)
//  lvGoods.SortType := stBoth;
//  lvGoods.SortType := stNone;
end;

//��������� ������� �� �������� ����������� "������"
procedure TframeGoodsTable.lvGoodsClick(Sender: TObject);
var
  SelectedItem, NewItem: TListItem;
  GA: TGoodsArray;
  i, ParentIndex: Integer;
  SelectedItemCode: String;
begin

  SelectedItem := lvGoods.Selected; //���������� ��������� �������

  if SelectedItem = nil then //���� ������ � �������
    Exit;

  lvGoods.Items.BeginUpdate; //��������� ����������� ����������

  SelectedItemCode := SelectedItem.SubItems[0]; //���������� ��� ���������� ��������

  if SelectedItem.StateIndex in [0, 1] then //���� ������ �� ������
    begin
      if SelectedItem.StateIndex = 0 then //���� ������ �������
        begin

          SelectedItem.StateIndex := 1; //������ ������ ������ �� "�������"

          lvGoods.Hint := SelectedItem.SubItems[0]; //���������� � hint ��� �������� ������, ��� ���� ����� ����� ���� ���������� ����� �������� �����������

            for i := lvGoods.Items.Count - 1 downto 0 do
              if lvGoods.Items[i].StateIndex <> 1 then
                lvGoods.Items[i].Delete; //������� �� ������ ��� �������� ������ � ������

          GA := DM1.GetGoodsGroupChild(SelectedItem.SubItems[0], False); //�������� ������ �������� ���������
        end
      else
        begin //���� ������ �������

          ParentIndex := SelectedItem.Index - 1; //������ ������������ ������

          if ParentIndex = -1 then //�������� ����������� (������)
            begin
              lvGoods.Clear;
              GA := DM1.GetGoodsGroupChild('', False); //�������� ������ �������� ���������

              lvGoods.Hint := '';
            end
          else
            begin
              for i := lvGoods.Items.Count - 1 downto ParentIndex + 1 do //������� ��� ��������� �� ������������ ������� ��������
                lvGoods.Items[i].Delete;
              GA := DM1.GetGoodsGroupChild(lvGoods.Items[ParentIndex].SubItems[0], False); //�������� ������ �������� ���������

              lvGoods.Hint := lvGoods.Items[ParentIndex].SubItems[0];
            end;

        end;

      for i := 0 to Length(GA) - 1 do //��������� �������� �������� ������
        begin
          NewItem := lvGoods.Items.Add;
          NewItem.SubItems.Append(GA[i].gCode); //���
          NewItem.SubItems.Append(GA[i].gName); //������������

          if GA[i].gIsGroup then
            NewItem.StateIndex := 0 //�������� ������
          else
            begin
              NewItem.StateIndex := 2; //�����
              NewItem.SubItems.Append(CurrToStrF(GA[i].gPrice, ffFixed, 2)); //����
            end
        end;

      for i := 0 to lvGoods.Items.Count - 1 do //���������� ���������
        if lvGoods.Items[i].SubItems[0] = SelectedItemCode then
          begin
            lvGoods.SelectItem(i);
            Break
          end;

      //��������� �������� (������ ����������� � �������, ���� ���-�� �� ���, �� ������������)
  //    lvGoods.SortType := stBoth;
  //    lvGoods.SortType := stNone;

      lvGoods.Selected.MakeVisible(False);

    end
  else
    begin //���� ������ �� �����
      //�������� ����� � ���
    end;

  lvGoods.Items.EndUpdate;

end;

//���������� �������
{�������� Compare ����� ����� ��� ��������: 1, -1 ��� 0.
 ������� ��������, ��� ������ ������� ������ (��� ������ ���� �������� �����) ������� ��������.
 ����� ���� ��������, ��� ������ ������� ������ ��� (��� ������ ���� �������� �����) ������ �������.
 ���� ��������, ��� ��� �������� �����.}
procedure TframeGoodsTable.lvGoodsCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
begin
  if (Item1.StateIndex = 2) and (Item2.StateIndex = 0) then //���������� ����� � �������� ������
    Compare := 1 //����������� �������� ������ ����� �������
  else
  if ((Item1.StateIndex = 0) and (Item2.StateIndex = 0)) or ((Item1.StateIndex = 2) and (Item2.StateIndex = 2)) then //���� ������ � ��������� ��������
    Compare := AnsiCompareStr(Item1.SubItems[1], Item2.SubItems[1]) //��������� �� ��������
  else
    Compare := 0 //�� ���� ��������� ������� �� ������ ��������� ���������
end;

end.
