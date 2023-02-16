object frmPackagesEditor: TfrmPackagesEditor
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Packages Edit'
  ClientHeight = 414
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
  OnResize = FormResize
  DesignSize = (
    706
    414)
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
  object lblVersion: TLabel
    Left = 6
    Top = 75
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
    Top = 377
    Width = 706
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      706
      37)
    object Button1: TButton
      Left = 621
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
      OnClick = Button1Click
      ExplicitLeft = 619
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 160
    Width = 706
    Height = 217
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
    OnDrawColumnCell = DBGrid1DrawColumnCell
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
    ExplicitWidth = 565
  end
  object DBNavigator1: TDBNavigator
    Left = 1
    Top = 129
    Width = 240
    Height = 25
    DataSource = DM1.dsPackages
    Anchors = [akTop, akRight]
    TabOrder = 3
    ExplicitLeft = -1
  end
  object btnAdd: TButton
    Left = 626
    Top = 8
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Add'
    TabOrder = 4
    ExplicitLeft = 624
  end
  object btnDelete: TButton
    Left = 626
    Top = 39
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Delete'
    TabOrder = 5
    ExplicitLeft = 624
  end
  object dbeURL: TDBEdit
    Left = 53
    Top = 40
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
    Top = 69
    Width = 188
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    DataField = 'Version'
    DataSource = DM1.dsPackages
    TabOrder = 7
    ExplicitWidth = 186
  end
  object DBEdit2: TDBEdit
    Left = 95
    Top = 98
    Width = 525
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    DataField = 'VersionRegExp'
    DataSource = DM1.dsPackages
    TabOrder = 8
    ExplicitWidth = 523
  end
end
