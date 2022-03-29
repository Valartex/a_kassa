unit TradeUnit_i;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.StrUtils, System.Variants, System.Classes,
  System.Types, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sComboBox,
  Vcl.Buttons, sSpeedButton, Vcl.ComCtrls, sPageControl, sListView, sEdit,
  sLabel, Vcl.ExtCtrls, sPanel, System.Math, System.DateUtils,
  Vcl.OleCtrls, DBUnit, CommonUnit;

type

  TframeTrade = class(TFrame)
    sPanel1: TsPanel;
    lvWares: TsListView;
    sPanel2: TsPanel;
    btn7: TsSpeedButton;
    btn8: TsSpeedButton;
    btn9: TsSpeedButton;
    btn0: TsSpeedButton;
    btn4: TsSpeedButton;
    btn5: TsSpeedButton;
    btn6: TsSpeedButton;
    btnSeparator: TsSpeedButton;
    btn3: TsSpeedButton;
    btn2: TsSpeedButton;
    btn1: TsSpeedButton;
    btnC: TsSpeedButton;
    btnCancelDiscount: TsSpeedButton;
    btnCheqCopy: TsSpeedButton;
    btnCheqCancel: TsSpeedButton;
    btnCheqDiscount: TsSpeedButton;
    btnPosDiscount: TsSpeedButton;
    btnOpenCashbox: TsSpeedButton;
    btnCashboxSum: TsSpeedButton;
    btnCloseCheq: TsSpeedButton;
    sPanel3: TsPanel;
    sPanel4: TsPanel;
    sPanel5: TsPanel;
    sPanel6: TsPanel;
    labelTotalSum: TsLabel;
    labelInitialSum: TsLabel;
    labelCheqDiscount: TsLabel;
    editMain: TsEdit;
    sPanel9: TsPanel;
    sPanel10: TsPanel;
    sPanel11: TsPanel;
    sPanel12: TsPanel;
    labelChange: TsLabel;
    btnPayCash: TsSpeedButton;
    btnPayCard: TsSpeedButton;
    sPanel13: TsPanel;
    sPanel7: TsPanel;
    sPanel8: TsPanel;
    labelReceiptNumber: TsLabel;
    btnSelectCheqType: TsSpeedButton;
    sLabel3: TsLabel;
    btnCode: TsSpeedButton;
    btnVendorcode: TsSpeedButton;
    btnBarcode: TsSpeedButton;
    btnPrice: TsSpeedButton;
    sLabel6: TsLabel;
    sLabel8: TsLabel;
    sLabel9: TsLabel;
    btnRestoreDoc: TsSpeedButton;
    btnPersonalDiscount: TsSpeedButton;
    btnDigitalCopy: TsSpeedButton;
    sPanel14: TsPanel;
    btnQuantityPlus: TsSpeedButton;
    btnQuantityMinus: TsSpeedButton;
    btnQuantitySet: TsSpeedButton;
    btnDelPos: TsSpeedButton;
    btnPriceSet: TsSpeedButton;
    btnBS: TsSpeedButton;
    btnX: TsSpeedButton;
    panelDigitalCopy: TsPanel;
    btn00: TsSpeedButton;
    btn000: TsSpeedButton;
    btnGoods: TsSpeedButton;
    btnUp: TsSpeedButton;
    btnDown: TsSpeedButton;
    btnCashIn: TsSpeedButton;
    btnCashOut: TsSpeedButton;
    sPanel15: TsPanel;
    timerOFD: TTimer;
    labelOFDStatus: TsLabel;
    procedure NumericButtonClick(Sender: TObject);
    procedure btnSeparatorClick(Sender: TObject);
    procedure btnCClick(Sender: TObject);
    procedure btnCloseCheqClick(Sender: TObject);
    procedure btnZReportClick(Sender: TObject);
    procedure PanelResize(Sender: TObject);
    procedure btnDigitalCopyClick(Sender: TObject);
    procedure btnQuantityPlusClick(Sender: TObject);
    procedure btnQuantityMinusClick(Sender: TObject);
    procedure btnDelPosClick(Sender: TObject);
    procedure btnQuantitySetClick(Sender: TObject);
    procedure btnPriceSetClick(Sender: TObject);
    procedure btnBSClick(Sender: TObject);
    procedure btnXClick(Sender: TObject);
    procedure btnPayCashClick(Sender: TObject);
    procedure btnCheqCancelClick(Sender: TObject);
    procedure btn00Click(Sender: TObject);
    procedure btnCheqCopyClick(Sender: TObject);
    procedure btnCodeClick(Sender: TObject);
    procedure btnVendorcodeClick(Sender: TObject);
    procedure btnPriceClick(Sender: TObject);
    procedure btnBarcodeClick(Sender: TObject);
    procedure btnCheqDiscountClick(Sender: TObject);
    procedure btnCancelDiscountClick(Sender: TObject);
    procedure btnPosDiscountClick(Sender: TObject);
    procedure btnGoodsClick(Sender: TObject);
    procedure btnSelectCheqTypeClick(Sender: TObject);
    procedure btnUpClick(Sender: TObject);
    procedure btnDownClick(Sender: TObject);
    procedure btnRestoreDocClick(Sender: TObject);
    procedure btnOpenCashboxClick(Sender: TObject);
    procedure btnCashboxSumClick(Sender: TObject);
    procedure FrameEnter(Sender: TObject);
    procedure FrameExit(Sender: TObject);
    procedure btnPayCardClick(Sender: TObject);
    procedure btnCashOutClick(Sender: TObject);
    procedure btnCashInClick(Sender: TObject);
    procedure timerOFDTimer(Sender: TObject);
    procedure btnPersonalDiscountClick(Sender: TObject);
  private
    roundSum: Currency; // сумма округления
    arrayOfMarks: TStringDynArray; //массив марок чека
    procedure AddGoodsToCheq(goodsCode, goodsName: String; goodsPrice: Currency; goodsQuantity: Real); // добавление позиции в чек
    procedure RecalcCheq; // при изменении списка товаров
    procedure ChangeCalculation; // расчёт сдачи
    procedure ChangeCheqType(CheqType: String); // действия при смене типа чека
    procedure ClearReceipt; // очистка всех полей в чеке
    procedure BCScanerDataEvent(var scanerDataMessage: TScanerDataMessage); message WM_ScanerData;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses YesNoUnit, SelectCheqTypeUnit, DocumentsUnit,
  CorrectionInfoUnit, FRDriverUnit;

