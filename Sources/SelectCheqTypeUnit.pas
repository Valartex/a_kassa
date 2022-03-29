unit SelectCheqTypeUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, sSkinProvider, Vcl.Buttons,
  sSpeedButton, Vcl.ExtCtrls, sPanel;

type
  TformSelectCheqType = class(TForm)
    sSkinProvider1: TsSkinProvider;
    sPanel1: TsPanel;
    sPanel2: TsPanel;
    btnSale: TsSpeedButton;
    btnRefund: TsSpeedButton;
    sPanel3: TsPanel;
    sSpeedButton3: TsSpeedButton;
    sSpeedButton4: TsSpeedButton;
    sSpeedButton1: TsSpeedButton;
    sSpeedButton2: TsSpeedButton;
    procedure btnSaleClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    CheqType: String;
  end;

var
  formSelectCheqType: TformSelectCheqType;

implementation

{$R *.dfm}

uses CommonUnit;

//��������� ������� �� ������ ����� ����
procedure TformSelectCheqType.btnSaleClick(Sender: TObject);
begin
  CheqType := (Sender as TsSpeedButton).Caption;
  Close
end;

//���� ������ �������, �� ������ ��� ����
procedure TformSelectCheqType.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := CheqType <> ''
end;

procedure TformSelectCheqType.FormShow(Sender: TObject);
var
  i: Integer;
begin
  ScaleWindow(Self, 100); //������������ ���� ��� ������� ����������
  sPanel2.Width := sPanel2.Parent.ClientWidth div 2;

  for i := 0 to ComponentCount - 1 do
    if Components[i] is TsSpeedButton then
      TsSpeedButton(Components[i]).Width := sPanel2.Width - TsSpeedButton(Components[i]).Left * 2
end;

end.
