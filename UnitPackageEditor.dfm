object frmPackageEditor: TfrmPackageEditor
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Package Editor'
  ClientHeight = 382
  ClientWidth = 688
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  DesignSize = (
    688
    382)
  TextHeight = 15
  object lblName: TLabel
    Left = 36
    Top = 17
    Width = 35
    Height = 15
    Caption = 'Name:'
  end
  object lblSubName: TLabel
    Left = 16
    Top = 46
    Width = 55
    Height = 15
    Caption = 'SubName:'
  end
  object lblVersion: TLabel
    Left = 30
    Top = 75
    Width = 41
    Height = 15
    Caption = 'Version:'
  end
  object lblUrl: TLabel
    Left = 47
    Top = 133
    Width = 24
    Height = 15
    Caption = 'URL:'
  end
  object lblVersionRegExp: TLabel
    Left = 252
    Top = 75
    Width = 83
    Height = 15
    Caption = 'Version RegExp:'
  end
  object lblType: TLabel
    Left = 44
    Top = 104
    Width = 27
    Height = 15
    Caption = 'Type:'
  end
  object Label1: TLabel
    Left = 8
    Top = 159
    Width = 63
    Height = 15
    Caption = 'Description:'
  end
  object Panel1: TPanel
    Left = 0
    Top = 345
    Width = 688
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 6
    ExplicitTop = 341
    ExplicitWidth = 686
    DesignSize = (
      688
      37)
    object Button1: TButton
      Left = 504
      Top = 6
      Width = 75
      Height = 25
      Action = actSave
      Anchors = [akTop, akRight]
      Default = True
      TabOrder = 0
      ExplicitLeft = 502
    end
    object Button2: TButton
      Left = 591
      Top = 6
      Width = 75
      Height = 25
      Action = actCancel
      Anchors = [akTop, akRight]
      Cancel = True
      TabOrder = 1
      ExplicitLeft = 589
    end
  end
  object dbeName: TDBEdit
    Left = 77
    Top = 11
    Width = 284
    Height = 23
    DataField = 'Name'
    DataSource = DM1.dsPackages
    TabOrder = 0
    OnChange = dbeNameChange
  end
  object dbeSubName: TDBEdit
    Left = 77
    Top = 40
    Width = 491
    Height = 23
    DataField = 'SubName'
    DataSource = DM1.dsPackages
    TabOrder = 1
    OnChange = dbeSubNameChange
  end
  object dbeVersion: TDBEdit
    Left = 77
    Top = 69
    Width = 164
    Height = 23
    DataField = 'Version'
    DataSource = DM1.dsPackages
    TabOrder = 2
    OnChange = dbeVersionChange
  end
  object dbeURL: TDBEdit
    Left = 77
    Top = 127
    Width = 587
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    DataField = 'Url'
    DataSource = DM1.dsPackages
    TabOrder = 5
    OnChange = dbeURLChange
    ExplicitWidth = 585
  end
  object dbeVersioRgExp: TDBEdit
    Left = 341
    Top = 69
    Width = 323
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    DataField = 'VersionRegExp'
    DataSource = DM1.dsPackages
    TabOrder = 3
    OnChange = dbeVersioRgExpChange
    ExplicitWidth = 321
  end
  object DBLookupComboBox1: TDBLookupComboBox
    Left = 77
    Top = 98
    Width = 356
    Height = 23
    DataField = 'Type_ID'
    DataSource = DM1.dsPackages
    KeyField = 'Type_ID'
    ListField = 'Name'
    ListSource = DM1.dsPackageTypes
    TabOrder = 4
    OnCloseUp = DBLookupComboBox1CloseUp
  end
  object dbcbGetIt: TDBCheckBox
    Left = 447
    Top = 104
    Width = 121
    Height = 17
    Caption = 'Available in GetIt'
    DataField = 'InGetIt'
    DataSource = DM1.dsPackages
    TabOrder = 7
  end
  object DBMemo1: TDBMemo
    Left = 77
    Top = 156
    Width = 587
    Height = 183
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataField = 'Description'
    DataSource = DM1.dsPackages
    ScrollBars = ssVertical
    TabOrder = 8
    OnChange = DBMemo1Change
    ExplicitWidth = 585
    ExplicitHeight = 179
  end
  object ActionList1: TActionList
    Left = 624
    Top = 8
    object actSave: TAction
      Caption = 'Save'
      OnExecute = actSaveExecute
    end
    object actCancel: TAction
      Caption = 'Cancel'
      OnExecute = actCancelExecute
    end
  end
end