procedure TframeTrade.BCScanerDataEvent(var scanerDataMessage: TScanerDataMessage);
var
  goodsArray: TGoodsArray;
  SelectedCode: String;
begin
  goodsArray := DM1.FindGoodsByBarcode(scanerDataMessage.LParam);

  if Length(goodsArray) > 1 then
    begin
      SelectedCode := GoodsSearchResultDlg(scanerDataMessage.LParam, 'barcode');

      if SelectedCode <> '' then
        AddGoodsToCheq(SelectedCode, '', 0, 1);
    end
  else
    if Length(goodsArray) = 1 then
      AddGoodsToCheq(goodsArray[0].gCode, '', 0, 1)
    else
      YesNoDialog('Товар со штрихкодом ' + scanerDataMessage.LParam + ' не найден.', 1, False);

  inherited
end;

procedure TframeTrade.btnPersonalDiscountClick(Sender: TObject);
begin
  AddGoodsToCheq('72850', '', 0, 1);
end;


//изменение ширины и положения кнопок на панелях
procedure TframeTrade.PanelResize(Sender: TObject);
begin
  AlignPanelControls(Sender as TsPanel) //изменение ширины и положения кнопок на панелях
end;

//при изменении списка товаров
procedure TframeTrade.RecalcCheq;
var
  i: Integer;
  PosInitialSum, PosSum, PosDiscount, TotalSum, InitialSum, CheqDiscount: Currency;
  CommonSettings: TCommonSettingsRecord;
begin
  InitialSum := 0;
  TotalSum := 0;

  CommonSettings := DM1.GetCommonSettings; //запрос общих настроек

  for i := 0 to lvWares.Items.Count - 1 do
  begin
    PosDiscount := StrToCurrDef(lvWares.Items[i].SubItems[3], 0); //скидка на позицию
    PosInitialSum := StrToCurr(lvWares.Items[i].SubItems[1]) * StrToCurr(lvWares.Items[i].SubItems[2]); //сумма позиции без скидки
    PosSum := PosInitialSum - PosInitialSum * PosDiscount / 100; //сумма позиции с учётом скидки
    lvWares.Items[i].SubItems[4] := CurrToStrF(PosSum, ffFixed, 2);

    InitialSum := InitialSum + PosInitialSum; //сумма чека без скидок и округления
    TotalSum := TotalSum + PosSum; //конечная сумма чека
  end;

  roundSum := TotalSum; //запоминаем сумму чека без округления

  //округление
  if CommonSettings.roundMethod > 0 then
  begin
    TotalSum := RoundToEx(TotalSum, CommonSettings.roundPrecision, CommonSettings.roundMethod);
    roundSum := TotalSum - roundSum; //сумма округления
  end;

  if InitialSum <> 0 then
    CheqDiscount := 100 - TotalSum / InitialSum * 100 //вычисляем итоговую скидку на чек
  else
    CheqDiscount := 0;

  labelInitialSum.Caption := CurrToStrF(InitialSum, ffFixed, 2); //отображаем сумму чека без скидок
  labelTotalSum.Caption := CurrToStrF(TotalSum, ffFixed, 2); //отбражаем конечную сумму чека
  labelCheqDiscount.Caption := CurrToStrF(CheqDiscount, ffFixed, 2); //отбражаем итоговую скидку на чек

  ChangeCalculation;
end;

// обработка считанного ШК
//procedure TframeTrade.BCScanerDataEvent(Sender: TObject);
//var
//  goodsArray: TGoodsArray;
//  SelectedCode: String;
//begin
//  goodsArray := DM1.FindGoodsByBarcode(bcScaner.ScanData);
//
//  if Length(goodsArray) > 1 then
//    begin
//      SelectedCode := GoodsSearchResultDlg(bcScaner.ScanData, 'barcode');
//
//      if SelectedCode <> '' then
//        begin
//          addedGoodsCode := SelectedCode;
////          timerAddToCheq.Enabled := True; // извращение с таймером нужно для выхода из процедуры, иначе сканер не работает в окне считывания марки, т.к. новый объект драйвера создаётся вовремя обработки данных от другого объекта драйвера
//          AddGoodsToCheq(SelectedCode, '', 0, 1);
//        end;
//    end
//  else
//    if Length(goodsArray) = 1 then
//      begin
//        addedGoodsCode := goodsArray[0].gCode;
////        timerAddToCheq.Enabled := True;
//        AddGoodsToCheq(goodsArray[0].gCode, '', 0, 1)
//      end
//    else
//      YesNoDialog('Товар со штрихкодом ' + bcScaner.ScanData + ' не найден.', 1, False)
//end;

//открыть ДЯ
procedure TframeTrade.btnOpenCashboxClick(Sender: TObject);
begin
  frDriver.OpenDrawer
end;

// восстановить отмененный
procedure TframeTrade.btnRestoreDocClick(Sender: TObject);
var
  ReceiptID: Integer;
  Receipt  : TReceiptAllDataRecord;
  i        : Integer;
  LI       : TListItem;
begin
  // отменяем текущий чек, если он есть
  frDriver.CancelReceipt;
  ClearReceipt;

  // открываем форму выбора чека
  formDocuments        := TformDocuments.Create(Self);
  formDocuments.Status := 2;
  formDocuments.ShowModal;
  ReceiptID            := formDocuments.SelectedCode;
  formDocuments.Free;

  if ReceiptID <= 0 then
    Exit;

  Receipt := DM1.GetReceipt(ReceiptID); // запрашиваем информацию по выбранному чеку

  // заполняем продажную форму данными о чеке

  // общая информация о чеке
  btnSelectCheqType.Caption  := DM1.InternalCodeToReceiptType(Receipt.receiptRecord.receiptType); // тип чека
  labelReceiptNumber.Caption := IntToStr(Receipt.receiptRecord.receiptID);                        // номер чека
  labelCheqDiscount.Caption  := CurrToStrF(Receipt.receiptRecord.receiptDiscount, ffFixed, 2);    // скидка на чек
  labelTotalSum.Caption      := CurrToStrF(Receipt.receiptRecord.receiptSumm, ffFixed, 2);        // конечная сумма чека
  // сумма чека без скидки
  if Receipt.receiptRecord.receiptDiscount <> 0 then
    labelInitialSum.Caption := CurrToStrF(100 * Receipt.receiptRecord.receiptSumm / Receipt.receiptRecord.receiptDiscount, ffFixed, 2)
  else
    labelInitialSum.Caption := labelTotalSum.Caption;
  panelDigitalCopy.Caption  := Receipt.receiptRecord.receiptContact; // контакт клиента для отправки электронной копии чека

  // позиции чека
  for i := 0 to Length(Receipt.receiptPosArray) - 1 do
    with Receipt.receiptPosArray[i] do
      begin
        LI         := lvWares.Items.Add;
        LI.Caption := rpGoodsCode;
        LI.SubItems.Add(rpGoodsName);
        LI.SubItems.Add(CurrToStrF(rpPrice, ffFixed, 2));
        LI.SubItems.Add(CurrToStrF(rpQuantity, ffFixed, 2));
        LI.SubItems.Add(CurrToStrF(rpDiscount, ffFixed, 2));
        LI.SubItems.Add(CurrToStrF(rpSumm, ffFixed, 2));
      end;

  // оплаты
  btnPayCash.Caption  := CurrToStrF(Receipt.receiptPaymentsArray[0].rpValue, ffFixed, 2);
  btnPayCard.Caption  := CurrToStrF(Receipt.receiptPaymentsArray[1].rpValue, ffFixed, 2);
  labelChange.Caption := CurrToStrF(Receipt.receiptPaymentsArray[0].rpValue + Receipt.receiptPaymentsArray[1].rpValue - Receipt.receiptRecord.receiptSumm, ffFixed, 2);
