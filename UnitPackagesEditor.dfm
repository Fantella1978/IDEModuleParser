object frmPackagesEditor: TfrmPackagesEditor
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Packages Edit'
  ClientHeight = 445
  ClientWidth = 626
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  TextHeight = 15
  object lblName: TLabel
    Left = 2
    Top = 19
    Width = 35
    Height = 15
    Caption = 'Name:'
  end
  object lblUrl: TLabel
    Left = 13
    Top = 46
    Width = 24
    Height = 15
    Caption = 'URL:'
  end
  object Panel1: TPanel
    Left = 0
    Top = 408
    Width = 626
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 404
    DesignSize = (
      626
      37)
    object Button1: TButton
      Left = 543
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
  object DBGrid1: TDBGrid
    Left = 0
    Top = 100
    Width = 626
    Height = 308
    Align = alBottom
    DataSource = DM1.dsPackages
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Num'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'Name'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Url'
        Visible = True
      end>
  end
  object dbeName: TDBEdit
    Left = 43
    Top = 11
    Width = 494
    Height = 23
    DataField = 'Name'
    DataSource = DM1.dsPackages
    TabOrder = 2
  end
  object DBNavigator1: TDBNavigator
    Left = 378
    Top = 70
    Width = 240
    Height = 25
    TabOrder = 3
  end
  object btnAdd: TButton
    Left = 543
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Add'
    TabOrder = 4
  end
  object btnDelete: TButton
    Left = 543
    Top = 39
    Width = 75
    Height = 25
    Caption = 'Delete'
    TabOrder = 5
  end
  object DBEdit1: TDBEdit
    Left = 43
    Top = 40
    Width = 494
    Height = 23
    TabOrder = 6
  end
end
