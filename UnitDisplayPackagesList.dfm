object frmPackagesList: TfrmPackagesList
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Packages list'
  ClientHeight = 445
  ClientWidth = 989
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 408
    Width = 989
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 404
    ExplicitWidth = 987
    DesignSize = (
      989
      37)
    object Button1: TButton
      Left = 897
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
      ExplicitLeft = 895
    end
  end
  object ControlList1: TControlList
    Left = 0
    Top = 0
    Width = 989
    Height = 408
    Align = alClient
    ItemHeight = 65
    ItemMargins.Left = 0
    ItemMargins.Top = 0
    ItemMargins.Right = 0
    ItemMargins.Bottom = 0
    ItemSelectionOptions.HotColorAlpha = 50
    ItemSelectionOptions.SelectedColorAlpha = 70
    ItemSelectionOptions.FocusedColorAlpha = 80
    ItemSelectionOptions.UseFontColorForLabels = True
    ParentColor = False
    TabOrder = 1
    OnBeforeDrawItem = ControlList1BeforeDrawItem
    OnClick = ControlList1Click
    ExplicitTop = 8
    object lblName: TLabel
      Left = 10
      Top = 6
      Width = 35
      Height = 16
      Caption = 'Name'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBtnText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object lblURL: TLabel
      Left = 10
      Top = 23
      Width = 34
      Height = 15
      Caption = 'lblURL'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHighlight
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      StyleElements = [seClient, seBorder]
    end
    object clbURL: TControlListButton
      AlignWithMargins = True
      Left = 906
      Top = 20
      Width = 52
      Height = 25
      Margins.Left = 5
      Margins.Top = 20
      Margins.Right = 27
      Margins.Bottom = 20
      Align = alRight
      Caption = 'Open'
      LinkHotColor = clHighlight
      ExplicitLeft = 908
      ExplicitTop = 23
    end
    object lblDescr: TLabel
      AlignWithMargins = True
      Left = 10
      Top = 42
      Width = 890
      Height = 15
      Anchors = [akLeft, akTop, akRight, akBottom]
      AutoSize = False
      Caption = 'lblDescr'
      Constraints.MaxHeight = 15
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowFrame
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      WordWrap = True
      StyleElements = [seClient, seBorder]
    end
    object lblGetIt: TLabel
      Left = 50
      Top = 5
      Width = 107
      Height = 17
      Caption = 'Available in GetIt'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clPurple
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      StyleElements = [seClient, seBorder]
    end
  end
end
