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
    procedure btnSaveGoodsClick(Sender: TObject); //сохранить товар
    procedure btnSaveGoodsGroupClick(Sender: TObject); //сохранить товарную группу
    procedure btnAddGoodsClick(Sender: TObject); //добавить товар
    procedure btnAddGoodsGroupClick(Sender: TObject); //добавить товарную группу
    procedure btnCancelGoodsClick(Sender: TObject); //отмена изменений данных о товаре
    procedure btnCancelGoodsGroupClick(Sender: TObject); //отмена изменений данных о товарной группе
    procedure imgGoodsClick(Sender: TObject); //выбор изображения для товара
    procedure btnClearGoodsImageClick(Sender: TObject); //убрать изображение товара
    procedure btnBarcodeDeleteClick(Sender: TObject); //удалить ШК товара
    procedure imgGoodsGroupClick(Sender: TObject); //выбрать изображение для товарной группы
    procedure btnClearGoodsGroupImageClick(Sender: TObject); //убрать изображение товарной группы
    procedure lvGoodsClick(Sender: TObject); //обработка нажатия на товар или товарную группу
    procedure timerInitTimer(Sender: TObject); //инициализация данных фрейма
    procedure btnEditGoodsClick(Sender: TObject); //редактировать товар или товарную группу
    procedure lvGoodsCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer); //сортировка таблицы товаров
    procedure btnDeleteGoodsClick(Sender: TObject); //удалить товар или товарную группу
    procedure btnSelectGroupParentClick(Sender: TObject); //выбор родителя для товарной группы
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

// инициализация фрейма
procedure TframeGoodsBase.timerInitTimer(Sender: TObject);
var
  sl: TStringList;
begin
  timerInit.Enabled := False; // т.к. должно сработать один раз при создании фрейма

  lvGoods := frameGoodsTable1.lvGoods;

  // заполняем комбобоксы на вкладках с информацией о товаре и товарной группе
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

//выбрать родительскую группу для товара
procedure TframeGoodsBase.btnSelectGoodsParentClick(Sender: TObject);
var
  prnt: String;
begin
  prnt := SelectParentDlg; //диалог выбора родителя
  if prnt <> '' then
    editGoodsParent.Text := prnt
end;

//выбрать родительскую группу для группы
procedure TframeGoodsBase.btnSelectGroupParentClick(Sender: TObject);
var
  prnt: String;
begin
  prnt := SelectParentDlg; //диалог выбора родительской товарной группы
  if prnt <> '' then
    editGroupParent.Text := prnt
end;

//прокрутить на одну страницу вверх
procedure TframeGoodsBase.btnUpClick(Sender: TObject);
begin
  LVScrollPage(lvGoods, True);
end;

//прокрутить на одну страницу вниз
procedure TframeGoodsBase.btnDownClick(Sender: TObject);
begin
  LVScrollPage(lvGoods, False);
end;

//изменение ширины и положения кнопок на панелях
procedure TframeGoodsBase.PanelResize(Sender: TObject);
begin
  AlignPanelControls(Sender as TsPanel)
end;

//сохранить товар
procedure TframeGoodsBase.btnSaveGoodsClick(Sender: TObject);
var
  GR: TGoodsRecord;
  i: Integer;
  NewItem: TListItem;
  newCode: String;
