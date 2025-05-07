object frmModulesEditor: TfrmModulesEditor
  Left = 0
  Top = 0
  Caption = 'Modules Editor'
  ClientHeight = 482
  ClientWidth = 869
  Color = clBtnFace
  Constraints.MinHeight = 480
  Constraints.MinWidth = 880
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  TextHeight = 15
  object pnlBottom: TPanel
    Left = 0
    Top = 445
    Width = 869
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      869
      37)
    object btnOK: TButton
      Left = 778
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
      OnClick = btnOKClick
    end
  end
  object dbgModules: TDBGrid
    Left = 0
    Top = 121
    Width = 869
    Height = 324
    Align = alClient
    DataSource = DM1.dsModules
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnDrawColumnCell = dbgModulesDrawColumnCell
    OnTitleClick = dbgModulesTitleClick
    Columns = <
      item
        Expanded = False
        FieldName = 'Module_ID'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FileName'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Version'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Package_FullName'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VersionRegExp'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FileNameRegExp'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PathRegExp'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Hash'
        Width = 200
        Visible = True
      end>
  end
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 869
    Height = 121
    Align = alTop
    TabOrder = 2
    DesignSize = (
      869
      121)
    object SpeedButton1: TSpeedButton
      Left = 646
      Top = 11
      Width = 207
      Height = 22
      Action = actCopyFileNameAsRegExp
      Anchors = [akTop, akRight]
      ParentShowHint = False
      ShowHint = True
      ExplicitLeft = 654
    end
    object GroupBox1: TGroupBox
      Left = 1
      Top = 1
      Width = 366
      Height = 119
      Align = alLeft
      Caption = 'Filter'
      TabOrder = 0
      ExplicitHeight = 71
      object Label1: TLabel
        Left = 7
        Top = 66
        Width = 44
        Height = 15
        Caption = 'Package'
      end
      object lbedFilterFileName: TLabeledEdit
        Left = 7
        Top = 37
        Width = 138
        Height = 23
        EditLabel.Width = 53
        EditLabel.Height = 15
        EditLabel.Caption = 'File Name'
        TabOrder = 0
        Text = ''
        OnChange = lbedFilterFileNameChange
      end
      object cbFilterPackages: TComboBox
        Left = 7
        Top = 87
        Width = 346
        Height = 23
        TabOrder = 1
        OnChange = cbFilterPackagesChange
      end
    end
    object DBNavigator1: TDBNavigator
      Left = 613
      Top = 87
      Width = 240
      Height = 25
      DataSource = DM1.dsModules
      Anchors = [akRight, akBottom]
      TabOrder = 1
      ExplicitTop = 39
    end
    object Button2: TButton
      Left = 373
      Top = 8
      Width = 114
      Height = 25
      Action = actFindDuplicates
      TabOrder = 2
    end
    object Button3: TButton
      Left = 373
      Top = 39
      Width = 114
      Height = 25
      Action = actFindDuplicatesNext
      TabOrder = 3
    end
    object Button4: TButton
      Left = 493
      Top = 8
      Width = 114
      Height = 25
      Action = actFindAndDeleteDuplicates
      TabOrder = 4
    end
  end
  object ActionList1: TActionList
    Left = 400
    Top = 184
    object actFindDuplicates: TAction
      Caption = 'Find Duplicates'
      OnExecute = actFindDuplicatesExecute
    end
    object actFindDuplicatesNext: TAction
      Caption = 'Find Next >>>'
      Visible = False
      OnExecute = actFindDuplicatesNextExecute
    end
    object actFindAndDeleteDuplicates: TAction
      Caption = 'Delete Duplicates'
      OnExecute = actFindAndDeleteDuplicatesExecute
    end
    object actCopyFileNameAsRegExp: TAction
      Caption = 'Copy FileName to FileNameRegExp'
      Hint = 'Copy FileName to FileNameRegExp [Ctrl+R]'
      ShortCut = 16466
      OnExecute = actCopyFileNameAsRegExpExecute
    end
  end
end
