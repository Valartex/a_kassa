object formGoodsVisualSearch: TformGoodsVisualSearch
  Left = 0
  Top = 0
  ActiveControl = editSearch
  BorderStyle = bsNone
  Caption = 'formGoodsVisualSearch'
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
    inline frameGoodsTable1: TframeGoodsTable
      Left = 2
      Top = 44
      Width = 1020
      Height = 513
      Align = alClient
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 0
      ExplicitLeft = 2
      ExplicitTop = 44
      ExplicitWidth = 1020
      ExplicitHeight = 513
      inherited lvGoods: TsListView
        Width = 1020
        Height = 513
        ExplicitWidth = 1020
        ExplicitHeight = 513
      end
    end
    object panelButtons: TsPanel
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
        Left = 117
        Top = 1
        Width = 226
        Height = 40
        Caption = #1042#1099#1073#1088#1072#1090#1100
        OnClick = btnSelectClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnClose: TsSpeedButton
        Left = 344
        Top = 1
        Width = 226
        Height = 40
        Caption = #1054#1090#1084#1077#1085#1072
        OnClick = btnCloseClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnUp: TsSpeedButton
        Left = 571
        Top = 1
        Width = 228
        Height = 40
        Caption = #1042#1074#1077#1088#1093
        OnClick = btnUpClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnDown: TsSpeedButton
        Left = 800
        Top = 1
        Width = 222
        Height = 40
        Caption = #1042#1085#1080#1079
        OnClick = btnDownClick
        SkinData.SkinSection = 'BUTTON'
      end
    end
    object sPanel2: TsPanel
      Left = 2
      Top = 2
      Width = 1020
      Height = 42
      Align = alTop
      Caption = 'sPanel1'
      ShowCaption = False
      TabOrder = 2
      DesignSize = (
        1020
        42)
      object btnSearch: TsSpeedButton
        Left = 566
        Top = 0
        Width = 226
        Height = 40
        Anchors = [akTop, akRight]
        Caption = #1053#1072#1081#1090#1080
        OnClick = btnSearchClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnClearSearch: TsSpeedButton
        Left = 793
        Top = 0
        Width = 226
        Height = 40
        Anchors = [akTop, akRight]
        Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1092#1080#1083#1100#1090#1088' '#1087#1086#1080#1089#1082#1072
        OnClick = btnClearSearchClick
        SkinData.SkinSection = 'BUTTON'
      end
      object editSearch: TsEdit
        Left = 1
        Top = 1
        Width = 562
        Height = 41
        Alignment = taCenter
        Anchors = [akLeft, akTop, akRight, akBottom]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -27
        Font.Name = 'Tahoma'
        Font.Style = []
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
    Left = 16
    Top = 8
  end
end
