object frmModulesEditor: TfrmModulesEditor
  Left = 0
  Top = 0
  Caption = 'Modules Editor'
  ClientHeight = 486
  ClientWidth = 871
  Color = clBtnFace
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
    Top = 449
    Width = 871
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 445
    ExplicitWidth = 869
    DesignSize = (
      871
      37)
    object Button1: TButton
      Left = 784
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  object dbgModules: TDBGrid
    Left = 0
    Top = 73
    Width = 871
    Height = 376
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
        FieldName = 'Num'
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
        FieldName = 'Package'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'Hash'
        Width = 200
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
        FieldName = 'PackageID'
        Visible = True
      end>
  end
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 871
    Height = 73
    Align = alTop
    TabOrder = 2
    ExplicitWidth = 869
    DesignSize = (
      871
      73)
    object SpeedButton1: TSpeedButton
      Left = 652
      Top = 8
      Width = 207
      Height = 22
      Action = actCopyFileNameAsRegExp
      Anchors = [akTop, akRight]
    end
    object GroupBox1: TGroupBox
      Left = 1
      Top = 1
      Width = 366
      Height = 71
      Align = alLeft
      Caption = 'Filter'
      TabOrder = 0
      object Label1: TLabel
        Left = 151
        Top = 19
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
        Left = 151
        Top = 37
        Width = 202
        Height = 23
        TabOrder = 1
        OnChange = cbFilterPackagesChange
      end
    end
    object DBNavigator1: TDBNavigator
      Left = 619
      Top = 36
      Width = 240
      Height = 25
      DataSource = DM1.dsModules
      Anchors = [akRight, akBottom]
      TabOrder = 1
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
      ShortCut = 16466
      OnExecute = actCopyFileNameAsRegExpExecute
    end
  end
end
