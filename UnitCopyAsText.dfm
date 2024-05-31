object frmCopyAsText: TfrmCopyAsText
  Left = 0
  Top = 0
  BorderIcons = []
  Caption = 'Copy as Text'
  ClientHeight = 417
  ClientWidth = 900
  Color = clBtnFace
  Constraints.MinHeight = 400
  Constraints.MinWidth = 780
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnShow = FormShow
  TextHeight = 15
  object Splitter1: TSplitter
    Left = 198
    Top = 0
    Height = 380
    ExplicitLeft = 176
    ExplicitTop = 120
    ExplicitHeight = 100
  end
  object Panel1: TPanel
    Left = 0
    Top = 380
    Width = 900
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      900
      37)
    object btnOk: TButton
      Left = 686
      Top = 6
      Width = 117
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Copy to clipboard'
      Default = True
      ModalResult = 1
      TabOrder = 0
      OnClick = btnOkClick
    end
    object btnCancel: TButton
      Left = 815
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
  end
  object GroupBox2: TGroupBox
    AlignWithMargins = True
    Left = 206
    Top = 0
    Width = 694
    Height = 380
    Margins.Left = 5
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alClient
    Caption = 'Preview'
    Constraints.MinWidth = 250
    TabOrder = 1
    object Memo1: TMemo
      AlignWithMargins = True
      Left = 5
      Top = 20
      Width = 684
      Height = 355
      TabStop = False
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Monoid'
      Font.Style = []
      Lines.Strings = (
        'Memo1')
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 0
    end
  end
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 0
    Top = 0
    Width = 193
    Height = 380
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 5
    Margins.Bottom = 0
    Align = alLeft
    Caption = 'Columns'
    Constraints.MinWidth = 150
    TabOrder = 2
    object CheckListBox1: TCheckListBox
      AlignWithMargins = True
      Left = 5
      Top = 20
      Width = 183
      Height = 355
      Align = alClient
      Color = clBtnFace
      ItemHeight = 15
      Items.Strings = (
        'Item 1'
        'Item 2'
        'Item 3'
        'Item 4'
        'Item 5'
        'Item 6'
        'Item 7')
      TabOrder = 0
      OnClickCheck = CheckListBox1ClickCheck
    end
  end
end
