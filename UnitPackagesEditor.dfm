object frmPackagesEditor: TfrmPackagesEditor
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Packages Editor'
  ClientHeight = 637
  ClientWidth = 953
  Color = clBtnFace
  Constraints.MinHeight = 400
  Constraints.MinWidth = 720
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  OnResize = FormResize
  DesignSize = (
    953
    637)
  TextHeight = 15
  object lblName: TLabel
    Left = 12
    Top = 17
    Width = 35
    Height = 15
    Caption = 'Name:'
  end
  object lblUrl: TLabel
    Left = 23
    Top = 74
    Width = 24
    Height = 15
    Caption = 'URL:'
  end
  object lblVersion: TLabel
    Left = 6
    Top = 47
    Width = 41
    Height = 15
    Caption = 'Version:'
  end
  object lblVersionRegExp: TLabel
    Left = 6
    Top = 102
    Width = 83
    Height = 15
    Caption = 'Version RegExp:'
  end
  object lblSurName: TLabel
    Left = 344
    Top = 17
    Width = 55
    Height = 15
    Caption = 'Sur Name:'
  end
  object Panel1: TPanel
    Left = 0
    Top = 600
    Width = 953
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 13
    ExplicitTop = 596
    ExplicitWidth = 951
    DesignSize = (
      953
      37)
    object ButtonOK: TButton
      Left = 868
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
      OnClick = ButtonOKClick
      ExplicitLeft = 866
    end
  end
  object dbgPackages: TDBGrid
    Left = 0
    Top = 161
    Width = 953
    Height = 439
    Align = alBottom
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = DM1.dsPackages
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnDrawColumnCell = dbgPackagesDrawColumnCell
    Columns = <
      item
        Expanded = False
        FieldName = 'Num'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'Name'
        Title.Caption = 'Package Name'
        Width = 250
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SubName'
        Width = 250
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Version'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Url'
        Title.Caption = 'URL'
        Width = 300
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VersionRegExp'
        Title.Caption = 'Version RegExp'
        Visible = True
      end>
  end
  object dbeName: TDBEdit
    Left = 53
    Top = 11
    Width = 284
    Height = 23
    DataField = 'Name'
    DataSource = DM1.dsPackages
    TabOrder = 1
    OnChange = dbeNameChange
  end
  object DBNavigator1: TDBNavigator
    Left = 394
    Top = 130
    Width = 470
    Height = 25
    DataSource = DM1.dsPackages
    Anchors = [akTop, akRight]
    TabOrder = 12
  end
  object btnAdd: TButton
    Left = 870
    Top = 8
    Width = 75
    Height = 25
    Action = actPackageAdd
    Anchors = [akTop, akRight]
    TabOrder = 7
    ExplicitLeft = 868
  end
  object btnDelete: TButton
    Left = 870
    Top = 68
    Width = 75
    Height = 25
    Action = actPackageDelete
    Anchors = [akTop, akRight]
    TabOrder = 9
    ExplicitLeft = 868
  end
  object dbeURL: TDBEdit
    Left = 53
    Top = 70
    Width = 814
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    DataField = 'Url'
    DataSource = DM1.dsPackages
    TabOrder = 5
    OnChange = dbeURLChange
    ExplicitWidth = 812
  end
  object dbeVersion: TDBEdit
    Left = 53
    Top = 41
    Width = 164
    Height = 23
    DataField = 'Version'
    DataSource = DM1.dsPackages
    TabOrder = 3
    OnChange = dbeVersionChange
  end
  object dbeVersioRgExp: TDBEdit
    Left = 95
    Top = 101
    Width = 772
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    DataField = 'VersionRegExp'
    DataSource = DM1.dsPackages
    TabOrder = 6
    OnChange = dbeVersioRgExpChange
    ExplicitWidth = 770
  end
  object Button2: TButton
    Left = 870
    Top = 38
    Width = 75
    Height = 25
    Action = actPackageEdit
    Anchors = [akTop, akRight]
    TabOrder = 8
    ExplicitLeft = 868
  end
  object Button3: TButton
    Left = 870
    Top = 98
    Width = 75
    Height = 25
    Action = actPackagesSave
    Anchors = [akTop, akRight]
    TabOrder = 10
    ExplicitLeft = 868
  end
  object Button4: TButton
    Left = 870
    Top = 129
    Width = 75
    Height = 25
    Action = actPackagesCancel
    Anchors = [akTop, akRight]
    TabOrder = 11
    ExplicitLeft = 868
  end
  object dbeSurName: TDBEdit
    Left = 405
    Top = 11
    Width = 459
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    DataField = 'SubName'
    DataSource = DM1.dsPackages
    TabOrder = 2
    OnChange = dbeSurNameChange
    ExplicitWidth = 457
  end
  object DBLookupComboBox1: TDBLookupComboBox
    Left = 405
    Top = 40
    Width = 292
    Height = 23
    DataField = 'Type'
    DataSource = DM1.dsPackages
    KeyField = 'ID'
    ListField = 'Name'
    ListSource = DM1.dsPackageTypes
    TabOrder = 4
  end
  object ActionList1: TActionList
    Left = 304
    Top = 128
    object actPackageAdd: TAction
      Caption = 'Add'
      OnExecute = actPackageAddExecute
    end
    object actPackageDelete: TAction
      Caption = 'Delete'
      OnExecute = actPackageDeleteExecute
    end
    object actPackageEdit: TAction
      Caption = 'Edit'
      OnExecute = actPackageEditExecute
    end
    object actPackagesSave: TAction
      Caption = 'Save'
      Enabled = False
      OnExecute = actPackagesSaveExecute
    end
    object actPackagesCancel: TAction
      Caption = 'Cancel'
      Enabled = False
      OnExecute = actPackagesCancelExecute
    end
  end
end
