object formSelectParent: TformSelectParent
  Left = 0
  Top = 0
  ActiveControl = tvGoodsGroups
  BorderStyle = bsNone
  Caption = 'formSelectParent'
  ClientHeight = 600
  ClientWidth = 1024
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
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
    object sPanel7: TsPanel
      Left = 2
      Top = 557
      Width = 1020
      Height = 41
      Align = alBottom
      Caption = 'sPanel6'
      ShowCaption = False
      TabOrder = 0
      OnResize = PanelResize
      object btnSelectGroup: TsButton
        Left = 0
        Top = 1
        Width = 342
        Height = 40
        Caption = #1042#1099#1073#1088#1072#1090#1100
        ModalResult = 6
        TabOrder = 0
        OnClick = btnSelectGroupClick
      end
      object btnCancel: TsButton
        Left = 343
        Top = 1
        Width = 355
        Height = 40
        Cancel = True
        Caption = #1054#1090#1084#1077#1085#1072
        ModalResult = 2
        TabOrder = 1
      end
    end
    object tvGoodsGroups: TsTreeView
      Left = 2
      Top = 2
      Width = 1020
      Height = 555
      Align = alClient
      AutoExpand = True
      Indent = 19
      ReadOnly = True
      StateImages = sAlphaImageList1
      TabOrder = 1
      OnClick = tvGoodsGroupsClick
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
    Left = 8
    Top = 8
  end
  object sAlphaImageList1: TsAlphaImageList
    Height = 64
    Width = 64
    Items = <
      item
        ImageFormat = ifPNG
        ImageName = 'folder'
        ImgData = {
          89504E470D0A1A0A0000000D49484452000001000000010008060000005C72A8
          660000050349444154789CEDDD4B6BDC6500C5E1D34928B5D6222AB5486D8B28
          78812C8A585044DCB810145D082AD6EA42BC2DF4FBB810A90BBF809F41EB42A4
          88E8CAA41B77AEA2884470F14F24486A2F26F34E729E07029961168730F99199
          7726930000000000000000000000000000000000000000000000000000000000
          000000D773E81AD71F4BB292E47492B349CE24599ED3A645B491642DC9EAE6D7
          F749D607EE815DB15300CE25B9902902EC6C3DC96749BE1B3D04FE8FED013892
          E48D24E7076DD98FBE4AF24592DF470F815BB1B4EDFBB7E297FF66DD9FE4D124
          5F27F96BF016B8695B013897E4A59143F6B13B939C4AF2CDE82170B396323DD6
          FF38C9E1C15BF6B393496ECFF4E420EC1B4B491E8F3FFD77C303497E4BF2F3E8
          2170A366998EFAD81DAF653A3E857D6196E99C9FDDF36E44957D6296E9453EEC
          9EC3493E4A72D7E821703DB374BFC26FAF1CCF148123A387C07F998D1E7080DD
          97E4BDF819B3C0DC39F7D663495E1F3D02AE4500F6DE33499E1B3D02762200F3
          F14AA6575BC2421180F979278E5C593002303FCB994E06EE193D04B608C07C1D
          CB1481A3A387402200239C8CE34116843BE1188F247973F4081080719E4AF2FC
          E811741380B15E4EF2C4E811F41280F1DE4EF2E0E811741280F196937C98E4C4
          E821F41180C5B0753CE85FB1335702B0384E24F920DE9ECD1C09C0627928D3BF
          6787B91080C5733EC98BA347D0410016D30B499E1C3D82834F0016D7C5240F8F
          1EC1C126008B6B96E4FD4CEF1D803D21008BED681C0FB2870E25F964F408AE6B
          63F30B6ED49F49D6925C4DB29AE4C7247FFCFB4602001D7E4DF269A610FC6329
          8E9CA0C16D994E96EE48F253363FCEDE7300D0E5D924AF6E5D1000E8F374363F
          C45600A0D3C5244705003A1D4FB22200D0EBAC0040AFD30200BDCE0800F43A2C
          00504C00A0980040310180620200C504008A0900141300282600504C00A09800
          40310180620200C504008A0900141300282600504C00A0980040310180620200
          C504008A0900141300282600504C00A0980040310180620200C504008A090014
          1300282600504C00A0980040310180620200C504008A0900141300282600504C
          00A0980040310180620200C504008A0900141300282600504C00A09800403101
          80620200C504008A0900141300282600504C00A0980040310180620200C50400
          8A0900141300282600504C00A0980040310180620200C504008A090014130028
          2600504C00A0980040310180620200C504008A0900141300282600504C00A098
          0040310180620200C504008A0900141300282600504C00A09800403101806202
          00C504008A0900141300282600504C00A0980040310180620200C504008A0900
          141300282600504C00A0980040310180620200C504008A090014130028260050
          4C00A0980040310180620200C504008A0900141300282600504C00A098004031
          0180620200C504008A0900141300282600504C00A0980040310180620200C504
          008A0900141300282600504C00A0980040B159928DD1238021366649D646AF00
          86589B25591DBD0218627596E4EAE815C010576749AE24591FBD0498ABF52457
          669BDF5C1A3C0698AF4B49D697362FFC92E4DE24A7C6ED01E6E472922F936469
          DB953F24B93B220007D9E5249F67F3F8FFD00E373897E4429263731C05ECADAD
          87FADF6EBF72A70024D32FFF4A92D349CE26399364790FC701BB6B23D36B7C56
          339DF479B21F0000000000000000000000000000000000000000000000000000
          00000000006ED1DFC8334F5DBA9464090000000049454E44AE426082}
      end
      item
        ImageFormat = ifPNG
        ImageName = 'folder2'
        ImgData = {
          89504E470D0A1A0A0000000D49484452000001000000010008060000005C72A8
          660000085149444154789CEDDDCBAB5D571D07F06F6E2E21C4B4482D35949A54
          0B062A54083E513B71A242C5C74830BE2AF846FF0171E81FA182D0893876200E
          1CAA0311292AD4074DAD5471209ADE8650D2E860DF485AEEDD8FB3F7DD7BEDB5
          3F1FB834E49C7DB208DDDFACF55BEB7776020000000000000000000000000000
          0000000000000000000000000000000000743975CCEF9F4FF258928B491E4E72
          29C9FE4C632AD1AD24CF25B976F8F3BB24070B8E07267154005C4972354D0870
          B483244F25F9CDD2038131EE0E80B3493E9DE4DD0B8D658D7E99E447496E2C3D
          10D8C5E9BB7EFDB9B8F9877A53924793FC2AC92B0B8F0506BB130057927C6CC9
          81ACD8EB933C94E4D749FEBBF0586090D369D6FADF4A7266E1B1ACD98524E7D2
          140761354E2779474CFDA7F096242F257976E981405F7B69B6FA98C6A7D26C9F
          C22AECA5D9E7673A5F8A506525F6D21CF2613A67927C33C97D4B0F04BAEC65DB
          27FC4ECABD6942E0ECD20381367B4B0FA0620F26F972FC1D5330FF739EACB7A5
          395D0945120027EF03493EB4F420E02802601E9F4C73DE028A2200E6F3649AC3
          42500C01309FFD24DF4872FFD203813B04C0BCCEA7D91E3CB7F4402011004BB8
          90E4AB71FE82020880655C4EF299A50701026039EF4DF2D1A507C1B60980653D
          91E43D4B0F82ED1200CBFB6C92B72E3D08B649002C6F3FC9D7D21407615602A0
          0CE7D26C0FFA2A76662500CA717F92AFC7F620331200657924C917961E04DB21
          00CAF3CE249F587A106C830028D38793BC7FE941503F0150AEAB699E3A042746
          00946B2FC957D27CB5189C080150B6B369B607EF5D7A20D4E95492EF2D3D083A
          DD3EFC811B499E4FF2B7247F4EF2DB311F260060DDFE92E611F5D776B9F87474
          A4C19ADD97E4F1348FA7FFD3D08BD500A00E1F4FF2AEA1170900A8C7E733F059
          9F0200EAB19FE423432E10005097B767C0B6B12220D4E5549A99C0419A2DC357
          BADE6C1B10EA743BC93F923C9BE41749FEF8DA37980140BD4E25B927C9C524EF
          4BF2BA3421F0FF59811A006CC707937C27777DFD9C00806D7920C9177378EF0B
          00D89E4B39DC2E1400B04D4F24B92000609BF6923C3AE537D03E9FE46749FEB9
          E3F543C3E8A4DF3FF79F677C65BF7FEE3F6FECF8CEA779FC5CDBE3E82F4E1900
          DF4FF2C2849F078CF3F324DF4DF3C5324779F3544B80EB71F343690ED27C5FC0
          711E982A006E4EF439C0B4CEB5BC7673AA007871A2CF01A6754FCB6BD7A70A80
          83893E079856DBF3265F140050AFFD1C5F004C92030100F56A5BFF27C90D0100
          F5EA7ADCBC1A0054ACEB9B812C01A0625D33004B00A8585700980140C5D40060
          C3CC0060C366A901B8F9A14C6D01703B1305C08D093E03985E5B001C24D37C25
          98462028535B23D06401600900656A6D044A0400D46A3FC99996D7CD00A0629D
          5B808900805A0900D83001001B260060C304006C9800800D1300B061B304809B
          1FCAD4D5087433191F001A81A04C9D8D40C9F800D0080465EA6C044A2C01A056
          9D8D408900801AF56A044A0400D4A8F37900777E2100A03EBDB60013010035EA
          7A26A000808A9901C086A901C0869901C086A901C086CDB20470F343997A3502
          25E30240231094A96D09F0AA7FB8C7048046202853AF46A0C412006AD4560378
          D53FDC6302E0FA886B8193B17FF8739CC966006A00509EDE3B00892500D4A6F7
          21A04400406D7A1F024A0400D4C60C00364C0D0036CC0C00364C0D00366C9625
          809B1FCAD4BB11281100509BDE8D40C9EE01F0D28ED70127AB772350620600B5
          E9DD0894EC1E001A81A03C831A8192DD034023109467D00E4062090035197408
          2811005093418780120100353103800D5303800D3303800D5303800D9B6509E0
          E68732B52D016EE5358D408900809AB42D018E3CBCB74B00680482320D6A044A
          CC00A026831A8192DD024023109467702350B25B00680482F20CDE01482C01A0
          16830F012502006A31F810502200A0166600B0616A00B0616600B0616A00B061
          B32C01DCFC50A6C18D408900805A0C7A22D01D430340231094A9AD11E8D8D3BB
          66005087B61AC07F8E7B616800680482F2ECD408940C0F008D40509E9D760012
          4B00A841D721203500A858D721A06397EE6A00B07E3B1D034ED400A0065D3500
          4B00A8D86C33000100E599AD062000A03CB36C03BAF9A14C5D8D402F1FF7A200
          80F5DBA911281916001A81A04C6D8D40473E10E40E330058BFB61AC064330087
          80A03C3B370225C302C0212028CFCE3B00892500ACDDCE87801201006BB7D3B7
          01DFA10600EB36DB0C400D00CAA306001BA606001B365B0D40004079665902B8
          F9A14C3B3702250200D66EE746A0A47F0068048232EDDC08949801C0DAEDDC08
          94F40F008780A03CA31A8112330058B3513B0049FF00700A10CA33EA10506206
          006B36EA1050A206006B36DB0CC01200CA335B0DC01200CAA306001B365B0D40
          004079665902B8F9A14CA31A811201006B36AA1128E917009D0D05C022463502
          25FD02C016209469542350D22F001C0282F28C6E044AD40060AD46EF00249600
          B056A30F01256600B056A30F01256A00B056B3CD002C01A03CB3D5002C01A03C
          6A00B061B3D500040094679625809B1FCA34BA11281100B056A31B8192EE00D0
          0804651ADD0894340170ABE5F5DBBD8703CC653FED4B807FF7FDA0BD24CFB5BC
          7E39C9C5BE1F06CCE2F124675A5EFF6BDF0FDA4F722DC9232DEFF9769267E240
          1094E08D491EEC78CFA000E8F3E6CB7D3F1058DCB5BE6FDC4BF27454FBA116CF
          24F957DF37EFA5B9F99F3AB1E100737939C90F875C70FAF0BF7F4FB3B67868E2
          0101F3F97192DF0FB9E0F45DBFFE4392374408C0DADC4EF293243F1D7AE1A923
          7EEF4A92ABE9EE360296F742921F6440E5FF6E470540D2DCFC8FA53903F07092
          4B69FF0242601E37D29CDDB976F8F374DA0FF301000000000000000000000000
          0000000000000000000000000000000000000023FD0F229D762494B43F7F0000
          000049454E44AE426082}
      end>
    Left = 100
    Top = 14
    Bitmap = {
      494C010100000800080001000100FFFFFFFF0400FFFFFFFFFFFFFFFF424D7600
      0000000000007600000028000000040000000100000001000400000000000400
      0000000000000000000000000000000000000000000000008000008000000080
      8000800000008000800080800000C0C0C000808080000000FF0000FF000000FF
      FF00FF000000FF00FF00FFFF0000FFFFFF0000000000}
  end
end
