object formGoodsSearchResult: TformGoodsSearchResult
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'formGoodsSearchResult'
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
    object lvGoods: TsListView
      Left = 2
      Top = 2
      Width = 1020
      Height = 555
      HighlightHeaders = False
      Align = alClient
      Columns = <
        item
          Caption = #1050#1086#1076
          MinWidth = 60
          Width = 60
        end
        item
          Caption = #1040#1088#1090#1080#1082#1091#1083
          MinWidth = 60
          Width = 60
        end
        item
          AutoSize = True
          Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
        end
        item
          Caption = #1062#1077#1085#1072
          MinWidth = 60
          Width = 60
        end>
      ColumnClick = False
      HideSelection = False
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
    end
    object sPanel2: TsPanel
      Left = 2
      Top = 557
      Width = 1020
      Height = 41
      Align = alBottom
      Caption = 'sPanel1'
      ShowCaption = False
      TabOrder = 1
      OnResize = PanelResize
      object btnSelect: TsSpeedButton
        Left = 12
        Top = 1
        Width = 250
        Height = 40
        Caption = #1042#1099#1073#1088#1072#1090#1100
        OnClick = btnSelectClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnClose: TsSpeedButton
        Left = 263
        Top = 1
        Width = 250
        Height = 40
        Caption = #1054#1090#1084#1077#1085#1072
        OnClick = btnCloseClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnUp: TsSpeedButton
        Left = 514
        Top = 1
        Width = 250
        Height = 40
        Caption = #1042#1074#1077#1088#1093
        OnClick = btnUpClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnDown: TsSpeedButton
        Left = 765
        Top = 1
        Width = 250
        Height = 40
        Caption = #1042#1085#1080#1079
        OnClick = btnDownClick
        SkinData.SkinSection = 'BUTTON'
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
    Left = 32
    Top = 280
  end
end