begin
  //заполняем структуру данными из полей ввода
  with GR do
    begin
      gCode := editGoodsCode.Text;
      gIsGroup := False;
      gName := editGoodsName.Text;
      if editGoodsParent.Text = '' then
        gParent := ''
      else
        gParent := Copy(editGoodsParent.Text, 1, Pos('.', editGoodsParent.Text) - 1); //т.к. родитель в формате "Код. Наименование", а нам нужен только код
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

  //сохраням товар в БД, в ответ получая код вновь созданного товара (или существующего, если это редактирование)
  newCode := DM1.SaveGoods(GR);

  //меняем данные товара в таблице или добавляем новый
  if editGoodsCode.Text <> '' then //старый товар
    begin
      lvGoods.Items[lvGoods.ItemIndex].SubItems[1] := editGoodsName.Text;
      lvGoods.Items[lvGoods.ItemIndex].SubItems[2] := CurrToStrF(seGoodsPrice.Value, ffFixed, 2);
    end
  else //новый товар
    begin
      NewItem := lvGoods.Items.Add;
      NewItem.StateIndex := 2;
      NewItem.SubItems.Append(newCode);
      NewItem.SubItems.Append(editGoodsName.Text);
      NewItem.SubItems.Append(CurrToStrF(seGoodsPrice.Value, ffFixed, 2));
    end;

  lvGoods.SortType := stBoth; //сортируем элементы
  lvGoods.SortType := stNone;

  pcGoods.ActivePageIndex := 0
end;

//сохранить товарную группу
procedure TframeGoodsBase.btnSaveGoodsGroupClick(Sender: TObject);
var
  GR: TGoodsRecord;
  NewItem: TListItem;
  newCode: String;
begin
  //заполняем структуру данными из полей ввода
  with GR do
    begin
      gCode := editGroupCode.Text;
      gIsGroup := True;
      gName := editGroupName.Text;
      if editGroupParent.Text = '' then
        gParent := ''
      else
        gParent := Copy(editGroupParent.Text, 1, Pos('.', editGroupParent.Text) - 1); //т.к. родитель в формате "Код. Наименование", а нам нужен только код
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

  //сохраням товарную группу в БД, в ответ получая код вновь созданной товарной группы (или существующей, если это редактирование)
  newCode := DM1.SaveGoods(GR);

  // меняем данные товарной группы в таблице или добавляем новую
  if editGroupCode.Text <> '' then // старая группа
    begin
      lvGoods.Items[lvGoods.ItemIndex].SubItems[1] := editGroupName.Text;
    end
  else //новая группа
    begin
      NewItem := lvGoods.Items.Add;
      NewItem.StateIndex := 0;
      NewItem.SubItems.Append(newCode);
      NewItem.SubItems.Append(editGroupName.Text);
    end;

  lvGoods.SortType := stBoth; //сортируем элементы
  lvGoods.SortType := stNone;

  pcGoods.ActivePageIndex := 0
end;

//добавить товар
procedure TframeGoodsBase.btnAddGoodsClick(Sender: TObject);
var
  GR: TGoodsRecord;
begin
  //очищаем поля ввода от предыдущих данных
  editGoodsName.Text := '';
  editGoodsCode.Text := '';
  editGoodsVendorcode.Text := '';
  editGoodsPLU.Text := '';
  seGoodsPrice.Value := 0.00;
  memoGoodsComposition.Text := '';

  imgGoods.Picture := nil;

  lvBarcodes.Clear;

  if lvGoods.Hint <> '' then //в хинте хранится код открытой товарной группы; если он пуст, значит мы в корне
  begin
    //запрашиваем данные об открытой товарной группе и проставляем их в поля дочернего товара (наследуем)
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
      //проставляем значения по-умолчанию если группа корневая
      editGoodsParent.Text := '';
      seGoodsDepartment.Value := 0;
      cbGoodsUnit.ItemIndex := cbGoodsUnit.IndexOf('Штука');
      cbGoodsTax.ItemIndex := 0;
      cbGoodsPPR.ItemIndex := cbGoodsPPR.IndexOf('Товар');
      cbGoodsType.ItemIndex := 0;
      cbGoodsFractional.ItemIndex := 0;
      cbGoodsUnloadInScales.ItemIndex := 0;
      cbGoodsQuantityRequest.ItemIndex := 0;
      cbGoodsPriceRequest.ItemIndex := 0;
    end;

  pcGoods.ActivePageIndex := 2;
end;

//добавить группу товаров
procedure TframeGoodsBase.btnAddGoodsGroupClick(Sender: TObject);
var
  GR: TGoodsRecord;
