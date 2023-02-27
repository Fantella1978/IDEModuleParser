object DM1: TDM1
  Height = 480
  Width = 830
  object cdsModules: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'Num'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'FileName'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'Path'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'Version'
        DataType = ftString
        Size = 27
      end
      item
        Name = 'DateAndTime'
        DataType = ftDateTime
      end
      item
        Name = 'Hash'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'PackageID'
        DataType = ftInteger
      end
      item
        Name = 'PackageName'
        DataType = ftString
        Size = 60
      end>
    IndexDefs = <
      item
        Name = 'cdsModulesFileNameIndexASC'
        Fields = 'FileName'
        Options = [ixCaseInsensitive]
      end
      item
        Name = 'cdsModulesFileNameIndex'
        Fields = 'FileName'
        Options = [ixDescending, ixCaseInsensitive]
      end
      item
        Name = 'cdsModulesPathIndexASC'
        Fields = 'Path;FileName'
        Options = [ixCaseInsensitive]
      end
      item
        Name = 'cdsModulesPathIndex'
        Fields = 'Path;FileName'
        Options = [ixDescending, ixCaseInsensitive]
      end
      item
        Name = 'cdsModulesDateAndTimeIndexASC'
        Fields = 'DateAndTime;Path;FileName'
      end
      item
        Name = 'cdsModulesDateAndTimeIndex'
        Fields = 'DateAndTime;Path;FileName'
        Options = [ixDescending]
      end
      item
        Name = 'cdsModulesVersionIndexASC'
        Fields = 'Version;FileName'
      end
      item
        Name = 'cdsModulesVersionIndex'
        Fields = 'Version;FileName'
        Options = [ixDescending]
      end
      item
        Name = 'cdsModulesPackageNameIndexASC'
        Fields = 'PackageName;FileName'
      end
      item
        Name = 'cdsModulesPackageNameIndex'
        Fields = 'PackageName;FileName'
        Options = [ixDescending]
      end>
    Params = <>
    StoreDefs = True
    AfterScroll = cdsModulesAfterScroll
    Left = 64
    Top = 56
    object cdsModulesNum: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'Num'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object cdsModulesFileName: TStringField
      FieldName = 'FileName'
      Size = 60
    end
    object cdsModulesPath: TStringField
      FieldName = 'Path'
      Size = 255
    end
    object cdsModulesVersion: TStringField
      FieldName = 'Version'
      Size = 27
    end
    object cdsModulesDateAndTime: TDateTimeField
      FieldName = 'DateAndTime'
    end
    object cdsModulesHash: TStringField
      FieldName = 'Hash'
      Size = 40
    end
    object cdsModulesPackageID: TIntegerField
      FieldName = 'PackageID'
    end
    object cdsModulesPackageName: TStringField
      FieldName = 'PackageName'
      Size = 60
    end
  end
  object DataSource1: TDataSource
    DataSet = cdsModules
    Left = 64
    Top = 120
  end
  object DataSetProvider1: TDataSetProvider
    DataSet = cdsModules
    Left = 64
    Top = 176
  end
  object fdcSQLite: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\Tester\Documents\Embarcadero\Studio\Projects\I' +
        'DE Module Parser\IDEModuleParser.db3'
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 280
    Top = 56
  end
  object fdqModulesFromQuery: TFDQuery
    Connection = fdcSQLite
    SQL.Strings = (
      
        'SELECT m.FileName, p.Name as PackageName, p.Url FROM Modules m L' +
        'EFT OUTER JOIN Packages p ON p.Num = m.PackageID')
    Left = 232
    Top = 248
  end
  object fdtModules: TFDTable
    IndexFieldNames = 'Num'
    Connection = fdcSQLite
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'Modules'
    Left = 232
    Top = 120
    object fdtModulesNum: TFDAutoIncField
      FieldName = 'Num'
      Origin = 'Num'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object fdtModulesFileName: TStringField
      FieldName = 'FileName'
      Origin = 'FileName'
      Required = True
      Size = 100
    end
    object fdtModulesHash: TStringField
      FieldName = 'Hash'
      Origin = 'Hash'
      FixedChar = True
      Size = 40
    end
    object fdtModulesPathRegExp: TWideStringField
      FieldName = 'PathRegExp'
      Origin = 'PathRegExp'
      Size = 100
    end
    object fdtModulesVersion: TStringField
      FieldName = 'Version'
      Origin = 'Version'
      Size = 27
    end
    object fdtModulesVersionRegExp: TWideStringField
      FieldName = 'VersionRegExp'
      Origin = 'VersionRegExp'
      Size = 100
    end
    object fdtModulesPackageID: TIntegerField
      FieldName = 'PackageID'
      Origin = 'PackageID'
    end
  end
  object dsModules: TDataSource
    DataSet = fdtModules
    Left = 232
    Top = 184
  end
  object fdtPackages: TFDTable
    AfterOpen = fdtPackagesAfterOpen
    AfterEdit = fdtPackagesAfterEdit
    AfterCancel = fdtPackagesAfterCancel
    AfterRefresh = fdtPackagesAfterRefresh
    IndexFieldNames = 'Num'
    Connection = fdcSQLite
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'Packages'
    Left = 336
    Top = 120
  end
  object dsPackages: TDataSource
    DataSet = fdtPackages
    OnStateChange = dsPackagesStateChange
    Left = 336
    Top = 184
  end
  object dsModulesFromQuery: TDataSource
    DataSet = fdqModulesFromQuery
    Left = 232
    Top = 312
  end
  object FDUpdateSQL1: TFDUpdateSQL
    Connection = fdcSQLite
    Left = 336
    Top = 248
  end
end