end;

// добавление позиции в чек
procedure TframeTrade.AddGoodsToCheq(goodsCode, goodsName: String; goodsPrice: Currency; goodsQuantity: Real);
var
  LI: TListItem;
  i: Integer;
  mark: String;
  added: Boolean;
  summ: Currency;
  discount: Real;
  Goods: TGoodsRecord;
begin
  added := False;

  Goods := DM1.GetGoodsData(goodsCode);

  // если это маркированный товар
  if Goods.gType > 0 then
    begin
//          if scanerSettings.sStatus then
      mark := GetMarkDialog(arrayOfMarks, Goods.gType); // запрос марки
      if mark = '' then // если марка не считана, то не добавляем товар в чек
        Exit
//          else
//            YesNoDialog('Марка не может быть считана, т.к. сканер штрихкодов не включён в настройках.' + #13#10 +
//                        '(Настройки -> Оборудование -> Сканер ШК).', 1, False)
    end
  else
    // проверяем нет ли уже в чеке такой позиции; если есть, то объединяем
    for i := 0 to lvWares.Items.Count - 1 do
      if lvWares.Items[i].Caption = goodsCode then
        begin
          LI := lvWares.Items[i];
          LI.SubItems[2] := FloatToStr(StrToFloat(LI.SubItems[2]) + goodsQuantity); //количество

          added := True;
          Break
        end;

  // если позиции с таким же кодом нет или это маркированный товар, то добавляем новую позицию в чек
  if not added then
    begin
      LI := lvWares.Items.Add;
      LI.Caption := goodsCode;
      LI.SubItems.Add(Goods.gName);
      LI.SubItems.Add(CurrToStrF(Goods.gPrice, ffFixed, 2));
      LI.SubItems.Add(FloatToStr(goodsQuantity));
      LI.SubItems.Add('');
      LI.SubItems.Add(CurrToStrF(Goods.gPrice * goodsQuantity, ffFixed, 2));
      // сохраняем марку даже если это не маркированный товар. это нужно для сопостовления индекса позиции и марки
      SetLength(arrayOfMarks, Length(arrayOfMarks) + 1);
      arrayOfMarks[Length(arrayOfMarks) - 1] := mark
    end;

  LI.Selected := True;   // выделяем добавленную позицию
  LI.MakeVisible(False); // прокручиваем список до этой позиции, если она была за пределами видимости
  editMain.Clear;

  RecalcCheq;
end;

//кнопка "Очистить"
procedure TframeTrade.btnCClick(Sender: TObject);
begin
  editMain.Clear
end;

// отменить чек
procedure TframeTrade.btnCheqCancelClick(Sender: TObject);
var
  i      : Integer;
  Receipt: TReceiptAllDataRecord;
  Cashier: TCashierRecord;
begin
  if not YesNoDialog('Вы действительно хотите отменить чек?', 0, False) then
    Exit;

  frDriver.CancelReceipt;

  // если в чеке нет товарных позиций
  if lvWares.Items.Count = 0 then
    begin
      ClearReceipt;
      Exit
    end;

  // заполняем структуру информацией о позициях чека
  SetLength(Receipt.receiptPosArray, lvWares.Items.Count);

  for i := 0 to lvWares.Items.Count - 1 do
    with Receipt.receiptPosArray[i] do
      begin
        rpGoodsCode := lvWares.Items[i].Caption;
        rpGoodsName := lvWares.Items[i].SubItems[0];
        rpQuantity  := StrToCurr(lvWares.Items[i].SubItems[2]);
        rpDiscount  := StrToCurrDef(lvWares.Items[i].SubItems[3], 0);
        rpPrice     := StrToCurr(lvWares.Items[i].SubItems[1]);
        rpSumm      := StrToCurr(lvWares.Items[i].SubItems[4]);
        rpMark      := arrayOfMarks[i]
      end;

  // сохраняем оплаты
  SetLength(Receipt.receiptPaymentsArray, 2);

  // оплата наличными
  Receipt.receiptPaymentsArray[0].rpType  := 0;
  Receipt.receiptPaymentsArray[0].rpValue := StrToCurr(btnPayCash.Caption);

  // оплата картой
  Receipt.receiptPaymentsArray[1].rpType  := 1;
  Receipt.receiptPaymentsArray[1].rpValue := StrToCurr(btnPayCard.Caption);

  // заполняем структуру информацией о чеке
  with Receipt.receiptRecord do
    begin
      receiptID            := StrToIntDef(labelReceiptNumber.Caption, 0);
      receiptType          := DM1.ReceiptTypeToInternalCode(AnsiLowerCase(btnSelectCheqType.Caption));
      receiptSumm          := StrToCurr(labelTotalSum.Caption);
      receiptCashierCode   := DM1.GetNonVisualSettings.lastCashier;
      receiptCloseDate     := Date;
      receiptCloseTime     := Time;
      receiptClientCode    := 0;
      receiptStatus        := 2; // 0 - открыт; 1 - закрыт; 2 - отменён
      receiptSessionNumber := DM1.GetNonVisualSettings.sessionNumber;
      receiptNote          := '';
      receiptDiscount      := StrToCurr(labelCheqDiscount.Caption);
      receiptContact       := panelDigitalCopy.Caption
    end;

  // записываем чек в БД
  DM1.SaveReceipt(Receipt);

  // очищаем поля ввода
  ClearReceipt;

  // очищаем массив марок
  SetLength(arrayOfMarks, 0);
