object DM1: TDM1
  Height = 480
  Width = 640
  object cdsModules: TClientDataSet
    PersistDataPacket.Data = {
      3F0000009619E0BD0100000018000000020000000000030000003F00034E756D
      0400010004000000044E616D6501004900000001000557494454480200020014
      000000}
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
        Size = 20
      end>
    IndexDefs = <
      item
        Name = 'cdsModulesNameIndex'
        Fields = 'Name'
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
