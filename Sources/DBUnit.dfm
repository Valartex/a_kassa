object DM1: TDM1
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 309
  Width = 323
  object FDConnection1: TFDConnection
    Params.Strings = (
      'DriverID=SQLite')
    ResourceOptions.AssignedValues = [rvAutoConnect]
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.LockWait = True
    UpdateOptions.RefreshMode = rmManual
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    LoginPrompt = False
    Transaction = FDTransaction1
    Left = 24
    Top = 8
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    Left = 176
    Top = 8
  end
  object FDTransaction1: TFDTransaction
    Connection = FDConnection1
    Left = 104
    Top = 8
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    ScreenCursor = gcrDefault
    Left = 248
    Top = 232
  end
  object FDCommand1: TFDCommand
    Connection = FDConnection1
    Transaction = FDTransaction1
    Left = 264
    Top = 8
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 32
    Top = 88
  end
  object FDSQLiteBackup1: TFDSQLiteBackup
    DriverLink = FDPhysSQLiteDriverLink1
    Catalog = 'MAIN'
    DestCatalog = 'MAIN'
    Left = 32
    Top = 240
  end
end
