unit SelectFileUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, sSkinProvider, Vcl.ComCtrls,
  sTreeView, acShellCtrls, Vcl.Buttons, sSpeedButton, Vcl.ExtCtrls, sPanel,
  Vcl.StdCtrls, sButton;

type
  TformSelectFile = class(TForm)
    sSkinProvider1: TsSkinProvider;
    sPanel7: TsPanel;
    ShellTreeView1: TsShellTreeView;
    sPanel1: TsPanel;
    btnCancel: TsButton;
    btnSelectFile: TsButton;
    procedure PanelResize(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnSelectFileClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ShellTreeView1Change(Sender: TObject; Node: TTreeNode);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formSelectFile: TformSelectFile;

implementation

{$R *.dfm}

uses CommonUnit;

//изменение ширины и положения кнопок на панелях
procedure TformSelectFile.PanelResize(Sender: TObject);
begin
  AlignPanelControls(Sender as TsPanel)
end;

procedure TformSelectFile.ShellTreeView1Change(Sender: TObject;
  Node: TTreeNode);
begin
  btnSelectFile.Enabled := FileExists(ShellTreeView1.Path) //если выбран файл, то делаем кнопку выбора активной
end;

procedure TformSelectFile.btnSelectFileClick(Sender: TObject);
begin
  Hint := ShellTreeView1.Path //запоминаем в hint выбранный файл
end;

//обработка нажатий клавиш клавиатуры
procedure TformSelectFile.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close
end;

procedure TformSelectFile.FormShow(Sender: TObject);
begin
  ScaleWindow(Self, 100); //масштабируем окно под текущее разрешение

  ShellTreeView1.ObjectTypes := [otFolders, otNonFolders];
  if Trim(Hint) <> '' then
  try
    ShellTreeView1.Path := Hint;
    ShellTreeView1.SetFocus;
  except
  end;
end;

end.