begin
  imgGoodsGroup.Picture := nil;
  imgGoodsGroup.Hint := '';

  editGroupName.Text := '';
  editGroupCode.Text := '';

  if lvGoods.Hint <> '' then //в хинте хранится код открытой товарной группы; если он пуст, значит мы в корне
    begin
      //запрашиваем данные об открытой товарной группе и проставляем их в поля дочерней группы
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
      //проставляем значения по-умолчанию
      editGroupParent.Text := '';
      seGroupDepartment.Value := 0;
      cbGroupUnit.ItemIndex := cbGroupUnit.IndexOf('Штука');
      cbGroupTax.ItemIndex := 0;
      cbGroupPPR.ItemIndex := cbGroupPPR.IndexOf('Товар');
      cbGroupType.ItemIndex := 0;
      cbGroupFractional.ItemIndex := 0;
      cbGroupUnloadInScales.ItemIndex := 0;
      cbGroupQuantityRequest.ItemIndex := 0;
      cbGroupPriceRequest.ItemIndex := 0;
    end;

  pcGoods.ActivePageIndex := 1;
end;

//отменить создание\изменение товара
procedure TframeGoodsBase.btnCancelGoodsClick(Sender: TObject);
begin
  pcGoods.ActivePageIndex := 0
end;

//отменить создание\изменение группы товаров
procedure TframeGoodsBase.btnCancelGoodsGroupClick(Sender: TObject);
begin
  pcGoods.ActivePageIndex := 0
end;

