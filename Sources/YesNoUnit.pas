unit YesNoUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, sLabel,
  sButton, sPanel, sSkinProvider, Vcl.Buttons;

type
  TformYesNo = class(TForm)
    sPanel1: TsPanel;
    labelMessage: TsLabel;
    Timer1: TTimer;
    sSkinProvider1: TsSkinProvider;
    Panel1: TsPanel;
    btnYes: TsButton;
    btnNo: TsButton;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    btnYesCaption: String; // текст на кнопке Да/Ok
    yesButtonDelay: Integer; // задержка доступности кнопки Да/Ok
  public
    { Public declarations }
    messageText: String; // текст сообщения
    dialogType: SmallInt; // тип диалога: 0 - вопрос; 1 - сообщение
    block: Boolean; // блокировать или нет кнопку Да/Ok
  end;

var
  formYesNo: TformYesNo;

implementation

{$R *.dfm}

uses DBUnit, CommonUnit;

procedure TformYesNo.FormCreate(Sender: TObject);
begin
  yesButtonDelay := DM1.GetCommonSettings.blockYesButton
end;

procedure TformYesNo.FormShow(Sender: TObject);
begin
  ScaleWindow(formYesNo, 100); // масштабируем окно под текущее разрешение

  labelMessage.Caption := messageText;

  btnYes.Left := 1;

  if dialogType = 0 then
    begin
      btnYesCaption := 'Да';

      btnYes.Width := Panel1.Width div 2 - 1;
      btnNo.Left := btnYes.Left + btnYes.Width + 1;
      btnNo.Width := Panel1.Width - btnNo.Left - 1;
    end
  else
    begin
      btnYesCaption := 'OK';
      btnNo.Visible := False;

      btnYes.Width := Panel1.Width - 2;
    end;

  if yesButtonDelay = 0 then
    begin
      btnYes.Caption := btnYesCaption;
      btnYes.Enabled := True;
    end
  else
    if block then
      begin
        btnYes.Caption := btnYesCaption + ' (' + IntToStr(yesButtonDelay) + ')';
      end;
end;

procedure TformYesNo.Timer1Timer(Sender: TObject);
begin
  Dec(yesButtonDelay);

  if yesButtonDelay > 0 then
    btnYes.Caption := btnYesCaption + ' (' + IntToStr(yesButtonDelay) + ')'
  else
    begin
      btnYes.Caption := btnYesCaption;
      btnYes.Enabled := True
    end;
end;

end.
