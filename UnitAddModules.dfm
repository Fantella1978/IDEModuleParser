object frmAddModules: TfrmAddModules
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Add Modules to Known'
  ClientHeight = 397
  ClientWidth = 821
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
    Top = 360
    Width = 821
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 356
    ExplicitWidth = 819
    DesignSize = (
      821
      37)
    object btnAdd: TButton
      Left = 654
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Add'
      Default = True
      ModalResult = 1
      TabOrder = 0
      OnClick = btnAddClick
      ExplicitLeft = 652
    end
    object btnCancel: TButton
      Left = 737
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
      OnClick = btnCancelClick
      ExplicitLeft = 735
    end
    object ProgressBarAddModules: TProgressBar
      Left = 6
      Top = 10
      Width = 637
      Height = 16
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 2
      Visible = False
      ExplicitWidth = 635
    end
  end
  object GroupBox3: TGroupBox
    Left = 0
    Top = 97
    Width = 821
    Height = 263
    Align = alClient
    Caption = 'Modules'
    Constraints.MinHeight = 100
    TabOrder = 1
    ExplicitWidth = 819
    ExplicitHeight = 259
    object lbxModules: TListBox
      AlignWithMargins = True
      Left = 5
      Top = 20
      Width = 811
      Height = 238
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
      ExplicitWidth = 809
      ExplicitHeight = 234
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 821
    Height = 97
    Align = alTop
    Anchors = []
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitWidth = 819
    object GroupBox2: TGroupBox
      Left = 0
      Top = 0
      Width = 136
      Height = 97
      Align = alLeft
      Caption = 'Copy to DB'
      TabOrder = 0
      object clbFields: TCheckListBox
        AlignWithMargins = True
        Left = 5
        Top = 20
        Width = 126
        Height = 72
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
      Left = 136
      Top = 0
      Width = 685
      Height = 97
      Align = alClient
      Caption = 'Package'
      ParentBackground = False
      TabOrder = 1
      ExplicitWidth = 683
      DesignSize = (
        685
        97)
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
        Width = 605
        Height = 23
        AutoDropDown = True
        AutoCloseUp = True
        Anchors = [akLeft, akTop, akRight]
        DropDownCount = 10
        ExtendedUI = True
        TabOrder = 1
        Text = 'cbPackages'
        OnCloseUp = cbPackagesCloseUp
        ExplicitWidth = 603
      end
      object CheckBox1: TCheckBox
        Left = 255
        Top = 56
        Width = 413
        Height = 17
        Anchors = [akLeft, akTop, akRight]
        Caption = 
          'Automatically replace existing ones with the same File Name && V' +
          'ersion'
        Checked = True
        State = cbChecked
        TabOrder = 2
        ExplicitWidth = 411
      end
    end
  end
  object ActionList1: TActionList
    Left = 160
    Top = 80
    object actPackagesEditor: TAction
      Caption = 'Packages Editor'
      OnExecute = actPackagesEditorExecute
    end
  end
end
