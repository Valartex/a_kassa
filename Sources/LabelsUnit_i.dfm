object frameLabels: TframeLabels
  Left = 0
  Top = 0
  Width = 936
  Height = 567
  DoubleBuffered = True
  ParentDoubleBuffered = False
  TabOrder = 0
  OnEnter = FrameEnter
  object sPageControl2: TsPageControl
    Left = 0
    Top = 0
    Width = 936
    Height = 567
    ActivePage = sTabSheet8
    Align = alClient
    MultiLine = True
    TabHeight = 80
    TabOrder = 0
    TabPosition = tpRight
    TabWidth = 80
    RotateCaptions = True
    ShowFocus = False
    TabsLineSkin = 'BAR'
    object sTabSheet8: TsTabSheet
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099
      object sPanel5: TsPanel
        Left = 0
        Top = 317
        Width = 848
        Height = 42
        Align = alBottom
        BevelOuter = bvNone
        Caption = 'sPanel5'
        ShowCaption = False
        TabOrder = 0
        OnResize = PanelResize
        object btnAddGoods: TsSpeedButton
          Left = 0
          Top = 1
          Width = 124
          Height = 40
          Caption = #1044#1086#1073#1072#1074#1080#1090#1100
          OnClick = btnAddGoodsClick
          SkinData.SkinSection = 'BUTTON'
        end
        object btnAddAllGoods: TsSpeedButton
          Left = 125
          Top = 1
          Width = 124
          Height = 40
          Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1074#1089#1077
          OnClick = btnAddAllGoodsClick
          SkinData.SkinSection = 'BUTTON'
        end
        object btnUp: TsSpeedButton
          Left = 375
          Top = 1
          Width = 124
          Height = 40
          Caption = #1042#1074#1077#1088#1093
          OnClick = btnUpClick
          SkinData.SkinSection = 'BUTTON'
        end
        object btnDown: TsSpeedButton
          Left = 500
          Top = 1
          Width = 124
          Height = 40
          Caption = #1042#1085#1080#1079
          OnClick = btnDownClick
          SkinData.SkinSection = 'BUTTON'
        end
      end
      inline frameGoodsTable1: TframeGoodsTable
        Left = 0
        Top = 0
        Width = 848
        Height = 317
        Align = alClient
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 1
        ExplicitWidth = 848
        ExplicitHeight = 317
        inherited lvGoods: TsListView
          Width = 848
          Height = 317
          ExplicitWidth = 848
          ExplicitHeight = 317
        end
      end
      object sPanel1: TsPanel
        Left = 0
        Top = 359
        Width = 848
        Height = 200
        Align = alBottom
        BevelOuter = bvNone
        Caption = 'sPanel1'
        ShowCaption = False
        TabOrder = 2
        object sPanel2: TsPanel
          Left = 0
          Top = 0
          Width = 848
          Height = 23
          Align = alTop
          BevelOuter = bvNone
          Caption = 'sPanel5'
          ShowCaption = False
          TabOrder = 0
          OnResize = PanelResize
          object cbLabels: TsComboBox
            Left = 0
            Top = 1
            Width = 306
            Height = 21
            Style = csDropDownList
            ItemIndex = -1
            Sorted = True
            TabOrder = 0
            OnChange = cbLabelsChange
          end
          object cbPrinters: TsComboBox
            Left = 320
            Top = 1
            Width = 297
            Height = 21
            Style = csDropDownList
            ItemIndex = -1
            Sorted = True
            TabOrder = 1
            OnChange = cbLabelsChange
          end
        end
        object lvSelectedGoods: TsListView
          Left = 0
          Top = 23
          Width = 848
          Height = 135
          HighlightHeaders = False
          Align = alClient
          Columns = <
            item
              Caption = #1050#1086#1076
              Width = 70
            end
            item
              AutoSize = True
              Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
            end
            item
              Caption = #1064#1090#1088#1080#1093#1082#1086#1076
              Width = 150
            end
            item
              Caption = #1062#1077#1085#1072
              Width = 100
            end
            item
              Alignment = taCenter
              Caption = #1050#1086#1083'-'#1074#1086
              Width = 150
            end>
          ColumnClick = False
          HideSelection = False
          RowSelect = True
          TabOrder = 1
          ViewStyle = vsReport
          OnCustomDraw = lvSelectedGoodsCustomDraw
          OnSelectItem = lvSelectedGoodsSelectItem
        end
        object sPanel3: TsPanel
          Left = 0
          Top = 158
          Width = 848
          Height = 42
          Align = alBottom
          BevelOuter = bvNone
          Caption = 'sPanel5'
          ShowCaption = False
          TabOrder = 2
          OnResize = PanelResize
          object btnDelete: TsSpeedButton
            Left = 125
            Top = 1
            Width = 124
            Height = 40
            Caption = #1059#1076#1072#1083#1080#1090#1100
            OnClick = btnDeleteClick
            SkinData.SkinSection = 'BUTTON'
          end
          object btnClearGoods: TsSpeedButton
            Left = 250
            Top = 1
            Width = 124
            Height = 40
            Caption = #1054#1095#1080#1089#1090#1080#1090#1100
            OnClick = btnClearGoodsClick
            SkinData.SkinSection = 'BUTTON'
          end
          object btnUp2: TsSpeedButton
            Left = 375
            Top = 1
            Width = 124
            Height = 40
            Caption = #1042#1074#1077#1088#1093
            OnClick = btnUp2Click
            SkinData.SkinSection = 'BUTTON'
          end
          object btnDown2: TsSpeedButton
            Left = 500
            Top = 1
            Width = 124
            Height = 40
            Caption = #1042#1085#1080#1079
            OnClick = btnDown2Click
            SkinData.SkinSection = 'BUTTON'
          end
        end
      end
    end
    object sTabSheet9: TsTabSheet
      Caption = #1055#1088#1077#1076#1087#1088#1086#1089#1084#1086#1090#1088
      OnShow = sTabSheet9Show
      object sPanel4: TsPanel
        Left = 0
        Top = 517
        Width = 848
        Height = 42
        Align = alBottom
        Caption = 'sPanel4'
        ShowCaption = False
        TabOrder = 0
        DesignSize = (
          848
          42)
        object btnPrintLabels: TsSpeedButton
          Tag = 80
          Left = 0
          Top = 2
          Width = 846
          Height = 40
          Anchors = [akLeft, akRight, akBottom]
          Caption = #1055#1077#1095#1072#1090#1100
          OnClick = btnPrintLabelsClick
          SkinData.SkinSection = 'BUTTON'
          ExplicitWidth = 622
        end
      end
      object frxPreview1: TfrxPreview
        Left = 0
        Top = 0
        Width = 848
        Height = 517
        Align = alClient
        ActiveFrameColor = 6393569
        BackColor = 3682598
        BorderStyle = bsNone
        OutlineVisible = False
        OutlineWidth = 120
        ThumbnailVisible = False
        UseReportHints = True
      end
    end
  end
  object frxReport1: TfrxReport
    Version = '6.2.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    Preview = frxPreview1
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = #1055#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
    PrintOptions.PrintOnSheet = 0
    PrintOptions.ShowDialog = False
    ReportOptions.CreateDate = 43062.703145567100000000
    ReportOptions.LastChange = 43282.934342384260000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    OnGetValue = frxReport1GetValue
    Left = 464
    Top = 448
    Datasets = <
      item
        DataSet = frxUserDataSet1
        DataSetName = 'frxUserDataSet1'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      Columns = 3
      ColumnWidth = 66.700000000000000000
      ColumnPositions.Strings = (
        '0'
        '66,70'
        '133,30')
      Frame.Typ = []
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Style = fsDot
        Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
        Height = 105.826771650000000000
        Top = 18.897650000000000000
        Width = 252.094651000000000000
        DataSet = frxUserDataSet1
        DataSetName = 'frxUserDataSet1'
        RowCount = 0
        object Memo1: TfrxMemoView
          AllowVectorExport = True
          Left = 18.897650000000000000
          Width = 185.196970000000000000
          Height = 68.031515590000000000
          DataSet = frxUserDataSet1
          DataSetName = 'frxUserDataSet1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[warename]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          AllowVectorExport = True
          Width = 18.897637800000000000
          Height = 105.826840000000000000
          DataSet = frxUserDataSet1
          DataSetName = 'frxUserDataSet1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftRight]
          HAlign = haCenter
          Memo.UTF8W = (
            '[companyname]')
          ParentFont = False
          Rotation = 90
          VAlign = vaCenter
        end
        object BarCode1: TfrxBarCodeView
          AllowVectorExport = True
          Left = 219.212740000000000000
          Top = 1.000000000000000000
          Width = 30.236220470000000000
          Height = 103.000000000000000000
          BarType = bcCodeEAN13
          Expression = 'bc'
          Frame.Typ = []
          Rotation = 90
          ShowText = False
          TestLine = False
          Text = '12345678'
          WideBarRatio = 2.000000000000000000
          Zoom = 1.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
        end
        object Memo3: TfrxMemoView
          AllowVectorExport = True
          Left = 18.897650000000000000
          Top = 68.692950000000000000
          Width = 185.196970000000000000
          Height = 37.795300000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -32
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[price] '#1088'.')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          AllowVectorExport = True
          Left = 205.874150000000000000
          Width = 11.338590000000000000
          Height = 105.826840000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
          Rotation = 90
        end
      end
    end
  end
  object frxUserDataSet1: TfrxUserDataSet
    RangeEnd = reCount
    UserName = 'frxUserDataSet1'
    OnNext = frxUserDataSet1Next
    Left = 556
    Top = 452
  end
  object timerInit: TTimer
    Interval = 1
    OnTimer = timerInitTimer
    Left = 388
    Top = 452
  end
end
