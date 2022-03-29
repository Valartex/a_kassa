object formCorrectionInfo: TformCorrectionInfo
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'formCorrectionInfo'
  ClientHeight = 600
  ClientWidth = 1024
  Color = clBtnFace
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
    BevelInner = bvSpace
    Caption = 'sPanel1'
    ShowCaption = False
    TabOrder = 0
    ExplicitLeft = 352
    ExplicitTop = 232
    ExplicitWidth = 185
    ExplicitHeight = 41
    DesignSize = (
      1024
      600)
    object sLabel1: TsLabel
      Left = 2
      Top = 2
      Width = 1020
      Height = 29
      Align = alTop
      Alignment = taCenter
      Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1076#1083#1103' '#1095#1077#1082#1072' '#1082#1086#1088#1088#1077#1082#1094#1080#1080
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Tahoma'
      Font.Style = []
      ExplicitWidth = 375
    end
    object sLabel2: TsLabel
      Left = 8
      Top = 194
      Width = 106
      Height = 13
      Caption = #1044#1086#1082#1091#1084#1077#1085#1090' '#1086#1089#1085#1086#1074#1072#1085#1080#1077
    end
    object sLabel3: TsLabel
      Left = 8
      Top = 242
      Width = 145
      Height = 13
      Caption = #1053#1086#1084#1077#1088' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' '#1086#1089#1085#1086#1074#1072#1085#1080#1103
    end
    object sLabel4: TsLabel
      Left = 8
      Top = 290
      Width = 140
      Height = 13
      Caption = #1044#1072#1090#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' '#1086#1089#1085#1086#1074#1072#1085#1080#1103
    end
    object editParentDoc: TsEdit
      Left = 176
      Top = 191
      Width = 840
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
    object editParentDocNum: TsEdit
      Left = 176
      Top = 239
      Width = 840
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
    end
    object sPanel7: TsPanel
      Left = 2
      Top = 557
      Width = 1020
      Height = 41
      Align = alBottom
      Caption = 'sPanel6'
      ShowCaption = False
      TabOrder = 2
      OnResize = PanelResize
      object btnOk: TsButton
        Left = 0
        Top = 1
        Width = 342
        Height = 40
        Caption = #1055#1086#1076#1090#1074#1077#1088#1076#1080#1090#1100
        TabOrder = 1
        OnClick = btnOkClick
      end
      object btnCancel: TsButton
        Left = 343
        Top = 1
        Width = 355
        Height = 40
        Cancel = True
        Caption = #1054#1090#1084#1077#1085#1072
        ModalResult = 2
        TabOrder = 0
      end
    end
    object editParentDocDate: TsMaskEdit
      Left = 176
      Top = 287
      Width = 838
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      EditMask = '99/99/9999;1;_'
      MaxLength = 10
      TabOrder = 3
      Text = '  .  .    '
      CheckOnExit = True
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
    Left = 304
    Top = 16
  end
end
