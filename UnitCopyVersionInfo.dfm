object frmCopyVersionInfo: TfrmCopyVersionInfo
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Copy modules information from RS Version Information'
  ClientHeight = 478
  ClientWidth = 644
  Color = clBtnFace
  Constraints.MinHeight = 400
  Constraints.MinWidth = 640
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnShow = FormShow
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 441
    Width = 644
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 437
    ExplicitWidth = 642
    DesignSize = (
      644
      37)
    object Button1: TButton
      Left = 474
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
      ExplicitLeft = 472
    end
    object Button2: TButton
      Left = 561
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
      ExplicitLeft = 559
    end
  end
  object memVersionInformation: TMemo
    Left = 0
    Top = 41
    Width = 644
    Height = 400
    Align = alClient
    Lines.Strings = (
      'memVersionInformation')
    ScrollBars = ssBoth
    TabOrder = 1
    OnChange = memVersionInformationChange
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 644
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitWidth = 642
    DesignSize = (
      644
      41)
    object Label1: TLabel
      Left = 8
      Top = 13
      Width = 603
      Height = 15
      Anchors = [akLeft, akTop, akRight]
      Caption = 
        'Paste text Version Information from Help > About Embarcadero'#174' RA' +
        'D Studio > Version Info... and press OK button'
      ExplicitWidth = 605
    end
  end
end
