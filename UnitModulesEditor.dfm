object frmModulesEditor: TfrmModulesEditor
  Left = 0
  Top = 0
  Caption = 'Modules Editor'
  ClientHeight = 486
  ClientWidth = 766
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  WindowState = wsMaximized
  TextHeight = 15
  object pnlBottom: TPanel
    Left = 0
    Top = 449
    Width = 766
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 445
    ExplicitWidth = 764
    DesignSize = (
      766
      37)
    object Button1: TButton
      Left = 685
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
    Width = 766
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
    Columns = <
      item
        Expanded = False
        FieldName = 'Num'
        Visible = False
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
        FieldName = 'PathRegExp'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VersionRegExp'
        Width = 200
        Visible = True
      end>
  end
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 766
    Height = 73
    Align = alTop
    TabOrder = 2
    object GroupBox1: TGroupBox
      Left = 1
      Top = 1
      Width = 136
      Height = 71
      Align = alLeft
      Caption = 'Filter'
      TabOrder = 0
      object lbedFilterFileName: TLabeledEdit
        Left = 7
        Top = 37
        Width = 122
        Height = 23
        EditLabel.Width = 53
        EditLabel.Height = 15
        EditLabel.Caption = 'File Name'
        TabOrder = 0
        Text = ''
        OnChange = lbedFilterFileNameChange
      end
    end
    object DBNavigator1: TDBNavigator
      Left = 520
      Top = 40
      Width = 240
      Height = 25
      DataSource = DM1.dsModules
      TabOrder = 1
    end
  end
end
