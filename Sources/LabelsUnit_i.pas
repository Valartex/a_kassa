unit LabelsUnit_i;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frxClass, frxBarcode,
  System.ImageList, Vcl.ImgList, acAlphaImageList, frxPreview, Vcl.StdCtrls,
  Vcl.ComCtrls, sComboBoxes, sListView, sPageControl, Vcl.Buttons, sSpeedButton,
  Vcl.ExtCtrls, sPanel, sComboBox, GoodsTableUnit, sButton, Vcl.Printers,
  sEdit, Vcl.OleCtrls, System.Types, CommonUnit;

type
  TLabelData = Record
    GoodsCode: String;
    GoodsName: String;
    GoodsPrice: String;
    GoodsBC: String;
    Count: Integer;
  end;
  TframeLabels = class(TFrame)
    frxReport1: TfrxReport;
    frxUserDataSet1: TfrxUserDataSet;
    sPageControl2: TsPageControl;
    sTabSheet8: TsTabSheet;
    sPanel5: TsPanel;
    btnAddGoods: TsSpeedButton;
    btnAddAllGoods: TsSpeedButton;
    sTabSheet9: TsTabSheet;
    sPanel4: TsPanel;
    btnPrintLabels: TsSpeedButton;
    frxPreview1: TfrxPreview;
    frameGoodsTable1: TframeGoodsTable;
    timerInit: TTimer;
    sPanel1: TsPanel;
    sPanel2: TsPanel;
    cbLabels: TsComboBox;
    cbPrinters: TsComboBox;
    lvSelectedGoods: TsListView;
    btnUp: TsSpeedButton;
    btnDown: TsSpeedButton;
    sPanel3: TsPanel;
    btnDelete: TsSpeedButton;
    btnClearGoods: TsSpeedButton;
    btnUp2: TsSpeedButton;
    btnDown2: TsSpeedButton;
    procedure frxReport1GetValue(const VarName: string; var Value: Variant);
    procedure PanelResize(Sender: TObject);
    procedure sTabSheet9Show(Sender: TObject);
    procedure btnClearGoodsClick(Sender: TObject);
    procedure btnAddGoodsClick(Sender: TObject);
    procedure frxUserDataSet1Next(Sender: TObject);
    procedure btnAddAllGoodsClick(Sender: TObject);
    procedure timerInitTimer(Sender: TObject);
    procedure btnPrintLabelsClick(Sender: TObject);
    procedure cbLabelsChange(Sender: TObject);
    procedure lvSelectedGoodsSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure lvSelectedGoodsCustomDraw(Sender: TCustomListView;
      const ARect: TRect; var DefaultDraw: Boolean);
    procedure btnUpClick(Sender: TObject);
    procedure btnDownClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnUp2Click(Sender: TObject);
    procedure btnDown2Click(Sender: TObject);
    procedure FrameEnter(Sender: TObject);
  private
    { Private declarations }
    LabelData: array of TLabelData;
    LabelCnt, GoodsCnt: Integer;
    CompanyName, ShopName, CompanyAddress, ShopAddress, CompanyINN, CompanyEmail, CompanyWeb, CompanyPhone: String;
    procedure AddLVValueEditor(LI: TListItem); //��������� �������� ���������� ��� ListView
    procedure btnPlusClick(Sender: TObject);
    procedure btnMinusClick(Sender: TObject);
    procedure editValueOnChange(Sender: TObject);
    procedure AddGoods(Code, GoodsName: String; Barcodes: TStringDynArray; Price: Currency);
    procedure BCScanerDataEvent(var scanerDataMessage: TScanerDataMessage); message WM_ScanerData;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses DBUnit;

// ������������� ������
procedure TframeLabels.timerInitTimer(Sender: TObject);
var
  LblFile: TSearchRec;
  nonVisualSettings: TNonVisualSettingsRecord;
