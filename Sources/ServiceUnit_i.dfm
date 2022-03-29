object frameService: TframeService
  Left = 0
  Top = 0
  Width = 936
  Height = 567
  DoubleBuffered = True
  ParentDoubleBuffered = False
  TabOrder = 0
  OnEnter = FrameEnter
  OnExit = FrameExit
  DesignSize = (
    936
    567)
  object btnLoadLPScale: TsSpeedButton
    Tag = 80
    Left = 2
    Top = 182
    Width = 934
    Height = 50
    Anchors = [akLeft, akRight, akBottom]
    Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1076#1072#1085#1085#1099#1077' '#1074' '#1074#1077#1089#1099' '#1089' '#1055#1069
    Enabled = False
    SkinData.SkinSection = 'BUTTON'
  end
  object btnExternalApp: TsSpeedButton
    Tag = 80
    Left = 2
    Top = 284
    Width = 934
    Height = 50
    Anchors = [akLeft, akRight, akBottom]
    Caption = #1047#1072#1087#1091#1089#1090#1080#1090#1100' '#1074#1085#1077#1096#1085#1077#1077' '#1087#1088#1080#1083#1086#1078#1077#1085#1080#1077
    OnClick = btnExternalAppClick
    SkinData.SkinSection = 'BUTTON'
  end
  object btnCloseProgram: TsSpeedButton
    Tag = 80
    Left = 2
    Top = 335
    Width = 934
    Height = 50
    Anchors = [akLeft, akRight, akBottom]
    Caption = #1047#1072#1082#1088#1099#1090#1100' '#1087#1088#1086#1075#1088#1072#1084#1084#1091
    OnClick = btnCloseProgramClick
    SkinData.SkinSection = 'BUTTON'
  end
  object btnPowerOff: TsSpeedButton
    Tag = 80
    Left = 2
    Top = 437
    Width = 934
    Height = 50
    Anchors = [akLeft, akRight, akBottom]
    Caption = #1042#1099#1082#1083#1102#1095#1080#1090#1100' '#1082#1086#1084#1087#1100#1102#1090#1077#1088
    OnClick = btnPowerOffClick
    SkinData.SkinSection = 'BUTTON'
  end
  object btnUploadReport: TsSpeedButton
    Tag = 80
    Left = 2
    Top = 131
    Width = 934
    Height = 50
    Anchors = [akLeft, akRight, akBottom]
    Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1086#1090#1095#1105#1090' '#1086' '#1087#1088#1086#1076#1072#1078#1072#1093
    Enabled = False
    SkinData.SkinSection = 'BUTTON'
  end
  object btnLoadData: TsSpeedButton
    Tag = 80
    Left = 2
    Top = 80
    Width = 934
    Height = 50
    Anchors = [akLeft, akRight, akBottom]
    Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1076#1072#1085#1085#1099#1077' '#1074' '#1087#1088#1086#1075#1088#1072#1084#1084#1091
    OnClick = btnLoadDataClick
    SkinData.SkinSection = 'BUTTON'
  end
  object btnSynchroTime: TsSpeedButton
    Tag = 80
    Left = 2
    Top = 233
    Width = 934
    Height = 50
    Anchors = [akLeft, akRight, akBottom]
    Caption = #1057#1080#1085#1093#1088#1086#1085#1080#1079#1080#1088#1086#1074#1072#1090#1100' '#1074#1088#1077#1084#1103' '#1092#1080#1089#1082#1072#1083#1100#1085#1086#1075#1086' '#1088#1077#1075#1080#1089#1090#1088#1072#1090#1086#1088#1072' '#1089' '#1082#1086#1084#1087#1100#1102#1090#1077#1088#1086#1084
    OnClick = btnSynchroTimeClick
    SkinData.SkinSection = 'BUTTON'
  end
  object btnCloseSession: TsSpeedButton
    Tag = 80
    Left = 2
    Top = 386
    Width = 934
    Height = 50
    Anchors = [akLeft, akRight, akBottom]
    Caption = #1047#1072#1082#1088#1099#1090#1100' '#1089#1084#1077#1085#1091
    OnClick = btnCloseSessionClick
    SkinData.SkinSection = 'BUTTON'
  end
end
