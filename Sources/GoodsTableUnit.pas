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

//инициализация фрейма
procedure TframeGoodsTable.timerInitTimer(Sender: TObject);
begin
  timerInit.Enabled := False; //т.к. должно сработать один раз при создании фрейма

  UpdateGoodsList; //заполняем ListView данными из справочника товаров

  //изменяем размер значка товара/папки в зависимости от ширины колонки
  sAlphaImageList1.Width := lvGoods.Columns[0].Width - 2;
  sAlphaImageList1.Height := sAlphaImageList1.Width;
end;

//выделение товара в списке
procedure TframeGoodsTable.SelectGoods(Code: String);
var
  GA: TGoodsArray;
  GR: TGoodsRecord;
  i: Integer;
  NewItem: TListItem;
begin
  GR := DM1.GetGoodsData(Code); //получаем данные искомого товара
  GA := DM1.GetGoodsGroupChild(GR.gParent, False); // получаем все дочерние элементы группы, в которй находится искомый товар

  lvGoods.Hint := GR.gParent; //запоминаем в hint код открытой группы, для того чтобы знать куда записывать новые элементы справочника

  lvGoods.Items.BeginUpdate; //отключаем перерисовку компонента

  lvGoods.Clear;

  while GR.gParent <> '' do
    begin
      GR := DM1.GetGoodsData(GR.gParent); //получаем данные родительской группы

      NewItem := lvGoods.Items.Insert(0); //вставляем очередного родителя в первую позицию
      NewItem.SubItems.Append(GR.gCode); //код
      NewItem.SubItems.Append(GR.gName); //наименование
      NewItem.StateIndex := 1; //открытая группа
    end;

  //добавляем дочерние элементы группы
  for i := 0 to Length(GA) - 1 do
  begin
    NewItem := lvGoods.Items.Add;
    NewItem.SubItems.Append(GA[i].gCode); //код
    NewItem.SubItems.Append(GA[i].gName); //наименование

    if GA[i].gIsGroup then
      NewItem.StateIndex := 0 //закрытая группа
    else
    begin
      NewItem.StateIndex := 2; //товар
      NewItem.SubItems.Append(CurrToStrF(GA[i].gPrice, ffFixed, 2)); //цена
    end
  end;

  //выделяем искомый товар
  for i := 0 to lvGoods.Items.Count - 1 do
    if lvGoods.Items[i].SubItems[0] = Code then
      begin
        lvGoods.SelectItem(i);
        Break
      end;

  lvGoods.Selected.MakeVisible(False);

  lvGoods.Items.EndUpdate; //включаем перерисовку
end;

//перезаполняем список товаров
procedure TframeGoodsTable.UpdateGoodsList;
var
  GoodsData: TGoodsArray;
  i: Integer;
  NewItem: TListItem;
begin
  GoodsData := DM1.GetGoodsGroupChild('', False); //получаем список дочерних элементов корня

  lvGoods.Clear;

  for i := 0 to Length(GoodsData) - 1 do //добавляем дочерние элементы группы
  begin
    NewItem := lvGoods.Items.Add;
    NewItem.SubItems.Append(GoodsData[i].gCode);  //код
    NewItem.SubItems.Append(GoodsData[i].gName); //наименование

    if GoodsData[i].gIsGroup then
      NewItem.StateIndex := 0 //закрытая группа
    else
    begin
      NewItem.StateIndex := 2; //товар
      NewItem.SubItems.Append(CurrToStrF(GoodsData[i].gPrice, ffFixed, 2)); //цена
    end
  end;

  //сортируем элементы (сейчас сортируется в запросе, если что-то не так, то раскоментить)
//  lvGoods.SortType := stBoth;
//  lvGoods.SortType := stNone;
end;

//обработка нажатия на элементе справочника "Товары"
procedure TframeGoodsTable.lvGoodsClick(Sender: TObject);
var
  SelectedItem, NewItem: TListItem;
  GA: TGoodsArray;
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

          GA := DM1.GetGoodsGroupChild(SelectedItem.SubItems[0], False); //получаем список дочерних элементов
        end
      else
        begin //если группа открыта

          ParentIndex := SelectedItem.Index - 1; //индекс родительской группы

          if ParentIndex = -1 then //родитель отсутствует (корень)
            begin
              lvGoods.Clear;
              GA := DM1.GetGoodsGroupChild('', False); //получаем список дочерних элементов

              lvGoods.Hint := '';
            end
          else
            begin
              for i := lvGoods.Items.Count - 1 downto ParentIndex + 1 do //удаляем все следующие за родительской группой элементы
                lvGoods.Items[i].Delete;
              GA := DM1.GetGoodsGroupChild(lvGoods.Items[ParentIndex].SubItems[0], False); //получаем список дочерних элементов

              lvGoods.Hint := lvGoods.Items[ParentIndex].SubItems[0];
            end;

        end;

      for i := 0 to Length(GA) - 1 do //добавляем дочерние элементы группы
        begin
          NewItem := lvGoods.Items.Add;
          NewItem.SubItems.Append(GA[i].gCode); //код
          NewItem.SubItems.Append(GA[i].gName); //наименование

          if GA[i].gIsGroup then
            NewItem.StateIndex := 0 //закрытая группа
          else
            begin
              NewItem.StateIndex := 2; //товар
              NewItem.SubItems.Append(CurrToStrF(GA[i].gPrice, ffFixed, 2)); //цена
            end
        end;

      for i := 0 to lvGoods.Items.Count - 1 do //возвращаем выделение
        if lvGoods.Items[i].SubItems[0] = SelectedItemCode then
          begin
            lvGoods.SelectItem(i);
            Break
          end;

      //сортируем элементы (сейчас сортируется в запросе, если что-то не так, то раскоментить)
  //    lvGoods.SortType := stBoth;
  //    lvGoods.SortType := stNone;

      lvGoods.Selected.MakeVisible(False);

    end
  else
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
procedure TframeGoodsTable.lvGoodsCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
begin
  if (Item1.StateIndex = 2) and (Item2.StateIndex = 0) then //сравниваем товар и закрытую группу
    Compare := 1 //располагаем закрытую группу перед товаром
  else
  if ((Item1.StateIndex = 0) and (Item2.StateIndex = 0)) or ((Item1.StateIndex = 2) and (Item2.StateIndex = 2)) then //если статус у элементов одинаков
    Compare := AnsiCompareStr(Item1.SubItems[1], Item2.SubItems[1]) //сортируем по алфавиту
  else
    Compare := 0 //во всех остальных случаях не меняем положения элементов
end;

end.
