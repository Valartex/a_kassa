object frameReports: TframeReports
  Left = 0
  Top = 0
  Width = 936
  Height = 567
  DoubleBuffered = True
  ParentDoubleBuffered = False
  TabOrder = 0
  OnEnter = FrameEnter
  OnExit = FrameExit
  object sPageControl2: TsPageControl
    Left = 0
    Top = 0
    Width = 936
    Height = 567
    ActivePage = sTabSheet7
    Align = alClient
    MultiLine = True
    TabHeight = 140
    TabOrder = 0
    TabPosition = tpRight
    TabWidth = 40
    RotateCaptions = True
    object sTabSheet7: TsTabSheet
      Caption = #1050#1072#1089#1089#1086#1074#1099#1077
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object btnXReport: TsSpeedButton
        Left = 3
        Top = 3
        Width = 262
        Height = 50
        Caption = 'X-'#1086#1090#1095#1105#1090
        OnClick = btnXReportClick
        SkinData.SkinSection = 'BUTTON'
      end
    end
    object sTabSheet8: TsTabSheet
      Caption = #1040#1085#1072#1083#1080#1090#1080#1095#1077#1089#1082#1080#1077
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
  end
  object FileOpenDialog1: TFileOpenDialog
    FavoriteLinks = <>
    FileTypes = <>
    Options = []
    Left = 436
    Top = 188
  end
end
