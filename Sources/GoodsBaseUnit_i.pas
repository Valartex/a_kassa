unit GoodsBaseUnit_i;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, sSpinEdit, Vcl.StdCtrls,
  sCheckBox, sComboBox, sEdit, sLabel, Vcl.ExtCtrls, acImage, Vcl.Buttons,
  sSpeedButton, sPanel, Vcl.ComCtrls, sListView, sPageControl, Vcl.ExtDlgs,
  sDialogs, System.ImageList, Vcl.ImgList, acAlphaImageList, sMemo,
  GoodsTableUnit, sButton, Vcl.OleCtrls, CommonUnit;

type
  TframeGoodsBase = class(TFrame)
    pcGoods: TsPageControl;
    tsGoods: TsTabSheet;
    sPanel6: TsPanel;
    btnAddGoodsGroup: TsSpeedButton;
    btnAddGoods: TsSpeedButton;
    btnEditGoods: TsSpeedButton;
    btnDeleteGoods: TsSpeedButton;
    tsGoodsGroupData: TsTabSheet;
    imgGoodsGroup: TsImage;
    btnClearGoodsGroupImage: TsSpeedButton;
    sLabel9: TsLabel;
    sLabel10: TsLabel;
    sLabel11: TsLabel;
    sLabel12: TsLabel;
    sLabel13: TsLabel;
    sLabel69: TsLabel;
    sPanel7: TsPanel;
    btnSaveGoodsGroup: TsSpeedButton;
    btnCancelGoodsGroup: TsSpeedButton;
    editGroupName: TsEdit;
    editGroupCode: TsEdit;
    cbGroupUnit: TsComboBox;
    cbGroupTax: TsComboBox;
    cbGroupPPR: TsComboBox;
    tsGoodsData: TsTabSheet;
    imgGoods: TsImage;
    sLabel1: TsLabel;
    sLabel2: TsLabel;
    sLabel3: TsLabel;
    sLabel4: TsLabel;
    sLabel5: TsLabel;
    sLabel6: TsLabel;
    sLabel7: TsLabel;
    sLabel8: TsLabel;
    btnClearGoodsImage: TsSpeedButton;
    btnBarcodeDelete: TsSpeedButton;
    sLabel70: TsLabel;
    sPanel8: TsPanel;
    btnSaveGoods: TsSpeedButton;
    btnCancelGoods: TsSpeedButton;
    editGoodsName: TsEdit;
    lvBarcodes: TsListView;
    editGoodsCode: TsEdit;
    editGoodsVendorcode: TsEdit;
    cbGoodsUnit: TsComboBox;
    cbGoodsTax: TsComboBox;
    seGoodsPrice: TsDecimalSpinEdit;
    editGoodsPLU: TsEdit;
    cbGoodsPPR: TsComboBox;
    sLabel14: TsLabel;
    cbGoodsFractional: TsComboBox;
    sLabel15: TsLabel;
    cbGoodsUnloadInScales: TsComboBox;
    sLabel16: TsLabel;
    cbGoodsQuantityRequest: TsComboBox;
    sLabel17: TsLabel;
    cbGoodsPriceRequest: TsComboBox;
    OpenPictureDialog1: TsOpenPictureDialog;
    sLabel18: TsLabel;
    cbGroupFractional: TsComboBox;
    sLabel19: TsLabel;
    cbGroupUnloadInScales: TsComboBox;
    sLabel20: TsLabel;
    cbGroupQuantityRequest: TsComboBox;
    sLabel21: TsLabel;
    cbGroupPriceRequest: TsComboBox;
    editGroupParent: TsEdit;
    editGoodsParent: TsEdit;
    seGoodsDepartment: TsSpinEdit;
    sLabel22: TsLabel;
    seGroupDepartment: TsSpinEdit;
    sLabel23: TsLabel;
    memoGoodsComposition: TsMemo;
    sLabel24: TsLabel;
    timerInit: TTimer;
    btnGeneratePLU: TsSpeedButton;
    btnSelectGoodsParent: TsSpeedButton;
    btnSelectGroupParent: TsSpeedButton;
    frameGoodsTable1: TframeGoodsTable;
    sSpeedButton1: TsSpeedButton;
    sSpeedButton2: TsSpeedButton;
    btnBarcodeGen: TsSpeedButton;
    sLabel25: TsLabel;
    cbGroupType: TsComboBox;
    sLabel26: TsLabel;
    cbGoodsType: TsComboBox;
    procedure PanelResize(Sender: TObject);
    procedure btnSaveGoodsClick(Sender: TObject); //��������� �����
    procedure btnSaveGoodsGroupClick(Sender: TObject); //��������� �������� ������
    procedure btnAddGoodsClick(Sender: TObject); //�������� �����
    procedure btnAddGoodsGroupClick(Sender: TObject); //�������� �������� ������
    procedure btnCancelGoodsClick(Sender: TObject); //������ ��������� ������ � ������
    procedure btnCancelGoodsGroupClick(Sender: TObject); //������ ��������� ������ � �������� ������
    procedure imgGoodsClick(Sender: TObject); //����� ����������� ��� ������
    procedure btnClearGoodsImageClick(Sender: TObject); //������ ����������� ������
    procedure btnBarcodeDeleteClick(Sender: TObject); //������� �� ������
    procedure imgGoodsGroupClick(Sender: TObject); //������� ����������� ��� �������� ������
    procedure btnClearGoodsGroupImageClick(Sender: TObject); //������ ����������� �������� ������
    procedure lvGoodsClick(Sender: TObject); //��������� ������� �� ����� ��� �������� ������
    procedure timerInitTimer(Sender: TObject); //������������� ������ ������
    procedure btnEditGoodsClick(Sender: TObject); //������������� ����� ��� �������� ������
    procedure lvGoodsCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer); //���������� ������� �������
    procedure btnDeleteGoodsClick(Sender: TObject); //������� ����� ��� �������� ������
    procedure btnSelectGroupParentClick(Sender: TObject); //����� �������� ��� �������� ������
    procedure btnSelectGoodsParentClick(Sender: TObject);
    procedure btnUpClick(Sender: TObject);
    procedure btnDownClick(Sender: TObject);
    procedure btnBarcodeGenClick(Sender: TObject);
  private
    { Private declarations }
    lvGoods: TsListView;
    procedure BCScanerDataEvent(var scanerDataMessage: TScanerDataMessage); message WM_ScanerData;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses SelectParentUnit, DBUnit;

