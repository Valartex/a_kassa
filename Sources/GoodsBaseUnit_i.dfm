object frameGoodsBase: TframeGoodsBase
  Left = 0
  Top = 0
  Width = 936
  Height = 567
  DoubleBuffered = True
  ParentDoubleBuffered = False
  TabOrder = 0
  object pcGoods: TsPageControl
    Left = 0
    Top = 0
    Width = 936
    Height = 567
    ActivePage = tsGoods
    Align = alClient
    TabOrder = 0
    object tsGoods: TsTabSheet
      Caption = 'tsGoods'
      TabVisible = False
      object sPanel6: TsPanel
        Left = 0
        Top = 516
        Width = 928
        Height = 41
        Align = alBottom
        Caption = 'sPanel6'
        ShowCaption = False
        TabOrder = 0
        OnResize = PanelResize
        object btnAddGoodsGroup: TsSpeedButton
          Left = 0
          Top = 1
          Width = 142
          Height = 40
          Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1075#1088#1091#1087#1087#1091
          OnClick = btnAddGoodsGroupClick
          SkinData.SkinSection = 'BUTTON'
        end
        object btnAddGoods: TsSpeedButton
          Left = 143
          Top = 1
          Width = 142
          Height = 40
          Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1090#1086#1074#1072#1088
          OnClick = btnAddGoodsClick
          SkinData.SkinSection = 'BUTTON'
        end
        object btnEditGoods: TsSpeedButton
          Left = 286
          Top = 1
          Width = 142
          Height = 40
          Caption = #1048#1079#1084#1077#1085#1080#1090#1100
          OnClick = btnEditGoodsClick
          SkinData.SkinSection = 'BUTTON'
        end
        object btnDeleteGoods: TsSpeedButton
          Left = 429
          Top = 1
          Width = 141
          Height = 40
          Caption = #1059#1076#1072#1083#1080#1090#1100
          OnClick = btnDeleteGoodsClick
          SkinData.SkinSection = 'BUTTON'
        end
        object sSpeedButton1: TsSpeedButton
          Left = 571
          Top = 1
          Width = 142
          Height = 40
          Caption = #1042#1074#1077#1088#1093
          OnClick = btnUpClick
          SkinData.SkinSection = 'BUTTON'
        end
        object sSpeedButton2: TsSpeedButton
          Left = 714
          Top = 1
          Width = 141
          Height = 40
          Caption = #1042#1085#1080#1079
          OnClick = btnDownClick
          SkinData.SkinSection = 'BUTTON'
        end
      end
      inline frameGoodsTable1: TframeGoodsTable
        Left = 0
        Top = 0
        Width = 928
        Height = 516
        Align = alClient
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 1
        ExplicitWidth = 928
        ExplicitHeight = 516
        inherited lvGoods: TsListView
          Width = 928
          Height = 516
          ExplicitWidth = 928
          ExplicitHeight = 516
        end
      end
    end
    object tsGoodsGroupData: TsTabSheet
      Caption = 'tsGoodsGroupData'
      TabVisible = False
      DesignSize = (
        928
        557)
      object imgGoodsGroup: TsImage
        Left = 3
        Top = 3
        Width = 191
        Height = 166
        Center = True
        Picture.Data = {07544269746D617000000000}
        Proportional = True
        Stretch = True
        OnClick = imgGoodsGroupClick
        SkinData.SkinSection = 'EDIT'
      end
      object btnClearGoodsGroupImage: TsSpeedButton
        Left = 3
        Top = 175
        Width = 191
        Height = 40
        Caption = #1059#1073#1088#1072#1090#1100' '#1082#1072#1088#1090#1080#1085#1082#1091
        OnClick = btnClearGoodsGroupImageClick
        SkinData.SkinSection = 'BUTTON'
      end
      object sLabel9: TsLabel
        Left = 200
        Top = 6
        Width = 73
        Height = 13
        Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      end
      object sLabel10: TsLabel
        Left = 200
        Top = 33
        Width = 81
        Height = 13
        Caption = #1043#1088#1091#1087#1087#1072' '#1090#1086#1074#1072#1088#1086#1074
      end
      object sLabel11: TsLabel
        Left = 200
        Top = 60
        Width = 20
        Height = 13
        Caption = #1050#1086#1076
      end
      object sLabel12: TsLabel
        Left = 200
        Top = 114
        Width = 99
        Height = 13
        Caption = #1045#1076#1080#1085#1080#1094#1072' '#1080#1079#1084#1077#1088#1077#1085#1080#1103
      end
      object sLabel13: TsLabel
        Left = 200
        Top = 141
        Width = 92
        Height = 13
        Caption = #1053#1072#1083#1086#1075#1086#1074#1072#1103' '#1075#1088#1091#1087#1087#1072
      end
      object sLabel69: TsLabel
        Left = 200
        Top = 195
        Width = 138
        Height = 13
        Caption = #1055#1088#1080#1079#1085#1072#1082' '#1087#1088#1077#1076#1084#1077#1090#1072' '#1088#1072#1089#1095#1105#1090#1072
      end
      object sLabel18: TsLabel
        Left = 200
        Top = 222
        Width = 106
        Height = 13
        Caption = #1044#1088#1086#1073#1085#1086#1077' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086
      end
      object sLabel19: TsLabel
        Left = 200
        Top = 249
        Width = 92
        Height = 13
        Caption = #1047#1072#1075#1088#1091#1078#1072#1090#1100' '#1074' '#1074#1077#1089#1099
      end
      object sLabel20: TsLabel
        Left = 200
        Top = 276
        Width = 97
        Height = 13
        Caption = #1047#1072#1087#1088#1086#1089' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1072
      end
      object sLabel21: TsLabel
        Left = 200
        Top = 303
        Width = 64
        Height = 13
        Caption = #1047#1072#1087#1088#1086#1089' '#1094#1077#1085#1099
      end
      object sLabel23: TsLabel
        Left = 200
        Top = 168
        Width = 79
        Height = 13
        Caption = #1057#1077#1082#1094#1080#1103' ('#1086#1090#1076#1077#1083')'
      end
      object btnSelectGroupParent: TsSpeedButton
        Tag = 1
        Left = 904
        Top = 30
        Width = 21
        Height = 21
        Anchors = [akTop, akRight]
        Caption = '...'
        OnClick = btnSelectGroupParentClick
        SkinData.SkinSection = 'BUTTON'
        ExplicitLeft = 680
      end
      object sLabel25: TsLabel
        Left = 200
        Top = 87
        Width = 19
        Height = 13
        Caption = #1042#1080#1076
      end
      object sPanel7: TsPanel
        Left = 0
        Top = 516
        Width = 928
        Height = 41
        Align = alBottom
        Caption = 'sPanel6'
        ShowCaption = False
        TabOrder = 0
        OnResize = PanelResize
        object btnSaveGoodsGroup: TsSpeedButton
          Left = 0
          Top = 1
          Width = 351
          Height = 40
          Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
          OnClick = btnSaveGoodsGroupClick
          SkinData.SkinSection = 'BUTTON'
        end
        object btnCancelGoodsGroup: TsSpeedButton
          Left = 352
          Top = 1
          Width = 351
          Height = 40
          Caption = #1054#1090#1084#1077#1085#1080#1090#1100
          OnClick = btnCancelGoodsGroupClick
          SkinData.SkinSection = 'BUTTON'
        end
      end
      object editGroupName: TsEdit
        Left = 352
        Top = 3
        Width = 573
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 1
      end
      object editGroupCode: TsEdit
        Left = 352
        Top = 57
        Width = 573
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        Enabled = False
        ReadOnly = True
        TabOrder = 2
      end
      object cbGroupUnit: TsComboBox
        Left = 352
        Top = 111
        Width = 573
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        Style = csDropDownList
        ItemIndex = -1
        TabOrder = 3
      end
      object cbGroupTax: TsComboBox
        Left = 352
        Top = 138
        Width = 573
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 4
        Text = #1041#1077#1079' '#1053#1044#1057
        Items.Strings = (
          #1041#1077#1079' '#1053#1044#1057
          #1053#1044#1057' 0%'
          #1053#1044#1057' 10%'
          #1053#1044#1057' 20%'
          #1053#1044#1057' 10/100'
          #1053#1044#1057' 20/120')
      end
      object cbGroupPPR: TsComboBox
        Left = 352
        Top = 192
        Width = 573
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        Style = csDropDownList
        ItemIndex = -1
        TabOrder = 5
      end
      object cbGroupFractional: TsComboBox
        Left = 352
        Top = 219
        Width = 573
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        Style = csDropDownList
        ItemIndex = -1
        TabOrder = 6
        Items.Strings = (
          #1053#1077#1090
          #1044#1072)
      end
      object cbGroupUnloadInScales: TsComboBox
        Left = 352
        Top = 246
        Width = 573
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        Style = csDropDownList
        ItemIndex = -1
        TabOrder = 7
        Items.Strings = (
          #1053#1077#1090
          #1044#1072)
      end
      object cbGroupQuantityRequest: TsComboBox
        Left = 352
        Top = 273
        Width = 573
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        Style = csDropDownList
        ItemIndex = -1
        TabOrder = 8
        Items.Strings = (
          #1053#1077#1090
          #1044#1072)
      end
      object cbGroupPriceRequest: TsComboBox
        Left = 352
        Top = 300
        Width = 573
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        Style = csDropDownList
        ItemIndex = -1
        TabOrder = 9
        Items.Strings = (
          #1053#1077#1090
          #1044#1072)
      end
      object editGroupParent: TsEdit
        Left = 352
        Top = 30
        Width = 546
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        ReadOnly = True
        TabOrder = 10
      end
      object seGroupDepartment: TsSpinEdit
        Left = 352
        Top = 165
        Width = 573
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        NumbersOnly = True
        TabOrder = 11
        AllowNegative = False
        MaxValue = 30
        MinValue = 0
      end
      object cbGroupType: TsComboBox
        Left = 352
        Top = 84
        Width = 573
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 12
        Text = #1054#1073#1099#1095#1085#1099#1081' '#1090#1086#1074#1072#1088
        Items.Strings = (
          #1054#1073#1099#1095#1085#1099#1081' '#1090#1086#1074#1072#1088
          #1052#1072#1088#1082#1080#1088#1086#1074#1072#1085#1085#1099#1081' '#1072#1083#1082#1086#1075#1086#1083#1100
          #1052#1077#1093#1086#1074#1099#1077' '#1080#1079#1076#1077#1083#1080#1103
          #1051#1077#1082#1072#1088#1089#1090#1074#1077#1085#1085#1099#1077' '#1087#1088#1077#1087#1072#1088#1072#1090#1099
          #1058#1072#1073#1072#1095#1085#1072#1103' '#1087#1088#1086#1076#1091#1082#1094#1080#1103
          #1054#1073#1091#1074#1100
          #1051#1086#1090#1077#1088#1077#1103
          #1048#1085#1072#1103' '#1084#1072#1088#1082#1080#1088#1086#1074#1072#1085#1085#1072#1103' '#1087#1088#1086#1076#1091#1082#1094#1080#1103)
      end
    end
    object tsGoodsData: TsTabSheet
      Caption = 'tsGoodsData'
      TabVisible = False
      DesignSize = (
        928
        557)
      object imgGoods: TsImage
        Left = 3
        Top = 3
        Width = 191
        Height = 166
        Center = True
        Picture.Data = {07544269746D617000000000}
        Proportional = True
        Stretch = True
        OnClick = imgGoodsClick
        SkinData.SkinSection = 'EDIT'
      end
      object sLabel1: TsLabel
        Left = 200
        Top = 6
        Width = 73
        Height = 13
        Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      end
      object sLabel2: TsLabel
        Left = 200
        Top = 33
        Width = 81
        Height = 13
        Caption = #1043#1088#1091#1087#1087#1072' '#1090#1086#1074#1072#1088#1086#1074
      end
      object sLabel3: TsLabel
        Left = 200
        Top = 60
        Width = 20
        Height = 13
        Caption = #1050#1086#1076
      end
      object sLabel4: TsLabel
        Left = 200
        Top = 114
        Width = 43
        Height = 13
        Caption = #1040#1088#1090#1080#1082#1091#1083
      end
      object sLabel5: TsLabel
        Left = 200
        Top = 141
        Width = 99
        Height = 13
        Caption = #1045#1076#1080#1085#1080#1094#1072' '#1080#1079#1084#1077#1088#1077#1085#1080#1103
      end
      object sLabel6: TsLabel
        Left = 200
        Top = 168
        Width = 92
        Height = 13
        Caption = #1053#1072#1083#1086#1075#1086#1074#1072#1103' '#1075#1088#1091#1087#1087#1072
      end
      object sLabel7: TsLabel
        Left = 200
        Top = 222
        Width = 90
        Height = 13
        Caption = #1050#1086#1076' '#1074' '#1074#1077#1089#1072#1093' (PLU)'
      end
      object sLabel8: TsLabel
        Left = 200
        Top = 249
        Width = 26
        Height = 13
        Caption = #1062#1077#1085#1072
      end
      object btnClearGoodsImage: TsSpeedButton
        Left = 3
        Top = 175
        Width = 191
        Height = 40
        Caption = #1059#1073#1088#1072#1090#1100' '#1082#1072#1088#1090#1080#1085#1082#1091
        OnClick = btnClearGoodsImageClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnBarcodeDelete: TsSpeedButton
        Left = 3
        Top = 470
        Width = 191
        Height = 40
        Caption = #1059#1076#1072#1083#1080#1090#1100' '#1096#1090#1088#1080#1093#1082#1086#1076
        OnClick = btnBarcodeDeleteClick
        SkinData.SkinSection = 'BUTTON'
      end
      object sLabel70: TsLabel
        Left = 200
        Top = 276
        Width = 138
        Height = 13
        Caption = #1055#1088#1080#1079#1085#1072#1082' '#1087#1088#1077#1076#1084#1077#1090#1072' '#1088#1072#1089#1095#1105#1090#1072
      end
      object sLabel14: TsLabel
        Left = 200
        Top = 303
        Width = 106
        Height = 13
        Caption = #1044#1088#1086#1073#1085#1086#1077' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086
      end
      object sLabel15: TsLabel
        Left = 200
        Top = 330
        Width = 92
        Height = 13
        Caption = #1047#1072#1075#1088#1091#1078#1072#1090#1100' '#1074' '#1074#1077#1089#1099
      end
      object sLabel16: TsLabel
        Left = 200
        Top = 357
        Width = 97
        Height = 13
        Caption = #1047#1072#1087#1088#1086#1089' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1072
      end
      object sLabel17: TsLabel
        Left = 200
        Top = 384
        Width = 64
        Height = 13
        Caption = #1047#1072#1087#1088#1086#1089' '#1094#1077#1085#1099
      end
      object sLabel22: TsLabel
        Left = 200
        Top = 195
        Width = 79
        Height = 13
        Caption = #1057#1077#1082#1094#1080#1103' ('#1086#1090#1076#1077#1083')'
      end
      object sLabel24: TsLabel
        Left = 200
        Top = 411
        Width = 36
        Height = 13
        Caption = #1057#1086#1089#1090#1072#1074
      end
      object btnGeneratePLU: TsSpeedButton
        Tag = 1
        Left = 904
        Top = 192
        Width = 21
        Height = 21
        Anchors = [akTop, akRight]
        Caption = '...'
        SkinData.SkinSection = 'BUTTON'
        ExplicitLeft = 680
      end
      object btnSelectGoodsParent: TsSpeedButton
        Tag = 1
        Left = 904
        Top = 30
        Width = 21
        Height = 21
        Anchors = [akTop, akRight]
        Caption = '...'
        OnClick = btnSelectGoodsParentClick
        SkinData.SkinSection = 'BUTTON'
        ExplicitLeft = 680
      end
      object btnBarcodeGen: TsSpeedButton
        Left = 3
        Top = 424
        Width = 191
        Height = 40
        Caption = #1057#1075#1077#1085#1077#1088#1080#1088#1086#1074#1072#1090#1100' '#1096#1090#1088#1080#1093#1082#1086#1076
        OnClick = btnBarcodeGenClick
        SkinData.SkinSection = 'BUTTON'
      end
      object sLabel26: TsLabel
        Left = 200
        Top = 87
        Width = 19
        Height = 13
        Caption = #1042#1080#1076
      end
      object sPanel8: TsPanel
        Left = 0
        Top = 516
        Width = 928
        Height = 41
        Align = alBottom
        Caption = 'sPanel6'
        ShowCaption = False
        TabOrder = 0
        OnResize = PanelResize
        object btnSaveGoods: TsSpeedButton
          Left = 0
          Top = 1
          Width = 351
          Height = 40
          Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
          OnClick = btnSaveGoodsClick
          SkinData.SkinSection = 'BUTTON'
        end
        object btnCancelGoods: TsSpeedButton
          Left = 352
          Top = 1
          Width = 351
          Height = 40
          Caption = #1054#1090#1084#1077#1085#1080#1090#1100
          OnClick = btnCancelGoodsClick
          SkinData.SkinSection = 'BUTTON'
        end
      end
      object editGoodsName: TsEdit
        Left = 352
        Top = 3
        Width = 573
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 1
      end
      object lvBarcodes: TsListView
        Left = 3
        Top = 228
        Width = 191
        Height = 190
        Columns = <
          item
            AutoSize = True
            Caption = #1064#1090#1088#1080#1093#1082#1086#1076#1099
          end>
        TabOrder = 2
        ViewStyle = vsReport
      end
      object editGoodsCode: TsEdit
        Left = 352
        Top = 57
        Width = 573
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        Enabled = False
        ReadOnly = True
        TabOrder = 3
      end
      object editGoodsVendorcode: TsEdit
        Left = 352
        Top = 111
        Width = 573
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 4
      end
      object cbGoodsUnit: TsComboBox
        Left = 352
        Top = 138
        Width = 573
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        Style = csDropDownList
        ItemIndex = -1
        TabOrder = 5
      end
      object cbGoodsTax: TsComboBox
        Left = 352
        Top = 165
        Width = 573
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 6
        Text = #1041#1077#1079' '#1053#1044#1057
        Items.Strings = (
          #1041#1077#1079' '#1053#1044#1057
          #1053#1044#1057' 0%'
          #1053#1044#1057' 10%'
          #1053#1044#1057' 20%'
          #1053#1044#1057' 10/100'
          #1053#1044#1057' 20/120')
      end
      object seGoodsPrice: TsDecimalSpinEdit
        Left = 352
        Top = 246
        Width = 573
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 7
        AllowNegative = False
        Increment = 1.000000000000000000
      end
      object editGoodsPLU: TsEdit
        Left = 352
        Top = 219
        Width = 546
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        Enabled = False
        ReadOnly = True
        TabOrder = 8
      end
      object cbGoodsPPR: TsComboBox
        Left = 352
        Top = 273
        Width = 573
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        Style = csDropDownList
        ItemIndex = -1
        TabOrder = 9
      end
      object cbGoodsFractional: TsComboBox
        Left = 352
        Top = 300
        Width = 573
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        Style = csDropDownList
        ItemIndex = -1
        TabOrder = 10
        Items.Strings = (
          #1053#1077#1090
          #1044#1072)
      end
      object cbGoodsUnloadInScales: TsComboBox
        Left = 352
        Top = 327
        Width = 573
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        Style = csDropDownList
        ItemIndex = -1
        TabOrder = 11
        Items.Strings = (
          #1053#1077#1090
          #1044#1072)
      end
      object cbGoodsQuantityRequest: TsComboBox
        Left = 352
        Top = 354
        Width = 573
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        Style = csDropDownList
        ItemIndex = -1
        TabOrder = 12
        Items.Strings = (
          #1053#1077#1090
          #1044#1072)
      end
      object cbGoodsPriceRequest: TsComboBox
        Left = 352
        Top = 381
        Width = 573
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        Style = csDropDownList
        ItemIndex = -1
        TabOrder = 13
        Items.Strings = (
          #1053#1077#1090
          #1044#1072)
      end
      object editGoodsParent: TsEdit
        Left = 352
        Top = 30
        Width = 546
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        ReadOnly = True
        TabOrder = 14
      end
      object seGoodsDepartment: TsSpinEdit
        Left = 352
        Top = 192
        Width = 573
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        NumbersOnly = True
        TabOrder = 15
        AllowNegative = False
        MaxValue = 30
        MinValue = 0
      end
      object memoGoodsComposition: TsMemo
        Left = 352
        Top = 408
        Width = 573
        Height = 102
        Anchors = [akLeft, akTop, akRight]
        ScrollBars = ssVertical
        TabOrder = 16
      end
      object cbGoodsType: TsComboBox
        Left = 352
        Top = 84
        Width = 573
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 17
        Text = #1054#1073#1099#1095#1085#1099#1081' '#1090#1086#1074#1072#1088
        Items.Strings = (
          #1054#1073#1099#1095#1085#1099#1081' '#1090#1086#1074#1072#1088
          #1052#1072#1088#1082#1080#1088#1086#1074#1072#1085#1085#1099#1081' '#1072#1083#1082#1086#1075#1086#1083#1100
          #1052#1077#1093#1086#1074#1099#1077' '#1080#1079#1076#1077#1083#1080#1103
          #1051#1077#1082#1072#1088#1089#1090#1074#1077#1085#1085#1099#1077' '#1087#1088#1077#1087#1072#1088#1072#1090#1099
          #1058#1072#1073#1072#1095#1085#1072#1103' '#1087#1088#1086#1076#1091#1082#1094#1080#1103
          #1054#1073#1091#1074#1100
          #1051#1086#1090#1077#1088#1077#1103
          #1048#1085#1072#1103' '#1084#1072#1088#1082#1080#1088#1086#1074#1072#1085#1085#1072#1103' '#1087#1088#1086#1076#1091#1082#1094#1080#1103)
      end
    end
  end
  object OpenPictureDialog1: TsOpenPictureDialog
    Filter = 
      'All (*.png;*.gif;*.png;*.jpg;*.jpeg;*.bmp;*.jpg;*.jpeg;*.gif;*.p' +
      'ng;*.ico;*.emf;*.wmf;*.tif;*.tiff)|*.png;*.gif;*.png;*.jpg;*.jpe' +
      'g;*.bmp;*.jpg;*.jpeg;*.gif;*.png;*.ico;*.emf;*.wmf;*.tif;*.tiff|' +
      'Portable network graphics (AlphaControls) (*.png)|*.png|GIF Imag' +
      'e (*.gif)|*.gif|Portable Network Graphics (*.png)|*.png|JPEG Ima' +
      'ge File (*.jpg)|*.jpg|JPEG Image File (*.jpeg)|*.jpeg|Bitmaps (*' +
      '.bmp)|*.bmp|JPEG Images (*.jpg)|*.jpg|JPEG Images (*.jpeg)|*.jpe' +
      'g|GIF Images (*.gif)|*.gif|PNG Images (*.png)|*.png|Icons (*.ico' +
      ')|*.ico|Enhanced Metafiles (*.emf)|*.emf|Metafiles (*.wmf)|*.wmf' +
      '|TIFF Images (*.tif)|*.tif|TIFF Images (*.tiff)|*.tiff'
    Options = [ofPathMustExist, ofFileMustExist, ofEnableSizing, ofDontAddToRecent]
    Left = 108
    Top = 22
  end
  object timerInit: TTimer
    Interval = 1
    OnTimer = timerInitTimer
    Left = 28
    Top = 22
  end
end
