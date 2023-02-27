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
  object Panel1: TPanel
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
      Left = 676
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
      OnClick = Button1Click
      ExplicitLeft = 674
    end
  end
  object dbgModules: TDBGrid
    Left = 0
    Top = 0
    Width = 766
    Height = 407
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
  object Panel2: TPanel
    Left = 0
    Top = 407
    Width = 766
    Height = 42
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitTop = 403
    ExplicitWidth = 764
    object DBNavigator1: TDBNavigator
      Left = 8
      Top = 8
      Width = 240
      Height = 25
      DataSource = DM1.dsModules
      TabOrder = 0
    end
  end
end
