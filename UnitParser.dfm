object frmParse: TfrmParse
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Parsing'
  ClientHeight = 141
  ClientWidth = 532
  Color = clBtnFace
  Constraints.MaxHeight = 180
  Constraints.MaxWidth = 550
  Constraints.MinHeight = 180
  Constraints.MinWidth = 500
  DefaultMonitor = dmMainForm
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  DesignSize = (
    532
    141)
  TextHeight = 15
  object lblOverall: TLabel
    Left = 7
    Top = 57
    Width = 520
    Height = 15
    AutoSize = False
    Caption = 'Overall progress'
  end
  object lblCurrentTask: TLabel
    Left = 7
    Top = 13
    Width = 520
    Height = 15
    AutoSize = False
    Caption = 'Current Task progress'
  end
  object Panel1: TPanel
    Left = 0
    Top = 104
    Width = 532
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 530
    DesignSize = (
      532
      37)
    object btnStop: TButton
      Left = 452
      Top = 6
      Width = 75
      Height = 25
      Action = frmMain.actParseCancel
      Anchors = [akRight, akBottom]
      TabOrder = 0
      ExplicitLeft = 450
    end
  end
  object pBarOverall: TProgressBar
    Left = 7
    Top = 78
    Width = 520
    Height = 17
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
    ExplicitWidth = 518
  end
  object pBarCurrentTask: TProgressBar
    Left = 7
    Top = 34
    Width = 520
    Height = 17
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 2
    ExplicitWidth = 518
  end
end
