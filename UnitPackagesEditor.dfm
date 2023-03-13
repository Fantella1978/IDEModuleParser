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
  object Panel1: TPanel
    Left = 0
    Top = 600
    Width = 953
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 5
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
    Top = 69
    Width = 953
    Height = 531
    Align = alBottom
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = DM1.dsPackages
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    PopupMenu = ppmPackagesEditor
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnDrawColumnCell = dbgPackagesDrawColumnCell
    OnDblClick = dbgPackagesDblClick
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
  object DBNavigator1: TDBNavigator
    Left = 271
    Top = 8
    Width = 420
    Height = 25
    DataSource = DM1.dsPackages
    VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbEdit, nbRefresh]
    Anchors = [akTop, akRight]
    TabOrder = 4
    OnClick = DBNavigator1Click
    ExplicitLeft = 269
  end
  object btnAdd: TButton
    Left = 706
    Top = 8
    Width = 75
    Height = 25
    Action = actPackageAdd
    Anchors = [akTop, akRight]
    TabOrder = 1
    ExplicitLeft = 704
  end
  object btnDelete: TButton
    Left = 868
    Top = 8
    Width = 75
    Height = 25
    Action = actPackageDelete
    Anchors = [akTop, akRight]
    TabOrder = 3
    ExplicitLeft = 866
  end
  object Button2: TButton
    Left = 787
    Top = 8
    Width = 75
    Height = 25
    Action = actPackageEdit
    Anchors = [akTop, akRight]
    TabOrder = 2
    ExplicitLeft = 785
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 265
    Height = 69
    Align = alLeft
    Caption = 'Filter'
    TabOrder = 6
    object lbedFilterFileName: TLabeledEdit
      Left = 7
      Top = 37
      Width = 251
      Height = 23
      EditLabel.Width = 53
      EditLabel.Height = 15
      EditLabel.Caption = 'File Name'
      TabOrder = 0
      Text = ''
      OnChange = lbedFilterFileNameChange
    end
  end
  object ActionList1: TActionList
    Left = 656
    Top = 56
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
  end
  object ppmPackagesEditor: TPopupMenu
    Left = 560
    Top = 56
    object Add1: TMenuItem
      Action = actPackageAdd
      Caption = 'Add new package'
    end
    object Edit1: TMenuItem
      Action = actPackageEdit
      Caption = 'Edit package'
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Delete1: TMenuItem
      Action = actPackageDelete
      Caption = 'Delete package'
    end
  end
end