// ������������� ������
procedure TframeGoodsBase.timerInitTimer(Sender: TObject);
var
  sl: TStringList;
begin
  timerInit.Enabled := False; // �.�. ������ ��������� ���� ��� ��� �������� ������

  lvGoods := frameGoodsTable1.lvGoods;

  // ��������� ���������� �� �������� � ����������� � ������ � �������� ������
  sl := TStringList.Create;

  DM1.GetUnitsNames(sl);
  cbGoodsUnit.Items.Assign(sl);
  cbGroupUnit.Items.Assign(sl);

//  DM1.GetTaxesNames(sl);
//  cbGoodsTax.Items.Assign(sl);
//  cbGroupTax.Items.Assign(sl);

  DM1.GetPPRNames(sl);
  cbGoodsPPR.Items.Assign(sl);
  cbGroupPPR.Items.Assign(sl);

  sl.Free;
end;

//������� ������������ ������ ��� ������
procedure TframeGoodsBase.btnSelectGoodsParentClick(Sender: TObject);
var
  prnt: String;
begin
  prnt := SelectParentDlg; //������ ������ ��������
  if prnt <> '' then
    editGoodsParent.Text := prnt
end;

//������� ������������ ������ ��� ������
procedure TframeGoodsBase.btnSelectGroupParentClick(Sender: TObject);
var
  prnt: String;
