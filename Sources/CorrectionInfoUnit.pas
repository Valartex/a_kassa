unit CorrectionInfoUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, sSkinProvider, Vcl.StdCtrls,
  sLabel, sEdit, sButton, Vcl.ExtCtrls, sPanel, Vcl.WinXPickers, Vcl.Mask,
  sMaskEdit;

type
  TformCorrectionInfo = class(TForm)
    sPanel1: TsPanel;
    sSkinProvider1: TsSkinProvider;
    editParentDoc: TsEdit;
    editParentDocNum: TsEdit;
    sLabel1: TsLabel;
    sPanel7: TsPanel;
    btnOk: TsButton;
    btnCancel: TsButton;
    sLabel2: TsLabel;
    sLabel3: TsLabel;
    sLabel4: TsLabel;
    editParentDocDate: TsMaskEdit;
    procedure PanelResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    ParentDoc, ParentDocNum: String;
    ParentDocDate: TDateTime;
  end;

var
  formCorrectionInfo: TformCorrectionInfo;

implementation

{$R *.dfm}

uses CommonUnit;

//��������� ������ � ��������� ������ �� �������
procedure TformCorrectionInfo.btnOkClick(Sender: TObject);
begin
  ParentDoc := Trim(editParentDoc.Text);
  ParentDocNum := Trim(editParentDocNum.Text);

  if ParentDoc = '' then
  begin
    YesNoDialog('�� �������� �������� ���������', 1, False);
    Exit
  end;

  if ParentDocNum = '' then
  begin
    YesNoDialog('�� �������� ����� ��������� ���������', 1, False);
    Exit
  end;

  if not TryStrToDate(editParentDocDate.Text, ParentDocDate) then
  begin
    YesNoDialog('�� ���������� ���� ��������� ���������', 1, False);
    Exit
  end;

  Close
end;

procedure TformCorrectionInfo.FormShow(Sender: TObject);
begin
  ScaleWindow(Self, 100); //������������ ���� ��� ������� ����������
end;

procedure TformCorrectionInfo.PanelResize(Sender: TObject);
begin
  AlignPanelControls(Sender as TsPanel)
end;

end.
