object formSelectCheqType: TformSelectCheqType
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'formSelectCheqType'
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
  OnCloseQuery = FormCloseQuery
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
    object sPanel2: TsPanel
      Left = 1
      Top = 1
      Width = 511
      Height = 598
      Align = alLeft
      BevelOuter = bvNone
      Caption = 'sPanel2'
      ShowCaption = False
      TabOrder = 0
      DesignSize = (
        511
        598)
      object btnSale: TsSpeedButton
        Tag = 80
        Left = 2
        Top = 173
        Width = 506
        Height = 80
        Anchors = [akLeft, akTop, akRight]
        Caption = #1055#1088#1086#1076#1072#1078#1072
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        OnClick = btnSaleClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnRefund: TsSpeedButton
        Tag = 80
        Left = 2
        Top = 259
        Width = 506
        Height = 80
        Anchors = [akLeft, akTop, akRight]
        Caption = #1042#1086#1079#1074#1088#1072#1090
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        OnClick = btnSaleClick
        SkinData.SkinSection = 'BUTTON'
      end
      object sSpeedButton2: TsSpeedButton
        Tag = 80
        Left = 2
        Top = 345
        Width = 506
        Height = 80
        Anchors = [akLeft, akTop, akRight]
        Caption = #1050#1086#1088#1088#1077#1082#1094#1080#1103' '#1088#1072#1089#1093#1086#1076#1072
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        OnClick = btnSaleClick
        SkinData.SkinSection = 'BUTTON'
      end
    end
    object sPanel3: TsPanel
      Left = 512
      Top = 1
      Width = 511
      Height = 598
      Align = alClient
      BevelOuter = bvNone
      Caption = 'sPanel3'
      ShowCaption = False
      TabOrder = 1
      DesignSize = (
        511
        598)
      object sSpeedButton3: TsSpeedButton
        Tag = 80
        Left = 3
        Top = 173
        Width = 507
        Height = 80
        Anchors = [akLeft, akTop, akRight]
        Caption = #1056#1072#1089#1093#1086#1076
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        OnClick = btnSaleClick
        SkinData.SkinSection = 'BUTTON'
      end
      object sSpeedButton4: TsSpeedButton
        Tag = 80
        Left = 3
        Top = 259
        Width = 507
        Height = 80
        Anchors = [akLeft, akTop, akRight]
        Caption = #1042#1086#1079#1074#1088#1072#1090' '#1088#1072#1089#1093#1086#1076#1072
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        OnClick = btnSaleClick
        SkinData.SkinSection = 'BUTTON'
      end
      object sSpeedButton1: TsSpeedButton
        Tag = 80
        Left = 3
        Top = 345
        Width = 506
        Height = 80
        Anchors = [akLeft, akTop, akRight]
        Caption = #1050#1086#1088#1088#1077#1082#1094#1080#1103' '#1087#1088#1080#1093#1086#1076#1072
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        OnClick = btnSaleClick
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
    Left = 24
    Top = 544
  end
end
