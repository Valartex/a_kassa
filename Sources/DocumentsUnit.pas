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

// ���������� �� ���� �������� �����
procedure TformDocuments.btnUpClick(Sender: TObject);
begin
  LVScrollPage(lvDocuments, True);
end;

// ���������� �� ���� �������� ����
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
  ScaleWindow(Self, 100); // ������������ ���� ��� ������� ����������

  receiptsArray := DM1.GetReceipts(-1, Status); // ����������� ��� ���������� (�� ��������) ����

  for i := 0 to Length(receiptsArray) - 1 do
    begin
      LI := lvDocuments.Items.Add;
      LI.Caption := IntToStr(receiptsArray[i].receiptID);                           // ��� ���������
      LI.SubItems.Add(DM1.InternalCodeToReceiptType(receiptsArray[i].receiptType)); // ��� ���������
      LI.SubItems.Add(DateToStr(receiptsArray[i].receiptCloseDate));                // ���� �������� ��� ������ ���������
      LI.SubItems.Add(TimeToStr(receiptsArray[i].receiptCloseTime));                // ����� �������� ��� ������ ���������
      LI.SubItems.Add(IntToStr(receiptsArray[i].receiptSessionNumber));             // ����� �����

      // ������ ����
      case receiptsArray[i].receiptStatus of
        0: LI.SubItems.Add('������');
        1: LI.SubItems.Add('������');
        2: LI.SubItems.Add('������');
      else
        LI.SubItems.Add('�� ��������');
      end;

      LI.SubItems.Add(CurrToStrF(receiptsArray[i].receiptSumm, ffFixed, 2));          // ����� ���������
      LI.SubItems.Add(DM1.GetCashierData(receiptsArray[i].receiptCashierCode).cName); // ��� ������� (������ ����� ����� ��������� � GetReceipts)
  end;
end;

// ��������� ������ � ��������� ������ �� �������
procedure TformDocuments.PanelResize(Sender: TObject);
begin
  AlignPanelControls(Sender as TsPanel)
end;

// ������
procedure TformDocuments.btnCloseClick(Sender: TObject);
begin
  Close
end;

// ������� ��������
procedure TformDocuments.btnSelectClick(Sender: TObject);
var
  SelectedItem: TListItem;
begin
  SelectedItem := lvDocuments.Selected;

  if SelectedItem = nil then
  begin
    YesNoDialog('������� ��� ��������, ������� ������ ������������.', 1, False);
    Exit
  end;

  SelectedCode := StrToInt(SelectedItem.Caption);

  Close
end;

end.