end;

//копия чека
procedure TframeTrade.btnCheqCopyClick(Sender: TObject);
var
  ReceiptID, i: Integer;
  Receipt     : TReceiptAllDataRecord;
  Error       : TFRError;
  Cashier     : TCashierRecord;
begin
  // отменяем текущий чек, если он есть
  frDriver.CancelReceipt;
  ClearReceipt;

  formDocuments        := TformDocuments.Create(Self);
  formDocuments.Status := 1;
  formDocuments.ShowModal;
  ReceiptID := formDocuments.SelectedCode;
  formDocuments.Free;

  if ReceiptID <= 0 then
    Exit;

  Cashier := DM1.GetCashierData(DM1.GetNonVisualSettings.lastCashier); //получаем данные текущего кассира

  // открываем чек
  Error := frDriver.OpenNonFiscalReceipt(Cashier.cName, Cashier.cINN);
  if Error.ErrorCode <> 0 then
  begin
    YesNoDialog(Error.ErrorText, 1, False);
    Exit
  end;

  Receipt := DM1.GetReceipt(ReceiptID); // запрашиваем информацию по выбранному чеку

  Error := frDriver.PrintStr('КОПИЯ ЧЕКА ОТ', 3, 0, False, False);
  Error := frDriver.PrintStr(DateToStr(Receipt.receiptRecord.receiptCloseDate) + ' ' + TimeToStr(Receipt.receiptRecord.receiptCloseTime), 3, 0, False, False);
  Error := frDriver.PrintStr('Тип чека: ' + DM1.InternalCodeToReceiptType(Receipt.receiptRecord.receiptType), 1, 0, False, False);

  for i := 0 to Length(Receipt.receiptPosArray) - 1 do
    with Receipt.receiptPosArray[i] do
      begin
        Error := frDriver.PrintStr(rpGoodsName, 1, 0, False, False);
        Error := frDriver.PrintStr(CurrToStrF(rpQuantity, ffFixed, 3) + ' * ' + CurrToStrF(rpPrice, ffFixed, 2) + ' = ' + CurrToStrF(rpSumm, ffFixed, 2), 3, 0, False, False);

        if Error.ErrorCode <> 0 then
          begin
            YesNoDialog(Error.ErrorText, 1, False);
            Exit
          end;
      end;

  Error := frDriver.PrintStr('Скидка: ' + CurrToStrF(Receipt.receiptRecord.receiptDiscount, ffFixed, 2), 1, 0, False, False);
  Error := frDriver.PrintStr('ИТОГ: ' + CurrToStrF(Receipt.receiptRecord.receiptSumm, ffFixed, 2), 1, 0, True, True);
  Error := frDriver.PrintStr('НАЛИЧНЫМИ: ' + CurrToStrF(Receipt.receiptPaymentsArray[0].rpValue, ffFixed, 2), 1, 0, False, False);
  Error := frDriver.PrintStr('ЭЛЕКТРОННЫМИ: ' + CurrToStrF(Receipt.receiptPaymentsArray[1].rpValue, ffFixed, 2), 1, 0, False, False);
  Error := frDriver.PrintStr('Кассир: ' + DM1.GetCashierData(Receipt.receiptRecord.receiptCashierCode).cName, 1, 0, False, False);

  // закрываем чек
  Error := frDriver.CloseNonFiscalReceipt;
  if Error.ErrorCode <> 0 then
    begin
      YesNoDialog(Error.ErrorText, 1, False);
      Exit
    end;
end;

//скидка на чек
procedure TframeTrade.btnCheqDiscountClick(Sender: TObject);
var
  Value: Currency;
  i: Integer;
begin
  Value := StrToCurrDef(editMain.Text, 0);

  if (Value <= 0) or (Value > 100) then
  begin
    YesNoDialog('Значение скидки должно быть больше 0 и меньше 100%.', 1, False);
    Exit
  end;

//  labelCheqDiscount.Caption := CurrToStrF(Value, ffFixed, 2);

  for i := 0 to lvWares.Items.Count - 1 do
    lvWares.Items[i].SubItems[3] := CurrToStrF(Value, ffFixed, 2);

  RecalcCheq;

  editMain.Clear
end;

//скидка на позицию
procedure TframeTrade.btnPosDiscountClick(Sender: TObject);
var
  SelectedItem: TListItem;
  Value: Currency;
begin
  SelectedItem := lvWares.Selected;
  if SelectedItem = nil then
  begin
    YesNoDialog('Выберите одну из позиций в чеке, на которую нужно сделать скидку.', 1, False);
    Exit
  end;

  Value := StrToCurrDef(editMain.Text, 0);

  if (Value <= 0) or (Value > 100) then
  begin
    YesNoDialog('Значение скидки должно быть больше 0 и меньше 100%.', 1, False);
    Exit
  end;

  SelectedItem.SubItems[3] := CurrToStrF(Value, ffFixed, 2);

  RecalcCheq; //пересчитываем чек

  editMain.Clear
end;

//отменить скидки
procedure TframeTrade.btnCancelDiscountClick(Sender: TObject);
var
  i: Integer;
begin
  //убираем скидки на позиции
  for i := 0 to lvWares.Items.Count - 1 do
    lvWares.Items[i].SubItems[3] := '';

  RecalcCheq; //пересчитываем чек
end;

//сумма в ДЯ
procedure TframeTrade.btnCashboxSumClick(Sender: TObject);
begin
  YesNoDialog('Сумма в денежном ящике: ' + CurrToStrF(frDriver.CashBoxSum, ffFixed, 2), 1, False)
end;

//визуальный поиск товара
procedure TframeTrade.btnGoodsClick(Sender: TObject);
var
  selectedCode: String;
begin
  selectedCode := GoodsVisualSearchResultDlg;

  if selectedCode <> '' then
    AddGoodsToCheq(selectedCode, '', 0, 1);
end;

//поиск товара по коду
procedure TframeTrade.btnCodeClick(Sender: TObject);
var
  GD: TGoodsRecord;