//указываем изображение товара
procedure TframeGoodsBase.imgGoodsClick(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
  begin
    imgGoods.Picture.LoadFromFile(OpenPictureDialog1.FileName);
    imgGoods.Hint := OpenPictureDialog1.FileName; //записываем в hint путь к файлу для последующего сохранения в БД
  end;
end;

//убираем изображение товара
procedure TframeGoodsBase.btnClearGoodsImageClick(Sender: TObject);
begin
  imgGoods.Picture := nil;
  imgGoods.Hint := '';
end;

//удалить выделенный товар или товарную группу
procedure TframeGoodsBase.btnDeleteGoodsClick(Sender: TObject);
var
  SelectedItem, NewItem: TListItem;
  ParentIndex, i: Integer;
  GoodsData: TGoodsArray;
begin
  if not YesNoDialog('Удалить выбранный элемент?', 0, False) then
    Exit;

  SelectedItem := lvGoods.Selected; //запоминаем выбранный элемент

  if SelectedItem = nil then
    Exit;

  LockWindowUpdate(Handle); //отключаем перерисовку формы

  DM1.DeleteGoods(SelectedItem.SubItems[0]); //удаляем товар или группу из БД

  if SelectedItem.StateIndex in [0, 2] then //если закрытая группа или товар
    lvGoods.DeleteSelected
  else
  begin //если удаляется открытая группа
    ParentIndex := SelectedItem.Index - 1; //индекс родительской группы

    if ParentIndex = -1 then //родитель отсутствует (корень)
    begin
      lvGoods.Clear;
      GoodsData := DM1.GetGoodsGroupChild('', False); //получаем список дочерних элементов

      lvGoods.Hint := ''; //открытой группы нет
    end else
    begin
      for i := lvGoods.Items.Count - 1 downto ParentIndex + 1 do //удаляем все следующие за родительской группой элементы
        lvGoods.Items[i].Delete;
      GoodsData := DM1.GetGoodsGroupChild(lvGoods.Items[ParentIndex].SubItems[0], False); //получаем список дочерних элементов

      lvGoods.Hint := lvGoods.Items[ParentIndex].SubItems[0]; //запоминаем код открытой товарной группы
    end;

    for i := 0 to Length(GoodsData) - 1 do //добавляем дочерние элементы группы
    begin
      NewItem := lvGoods.Items.Add;
      NewItem.SubItems.Append(GoodsData[i].gCode); //код
      NewItem.SubItems.Append(GoodsData[i].gName); //наименование

      if GoodsData[i].gIsGroup then
        NewItem.StateIndex := 0 //закрытая группа
      else
      begin
        NewItem.StateIndex := 2; //товар
        NewItem.SubItems.Append(CurrToStrF(GoodsData[i].gPrice, ffFixed, 2)); //цена
      end
    end;

    lvGoods.SortType := stBoth; //сортируем элементы
    lvGoods.SortType := stNone;

    //выделяем родителя удалённого элемента
    if (ParentIndex = -1) and (lvGoods.Items.Count > 0) then
      lvGoods.SelectItem(0)
    else
      lvGoods.SelectItem(ParentIndex);

  end;

  LockWindowUpdate(0);

end;

//изменить данные о товаре или товарной группе
procedure TframeGoodsBase.btnEditGoodsClick(Sender: TObject);
var
  SelectedItem, NewItem: TListItem;
  GR: TGoodsRecord;
  i: Integer;
begin
  SelectedItem := lvGoods.Selected; //запоминаем выбранный элемент

  if SelectedItem = nil then Exit;

  GR := DM1.GetGoodsData(SelectedItem.SubItems[0]); //запрашиваем данные об элементе справочника "товары"

  if SelectedItem.StateIndex in [0, 1] then  //если нажали на группу
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
    begin //нажали на товар
      if (GR.gPicture <> '') and FileExists(GR.gPicture) then
        begin
          imgGoods.Picture.LoadFromFile(GR.gPicture);
          imgGoods.Hint := GR.gPicture;
        end;

      lvBarcodes.Clear; //очищаем таблицу от ШК, которые могли остаться от предыдущего товара

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

//указываем изображение для товарной группы
procedure TframeGoodsBase.imgGoodsGroupClick(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
  begin
    imgGoodsGroup.Picture.LoadFromFile(OpenPictureDialog1.FileName);
    imgGoodsGroup.Hint := OpenPictureDialog1.FileName;
  end;
end;

//обработка нажатия на элементе справочника "Товары"
procedure TframeGoodsBase.lvGoodsClick(Sender: TObject);
var
  SelectedItem, NewItem: TListItem;
  GoodsData: TGoodsArray;
  i, ParentIndex: Integer;
  SelectedItemCode: String;
begin

  SelectedItem := lvGoods.Selected; //запоминаем выбранный элемент

  if SelectedItem = nil then //если нажали в пустоту
    Exit;

  lvGoods.Items.BeginUpdate; //отключаем перерисовку компонента

  SelectedItemCode := SelectedItem.SubItems[0]; //запоминаем код выбранного элемента

  if SelectedItem.StateIndex in [0, 1] then //если нажали на группу
  begin
    if SelectedItem.StateIndex = 0 then //если группа закрыта
    begin

      SelectedItem.StateIndex := 1; //меняем статус группы на "открыта"

      lvGoods.Hint := SelectedItem.SubItems[0]; //запоминаем в hint код открытой группы, для того чтобы знать куда записывать новые элементы справочника

        for i := lvGoods.Items.Count - 1 downto 0 do
          if lvGoods.Items[i].StateIndex <> 1 then
            lvGoods.Items[i].Delete; //удаляем из списка все закрытые группы и товары

      GoodsData := DM1.GetGoodsGroupChild(SelectedItem.SubItems[0], False); //получаем список дочерних элементов
    end else
    begin //если группа открыта

      ParentIndex := SelectedItem.Index - 1; //индекс родительской группы

      if ParentIndex = -1 then //родитель отсутствует (корень)
      begin
        lvGoods.Clear;
        GoodsData := DM1.GetGoodsGroupChild('', False); //получаем список дочерних элементов

        lvGoods.Hint := '';
      end else
      begin
        for i := lvGoods.Items.Count - 1 downto ParentIndex + 1 do //удаляем все следующие за родительской группой элементы
          lvGoods.Items[i].Delete;
        GoodsData := DM1.GetGoodsGroupChild(lvGoods.Items[ParentIndex].SubItems[0], False); //получаем список дочерних элементов

        lvGoods.Hint := lvGoods.Items[ParentIndex].SubItems[0];
      end;

    end;

    for i := 0 to Length(GoodsData) - 1 do //добавляем дочерние элементы группы
    begin
      NewItem := lvGoods.Items.Add;
      NewItem.SubItems.Append(GoodsData[i].gCode); //код
      NewItem.SubItems.Append(GoodsData[i].gName); //наименование

      if GoodsData[i].gIsGroup then
        NewItem.StateIndex := 0 //закрытая группа
      else
      begin
        NewItem.StateIndex := 2; //товар
        NewItem.SubItems.Append(CurrToStrF(GoodsData[i].gPrice, ffFixed, 2)); //цена
      end
    end;

    for i := 0 to lvGoods.Items.Count - 1 do //возвращаем выделение
      if lvGoods.Items[i].SubItems[0] = SelectedItemCode then
      begin
        lvGoods.SelectItem(i);
        Break
      end;

    lvGoods.SortType := stBoth; //сортируем элементы
    lvGoods.SortType := stNone;

  end else
  begin //если нажали на товар
    //добавить товар в чек
  end;

  lvGoods.Items.EndUpdate;

end;

//сортировка товаров
{Параметр Compare может иметь три значения: 1, -1 или 0.
 Единица означает, что первый элемент больше (или должен быть размещён после) второго элемента.
 Минус одни означает, что первый элемент меньше чем (или должен быть размещён перед) второй элемент.
 Ноль означает, что два элемента равны.}
procedure TframeGoodsBase.lvGoodsCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
begin
{  if (Item1.StateIndex = 0) and (Item2.StateIndex = 2) then //сравниваем закрытую группу и товар
    Compare := -1 //располагаем закрытую группу перед товаром
  else}
  if (Item1.StateIndex = 2) and (Item2.StateIndex = 0) then //сравниваем товар и закрытую группу
    Compare := 1 //располагаем закрытую группу перед товаром
  else
  if ((Item1.StateIndex = 0) and (Item2.StateIndex = 0)) or ((Item1.StateIndex = 2) and (Item2.StateIndex = 2)) then //если статус у элементов одинаков
    Compare := AnsiCompareStr(Item1.SubItems[1], Item2.SubItems[1]) //сортируем по алфавиту
  else
    Compare := 0 //во всех остальных случаях не меняем положения элементов
end;

//убираем изображение товарной группы
procedure TframeGoodsBase.btnClearGoodsGroupImageClick(Sender: TObject);
begin
  imgGoodsGroup.Picture := nil;
  imgGoodsGroup.Hint := '';
end;

//удалить выбранный ШК товара
procedure TframeGoodsBase.btnBarcodeDeleteClick(Sender: TObject);
begin
  lvBarcodes.DeleteSelected
end;

//сгенерировать ШК
procedure TframeGoodsBase.btnBarcodeGenClick(Sender: TObject);
var
  bc: String;
begin
  bc := BarcodeGen('20', DM1.BarcodeGen);
  if bc <> '' then
    lvBarcodes.Items.Add.Caption := bc;
end;

// событие по считыванию ШК
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
        YesNoDialog('Товар со штрихкодом ' + scanerDataMessage.LParam + ' не найден!', 1, False);
    end
  else
  if pcGoods.ActivePage = tsGoodsData then
    begin
      if lvBarcodes.FindCaption(0, scanerDataMessage.LParam, False, True, False) <> nil then //такой ШК есть в карточке текущего товара
        Exit;

      if Length(GA) > 0 then
        begin
          if YesNoDialog('Такой штрихкод уже присвоен как минимум одному товару: ' + GA[0].gName + '. Добавить считанный штрихкод в карточку редактируемого товара?', 0, False) then
              lvBarcodes.Items.Add.Caption := scanerDataMessage.LParam
        end
      else
        lvBarcodes.Items.Add.Caption := scanerDataMessage.LParam
    end;
end;

end.
