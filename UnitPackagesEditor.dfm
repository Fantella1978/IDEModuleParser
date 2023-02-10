object frmPackagesEditor: TfrmPackagesEditor
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Packages Edit'
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
    Top = 49
    Width = 24
    Height = 15
    Caption = 'URL:'
  end
  object Label1: TLabel
    Left = 0
    Top = 79
    Width = 47
    Height = 15
    Alignment = taRightJustify
    Caption = 'Package:'
  end
  object Panel1: TPanel
    Left = 0
    Top = 328
    Width = 706
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 404
    ExplicitWidth = 624
    DesignSize = (
      706
      37)
    object Button1: TButton
      Left = 623
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
      OnClick = Button1Click
      ExplicitLeft = 541
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 100
    Width = 706
    Height = 228
    Align = alBottom
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = DM1.dsModulesFromQuery
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'FileName'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PackageName'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Url'
        Width = 300
        Visible = True
      end>
  end
  object dbeName: TDBEdit
    Left = 53
    Top = 11
    Width = 569
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    DataField = 'Name'
    DataSource = DM1.dsLocalPackages
    TabOrder = 2
  end
  object DBNavigator1: TDBNavigator
    Left = 463
    Top = 70
    Width = 240
    Height = 25
    Anchors = [akTop, akRight]
    TabOrder = 3
    ExplicitLeft = 378
  end
  object btnAdd: TButton
    Left = 628
    Top = 8
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Add'
    TabOrder = 4
    ExplicitLeft = 543
  end
  object btnDelete: TButton
    Left = 628
    Top = 39
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Delete'
    TabOrder = 5
    ExplicitLeft = 543
  end
  object DBEdit1: TDBEdit
    Left = 53
    Top = 40
    Width = 569
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 6
  end
  object DBLookupComboBox1: TDBLookupComboBox
    Left = 53
    Top = 71
    Width = 404
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    DataField = 'PackageName'
    DataSource = DM1.dsModulesFromQuery
    KeyField = 'Name'
    ListField = 'Name'
    ListSource = DM1.dsPackages
    TabOrder = 7
  end
end