begin
  if Trim(editMain.Text) = '' then
  begin
    YesNoDialog('Вначале введите код.', 1, False);
    Exit
  end;

  GD := DM1.GetGoodsData(editMain.Text);

  if (GD.gCode = '') or GD.gIsGroup then
  begin
    YesNoDialog('Товар с таким кодом не найден.', 1, False);
    editMain.Clear
  end
  else
    AddGoodsToCheq(GD.gCode, '', 0, 1);
end;

//поиск товара по артикулу
procedure TframeTrade.btnVendorcodeClick(Sender: TObject);
var
  SelectedCode: String;
begin
  if Trim(editMain.Text) = '' then
  begin
    YesNoDialog('Вначале введите артикул.', 1, False);
    Exit
  end;

  SelectedCode := GoodsSearchResultDlg(editMain.Text, 'vendorcode');

  if SelectedCode <> '' then
    AddGoodsToCheq(SelectedCode, '', 0, 1);

  editMain.Clear
end;

//поиск товара по цене
procedure TframeTrade.btnPriceClick(Sender: TObject);
var
  SelectedCode, Str: String;
  Value: Currency;
begin
  if not TryStrToCurr(editMain.Text, Value) then
  begin
    YesNoDialog('Вначале введите корректную цену.', 1, False);
    Exit
  end;

  Str := StringReplace(editMain.Text, ',', '.', [rfIgnoreCase]); //заменяем в числе запятую на точку, т.к. SQL воспринимает только точку в качестве разделителя целой и дробной части

  SelectedCode := GoodsSearchResultDlg(Str, 'price');

  if SelectedCode <> '' then
    AddGoodsToCheq(SelectedCode, '', 0, 1);

  editMain.Clear
end;

//поиск товара по ШК введённому вручную
procedure TframeTrade.btnBarcodeClick(Sender: TObject);
var
  SelectedCode: String;
begin
  if Trim(editMain.Text) = '' then
  begin
    YesNoDialog('Вначале введите штрихкод.', 1, False);
    Exit
  end;

  SelectedCode := GoodsSearchResultDlg(editMain.Text, 'barcode');

  if SelectedCode <> '' then
    AddGoodsToCheq(SelectedCode, '', 0, 1);

  editMain.Clear
end;

//несколько нулей
procedure TframeTrade.btn00Click(Sender: TObject);
var
  i: Integer;
begin
  if not editMain.Focused then
    editMain.SetFocus;

  for i := 0 to Length((Sender as TsSpeedButton).Caption) - 1 do
  begin
    keybd_event(Ord('0'), 0, 0, 0);
    keybd_event(Ord('0'), 0, KEYEVENTF_KEYUP, 0);
  end;
end;

//Backspase
procedure TframeTrade.btnBSClick(Sender: TObject);
begin
  if not editMain.Focused then
    editMain.SetFocus;

  keybd_event(VK_BACK, 0, 0, 0);
  keybd_event(VK_BACK, 0, KEYEVENTF_KEYUP, 0);
end;

//Оплата наличными
procedure TframeTrade.btnPayCashClick(Sender: TObject);
var
  PaymentCash, PaymentCard, TotalSum: Currency;
begin
  if lvWares.Items.Count = 0 then
    begin
      YesNoDialog('Вначале добавьте товары в чек.', 1, False);
      Exit
    end;

  PaymentCash := StrToCurrDef(editMain.Text, 0);
  PaymentCard := StrToCurrDef(btnPayCard.Caption, 0);
  TotalSum := StrToCurrDef(labelTotalSum.Caption, 0);

  if (PaymentCash = 0) and (PaymentCard = 0) then
    btnPayCash.Caption := CurrToStrF(TotalSum, ffFixed, 2) //если в поле ввода ничего нет и оплата картой нулевая, то делаем оплату наличными равной сумме чека
  else
  if (PaymentCash = 0) and (PaymentCard > 0) then
    btnPayCash.Caption := CurrToStrF(TotalSum - PaymentCard, ffFixed, 2) //если в поле ввода ничего нет, но оплата картой не нулевая, то делаем оплату наличными на остаток суммы
  else
    btnPayCash.Caption := CurrToStrF(PaymentCash, ffFixed, 2); //в оплату наличными переносим значение из поля ввода

  ChangeCalculation; //пересчитываем сдачу

  editMain.Clear;

  //открываем ДЯ
  if DM1.GetDrawerSettings.status and DM1.GetDrawerSettings.autoOpen then
    frDriver.OpenDrawer;
end;

//оплата картой
procedure TframeTrade.btnPayCardClick(Sender: TObject);
var
  PaymentCash, PaymentCard, TotalSum: Currency;
begin
  if lvWares.Items.Count = 0 then
    begin
      YesNoDialog('Вначале добавьте товары в чек.', 1, False);
      Exit
    end;

  PaymentCard := StrToCurrDef(editMain.Text, 0);
  PaymentCash := StrToCurrDef(btnPayCash.Caption, 0);
  TotalSum := StrToCurrDef(labelTotalSum.Caption, 0);

  if PaymentCard > TotalSum then
    begin
      YesNoDialog('Оплата по карте не может быть больше суммы чека.', 1, False);
      Exit
    end;

  if (PaymentCash = 0) and (PaymentCard = 0) then
    btnPayCard.Caption := CurrToStrF(TotalSum, ffFixed, 2) //если в поле ввода ничего нет и оплата наличными нулевая, то делаем оплату картой равной сумме чека
  else
  if (PaymentCard = 0) and (PaymentCash > 0) and (PaymentCash <= TotalSum) then
    btnPayCard.Caption := CurrToStrF(TotalSum - PaymentCash, ffFixed, 2) //если в поле ввода ничего нет, но оплата наличными не нулевая и не больше суммы чека, то делаем оплату картой на остаток суммы
  else
    btnPayCard.Caption := CurrToStrF(PaymentCard, ffFixed, 2); //в оплату картой переносим значение из поля ввода

  ChangeCalculation; //пересчитываем сдачу

  editMain.Clear
end;

//расчёт сдачи
procedure TframeTrade.ChangeCalculation;
var
  Change, TotalSum: Currency;
begin
  TotalSum := StrToCurr(labelTotalSum.Caption);
  Change := StrToCurr(btnPayCash.Caption) + StrToCurr(btnPayCard.Caption) - TotalSum;

  labelChange.Caption := CurrToStrF(Change, ffFixed, 2)
end;

//действия при смене типа чека
procedure TframeTrade.ChangeCheqType(CheqType: String);
var
  locking: Boolean;
  i: Integer;
