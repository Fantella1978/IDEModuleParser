object DM1: TDM1
  Height = 480
  Width = 830
  object cdsModules: TClientDataSet
    PersistDataPacket.Data = {
      A10000009619E0BD010000001800000006000000000003000000A100034E756D
      0400010004000000044E616D650100490000000100055749445448020002007F
      000450617468020049000000010005574944544802000200FF00075665727369
      6F6E0100490000000100055749445448020002001B000B44617465416E645469
      6D65080008000000000004486173680100490000000100055749445448020002
      0028000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'Num'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'Name'
        DataType = ftString
        Size = 127
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
      end>
    IndexDefs = <
      item
        Name = 'cdsModulesNameIndexASC'
        Fields = 'Name;Path'
        Options = [ixCaseInsensitive]
      end
      item
        Name = 'cdsModulesNameIndex'
        Fields = 'Name;Path'
        Options = [ixDescending, ixCaseInsensitive]
      end
      item
        Name = 'cdsModulesPathIndexASC'
        Fields = 'Path;Name'
        Options = [ixCaseInsensitive]
      end
      item
        Name = 'cdsModulesPathIndex'
        Fields = 'Path;Name'
        Options = [ixDescending, ixCaseInsensitive]
      end
      item
        Name = 'cdsModulesDateAndTimeIndexASC'
        Fields = 'DateAndTime;Path;Name'
      end
      item
        Name = 'cdsModulesDateAndTimeIndex'
        Fields = 'DateAndTime;Path;Name'
        Options = [ixDescending]
      end
      item
        Name = 'cdsModulesVersionIndexASC'
        Fields = 'Version;Name'
      end
      item
        Name = 'cdsModulesVersionIndex'
        Fields = 'Version;Name'
        Options = [ixDescending]
      end>
    Params = <>
    StoreDefs = True
    Left = 64
    Top = 56
    object cdsModulesNum: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'Num'
      Required = True
    end
    object cdsModulesName: TStringField
      FieldName = 'Name'
      Size = 127
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
  object cdsPackages: TClientDataSet
    PersistDataPacket.Data = {
      570000009619E0BD0100000018000000030000000000030000005700034E756D
      0400010010000000044E616D6501004900100001000557494454480200020014
      000355726C020049001000010005574944544802000200FF000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'Num'
        Attributes = [faUnNamed]
        DataType = ftInteger
      end
      item
        Name = 'Name'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Url'
        Attributes = [faUnNamed]
        DataType = ftString
        Size = 255
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 568
    Top = 56
    object cdsPackagesNum: TIntegerField
      FieldName = 'Num'
    end
    object cdsPackagesName: TStringField
      FieldName = 'Name'
    end
    object cdsPackagesUrl: TStringField
      FieldName = 'Url'
      Size = 255
    end
  end
  object dsLocalPackages: TDataSource
    DataSet = cdsPackages
    Left = 568
    Top = 120
  end
  object DataSetProvider2: TDataSetProvider
    Left = 568
    Top = 176
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\Tester\Documents\Embarcadero\Studio\Projects\I' +
        'DE Module Parser\IDEModuleParser.db3'
      'DriverID=SQLite')
    Connected = True
    LoginPrompt = False
    Left = 232
    Top = 56
  end
  object fdqModulesFromQuery: TFDQuery
    Active = True
    Connection = FDConnection1
    SQL.Strings = (
      
        'SELECT m.FileName, p.Name as PackageName, p.Url FROM Modules m L' +
        'EFT OUTER JOIN Packages p ON p.Num = m.Package')
    Left = 232
    Top = 248
  end
  object fdtModules: TFDTable
    Active = True
    IndexFieldNames = 'Num'
    Connection = FDConnection1
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'Modules'
    Left = 232
    Top = 120
  end
  object dsModules: TDataSource
    DataSet = fdtModules
    Left = 232
    Top = 184
  end
  object fdtPackages: TFDTable
    Active = True
    IndexFieldNames = 'Num'
    Connection = FDConnection1
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'Packages'
    Left = 312
    Top = 120
  end
  object dsPackages: TDataSource
    DataSet = fdtPackages
    Left = 312
    Top = 184
  end
  object dsModulesFromQuery: TDataSource
    DataSet = fdqModulesFromQuery
    Left = 232
    Top = 312
  end
end