begin
  prnt := SelectParentDlg; //������ ������ ������������ �������� ������
  if prnt <> '' then
    editGroupParent.Text := prnt
end;

//���������� �� ���� �������� �����
procedure TframeGoodsBase.btnUpClick(Sender: TObject);
begin
  LVScrollPage(lvGoods, True);
end;

//���������� �� ���� �������� ����
procedure TframeGoodsBase.btnDownClick(Sender: TObject);
begin
  LVScrollPage(lvGoods, False);
end;

//��������� ������ � ��������� ������ �� �������
procedure TframeGoodsBase.PanelResize(Sender: TObject);
begin
  AlignPanelControls(Sender as TsPanel)
end;

//��������� �����
procedure TframeGoodsBase.btnSaveGoodsClick(Sender: TObject);
var
  GR: TGoodsRecord;
  i: Integer;
  NewItem: TListItem;
  newCode: String;
begin
  //��������� ��������� ������� �� ����� �����
  with GR do
    begin
      gCode := editGoodsCode.Text;
      gIsGroup := False;
      gName := editGoodsName.Text;
      if editGoodsParent.Text = '' then
        gParent := ''
      else
        gParent := Copy(editGoodsParent.Text, 1, Pos('.', editGoodsParent.Text) - 1); //�.�. �������� � ������� "���. ������������", � ��� ����� ������ ���
      gVendorcode := editGoodsVendorcode.Text;
      gUnit := DM1.GetUnitCodeByName(cbGoodsUnit.Text);
      gTax := cbGoodsTax.ItemIndex;
      gPPR := DM1.GetPPRCodeByName(cbGoodsPPR.Text);
      gType := cbGoodsType.ItemIndex;
      gDepartment := seGoodsDepartment.Value;
      if editGoodsPLU.Text <> '' then
        gPLU := StrToInt(editGoodsPLU.Text)
      else
        gPLU := 0;
      gPrice := seGoodsPrice.Value;
      gFractional := Boolean(cbGoodsFractional.ItemIndex);
      gUnloadInScales := Boolean(cbGoodsUnloadInScales.ItemIndex);
      gQuantityRequest := Boolean(cbGoodsQuantityRequest.ItemIndex);
      gPriceRequest := Boolean(cbGoodsPriceRequest.ItemIndex);
      gPicture := imgGoods.Hint;

      SetLength(gBarcodes, lvBarcodes.Items.Count);
      for i := 0 to lvBarcodes.Items.Count - 1 do
        gBarcodes[i] := lvBarcodes.Items[i].Caption;
    end;

  //�������� ����� � ��, � ����� ������� ��� ����� ���������� ������ (��� �������������, ���� ��� ��������������)
  newCode := DM1.SaveGoods(GR);

  //������ ������ ������ � ������� ��� ��������� �����
  if editGoodsCode.Text <> '' then //������ �����
    begin
      lvGoods.Items[lvGoods.ItemIndex].SubItems[1] := editGoodsName.Text;
      lvGoods.Items[lvGoods.ItemIndex].SubItems[2] := CurrToStrF(seGoodsPrice.Value, ffFixed, 2);
    end
  else //����� �����
    begin
      NewItem := lvGoods.Items.Add;
      NewItem.StateIndex := 2;
      NewItem.SubItems.Append(newCode);
      NewItem.SubItems.Append(editGoodsName.Text);
      NewItem.SubItems.Append(CurrToStrF(seGoodsPrice.Value, ffFixed, 2));
    end;

  lvGoods.SortType := stBoth; //��������� ��������
  lvGoods.SortType := stNone;

  pcGoods.ActivePageIndex := 0
end;

//��������� �������� ������
procedure TframeGoodsBase.btnSaveGoodsGroupClick(Sender: TObject);
var
  GR: TGoodsRecord;
  NewItem: TListItem;
  newCode: String;