begin
  locking := (AnsiLowerCase(CheqType) = 'продажа') or (AnsiLowerCase(CheqType) = 'возврат');

  for i := 0 to ComponentCount - 1 do
    if Components[i].Tag = 2 then
      TButton(Components[i]).Enabled := locking
end;

//очистка всех полей ввода в чеке
procedure TframeTrade.ClearReceipt;
begin
  lvWares.Clear;
  RecalcCheq;

  btnPayCash.Caption := '0,00';
  btnPayCard.Caption := '0,00';
  labelChange.Caption := '0,00';

  btnSelectCheqType.Caption := 'Продажа';
  ChangeCheqType(btnSelectCheqType.Caption);
  labelReceiptNumber.Caption := '';
end;

// закрыть чек
procedure TframeTrade.btnCloseCheqClick(Sender: TObject);
var
  i, timeAlert                          : Integer;
  cheqType, parentDoc, parentDocNum     : String;
  parentDocDate                         : TDateTime;
  receiptData                           : TReceiptAllDataRecord;
  cashierData                           : TCashierRecord;
  frError                               : TFRError;
  payCash, payCard, totalSum, initialSum: Currency;
  nonVisualSettings                     : TNonVisualSettingsRecord;
  posInfo                               : TPosInfo;
begin
  if lvWares.Items.Count = 0 then
    begin
      YesNoDialog('В чеке нет позиций!', 1, False);
      Exit
    end;

  if StrToCurr(labelChange.Caption) < 0 then
    begin
      YesNoDialog('Сумма оплат меньше суммы чека!', 1, False);
      Exit
    end;

  timeAlert := DM1.GetFRSetting.frTimeAlert;

  if (timeAlert > 0) and (MinutesBetween(Now, frDriver.GetDateTime) >= timeAlert) then
    YesNoDialog('Расхождение времени между фискальным регистратором (' + DateTimeToStr(frDriver.GetDateTime) + ') и компьютером (' + DateTimeToStr(Now) + ') составляет ' + IntToStr(MinutesBetween(Now, frDriver.GetDateTime)) + ' минут!', 1, False);

  nonVisualSettings := DM1.GetNonVisualSettings;
  cashierData       := DM1.GetCashierData(nonVisualSettings.lastCashier); //получаем данные текущего кассира

  if frDriver.IsSessionClosed then
    begin
      // синхронизация времени ФР с ПК
      if DM1.GetFRSetting.frSynchroTime and (MinutesBetween(Now, frDriver.GetDateTime) >= 1) then
        frError := frDriver.SetDateTime;

      if frError.ErrorCode <> 0 then
        YesNoDialog(frError.ErrorText, 1, False);

      if YesNoDialog('Смена закрыта. Открыть её?', 0, False) then
        frDriver.OpenSession(cashierData.cName, cashierData.cINN)
      else
        Exit
    end;

    // если программная смена закрыта, то открываем её
    if not nonVisualSettings.sessionIsOpen then
      begin
        nonVisualSettings.sessionIsOpen := True;
        DM1.SaveNonVisualSetting(nonVisualSettings);
      end;

  if frDriver.IsSessionExpired then
    begin
      if YesNoDialog('Длительность смены превысила 24 часа, необходимо закрыть её. Сделать это?', 0, False) then
        frDriver.CloseSession(cashierData.cName, cashierData.cINN)
      else
        Exit
    end;

  cheqType := AnsiLowerCase(btnSelectCheqType.Caption); // узнаём тип чека

  if (cheqType = 'коррекция прихода') or (cheqType = 'коррекция расхода') then
    begin
      // окно с запросом информации для чека коррекции
      formCorrectionInfo := TformCorrectionInfo.Create(Self);
      formCorrectionInfo.ShowModal;

      if formCorrectionInfo.ModalResult <> mrCancel then // если не отменили ввод данных
        begin
          parentDoc     := formCorrectionInfo.ParentDoc;
          parentDocNum  := formCorrectionInfo.ParentDocNum;
          parentDocDate := formCorrectionInfo.ParentDocDate;
        end
      else
        begin // если отменили ввод данных
          formCorrectionInfo.Free;
          Exit
        end;

      formCorrectionInfo.Free
    end;

  // отменяем чек в ФР на тот случай, если по каким-то причинам он в нём открыт
  frDriver.CancelReceipt;

  frError := frDriver.OpenReceipt(cheqType, panelDigitalCopy.Caption, cashierData.cName, cashierData.cINN, parentDoc, parentDocNum, DM1.GetFRSetting.frReceiptPrint, parentDocDate); //открываем чек в ФР
  if frError.ErrorCode <> 0 then
    begin
      YesNoDialog(frError.ErrorText, 1, False);
      Exit
    end;

  // заполняем структуру информацией о позициях чека
  SetLength(receiptData.receiptPosArray, lvWares.Items.Count);

  totalSum := StrToCurrDef(labelTotalSum.Caption, 0);     // сумма чека с округлением
  initialSum := StrToCurrDef(labelInitialSum.Caption, 0); // сумма чека без скидок и округления

  for i := 0 to lvWares.Items.Count - 1 do
    with receiptData.receiptPosArray[i] do
      begin
        rpGoodsCode := lvWares.Items[i].Caption;
        rpGoodsName := lvWares.Items[i].SubItems[0];
        rpTax       := DM1.GetGoodsData(rpGoodsCode).gTax;
        rpQuantity  := StrToCurr(lvWares.Items[i].SubItems[2]);
        rpDiscount  := StrToCurrDef(lvWares.Items[i].SubItems[3], 0);
        rpPPR       := DM1.GetGoodsData(rpGoodsCode).gPPR;
        rpMark      := arrayOfMarks[i];

        // корректируем цены на позиции при наличии округления на чек (иначе будет расхождение суммы чека и суммы позиций, ФР не разрешит закрыть такой чек)
        if totalSum <> initialSum then
          begin
            rpSumm  := StrToCurr(lvWares.Items[i].SubItems[4]) / totalSum * roundSum + StrToCurr(lvWares.Items[i].SubItems[4]);
            rpPrice := rpSumm / StrToCurr(lvWares.Items[i].SubItems[2]);
          end
        else
          begin
            rpPrice := StrToCurr(lvWares.Items[i].SubItems[1]);
            rpSumm  := StrToCurr(lvWares.Items[i].SubItems[4]);
          end;
      end;

  // регистрируем позиции в ФР
  for i := 0 to lvWares.Items.Count - 1 do
    begin
      with receiptData.receiptPosArray[i], posInfo do
        begin
          gName     := rpGoodsName;
          gCode     := rpGoodsCode;
          gPrice    := rpPrice;
          gQuantity := rpQuantity;
          gTaxType  := rpTax;
          gDiscount := rpDiscount;
          gPPR      := rpPPR;
          gMark     := rpMark
        end;

      frError := frDriver.PosRegistration(posInfo);

      if frError.ErrorCode <> 0 then
        begin
          YesNoDialog(frError.ErrorText, 1, False);
          Exit
        end;
    end;

  payCash := StrToCurr(btnPayCash.Caption);
  payCard := StrToCurr(btnPayCard.Caption);

  if (payCash = 0) and (payCard = 0) then
    payCash := totalSum;

  SetLength(receiptData.receiptPaymentsArray, 2);

  // регистрируем оплату наличными
  if payCash > 0 then
    begin
      frError := frDriver.PaymentRegistration(0, payCash);
      if frError.ErrorCode <> 0 then
        begin
          YesNoDialog(frError.ErrorText, 1, False);
          Exit
        end
      else
        begin
          receiptData.receiptPaymentsArray[0].rpType  := 0;
          receiptData.receiptPaymentsArray[0].rpValue := payCash
        end;
    end;

  // регистрируем оплату картой
  if payCard > 0 then
    begin
      frError := frDriver.PaymentRegistration(1, payCard);
      if frError.ErrorCode <> 0 then
        begin
          YesNoDialog(frError.ErrorText, 1, False);
          Exit
        end
      else
        begin
          receiptData.receiptPaymentsArray[1].rpType  := 1;
          receiptData.receiptPaymentsArray[1].rpValue := payCard
        end;
    end;

  // регистрируем итог
  frError := frDriver.TotalRegistration(totalSum);
  if frError.ErrorCode <> 0 then
    begin
      YesNoDialog(frError.ErrorText, 1, False);
      Exit
    end;

  // закрываем чек
  frDriver.CloseReceipt;

  // заполняем структуру информацией о чеке
  with receiptData.receiptRecord do
    begin
      receiptID            := StrToIntDef(labelReceiptNumber.Caption, 0);
      receiptType          := DM1.ReceiptTypeToInternalCode(cheqType);
      receiptSumm          := StrToCurr(labelTotalSum.Caption);
      receiptCashierCode   := nonVisualSettings.lastCashier;
      receiptCloseDate     := Date;
      receiptCloseTime     := Time;
      receiptClientCode    := 0;
      receiptStatus        := 1; // 0 - открыт; 1 - закрыт; 2 - отменён
      receiptSessionNumber := nonVisualSettings.sessionNumber;
      receiptNote          := '';
      receiptDiscount      := StrToCurr(labelCheqDiscount.Caption);
      receiptContact       := panelDigitalCopy.Caption
    end;

  // записываем чек в БД
  DM1.SaveReceipt(receiptData);

  // очищаем поля ввода
  ClearReceipt;

  // очищаем массив марок
  SetLength(arrayOfMarks, 0);
