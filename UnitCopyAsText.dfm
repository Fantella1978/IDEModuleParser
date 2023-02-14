object frmCopyAsText: TfrmCopyAsText
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Copy as Text'
  ClientHeight = 365
  ClientWidth = 766
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
    Height = 328
    ExplicitLeft = 176
    ExplicitTop = 120
    ExplicitHeight = 100
  end
  object Panel1: TPanel
    Left = 0
    Top = 328
    Width = 766
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 334
    ExplicitWidth = 784
    DesignSize = (
      766
      37)
    object Button1: TButton
      Left = 598
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
      OnClick = Button1Click
      ExplicitLeft = 616
    end
    object Button2: TButton
      Left = 685
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
      OnClick = Button2Click
      ExplicitLeft = 703
    end
  end
  object GroupBox2: TGroupBox
    AlignWithMargins = True
    Left = 206
    Top = 0
    Width = 560
    Height = 328
    Margins.Left = 5
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alClient
    Caption = 'Preview'
    Constraints.MinWidth = 250
    TabOrder = 1
    ExplicitLeft = 310
    ExplicitWidth = 474
    ExplicitHeight = 334
    object Memo1: TMemo
      AlignWithMargins = True
      Left = 5
      Top = 20
      Width = 550
      Height = 303
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
    Height = 328
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 5
    Margins.Bottom = 0
    Align = alLeft
    Caption = 'Columns'
    Constraints.MinWidth = 150
    TabOrder = 2
    ExplicitHeight = 338
    object CheckListBox1: TCheckListBox
      AlignWithMargins = True
      Left = 5
      Top = 20
      Width = 183
      Height = 303
      Align = alClient
      Color = clBtnFace
      ItemHeight = 15
      Items.Strings = (
        'sd'
        'sd'
        'sdg'
        'sdg'
        'sdg'
        'sdgsdgfs')
      TabOrder = 0
      OnClickCheck = CheckListBox1ClickCheck
      ExplicitWidth = 287
      ExplicitHeight = 309
    end
  end
end
