unit SelectCashierUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, sSkinProvider, Vcl.Buttons,
  sSpeedButton, Vcl.ExtCtrls, sPanel, Vcl.ComCtrls, sPageControl, CommCtrl,
  Vcl.StdCtrls, sEdit, sLabel;

type
  TsPageControl = class(sPageControl.TsPageControl)
  private
    procedure TCMAdjustRect(var Msg: TMessage); message TCM_ADJUSTRECT;
  end;

  TformSelectCashier = class(TForm)
    sSkinProvider1: TsSkinProvider;
    sPageControl1: TsPageControl;
    sTabSheet1: TsTabSheet;
    sTabSheet2: TsTabSheet;
    panelButtons: TsPanel;
    panelScroll: TsPanel;
    btnScrollUp: TsSpeedButton;
    btnScrollDown: TsSpeedButton;
    sPanel1: TsPanel;
    btnCancel: TsSpeedButton;
    btnEnter: TsSpeedButton;
    labelCashier: TsLabel;
    panelPassword: TsPanel;
    btn0: TsSpeedButton;
    btn1: TsSpeedButton;
    btn2: TsSpeedButton;
    btn3: TsSpeedButton;
    btn4: TsSpeedButton;
    btn5: TsSpeedButton;
    btn6: TsSpeedButton;
    btn7: TsSpeedButton;
    btn8: TsSpeedButton;
    btn9: TsSpeedButton;
    btnBS: TsSpeedButton;
    btnC: TsSpeedButton;
    editPassword: TsEdit;
    procedure FormShow(Sender: TObject);
    procedure btnCashierClick(Sender: TObject);
    procedure btnScrollUpClick(Sender: TObject);
    procedure btnScrollDownClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure PanelResize(Sender: TObject);
    procedure btnEnterClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure NumericButtonClick(Sender: TObject);
    procedure btnBSClick(Sender: TObject);
    procedure btnCClick(Sender: TObject);
    procedure editPasswordKeyPress(Sender: TObject; var Key: Char);
  private
    Access: Boolean;
  public
    const
      btnIndent: Integer = 5;
      btnHeight: Integer = 50;
  end;

var
  formSelectCashier: TformSelectCashier;

implementation

{$R *.dfm}

uses DBUnit, CommonUnit;

//��������� ������ � ��������� ������ �� �������
procedure TformSelectCashier.PanelResize(Sender: TObject);
begin
  AlignPanelControls(Sender as TsPanel)
end;

// ������� ������� � PageControl (������������ ������ �� ���������� ����� �������� ��� Style=tsButtons, �� ������ ������ ����� ������)
procedure TsPageControl.TCMAdjustRect(var Msg: TMessage);
begin
  if self.TabPosition = tpTop then
    begin
      PRect(Msg.LParam)^.Left  := 0;
      PRect(Msg.LParam)^.Right := self.ClientWidth;
      Dec(PRect(Msg.LParam)^.Top, 4);
      PRect(Msg.LParam)^.Bottom := self.ClientHeight;
    end
  else
    inherited;
end;

// ������ �� �������
procedure TformSelectCashier.btnCashierClick(Sender: TObject);
begin
  Tag := (Sender as TsSpeedButton).Tag; // ���������� ��� �������

  // ����������� ������
  labelCashier.Caption          := (Sender as TsSpeedButton).Caption;
  sPageControl1.ActivePageIndex := 1;
  editPassword.SetFocus;
end;

// ���������� ����� ����
procedure TformSelectCashier.btnScrollDownClick(Sender: TObject);
var
  LastButton: TsSpeedButton;
begin
  LastButton := panelButtons.Components[panelButtons.ComponentCount - 1] as TsSpeedButton; // ��������� ������
  if LastButton.Top > (panelButtons.Height - LastButton.Height - btnIndent)  then
    panelButtons.ScrollBy(0, -LastButton.Height);
end;

// ���������� ����� �����
procedure TformSelectCashier.btnScrollUpClick(Sender: TObject);
var
  FirstButton: TsSpeedButton;
begin
  FirstButton := panelButtons.Components[0] as TsSpeedButton; // ������ ������
  if FirstButton.Top < btnIndent  then
    panelButtons.ScrollBy(0, FirstButton.Height);
end;

procedure TformSelectCashier.editPasswordKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
    btnEnterClick(Sender)
end;

// ������ ���������� �� �������� ����
procedure TformSelectCashier.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := Access // ���� ������ ������������ � ��������� ����� ������, �� ���� ����� ���������
end;

procedure TformSelectCashier.FormShow(Sender: TObject);
var
  Cashiers                                  : TCashierArray;
  btnCashier                                : TsSpeedButton;
  BtnWidth, i, BtnLeft, BtnTop, NewBtnIndent: Integer;
  Bmp                                       : TBitmap;
  Pic                                       : TPicture;
