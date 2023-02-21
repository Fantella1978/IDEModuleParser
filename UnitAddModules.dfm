object frmAddModules: TfrmAddModules
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Add Modules to Known'
  ClientHeight = 347
  ClientWidth = 630
  Color = clBtnFace
  Constraints.MinHeight = 330
  Constraints.MinWidth = 450
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnShow = FormShow
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 310
    Width = 630
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 404
    ExplicitWidth = 624
    DesignSize = (
      630
      37)
    object btnOK: TButton
      Left = 460
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
      OnClick = btnOKClick
      ExplicitLeft = 454
    end
    object btnCancel: TButton
      Left = 547
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
      OnClick = btnCancelClick
      ExplicitLeft = 541
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 630
    Height = 89
    Align = alTop
    Caption = 'Package'
    TabOrder = 1
    ExplicitWidth = 626
    DesignSize = (
      630
      89)
    object Label1: TLabel
      Left = 10
      Top = 27
      Width = 47
      Height = 15
      Caption = 'Package:'
    end
    object Button5: TButton
      Left = 63
      Top = 53
      Width = 175
      Height = 25
      Action = frmMain.actPackagesEditor
      TabOrder = 0
    end
    object ComboBox1: TComboBox
      Left = 63
      Top = 24
      Width = 564
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
      Text = 'ComboBox1'
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 89
    Width = 185
    Height = 221
    Align = alLeft
    Caption = 'Copy to DB'
    TabOrder = 2
    ExplicitLeft = 40
    ExplicitTop = 152
    ExplicitHeight = 105
    object CheckListBox1: TCheckListBox
      AlignWithMargins = True
      Left = 5
      Top = 20
      Width = 175
      Height = 196
      Align = alClient
      Color = clBtnFace
      Items.Strings = (
        'Item 1'
        'Item 2'
        'Item 3'
        'Item 4'
        'Item 5'
        'Item 6'
        'Item 7')
      TabOrder = 0
      ExplicitWidth = 183
      ExplicitHeight = 355
    end
  end
  object GroupBox3: TGroupBox
    Left = 185
    Top = 89
    Width = 445
    Height = 221
    Align = alClient
    Caption = 'Modules'
    TabOrder = 3
    ExplicitLeft = 224
    ExplicitTop = 109
    ExplicitWidth = 185
    ExplicitHeight = 105
    object ListBox1: TListBox
      AlignWithMargins = True
      Left = 5
      Top = 20
      Width = 435
      Height = 196
      Align = alClient
      ItemHeight = 15
      TabOrder = 0
      ExplicitLeft = 184
      ExplicitTop = 72
      ExplicitWidth = 121
      ExplicitHeight = 97
    end
  end
end
