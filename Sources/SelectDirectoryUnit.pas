unit SelectDirectoryUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, sSkinProvider, Vcl.ComCtrls,
  sTreeView, acShellCtrls, Vcl.Buttons, sSpeedButton, Vcl.ExtCtrls, sPanel,
  Vcl.StdCtrls, sButton;

type
  TformSelectDirectory = class(TForm)
    sSkinProvider1: TsSkinProvider;
    sPanel7: TsPanel;
    ShellTreeView1: TsShellTreeView;
    sPanel1: TsPanel;
    btnCancel: TsButton;
    btnSelectDirectory: TsButton;
    procedure PanelResize(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnSelectDirectoryClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Path: String;
  end;

var
  formSelectDirectory: TformSelectDirectory;

implementation

{$R *.dfm}

uses CommonUnit;

//изменение ширины и положения кнопок на панелях
procedure TformSelectDirectory.PanelResize(Sender: TObject);
begin
  AlignPanelControls(Sender as TsPanel)
end;

procedure TformSelectDirectory.btnSelectDirectoryClick(Sender: TObject);
begin
  Path := ShellTreeView1.Path; //запоминаем выбранный каталог
  if Path[Length(Path)] <> '\' then
    Path := Path + '\'
end;

//обработка нажатий клавиш клавиатуры
procedure TformSelectDirectory.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close
end;

procedure TformSelectDirectory.FormShow(Sender: TObject);
begin
  ScaleWindow(Self, 100); //масштабируем окно под текущее разрешение

  if Trim(Path) <> '' then
  try
    ShellTreeView1.Path := Path;
    ShellTreeView1.SetFocus;
  except
  end;
end;

end.
