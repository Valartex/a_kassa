unit AboutUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, sSpeedButton,
  Vcl.StdCtrls, sLabel, Winapi.ShellAPI;

type
  TframeAbout = class(TFrame)
    sWebLabel2: TsWebLabel;
    sLabel1: TsLabel;
    btnCheckUpdates: TsSpeedButton;
    btnDevelopers: TsSpeedButton;
    btnYoutube: TsSpeedButton;
    btnVK: TsSpeedButton;
    procedure btnCheckUpdatesClick(Sender: TObject);
    procedure btnDevelopersClick(Sender: TObject);
    procedure btnYoutubeClick(Sender: TObject);
    procedure btnVKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

//проверить обновления
procedure TframeAbout.btnCheckUpdatesClick(Sender: TObject);
begin
  ShellExecute(Handle, 'open', PChar('https://www.akassa.online/'), nil, nil, SW_SHOW);
end;

//написать разработчикам
procedure TframeAbout.btnDevelopersClick(Sender: TObject);
begin
  ShellExecute(Handle, 'open', PChar('https://www.akassa.online/#contact'), nil, nil, SW_SHOW);
end;

//youtube
procedure TframeAbout.btnYoutubeClick(Sender: TObject);
begin
  ShellExecute(Handle, 'open', PChar('https://www.youtube.com/channel/UCBZFRnjPDYaar9unUcfKoRw/'), nil, nil, SW_SHOW);
end;

//VK
procedure TframeAbout.btnVKClick(Sender: TObject);
begin
  ShellExecute(Handle, 'open', PChar('https://vk.com/a_kassa'), nil, nil, SW_SHOW);
end;

end.