begin
  //��������� ��������� ������� �� ����� �����
  with GR do
    begin
      gCode := editGroupCode.Text;
      gIsGroup := True;
      gName := editGroupName.Text;
      if editGroupParent.Text = '' then
        gParent := ''
      else
        gParent := Copy(editGroupParent.Text, 1, Pos('.', editGroupParent.Text) - 1); //�.�. �������� � ������� "���. ������������", � ��� ����� ������ ���
      gVendorcode := '';
      gUnit := DM1.GetUnitCodeByName(cbGroupUnit.Text);
      gTax := cbGroupTax.ItemIndex;
      gPPR := DM1.GetPPRCodeByName(cbGroupPPR.Text);
      gType := cbGroupType.ItemIndex;
      gDepartment := seGroupDepartment.Value;
      gPLU := 0;
      gPrice := 0.00;
      gFractional := Boolean(cbGroupFractional.ItemIndex);
      gUnloadInScales := Boolean(cbGroupUnloadInScales.ItemIndex);
      gQuantityRequest := Boolean(cbGroupQuantityRequest.ItemIndex);
      gPriceRequest := Boolean(cbGroupPriceRequest.ItemIndex);
      gPicture := imgGoodsGroup.Hint;

      SetLength(gBarcodes, 0);
    end;

  //�������� �������� ������ � ��, � ����� ������� ��� ����� ��������� �������� ������ (��� ������������, ���� ��� ��������������)
  newCode := DM1.SaveGoods(GR);

  // ������ ������ �������� ������ � ������� ��� ��������� �����
  if editGroupCode.Text <> '' then // ������ ������
    begin
      lvGoods.Items[lvGoods.ItemIndex].SubItems[1] := editGroupName.Text;
    end
  else //����� ������
    begin
      NewItem := lvGoods.Items.Add;
      NewItem.StateIndex := 0;
      NewItem.SubItems.Append(newCode);
      NewItem.SubItems.Append(editGroupName.Text);
    end;

  lvGoods.SortType := stBoth; //��������� ��������
  lvGoods.SortType := stNone;

  pcGoods.ActivePageIndex := 0
end;

//�������� �����
procedure TframeGoodsBase.btnAddGoodsClick(Sender: TObject);
var
  GR: TGoodsRecord;
begin
  //������� ���� ����� �� ���������� ������
  editGoodsName.Text := '';
  editGoodsCode.Text := '';
  editGoodsVendorcode.Text := '';
  editGoodsPLU.Text := '';
  seGoodsPrice.Value := 0.00;
  memoGoodsComposition.Text := '';

  imgGoods.Picture := nil;

  lvBarcodes.Clear;

  if lvGoods.Hint <> '' then //� ����� �������� ��� �������� �������� ������; ���� �� ����, ������ �� � �����
  begin
    //����������� ������ �� �������� �������� ������ � ����������� �� � ���� ��������� ������ (���������)
    GR := DM1.GetGoodsData(lvGoods.Hint);

    with GR do
      begin
        editGoodsParent.Text := lvGoods.Hint + '. ' + gName;
        cbGoodsUnit.ItemIndex := cbGoodsUnit.IndexOf(DM1.GetUnitData(gUnit).uName);
        cbGoodsTax.ItemIndex := gTax;
        seGoodsDepartment.Value := gDepartment;
        cbGoodsPPR.ItemIndex := cbGoodsPPR.IndexOf(DM1.GetPPRData(gPPR).pprName);
        cbGoodsType.ItemIndex := gType;
        cbGoodsFractional.ItemIndex := Integer(gFractional);
        cbGoodsUnloadInScales.ItemIndex := Integer(gUnloadInScales);
        cbGoodsQuantityRequest.ItemIndex := Integer(gQuantityRequest);
        cbGoodsPriceRequest.ItemIndex := Integer(gPriceRequest);
      end;
    end
  else
    begin
      //����������� �������� ��-��������� ���� ������ ��������
      editGoodsParent.Text := '';
      seGoodsDepartment.Value := 0;
      cbGoodsUnit.ItemIndex := cbGoodsUnit.IndexOf('�����');
      cbGoodsTax.ItemIndex := 0;
      cbGoodsPPR.ItemIndex := cbGoodsPPR.IndexOf('�����');
      cbGoodsType.ItemIndex := 0;
      cbGoodsFractional.ItemIndex := 0;
      cbGoodsUnloadInScales.ItemIndex := 0;
      cbGoodsQuantityRequest.ItemIndex := 0;
      cbGoodsPriceRequest.ItemIndex := 0;
    end;

  pcGoods.ActivePageIndex := 2;
