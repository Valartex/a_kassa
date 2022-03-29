unit DocumentsUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, sSkinProvider, Vcl.Buttons,
  sSpeedButton, Vcl.ComCtrls, sListView, Vcl.ExtCtrls, sPanel;

type
  TformDocuments = class(TForm)
    sSkinProvider1: TsSkinProvider;
    sPanel1: TsPanel;
    lvDocuments: TsListView;
    sPanel2: TsPanel;
    btnSelect: TsSpeedButton;
    btnClose: TsSpeedButton;
    btnUp: TsSpeedButton;
    btnDown: TsSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure PanelResize(Sender: TObject);
    procedure btnUpClick(Sender: TObject);
    procedure btnDownClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
  private
    { Private declarations }
  public
    Status      : Integer;
    SelectedCode: Integer;
  end;

var
  formDocuments: TformDocuments;

implementation

{$R *.dfm}

uses CommonUnit, DBUnit;

// прокрутить на одну страницу вверх
procedure TformDocuments.btnUpClick(Sender: TObject);
begin
  LVScrollPage(lvDocuments, True);
end;

// прокрутить на одну страницу вниз
procedure TformDocuments.btnDownClick(Sender: TObject);
begin
  LVScrollPage(lvDocuments, False);
end;

procedure TformDocuments.FormShow(Sender: TObject);
var
  receiptsArray: TReceiptsArray;
  i            : Integer;
  LI           : TListItem;
begin
  ScaleWindow(Self, 100); // масштабируем окно под текущее разрешение

  receiptsArray := DM1.GetReceipts(-1, Status); // запрашиваем все отмененные (не закрытые) чеки

  for i := 0 to Length(receiptsArray) - 1 do
    begin
      LI := lvDocuments.Items.Add;
      LI.Caption := IntToStr(receiptsArray[i].receiptID);                           // код документа
      LI.SubItems.Add(DM1.InternalCodeToReceiptType(receiptsArray[i].receiptType)); // тип документа
      LI.SubItems.Add(DateToStr(receiptsArray[i].receiptCloseDate));                // дата закрытия или отмены документа
      LI.SubItems.Add(TimeToStr(receiptsArray[i].receiptCloseTime));                // время закрытия или отмены документа
      LI.SubItems.Add(IntToStr(receiptsArray[i].receiptSessionNumber));             // номер смены

      // статус чека
      case receiptsArray[i].receiptStatus of
        0: LI.SubItems.Add('Открыт');
        1: LI.SubItems.Add('Закрыт');
        2: LI.SubItems.Add('Отменён');
      else
        LI.SubItems.Add('Не определён');
      end;

      LI.SubItems.Add(CurrToStrF(receiptsArray[i].receiptSumm, ffFixed, 2));          // сумма документа
      LI.SubItems.Add(DM1.GetCashierData(receiptsArray[i].receiptCashierCode).cName); // имя кассира (запрос имени лучше перенести в GetReceipts)
  end;
end;

// изменение ширины и положения кнопок на панелях
procedure TformDocuments.PanelResize(Sender: TObject);
begin
  AlignPanelControls(Sender as TsPanel)
end;

// отмена
procedure TformDocuments.btnCloseClick(Sender: TObject);
begin
  Close
end;

// выбрать документ
procedure TformDocuments.btnSelectClick(Sender: TObject);
var
  SelectedItem: TListItem;
begin
  SelectedItem := lvDocuments.Selected;

  if SelectedItem = nil then
  begin
    YesNoDialog('Укажите тот документ, который хотите восстановить.', 1, False);
    Exit
  end;

  SelectedCode := StrToInt(SelectedItem.Caption);

  Close
end;

end.
