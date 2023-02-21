object frmPackagesEditor: TfrmPackagesEditor
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Packages Editor'
  ClientHeight = 365
  ClientWidth = 706
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
    706
    365)
  TextHeight = 15
  object lblName: TLabel
    Left = 12
    Top = 19
    Width = 35
    Height = 15
    Caption = 'Name:'
  end
  object lblUrl: TLabel
    Left = 23
    Top = 73
    Width = 24
    Height = 15
    Caption = 'URL:'
  end
  object lblVersion: TLabel
    Left = 6
    Top = 46
    Width = 41
    Height = 15
    Caption = 'Version:'
  end
  object lblVersionRegExp: TLabel
    Left = 6
    Top = 101
    Width = 83
    Height = 15
    Caption = 'Version RegExp:'
  end
  object Panel1: TPanel
    Left = 0
    Top = 328
    Width = 706
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 324
    ExplicitWidth = 704
    DesignSize = (
      706
      37)
    object ButtonOK: TButton
      Left = 621
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
      OnClick = ButtonOKClick
      ExplicitLeft = 619
    end
  end
  object dbgPackages: TDBGrid
    Left = 0
    Top = 160
    Width = 706
    Height = 168
    Align = alBottom
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = DM1.dsPackages
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 1
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
    Width = 567
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    DataField = 'Name'
    DataSource = DM1.dsPackages
    TabOrder = 2
    OnChange = dbeNameChange
    ExplicitWidth = 565
  end
  object DBNavigator1: TDBNavigator
    Left = 8
    Top = 129
    Width = 240
    Height = 25
    DataSource = DM1.dsPackages
    TabOrder = 3
  end
  object btnAdd: TButton
    Left = 626
    Top = 8
    Width = 75
    Height = 25
    Action = actPackageAdd
    Anchors = [akTop, akRight]
    TabOrder = 4
    ExplicitLeft = 624
  end
  object btnDelete: TButton
    Left = 626
    Top = 68
    Width = 75
    Height = 25
    Action = actPackageDelete
    Anchors = [akTop, akRight]
    TabOrder = 5
    ExplicitLeft = 624
  end
  object dbeURL: TDBEdit
    Left = 53
    Top = 69
    Width = 567
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    DataField = 'Url'
    DataSource = DM1.dsPackages
    TabOrder = 6
    ExplicitWidth = 565
  end
  object dbeVersion: TDBEdit
    Left = 53
    Top = 40
    Width = 188
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    DataField = 'Version'
    DataSource = DM1.dsPackages
    TabOrder = 7
    OnChange = dbeVersionChange
    ExplicitWidth = 186
  end
  object DBEdit2: TDBEdit
    Left = 95
    Top = 100
    Width = 525
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    DataField = 'VersionRegExp'
    DataSource = DM1.dsPackages
    TabOrder = 8
    ExplicitWidth = 523
  end
  object Button2: TButton
    Left = 626
    Top = 39
    Width = 75
    Height = 25
    Action = actPackageEdit
    Anchors = [akTop, akRight]
    TabOrder = 9
    ExplicitLeft = 624
  end
  object Button3: TButton
    Left = 626
    Top = 97
    Width = 75
    Height = 25
    Action = actPackagesSave
    Anchors = [akTop, akRight]
    TabOrder = 10
    ExplicitLeft = 624
  end
  object Button4: TButton
    Left = 626
    Top = 128
    Width = 75
    Height = 25
    Action = actPackagesCancel
    Anchors = [akTop, akRight]
    TabOrder = 11
    ExplicitLeft = 624
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
