object formExchangeProcess: TformExchangeProcess
  Left = 0
  Top = 0
  AlphaBlend = True
  BorderStyle = bsNone
  Caption = 'formExchangeProcess'
  ClientHeight = 600
  ClientWidth = 1024
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object sPanel1: TsPanel
    Left = 0
    Top = 0
    Width = 1024
    Height = 600
    SkinData.SkinSection = 'DIALOG'
    Align = alClient
    Caption = 'sPanel1'
    ShowCaption = False
    TabOrder = 0
    object labelMessage: TsLabel
      Left = 1
      Top = 1
      Width = 1022
      Height = 548
      Align = alClient
      Alignment = taCenter
      AutoSize = False
      Caption = #1048#1076#1105#1090' '#1086#1073#1084#1077#1085'...'
      ParentFont = False
      Layout = tlCenter
      WordWrap = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Tahoma'
      Font.Style = []
      ExplicitWidth = 798
      ExplicitHeight = 376
    end
    object labelMark: TsLabel
      Left = 1
      Top = 549
      Width = 1022
      Height = 50
      Align = alBottom
      Alignment = taCenter
      AutoSize = False
      Layout = tlCenter
      ExplicitTop = 535
    end
  end
  object sSkinProvider1: TsSkinProvider
    AddedTitle.Font.Charset = DEFAULT_CHARSET
    AddedTitle.Font.Color = clNone
    AddedTitle.Font.Height = -11
    AddedTitle.Font.Name = 'Tahoma'
    AddedTitle.Font.Style = []
    SkinData.SkinSection = 'FORM'
    TitleButtons = <>
    Left = 24
    Top = 16
  end
  object timerInit: TTimer
    Interval = 1
    OnTimer = timerInitTimer
    Left = 24
    Top = 72
  end
end
