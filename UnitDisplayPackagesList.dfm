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
    ItemHeight = 50
    ItemMargins.Left = 0
    ItemMargins.Top = 0
    ItemMargins.Right = 0
    ItemMargins.Bottom = 0
    ItemSelectionOptions.HotColorAlpha = 50
    ItemSelectionOptions.SelectedColorAlpha = 70
    ItemSelectionOptions.FocusedColorAlpha = 80
    ParentColor = False
    TabOrder = 1
    OnBeforeDrawItem = ControlList1BeforeDrawItem
    OnClick = ControlList1Click
    ExplicitWidth = 987
    ExplicitHeight = 404
    object lblTitle: TLabel
      Left = 10
      Top = 6
      Width = 25
      Height = 13
      Caption = 'Title'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label1: TLabel
      Left = 10
      Top = 25
      Width = 34
      Height = 15
      Caption = 'Label1'
    end
    object ControlListButton1: TControlListButton
      Left = 904
      Top = 11
      Width = 52
      Height = 25
      Caption = 'Open'
      LinkHotColor = clHighlight
      OnClick = ControlListButton1Click
    end
  end
end
