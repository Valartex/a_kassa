object formYesNo: TformYesNo
  Left = 0
  Top = 0
  AlphaBlend = True
  BorderStyle = bsNone
  Caption = 'formYesNo'
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
      Height = 547
      Align = alClient
      Alignment = taCenter
      AutoSize = False
      Caption = 'labelMessage'
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
    object Panel1: TsPanel
      Left = 1
      Top = 548
      Width = 1022
      Height = 51
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'Panel1'
      ShowCaption = False
      TabOrder = 0
      DesignSize = (
        1022
        51)
      object btnYes: TsButton
        Left = 235
        Top = 0
        Width = 150
        Height = 50
        Anchors = [akTop]
        Caption = #1044#1072' (5)'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Tahoma'
        Font.Style = []
        ModalResult = 6
        ParentFont = False
        TabOrder = 0
      end
      object btnNo: TsButton
        Left = 639
        Top = 0
        Width = 150
        Height = 50
        Anchors = [akTop]
        Cancel = True
        Caption = #1053#1077#1090
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Tahoma'
        Font.Style = []
        ModalResult = 2
        ParentFont = False
        TabOrder = 1
      end
    end
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 424
    Top = 96
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
end
