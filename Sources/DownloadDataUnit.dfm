object formDownloadData: TformDownloadData
  Left = 0
  Top = 0
  AlphaBlend = True
  AlphaBlendValue = 240
  BorderStyle = bsNone
  Caption = 'formDownloadData'
  ClientHeight = 100
  ClientWidth = 700
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  DesignSize = (
    700
    100)
  PixelsPerInch = 96
  TextHeight = 13
  object sLabel1: TsLabel
    Left = 24
    Top = 26
    Width = 100
    Height = 13
    Caption = #1047#1072#1075#1088#1091#1079#1082#1072' '#1076#1072#1085#1085#1099#1093'...'
  end
  object ProgressBar1: TsProgressBar
    Left = 24
    Top = 45
    Width = 649
    Height = 17
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
  end
  object sSkinProvider1: TsSkinProvider
    AddedTitle.Font.Charset = DEFAULT_CHARSET
    AddedTitle.Font.Color = clNone
    AddedTitle.Font.Height = -11
    AddedTitle.Font.Name = 'Tahoma'
    AddedTitle.Font.Style = []
    SkinData.SkinSection = 'FORM'
    TitleButtons = <>
    Left = 664
    Top = 48
  end
  object timerInit: TTimer
    Interval = 1
    OnTimer = timerInitTimer
    Left = 664
  end
end
