object frmAddModules: TfrmAddModules
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Add Modules to Known'
  ClientHeight = 436
  ClientWidth = 808
  Color = clBtnFace
  Constraints.MinHeight = 330
  Constraints.MinWidth = 450
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 399
    Width = 808
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      808
      37)
    object btnAdd: TButton
      Left = 624
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Add'
      Default = True
      ModalResult = 1
      TabOrder = 0
      OnClick = btnAddClick
    end
    object btnCancel: TButton
      Left = 711
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
      OnClick = btnCancelClick
    end
    object ProgressBarAddModules: TProgressBar
      Left = 6
      Top = 10
      Width = 620
      Height = 16
      TabOrder = 2
      Visible = False
    end
  end
  object GroupBox3: TGroupBox
    Left = 0
    Top = 129
    Width = 808
    Height = 270
    Align = alClient
    Caption = 'Modules'
    Constraints.MinHeight = 100
    TabOrder = 1
    object lbxModules: TListBox
      AlignWithMargins = True
      Left = 5
      Top = 20
      Width = 798
      Height = 245
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Monoid'
      Font.Pitch = fpFixed
      Font.Style = []
      ItemHeight = 17
      ParentFont = False
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 808
    Height = 129
    Align = alTop
    Anchors = []
    TabOrder = 2
    object GroupBox2: TGroupBox
      Left = 1
      Top = 1
      Width = 136
      Height = 127
      Align = alLeft
      Caption = 'Copy to DB'
      TabOrder = 0
      object clbFields: TCheckListBox
        AlignWithMargins = True
        Left = 5
        Top = 20
        Width = 126
        Height = 102
        Align = alClient
        Color = clBtnFace
        ItemHeight = 15
        Items.Strings = (
          'File Name'
          'Version'
          'Hash')
        TabOrder = 0
        OnClickCheck = clbFieldsClickCheck
      end
    end
    object GroupBox1: TGroupBox
      Left = 137
      Top = 1
      Width = 670
      Height = 127
      Align = alClient
      Caption = 'Package'
      ParentBackground = False
      TabOrder = 1
      DesignSize = (
        670
        127)
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
        Action = actPackagesEditor
        TabOrder = 0
      end
      object cbPackages: TComboBox
        Left = 63
        Top = 24
        Width = 590
        Height = 23
        AutoDropDown = True
        AutoCloseUp = True
        Anchors = [akLeft, akTop, akRight]
        DropDownCount = 10
        ExtendedUI = True
        TabOrder = 1
        Text = 'cbPackages'
        OnCloseUp = cbPackagesCloseUp
      end
    end
  end
  object ActionList1: TActionList
    Left = 40
    Top = 328
    object actPackagesEditor: TAction
      Caption = 'Packages Editor'
      OnExecute = actPackagesEditorExecute
    end
  end
end