end;

//уменьшаем количество выделенной строки товара на 1
procedure TframeTrade.btnQuantityMinusClick(Sender: TObject);
var
  SelectedItem: TListItem;
  Quantity: Real;
begin
  SelectedItem := lvWares.Selected;
  if SelectedItem = nil then
  begin
    YesNoDialog('Выберите позицию в чеке, количество которой хотите изменить.', 1, False);
    Exit;
  end;

  Quantity := StrToFloat(SelectedItem.SubItems[2]);
  if Quantity > 1 then
    SelectedItem.SubItems[2] := FloatToStr(Quantity - 1);

  RecalcCheq
end;

//увеличиваем количество выделенной строки товара на 1
procedure TframeTrade.btnQuantityPlusClick(Sender: TObject);
var
  SelectedItem: TListItem;
begin
  SelectedItem := lvWares.Selected;
  if SelectedItem = nil then
  begin
    YesNoDialog('Выберите позицию в чеке, количество которой хотите изменить.', 1, False);
    Exit;
  end;

  SelectedItem.SubItems[2] := FloatToStr(StrToFloat(SelectedItem.SubItems[2]) + 1);

  RecalcCheq
end;

//устанавливаем количество товара в выделенной строке
procedure TframeTrade.btnQuantitySetClick(Sender: TObject);
var
  SelectedItem: TListItem;
  Quantity: Real;
begin
  SelectedItem := lvWares.Selected;
  if SelectedItem = nil then
  begin
    YesNoDialog('Выберите позицию в чеке, количество которой хотите изменить.', 1, False);
    Exit;
  end;

  Quantity := StrToFloatDef(editMain.Text, 0);

  if Quantity <= 0 then
  begin
    YesNoDialog('Введите корректное количество.', 1, False);
    Exit
  end;

  SelectedItem.SubItems[2] := FloatToStr(Quantity);

  editMain.Clear;

  RecalcCheq
end;

//устанавливаем цену товара в выделенной строке
procedure TframeTrade.btnPriceSetClick(Sender: TObject);
var
  SelectedItem: TListItem;
  Price: Currency;
begin
  SelectedItem := lvWares.Selected;
  if SelectedItem = nil then
  begin
    YesNoDialog('Выберите позицию в чеке, на которую хотите изменить цену', 1, False);
    Exit;
  end;

  Price := StrToCurrDef(editMain.Text, 0);
  if Price <= 0 then
  begin
    YesNoDialog('Введите корректную цену', 1, False);
    Exit
  end;

  SelectedItem.SubItems[1] := CurrToStrF(Price, ffFixed, 2);

  editMain.Clear;

  RecalcCheq
end;

// удалить позицию из чека
procedure TframeTrade.btnDelPosClick(Sender: TObject);
var
  selectedItem: TListItem;
  markIndex, goodsType: Integer;
begin
  selectedItem := lvWares.Selected;

  if selectedItem = nil then
    begin
      YesNoDialog('Выберите ту позицию из чека, которую хотите удалить.', 1, False);
      Exit
    end;

  goodsType := DM1.GetGoodsData(selectedItem.Caption).gType;
  // если удаляется маркированный товар
  if goodsType > 0 then
    begin
