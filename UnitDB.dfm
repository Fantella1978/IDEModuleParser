object DM1: TDM1
  Height = 480
  Width = 640
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
    Top = 152
  end
  object DataSetProvider1: TDataSetProvider
    DataSet = cdsModules
    Left = 64
    Top = 232
  end
end
