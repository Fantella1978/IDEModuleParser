object DM1: TDM1
  OnCreate = DataModuleCreate
  Height = 480
  Width = 830
  object cdsModules: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'Module_ID'
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
        Name = 'Package_ID'
        DataType = ftInteger
      end
      item
        Name = 'PackageName'
        DataType = ftString
        Size = 120
      end
      item
        Name = 'PackageType_ID'
        DataType = ftInteger
      end
      item
        Name = 'PackageVersion'
        DataType = ftString
        Size = 27
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
      end
      item
        Name = 'cdsModulesModule_IDIndexUNIQ'
        Fields = 'Module_ID'
        Options = [ixPrimary, ixUnique]
      end>
    Params = <>
    StoreDefs = True
    AfterScroll = cdsModulesAfterScroll
    Left = 64
    Top = 56
    object cdsModulesModule_ID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'Module_ID'
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
    object cdsModulesPackage_ID: TIntegerField
      FieldName = 'Package_ID'
    end
    object cdsModulesPackageName: TStringField
      FieldName = 'PackageName'
      Size = 120
    end
    object cdsModulesPackageType_ID: TIntegerField
      FieldName = 'PackageType_ID'
    end
    object cdsModulesPackageVersion: TStringField
      FieldName = 'PackageVersion'
      Size = 27
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
      'Database=Z:\IDE Module Parser\IDEModuleParser.db3'
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 280
    Top = 56
  end
  object fdqModulesFromQuery: TFDQuery
    Connection = fdcSQLite
    SQL.Strings = (
      
        'SELECT m.FileName, p.Name as PackageName, p.Url FROM Modules m L' +
        'EFT OUTER JOIN Packages p ON p.Package_ID = m.Package_ID')
    Left = 232
    Top = 256
  end
  object fdtModules: TFDTable
    AfterScroll = fdtModulesAfterScroll
    AfterRefresh = fdtModulesAfterRefresh
    IndexFieldNames = 'Module_ID'
    Connection = fdcSQLite
    FetchOptions.AssignedValues = [evCursorKind]
    FetchOptions.CursorKind = ckStatic
    FormatOptions.AssignedValues = [fvSortLocale, fvSortOptions]
    FormatOptions.SortLocale = 0
    FormatOptions.SortOptions = [soNoCase]
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    UpdateOptions.KeyFields = 'Module_ID'
    TableName = 'Modules'
    Left = 232
    Top = 120
    object fdtModulesModule_ID: TFDAutoIncField
      DisplayLabel = 'Module Id'
      FieldName = 'Module_ID'
      Origin = 'Module_ID'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object fdtModulesFileName: TStringField
      DisplayLabel = 'File Name'
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
    object fdtModulesVersion: TStringField
      FieldName = 'Version'
      Origin = 'Version'
      Size = 27
    end
    object fdtModulesPackage_ID: TIntegerField
      DisplayLabel = 'Package Id'
      FieldName = 'Package_ID'
      Origin = 'Package_ID'
    end
    object fdtModulesPathRegExp: TStringField
      DisplayLabel = 'Path RegExp'
      FieldName = 'PathRegExp'
      Origin = 'PathRegExp'
      Size = 100
    end
    object fdtModulesVersionRegExp: TStringField
      DisplayLabel = 'Version RegExp'
      FieldName = 'VersionRegExp'
      Origin = 'VersionRegExp'
      Size = 100
    end
    object fdtModulesFileNameRegExp: TStringField
      DisplayLabel = 'File Name RegExp'
      FieldName = 'FileNameRegExp'
      Origin = 'FileNameRegExp'
      OnValidate = fdtModulesFileNameRegExpValidate
      Size = 120
    end
    object fdtModulesPackage_Name: TStringField
      DisplayLabel = 'Package Name'
      FieldKind = fkLookup
      FieldName = 'Package_FullName'
      LookupDataSet = fdtPackages
      LookupKeyFields = 'Package_ID'
      LookupResultField = 'FullName'
      KeyFields = 'Package_ID'
      LookupCache = True
      Size = 60
      Lookup = True
    end
  end
  object dsModules: TDataSource
    DataSet = fdtModules
    Left = 232
    Top = 184
  end
  object fdtPackages: TFDTable
    AfterInsert = fdtPackagesAfterInsert
    AfterScroll = fdtPackagesAfterScroll
    AfterRefresh = fdtPackagesAfterRefresh
    OnCalcFields = fdtPackagesCalcFields
    IndexFieldNames = 'Package_ID'
    Connection = fdcSQLite
    UpdateTransaction = FDTransaction1
    FetchOptions.AssignedValues = [evCursorKind]
    FetchOptions.CursorKind = ckStatic
    FormatOptions.AssignedValues = [fvSortLocale, fvSortOptions]
    FormatOptions.SortOptions = [soNoCase]
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    UpdateOptions.AssignedValues = [uvUpdateNonBaseFields, uvAutoCommitUpdates]
    UpdateOptions.KeyFields = 'Package_ID'
    TableName = 'Packages'
    Left = 336
    Top = 120
    object fdtPackagesPackage_ID: TFDAutoIncField
      FieldName = 'Package_ID'
      Origin = 'Package_ID'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object fdtPackagesName: TStringField
      FieldName = 'Name'
      Origin = 'Name'
      Required = True
      Size = 60
    end
    object fdtPackagesSubName: TStringField
      FieldName = 'SubName'
      Origin = 'SubName'
      Size = 60
    end
    object fdtPackagesUrl: TStringField
      FieldName = 'Url'
      Origin = 'Url'
      Size = 255
    end
    object fdtPackagesVersionRegExp: TStringField
      FieldName = 'VersionRegExp'
      Origin = 'VersionRegExp'
      Size = 100
    end
    object fdtPackagesVersion: TStringField
      FieldName = 'Version'
      Origin = 'Version'
      Size = 27
    end
    object fdtPackagesType_ID: TIntegerField
      FieldName = 'Type_ID'
      Origin = 'Type_ID'
    end
    object fdtPackagesInGetIt: TBooleanField
      FieldName = 'InGetIt'
      Origin = 'InGetIt'
    end
    object fdtPackagesDescription: TWideMemoField
      FieldName = 'Description'
      Origin = 'Description'
      BlobType = ftWideMemo
    end
    object fdtPackagesPackage_Type: TStringField
      FieldKind = fkLookup
      FieldName = 'Package_Type'
      LookupDataSet = fdtPackageTypes
      LookupKeyFields = 'Type_ID'
      LookupResultField = 'Name'
      KeyFields = 'Type_ID'
      LookupCache = True
      Size = 50
      Lookup = True
    end
    object fdtPackagesFullName: TStringField
      FieldKind = fkInternalCalc
      FieldName = 'FullName'
      Size = 149
    end
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
  object fdtPackageTypes: TFDTable
    IndexFieldNames = 'Type_ID'
    Connection = fdcSQLite
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'PackageTypes'
    Left = 424
    Top = 120
  end
  object dsPackageTypes: TDataSource
    DataSet = fdtPackageTypes
    Left = 424
    Top = 184
  end
  object FDTransaction1: TFDTransaction
    Connection = fdcSQLite
    Left = 336
    Top = 312
  end
  object cdsScreenshots: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'FilePath'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'FileName'
        DataType = ftString
        Size = 255
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 560
    Top = 64
    object cdsScreenshotsFilePath: TStringField
      FieldName = 'FilePath'
      Size = 255
    end
    object cdsScreenshotsFileName: TStringField
      FieldName = 'FileName'
      Size = 255
    end
  end
  object dsScreenshots: TDataSource
    DataSet = cdsScreenshots
    Left = 560
    Top = 120
  end
  object dspScreenshots: TDataSetProvider
    DataSet = cdsScreenshots
    Left = 560
    Top = 184
  end
end