end;

//�������� ������ �������
procedure TframeGoodsBase.btnAddGoodsGroupClick(Sender: TObject);
var
  GR: TGoodsRecord;
begin
  imgGoodsGroup.Picture := nil;
  imgGoodsGroup.Hint := '';

  editGroupName.Text := '';
  editGroupCode.Text := '';

  if lvGoods.Hint <> '' then //� ����� �������� ��� �������� �������� ������; ���� �� ����, ������ �� � �����
    begin
      //����������� ������ �� �������� �������� ������ � ����������� �� � ���� �������� ������
      GR := DM1.GetGoodsData(lvGoods.Hint);

      with GR do
        begin
          editGroupParent.Text := lvGoods.Hint + '. ' + gName;
          cbGroupUnit.ItemIndex := cbGroupUnit.IndexOf(DM1.GetUnitData(gUnit).uName);
          cbGroupTax.ItemIndex := gTax;
          cbGroupPPR.ItemIndex := cbGroupPPR.IndexOf(DM1.GetPPRData(gPPR).pprName);
          cbGoodsType.ItemIndex := gType;
          cbGroupFractional.ItemIndex := Integer(gFractional);
          cbGroupUnloadInScales.ItemIndex := Integer(gUnloadInScales);
          cbGroupQuantityRequest.ItemIndex := Integer(gQuantityRequest);
          cbGroupPriceRequest.ItemIndex := Integer(gPriceRequest);
          seGroupDepartment.Value := gDepartment;
        end;

    end
  else
    begin
      //����������� �������� ��-���������
      editGroupParent.Text := '';
      seGroupDepartment.Value := 0;
      cbGroupUnit.ItemIndex := cbGroupUnit.IndexOf('�����');
      cbGroupTax.ItemIndex := 0;
      cbGroupPPR.ItemIndex := cbGroupPPR.IndexOf('�����');
      cbGroupType.ItemIndex := 0;
      cbGroupFractional.ItemIndex := 0;
      cbGroupUnloadInScales.ItemIndex := 0;
      cbGroupQuantityRequest.ItemIndex := 0;
      cbGroupPriceRequest.ItemIndex := 0;
    end;

  pcGoods.ActivePageIndex := 1;
end;

//�������� ��������\��������� ������
procedure TframeGoodsBase.btnCancelGoodsClick(Sender: TObject);
begin
  pcGoods.ActivePageIndex := 0
end;

//�������� ��������\��������� ������ �������
procedure TframeGoodsBase.btnCancelGoodsGroupClick(Sender: TObject);
begin
  pcGoods.ActivePageIndex := 0
end;

