object frmParse: TfrmParse
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Parsing'
  ClientHeight = 76
  ClientWidth = 522
  Color = clBtnFace
  DefaultMonitor = dmMainForm
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  DesignSize = (
    522
    76)
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 39
    Width = 522
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 35
    ExplicitWidth = 520
    object Button1: TButton
      Left = 439
      Top = 8
      Width = 75
      Height = 25
      Action = Form1.actParseCancel
      TabOrder = 0
    end
  end
  object ProgressBar1: TProgressBar
    Left = 8
    Top = 8
    Width = 506
    Height = 17
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
    ExplicitWidth = 504
  end
end
