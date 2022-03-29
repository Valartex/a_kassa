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

//изменение ширины и положени€ кнопок на панел€х
procedure TformSelectCashier.PanelResize(Sender: TObject);
begin
  AlignPanelControls(Sender as TsPanel)
end;

// убираем отступы в PageControl (приблительно такого же результата можно добитьс€ при Style=tsButtons, но отступ сверху будет больше)
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

// нажали на кассира
procedure TformSelectCashier.btnCashierClick(Sender: TObject);
begin
  Tag := (Sender as TsSpeedButton).Tag; // запоминаем код кассира

  // запрашиваем пароль
  labelCashier.Caption          := (Sender as TsSpeedButton).Caption;
  sPageControl1.ActivePageIndex := 1;
  editPassword.SetFocus;
end;

// прокрутить форму вниз
procedure TformSelectCashier.btnScrollDownClick(Sender: TObject);
var
  LastButton: TsSpeedButton;
begin
  LastButton := panelButtons.Components[panelButtons.ComponentCount - 1] as TsSpeedButton; // последн€€ кнопка
  if LastButton.Top > (panelButtons.Height - LastButton.Height - btnIndent)  then
    panelButtons.ScrollBy(0, -LastButton.Height);
end;

// прокрутить форму вверх
procedure TformSelectCashier.btnScrollUpClick(Sender: TObject);
var
  FirstButton: TsSpeedButton;
begin
  FirstButton := panelButtons.Components[0] as TsSpeedButton; // перва€ кнопка
  if FirstButton.Top < btnIndent  then
    panelButtons.ScrollBy(0, FirstButton.Height);
end;

procedure TformSelectCashier.editPasswordKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
    btnEnterClick(Sender)
end;

// запрос разрешени€ на закрытие окна
procedure TformSelectCashier.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := Access // если выбран пользователь и правильно введЄн пароль, то окно можно закрывать
end;

procedure TformSelectCashier.FormShow(Sender: TObject);
var
  Cashiers                                  : TCashierArray;
  btnCashier                                : TsSpeedButton;
  BtnWidth, i, BtnLeft, BtnTop, NewBtnIndent: Integer;
  Bmp                                       : TBitmap;
  Pic                                       : TPicture;
begin
  Access := False; // нельз€ закрыть окно, пока не выбран пользователь и не введЄн правильный пароль

  Cashiers := DM1.GetCashires;

  BtnWidth := (panelButtons.Width - BtnIndent) div 3 - BtnIndent; // ширина кнопки; от ширины панели отнимаем 1 отступ слева и от каждой кнопки отнимаем отступ справа; всего 3 кнопки

  // положение первой кнопки равно отступу
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

      if (BtnLeft + BtnWidth + BtnIndent > panelButtons.Width)  then //если следующа€ кнопка не влезает, то переносим еЄ на новую строку
        begin
          BtnLeft := BtnIndent;
          BtnTop  := BtnTop + BtnHeight + BtnIndent;
        end;

    end;

  ScaleWindow(Self, 0); // масштабируем окно под текущее разрешение

  NewBtnIndent       := panelButtons.Controls[0].Left;                            // новый отступ после масштабировани€
  BtnWidth           := (panelButtons.Width - NewBtnIndent) div 3 - NewBtnIndent; // новый размер кнопки, который должен быть после масштабировани€
  BtnLeft            := NewBtnIndent;

  panelPassword.Left := (panelPassword.Parent.Width - panelPassword.Width) div 2; // выравниваем по центру панель ввода парол€

  Pic := TPicture.Create;

  Bmp             := TBitmap.Create;
  Bmp.PixelFormat := pf24bit;
//  Bmp.TransparentMode := tmAuto;
//  Bmp.Canvas.CopyMode := cmSrcCopy;

  // выравниваем кнопки с именами кассиров (т.к. после масштабировани€ они заполн€ют не всю ширину) и загружаем фото
  for i := 0 to panelButtons.ComponentCount - 1 do
    begin
      btnCashier       := panelButtons.Components[i] as TsSpeedButton;

      btnCashier.Width := BtnWidth;
      btnCashier.Left  := BtnLeft;

      BtnLeft          := BtnLeft + BtnWidth + NewBtnIndent;

      if (BtnLeft + BtnWidth + NewBtnIndent > panelButtons.Width)  then //переходим к следующей строке
        BtnLeft := NewBtnIndent;

      try
        if FileExists(btnCashier.Hint) then //если файл с фото кассира существует, то загружаем его с масштабированием по размеру кнопки
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

// попытатьс€ войти под выбранным пользователем
procedure TformSelectCashier.btnEnterClick(Sender: TObject);
begin
  if (DM1.GetCashierData(Tag).cPassword = editPassword.Text) {or (DM1.GetCashierData(Tag).CBarcode = editPassword.Text)} then
    begin
      Access := True;
      Close
    end
  else
    YesNoDialog('ќтказано в доступе!', 1, False)
end;

// назад к выбору пользовател€
procedure TformSelectCashier.btnCancelClick(Sender: TObject);
begin
  sPageControl1.ActivePageIndex := 0
end;

// кнопки с цифрами
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

// кнопка "ќчистить"
procedure TformSelectCashier.btnCClick(Sender: TObject);
begin
  editPassword.Clear
end;

end.

