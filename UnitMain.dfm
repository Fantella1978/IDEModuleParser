object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'IDE Module Parser'
  ClientHeight = 448
  ClientWidth = 630
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
    Top = 411
    Width = 630
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 404
    ExplicitWidth = 624
    DesignSize = (
      630
      37)
    object Button1: TButton
      Left = 408
      Top = 6
      Width = 135
      Height = 25
      Action = actOpenModuleFile
      Anchors = [akRight, akBottom]
      Default = True
      ModalResult = 1
      TabOrder = 0
      ExplicitLeft = 404
    end
    object Button2: TButton
      Left = 549
      Top = 6
      Width = 75
      Height = 25
      Action = actExit
      Anchors = [akRight, akBottom]
      Cancel = True
      ModalResult = 2
      TabOrder = 1
      ExplicitLeft = 543
    end
    object Button3: TButton
      Left = 195
      Top = 6
      Width = 75
      Height = 25
      Action = actParseModuleFile
      Anchors = [akRight, akBottom]
      TabOrder = 2
      ExplicitLeft = 191
    end
    object Button4: TButton
      Left = 276
      Top = 6
      Width = 126
      Height = 25
      Action = actOpenReportZipFile
      Anchors = [akRight, akBottom]
      Caption = 'Open Report in Zip'
      TabOrder = 3
      ExplicitLeft = 272
    end
  end
  object TabControl1: TTabControl
    Left = 0
    Top = 0
    Width = 630
    Height = 411
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
    Left = 456
    Top = 5
    object actExit: TAction
      Caption = 'Exit'
      Hint = 'Close the program'
      OnExecute = actExitExecute
    end
    object actOpenModuleFile: TAction
      Caption = 'Open Module File'
      Hint = 'Open Module file (ModuleList.txt)'
      OnExecute = actOpenModuleFileExecute
    end
    object actParseModuleFile: TAction
      Caption = 'Parse'
      Enabled = False
      Hint = 'Parse Module file'
      OnExecute = actParseModuleFileExecute
    end
    object actOpenReportZipFile: TAction
      Caption = 'Open Report Zip'
      Hint = 'Open Repot Zip file (QPInfo-XXXXXXXX-XXXX.zip)'
      OnExecute = actOpenReportZipFileExecute
    end
  end
  object OpenTextFileDialog1: TOpenTextFileDialog
    Left = 550
    Top = 5
  end
end
