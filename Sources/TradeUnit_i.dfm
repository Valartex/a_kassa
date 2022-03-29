object frameTrade: TframeTrade
  Left = 0
  Top = 0
  Width = 936
  Height = 567
  DoubleBuffered = True
  Ctl3D = True
  ParentCtl3D = False
  ParentDoubleBuffered = False
  TabOrder = 0
  OnEnter = FrameEnter
  OnExit = FrameExit
  object sPanel1: TsPanel
    Left = 326
    Top = 0
    Width = 610
    Height = 567
    SkinData.SkinSection = 'BAR'
    Align = alClient
    BevelEdges = []
    BevelOuter = bvNone
    Caption = 'sPanel1'
    ShowCaption = False
    TabOrder = 0
    DesignSize = (
      610
      567)
    object btnCloseCheq: TsSpeedButton
      Left = 3
      Top = 514
      Width = 604
      Height = 50
      Anchors = [akLeft, akRight, akBottom]
      Caption = #1047#1072#1082#1088#1099#1090#1100' '#1095#1077#1082
      OnClick = btnCloseCheqClick
      SkinData.SkinSection = 'BUTTON'
      ExplicitWidth = 380
    end
    object lvWares: TsListView
      Left = 3
      Top = 55
      Width = 604
      Height = 254
      HighlightHeaders = False
      Anchors = [akLeft, akTop, akRight]
      Columns = <
        item
          Caption = #1050#1086#1076
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
        end
        item
          Caption = #1050#1086#1083'-'#1074#1086
          MinWidth = 60
          Width = 60
        end
        item
          Caption = #1057#1082#1080#1076#1082#1072
          MinWidth = 60
          Width = 60
        end
        item
          Caption = #1057#1091#1084#1084#1072
          MinWidth = 90
          Width = 90
        end>
      ColumnClick = False
      HideSelection = False
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
    end
    object sPanel3: TsPanel
      Left = 3
      Top = 362
      Width = 604
      Height = 52
      SkinData.SkinSection = 'BAR'
      Anchors = [akLeft, akTop, akRight]
      BevelOuter = bvNone
      Caption = 'sPanel3'
      ShowCaption = False
      TabOrder = 1
      OnResize = PanelResize
      object sPanel4: TsPanel
        Left = 0
        Top = 0
        Width = 128
        Height = 50
        SkinData.SkinSection = 'ALPHAEDIT'
        Alignment = taLeftJustify
        Caption = #1041#1077#1079' '#1089#1082#1080#1076#1082#1080' ('#1056')'
        VerticalAlignment = taAlignTop
        TabOrder = 0
        object labelInitialSum: TsLabel
          Left = 1
          Top = 16
          Width = 126
          Height = 33
          Align = alBottom
          AutoSize = False
          Caption = '0,00'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -24
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ExplicitLeft = 2
          ExplicitTop = 17
        end
      end
      object sPanel5: TsPanel
        Left = 132
        Top = 0
        Width = 104
        Height = 50
        SkinData.SkinSection = 'ALPHAEDIT'
        Alignment = taLeftJustify
        Caption = #1057#1082#1080#1076#1082#1072' (%)'
        VerticalAlignment = taAlignTop
        TabOrder = 1
        object labelCheqDiscount: TsLabel
          Left = 1
          Top = 16
          Width = 102
          Height = 33
          Align = alBottom
          AutoSize = False
          Caption = '0,00'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -24
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ExplicitLeft = 2
          ExplicitTop = 17
        end
      end
      object sPanel6: TsPanel
        Left = 239
        Top = 0
        Width = 140
        Height = 50
        SkinData.SkinSection = 'ALPHAEDIT'
        Alignment = taLeftJustify
        Caption = #1048#1090#1086#1075' ('#1056')'
        VerticalAlignment = taAlignTop
        TabOrder = 2
        object labelTotalSum: TsLabel
          Left = 1
          Top = 16
          Width = 138
          Height = 33
          Align = alBottom
          AutoSize = False
          Caption = '0,00'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -24
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ExplicitLeft = -195
          ExplicitTop = 17
          ExplicitWidth = 380
        end
      end
    end
    object sPanel9: TsPanel
      Left = 3
      Top = 464
      Width = 604
      Height = 52
      SkinData.SkinSection = 'BAR'
      Anchors = [akLeft, akTop, akRight]
      BevelOuter = bvNone
      Caption = 'sPanel3'
      ShowCaption = False
      TabOrder = 2
      OnResize = PanelResize
      object sPanel10: TsPanel
        Left = 0
        Top = 0
        Width = 128
        Height = 50
        SkinData.SkinSection = 'ALPHAEDIT'
        Alignment = taLeftJustify
        Caption = #1054#1087#1083#1072#1090#1072' '#1085#1072#1083#1080#1095#1085#1099#1084#1080
        VerticalAlignment = taAlignTop
        TabOrder = 0
        object btnPayCash: TsSpeedButton
          Tag = 2
          Left = 1
          Top = 16
          Width = 126
          Height = 33
          Align = alBottom
          Caption = '0,00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -24
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = btnPayCashClick
          SkinData.SkinSection = 'MENUITEM'
          Alignment = taLeftJustify
          ExplicitTop = 27
        end
      end
      object sPanel11: TsPanel
        Left = 132
        Top = 0
        Width = 104
        Height = 50
        SkinData.SkinSection = 'ALPHAEDIT'
        Alignment = taLeftJustify
        Caption = #1054#1087#1083#1072#1090#1072' '#1082#1072#1088#1090#1086#1081
        VerticalAlignment = taAlignTop
        TabOrder = 1
        object btnPayCard: TsSpeedButton
          Tag = 2
          Left = 1
          Top = 16
          Width = 102
          Height = 33
          Align = alBottom
          Caption = '0,00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -24
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = btnPayCardClick
          SkinData.SkinSection = 'MENUITEM'
          Alignment = taLeftJustify
          ExplicitLeft = 2
          ExplicitTop = 17
        end
      end
      object sPanel12: TsPanel
        Left = 239
        Top = 0
        Width = 140
        Height = 50
        SkinData.SkinSection = 'ALPHAEDIT'
        Alignment = taLeftJustify
        Caption = #1057#1076#1072#1095#1072' \ -'#1054#1089#1090#1072#1090#1086#1082
        VerticalAlignment = taAlignTop
        TabOrder = 2
        object labelChange: TsLabel
          Left = 1
          Top = 16
          Width = 138
          Height = 33
          Align = alBottom
          AutoSize = False
          Caption = '0,00'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -24
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ExplicitLeft = -195
          ExplicitTop = 17
          ExplicitWidth = 380
        end
      end
    end
    object sPanel13: TsPanel
      Left = 3
      Top = 3
      Width = 604
      Height = 50
      SkinData.SkinSection = 'BAR'
      Anchors = [akLeft, akTop, akRight]
      BevelOuter = bvNone
      Caption = 'sPanel3'
      ShowCaption = False
      TabOrder = 3
      OnResize = PanelResize
      object sPanel7: TsPanel
        Left = 0
        Top = 0
        Width = 188
        Height = 50
        SkinData.SkinSection = 'ALPHAEDIT'
        Alignment = taLeftJustify
        Caption = #1058#1080#1087' '#1095#1077#1082#1072
        VerticalAlignment = taAlignTop
        TabOrder = 0
        object btnSelectCheqType: TsSpeedButton
          Left = 1
          Top = 16
          Width = 186
          Height = 33
          Align = alBottom
          Caption = #1055#1088#1086#1076#1072#1078#1072
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -19
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = btnSelectCheqTypeClick
          SkinData.SkinSection = 'MENUITEM'
          Alignment = taLeftJustify
          WordWrap = False
          ExplicitTop = 19
        end
      end
      object sPanel8: TsPanel
        Left = 191
        Top = 0
        Width = 189
        Height = 50
        SkinData.SkinSection = 'ALPHAEDIT'
        Alignment = taLeftJustify
        Caption = #1053#1086#1084#1077#1088' '#1095#1077#1082#1072
        VerticalAlignment = taAlignTop
        TabOrder = 1
        object labelReceiptNumber: TsLabel
          Left = 1
          Top = 16
          Width = 187
          Height = 33
          Align = alBottom
          AutoSize = False
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -19
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ExplicitTop = -1
          ExplicitWidth = 102
        end
      end
      object sPanel15: TsPanel
        Left = 390
        Top = 0
        Width = 188
        Height = 50
        SkinData.SkinSection = 'ALPHAEDIT'
        Alignment = taLeftJustify
        Caption = #1057#1090#1072#1090#1091#1089' '#1054#1060#1044
        VerticalAlignment = taAlignTop
        TabOrder = 2
        object labelOFDStatus: TsLabel
          Left = 1
          Top = 16
          Width = 186
          Height = 33
          Align = alBottom
          AutoSize = False
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -19
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ExplicitLeft = 2
          ExplicitTop = 17
        end
      end
    end
    object sPanel14: TsPanel
      Left = 3
      Top = 310
      Width = 604
      Height = 50
      Anchors = [akLeft, akTop, akRight]
      BevelOuter = bvNone
      Caption = 'sPanel14'
      ShowCaption = False
      TabOrder = 4
      OnResize = PanelResize
      DesignSize = (
        604
        50)
      object btnQuantityPlus: TsSpeedButton
        Tag = 2
        Left = 0
        Top = 0
        Width = 75
        Height = 50
        Anchors = [akLeft, akBottom]
        Caption = #1059#1074#1077#1083#1080#1095#1080#1090#1100' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086
        OnClick = btnQuantityPlusClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnQuantityMinus: TsSpeedButton
        Tag = 2
        Left = 74
        Top = 0
        Width = 75
        Height = 50
        Anchors = [akLeft, akBottom]
        Caption = #1059#1084#1077#1085#1100#1096#1080#1090#1100' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086
        OnClick = btnQuantityMinusClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnQuantitySet: TsSpeedButton
        Tag = 2
        Left = 148
        Top = 0
        Width = 75
        Height = 50
        Anchors = [akLeft, akBottom]
        Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086
        OnClick = btnQuantitySetClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnPriceSet: TsSpeedButton
        Tag = 80
        Left = 222
        Top = 0
        Width = 75
        Height = 50
        Anchors = [akLeft, akBottom]
        Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1094#1077#1085#1091
        OnClick = btnPriceSetClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnDelPos: TsSpeedButton
        Tag = 80
        Left = 303
        Top = 0
        Width = 75
        Height = 50
        Anchors = [akLeft, akBottom]
        Caption = #1059#1076#1072#1083#1080#1090#1100
        OnClick = btnDelPosClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnUp: TsSpeedButton
        Tag = 80
        Left = 379
        Top = 0
        Width = 75
        Height = 50
        Anchors = [akLeft, akBottom]
        Caption = #1042#1074#1077#1088#1093
        OnClick = btnUpClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnDown: TsSpeedButton
        Tag = 80
        Left = 455
        Top = 0
        Width = 75
        Height = 50
        Anchors = [akLeft, akBottom]
        Caption = #1042#1085#1080#1079
        OnClick = btnDownClick
        SkinData.SkinSection = 'BUTTON'
      end
    end
    object panelDigitalCopy: TsPanel
      Left = 3
      Top = 413
      Width = 604
      Height = 50
      SkinData.SkinSection = 'ALPHAEDIT'
      Anchors = [akLeft, akTop, akRight]
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
  end
  object sPanel2: TsPanel
    Left = 0
    Top = 0
    Width = 326
    Height = 567
    Align = alLeft
    BevelEdges = []
    BevelOuter = bvNone
    Caption = 'sPanel2'
    ShowCaption = False
    TabOrder = 1
    DesignSize = (
      326
      567)
    object btn7: TsSpeedButton
      Tag = 80
      Left = 2
      Top = 45
      Width = 80
      Height = 50
      Caption = '7'
      OnClick = NumericButtonClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btn8: TsSpeedButton
      Tag = 80
      Left = 83
      Top = 45
      Width = 80
      Height = 50
      Caption = '8'
      OnClick = NumericButtonClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btn9: TsSpeedButton
      Tag = 80
      Left = 164
      Top = 45
      Width = 80
      Height = 50
      Caption = '9'
      OnClick = NumericButtonClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btn0: TsSpeedButton
      Tag = 80
      Left = 245
      Top = 45
      Width = 80
      Height = 50
      Caption = '0'
      OnClick = NumericButtonClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btn4: TsSpeedButton
      Tag = 80
      Left = 2
      Top = 96
      Width = 80
      Height = 50
      Caption = '4'
      OnClick = NumericButtonClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btn5: TsSpeedButton
      Tag = 80
      Left = 83
      Top = 96
      Width = 80
      Height = 50
      Caption = '5'
      OnClick = NumericButtonClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btn6: TsSpeedButton
      Tag = 80
      Left = 164
      Top = 96
      Width = 80
      Height = 50
      Caption = '6'
      OnClick = NumericButtonClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnSeparator: TsSpeedButton
      Tag = 80
      Left = 2
      Top = 198
      Width = 80
      Height = 50
      Caption = '.'
      OnClick = btnSeparatorClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btn3: TsSpeedButton
      Tag = 80
      Left = 164
      Top = 147
      Width = 80
      Height = 50
      Caption = '3'
      OnClick = NumericButtonClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btn2: TsSpeedButton
      Tag = 80
      Left = 83
      Top = 147
      Width = 80
      Height = 50
      Caption = '2'
      OnClick = NumericButtonClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btn1: TsSpeedButton
      Tag = 80
      Left = 2
      Top = 147
      Width = 80
      Height = 50
      Caption = '1'
      OnClick = NumericButtonClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnC: TsSpeedButton
      Tag = 80
      Left = 245
      Top = 198
      Width = 80
      Height = 50
      Caption = 'C'
      OnClick = btnCClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnCancelDiscount: TsSpeedButton
      Tag = 2
      Left = 164
      Top = 451
      Width = 80
      Height = 50
      Anchors = [akLeft, akBottom]
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100' '#1089#1082#1080#1076#1082#1080
      OnClick = btnCancelDiscountClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnCheqCopy: TsSpeedButton
      Tag = 2
      Left = 164
      Top = 388
      Width = 80
      Height = 50
      Anchors = [akLeft, akBottom]
      Caption = #1050#1086#1087#1080#1103
      OnClick = btnCheqCopyClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnCheqCancel: TsSpeedButton
      Tag = 80
      Left = 2
      Top = 388
      Width = 80
      Height = 50
      Anchors = [akLeft, akBottom]
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      OnClick = btnCheqCancelClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnCheqDiscount: TsSpeedButton
      Tag = 2
      Left = 2
      Top = 451
      Width = 80
      Height = 50
      Anchors = [akLeft, akBottom]
      Caption = #1057#1082#1080#1076#1082#1072' '#1085#1072' '#1095#1077#1082
      OnClick = btnCheqDiscountClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnPosDiscount: TsSpeedButton
      Tag = 2
      Left = 83
      Top = 451
      Width = 80
      Height = 50
      Anchors = [akLeft, akBottom]
      Caption = #1057#1082#1080#1076#1082#1072' '#1085#1072' '#1087#1086#1079#1080#1094#1080#1102
      OnClick = btnPosDiscountClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnOpenCashbox: TsSpeedButton
      Tag = 80
      Left = 2
      Top = 514
      Width = 80
      Height = 50
      Anchors = [akLeft, akBottom]
      Caption = #1054#1090#1082#1088#1099#1090#1100' '#1076#1077#1085#1077#1078#1085#1099#1081' '#1103#1097#1080#1082
      OnClick = btnOpenCashboxClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnCashboxSum: TsSpeedButton
      Tag = 80
      Left = 83
      Top = 514
      Width = 80
      Height = 50
      Anchors = [akLeft, akBottom]
      Caption = #1057#1091#1084#1084#1072' '#1074' '#1076#1077#1085#1077#1078#1085#1086#1084' '#1103#1097#1080#1082#1077
      OnClick = btnCashboxSumClick
      SkinData.SkinSection = 'BUTTON'
    end
    object sLabel3: TsLabel
      Left = 2
      Top = 260
      Width = 30
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = #1055#1086#1080#1089#1082
    end
    object btnCode: TsSpeedButton
      Tag = 2
      Left = 2
      Top = 325
      Width = 80
      Height = 50
      Anchors = [akLeft, akBottom]
      Caption = #1050#1086#1076
      OnClick = btnCodeClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnVendorcode: TsSpeedButton
      Tag = 2
      Left = 83
      Top = 325
      Width = 80
      Height = 50
      Anchors = [akLeft, akBottom]
      Caption = #1040#1088#1090#1080#1082#1091#1083
      OnClick = btnVendorcodeClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnBarcode: TsSpeedButton
      Tag = 2
      Left = 164
      Top = 325
      Width = 80
      Height = 50
      Anchors = [akLeft, akBottom]
      Caption = #1064#1090#1088#1080#1093#1082#1086#1076
      OnClick = btnBarcodeClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnPrice: TsSpeedButton
      Tag = 2
      Left = 245
      Top = 325
      Width = 80
      Height = 50
      Anchors = [akLeft, akBottom]
      Caption = #1062#1077#1085#1072
      OnClick = btnPriceClick
      SkinData.SkinSection = 'BUTTON'
    end
    object sLabel6: TsLabel
      Left = 2
      Top = 374
      Width = 19
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = #1063#1077#1082
    end
    object sLabel8: TsLabel
      Left = 2
      Top = 437
      Width = 38
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = #1057#1082#1080#1076#1082#1080
    end
    object sLabel9: TsLabel
      Left = 2
      Top = 500
      Width = 60
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = #1053#1072#1083#1080#1095#1085#1086#1089#1090#1100
    end
    object btnRestoreDoc: TsSpeedButton
      Tag = 2
      Left = 83
      Top = 388
      Width = 80
      Height = 50
      Anchors = [akLeft, akBottom]
      Caption = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1086#1090#1084#1077#1085#1105#1085#1085#1099#1081
      OnClick = btnRestoreDocClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnPersonalDiscount: TsSpeedButton
      Tag = 2
      Left = 245
      Top = 451
      Width = 80
      Height = 50
      Anchors = [akLeft, akBottom]
      Caption = #1055#1077#1088#1089#1086#1085#1072#1083#1100#1085#1072#1103' '#1089#1082#1080#1076#1082#1072
      Enabled = False
      OnClick = btnPersonalDiscountClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnDigitalCopy: TsSpeedButton
      Tag = 2
      Left = 245
      Top = 388
      Width = 80
      Height = 50
      Anchors = [akLeft, akBottom]
      Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1082#1083#1080#1077#1085#1090#1091
      OnClick = btnDigitalCopyClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnBS: TsSpeedButton
      Tag = 80
      Left = 164
      Top = 198
      Width = 80
      Height = 50
      Caption = 'BS'
      OnClick = btnBSClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnX: TsSpeedButton
      Tag = 80
      Left = 83
      Top = 198
      Width = 80
      Height = 50
      Caption = '*'
      OnClick = btnXClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btn00: TsSpeedButton
      Tag = 80
      Left = 245
      Top = 96
      Width = 80
      Height = 50
      Caption = '00'
      OnClick = btn00Click
      SkinData.SkinSection = 'BUTTON'
    end
    object btn000: TsSpeedButton
      Tag = 80
      Left = 245
      Top = 147
      Width = 80
      Height = 50
      Caption = '000'
      OnClick = btn00Click
      SkinData.SkinSection = 'BUTTON'
    end
    object btnGoods: TsSpeedButton
      Tag = 2
      Left = 2
      Top = 274
      Width = 323
      Height = 50
      Anchors = [akLeft, akBottom]
      Caption = #1058#1086#1074#1072#1088#1099
      OnClick = btnGoodsClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnCashIn: TsSpeedButton
      Tag = 80
      Left = 164
      Top = 514
      Width = 80
      Height = 50
      Anchors = [akLeft, akBottom]
      Caption = #1042#1085#1077#1089#1077#1085#1080#1077
      OnClick = btnCashInClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnCashOut: TsSpeedButton
      Tag = 80
      Left = 245
      Top = 514
      Width = 80
      Height = 50
      Anchors = [akLeft, akBottom]
      Caption = #1042#1099#1087#1083#1072#1090#1072
      OnClick = btnCashOutClick
      SkinData.SkinSection = 'BUTTON'
    end
    object editMain: TsEdit
      Left = 2
      Top = 3
      Width = 323
      Height = 41
      Alignment = taCenter
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -27
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = 16772838
      BoundLabel.Font.Height = -27
      BoundLabel.Font.Name = 'Tahoma'
      BoundLabel.Font.Style = []
    end
  end
  object timerOFD: TTimer
    Enabled = False
    Interval = 10000
    OnTimer = timerOFDTimer
    Left = 902
    Top = 8
  end
end
