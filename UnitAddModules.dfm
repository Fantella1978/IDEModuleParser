object frmAddModules: TfrmAddModules
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Add Modules to Known'
  ClientHeight = 391
  ClientWidth = 818
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
    Top = 354
    Width = 818
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 350
    ExplicitWidth = 816
    DesignSize = (
      818
      37)
    object btnAdd: TButton
      Left = 651
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Add'
      Default = True
      ModalResult = 1
      TabOrder = 0
      OnClick = btnAddClick
      ExplicitLeft = 649
    end
    object btnCancel: TButton
      Left = 734
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
      OnClick = btnCancelClick
      ExplicitLeft = 732
    end
    object ProgressBarAddModules: TProgressBar
      Left = 6
      Top = 10
      Width = 634
      Height = 16
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 2
      Visible = False
      ExplicitWidth = 632
    end
  end
  object GroupBox3: TGroupBox
    Left = 0
    Top = 137
    Width = 818
    Height = 217
    Align = alClient
    Caption = 'Modules'
    Constraints.MinHeight = 100
    TabOrder = 1
    ExplicitWidth = 816
    ExplicitHeight = 213
    object lbxModules: TListBox
      AlignWithMargins = True
      Left = 5
      Top = 20
      Width = 808
      Height = 192
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
      ExplicitWidth = 806
      ExplicitHeight = 188
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 818
    Height = 137
    Align = alTop
    Anchors = []
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitWidth = 816
    object Panel3: TPanel
      Left = 136
      Top = 0
      Width = 682
      Height = 137
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitWidth = 680
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 682
        Height = 63
        Align = alTop
        Caption = 'Package'
        ParentBackground = False
        TabOrder = 0
        ExplicitWidth = 680
        DesignSize = (
          682
          63)
        object Label1: TLabel
          Left = 10
          Top = 27
          Width = 47
          Height = 15
          Caption = 'Package:'
        end
        object Button5: TButton
          Left = 556
          Top = 23
          Width = 114
          Height = 25
          Action = actPackagesEditor
          Anchors = [akTop, akRight]
          TabOrder = 0
          ExplicitLeft = 554
        end
        object cbPackages: TComboBox
          Left = 63
          Top = 24
          Width = 487
          Height = 23
          AutoDropDown = True
          AutoCloseUp = True
          Style = csDropDownList
          Anchors = [akLeft, akTop, akRight]
          DropDownCount = 10
          ExtendedUI = True
          TabOrder = 1
          OnCloseUp = cbPackagesCloseUp
          ExplicitWidth = 485
        end
      end
      object GroupBox4: TGroupBox
        Left = 0
        Top = 63
        Width = 682
        Height = 74
        Align = alClient
        Caption = 'Options'
        TabOrder = 1
        ExplicitLeft = 1
        ExplicitTop = 69
        DesignSize = (
          682
          74)
        object CheckBox1: TCheckBox
          Left = 10
          Top = 24
          Width = 410
          Height = 17
          Anchors = [akLeft, akTop, akRight]
          Caption = 
            'Automatically replace existing ones with the same File Name && V' +
            'ersion'
          Checked = True
          State = cbChecked
          TabOrder = 0
          ExplicitWidth = 408
        end
        object cbOptionsFileNameRegExp: TCheckBox
          Left = 10
          Top = 47
          Width = 410
          Height = 17
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Add File Name also as a File Name RegExp'
          TabOrder = 1
          ExplicitWidth = 408
        end
      end
    end
    object GroupBox2: TGroupBox
      Left = 0
      Top = 0
      Width = 136
      Height = 137
      Align = alLeft
      Caption = 'Copy to DB'
      TabOrder = 0
      object clbFields: TCheckListBox
        AlignWithMargins = True
        Left = 5
        Top = 20
        Width = 126
        Height = 112
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
  end
  object ActionList1: TActionList
    Left = 32
    Top = 296
    object actPackagesEditor: TAction
      Caption = 'Packages Editor'
      OnExecute = actPackagesEditorExecute
    end
  end
end
