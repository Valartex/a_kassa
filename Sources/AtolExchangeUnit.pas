unit AtolExchangeUnit;

interface

uses
  System.SysUtils, System.Classes, System.StrUtils, System.Types, acProgressBar, Vcl.Forms, Winapi.Windows,
  Winapi.Messages;

function Download(fileName: String): Boolean;
function Upload(fileName: String): Boolean;

implementation

uses DBUnit, CommonUnit;

// загрузка данных
function Download(fileName: String): Boolean;
const
  // $$$ADDQUANTITY - добавить товары с добавлением начального остатка
  // $$$REPLACEQUANTITY - добавить товары с замещением начального остатка и удалением продаж
  // $$$REPLACEQUANTITYWITHOUTSALE - добавить товары с замещением начального остатка

  optionsForAdding: array[1..3] of String = ('$$$ADDQUANTITY', '$$$REPLACEQUANTITY', '$$$REPLACEQUANTITYWITHOUTSALE'); // варианты добавления товаров
var
  dlFile, logFile                : TStringList;
  startStr, i, j, n, taxCode     : Integer;
  goodsStr, flagsStr, barcodesStr: TStringDynArray;
  goodsRecord                    : TGoodsRecord;
  taxArray                       : TTaxArray;
begin
  Result := FileExists(fileName);
  if not Result then Exit;

  taxArray := DM1.GetTaxes; // получаем из БД данные по всем налогам

  logFile := TStringList.Create;
  logFile.Append('Строки, содержащие ошибки:');

  dlFile := TStringList.Create;
  dlFile.LoadFromFile(fileName);

  if dlFile.count < 3 then Exit;

  Result := Trim(dlFile[0]) = '##@@&&'; // признак файла загрузки Фронтол
  if not Result then Exit;

  Result := Trim(dlFile[1]) = '#'; // признак того, что файл ещё не загружался
  if not Result then Exit;

  SendMessage(Application.MainFormHandle, WM_USER + 3, dlFile.Count, 1); // установка максимального значения для ProgressBar в главном окне

  if dlFile.IndexOf('$$$DELETEALLWARES') > 0 then //удалить все товары
    begin
      DM1.DeleteAllGoods
    end;

  if dlFile.IndexOf('$$$DELETEALLBARCODES') > 0 then //удалить все штрихкоды
    begin
      DM1.DeleteAllBarcodes
    end;

  if dlFile.IndexOf('$$$DELETEALLUSERS') > 0 then //удалить всех пользователей
    begin
      DM1.DeleteAllCashiers
    end;

  if dlFile.IndexOf('$$$DELETEALLTAXRATES') > 0 then //удалить все налоговые ставки
    begin
      DM1.DeleteAllTaxes
    end;

  if dlFile.IndexOf('$$$DELETEALLCLIENTDISCS') > 0 then //удалить всех клиентов
    begin

    end;

  if dlFile.IndexOf('$$$ADDUSERS') > 0 then //добавить пользователей
    begin

    end;

  if dlFile.IndexOf('$$$ADDTAXRATES') > 0 then //добавить налоговые ставки
    begin

    end;

  if dlFile.IndexOf('$$$ADDCLIENTDISCS') > 0 then //добавить клиентов
    begin

    end;

  for j := 1 to Length(optionsForAdding) do
    begin

      DM1.StartTransaction;

      startStr := dlFile.IndexOf(optionsForAdding[j]); // находим все варианты добавления товаров
      if startStr < 0 then Continue;

      i := startStr + 1;

      while (i < dlFile.Count) and (Copy(dlFile[i], 1, 3) <> '$$$') and (Trim(dlFile[i]) <> '') do // если не дошли до конца файла и до следующей команды
        begin
          SendMessage(Application.MainFormHandle, WM_USER + 2, 1, 1); // обновляем ProgressBar на главной форме

          try
            goodsStr    := SplitString(dlFile[i], ';');   // разбиваем строку с информацией о товаре по разделителю
            flagsStr    := SplitString(goodsStr[7], ','); // флаги товара (опции)
            barcodesStr := SplitString(goodsStr[1], ','); // штрих-коды

            with goodsRecord do
              begin
                // значение из документации минус один, т.к. динамич. массив
                gCode       := goodsStr[0];   // код
                if (Length(gCode) = 0) or (gCode[1] = ' ') then     // т.к. код обязательное поле
                  Abort;
                gName       := goodsStr[2];   // наименование
                gPicture    := goodsStr[30];  // картинка
                gVendorcode := goodsStr[25];  // артикул
                gParent     := goodsStr[15];  // родитель
                gUnit       := 1;             // единица измерения Штука

                // налоговая группа (если не указана, то Без НДС)
                gTax    := 0;
                taxCode := StrToIntDefEx(goodsStr[22], -1);
                if taxCode <> -1 then
                  for n := 0 to Length(taxArray) - 1 do
                    if taxArray[n].taxCode = taxCode then
                      begin
                        gTax := n;
                        Break
                      end;

                gPPR             := StrToIntDefEx(goodsStr[12], 1);         // признак предмета расчёта (если не указан, то Товар)
                gPLU             := StrToIntDefEx(goodsStr[24], 0);         // PLU (если не указан, то 0)
                gDepartment      := StrToIntDefEx(goodsStr[36], 0);         // секция ККМ (если не указана, то 0)
                gPrice           := StrToCurrDefEx(goodsStr[4], 0);         // цена (если не указана, то 0)
                gIsGroup         := not StrToBoolDefEx(goodsStr[16], True); // группа или товар (у Атола 1 - товар, 0 - группа, у нас - наоборот)
                gFractional      := StrToBoolDefEx(flagsStr[0], True);      // дробное количество
                gUnloadInScales  := StrToIntDefEx(goodsStr[24], 0) > 0;     // загружать в весы, если задано PLU
                gPriceRequest    := StrToBoolDefEx(flagsStr[11], False);    // запрос цены
                gQuantityRequest := not StrToBoolDefEx(flagsStr[4], False); // запрос количества (у Атола этот флаг называется "Без ввода количества")
                gComposition     := goodsStr[49];                           // состав
                gType            := StrToIntDefEx(goodsStr[54], 0);         // вид товара (обычный, табак, обувь...)
                gBarcodes        := barcodesStr;                            // список штрихкодов
              end;

            DM1.SaveGoods(goodsRecord);

          except
            logFile.Append(dlFile[i]);
          end;

          Inc(i);

        end;

      DM1.CommitTransaction;

    end;

 // добавить штрихкоды
  startStr := dlFile.IndexOf('$$$ADDBARCODES');

  if startStr > 0 then
    begin
      DM1.StartTransaction;

      i := startStr + 1;

      while (i < dlFile.Count) and (Copy(dlFile[i], 1, 3) <> '$$$') and (Trim(dlFile[i]) <> '') do // если не дошли до конца файла и до следующей команды
        begin
          SendMessage(Application.MainFormHandle, WM_USER + 2, 1, 1); // обновляем ProgressBar на главной форме

          barcodesStr := SplitString(dlFile[i], ';');

          try
            DM1.SaveBarcode(barcodesStr[1], barcodesStr[0]);
          except
            logFile.Append(dlFile[i]);
          end;

          Inc(i);
        end;

      DM1.CommitTransaction;

    end;

  SendMessage(Application.MainFormHandle, WM_USER + 2, 0, 1); // обнуляем ProgressBar на главной форме

  logFile.SaveToFile(DM1.GetCommonSettings.exchangePath + 'LoadResult.txt');

  dlFile.Free;
  logFile.Free
end;

// выгрузка данных
function Upload(fileName: String): Boolean;
begin

end;

end.