//      if not scanerSettings.sStatus then
//        begin
//          YesNoDialog('Марка не может быть считана, т.к. сканер штрихкодов не включён в настройках.' + #13#10 +
//                      '(Настройки -> Оборудование -> Сканер ШК).', 1, False);
//          Exit
//        end;

      markIndex := DelMarkDialog(arrayOfMarks, goodsType); // узнаём под каким индексом находится считанная марка, т.к. пользователь может сторнировать один товар, а марку считывать от другого
      if markIndex = -1 then                               // марка не считана
        Exit;
      Delete(arrayOfMarks, markIndex, 1); // удаляем марку из массива
      lvWares.Items[markIndex].Delete     // удаляем товар из списка
    end
  else
    begin
      Delete(arrayOfMarks, selectedItem.Index, 1); // удаляем пустое значение из массива марок
      selectedItem.Delete;                         // удаляем товар из списка
    end;

  RecalcCheq
end;

//кнопка разделитель
procedure TframeTrade.btnSeparatorClick(Sender: TObject);
var
  s: String;
  p: Integer;
begin
  if not editMain.Focused then
    editMain.SetFocus;

  editMain.ClearSelection;

  s := editMain.Text;
  p := editMain.SelStart;
  Insert(FormatSettings.DecimalSeparator, s, p + 1);
  editMain.Text := s;
  editMain.SelStart := p + 1;
end;

//*
procedure TframeTrade.btnXClick(Sender: TObject);
begin
  if not editMain.Focused then
    editMain.SetFocus;

  keybd_event(VK_MULTIPLY, 0, 0, 0);
  keybd_event(VK_MULTIPLY, 0, KEYEVENTF_KEYUP, 0);
end;

//инициализация оборудования
procedure TframeTrade.FrameEnter(Sender: TObject);
var
  frSettings: TFRSettingsRecord;
  frError: TFRError;
  errorMsg: String;
begin
  frSettings := DM1.GetFRSetting;

  // если ФР включён в настройках, пытаемся к нему подключиться
  frDriver := TfrDriver.Create(frSettings.frModel, not frSettings.frStatus);

  frError := frDriver.Connection(frSettings.frChanel, frSettings.frPort, frSettings.frSpeed, frSettings.frIP, frSettings.frMAC);
  if frError.ErrorCode <> 0 then
    begin
      errorMsg := 'Фискальный регистратор: ' + frError.ErrorText;
      YesNoDialog(errorMsg, 1, False);
    end
  else
    timerOFD.Enabled := True;

//  scanerSettings := DM1.GetScanerSettings;
//
//  // если сканер ШК включён в настройках
//  if scanerSettings.sStatus then
//    begin
//      bcScaner := TScaner45.Create(nil);
//      bcScaner.OnDataEvent := BCScanerDataEvent;
//
//      BCSConnection(bcScaner, scanerSettings.sChanel, scanerSettings.sPort, scanerSettings.sSpeed, scanerSettings.sPrefix, scanerSettings.sSufix);
//    end;
end;

//отключение оборудования
procedure TframeTrade.FrameExit(Sender: TObject);
begin
  timerOFD.Enabled := False;

  frDriver.Destroy; // объект драйвера ФР создаётся не зависимо от его наличия

//  if DM1.GetScanerSettings.sStatus then
//    bcScaner.Free
end;

//кнопки с цифрами
procedure TframeTrade.NumericButtonClick(Sender: TObject);
begin
  if not editMain.Focused then
    editMain.SetFocus;

  keybd_event(Ord((Sender as TsSpeedButton).Caption[1]), 0, 0, 0);
  keybd_event(Ord((Sender as TsSpeedButton).Caption[1]), 0, KEYEVENTF_KEYUP, 0);
end;

//данные клиента для отправки электронной копии чека
procedure TframeTrade.btnDigitalCopyClick(Sender: TObject);
begin
  if Trim(editMain.Text) = '' then
    YesNoDialog('Вначале введите электронную почту или телефон', 1, False)
  else
  begin
    panelDigitalCopy.Caption := editMain.Text;
    editMain.Text := ''
  end;
end;

//Z-отчёт
procedure TframeTrade.btnZReportClick(Sender: TObject);
begin
  YesNoDialog('Вы уверены, что хотите закрыть смену?', 0, True);
end;

//выбрать тип чека
procedure TframeTrade.btnSelectCheqTypeClick(Sender: TObject);
begin
  if lvWares.Items.Count <> 0 then
    begin
      YesNoDialog('Нельзя менять тип чека при наличии позиций в нём.', 1, False);
      Exit
    end;

  formSelectCheqType := TformSelectCheqType.Create(Self);
  formSelectCheqType.ShowModal;

  btnSelectCheqType.Caption := formSelectCheqType.CheqType;

  formSelectCheqType.Free;

  ChangeCheqType(btnSelectCheqType.Caption);
end;

//прокрутить вверх
procedure TframeTrade.btnUpClick(Sender: TObject);
begin
  LVScrollPage(lvWares, True);
end;

//прокрутить вниз
procedure TframeTrade.btnDownClick(Sender: TObject);
begin
  LVScrollPage(lvWares, False);
end;

//выплата
procedure TframeTrade.btnCashOutClick(Sender: TObject);
var
  Error: TFRError;
begin
  //отменяем текущий чек, если он есть
  frDriver.CancelReceipt;
  ClearReceipt;

  Error := frDriver.CashOut(StrToCurrDef(editMain.Text, 0));

  if Error.ErrorCode <> 0 then
    begin
      YesNoDialog(Error.ErrorText, 1, False);
      Exit
    end
  else
    editMain.Text := '';

  //открываем ДЯ
  if DM1.GetDrawerSettings.status and DM1.GetDrawerSettings.autoOpen then
    frDriver.OpenDrawer;
end;

//внесение
procedure TframeTrade.btnCashInClick(Sender: TObject);
var
  Error: TFRError;
begin
  //отменяем текущий чек, если он есть
  frDriver.CancelReceipt;
  ClearReceipt;

  Error := frDriver.CashIn(StrToCurrDef(editMain.Text, 0));

  if Error.ErrorCode <> 0 then
    begin
      YesNoDialog(Error.ErrorText, 1, False);
      Exit
    end
  else
    editMain.Text := '';

  //открываем ДЯ
  if DM1.GetDrawerSettings.status and DM1.GetDrawerSettings.autoOpen then
    frDriver.OpenDrawer;
end;

// запрос статуса обмена с ОФД
procedure TframeTrade.timerOFDTimer(Sender: TObject);
begin
  labelOFDStatus.Caption := frDriver.GetOFDExchangeError.OFDErrorText
end;


end.