begin
  timerInit.Enabled := False;

  // ��������� � ������ �������
  FindFirst(GetAppPath + 'Labels\*.lbl', faAnyFile, LblFile);

  if LblFile.Name <> '' then
    begin
      cbLabels.Items.Append(Copy(LblFile.Name, 1, Pos('.', LblFile.Name) - 1));

      while FindNext(LblFile) = 0 do
        cbLabels.Items.Append(Copy(LblFile.Name, 1, Pos('.', LblFile.Name) - 1));

      cbLabels.ItemIndex := 0
    end;

  FindClose(LblFile);

  // ��������� � ������ ��������
  cbPrinters.Items.Assign(Printer.Printers);
  cbPrinters.Items.Append('���������� �����������');

  // �������� �� �������� ��������� ��������� �������� � �������
  nonVisualSettings := DM1.GetNonVisualSettings;

  cbLabels.ItemIndex   := cbLabels.IndexOf(nonVisualSettings.lastLabel);
  cbPrinters.ItemIndex := cbPrinters.IndexOf(nonVisualSettings.lastPrinter);

  // ���� �� ������� ����� �������� � ��������, �� �������� ������ ������� � ������
  if (cbLabels.Items.Count > 0) and (cbLabels.Text = '') then
    cbLabels.ItemIndex := 0;
  if (cbPrinters.Items.Count > 0) and (cbPrinters.Text = '') then
    cbPrinters.ItemIndex := 0;
end;

// ������� ��� �������� ������
procedure TframeLabels.FrameEnter(Sender: TObject);
begin
  frameGoodsTable1.UpdateGoodsList; // ��������� ������ �������
end;

// ��������� �������� ���������� ��� ListView
procedure TframeLabels.AddLVValueEditor(LI: TListItem);
const
  ColumnIndex = 4;
var
  Panel            : TsPanel;
  editValue        : TsEdit;
  btnMinus, btnPlus: TsSpeedButton;
  PanelRect        : TRect;
begin
  lvSelectedGoods.Items.BeginUpdate;

  Panel := TsPanel.Create(lvSelectedGoods);
  Panel.ShowCaption := False;
  Panel.Parent      := lvSelectedGoods;
  PanelRect         := LI.DisplayRect(drBounds);
  PanelRect.Left    := PanelRect.Width - lvSelectedGoods.Columns[ColumnIndex].Width;
  PanelRect.Width   := lvSelectedGoods.Columns[ColumnIndex].Width;
  Panel.BoundsRect  := PanelRect;

  LI.Data := Panel; //����� ��������� ������ � listitem; �.�. ��� �������� li �������� � panel (�� ������� � ����� �� ��������)

  btnMinus := TsSpeedButton.Create(Panel);
  btnMinus.Caption := '-';
  btnMinus.Parent  := Panel;
  btnMinus.Align   := alLeft;
  btnMinus.Width   := btnMinus.Height * 2;
  btnMinus.OnClick := btnMinusClick;

  editValue := TsEdit.Create(Panel);
  editValue.Alignment   := taCenter;
  editValue.Text        := LI.SubItems[ColumnIndex - 1];
  editValue.Parent      := Panel;
  editValue.Align       := alClient;
  editValue.NumbersOnly := True;
  editValue.OnChange    := editValueOnChange;

  btnPlus := TsSpeedButton.Create(Panel);
  btnPlus.Caption := '+';
  btnPlus.Parent  := Panel;
  btnPlus.Align   := alRight;
  btnPlus.Width   := btnMinus.Width;
  btnPlus.OnClick := btnPlusClick;

  lvSelectedGoods.Items.EndUpdate
end;

// ��������� ������� �� ������� ����� � ������ ����������
procedure TframeLabels.btnMinusClick(Sender: TObject);
var
  editValue: TsEdit;
begin
  editValue := ((Sender as TsSpeedButton).Parent as TsPanel).Components[1] as TsEdit; // Edit �������� ������, ������� ������ ���������� ����� 1
  if StrToIntDef(editValue.Text, 0) > 0 then
    editValue.Text := IntToStr(StrToInt(editValue.Text) - 1)
end;

// ��������� ������� �� ������� ���� � ������ ����������
procedure TframeLabels.btnPlusClick(Sender: TObject);
var
  editValue: TsEdit;
begin
  editValue      := ((Sender as TsSpeedButton).Parent as TsPanel).Components[1] as TsEdit; // Edit �������� ������, ������� ������ ���������� ����� 1
  editValue.Text := IntToStr(StrToIntDef(editValue.Text, 0) + 1)
end;

// ��������� ������� �������� � ���� �������������� ���������� ��������
procedure TframeLabels.editValueOnChange(Sender: TObject);
begin
  lvSelectedGoods.Selected.SubItems[3] := (Sender as TsEdit).Text
end;

// ��������� ������ � ��������� ����������� �� �������
procedure TframeLabels.PanelResize(Sender: TObject);
begin
  AlignPanelControls(Sender as TsPanel)
end;

