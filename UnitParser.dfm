object frmParse: TfrmParse
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Stop'
  ClientHeight = 145
  ClientWidth = 486
  Color = clBtnFace
  Constraints.MaxHeight = 180
  Constraints.MaxWidth = 500
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
    486
    145)
  TextHeight = 15
  object lblOverall: TLabel
    Left = 8
    Top = 57
    Width = 470
    Height = 15
    AutoSize = False
    Caption = 'Overall progress'
  end
  object lblCurrentTask: TLabel
    Left = 8
    Top = 13
    Width = 470
    Height = 15
    AutoSize = False
    Caption = 'Current Task progress'
  end
  object Panel1: TPanel
    Left = 0
    Top = 108
    Width = 486
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 104
    ExplicitWidth = 484
    DesignSize = (
      486
      37)
    object btnStop: TButton
      Left = 407
      Top = 8
      Width = 75
      Height = 25
      Action = frmMain.actParseCancel
      Anchors = [akRight, akBottom]
      TabOrder = 0
      ExplicitLeft = 405
    end
  end
  object pBarOverall: TProgressBar
    Left = 8
    Top = 78
    Width = 474
    Height = 17
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
    ExplicitWidth = 472
  end
  object pBarCurrentTask: TProgressBar
    Left = 8
    Top = 34
    Width = 474
    Height = 17
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 2
    ExplicitWidth = 472
  end
end
