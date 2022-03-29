object formScanMark: TformScanMark
  Left = 0
  Top = 0
  AlphaBlend = True
  BorderStyle = bsNone
  Caption = 'formScanMark'
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
      Height = 497
      Align = alClient
      Alignment = taCenter
      AutoSize = False
      Caption = #1057#1095#1080#1090#1072#1081#1090#1077' '#1082#1086#1076' '#1084#1072#1088#1082#1080#1088#1086#1074#1082#1080'...'
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
      Top = 498
      Width = 1022
      Height = 50
      Align = alBottom
      Alignment = taCenter
      AutoSize = False
      Layout = tlCenter
      ExplicitTop = 535
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
      object btnCancel: TsButton
        Left = 0
        Top = 0
        Width = 1022
        Height = 50
        Anchors = [akLeft, akTop, akRight]
        Cancel = True
        Caption = #1054#1090#1084#1077#1085#1072
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Tahoma'
        Font.Style = []
        ModalResult = 2
        ParentFont = False
        TabOrder = 0
      end
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
end