//��������� ����������� ������
procedure TframeGoodsBase.imgGoodsClick(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
  begin
    imgGoods.Picture.LoadFromFile(OpenPictureDialog1.FileName);
    imgGoods.Hint := OpenPictureDialog1.FileName; //���������� � hint ���� � ����� ��� ������������ ���������� � ��
  end;
end;

//������� ����������� ������
procedure TframeGoodsBase.btnClearGoodsImageClick(Sender: TObject);
begin
  imgGoods.Picture := nil;
  imgGoods.Hint := '';
end;

//������� ���������� ����� ��� �������� ������
procedure TframeGoodsBase.btnDeleteGoodsClick(Sender: TObject);
var
  SelectedItem, NewItem: TListItem;
  ParentIndex, i: Integer;
  GoodsData: TGoodsArray;
begin
  if not YesNoDialog('������� ��������� �������?', 0, False) then
    Exit;

  SelectedItem := lvGoods.Selected; //���������� ��������� �������

  if SelectedItem = nil then
    Exit;

  LockWindowUpdate(Handle); //��������� ����������� �����

  DM1.DeleteGoods(SelectedItem.SubItems[0]); //������� ����� ��� ������ �� ��

  if SelectedItem.StateIndex in [0, 2] then //���� �������� ������ ��� �����
    lvGoods.DeleteSelected
  else
  begin //���� ��������� �������� ������
    ParentIndex := SelectedItem.Index - 1; //������ ������������ ������

    if ParentIndex = -1 then //�������� ����������� (������)
    begin
      lvGoods.Clear;
      GoodsData := DM1.GetGoodsGroupChild('', False); //�������� ������ �������� ���������

      lvGoods.Hint := ''; //�������� ������ ���
    end else
    begin
      for i := lvGoods.Items.Count - 1 downto ParentIndex + 1 do //������� ��� ��������� �� ������������ ������� ��������
        lvGoods.Items[i].Delete;
      GoodsData := DM1.GetGoodsGroupChild(lvGoods.Items[ParentIndex].SubItems[0], False); //�������� ������ �������� ���������

      lvGoods.Hint := lvGoods.Items[ParentIndex].SubItems[0]; //���������� ��� �������� �������� ������
    end;

    for i := 0 to Length(GoodsData) - 1 do //��������� �������� �������� ������
    begin
      NewItem := lvGoods.Items.Add;
      NewItem.SubItems.Append(GoodsData[i].gCode); //���
      NewItem.SubItems.Append(GoodsData[i].gName); //������������

      if GoodsData[i].gIsGroup then
        NewItem.StateIndex := 0 //�������� ������
      else
      begin
        NewItem.StateIndex := 2; //�����
        NewItem.SubItems.Append(CurrToStrF(GoodsData[i].gPrice, ffFixed, 2)); //����
      end
    end;

    lvGoods.SortType := stBoth; //��������� ��������
    lvGoods.SortType := stNone;

    //�������� �������� ��������� ��������
    if (ParentIndex = -1) and (lvGoods.Items.Count > 0) then
      lvGoods.SelectItem(0)
    else
      lvGoods.SelectItem(ParentIndex);

  end;

  LockWindowUpdate(0);

end;

//�������� ������ � ������ ��� �������� ������
procedure TframeGoodsBase.btnEditGoodsClick(Sender: TObject);
var
  SelectedItem, NewItem: TListItem;
  GR: TGoodsRecord;
  i: Integer;
begin
  SelectedItem := lvGoods.Selected; //���������� ��������� �������

  if SelectedItem = nil then Exit;

  GR := DM1.GetGoodsData(SelectedItem.SubItems[0]); //����������� ������ �� �������� ����������� "������"

  if SelectedItem.StateIndex in [0, 1] then  //���� ������ �� ������
    begin
      if (GR.gPicture <> '') and FileExists(GR.gPicture) then
        begin
          imgGoodsGroup.Picture.LoadFromFile(GR.gPicture);
          imgGoodsGroup.Hint := GR.gPicture
        end;

      editGroupName.Text := GR.gName;
      editGroupCode.Text := SelectedItem.SubItems[0];
      if GR.gParent <> '' then
        editGroupParent.Text := GR.gParent + '. ' + DM1.GetGoodsData(GR.gParent).gName;
      cbGroupUnit.ItemIndex := cbGroupUnit.IndexOf(DM1.GetUnitData(GR.gUnit).uName);
      cbGroupTax.ItemIndex := GR.gTax;
      cbGroupPPR.ItemIndex := cbGroupPPR.IndexOf(DM1.GetPPRData(GR.gPPR).pprName);
      cbGroupType.ItemIndex := GR.gType;
      cbGroupFractional.ItemIndex := Integer(GR.gFractional);
      cbGroupUnloadInScales.ItemIndex := Integer(GR.gUnloadInScales);
      cbGroupQuantityRequest.ItemIndex := Integer(GR.gQuantityRequest);
      cbGroupPriceRequest.ItemIndex := Integer(GR.gPriceRequest);
      seGroupDepartment.Value := GR.gDepartment;

      pcGoods.ActivePageIndex := 1;
    end
  else
    begin //������ �� �����
      if (GR.gPicture <> '') and FileExists(GR.gPicture) then
        begin
          imgGoods.Picture.LoadFromFile(GR.gPicture);
          imgGoods.Hint := GR.gPicture;
        end;

      lvBarcodes.Clear; //������� ������� �� ��, ������� ����� �������� �� ����������� ������

      for i := 0 to Length(GR.gBarcodes) - 1 do
        begin
          NewItem := lvBarcodes.Items.Add;
          NewItem.Caption := GR.gBarcodes[i]
        end;

      editGoodsName.Text := GR.gName;
      editGoodsParent.Text := GR.gParent + '. ' + DM1.GetGoodsData(GR.gParent).gName;
      editGoodsCode.Text := SelectedItem.SubItems[0];
      editGoodsVendorcode.Text := GR.gVendorcode;
      cbGoodsUnit.ItemIndex := cbGoodsUnit.IndexOf(DM1.GetUnitData(GR.gUnit).uName);
      cbGoodsTax.ItemIndex := GR.gTax;
      cbGoodsPPR.ItemIndex := cbGoodsPPR.IndexOf(DM1.GetPPRData(GR.gPPR).pprName);
      cbGoodsType.ItemIndex := GR.gType;
      editGoodsPLU.Text := IntToStr(GR.gPLU);
      seGoodsPrice.Value := GR.gPrice;
      seGoodsDepartment.Value := GR.gDepartment;
      cbGoodsFractional.ItemIndex := Integer(GR.gFractional);
      cbGoodsUnloadInScales.ItemIndex := Integer(GR.gUnloadInScales);
      cbGoodsQuantityRequest.ItemIndex := Integer(GR.gQuantityRequest);
      cbGoodsPriceRequest.ItemIndex := Integer(GR.gPriceRequest);
      memoGoodsComposition.Text := GR.gComposition;

      pcGoods.ActivePageIndex := 2;
    end;
end;

//��������� ����������� ��� �������� ������
procedure TframeGoodsBase.imgGoodsGroupClick(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
  begin
    imgGoodsGroup.Picture.LoadFromFile(OpenPictureDialog1.FileName);
    imgGoodsGroup.Hint := OpenPictureDialog1.FileName;
  end;
end;

//��������� ������� �� �������� ����������� "������"
procedure TframeGoodsBase.lvGoodsClick(Sender: TObject);
var
  SelectedItem, NewItem: TListItem;
  GoodsData: TGoodsArray;
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

      GoodsData := DM1.GetGoodsGroupChild(SelectedItem.SubItems[0], False); //�������� ������ �������� ���������
    end else
    begin //���� ������ �������

      ParentIndex := SelectedItem.Index - 1; //������ ������������ ������

      if ParentIndex = -1 then //�������� ����������� (������)
      begin
        lvGoods.Clear;
        GoodsData := DM1.GetGoodsGroupChild('', False); //�������� ������ �������� ���������

        lvGoods.Hint := '';
      end else
      begin
        for i := lvGoods.Items.Count - 1 downto ParentIndex + 1 do //������� ��� ��������� �� ������������ ������� ��������
          lvGoods.Items[i].Delete;
        GoodsData := DM1.GetGoodsGroupChild(lvGoods.Items[ParentIndex].SubItems[0], False); //�������� ������ �������� ���������

        lvGoods.Hint := lvGoods.Items[ParentIndex].SubItems[0];
      end;

    end;

    for i := 0 to Length(GoodsData) - 1 do //��������� �������� �������� ������
    begin
      NewItem := lvGoods.Items.Add;
      NewItem.SubItems.Append(GoodsData[i].gCode); //���
      NewItem.SubItems.Append(GoodsData[i].gName); //������������

      if GoodsData[i].gIsGroup then
        NewItem.StateIndex := 0 //�������� ������
      else
      begin
        NewItem.StateIndex := 2; //�����
        NewItem.SubItems.Append(CurrToStrF(GoodsData[i].gPrice, ffFixed, 2)); //����
      end
    end;

    for i := 0 to lvGoods.Items.Count - 1 do //���������� ���������
      if lvGoods.Items[i].SubItems[0] = SelectedItemCode then
      begin
        lvGoods.SelectItem(i);
        Break
      end;

    lvGoods.SortType := stBoth; //��������� ��������
    lvGoods.SortType := stNone;

  end else
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
procedure TframeGoodsBase.lvGoodsCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
begin
{  if (Item1.StateIndex = 0) and (Item2.StateIndex = 2) then //���������� �������� ������ � �����
    Compare := -1 //����������� �������� ������ ����� �������
  else}
  if (Item1.StateIndex = 2) and (Item2.StateIndex = 0) then //���������� ����� � �������� ������
    Compare := 1 //����������� �������� ������ ����� �������
  else
  if ((Item1.StateIndex = 0) and (Item2.StateIndex = 0)) or ((Item1.StateIndex = 2) and (Item2.StateIndex = 2)) then //���� ������ � ��������� ��������
    Compare := AnsiCompareStr(Item1.SubItems[1], Item2.SubItems[1]) //��������� �� ��������
  else
    Compare := 0 //�� ���� ��������� ������� �� ������ ��������� ���������
end;

//������� ����������� �������� ������
procedure TframeGoodsBase.btnClearGoodsGroupImageClick(Sender: TObject);
begin
  imgGoodsGroup.Picture := nil;
  imgGoodsGroup.Hint := '';
end;

//������� ��������� �� ������
procedure TframeGoodsBase.btnBarcodeDeleteClick(Sender: TObject);
begin
  lvBarcodes.DeleteSelected
end;

//������������� ��
procedure TframeGoodsBase.btnBarcodeGenClick(Sender: TObject);
var
  bc: String;
begin
  bc := BarcodeGen('20', DM1.BarcodeGen);
  if bc <> '' then
    lvBarcodes.Items.Add.Caption := bc;
end;

// ������� �� ���������� ��
procedure TframeGoodsBase.BCScanerDataEvent(var scanerDataMessage: TScanerDataMessage);
var
  GA: TGoodsArray;
  SelectedCode: String;
begin
  if pcGoods.ActivePage = tsGoodsGroupData then
    Exit;

  GA := DM1.FindGoodsByBarcode(scanerDataMessage.LParam);

  if pcGoods.ActivePage = tsGoods then
    begin
      if Length(GA) = 1 then
        begin
          frameGoodsTable1.SelectGoods(GA[0].gCode);
        end
      else
      if Length(GA) > 1 then
        begin
          SelectedCode := GoodsSearchResultDlg(scanerDataMessage.LParam, 'barcode');
          if SelectedCode <> '' then
            begin
              frameGoodsTable1.SelectGoods(SelectedCode);
            end;
        end
      else
        YesNoDialog('����� �� ���������� ' + scanerDataMessage.LParam + ' �� ������!', 1, False);
    end
  else
  if pcGoods.ActivePage = tsGoodsData then
    begin
      if lvBarcodes.FindCaption(0, scanerDataMessage.LParam, False, True, False) <> nil then //����� �� ���� � �������� �������� ������
        Exit;

      if Length(GA) > 0 then
        begin
          if YesNoDialog('����� �������� ��� �������� ��� ������� ������ ������: ' + GA[0].gName + '. �������� ��������� �������� � �������� �������������� ������?', 0, False) then
              lvBarcodes.Items.Add.Caption := scanerDataMessage.LParam
        end
      else
        lvBarcodes.Items.Add.Caption := scanerDataMessage.LParam
    end;
end;

end.
