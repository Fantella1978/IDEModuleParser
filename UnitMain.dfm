object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'IDE Module Parser'
  ClientHeight = 445
  ClientWidth = 626
  Color = clBtnFace
  Constraints.MinHeight = 480
  Constraints.MinWidth = 640
  DefaultMonitor = dmDesktop
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesktopCenter
  OnCreate = FormCreate
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 408
    Width = 626
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 404
    ExplicitWidth = 624
    DesignSize = (
      626
      37)
    object Button1: TButton
      Left = 398
      Top = 6
      Width = 135
      Height = 25
      Action = actOpenModuleFile
      Anchors = [akTop, akRight]
      Default = True
      ModalResult = 1
      TabOrder = 0
      ExplicitLeft = 396
    end
    object Button2: TButton
      Left = 545
      Top = 6
      Width = 75
      Height = 25
      Action = actExit
      Anchors = [akTop, akRight]
      Cancel = True
      ModalResult = 2
      TabOrder = 1
      ExplicitLeft = 543
    end
    object Button3: TButton
      Left = 319
      Top = 6
      Width = 75
      Height = 25
      Action = actParseModuleFile
      TabOrder = 2
    end
  end
  object TabControl1: TTabControl
    Left = 0
    Top = 0
    Width = 626
    Height = 408
    Align = alClient
    TabOrder = 1
    Tabs.Strings = (
      'Module File'
      'Modules List'
      '3rd-Party Modules'
      'System Modules')
    TabIndex = 0
    ExplicitWidth = 624
    ExplicitHeight = 404
  end
  object ActionList1: TActionList
    Left = 32
    Top = 389
    object actExit: TAction
      Caption = 'Exit'
      OnExecute = actExitExecute
    end
    object actOpenModuleFile: TAction
      Caption = 'Open Module File'
      OnExecute = actOpenModuleFileExecute
    end
    object actParseModuleFile: TAction
      Caption = 'Parse'
      Enabled = False
    end
  end
  object OpenTextFileDialog1: TOpenTextFileDialog
    Left = 126
    Top = 389
  end
end
