object frmEnableAdminMode: TfrmEnableAdminMode
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Enable Admin Mode'
  ClientHeight = 116
  ClientWidth = 261
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnShow = FormShow
  TextHeight = 15
  object lblRandomeCode: TLabel
    Left = 144
    Top = 16
    Width = 40
    Height = 20
    Caption = 'XXXX'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 42
    Top = 47
    Width = 96
    Height = 15
    Caption = 'Enter access code:'
  end
  object Label2: TLabel
    Left = 70
    Top = 20
    Width = 68
    Height = 16
    Caption = 'Access code:'
  end
  object Panel1: TPanel
    Left = 0
    Top = 79
    Width = 261
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 408
    ExplicitWidth = 626
    DesignSize = (
      261
      37)
    object btnOk: TButton
      Left = 93
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
      OnClick = btnOkClick
      ExplicitLeft = 458
    end
    object Button2: TButton
      Left = 180
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
      OnClick = Button2Click
      ExplicitLeft = 545
    end
  end
  object MaskEdit1: TMaskEdit
    Left = 144
    Top = 42
    Width = 64
    Height = 23
    EditMask = '0000'
    MaxLength = 4
    TabOrder = 0
    Text = '    '
    OnChange = MaskEdit1Change
  end
end
