object frmProgress: TfrmProgress
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'frmProgress'
  ClientHeight = 114
  ClientWidth = 542
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  TextHeight = 15
  object lblProgress: TLabel
    Left = 8
    Top = 19
    Width = 58
    Height = 15
    Caption = 'lblProgress'
  end
  object Panel1: TPanel
    Left = 0
    Top = 77
    Width = 542
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      542
      37)
    object btnCancel: TButton
      Left = 461
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 0
      OnClick = btnCancelClick
    end
  end
  object pbProgress: TProgressBar
    Left = 8
    Top = 40
    Width = 526
    Height = 17
    TabOrder = 1
  end
end