// ������������ ��������
procedure TframeLabels.sTabSheet9Show(Sender: TObject);
var
  i, k, n       : Integer;
  commonSettings: TCommonSettingsRecord;
begin
  LabelCnt := 0;
  GoodsCnt := 0;

  // �������� ������ � ��������
  commonSettings := DM1.GetCommonSettings;

  CompanyName    := commonSettings.companyName;
  ShopName       := commonSettings.shopName;
  CompanyAddress := commonSettings.companyAddress;
  ShopAddress    := commonSettings.shopAddress;
  CompanyINN     := commonSettings.companyINN;
  CompanyEmail   := commonSettings.companyEmail;
  CompanyWeb     := commonSettings.companyWeb;
  CompanyPhone   := commonSettings.companyPhone;

  n := 0; // ������� ��������� �������
  k := 0; // ������� �������� (�������� ������)

  for i := 0 to lvSelectedGoods.Items.Count - 1 do // ������� ����� ���������� �������� � ��������� ��������� �������
    begin
      if StrToInt(lvSelectedGoods.Items[i].SubItems.Strings[3]) = 0 then // ���� ������������ ������ ������� ���������� ��������, �� ���������� ������
        Continue;

      Inc(n);
      SetLength(LabelData, n); // ���-�� ��������� � �������

      k := k + StrToInt(lvSelectedGoods.Items[i].SubItems.Strings[3]);
      LabelData[n - 1].GoodsCode  := lvSelectedGoods.Items[i].Caption;                      // ��� ����
      LabelData[n - 1].GoodsName  := lvSelectedGoods.Items[i].SubItems.Strings[0];          // ������������ ������
      LabelData[n - 1].GoodsBC    := lvSelectedGoods.Items[i].SubItems.Strings[1];          // �������� ������
      LabelData[n - 1].GoodsPrice := lvSelectedGoods.Items[i].SubItems.Strings[2];          // ����
      LabelData[n - 1].Count      := StrToInt(lvSelectedGoods.Items[i].SubItems.Strings[3]) // ���������� ��������
    end;

  if cbLabels.Text <> '' then
    frxReport1.LoadFromFile(GetAppPath + 'Labels\' + cbLabels.Text + '.lbl');
  frxUserDataSet1.RangeEndCount := k; // ���������� �������� ������
  frxReport1.ShowReport;
end;

// �������� ������ ������� ��� ��������������
procedure TframeLabels.btnClearGoodsClick(Sender: TObject);
var
  i: Integer;
begin
  lvSelectedGoods.Clear;

  // ������� � ������� �������� ����������
  for i := 0 to lvSelectedGoods.ComponentCount - 1 do
    if lvSelectedGoods.Components[i] is TsPanel then
      begin
        (lvSelectedGoods.Components[i] as TsPanel).Free;
        Break
      end;
end;

// ������
procedure TframeLabels.btnPrintLabelsClick(Sender: TObject);
begin
  if cbPrinters.ItemIndex = cbPrinters.Items.Count - 1 then // ���� � �������� �������� ������ ��
    begin

    end
  else
    begin
      frxReport1.PrintOptions.Printer := cbPrinters.Text;
      frxReport1.PrintOptions.ShowDialog := False;
      SetPrinterPageSize(cbPrinters.Text, Round(frxReport1.Width / 10), Round(frxReport1.Height / 10)); // ������������ ������ ������ � ������� ������ (����� ������������ �� ����� ������ ������ ��� ������ ����� ��������)

      frxReport1.Print;
    end;
end;

// ��������� ��������� ������� � �������� � ���������
procedure TframeLabels.cbLabelsChange(Sender: TObject);
var
  nonVisualSettings: TNonVisualSettingsRecord;
begin
  nonVisualSettings := DM1.GetNonVisualSettings;

  nonVisualSettings.lastLabel   := cbLabels.Text;
  nonVisualSettings.lastPrinter := cbPrinters.Text;

  DM1.SaveNonVisualSetting(nonVisualSettings);
end;

// �������� ��� ������ ��� ��������������
procedure TframeLabels.btnAddAllGoodsClick(Sender: TObject);
var
  goodsArray: TGoodsArray;
  i         : Integer;
  NewItem   : TListItem;
begin
  if not YesNoDialog('�������� ��� ������?', 0, False) then
    Exit;

  lvSelectedGoods.Items.BeginUpdate;

  goodsArray := DM1.GetAllGoods;

  for i := 0 to Length(goodsArray) - 1 do
    begin
      NewItem := lvSelectedGoods.Items.Add;
      NewItem.Caption := goodsArray[i].gCode;
      NewItem.SubItems.Add(goodsArray[i].gName);
      if Length(goodsArray[i].gBarcodes) > 0 then
        NewItem.SubItems.Add(goodsArray[i].gBarcodes[0])
      else
        NewItem.SubItems.Add('');
      NewItem.SubItems.Add(CurrToStrF(goodsArray[i].gPrice, ffFixed, 2));
      NewItem.SubItems.Add('1');
    end;

  lvSelectedGoods.Items.EndUpdate;
end;

// ��������� �����
procedure TframeLabels.AddGoods(Code, GoodsName: String; Barcodes: TStringDynArray; Price: Currency);
var
  LI, NewItem: TListItem;
begin
  LI := lvSelectedGoods.FindCaption(0, Code, False, True, False); // ��������� ��� �� ��� � ������ ������ ������

  if LI = nil then // ���� ���, �� ���������
    begin
      NewItem := lvSelectedGoods.Items.Add;
      NewItem.Caption := Code;
      NewItem.SubItems.Add(GoodsName);
      if Length(Barcodes) > 0 then
        NewItem.SubItems.Add(Barcodes[0])
      else
        NewItem.SubItems.Add('');
      NewItem.SubItems.Add(CurrToStrF(Price, ffFixed, 2));
      NewItem.SubItems.Add('1');
    end
  else // ���� ����, �� ����������� ���������� �������� ��� ������ ������ �� �������
    begin
      lvSelectedGoods.Items[LI.Index].SubItems[3] := IntToStr(StrToInt(lvSelectedGoods.Items[LI.Index].SubItems[3]) + 1);
      if lvSelectedGoods.Items[LI.Index].Selected then
        (TsPanel(lvSelectedGoods.Items[LI.Index].Data).Components[1] as TsEdit).Text := lvSelectedGoods.Items[LI.Index].SubItems[3]
    end;
end;

// �������� ������ ��� ��������������
procedure TframeLabels.btnAddGoodsClick(Sender: TObject);
var
  SelectedItem, LI, NewItem: TListItem;
  goodsRecord              : TGoodsRecord;
  goodsArray               : TGoodsArray;
  i                        : Integer;
begin
  SelectedItem := frameGoodsTable1.lvGoods.Selected;

  if SelectedItem = nil then
    Exit;

  goodsRecord := DM1.GetGoodsData(SelectedItem.SubItems[0]);

  if goodsRecord.gIsGroup then
    begin
      if YesNoDialog('�������� ��� ������ �� ���� ������?', 0, False) then
        begin
          lvSelectedGoods.Items.BeginUpdate;

          goodsArray := DM1.GetAllGoodsGroupChild(goodsRecord.gCode);

          for i := 0 to Length(goodsArray) - 1 do
            begin
              SendMessage(Application.MainFormHandle, WM_USER + 2, 1, 1); //��������� ProgressBar �� ������� �����

              AddGoods(goodsArray[i].gCode, goodsArray[i].gName, goodsArray[i].gBarcodes, goodsArray[i].gPrice);
            end;

          lvSelectedGoods.Items.EndUpdate;

          SendMessage(Application.MainFormHandle, WM_USER + 2, 0, 0); //�������� ProgressBar �� ������� �����
        end
    end
  else
    begin
      AddGoods(goodsRecord.gCode, goodsRecord.gName, goodsRecord.gBarcodes, goodsRecord.gPrice);
    end
end;

// ���������� �� ���� �������� ����� ������ �������
procedure TframeLabels.btnUpClick(Sender: TObject);
begin
  LVScrollPage(frameGoodsTable1.lvGoods, True);
end;

// ���������� �� ���� �������� ���� ������ �������
procedure TframeLabels.btnDownClick(Sender: TObject);
begin
  LVScrollPage(frameGoodsTable1.lvGoods, False);
end;

// ���������� �� ���� �������� ����� ������� �������
procedure TframeLabels.btnUp2Click(Sender: TObject);
begin
  LVScrollPage(lvSelectedGoods, True);
end;

// ���������� �� ���� �������� ���� ������� �������
procedure TframeLabels.btnDown2Click(Sender: TObject);
begin
  LVScrollPage(lvSelectedGoods, False);
end;

// ������� ����� �� ������� �� ������
procedure TframeLabels.btnDeleteClick(Sender: TObject);
var
  SelectedItem: TListItem;
begin
  SelectedItem := lvSelectedGoods.Selected;

  if SelectedItem = nil then
    begin
      YesNoDialog('�������� ����� ��� �������� �� ������ �� ������.', 1, False);
      Exit
    end;

  SelectedItem.Delete
end;

// ��������� ������ ��� ���������� � �������
procedure TframeLabels.frxReport1GetValue(const VarName: string; var Value: Variant);
begin
  if CompareText(VarName, 'warename') = 0 then
    Value := LabelData[GoodsCnt].GoodsName
  else
  if CompareText(VarName, 'price') = 0 then
    Value := LabelData[GoodsCnt].GoodsPrice
  else
  if CompareText(VarName, 'bc') = 0 then
    Value := LabelData[GoodsCnt].GoodsBC
  else
  if CompareText(VarName, 'companyname') = 0 then
    Value := CompanyName
  else
  if CompareText(VarName, 'companyinn') = 0 then
    Value := CompanyINN
  else
  if CompareText(VarName, 'companyaddress') = 0 then
    Value := CompanyAddress
  else
  if CompareText(VarName, 'companyemail') = 0 then
    Value := CompanyEmail
  else
  if CompareText(VarName, 'companyweb') = 0 then
    Value := CompanyWeb
  else
  if CompareText(VarName, 'companyphone') = 0 then
    Value := CompanyPhone
  else
  if CompareText(VarName, 'shopname') = 0 then
    Value := ShopName
  else
  if CompareText(VarName, 'shopaddress') = 0 then
    Value := ShopAddress
end;

// �������, ������������ ��� �������� � ������ ������� (�������)
procedure TframeLabels.frxUserDataSet1Next(Sender: TObject);
begin
  Inc(LabelCnt); // ������� ��������� �������� ��� �������� ������

  if LabelCnt = LabelData[GoodsCnt].Count then // ���� ���������� ������������ �������� ����� ���������� ������������� ��� �������� ������, �� ��������� � ���������� ������
    begin
      LabelCnt := 0;
      Inc(GoodsCnt); // ������� �������
    end;
end;

// ������������ �������� ���������� ��� ��������� listview
procedure TframeLabels.lvSelectedGoodsCustomDraw(Sender: TCustomListView;
  const ARect: TRect; var DefaultDraw: Boolean);
const
  ColumnIndex = 4;
var
  LI       : TListItem;
  Panel    : TsPanel;
  PanelRect: TRect;
begin
  for LI in Sender.Items do
    begin
      Panel := TsPanel(LI.Data);
      if LI.Selected then
        begin
          PanelRect        := LI.DisplayRect(drBounds);
          PanelRect.Left   := PanelRect.Width - lvSelectedGoods.Columns[ColumnIndex].Width;
          PanelRect.Width  := lvSelectedGoods.Columns[ColumnIndex].Width;
          Panel.BoundsRect := PanelRect;

          if Panel.Top >= Panel.Height then // ����� �������� �� ������������� �� ��������� �������
            Panel.Visible := True
          else
            Panel.Visible := False;

          Break
        end;
    end;
end;

procedure TframeLabels.lvSelectedGoodsSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  if Selected then
    AddLVValueEditor(Item)
  else
    TsPanel(Item.Data).Free
end;

// ������� �� ������������ ��
procedure TframeLabels.BCScanerDataEvent(var scanerDataMessage: TScanerDataMessage);
var
  goodsArray  : TGoodsArray;
  SelectedCode: String;
  goodsRecord       : TGoodsRecord;
begin
  goodsArray := DM1.FindGoodsByBarcode(scanerDataMessage.LParam);

  if Length(goodsArray) > 1 then
    begin
      SelectedCode := GoodsSearchResultDlg(scanerDataMessage.LParam, 'barcode');

      if SelectedCode <> '' then
        begin
          goodsRecord := DM1.GetGoodsData(SelectedCode);
          AddGoods(SelectedCode, goodsRecord.gName, goodsRecord.gBarcodes, goodsRecord.gPrice);
        end;
    end
  else
    if Length(goodsArray) = 1 then
      AddGoods(goodsArray[0].gCode, goodsArray[0].gName, goodsArray[0].gBarcodes, goodsArray[0].gPrice)
    else
      YesNoDialog('����� �� ���������� ' + scanerDataMessage.LParam + ' �� ������.', 1, False)
end;

end.
