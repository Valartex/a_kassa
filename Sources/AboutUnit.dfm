object frameAbout: TframeAbout
  Left = 0
  Top = 0
  Width = 936
  Height = 567
  DoubleBuffered = True
  ParentDoubleBuffered = False
  TabOrder = 0
  DesignSize = (
    936
    567)
  object sWebLabel2: TsWebLabel
    Left = 0
    Top = 0
    Width = 936
    Height = 29
    Align = alTop
    Alignment = taCenter
    Caption = 'a_kassa v. 2021.01.28'
    ParentFont = False
    Layout = tlCenter
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Tahoma'
    Font.Style = []
    HoverFont.Charset = DEFAULT_CHARSET
    HoverFont.Color = clWindowText
    HoverFont.Height = -24
    HoverFont.Name = 'Tahoma'
    HoverFont.Style = []
    ExplicitWidth = 239
  end
  object sLabel1: TsLabel
    Left = 0
    Top = 29
    Width = 936
    Height = 13
    Align = alTop
    Alignment = taCenter
    Caption = #1057#1080#1089#1090#1077#1084#1072' '#1072#1074#1090#1086#1084#1072#1090#1080#1079#1072#1094#1080#1080' '#1087#1088#1086#1076#1072#1078'.'
    ExplicitWidth = 168
  end
  object btnCheckUpdates: TsSpeedButton
    Tag = 80
    Left = 2
    Top = 169
    Width = 934
    Height = 50
    Anchors = [akLeft, akRight, akBottom]
    Caption = #1055#1088#1086#1074#1077#1088#1080#1090#1100' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1077
    OnClick = btnCheckUpdatesClick
    SkinData.SkinSection = 'BUTTON'
  end
  object btnDevelopers: TsSpeedButton
    Tag = 80
    Left = 2
    Top = 220
    Width = 934
    Height = 50
    Anchors = [akLeft, akRight, akBottom]
    Caption = #1053#1072#1087#1080#1089#1072#1090#1100' '#1088#1072#1079#1088#1072#1073#1086#1090#1095#1080#1082#1072#1084
    OnClick = btnDevelopersClick
    SkinData.SkinSection = 'BUTTON'
  end
  object btnYoutube: TsSpeedButton
    Tag = 80
    Left = 2
    Top = 271
    Width = 934
    Height = 50
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'YouTube-'#1082#1072#1085#1072#1083
    OnClick = btnYoutubeClick
    SkinData.SkinSection = 'BUTTON'
  end
  object btnVK: TsSpeedButton
    Tag = 80
    Left = 2
    Top = 322
    Width = 934
    Height = 50
    Anchors = [akLeft, akRight, akBottom]
    Caption = #1043#1088#1091#1087#1087#1072' VK'
    OnClick = btnVKClick
    SkinData.SkinSection = 'BUTTON'
  end
end