begin
  Access := False; // ������ ������� ����, ���� �� ������ ������������ � �� ����� ���������� ������

  Cashiers := DM1.GetCashires;

  BtnWidth := (panelButtons.Width - BtnIndent) div 3 - BtnIndent; // ������ ������; �� ������ ������ �������� 1 ������ ����� � �� ������ ������ �������� ������ ������; ����� 3 ������

  // ��������� ������ ������ ����� �������
  BtnLeft := BtnIndent;
  BtnTop  := BtnIndent;

  for i := 0 to Length(Cashiers) - 1 do
    begin
      btnCashier                      := TsSpeedButton.Create(panelButtons);
      btnCashier.Parent               := panelButtons;
      btnCashier.Width                := BtnWidth;
      btnCashier.Height               := BtnHeight;
      btnCashier.Left                 := BtnLeft;
      btnCashier.Top                  := BtnTop;
      btnCashier.Alignment            := taLeftJustify;
      btnCashier.SkinData.SkinSection := 'BUTTON';

      btnCashier.Caption              := Cashiers[i].cName;
      btnCashier.Tag                  := Cashiers[i].cID;
      btnCashier.Hint                 := Cashiers[i].cPhoto;
      btnCashier.OnClick              := btnCashierClick;

      BtnLeft                         := BtnLeft + BtnWidth + BtnIndent;

      if (BtnLeft + BtnWidth + BtnIndent > panelButtons.Width)  then //���� ��������� ������ �� �������, �� ��������� � �� ����� ������
        begin
          BtnLeft := BtnIndent;
          BtnTop  := BtnTop + BtnHeight + BtnIndent;
        end;

    end;

  ScaleWindow(Self, 0); // ������������ ���� ��� ������� ����������

  NewBtnIndent       := panelButtons.Controls[0].Left;                            // ����� ������ ����� ���������������
  BtnWidth           := (panelButtons.Width - NewBtnIndent) div 3 - NewBtnIndent; // ����� ������ ������, ������� ������ ���� ����� ���������������
  BtnLeft            := NewBtnIndent;

  panelPassword.Left := (panelPassword.Parent.Width - panelPassword.Width) div 2; // ����������� �� ������ ������ ����� ������

  Pic := TPicture.Create;

  Bmp             := TBitmap.Create;
  Bmp.PixelFormat := pf24bit;
//  Bmp.TransparentMode := tmAuto;
//  Bmp.Canvas.CopyMode := cmSrcCopy;

  // ����������� ������ � ������� �������� (�.�. ����� ��������������� ��� ��������� �� ��� ������) � ��������� ����
  for i := 0 to panelButtons.ComponentCount - 1 do
    begin
      btnCashier       := panelButtons.Components[i] as TsSpeedButton;

      btnCashier.Width := BtnWidth;
      btnCashier.Left  := BtnLeft;

      BtnLeft          := BtnLeft + BtnWidth + NewBtnIndent;

      if (BtnLeft + BtnWidth + NewBtnIndent > panelButtons.Width)  then //��������� � ��������� ������
        BtnLeft := NewBtnIndent;

      try
        if FileExists(btnCashier.Hint) then //���� ���� � ���� ������� ����������, �� ��������� ��� � ���������������� �� ������� ������
          Pic.LoadFromFile(btnCashier.Hint)
        else
          Pic.LoadFromFile(GetAppPath + 'Images\user.png');

        Bmp.Width  := Pic.Width * btnCashier.Height div Pic.Height;
        Bmp.Height := btnCashier.Height;
        Bmp.Canvas.StretchDraw(Rect(1, 1, Bmp.Width - 1, Bmp.Height - 1), Pic.Graphic);

        btnCashier.Glyph := Bmp;
      except
      end;

    end;

  Bmp.Free;
  Pic.Free;
end;

// ���������� ����� ��� ��������� �������������
procedure TformSelectCashier.btnEnterClick(Sender: TObject);
begin
  if (DM1.GetCashierData(Tag).cPassword = editPassword.Text) {or (DM1.GetCashierData(Tag).CBarcode = editPassword.Text)} then
    begin
      Access := True;
      Close
    end
  else
    YesNoDialog('�������� � �������!', 1, False)
end;

// ����� � ������ ������������
procedure TformSelectCashier.btnCancelClick(Sender: TObject);
begin
  sPageControl1.ActivePageIndex := 0
end;

// ������ � �������
procedure TformSelectCashier.NumericButtonClick(Sender: TObject);
begin
  if not editPassword.Focused then
    editPassword.SetFocus;

  keybd_event(Ord((Sender as TsSpeedButton).Caption[1]), 0, 0, 0);
  keybd_event(Ord((Sender as TsSpeedButton).Caption[1]), 0, KEYEVENTF_KEYUP, 0);
end;

// Backspase
procedure TformSelectCashier.btnBSClick(Sender: TObject);
begin
  if not editPassword.Focused then
    editPassword.SetFocus;

  keybd_event(VK_BACK, 0, 0, 0);
  keybd_event(VK_BACK, 0, KEYEVENTF_KEYUP, 0);
end;

// ������ "��������"
procedure TformSelectCashier.btnCClick(Sender: TObject);
begin
  editPassword.Clear
end;

end.

