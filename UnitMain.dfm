object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'IDE Module Parser'
  ClientHeight = 520
  ClientWidth = 994
  Color = clBtnFace
  Constraints.MinHeight = 520
  Constraints.MinWidth = 950
  DefaultMonitor = dmDesktop
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesktopCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 994
    Height = 37
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      994
      37)
    object Button1: TButton
      Left = 292
      Top = 6
      Width = 157
      Height = 25
      Action = actOpenModuleFile
      ModalResult = 1
      TabOrder = 2
    end
    object Button2: TButton
      Left = 911
      Top = 6
      Width = 75
      Height = 25
      Action = actExit
      Anchors = [akRight, akBottom]
      Cancel = True
      ModalResult = 2
      TabOrder = 4
    end
    object Button3: TButton
      Left = 455
      Top = 6
      Width = 75
      Height = 25
      Action = actParseModuleFile
      TabOrder = 3
    end
    object Button4: TButton
      Left = 4
      Top = 6
      Width = 126
      Height = 25
      Action = actOpenReportZipFile
      Caption = 'Open Report in Zip'
      Default = True
      TabOrder = 0
    end
    object Button9: TButton
      Left = 136
      Top = 6
      Width = 150
      Height = 25
      Action = actCopyFromVersionInfo
      TabOrder = 1
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 37
    Width = 994
    Height = 464
    ActivePage = tsSettings
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    Style = tsFlatButtons
    TabOrder = 1
    OnChange = PageControl1Change
    object tsHome: TTabSheet
      Caption = 'Home'
      ImageIndex = 8
      DesignSize = (
        986
        429)
      object lblStartMessageMain: TLabel
        AlignWithMargins = True
        Left = 397
        Top = 87
        Width = 192
        Height = 28
        Alignment = taCenter
        Anchors = []
        Caption = 'Open or Drag&&Drop'
        Color = clWindow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clHighlight
        Font.Height = -20
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        StyleElements = [seClient, seBorder]
        ExplicitLeft = 352
        ExplicitTop = 75
      end
      object lblStartMessageSecondary: TLabel
        AlignWithMargins = True
        Left = 274
        Top = 153
        Width = 438
        Height = 122
        Alignment = taCenter
        Anchors = []
        AutoSize = False
        Caption = 'Start Message'
        Color = clWindow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMedGray
        Font.Height = -19
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = True
        WordWrap = True
        StyleElements = [seClient, seBorder]
        ExplicitLeft = 269
        ExplicitTop = 152
      end
    end
    object tsModulesList: TTabSheet
      Caption = 'Modules'
      ImageIndex = 1
      object Splitter1: TSplitter
        Left = 245
        Top = 0
        Width = 5
        Height = 429
        ExplicitLeft = 216
        ExplicitTop = -2
        ExplicitHeight = 468
      end
      object Panel11Right: TPanel
        Left = 250
        Top = 0
        Width = 736
        Height = 429
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        object gbModulesList: TGroupBox
          Left = 0
          Top = 105
          Width = 736
          Height = 324
          Align = alClient
          Caption = 'Modules List'
          TabOrder = 1
          object DBGridModules: TDBGrid
            Left = 2
            Top = 19
            Width = 732
            Height = 303
            Align = alClient
            DataSource = DM1.DataSource1
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
            PopupMenu = ppmModulesGrid
            ReadOnly = True
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -13
            TitleFont.Name = 'Segoe UI'
            TitleFont.Style = []
            OnDrawColumnCell = DBGridModulesDrawColumnCell
            OnDblClick = DBGridModulesDblClick
            OnTitleClick = DBGridModulesTitleClick
            Columns = <
              item
                Expanded = False
                FieldName = 'FileName'
                Title.Caption = 'File Name'
                Title.Color = clGrayText
                Width = 150
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'Version'
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'PackageName'
                Title.Caption = 'Package Name'
                Width = 200
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'Path'
                Width = 300
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'DateAndTime'
                Title.Caption = 'Date & Time'
                Width = 140
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'Hash'
                Width = 250
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'PackageType_ID'
                Visible = False
              end>
          end
        end
        object Panel9Top: TPanel
          Left = 0
          Top = 0
          Width = 736
          Height = 105
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          DesignSize = (
            736
            105)
          object SpeedButton1: TSpeedButton
            Left = 634
            Top = 77
            Width = 94
            Height = 22
            Action = actModulesCopySelectedAsText
            Anchors = [akTop, akRight]
            ParentShowHint = False
            ShowHint = True
            ExplicitLeft = 679
          end
          object SpeedButton3: TSpeedButton
            Left = 451
            Top = 77
            Width = 177
            Height = 22
            Action = actModulesAddSelectedToDB
            Anchors = [akTop, akRight]
            ParentShowHint = False
            ShowHint = True
            ExplicitLeft = 496
          end
          object SpeedButton2: TSpeedButton
            Left = 634
            Top = 46
            Width = 94
            Height = 22
            Action = actModulesSelectAll
            Anchors = [akTop, akRight]
            ParentShowHint = False
            ShowHint = True
          end
          object SpeedButton9: TSpeedButton
            Left = 534
            Top = 46
            Width = 94
            Height = 22
            Action = actDisplayPackagesList
            Anchors = [akTop, akRight]
          end
          object ledtBDSBuild: TLabeledEdit
            Left = 110
            Top = 45
            Width = 163
            Height = 25
            Alignment = taCenter
            EditLabel.Width = 78
            EditLabel.Height = 25
            EditLabel.Caption = 'BDS build '#8470':'
            LabelPosition = lpLeft
            ReadOnly = True
            TabOrder = 1
            Text = ''
          end
          object ledtBDSInstDate: TLabeledEdit
            Left = 110
            Top = 74
            Width = 163
            Height = 25
            Alignment = taCenter
            EditLabel.Width = 94
            EditLabel.Height = 25
            EditLabel.Caption = 'BDS install Date:'
            LabelPosition = lpLeft
            ReadOnly = True
            TabOrder = 2
            Text = ''
          end
          object ledtBDSPath: TLabeledEdit
            Left = 110
            Top = 14
            Width = 419
            Height = 25
            Constraints.MaxWidth = 600
            Constraints.MinWidth = 200
            EditLabel.Width = 51
            EditLabel.Height = 25
            EditLabel.Caption = 'BDS Path:'
            EditLabel.Color = clBtnFace
            EditLabel.Font.Charset = DEFAULT_CHARSET
            EditLabel.Font.Color = clWindowText
            EditLabel.Font.Height = -12
            EditLabel.Font.Name = 'Segoe UI'
            EditLabel.Font.Style = []
            EditLabel.ParentColor = False
            EditLabel.ParentFont = False
            LabelPosition = lpLeft
            ReadOnly = True
            TabOrder = 0
            Text = ''
          end
          object edRSBuild: TEdit
            Left = 279
            Top = 45
            Width = 249
            Height = 25
            Alignment = taCenter
            Constraints.MaxWidth = 400
            Constraints.MinWidth = 200
            ReadOnly = True
            TabOrder = 3
          end
          object eIDEbittness: TEdit
            Left = 535
            Top = 14
            Width = 74
            Height = 25
            Alignment = taCenter
            ReadOnly = True
            TabOrder = 4
            Text = '32-bit IDE'
          end
        end
      end
      object Panel10Left: TPanel
        Left = 0
        Top = 0
        Width = 245
        Height = 429
        Align = alLeft
        BevelOuter = bvNone
        Constraints.MaxWidth = 600
        Constraints.MinWidth = 200
        TabOrder = 0
        object GroupBox5: TGroupBox
          Left = 0
          Top = 105
          Width = 245
          Height = 324
          Align = alClient
          Caption = 'Filters'
          Constraints.MinWidth = 100
          PopupMenu = ppmFilters
          TabOrder = 0
          DesignSize = (
            245
            324)
          object Label1: TLabel
            Left = 11
            Top = 75
            Width = 54
            Height = 17
            Caption = 'Packages'
          end
          object Label5: TLabel
            Left = 11
            Top = 196
            Width = 91
            Height = 17
            Anchors = [akLeft, akBottom]
            Caption = 'Packages Types'
          end
          object sbPackagesPlus: TSpeedButton
            Left = 195
            Top = 77
            Width = 17
            Height = 17
            Action = actFilterPackagesSelectAll
            Anchors = [akTop, akRight]
            Caption = '+'
            ParentShowHint = False
            ShowHint = True
          end
          object sbPackagesMinus: TSpeedButton
            Left = 217
            Top = 77
            Width = 17
            Height = 17
            Action = actFilterPackagesUnSelectAll
            Anchors = [akTop, akRight]
            Caption = '-'
            ParentShowHint = False
            ShowHint = True
            ExplicitLeft = 172
          end
          object SpeedButton6: TSpeedButton
            Left = 195
            Top = 197
            Width = 17
            Height = 17
            Action = actFilterPackagesTypesSelectAll
            Anchors = [akRight, akBottom]
            Caption = '+'
            ParentShowHint = False
            ShowHint = True
            ExplicitLeft = 150
          end
          object SpeedButton7: TSpeedButton
            Left = 217
            Top = 197
            Width = 17
            Height = 17
            Action = actFilterPackagesTypesUnselectAll
            Anchors = [akRight, akBottom]
            Caption = '-'
            ParentShowHint = False
            ShowHint = True
            ExplicitLeft = 172
          end
          object sbPackagesC: TSpeedButton
            Left = 112
            Top = 77
            Width = 17
            Height = 17
            Action = actFilterPackagesCopyToClipboard
            Anchors = [akTop, akRight]
            Caption = 'C'
            Margin = 4
            ParentShowHint = False
            ShowHint = True
          end
          object SpeedButton10: TSpeedButton
            Left = 173
            Top = 197
            Width = 17
            Height = 17
            Action = actFilterPackagesTypesSelectOnlyEmpty
            Anchors = [akRight, akBottom]
            Caption = 'E'
            Margin = 4
            ParentShowHint = False
            ShowHint = True
            ExplicitLeft = 128
          end
          object sbPackagesE: TSpeedButton
            Left = 173
            Top = 77
            Width = 17
            Height = 17
            Action = actFilterPackagesSelectOnlyEmpty
            Anchors = [akTop, akRight]
            Caption = 'E'
            Margin = 4
            ParentShowHint = False
            ShowHint = True
          end
          object SpeedButton12: TSpeedButton
            Left = 136
            Top = 197
            Width = 31
            Height = 17
            Action = actFilterPackagesTypesSelectOnly3rdParty
            Anchors = [akRight, akBottom]
            Caption = '3rd'
            Margin = 4
            ParentShowHint = False
            ShowHint = True
          end
          object sbPackages3rd: TSpeedButton
            Left = 136
            Top = 77
            Width = 31
            Height = 17
            Action = actFilterPackagesSelectOnly3rdParty
            Anchors = [akTop, akRight]
            Caption = '3rd'
            Margin = 4
            ParentShowHint = False
            ShowHint = True
          end
          object clbVisiblePackages: TCheckListBox
            Left = 9
            Top = 96
            Width = 227
            Height = 94
            Anchors = [akLeft, akTop, akRight, akBottom]
            ItemHeight = 17
            PopupMenu = ppmFilterPackages
            Sorted = True
            TabOrder = 0
            OnClickCheck = clbVisiblePackagesClickCheck
          end
          object lbedFilterFileName: TLabeledEdit
            Left = 10
            Top = 43
            Width = 227
            Height = 25
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 58
            EditLabel.Height = 17
            EditLabel.Caption = 'File Name'
            MaxLength = 60
            TabOrder = 1
            Text = ''
            OnChange = lbedFilterFileNameChange
          end
          object clbVisiblePackagesTypes: TCheckListBox
            AlignWithMargins = True
            Left = 9
            Top = 216
            Width = 227
            Height = 99
            Margins.Left = 7
            Margins.Top = 7
            Margins.Right = 7
            Margins.Bottom = 7
            Align = alBottom
            ItemHeight = 17
            PopupMenu = ppmFilterPackagesTypes
            TabOrder = 2
            OnClickCheck = clbVisiblePackagesTypesClickCheck
          end
        end
        object GroupBox4: TGroupBox
          Left = 0
          Top = 0
          Width = 245
          Height = 105
          Align = alTop
          Caption = 'Statistic'
          TabOrder = 1
          DesignSize = (
            245
            105)
          object lblModulesSelectedCount: TLabel
            Left = 205
            Top = 48
            Width = 32
            Height = 17
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            Caption = #1061#1061#1061'X'
            ExplicitLeft = 160
          end
          object lblModulesCount: TLabel
            Left = 205
            Top = 25
            Width = 32
            Height = 17
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            Caption = #1061#1061#1061'X'
            ExplicitLeft = 160
          end
          object lblModulesFilteredCount: TLabel
            Left = 205
            Top = 71
            Width = 32
            Height = 17
            Alignment = taRightJustify
            Anchors = [akTop, akRight]
            Caption = #1061#1061#1061'X'
            ExplicitLeft = 160
          end
          object Label2: TLabel
            Left = 11
            Top = 25
            Width = 90
            Height = 17
            Caption = 'Modules count:'
          end
          object Label3: TLabel
            Left = 11
            Top = 48
            Width = 142
            Height = 17
            Caption = 'Modules selected count:'
          end
          object Label4: TLabel
            Left = 11
            Top = 71
            Width = 135
            Height = 17
            Caption = 'Modules filtered count:'
          end
        end
      end
    end
    object tsModuleListFile: TTabSheet
      Caption = 'ModuleList file'
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 986
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 0
        DesignSize = (
          986
          41)
        object lbedModuleFile: TLabeledEdit
          Left = 104
          Top = 10
          Width = 875
          Height = 25
          Cursor = crHandPoint
          Anchors = [akLeft, akTop, akRight, akBottom]
          EditLabel.Width = 88
          EditLabel.Height = 25
          EditLabel.Caption = 'ModuleList file:'
          LabelPosition = lpLeft
          ReadOnly = True
          TabOrder = 0
          Text = ''
          OnClick = actOpenModuleFileExecute
        end
      end
      object MemoTxtModuleFile: TMemo
        AlignWithMargins = True
        Left = 5
        Top = 46
        Width = 976
        Height = 378
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Monoid'
        Font.Pitch = fpFixed
        Font.Style = []
        Lines.Strings = (
          
            'bds.exe'#9'(0x00400000)'#9'C:\Program Files (x86)\Embarcadero\Studio\2' +
            '2.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:56:22 PM'#9'A98036BFF167998F35264DF59A' +
            'E3FADF49F76AEA'
          
            'ntdll.dll'#9'(0x773A0000)'#9'C:\WINDOWS\SYSTEM32\'#9'10.0.19041.2364'#9'12/2' +
            '0/2022 5:45:51 AM'#9
          'F96B368FDC17D226CD25848E95DE2DCD9CB10288'
          
            'KERNEL32.DLL'#9'(0x76720000)'#9'C:\WINDOWS\System32\'#9'10.0.19041.2364'#9'1' +
            '2/20/2022 5:46:20 AM'#9
          '519A656EF8CFAD56796567BFDF2F1F36C1631396'
          
            'KERNELBASE.dll'#9'(0x76C40000)'#9'C:\WINDOWS\System32\'#9'10.0.19041.2364' +
            #9'12/20/2022 5:41:17 AM'#9
          'E23E0DD62F89B7D2CF3548B692D337A80DA03A64'
          
            'ws2_32.dll'#9'(0x753A0000)'#9'C:\WINDOWS\System32\'#9'10.0.19041.546'#9'1/8/' +
            '2022 4:04:44 AM'#9
          '6C2781EADF53B3742D16DAB2F164BAF813F7AC85'
          
            'RPCRT4.dll'#9'(0x77170000)'#9'C:\WINDOWS\System32\'#9'10.0.19041.1806'#9'7/1' +
            '3/2022 4:22:49 PM'#9
          '8DAAED9A4E069984B897FB6631BF02FB772E2B48'
          
            'vclactnband280.bpl'#9'(0x217A0000)'#9'C:\Program Files (x86)\Embarcade' +
            'ro\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:40:44 PM'#9'E6815A062AE524C96A3178CD91' +
            '2467392D3351EF'
          
            'borlndmm.dll'#9'(0x50030000)'#9'C:\Program Files (x86)\Embarcadero\Stu' +
            'dio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:42:40 PM'#9'BDAD2846D0BA73F330306E9D6E' +
            '9BBDD3BF2F2A55'
          
            'user32.dll'#9'(0x76810000)'#9'C:\WINDOWS\System32\'#9'10.0.19041.2364'#9'12/' +
            '20/2022 5:47:59 AM'#9
          '6A91CF81082A08151A99F1E9DEA9BFEA342977AF'
          
            'winmm.dll'#9'(0x66600000)'#9'C:\WINDOWS\SYSTEM32\'#9'10.0.19041.546'#9'1/8/2' +
            '022 4:04:44 AM'#9
          '77CC21EE1D0B53504A0FD8208C617BB0855706B1'
          
            'win32u.dll'#9'(0x75E60000)'#9'C:\WINDOWS\System32\'#9'10.0.19041.2364'#9'12/' +
            '20/2022 5:47:59 AM'#9
          '96ED5377BBEE9BE9B16C483A9C9A27F1F19FB17C'
          
            'advapi32.dll'#9'(0x75B00000)'#9'C:\WINDOWS\System32\'#9'10.0.19041.2130'#9'1' +
            '0/13/2022 4:04:07 AM'#9
          '1F69E4B6DB8B84BD6CEFC963FC84DFB3976BEBD7'
          
            'oleaut32.dll'#9'(0x76010000)'#9'C:\WINDOWS\System32\'#9'10.0.19041.985'#9'1/' +
            '8/2022 4:04:58 AM'#9
          '44FC9695717B8841B6BFFB730A858BA00678C9D7'
          
            'msvcrt.dll'#9'(0x75C80000)'#9'C:\WINDOWS\System32\'#9'7.0.19041.546'#9'1/8/2' +
            '022 4:04:44 AM'#9
          'E75752978EDC470752DE9627A498794393C3B8EB'
          
            'GDI32.dll'#9'(0x769B0000)'#9'C:\WINDOWS\System32\'#9'10.0.19041.2130'#9'10/1' +
            '3/2022 4:05:06 AM'#9
          'B175DE0EE473C6ECF55FA8510994A20BCC52CC0E'
          
            'msvcp_win.dll'#9'(0x769E0000)'#9'C:\WINDOWS\System32\'#9'10.0.19041.789'#9'1' +
            '/8/2022 4:04:57 AM'#9
          '45C0154C0128D356FA96F23689D945CE4122D975'
          
            'gdi32full.dll'#9'(0x75430000)'#9'C:\WINDOWS\System32\'#9'10.0.19041.2364'#9 +
            '12/20/2022 5:48:19 AM'#9
          'C2CC7A1BAC6FEF9F26977A046600260A3DD91277'
          
            'sechost.dll'#9'(0x75F30000)'#9'C:\WINDOWS\System32\'#9'10.0.19041.1865'#9'8/' +
            '10/2022 1:48:00 PM'#9
          '66D7782C6E9068E128412544D3A0AF847560F309'
          
            'ucrtbase.dll'#9'(0x759E0000)'#9'C:\WINDOWS\System32\'#9'10.0.19041.789'#9'1/' +
            '8/2022 4:04:57 AM'#9
          '54D14ACE2F00A93C28984A577EBB47929D29E3CF'
          
            'oleacc.dll'#9'(0x66440000)'#9'C:\WINDOWS\SYSTEM32\'#9'7.2.19041.746'#9'1/8/2' +
            '022 4:05:01 AM'#9
          '3FE86EB84B20BE710FA80C47E68520DF37348F25'
          
            'shell32.dll'#9'(0x760B0000)'#9'C:\WINDOWS\System32\'#9'10.0.19041.2311'#9'12' +
            '/20/2022 5:48:30 AM'#9
          'A422FCED37E458E5B0A9ECB0279ACCB530240F9C'
          
            'combase.dll'#9'(0x76E60000)'#9'C:\WINDOWS\System32\'#9'10.0.19041.2311'#9'12' +
            '/20/2022 5:48:11 AM'#9
          '2C58ADC796F8C0E861E7D3E9EFCFC9018632A282'
          
            'ole32.dll'#9'(0x75B90000)'#9'C:\WINDOWS\System32\'#9'10.0.19041.1202'#9'1/8/' +
            '2022 4:04:57 AM'#9
          'D00929E5A7984336E61468ADE1B3647DD9BE4BE6'
          
            'version.dll'#9'(0x73940000)'#9'C:\WINDOWS\SYSTEM32\'#9'10.0.19041.546'#9'1/8' +
            '/2022 4:05:03 AM'#9
          'FB234C5AFA44388F6D4C8CFBF6090EAB0BF0C3F5'
          
            'rtl280.bpl'#9'(0x50050000)'#9'C:\Program Files (x86)\Embarcadero\Studi' +
            'o\22.0\bin\'#9
          
            '28.0.43310.7440'#9'11/10/2021 2:10:54 AM'#9'77956D7D6328D0D3B3BDBFBFFF' +
            '2CCBF06B07C95F'
          
            'comctl32.dll'#9'(0x6E0F0000)'#9'C:\WINDOWS\WinSxS\x86_microsoft.window' +
            's.common-'
          
            'controls_6595b64144ccf1df_6.0.19041.1110_none_a8625c1886757984\'#9 +
            '6.10.19041.1110'#9'1/8/2022 '
          '4:05:03 AM'#9'4223A6FB85FD0BE6E4D4E38506131863FDCD3BE3'
          
            'inet280.bpl'#9'(0x516A0000)'#9'C:\Program Files (x86)\Embarcadero\Stud' +
            'io\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:40:18 PM'#9'6150F1068F131E3888157A716D' +
            '242E2379D72400'
          
            'shlwapi.dll'#9'(0x76670000)'#9'C:\WINDOWS\System32\'#9'10.0.19041.2075'#9'10' +
            '/13/2022 4:05:34 AM'#9
          'EAB534D9FDF75EB3C08C026BB31FE423197F9CB6'
          
            'vclide280.bpl'#9'(0x210D0000)'#9'C:\Program Files (x86)\Embarcadero\St' +
            'udio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:40:48 PM'#9'5997154AC52CDD82F338B128A9' +
            'D9C2A54ACE090D'
          
            'IMAGEHLP.DLL'#9'(0x75410000)'#9'C:\WINDOWS\System32\'#9'10.0.19041.1415'#9'1' +
            '/8/2022 4:04:28 AM'#9
          '1D554FB98FD1D1DE73CC674F7CFD95F98E065F4B'
          
            'soaprtl280.bpl'#9'(0x52270000)'#9'C:\Program Files (x86)\Embarcadero\S' +
            'tudio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:40:36 PM'#9'1B84A3EBF730361EA188909FA8' +
            '2AFCB7DFB86995'
          
            'designide280.bpl'#9'(0x20F00000)'#9'C:\Program Files (x86)\Embarcadero' +
            '\Studio\22.0\bin\'#9
          
            '28.0.43310.7440'#9'11/10/2021 2:10:52 AM'#9'2B72EF0A164A6435BBF3A14444' +
            'DCB39D97E10661'
          
            'wsock32.dll'#9'(0x66700000)'#9'C:\WINDOWS\SYSTEM32\'#9'10.0.19041.1'#9'12/7/' +
            '2019 4:09:15 AM'#9
          '914B13BAD274B66743C019B6FC1240C9E25E6959'
          
            'wininet.dll'#9'(0x744C0000)'#9'C:\WINDOWS\SYSTEM32\'#9'11.0.19041.2193'#9'11' +
            '/10/2022 8:59:46 AM'#9
          '7268FAFD1CC07524E860A21963EB68E068C5D161'
          
            'xmlrtl280.bpl'#9'(0x51460000)'#9'C:\Program Files (x86)\Embarcadero\St' +
            'udio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:40:58 PM'#9'68D3347EA650B532F93C841DDE' +
            'C3670BEA441BD9'
          
            'coreide280.bpl'#9'(0x20400000)'#9'C:\Program Files (x86)\Embarcadero\S' +
            'tudio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:38:36 PM'#9'FC7462A1C6C276AFD83BED9BE8' +
            'CE1F57AFCECB42'
          
            'vclx280.bpl'#9'(0x510B0000)'#9'C:\Program Files (x86)\Embarcadero\Stud' +
            'io\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:40:52 PM'#9'5B5538E6FEC3B31266F20D43AE' +
            '4F1966D05776EF'
          
            'dbrtl280.bpl'#9'(0x513A0000)'#9'C:\Program Files (x86)\Embarcadero\Stu' +
            'dio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:38:44 PM'#9'8615C5B8036EDE1F44ED2C5573' +
            '42A3680D4D8DA6'
          
            'vcl280.bpl'#9'(0x50C90000)'#9'C:\Program Files (x86)\Embarcadero\Studi' +
            'o\22.0\bin\'#9
          
            '28.0.43310.7440'#9'11/10/2021 2:10:54 AM'#9'D52A3FA4195025BA880EC81194' +
            '535FEDD446BE6C'
          
            'vclie280.bpl'#9'(0x51100000)'#9'C:\Program Files (x86)\Embarcadero\Stu' +
            'dio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:40:48 PM'#9'675747630A2AF2FF892E0D7E82' +
            'FAF85790B6F235'
          
            'comdlg32.dll'#9'(0x75E80000)'#9'C:\WINDOWS\System32\'#9'10.0.19041.1806'#9'7' +
            '/13/2022 4:23:17 PM'#9
          '3007B6B9D9471FED1D9CE4EF54946419F78D1712'
          
            'iphlpapi.dll'#9'(0x74920000)'#9'C:\WINDOWS\SYSTEM32\'#9'10.0.19041.546'#9'1/' +
            '8/2022 4:04:57 AM'#9
          '609DCE661AFF6D63E0A0F7BD8A4DB024AFEADFFF'
          
            'mpr.dll'#9'(0x6F920000)'#9'C:\WINDOWS\SYSTEM32\'#9'10.0.19041.1806'#9'7/13/2' +
            '022 4:23:10 PM'#9
          '46904D2B5E67B4D9E3DD2C58D176BD55CC3CCC91'
          
            'netapi32.dll'#9'(0x744A0000)'#9'C:\WINDOWS\SYSTEM32\'#9'10.0.19041.2130'#9'1' +
            '0/13/2022 4:04:29 AM'#9
          'D83A5D080CB1E17A9BF947D52E48D07D54CB29CE'
          
            'winhttp.dll'#9'(0x73950000)'#9'C:\WINDOWS\SYSTEM32\'#9'10.0.19041.2193'#9'11' +
            '/10/2022 8:59:43 AM'#9
          '4363CE376AA7B45D7C9D6CD4E22DC49782DC0DDF'
          
            'URLMON.DLL'#9'(0x70380000)'#9'C:\WINDOWS\SYSTEM32\'#9'11.0.19041.2251'#9'11/' +
            '10/2022 8:59:47 AM'#9
          '6D36F794B64D2B8523D6D553C387AA4BDEDA0C11'
          
            'SHFolder.dll'#9'(0x5E420000)'#9'C:\WINDOWS\SYSTEM32\'#9'10.0.19041.1'#9'12/7' +
            '/2019 4:09:32 AM'#9
          '062897B3C966C34AF6893DF1F8A761A08308F7A5'
          
            'DotNetCoreAssemblies280.bpl'#9'(0x52840000)'#9'C:\Program Files (x86)\' +
            'Embarcadero\Studio'
          '\22.0\bin\'#9'28.0.42600.6491'#9'8/30/2021 10:39:36 PM'#9
          'E2195DDFCE7D521837DEAE8849C3D2BC12643407'
          
            'winspool.drv'#9'(0x6E970000)'#9'C:\WINDOWS\SYSTEM32\'#9'10.0.19041.2311'#9'1' +
            '2/20/2022 5:45:51 AM'#9
          '23334F46AB17B67FCF7DDFA602B0A805939F90C6'
          
            'iertutil.dll'#9'(0x70140000)'#9'C:\WINDOWS\SYSTEM32\'#9'11.0.19041.2130'#9'1' +
            '0/13/2022 4:05:30 AM'#9
          '00015DF7BE6D0B3175DE081D7ED0711F2377E4BF'
          
            'srvcli.dll'#9'(0x73120000)'#9'C:\WINDOWS\SYSTEM32\'#9'10.0.19041.1645'#9'4/2' +
            '1/2022 12:28:19 PM'#9
          'F14E5A327906E2413EA55B0FD766233B38091C5D'
          
            'netutils.dll'#9'(0x73680000)'#9'C:\WINDOWS\SYSTEM32\'#9'10.0.19041.1466'#9'1' +
            '/8/2022 4:04:57 AM'#9
          'B971FBEEAC2B156B6A8879BB5A84C708F19B2E1D'
          
            'shcore.dll'#9'(0x77260000)'#9'C:\WINDOWS\System32\'#9'10.0.19041.1645'#9'4/2' +
            '1/2022 12:28:17 PM'#9
          '250DBB0FBDA2BFB4E03AFCB4C07C22B4AF1EECD9'
          
            'oledlg.dll'#9'(0x5CD50000)'#9'C:\WINDOWS\SYSTEM32\'#9'10.0.19041.746'#9'1/8/' +
            '2022 4:04:57 AM'#9
          'A5C2819A821846D02849D4A75B82A81465815542'
          
            'getit280.bpl'#9'(0x015D0000)'#9'C:\Program Files (x86)\Embarcadero\Stu' +
            'dio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:40:02 PM'#9'34B15A3FFFD8046B7B4361D38F' +
            'BEAF59711A90C6'
          
            'vclwinx280.bpl'#9'(0x01450000)'#9'C:\Program Files (x86)\Embarcadero\S' +
            'tudio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:40:52 PM'#9'BC67744BDBC0D77864E904F714' +
            'F835BCC4AE001F'
          
            'vcledge280.bpl'#9'(0x008F0000)'#9'C:\Program Files (x86)\Embarcadero\S' +
            'tudio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:40:46 PM'#9'009A72779B28B4CBE190080102' +
            '4A02ED3CD1B8B0'
          
            'vclimg280.bpl'#9'(0x013F0000)'#9'C:\Program Files (x86)\Embarcadero\St' +
            'udio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:40:48 PM'#9'84492A2BDBE14F492970184379' +
            '3F4EAB9AFF5DB2'
          
            'designideresources280.bpl'#9'(0x018B0000)'#9'C:\Program Files (x86)\Em' +
            'barcadero\Studio'
          '\22.0\bin\'#9'28.0.42600.6491'#9'8/30/2021 10:39:34 PM'#9
          'DEA325AF972A02CAB2A0FBD76391968756CA183D'
          
            'bindengine280.bpl'#9'(0x01FE0000)'#9'C:\Program Files (x86)\Embarcader' +
            'o\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:38:30 PM'#9'58567D2F35FC6D5ABE747003B9' +
            'FF99BE086AA5B4'
          
            'IMM32.DLL'#9'(0x77230000)'#9'C:\WINDOWS\System32\'#9'10.0.19041.2193'#9'11/1' +
            '0/2022 8:59:44 AM'#9
          '037A686083A203E06BD2EFD4AA09C3DE9263417A'
          
            'Msctf.dll'#9'(0x75260000)'#9'C:\WINDOWS\System32\'#9'10.0.19041.2193'#9'11/1' +
            '0/2022 8:59:32 AM'#9
          '4B9F9407DD55FB6508DA285D4A4499CDC3C2F2CB'
          
            'uxtheme.dll'#9'(0x6E500000)'#9'C:\WINDOWS\system32\'#9'10.0.19041.2193'#9'11' +
            '/10/2022 8:59:32 AM'#9
          '9EFBD44379FF535C7FDFE00EB91C3667B2F30C45'
          
            'kernel.appcore.dll'#9'(0x74060000)'#9'C:\WINDOWS\SYSTEM32\'#9'10.0.19041.' +
            '546'#9'1/8/2022 '
          '4:04:52 AM'#9'CFAB795E1930778A50F7B2010900B052399A3B48'
          
            'bcryptPrimitives.dll'#9'(0x766C0000)'#9'C:\WINDOWS\System32\'#9'10.0.1904' +
            '1.1415'#9'1/8/2022 '
          '4:04:28 AM'#9'09E867F3BF5D266609D0F89935D87A1B3C1BE5F9'
          
            'wtsapi32.dll'#9'(0x73690000)'#9'C:\WINDOWS\SYSTEM32\'#9'10.0.19041.546'#9'1/' +
            '8/2022 4:04:46 AM'#9
          'B9DF8E8B4C7A8540B007C482ADA4A74E15999FF6'
          
            'WINSTA.dll'#9'(0x6E840000)'#9'C:\WINDOWS\SYSTEM32\'#9'10.0.19041.2075'#9'10/' +
            '13/2022 4:04:29 AM'#9
          '2858305C312D277864E39200324204B78ADF0B55'
          'gdiplus.dll'#9'(0x6D860000)'#9'C:\WINDOWS\WinSxS'
          
            '\x86_microsoft.windows.gdiplus_6595b64144ccf1df_1.1.19041.2251_n' +
            'one_d9513b1fe1046fc7\'#9
          
            '10.0.19041.2251'#9'11/4/2022 3:25:18 AM'#9'AC6E6B4F16B706083F74D2294EA' +
            '7FDC631EE8B0D'
          
            'olepro32.dll'#9'(0x5D530000)'#9'C:\WINDOWS\SYSTEM32\'#9'10.0.19041.84'#9'1/8' +
            '/2022 4:05:02 AM'#9
          'AB0E2CA1FF3F7FA865E6326C54834B68E44252D6'
          
            'clbcatq.dll'#9'(0x75510000)'#9'C:\WINDOWS\System32\'#9'2001.12.10941.1638' +
            '4'#9'10/13/2022 '
          '4:05:21 AM'#9'97A254FB98B6D6C7D99FDCE28D969043BE85861B'
          
            'windowscodecs.dll'#9'(0x66970000)'#9'C:\WINDOWS\system32\'#9'10.0.19041.1' +
            '706'#9'5/11/2022 '
          '10:12:13 AM'#9'8ED0438558DE7933049F37FA773C2D0B0017E0DD'
          
            'bcrypt.dll'#9'(0x75D40000)'#9'C:\WINDOWS\System32\'#9'10.0.19041.1023'#9'1/8' +
            '/2022 4:04:57 AM'#9
          '7BC8D3FF25A6106F6FF07804C32BB2103351AEF8'
          
            'identity280.bpl'#9'(0x04770000)'#9'C:\Program Files (x86)\Embarcadero\' +
            'Studio\22.0\bin\bds\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:52:54 PM'#9'65A4F57E7BE285BF5853C52CAE' +
            'E3100D65463D68'
          
            'TextShaping.dll'#9'(0x66AF0000)'#9'C:\WINDOWS\SYSTEM32\'#9'1/8/2022 4:04:' +
            '50 AM'#9
          'EC3A5EE104E43D1295EC5BAF0B5A55AB9C983F7F'
          
            'textinputframework.dll'#9'(0x6DE10000)'#9'C:\WINDOWS\SYSTEM32\'#9'10.0.19' +
            '041.2075'#9'10/13/2022 '
          '4:05:07 AM'#9'34C2FDB94E9A403CF2BF7A2C5B1DCC5609626CA8'
          
            'CoreMessaging.dll'#9'(0x6DB10000)'#9'C:\WINDOWS\SYSTEM32\'#9'10.0.19041.2' +
            '193'#9'11/10/2022 '
          '8:59:42 AM'#9'53E7AFD3674CCFA723D89F80BB619EFCC8C37677'
          
            'CoreUIComponents.dll'#9'(0x6AA80000)'#9'C:\WINDOWS\SYSTEM32\'#9'10.0.1904' +
            '1.546'#9'1/8/2022 '
          '4:04:49 AM'#9'02D2651EA6B38FAD4640210A31C75B38303855E8'
          
            'wintypes.dll'#9'(0x6DA10000)'#9'C:\WINDOWS\SYSTEM32\'#9'10.0.19041.2311'#9'1' +
            '2/20/2022 5:48:11 AM'#9
          '92A0631A59D56AA4842389E3177BF94A08207875'
          
            'ntmarta.dll'#9'(0x73140000)'#9'C:\WINDOWS\SYSTEM32\'#9'10.0.19041.546'#9'1/8' +
            '/2022 4:04:58 AM'#9
          '20A9C589317B498A9F449CE9A1A8211B37D26238'
          
            'DWMAPI.DLL'#9'(0x69820000)'#9'C:\WINDOWS\SYSTEM32\'#9'10.0.19041.746'#9'1/8/' +
            '2022 4:04:57 AM'#9
          '22C3513A3244E4E7EE5084844263D936CC8F01EA'
          
            'PSAPI.DLL'#9'(0x76A60000)'#9'C:\WINDOWS\System32\'#9'10.0.19041.546'#9'1/8/2' +
            '022 4:04:57 AM'#9
          'C3EB735B1C8C1DADAB0D5A55D1F6240F35A0EFD1'
          
            'windows.storage.dll'#9'(0x73A50000)'#9'C:\WINDOWS\SYSTEM32\'#9'10.0.19041' +
            '.2311'#9'12/20/2022 '
          '5:47:53 AM'#9'C67207211D2B7C431F7577FEB1E7B554E0055456'
          
            'Wldp.dll'#9'(0x73A20000)'#9'C:\WINDOWS\SYSTEM32\'#9'10.0.19041.2311'#9'12/20' +
            '/2022 5:48:11 AM'#9
          '49CFE09FCBE686F4B4792236BD37DCD604C5F955'
          
            'profapi.dll'#9'(0x726D0000)'#9'C:\WINDOWS\SYSTEM32\'#9'10.0.19041.844'#9'1/8' +
            '/2022 4:04:44 AM'#9
          'CB619A677F467E996FFBF55BE887ADDD70881AB4'
          
            'CFGMGR32.dll'#9'(0x77350000)'#9'C:\WINDOWS\System32\'#9'10.0.19041.1620'#9'4' +
            '/21/2022 12:28:19 PM'#9
          'A38B7FA4E031C3485FFCCB2FDE249D8AC59C3451'
          
            'propsys.dll'#9'(0x6A830000)'#9'C:\WINDOWS\system32\'#9'7.0.19041.1741'#9'6/1' +
            '5/2022 8:18:09 PM'#9
          '4C2EEB5581205EA2D8780FC87C9CD6C0F6B76B33'
          
            'msxml6.dll'#9'(0x724F0000)'#9'C:\Windows\System32\'#9'6.30.19041.1081'#9'1/8' +
            '/2022 4:04:55 AM'#9
          '2D307D2B5244F59B0C9092759A35F1AB5CF224D8'
          
            'wintrust.dll'#9'(0x75350000)'#9'C:\WINDOWS\System32\'#9'10.0.19041.2311'#9'1' +
            '2/20/2022 5:47:54 AM'#9
          '3BA7291F8CD37EE9F27F20A942B095AF936ED570'
          
            'CRYPT32.dll'#9'(0x75D60000)'#9'C:\WINDOWS\System32\'#9'10.0.19041.1889'#9'8/' +
            '10/2022 1:48:07 PM'#9
          'CED52E8362F6EE2D7E4880BD71F8855D372BA0BF'
          
            'MSASN1.dll'#9'(0x73670000)'#9'C:\WINDOWS\SYSTEM32\'#9'10.0.19041.2251'#9'11/' +
            '10/2022 8:59:43 AM'#9
          'AB4CB20CA9AAF8C48E269D8B85D2A92132AAC747'
          
            'CRYPTSP.dll'#9'(0x72720000)'#9'C:\WINDOWS\SYSTEM32\'#9'10.0.19041.546'#9'1/8' +
            '/2022 4:04:57 AM'#9
          '8155B9B85CE4F7030AB3432B2D008A8D5287B7AA'
          
            'rsaenh.dll'#9'(0x726F0000)'#9'C:\WINDOWS\system32\'#9'10.0.19041.1052'#9'1/8' +
            '/2022 4:04:57 AM'#9
          '186775F5F5D68F4BC3C058746FC56030CED9C550'
          
            'CRYPTBASE.dll'#9'(0x72460000)'#9'C:\WINDOWS\SYSTEM32\'#9'10.0.19041.546'#9'1' +
            '/8/2022 4:04:44 AM'#9
          '577E38BBE2DB46DC580E4E3EAD23EB1868AA3B9F'
          
            'gpapi.dll'#9'(0x6FED0000)'#9'C:\WINDOWS\SYSTEM32\'#9'10.0.19041.572'#9'1/8/2' +
            '022 4:04:59 AM'#9
          '1E89C0B3EEF8E15D253E2287F8A0684745A9194D'
          
            'cryptnet.dll'#9'(0x6FEA0000)'#9'C:\Windows\System32\'#9'10.0.19041.906'#9'1/' +
            '8/2022 4:04:57 AM'#9
          '98B81A3F34D2F0908D568AD76E07B4FDFD7F3AB9'
          
            'WINNSI.DLL'#9'(0x6FE40000)'#9'C:\WINDOWS\SYSTEM32\'#9'10.0.19041.546'#9'1/8/' +
            '2022 4:04:28 AM'#9
          '878E0CBDFFA9D140D388996A5E196C6BCF8867D2'
          
            'NSI.dll'#9'(0x75B80000)'#9'C:\WINDOWS\System32\'#9'10.0.19041.610'#9'1/8/202' +
            '2 4:04:28 AM'#9
          '9E3DF0709A82C13B2BBC0910A77A2DE108DEE303'
          
            'IDEvcl280.bpl'#9'(0x0E0F0000)'#9'c:\program files (x86)\embarcadero\st' +
            'udio\22.0\Bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:40:14 PM'#9'96B087F28A51DCF6E0E1BD8E33' +
            '6E250ECC3EDABD'
          
            'delphicoreide280.bpl'#9'(0x21BB0000)'#9'C:\Program Files (x86)\Embarca' +
            'dero\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:39:26 PM'#9'9330E3718168785687A819A6F8' +
            'F9B84F2228F978'
          
            'vcldesigner280.bpl'#9'(0x527E0000)'#9'C:\Program Files (x86)\Embarcade' +
            'ro\Studio\22.0\bin\'#9
          
            '28.0.43310.7440'#9'11/10/2021 2:10:56 AM'#9'7CF11BD14A9C5F25D31FE11277' +
            'E33A4A51D0346D'
          
            'BrcIde.Dll'#9'(0x21450000)'#9'C:\Program Files (x86)\Embarcadero\Studi' +
            'o\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:42:40 PM'#9'46708BAB6398BA73C03AD40277' +
            'EF2914C9C2BF57'
          
            'ModernTheme280.bpl'#9'(0x0E590000)'#9'c:\program files (x86)\embarcade' +
            'ro\studio\22.0\Bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:40:26 PM'#9'9CC9D0B3C30217ABAD2D2C3653' +
            '872C4A249E4788'
          
            'themeloader280.bpl'#9'(0x0E5D0000)'#9'C:\Program Files (x86)\Embarcade' +
            'ro\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:40:40 PM'#9'046F08506CA9810537D46B686A' +
            'B7B30D6C2A906C'
          
            'darktheme280.bpl'#9'(0x0E690000)'#9'c:\program files (x86)\embarcadero' +
            '\studio\22.0\Bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:38:36 PM'#9'674E76BF20482695DA239FC07C' +
            '7C5B4AD5D9CA1B'
          
            'codequeryide280.bpl'#9'(0x0E6D0000)'#9'c:\program files (x86)\embarcad' +
            'ero\studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:38:32 PM'#9'113F1F59B2933967F7E1F3FDB2' +
            'C645DDE6823804'
          
            'MultidevicePreview280.bpl'#9'(0x0E6F0000)'#9'c:\program files (x86)\em' +
            'barcadero\studio'
          '\22.0\Bin\'#9'28.0.42600.6491'#9'8/30/2021 10:40:26 PM'#9
          '1B2B46B7B17ADA5AB742E54E6026FE12FC400732'
          
            'asmview280.bpl'#9'(0x52600000)'#9'c:\program files (x86)\embarcadero\s' +
            'tudio\22.0\Bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:37:44 PM'#9'C6537A247352958066FF0A9862' +
            '9331ED5F77D82D'
          
            'plugview280.bpl'#9'(0x525C0000)'#9'C:\Program Files (x86)\Embarcadero\' +
            'Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:40:30 PM'#9'7CA8714ACF985E31ADAC16B35A' +
            '7ABBE629C8DA57'
          
            'mscoree.dll'#9'(0x73610000)'#9'C:\Windows\System32\'#9'10.0.19041.1'#9'12/7/' +
            '2019 4:10:05 AM'#9
          'E37695676AE23AE265E2E9110371DD93FCBD2078'
          
            'mscoreei.dll'#9'(0x73060000)'#9'C:\Windows\Microsoft.NET\Framework\v4.' +
            '0.30319\'#9'4.8.4180.0'#9
          '1/8/2022 3:57:31 AM'#9'F70FD3B9C4436234743D6DF1258FB7BAD9A21A6B'
          
            'clr.dll'#9'(0x72810000)'#9'C:\Windows\Microsoft.NET\Framework\v4.0.303' +
            '19\'#9'4.8.4515.0'#9
          '4/6/2022 12:35:22 AM'#9'023F56F572D33B53F0902839A265ABEB345F50B4'
          
            'ucrtbase_clr0400.dll'#9'(0x72740000)'#9'C:\WINDOWS\SYSTEM32\'#9'14.10.250' +
            '28.0'#9'12/7/2019 '
          '4:10:48 AM'#9'D922543E2CEEA2C3F68FD58FAFDA2951A058AF3D'
          
            'VCRUNTIME140_CLR0400.dll'#9'(0x727F0000)'#9'C:\WINDOWS\SYSTEM32\'#9'14.10' +
            '.25028.0'#9
          '12/7/2019 4:10:48 AM'#9'3454127B3FBE8C10D20FA288F37E7F72D9D1C00E'
          
            'fusion.dll'#9'(0x5CC20000)'#9'C:\Windows\Microsoft.NET\Framework\v4.0.' +
            '30319\'#9'4.8.4084.0'#9
          '12/7/2019 4:10:47 AM'#9'B8D05554D696AD8E509C0152811AD3A8F79E0178'
          
            'dbkdebugide280.bpl'#9'(0x202D0000)'#9'c:\program files (x86)\embarcade' +
            'ro\studio\22.0\Bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:38:44 PM'#9'983F93B5CAE57EB5B8905C12DA' +
            '784A78F4F5F4F5'
          
            'delphiwin32280.bpl'#9'(0x0E730000)'#9'c:\program files (x86)\embarcade' +
            'ro\studio\22.0\Bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:39:32 PM'#9'A3CE43B0B98C20ABD44104D1AF' +
            '38EE585043A1E5'
          
            'IDEWin32Platform280.bpl'#9'(0x0E750000)'#9'C:\Program Files (x86)\Emba' +
            'rcadero\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:40:14 PM'#9'4A53548DC2DF92B5EADD76F5EE' +
            'F559D36AB0CFFB'
          
            'fmx280.bpl'#9'(0x10790000)'#9'C:\Program Files (x86)\Embarcadero\Studi' +
            'o\22.0\bin\'#9
          
            '28.0.43310.7440'#9'11/10/2021 12:51:58 AM'#9'675C1FF4ECBEA619D4B7B83C3' +
            'B467B8E46718964'
          
            'd3d9.dll'#9'(0x5A260000)'#9'C:\WINDOWS\SYSTEM32\'#9'10.0.19041.2311'#9'12/20' +
            '/2022 5:48:19 AM'#9
          'E7C1BBEA14379441002BC525B221EB2F10838361'
          
            'dcc32280.dll'#9'(0x11390000)'#9'C:\Program Files (x86)\Embarcadero\Stu' +
            'dio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:42:54 PM'#9'B7CC4B8D4DDE93EAB581D7E738' +
            '2F1A4AAF1826D7'
          
            'dotnetcoreide280.bpl'#9'(0x22500000)'#9'c:\program files (x86)\embarca' +
            'dero\studio\22.0\Bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:39:36 PM'#9'A61A763BE50EF20498C2B1DD54' +
            '706A004280B1DA'
          
            'sxs.dll'#9'(0x6DF40000)'#9'C:\WINDOWS\SYSTEM32\'#9'10.0.19041.2364'#9'12/20/' +
            '2022 5:46:09 AM'#9
          '13E5C0C7BB14A491E1CA7ADB3888DCF1E0DD5234'
          
            'mscorlib.ni.dll'#9'(0x71050000)'#9'C:\WINDOWS\assembly\NativeImages_v4' +
            '.0.30319_32\mscorlib'
          
            '\a403a0b75e95c07da2caa7f780446a62\'#9'4.8.4515.0'#9'4/6/2022 12:35:22 ' +
            'AM'#9
          'F5714FCDFE4F79AF39444450208D4B43BABDACBD'
          
            'clrjit.dll'#9'(0x70FC0000)'#9'C:\Windows\Microsoft.NET\Framework\v4.0.' +
            '30319\'#9'4.8.4515.0'#9
          '4/6/2022 12:35:22 AM'#9'93C7D596E8798E477A2CD3C4D7DA2DC06403E4F8'
          
            'exceptiondiag280.bpl'#9'(0x52360000)'#9'c:\program files (x86)\embarca' +
            'dero\studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:39:46 PM'#9'C17EA6EDE678B47FB7EA346AF2' +
            'FD684D53C15415'
          
            'historyide280.bpl'#9'(0x20140000)'#9'c:\program files (x86)\embarcader' +
            'o\studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:40:04 PM'#9'DA4338D5191DEA2ED4FA4C1D22' +
            '16B96AE18F8D26'
          
            'htmlhelp1280.bpl'#9'(0x13D30000)'#9'c:\program files (x86)\embarcadero' +
            '\studio\22.0\Bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:40:06 PM'#9'595E4B0FF4CAACAA6D55430B1D' +
            'C99C4DB1FF66C0'
          
            'idefilefilters280.bpl'#9'(0x526B0000)'#9'c:\program files (x86)\embarc' +
            'adero\studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:40:08 PM'#9'B76B17AD63591054EC6AF5757E' +
            '1473FB5267F754'
          
            'projpageide280.bpl'#9'(0x116C0000)'#9'c:\program files (x86)\embarcade' +
            'ro\studio\22.0\Bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:40:32 PM'#9'230A5A6AF587845A597E0E1C0B' +
            'B181D4F21901E1'
          
            'WelcomePage.Plugin.CreateNew280.bpl'#9'(0x21710000)'#9'c:\program file' +
            's (x86)\embarcadero'
          '\studio\22.0\Bin\'#9'28.0.43310.7440'#9'11/10/2021 2:10:52 AM'#9
          '801F5C257FE76A11341A922C593548280AB2E431'
          
            'WelcomePageIDE280.bpl'#9'(0x216A0000)'#9'C:\Program Files (x86)\Embarc' +
            'adero\Studio\22.0\bin\'#9
          
            '28.0.43310.7440'#9'11/10/2021 2:10:52 AM'#9'944E5ACEDE6B757102D8693B2F' +
            '59D627C928E1C9'
          
            'WelcomePage.Plugin.GetItFeed280.bpl'#9'(0x21730000)'#9'c:\program file' +
            's (x86)\embarcadero'
          '\studio\22.0\Bin\'#9'28.0.43310.7440'#9'11/10/2021 2:10:52 AM'#9
          '57E241AE33E607648DBBC09F8CCBEDB3ECE473EA'
          
            'WelcomePage.Plugin.Learn280.bpl'#9'(0x21760000)'#9'c:\program files (x' +
            '86)\embarcadero\studio'
          '\22.0\Bin\'#9'28.0.43310.7440'#9'11/10/2021 2:10:52 AM'#9
          '4552552C9E5EB8A1155D1BFAA5080896E2FE2246'
          
            'WelcomePage.Plugin.OpenRecent280.bpl'#9'(0x21780000)'#9'c:\program fil' +
            'es (x86)\embarcadero'
          '\studio\22.0\Bin\'#9'28.0.43310.7440'#9'11/10/2021 2:10:52 AM'#9
          'CD402372E6E24AA948C8C3903DC74B31C4FF2E88'
          
            'tlbview280.bpl'#9'(0x52650000)'#9'c:\program files (x86)\embarcadero\s' +
            'tudio\22.0\Bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:40:40 PM'#9'8151D9A9BCE9F71EFDBDC03EED' +
            '7C159B3B069568'
          
            'tlib280.bpl'#9'(0x213B0000)'#9'C:\Program Files (x86)\Embarcadero\Stud' +
            'io\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:40:40 PM'#9'E567C73A4CE7C8122A25939BC5' +
            'C23B322C1DAB76'
          
            'IDELSP280.bpl'#9'(0x13E10000)'#9'c:\program files (x86)\embarcadero\st' +
            'udio\22.0\Bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:40:12 PM'#9'1E3842BC5CC4507678DE37F90D' +
            'ABAC7BCE53C06F'
          
            'comcore280.bpl'#9'(0x51EB0000)'#9'c:\program files (x86)\embarcadero\s' +
            'tudio\22.0\Bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:38:34 PM'#9'A78663FD47171A7B70716192EF' +
            '7C86A5B14EFE93'
          
            'projecttargets280.bpl'#9'(0x22270000)'#9'c:\program files (x86)\embarc' +
            'adero\studio\22.0\Bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:40:32 PM'#9'979A97A237C67DC2409E5DEFF0' +
            '2487E70DF2B770'
          
            'vclmenudesigner280.bpl'#9'(0x52560000)'#9'c:\program files (x86)\embar' +
            'cadero\studio\22.0\Bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:40:48 PM'#9'3FA2DF582ECF4672C3803DA9DD' +
            '4DE84B929BFD38'
          
            'comptoolbar280.bpl'#9'(0x527A0000)'#9'c:\program files (x86)\embarcade' +
            'ro\studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:38:34 PM'#9'0366ECBCD4B3DFAFCB42935088' +
            'E46C5A1B4400D6'
          
            'TrackingSystem280.bpl'#9'(0x116E0000)'#9'c:\program files (x86)\embarc' +
            'adero\studio\22.0\Bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:40:42 PM'#9'C96C7FD3129B7B3CEC4D96B307' +
            '98A99DA9569B1F'
          
            'unittestide280.bpl'#9'(0x21A50000)'#9'c:\program files (x86)\embarcade' +
            'ro\studio\22.0\Bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:40:42 AM'#9'F3ABA6F59B0EF40B01898BBAEE' +
            '82F2B3B95B722E'
          
            'gdbdebugcore280.bpl'#9'(0x13EC0000)'#9'c:\program files (x86)\embarcad' +
            'ero\studio\22.0\Bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:40:02 AM'#9'121CD6CA2CB29C1DDA6D38DF8D' +
            '76118A4D659A53'
          
            'DbxClientDriver280.bpl'#9'(0x52970000)'#9'C:\Program Files (x86)\Embar' +
            'cadero\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:38:46 AM'#9'75A654B1B2DB738A00F316183C' +
            '4AEB1E76EC45E4'
          
            'DbxCommonDriver280.bpl'#9'(0x529E0000)'#9'C:\Program Files (x86)\Embar' +
            'cadero\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:38:46 AM'#9'043E5CF6BA1AE897DA991E04B5' +
            '15D0717DAE572E'
          
            'profilemgride280.bpl'#9'(0x13F60000)'#9'C:\Program Files (x86)\Embarca' +
            'dero\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:40:30 AM'#9'15F4F12F521819F52ECDB313B8' +
            '187966890722AA'
          
            'paclientcore280.bpl'#9'(0x13FF0000)'#9'C:\Program Files (x86)\Embarcad' +
            'ero\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:40:30 AM'#9'49C6BE6085D9E7CA3F3C0ABC83' +
            '0360C36C713B7B'
          
            'CustomIPTransport280.bpl'#9'(0x14100000)'#9'C:\Program Files (x86)\Emb' +
            'arcadero\Studio'
          '\22.0\bin\'#9'28.0.42600.6491'#9'8/30/2021 10:38:36 PM'#9
          'C2E8F2DCBA0B31B9E57B74D54BA0AB4429DB6545'
          
            'DataSnapCommon280.bpl'#9'(0x14130000)'#9'C:\Program Files (x86)\Embarc' +
            'adero\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:38:40 AM'#9'A5B1514375EB28C38625E5C7E5' +
            'D25D19E71939CC'
          
            'DataSnapClient280.bpl'#9'(0x14170000)'#9'C:\Program Files (x86)\Embarc' +
            'adero\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:38:40 AM'#9'0D3C904C0CCE2750F3E3D6D683' +
            '69AAD1B974EF55'
          
            'gdbdebugide280.bpl'#9'(0x14210000)'#9'c:\program files (x86)\embarcade' +
            'ro\studio\22.0\Bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:40:02 AM'#9'982B313E98A6E899F4A2F259D9' +
            '2BB4D4AD078EB3'
          
            'ios32debugide280.bpl'#9'(0x14240000)'#9'c:\program files (x86)\embarca' +
            'dero\studio\22.0\Bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:40:18 AM'#9'8CE7A34ACACDC401FA364340E8' +
            'AF2277967BB43C'
          
            'win32debugide280.bpl'#9'(0x222C0000)'#9'C:\Program Files (x86)\Embarca' +
            'dero\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:40:56 PM'#9'37B73BC3093B6604F0CC72549D' +
            '6A3FC3D4E94F89'
          
            'ios64debugide280.bpl'#9'(0x13D80000)'#9'c:\program files (x86)\embarca' +
            'dero\studio\22.0\Bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:40:20 AM'#9'5F4B0C928B2C132756BF6854C2' +
            'C27489AF14DE77'
          
            'LivePreview280.bpl'#9'(0x14270000)'#9'c:\program files (x86)\embarcade' +
            'ro\studio\22.0\Bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:40:24 AM'#9'1E9F60BBA11283CB7AB62012D2' +
            '6F2AB7C7E6B4C4'
          
            'IndyProtocols280.bpl'#9'(0x51780000)'#9'C:\Program Files (x86)\Embarca' +
            'dero\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 7:12:50 PM'#9'62CEE6AA958BB14F1386AA6EAD4' +
            '8D3C23A22C5D0'
          
            'IndyCore280.bpl'#9'(0x51710000)'#9'C:\Program Files (x86)\Embarcadero\' +
            'Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 7:12:50 PM'#9'04CE78189AC7E2214E5FE80578D' +
            '48D2DF01F1DFB'
          
            'IndySystem280.bpl'#9'(0x51A20000)'#9'C:\Program Files (x86)\Embarcader' +
            'o\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 7:12:50 PM'#9'FA895BD983A73CD7CF5A07170D0' +
            '911F748E46058'
          
            'MirrorHub280.bpl'#9'(0x142F0000)'#9'C:\Program Files (x86)\Embarcadero' +
            '\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:40:24 AM'#9'E5E543B6BF19567007242B8B8A' +
            '917C2CA17F6392'
          
            'IndyIPClient280.bpl'#9'(0x14310000)'#9'C:\Program Files (x86)\Embarcad' +
            'ero\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:40:16 AM'#9'9F1F051D611E25C95DE99C2ECC' +
            '16284014EC5919'
          
            'tethering280.bpl'#9'(0x14330000)'#9'C:\Program Files (x86)\Embarcadero' +
            '\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:40:38 PM'#9'BB2EB36FE7A962CEA809BD3DDB' +
            '2A5F0BF32E43B6'
          
            'IndyIPCommon280.bpl'#9'(0x14490000)'#9'C:\Program Files (x86)\Embarcad' +
            'ero\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:40:16 AM'#9'34EB9B4CBA582F33F20D0875D0' +
            'A3E7AEF9D36A53'
          
            'IndyIPServer280.bpl'#9'(0x144B0000)'#9'C:\Program Files (x86)\Embarcad' +
            'ero\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:40:16 AM'#9'56A214350087FBFF7E03D9E3C0' +
            '697479C5264E87'
          
            'security.dll'#9'(0x46480000)'#9'C:\WINDOWS\SYSTEM32\'#9'10.0.19041.1'#9'12/7' +
            '/2019 4:09:30 AM'#9
          '463BFDC3A14B8C11AF9C204D65CD1C768A923ED3'
          
            'SECUR32.DLL'#9'(0x73470000)'#9'C:\WINDOWS\SYSTEM32\'#9'10.0.19041.546'#9'1/8' +
            '/2022 4:05:02 AM'#9
          '98667AE0AB2D955E69C365D62F2DD1A8C839E14E'
          
            'SSPICLI.DLL'#9'(0x730F0000)'#9'C:\WINDOWS\SYSTEM32\'#9'10.0.19041.2130'#9'10' +
            '/13/2022 4:04:06 AM'#9
          '3E18772B75026EEE3869863D1160B56D4D6B36B5'
          
            'codetemplates280.bpl'#9'(0x52750000)'#9'c:\program files (x86)\embarca' +
            'dero\studio\22.0\Bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:38:34 AM'#9'6519D609C465C69BD0A05A42FE' +
            'A18EC38CE6A3F3'
          
            'coreproide280.bpl'#9'(0x20270000)'#9'c:\program files (x86)\embarcader' +
            'o\studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:38:36 AM'#9'EEDD64E7F77A071F81137A31A7' +
            '055B0489E91656'
          
            'dbkdebugproide280.bpl'#9'(0x203C0000)'#9'c:\program files (x86)\embarc' +
            'adero\studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:38:44 AM'#9'9550D4200545A8AF7FE0D812FE' +
            '661F1F35FE1EB6'
          
            'profiledeployide280.bpl'#9'(0x144D0000)'#9'c:\program files (x86)\emba' +
            'rcadero\studio\22.0\Bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:40:30 AM'#9'FBF8929C5AC990D085E2F21789' +
            '5D805AF6DD4CEF'
          
            'sdkmgride280.bpl'#9'(0x14560000)'#9'c:\program files (x86)\embarcadero' +
            '\studio\22.0\Bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:40:34 AM'#9'7670BB650FF877EF885E32A154' +
            'C5F3ACE2A17C82'
          
            'refactoride280.bpl'#9'(0x20110000)'#9'c:\program files (x86)\embarcade' +
            'ro\studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:40:32 AM'#9'7AC815F96B4B8C2E1847E22085' +
            'B9C12082F9F434'
          
            'todoide280.bpl'#9'(0x21660000)'#9'c:\program files (x86)\embarcadero\s' +
            'tudio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:40:40 AM'#9'156B475125F22AD05D6D493E8A' +
            '97F39E956E4942'
          
            'vclhie280.bpl'#9'(0x51220000)'#9'C:\Program Files (x86)\Embarcadero\St' +
            'udio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:40:46 PM'#9'CF204B61E8493F098DC21C4BB3' +
            '9A2D373299C394'
          
            'DataExplorerIDE280.bpl'#9'(0x14640000)'#9'c:\program files (x86)\embar' +
            'cadero\studio\22.0\Bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:38:38 AM'#9'66A9D1DD85DF16BD80644F3CE1' +
            'FD1C2F4A02CB84'
          
            'VisualizationServiceIDE280.bpl'#9'(0x147A0000)'#9'c:\program files (x8' +
            '6)\embarcadero\studio'
          '\22.0\Bin\'#9'28.0.42600.6491'#9'8/31/2021 12:40:52 AM'#9
          'EEA3F0782AC18D75A3B0A07606245EF71D0512C2'
          
            'DeviceManager280.bpl'#9'(0x14820000)'#9'c:\program files (x86)\embarca' +
            'dero\studio\22.0\Bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:39:34 AM'#9'3590F50DD3CBC8F8AE36CA8C40' +
            'BCE292E1CA7F82'
          
            'fmxdesigner280.bpl'#9'(0x14860000)'#9'C:\Program Files (x86)\Embarcade' +
            'ro\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:40:00 AM'#9'E96AC831A767502FB57367F9EE' +
            '555317769F2EB6'
          
            'htmide280.bpl'#9'(0x201A0000)'#9'c:\program files (x86)\embarcadero\st' +
            'udio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:40:04 AM'#9'7F398F0BB2CBC92D0B3D7803EC' +
            '530BDBF4C94680'
          
            'MLCC280.bpl'#9'(0x51E20000)'#9'C:\Program Files (x86)\Embarcadero\Stud' +
            'io\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:40:26 AM'#9'B83A9A06B085B2824024FF78D8' +
            '0C9A3C3F0AC6EA'
          
            'HTMLDlgs280.bpl'#9'(0x21A20000)'#9'C:\Program Files (x86)\Embarcadero\' +
            'Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:40:04 AM'#9'E0AC6007C618CCCFF17F36EA31' +
            '7619E5E9F4D19A'
          
            'iteidew32280.bpl'#9'(0x20020000)'#9'c:\program files (x86)\embarcadero' +
            '\studio\22.0\Bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:40:22 AM'#9'E7C58EC843FCC015E9AD99838A' +
            '9C344A8476BF1C'
          
            'itecore280.bpl'#9'(0x21560000)'#9'C:\Program Files (x86)\Embarcadero\S' +
            'tudio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:40:20 AM'#9'4F4A17075A8DAD39A38F04FFC4' +
            '4F9A78EDA75AE4'
          
            'iteide280.bpl'#9'(0x214D0000)'#9'C:\Program Files (x86)\Embarcadero\St' +
            'udio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:40:22 AM'#9'EB35149DF19B1EDB84AB8BED00' +
            'E9EF45852B59FB'
          
            'tgide280.bpl'#9'(0x200C0000)'#9'c:\program files (x86)\embarcadero\stu' +
            'dio\22.0\Bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:40:40 AM'#9'BC3F398A2B83269D9BCE0B46C0' +
            'BA8EEAD98C61C5'
          
            'win64debugide280.bpl'#9'(0x15ED0000)'#9'c:\program files (x86)\embarca' +
            'dero\studio\22.0\Bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:40:56 AM'#9'25062D534F3A1F0EB60F6C76A9' +
            'A7FC068B2F1749'
          
            'delphiwin64280.bpl'#9'(0x15F50000)'#9'c:\program files (x86)\embarcade' +
            'ro\studio\22.0\Bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:39:32 AM'#9'843FC55B47768995A52A44CAA4' +
            '04D7A4CA2A20AA'
          
            'IDEWin64Platform280.bpl'#9'(0x15F70000)'#9'C:\Program Files (x86)\Emba' +
            'rcadero\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:40:14 PM'#9'E1272C37D5CD7186B6B1EDE03C' +
            'D5E32B11277AE8'
          
            'dcc64280.dll'#9'(0x160B0000)'#9'C:\Program Files (x86)\Embarcadero\Stu' +
            'dio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:42:54 AM'#9'3EB6DE1D05125DF81648611E1F' +
            'BB901CEA81A1DE'
          
            'linux64debugide280.bpl'#9'(0x16550000)'#9'c:\program files (x86)\embar' +
            'cadero\studio\22.0\Bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:40:22 AM'#9'223FFA8795D7E805DD738C576E' +
            'E799D8A870F903'
          
            'delphilinux64280.bpl'#9'(0x14D10000)'#9'c:\program files (x86)\embarca' +
            'dero\studio\22.0\Bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:39:30 AM'#9'54B114D520F49B610802A6A4EB' +
            'B3CC872E192A78'
          
            'IDELinux64Platform280.bpl'#9'(0x14D30000)'#9'C:\Program Files (x86)\Em' +
            'barcadero\Studio'
          '\22.0\bin\'#9'28.0.42600.6491'#9'8/31/2021 12:40:10 AM'#9
          'A79C069F02CD5C3ADC3F490D9A6A0F9BB9935FA3'
          
            'dcclinux64280.dll'#9'(0x14D50000)'#9'C:\Program Files (x86)\Embarcader' +
            'o\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:43:00 AM'#9'4E2E534F7CDA79A5F1C665A143' +
            'ACD361A8EC05AD'
          
            'compllvm.dll'#9'(0x58D50000)'#9'C:\Program Files (x86)\Embarcadero\Stu' +
            'dio\22.0\bin\'#9
          '8/31/2021 12:42:46 AM'#9'7E9BCD738C2F32E685CEF86B833C0259EBDB585A'
          
            'dbghelp.dll'#9'(0x740A0000)'#9'C:\WINDOWS\SYSTEM32\'#9'10.0.19041.1052'#9'1/' +
            '8/2022 4:04:58 AM'#9
          '6745ECBC77A2F9619AA757D91DE78390A5F3FB44'
          
            'win32debugproide280.bpl'#9'(0x22290000)'#9'c:\program files (x86)\emba' +
            'rcadero\studio\22.0\Bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:40:56 AM'#9'87451C43605A02B4B0D82F05CA' +
            'FE77ED79E2556D'
          
            'delphipro280.bpl'#9'(0x51DD0000)'#9'c:\program files (x86)\embarcadero' +
            '\studio\22.0\Bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:39:32 AM'#9'4682CE4969C257FA0D1C790B05' +
            '8E52E6F5254DF0'
          
            'codequerydelphi280.bpl'#9'(0x15090000)'#9'c:\program files (x86)\embar' +
            'cadero\studio\22.0\Bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:38:32 AM'#9'8D1BEA69623E935D32ED0CF249' +
            'F5C641EE235BB1'
          
            'delphicompro280.bpl'#9'(0x521A0000)'#9'c:\program files (x86)\embarcad' +
            'ero\studio\22.0\Bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:39:24 AM'#9'992A0F900E7C1CF56C6CA83617' +
            '79481BA33F4A83'
          
            'delphide280.bpl'#9'(0x22300000)'#9'c:\program files (x86)\embarcadero\' +
            'studio\22.0\Bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:39:26 AM'#9'6CAFC38C35FEFF2D03F8CC5EC0' +
            '58BDF59CD46164'
          
            'mswsock.dll'#9'(0x742C0000)'#9'C:\WINDOWS\system32\'#9'10.0.19041.546'#9'1/8' +
            '/2022 4:04:57 AM'#9
          '8ACD6BED9113D021C60ED490E9842E247992C237'
          
            'delphicoreproide280.bpl'#9'(0x51E80000)'#9'c:\program files (x86)\emba' +
            'rcadero\studio\22.0\Bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:39:26 AM'#9'31B5210157AB22E5431618320F' +
            '5CAC43E2F9E5DE'
          
            'delphierrorinsite280.bpl'#9'(0x22250000)'#9'c:\program files (x86)\emb' +
            'arcadero\studio'
          '\22.0\Bin\'#9'28.0.42600.6491'#9'8/31/2021 12:39:28 AM'#9
          '2881FA27EEBE2FB1A7C443D20CF96FE5C0313BE3'
          
            'delphivclide280.bpl'#9'(0x22490000)'#9'c:\program files (x86)\embarcad' +
            'ero\studio\22.0\Bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:39:32 AM'#9'3B3EC32D376A05D986F3866E94' +
            'C2C8349ACD6402'
          
            'delphicoment280.bpl'#9'(0x526F0000)'#9'c:\program files (x86)\embarcad' +
            'ero\studio\22.0\Bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:39:24 AM'#9'54EA5DEEF1B88C9ABDA357EEB0' +
            '3C4F5006E7AAF2'
          
            'comentcore280.bpl'#9'(0x526D0000)'#9'C:\Program Files (x86)\Embarcader' +
            'o\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:38:34 AM'#9'8AC040BDBDDCFD2E7269006891' +
            '612CE62EDFDDAE'
          
            'delphifmxmobile280.bpl'#9'(0x15550000)'#9'c:\program files (x86)\embar' +
            'cadero\studio\22.0\Bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:39:28 AM'#9'EF067671462530E0D00F890DB0' +
            '831F235FD47FF8'
          
            'delphifmxide280.bpl'#9'(0x155B0000)'#9'c:\program files (x86)\embarcad' +
            'ero\studio\22.0\Bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:39:28 AM'#9'58182C892B838CA89F59756733' +
            '51A0C4401B1419'
          
            'napinsp.dll'#9'(0x6FE20000)'#9'C:\WINDOWS\system32\'#9'10.0.19041.546'#9'1/8' +
            '/2022 4:04:48 AM'#9
          '27A2455EDAAC57A345814C5024C7E520A233626B'
          
            'pnrpnsp.dll'#9'(0x6FE00000)'#9'C:\WINDOWS\system32\'#9'10.0.19041.546'#9'1/8' +
            '/2022 4:05:30 AM'#9
          'DD7B08BE5FC407467EE82740162AD5188DE082E2'
          
            'wshbth.dll'#9'(0x6FDF0000)'#9'C:\WINDOWS\system32\'#9'10.0.19041.546'#9'1/8/' +
            '2022 4:04:55 AM'#9
          '0451F6A6888BDE69A25D30863DF52E6E6EC678D7'
          
            'NLAapi.dll'#9'(0x6FDD0000)'#9'C:\WINDOWS\system32\'#9'10.0.19041.546'#9'1/8/' +
            '2022 4:05:01 AM'#9
          '775DCC761FF9F9346E2362EC8CAF5445A0BC9C34'
          
            'DNSAPI.dll'#9'(0x6FF60000)'#9'C:\WINDOWS\SYSTEM32\'#9'10.0.19041.1865'#9'8/1' +
            '0/2022 1:48:07 PM'#9
          '617EABEF3F4778D16E2106AB9245F75B81A222A1'
          
            'winrnr.dll'#9'(0x6FDC0000)'#9'C:\WINDOWS\System32\'#9'10.0.19041.546'#9'1/8/' +
            '2022 4:04:59 AM'#9
          '9689FF4F63BCABBB0076B55B332CFECDB01804F7'
          
            'fwpuclnt.dll'#9'(0x74330000)'#9'C:\WINDOWS\System32\'#9'10.0.19041.1682'#9'5' +
            '/11/2022 10:12:15 AM'#9
          '31DA2C509EC22581022130EE230D4EB03E2C0529'
          
            'rasadhlp.dll'#9'(0x665D0000)'#9'C:\Windows\System32\'#9'10.0.19041.546'#9'1/' +
            '8/2022 4:05:03 AM'#9
          '5D93DBCA028162C1E157BCE7F4B99D8F806CA2B5'
          
            'thumbcache.dll'#9'(0x584D0000)'#9'C:\Windows\System32\'#9'10.0.19041.1466' +
            #9'1/8/2022 4:04:49 AM'#9
          '8D8321E0C142069E2D343E2C7607AA5DCE56E4D2'
          
            'dataexchange.dll'#9'(0x6E6D0000)'#9'C:\WINDOWS\system32\'#9'10.0.19041.13' +
            '87'#9'1/8/2022 '
          '4:04:48 AM'#9'DF4060212D3D3377896AEEDF7235E8CCAB4E562E'
          
            'dcomp.dll'#9'(0x614A0000)'#9'C:\WINDOWS\system32\'#9'10.0.19041.2075'#9'10/1' +
            '3/2022 4:05:21 AM'#9
          '337E3354CD8B736176D99920E8E9F699302347E6'
          
            'd3d11.dll'#9'(0x69DF0000)'#9'C:\WINDOWS\system32\'#9'10.0.19041.2075'#9'10/1' +
            '3/2022 4:05:05 AM'#9
          '4764D5A386809B8BA3AAF8DCBD51FE7F0FB3839A'
          
            'dxgi.dll'#9'(0x6A210000)'#9'C:\WINDOWS\system32\'#9'10.0.19041.2311'#9'12/20' +
            '/2022 5:47:43 AM'#9
          'E81EA55263A1354EFE59ECE279F192C34B0B7CC2'
          
            'twinapi.appcore.dll'#9'(0x6DC30000)'#9'C:\WINDOWS\system32\'#9'10.0.19041' +
            '.1865'#9'8/10/2022 '
          '1:48:06 PM'#9'5FF14DBE50B20CFD6184587E3AA375A90F953D1D'
          
            'boreditu.dll'#9'(0x21FB0000)'#9'C:\Program Files (x86)\Embarcadero\Stu' +
            'dio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:42:32 PM'#9'3410F9FDC61D0A3E4828D6E4FB' +
            'E287C54CACBEA0'
          
            'Scooter.BeyondCompare.Expert.dll'#9'(0x19540000)'#9'c:\program files (' +
            'x86)\embarcadero'
          '\studio\22.0\Bin\'#9'28.0.42400.6372'#9'8/14/2021 2:53:38 AM'#9
          '02B47DB4BFF7D4390A52CA1B25A2C53F27F18922'
          
            'CSRadStudioTools280.dll'#9'(0x19890000)'#9'C:\Program Files (x86)\Raiz' +
            'e\CS5\Bin\'#9'5.4.0.0'#9
          '9/8/2021 5:00:00 AM'#9'AA1EF6454E3AC6EB335ACFC9E0D559DD9DBC3351'
          
            'virtdisk.dll'#9'(0x6D9F0000)'#9'C:\WINDOWS\SYSTEM32\'#9'10.0.19041.2311'#9'1' +
            '2/20/2022 5:48:03 AM'#9
          '4C80DA0FFACC1558B1CFB09444B2FB202E798528'
          
            'FLTLIB.DLL'#9'(0x6A820000)'#9'C:\WINDOWS\SYSTEM32\'#9'10.0.19041.546'#9'1/8/' +
            '2022 4:04:59 AM'#9
          'F280639FF89F06CD699F1D97E877436D3ECBD165'
          
            'System.ni.dll'#9'(0x70560000)'#9'C:\WINDOWS\assembly\NativeImages_v4.0' +
            '.30319_32\System'
          
            '\920e3d1d70447c3c10e69e6df0766568\'#9'4.8.4536.0'#9'12/20/2022 6:31:41' +
            ' AM'#9
          'C0798C93DE69594551645530D38F86267FC7B452'
          'System.Xml.ni.dll'#9'(0x54A50000)'#9'C:\WINDOWS\assembly'
          
            '\NativeImages_v4.0.30319_32\System.Xml\2062ed810929ec0e33254c02b' +
            '0c61bb4\'#9'4.8.4084.0'#9
          '12/20/2022 6:33:41 AM'#9'C9E9FE11D5AD642633011491B6C63A024CDA086B'
          'System.Core.ni.dll'#9'(0x54230000)'#9'C:\WINDOWS\assembly'
          
            '\NativeImages_v4.0.30319_32\System.Core\45a9a2a2deda365165595326' +
            'f2f13be6\'#9'4.8.4590.0'#9
          '12/20/2022 6:32:06 AM'#9'CD759FA0CEEEFAD9B14244CD756D50C3C17AEC60'
          'System.Configuration.ni.dll'#9'(0x58C40000)'#9'C:\WINDOWS\assembly'
          
            '\NativeImages_v4.0.30319_32\System.Configuration\bf1f4d743828bbf' +
            '720baf57f6a37ce02\'#9
          
            '4.8.4190.0'#9'12/20/2022 6:33:04 AM'#9'BE8A1FEB230833A654FD0D4B0F4C594' +
            '376C42827'
          
            'tiptsf.dll'#9'(0x606A0000)'#9'C:\Program Files (x86)\Common Files\micr' +
            'osoft shared\ink\'#9
          
            '10.0.19041.746'#9'1/8/2022 4:05:28 AM'#9'346A8C7357B3DA6F1E8AEB745210E' +
            '50375921817'
          
            'IdnDL.dll'#9'(0x5D950000)'#9'C:\WINDOWS\SYSTEM32\'#9'10.0.19041.1'#9'12/7/20' +
            '19 4:09:29 AM'#9
          '1A9BFDB90B9FDA76CC501254247B2135ECC40665'
          
            'Normaliz.dll'#9'(0x75340000)'#9'C:\WINDOWS\System32\'#9'10.0.19041.546'#9'1/' +
            '8/2022 4:04:59 AM'#9
          '33C3EF19FB6C4B85B6E7625AE20694E494F04637'
          
            'dhcpcsvc6.DLL'#9'(0x6FFF0000)'#9'C:\WINDOWS\SYSTEM32\'#9'10.0.19041.2130'#9 +
            '10/13/2022 4:05:23 AM'#9
          '9D9FBA0516DF93FC3B91A60FB5F4AA2FBEC51FE6'
          
            'dhcpcsvc.DLL'#9'(0x70010000)'#9'C:\WINDOWS\SYSTEM32\'#9'10.0.19041.2130'#9'1' +
            '0/13/2022 4:05:23 AM'#9
          '01FC491884E3BD82DCF671CAD692B43239252137'
          'System.Windows.Forms.ni.dll'#9'(0x533A0000)'#9'C:\WINDOWS\assembly'
          
            '\NativeImages_v4.0.30319_32\System.Windows.Forms\c0a9c626d91460a' +
            '624ac1a5f89f0b4a8\'#9
          
            '4.8.4550.0'#9'12/22/2022 8:30:03 AM'#9'332062D884AE5D5971582EDCD732697' +
            '850EFACD7'
          'System.Design.ni.dll'#9'(0x1D410000)'#9'C:\WINDOWS\assembly'
          
            '\NativeImages_v4.0.30319_32\System.Design\adc3061c4b3b52adf3d505' +
            '6e19e19798\'#9'4.8.4084.0'#9
          '12/22/2022 8:30:23 AM'#9'831E26F0B6EE53491DEE2BC35DC1957030445CCD'
          'System.Drawing.ni.dll'#9'(0x58A90000)'#9'C:\WINDOWS\assembly'
          
            '\NativeImages_v4.0.30319_32\System.Drawing\fe4f7fb577b398b290c2d' +
            '5d25fed0ad8\'#9'4.8.4390.0'#9
          '8/24/2022 7:53:47 AM'#9'CB1920AF94CAD9914C75C43C43DF65D4CF2613F7'
          
            'msxml3.dll'#9'(0x58850000)'#9'C:\WINDOWS\System32\'#9'8.110.19041.844'#9'1/8' +
            '/2022 4:05:01 AM'#9
          '5E71B84E18A39BDD0F546CCF679C808E5DFFF4E6'
          
            'dclxml280.bpl'#9'(0x0DA20000)'#9'c:\program files (x86)\embarcadero\st' +
            'udio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:39:22 PM'#9'E6DA0E149788206C4E47A3D774' +
            'B5B2B0DDFD7DBA'
          
            'gitide280.bpl'#9'(0x0DA30000)'#9'c:\program files (x86)\embarcadero\st' +
            'udio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:40:04 PM'#9'6A7B854D377A15427F3EC3EE29' +
            '521FF824C856D7'
          
            'hgide280.bpl'#9'(0x0DAE0000)'#9'c:\program files (x86)\embarcadero\stu' +
            'dio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:40:04 PM'#9'64ADB15A17BDC044011BF0FABB' +
            '8DF8CE87D7ED59'
          
            'svnide280.bpl'#9'(0x1B9A0000)'#9'c:\program files (x86)\embarcadero\st' +
            'udio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:40:38 PM'#9'90D2304DD15C120FB073EE90E6' +
            '1DD5191C5397F0'
          
            'svnui280.bpl'#9'(0x1E6B0000)'#9'C:\Program Files (x86)\Embarcadero\Stu' +
            'dio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:40:38 PM'#9'3E302CC7B026D3D1B0FA0D6D8E' +
            '63996FC993F5EF'
          
            'svn280.bpl'#9'(0x1E740000)'#9'C:\Program Files (x86)\Embarcadero\Studi' +
            'o\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:40:38 PM'#9'96FB75B0525AEEFB99A61CE5A6' +
            '280A2DDC301D05'
          
            'dclbindcomp280.bpl'#9'(0x1E8E0000)'#9'c:\program files (x86)\embarcade' +
            'ro\studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:38:52 PM'#9'D6178A769EF507687DE873A4B2' +
            '9B3D0FCFC51B96'
          
            'bindcomp280.bpl'#9'(0x1EC00000)'#9'C:\Program Files (x86)\Embarcadero\' +
            'Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:38:26 PM'#9'68EEFE9272AC18AA50E4EF56D6' +
            'C8B32D13A18ADC'
          
            'ExpertsUI280.bpl'#9'(0x1EE30000)'#9'C:\Program Files (x86)\Embarcadero' +
            '\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:39:46 PM'#9'5E8C5285C1C947FAB278B55CC9' +
            '07F9FEB8175733'
          
            'dclcommon280.bpl'#9'(0x1EE80000)'#9'C:\Program Files (x86)\Embarcadero' +
            '\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:38:54 PM'#9'61876FDDAD4F6CB753F2B65153' +
            'B44FA6727706BA'
          
            'dclbindcompfmx280.bpl'#9'(0x1EF80000)'#9'c:\program files (x86)\embarc' +
            'adero\studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:38:54 PM'#9'71A8C92277DD71EF392976DCA8' +
            '79580CF4D482D2'
          
            'bindcompfmx280.bpl'#9'(0x1EFC0000)'#9'C:\Program Files (x86)\Embarcade' +
            'ro\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:38:28 PM'#9'E31F4F432B8087EE7179767BD6' +
            '8025E4B950EF32'
          
            'dclrtl280.bpl'#9'(0x1F0B0000)'#9'c:\program files (x86)\embarcadero\st' +
            'udio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:39:16 PM'#9'D00563B49AB057A55E65741BA4' +
            '1C7056FC300D20'
          
            'dcltethering280.bpl'#9'(0x1F110000)'#9'c:\program files (x86)\embarcad' +
            'ero\studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:39:20 PM'#9'BC7DB4E74384C9607963B53106' +
            '06F6D4C022C0C6'
          
            'dclact280.bpl'#9'(0x22FE0000)'#9'c:\program files (x86)\embarcadero\st' +
            'udio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:38:50 PM'#9'4600A41EEED932E30A5464A749' +
            'B824CCB916D8F3'
          
            'dcldb280.bpl'#9'(0x22CC0000)'#9'c:\program files (x86)\embarcadero\stu' +
            'dio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:39:00 PM'#9'E59D4B51DBCE24925B0506879E' +
            '175826DE83EB9B'
          
            'vcldb280.bpl'#9'(0x51AC0000)'#9'C:\Program Files (x86)\Embarcadero\Stu' +
            'dio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:40:44 PM'#9'23720D9A0E0C74A49617F31933' +
            '21CCD4849C54E3'
          
            'dclstd280.bpl'#9'(0x1F160000)'#9'C:\Program Files (x86)\Embarcadero\St' +
            'udio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:39:20 PM'#9'D3D355F557AB92798583860912' +
            'A46FF09320BE86'
          
            'dclemacsedit280.bpl'#9'(0x22FC0000)'#9'c:\program files (x86)\embarcad' +
            'ero\studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:39:02 PM'#9'025E17910BE88373A2F778C45A' +
            'B6AD0C11EA56B7'
          
            'dclmlwiz280.bpl'#9'(0x233B0000)'#9'c:\program files (x86)\embarcadero\' +
            'studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:39:12 PM'#9'170AFB84AA97161ED6F0DD40F9' +
            '14AB4D5FF532BC'
          
            'dclQuickEdit280.bpl'#9'(0x1F280000)'#9'c:\program files (x86)\embarcad' +
            'ero\studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:39:14 PM'#9'F5E3B8FF23BADE38B85DC4FD1A' +
            'BD2E0F7A87FA54'
          
            'dclshare280.bpl'#9'(0x1F2B0000)'#9'c:\program files (x86)\embarcadero\' +
            'studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:39:16 PM'#9'DA9FBCB3B06320F0B7849E840D' +
            'E705032594169A'
          
            'dclwinx280.bpl'#9'(0x1F2E0000)'#9'c:\program files (x86)\embarcadero\s' +
            'tudio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:39:22 PM'#9'00217AA826CD1D6E988F55D431' +
            '4222AAF87367EF'
          
            'samplevisualizers280.bpl'#9'(0x1F350000)'#9'c:\program files (x86)\emb' +
            'arcadero\studio'
          '\22.0\bin\'#9'28.0.42600.6491'#9'8/30/2021 10:40:34 PM'#9
          'B7826670B4D2899A61D40A13A5BC09A57D1ED612'
          
            'applet280.bpl'#9'(0x52340000)'#9'c:\program files (x86)\embarcadero\st' +
            'udio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:37:42 PM'#9'E6862CE7B7DC8F205AC50D2CE0' +
            '9459728BA3D404'
          
            'dclappanalytics280.bpl'#9'(0x1E580000)'#9'c:\program files (x86)\embar' +
            'cadero\studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:38:52 PM'#9'635751AA3A0943AAF37C47808A' +
            'CF228F35C54D5D'
          
            'appanalytics280.bpl'#9'(0x1F380000)'#9'C:\Program Files (x86)\Embarcad' +
            'ero\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:37:40 PM'#9'8CE6F54E7E0F09AC39F1FFBA87' +
            'C579785ED03BE6'
          
            'dclbindcompvcl280.bpl'#9'(0x1F3A0000)'#9'c:\program files (x86)\embarc' +
            'adero\studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:38:54 PM'#9'B737E623154DDA8BDA91CAC06B' +
            'BB8E7FB737D4EB'
          
            'bindcompvclwinx280.bpl'#9'(0x1F3C0000)'#9'C:\Program Files (x86)\Embar' +
            'cadero\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:38:30 PM'#9'61B5C9C9ECD80545E8C65DED93' +
            '1047DF414C221E'
          
            'bindcompvcl280.bpl'#9'(0x1F3E0000)'#9'C:\Program Files (x86)\Embarcade' +
            'ro\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:38:28 PM'#9'4CC8D76D190447EF93C26C79B1' +
            '481F66A6FC5AFB'
          
            'bindcompvclsmp280.bpl'#9'(0x1E590000)'#9'C:\Program Files (x86)\Embarc' +
            'adero\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:38:28 PM'#9'8B5EDA64D5747BC9B08ECB0250' +
            '1A55A666D1263A'
          
            'VclSmp280.bpl'#9'(0x1F430000)'#9'C:\Program Files (x86)\Embarcadero\St' +
            'udio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:40:50 PM'#9'7DE38C9E8BB80B902788A1DD2C' +
            'F871B1C248BA17'
          
            'dclmid280.bpl'#9'(0x22F10000)'#9'c:\program files (x86)\embarcadero\st' +
            'udio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:39:10 PM'#9'ADE7C3469EEB692D4C4938C846' +
            '4D67F0C3BA8027'
          
            'dsnap280.bpl'#9'(0x51330000)'#9'C:\Program Files (x86)\Embarcadero\Stu' +
            'dio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:39:36 PM'#9'63EAC4F939F908015BC9F2CC83' +
            'C7B519C6A071FB'
          
            'vcldsnap280.bpl'#9'(0x1F450000)'#9'C:\Program Files (x86)\Embarcadero\' +
            'Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:40:46 PM'#9'D5F64C6479B986DB9C09DE70BE' +
            '7CD090D6A56BE4'
          
            'dclnetwiz280.bpl'#9'(0x1F470000)'#9'c:\program files (x86)\embarcadero' +
            '\studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:39:14 PM'#9'9965451D25980247118A655DDF' +
            '688B000BE0F23E'
          
            'dclnet280.bpl'#9'(0x23130000)'#9'C:\Program Files (x86)\Embarcadero\St' +
            'udio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:39:12 PM'#9'E22BDEA96FFC65699E23E3240D' +
            'EF2A8723FD5446'
          
            'ExpertsCreators280.bpl'#9'(0x1F480000)'#9'C:\Program Files (x86)\Embar' +
            'cadero\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:39:46 PM'#9'00FEC9143901310984DF5698A9' +
            'BA5AC459A073B6'
          
            'dclvcldb280.bpl'#9'(0x1F4C0000)'#9'c:\program files (x86)\embarcadero\' +
            'studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:39:20 PM'#9'C0D725F89CD95017D4934311FF' +
            'B50BF0FF7E1D40'
          
            'dcl31w280.bpl'#9'(0x23020000)'#9'c:\program files (x86)\embarcadero\st' +
            'udio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:38:50 PM'#9'6FB08A674ED69BE5CA151AA30A' +
            'A83172966FD190'
          
            'dclsmp280.bpl'#9'(0x1F620000)'#9'c:\program files (x86)\embarcadero\st' +
            'udio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:39:18 PM'#9'A5E3600C51761242A6490E60A0' +
            '2399EC5E46D5C2'
          
            'dclsmpedit280.bpl'#9'(0x22FA0000)'#9'c:\program files (x86)\embarcader' +
            'o\studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:39:18 PM'#9'0D2B359C4EDF1D7767312DF672' +
            '024993E1AF8CD3'
          
            'dcltouch280.bpl'#9'(0x1F640000)'#9'c:\program files (x86)\embarcadero\' +
            'studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:39:20 PM'#9'116FCBEF8959D44A5C9E0EECF7' +
            'C58F7DFF8CA651'
          
            'vcltouch280.bpl'#9'(0x23050000)'#9'C:\Program Files (x86)\Embarcadero\' +
            'Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:40:52 PM'#9'60F87E81CFDC7E4415B3957BC6' +
            '3D58F04CF94F4D'
          
            'DUnitXIDEExpert280.bpl'#9'(0x1F6A0000)'#9'c:\program files (x86)\embar' +
            'cadero\studio\22.0\bin\'#9
          
            '15.0.3691.27788'#9'8/31/2021 12:39:40 AM'#9'81828AB4D635EF1AF108302324' +
            'E7D4B4B42D662B'
          
            'dclFMXtee9280.bpl'#9'(0x1F6C0000)'#9'c:\program files (x86)\embarcader' +
            'o\studio\22.0\bin\'#9
          
            '1.0.0.0'#9'8/30/2021 6:42:16 PM'#9'FB2F29C2893B2841B5AFFCEA91A8BB6467E' +
            '9FA42'
          
            'FmxTeeUI9280.bpl'#9'(0x231F0000)'#9'C:\Program Files (x86)\Embarcadero' +
            '\Studio\22.0\bin\'#9
          
            '9.0.1.0'#9'8/30/2021 6:31:40 PM'#9'F1D7866C294CA5D8EB1FBEE5F02CAA4DEE0' +
            '4AE42'
          
            'FMXTee9280.bpl'#9'(0x233D0000)'#9'C:\Program Files (x86)\Embarcadero\S' +
            'tudio\22.0\bin\'#9
          
            '9.0.1.0'#9'8/30/2021 6:31:38 PM'#9'CB9F5339573AB520B05B3EC4456F0CBEDAF' +
            '06B89'
          
            'dcltee9280.bpl'#9'(0x42600000)'#9'c:\program files (x86)\embarcadero\s' +
            'tudio\22.0\bin\'#9
          
            '9.0.1.0'#9'8/30/2021 6:42:16 PM'#9'764BC240C76C334354AB1FAFAAD1FA84562' +
            '5D6D7'
          
            'Tee9280.bpl'#9'(0x42200000)'#9'C:\Program Files (x86)\Embarcadero\Stud' +
            'io\22.0\bin\'#9
          
            '9.0.1.0'#9'8/30/2021 6:30:28 PM'#9'DE49370CB1F94B1CE63ED735580FF481CC6' +
            '08578'
          
            'TeeDB9280.bpl'#9'(0x42400000)'#9'C:\Program Files (x86)\Embarcadero\St' +
            'udio\22.0\bin\'#9
          
            '9.0.1.0'#9'8/30/2021 6:30:34 PM'#9'43D1CE0BC42C0E63AE07146F4753DCD0D2A' +
            '21CF8'
          
            'TeeUI9280.bpl'#9'(0x23540000)'#9'C:\Program Files (x86)\Embarcadero\St' +
            'udio\22.0\bin\'#9
          
            '9.0.1.0'#9'8/30/2021 6:30:34 PM'#9'85F4C73485039BAF546508A36B6484D435F' +
            'C8145'
          
            'dclbcbsmp280.bpl'#9'(0x1F6F0000)'#9'c:\program files (x86)\embarcadero' +
            '\studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:38:52 AM'#9'EFCC23DD2C61DEC24289BE9600' +
            '59371E78D9D817'
          
            'CC32280MT.DLL'#9'(0x321C0000)'#9'C:\Program Files (x86)\Embarcadero\St' +
            'udio\22.0\bin\'#9
          
            '1.192.0.0'#9'8/31/2021 12:55:40 AM'#9'7BEC854E8897977BDE93E02822AEE286' +
            '2EA9BF33'
          
            'bcbsmp280.bpl'#9'(0x22D40000)'#9'C:\Program Files (x86)\Embarcadero\St' +
            'udio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:38:24 AM'#9'BA2C2DA99EF9A274418F0DE8BC' +
            '8D623AE237E771'
          
            'bcbie280.bpl'#9'(0x22E90000)'#9'c:\program files (x86)\embarcadero\stu' +
            'dio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:38:20 AM'#9'7666798B8B0064A660150D18CB' +
            'F29452EC1AD0CE'
          
            'MobileWizardExpert280.bpl'#9'(0x22D70000)'#9'c:\program files (x86)\em' +
            'barcadero\studio'
          '\22.0\bin\'#9'28.0.42600.6491'#9'8/31/2021 12:40:26 AM'#9
          '01AF0173B8562C609C54D1E4CFDF1BE286C80309'
          
            'DataExplorerService280.bpl'#9'(0x22EC0000)'#9'c:\program files (x86)\e' +
            'mbarcadero\studio'
          '\22.0\bin\'#9'28.0.42600.6491'#9'8/31/2021 12:38:38 AM'#9
          '9D5A3DCA2DD89C911EA3F7BEB49D16171D655458'
          
            'dclDBXDrivers280.bpl'#9'(0x1F710000)'#9'c:\program files (x86)\embarca' +
            'dero\studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:39:00 AM'#9'0BE9E9FE7B6D40104F715EA5A6' +
            '47FB7CEEF9FA0B'
          
            'DBXMySQLDriver280.bpl'#9'(0x52C70000)'#9'C:\Program Files (x86)\Embarc' +
            'adero\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:38:48 AM'#9'E6D1C789363A95B422C93F077E' +
            '7C8D071C8D1BC5'
          
            'dbexpress280.bpl'#9'(0x51CE0000)'#9'C:\Program Files (x86)\Embarcadero' +
            '\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:38:44 AM'#9'D13680E8B3C3780A9408323F82' +
            '961994A67B71D7'
          
            'DBXSqliteDriver280.bpl'#9'(0x22EE0000)'#9'C:\Program Files (x86)\Embar' +
            'cadero\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:38:50 AM'#9'6A9ECA16D4640E214D34A9A9A0' +
            '810FC520DC060E'
          
            'dclDBXDriversInt280.bpl'#9'(0x22CB0000)'#9'c:\program files (x86)\emba' +
            'rcadero\studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:39:02 AM'#9'617EC477530A5D29F82542679B' +
            'C90F80B982ACA5'
          
            'DBXInterBaseDriver280.bpl'#9'(0x52C20000)'#9'C:\Program Files (x86)\Em' +
            'barcadero\Studio'
          '\22.0\bin\'#9'28.0.42600.6491'#9'8/31/2021 12:38:48 AM'#9
          'B116FA9A37410A038B48AE7BFEB6300ED7C88FE6'
          
            'dclIPIndyImpl280.bpl'#9'(0x22F60000)'#9'c:\program files (x86)\embarca' +
            'dero\studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:39:10 AM'#9'156331B2C44DFD78D928D8DEC6' +
            '5EEDA32D105166'
          
            'dclRESTBackendComponents280.bpl'#9'(0x230F0000)'#9'c:\program files (x' +
            '86)\embarcadero\studio'
          '\22.0\bin\'#9'28.0.42600.6491'#9'8/31/2021 12:39:16 AM'#9
          '680056B0D508B020AB123429EF0DF49E9E92C8C6'
          
            'RESTBackendComponents280.bpl'#9'(0x23690000)'#9'C:\Program Files (x86)' +
            '\Embarcadero\Studio'
          '\22.0\bin\'#9'28.0.42600.6491'#9'8/31/2021 12:40:32 AM'#9
          '472345ECAC9D0D6CC261D19CB6AE50F5F20D446A'
          
            'dclRESTComponents280.bpl'#9'(0x237A0000)'#9'C:\Program Files (x86)\Emb' +
            'arcadero\Studio'
          '\22.0\bin\'#9'28.0.42600.6491'#9'8/31/2021 12:39:16 AM'#9
          '204135B11F61C122929838C03E666279723E7A07'
          
            'RESTComponents280.bpl'#9'(0x232C0000)'#9'C:\Program Files (x86)\Embarc' +
            'adero\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:40:34 AM'#9'DFB13828A2CA497E2A2DB8711F' +
            'CB1BC045BD4C51'
          
            'VCLRESTComponents280.bpl'#9'(0x22F70000)'#9'C:\Program Files (x86)\Emb' +
            'arcadero\Studio'
          '\22.0\bin\'#9'28.0.42600.6491'#9'8/30/2021 10:40:50 PM'#9
          '29EA9F7B64366523C8D6ECC8C6C22329E6CC435C'
          
            'dcldbx280.bpl'#9'(0x237E0000)'#9'c:\program files (x86)\embarcadero\st' +
            'udio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:39:00 AM'#9'03E4A2BC995EE393B76191759A' +
            'EC85AEC7D8F99D'
          
            'dbxcds280.bpl'#9'(0x51DB0000)'#9'C:\Program Files (x86)\Embarcadero\St' +
            'udio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:38:46 AM'#9'DEE5A08AB3EDBF75763AD9D390' +
            '517D1B72E3FAC6'
          
            'dcldbxcds280.bpl'#9'(0x22F80000)'#9'c:\program files (x86)\embarcadero' +
            '\studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:39:00 AM'#9'E6B82E8C1F914DFEA52E2786A7' +
            '492FF5F0663688'
          
            'dclemsclient280.bpl'#9'(0x23830000)'#9'c:\program files (x86)\embarcad' +
            'ero\studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:39:02 AM'#9'77E4D14597A6A90A37FB8978FE' +
            '94AA85ECB385AF'
          
            'emsclient280.bpl'#9'(0x23850000)'#9'C:\Program Files (x86)\Embarcadero' +
            '\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:39:40 AM'#9'27CA81B025A11F0C91D12DD14F' +
            'F59B2313A702C6'
          
            'dclemsclientfiredac280.bpl'#9'(0x238B0000)'#9'c:\program files (x86)\e' +
            'mbarcadero\studio'
          '\22.0\bin\'#9'28.0.42600.6491'#9'8/31/2021 12:39:04 AM'#9
          '8EEC333D418719AFF5B285BA52634D777F607FF9'
          
            'emsclientfiredac280.bpl'#9'(0x233A0000)'#9'C:\Program Files (x86)\Emba' +
            'rcadero\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:39:42 AM'#9'B986636ADE8EF3BCD42CBEA0B9' +
            'C5D4AC5C8C9A36'
          
            'FireDAC280.bpl'#9'(0x238D0000)'#9'C:\Program Files (x86)\Embarcadero\S' +
            'tudio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:39:48 AM'#9'DA704F1F26DB61032EA2A6994C' +
            '9EA0BB0A094BEA'
          
            'FireDACCommon280.bpl'#9'(0x239B0000)'#9'C:\Program Files (x86)\Embarca' +
            'dero\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:39:50 AM'#9'7B3D6903619F8D670A7D2F51DD' +
            '3D033ECBA1DAB9'
          
            'FireDACCommonDriver280.bpl'#9'(0x23AB0000)'#9'C:\Program Files (x86)\E' +
            'mbarcadero\Studio'
          '\22.0\bin\'#9'28.0.42600.6491'#9'8/31/2021 12:39:50 AM'#9
          'A40DE4B236E3A0BFEDE2B4695E8E9A2863C0732D'
          
            'dclemsedge280.bpl'#9'(0x23B90000)'#9'c:\program files (x86)\embarcader' +
            'o\studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:39:04 AM'#9'189337279B569946273B3A8370' +
            '91827B144670D7'
          
            'emshosting280.bpl'#9'(0x23BB0000)'#9'C:\Program Files (x86)\Embarcader' +
            'o\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:39:42 AM'#9'B361CDFADDCF201530D9578078' +
            '0EF47245BE5156'
          
            'emsedge280.bpl'#9'(0x23C30000)'#9'C:\Program Files (x86)\Embarcadero\S' +
            'tudio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:39:42 AM'#9'93498A58E4B53B81C46A283E01' +
            'FAADBCEF37808E'
          
            'emsserverapi280.bpl'#9'(0x23C70000)'#9'C:\Program Files (x86)\Embarcad' +
            'ero\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:39:44 AM'#9'E327BC81168B7ACCEF106C25B7' +
            'F1DDC55B2E18D3'
          
            'dclemsserver280.bpl'#9'(0x23D30000)'#9'c:\program files (x86)\embarcad' +
            'ero\studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:39:04 AM'#9'6502AA9FA230E4C246FA53CBBC' +
            'E3B2E0361F65FD'
          
            'vclFireDAC280.bpl'#9'(0x23D60000)'#9'C:\Program Files (x86)\Embarcader' +
            'o\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:40:46 AM'#9'FF87BE07903208CE97EC906974' +
            '3A80B68973D478'
          
            'emsserverresource280.bpl'#9'(0x23E50000)'#9'C:\Program Files (x86)\Emb' +
            'arcadero\Studio'
          '\22.0\bin\'#9'28.0.42600.6491'#9'8/31/2021 12:39:44 AM'#9
          '222270E8CF1BF5EEEF3ED1F668CEFAFCEB7ECB08'
          
            'dclCloudService280.bpl'#9'(0x23E80000)'#9'c:\program files (x86)\embar' +
            'cadero\studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:38:54 AM'#9'6C5CC2F48C515F6033BC350790' +
            '006C148D97E3C4'
          
            'CloudService280.bpl'#9'(0x23EA0000)'#9'C:\Program Files (x86)\Embarcad' +
            'ero\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:38:32 AM'#9'624DC6F0C238B47BD519458E40' +
            '20AAC0FEFD98D4'
          
            'dclDBXDriversEnt280.bpl'#9'(0x23F90000)'#9'c:\program files (x86)\emba' +
            'rcadero\studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:39:00 AM'#9'1AE02CAD15EF12022A017D50AB' +
            '7C36A7802A6F36'
          
            'DBXOracleDriver280.bpl'#9'(0x52CA0000)'#9'C:\Program Files (x86)\Embar' +
            'cadero\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:38:48 AM'#9'C0AEDAFC9DC4B3AF6BA59250DF' +
            '3A0F0BB76807C1'
          
            'DBXSybaseASADriver280.bpl'#9'(0x52CC0000)'#9'C:\Program Files (x86)\Em' +
            'barcadero\Studio'
          '\22.0\bin\'#9'28.0.42600.6491'#9'8/31/2021 12:38:50 AM'#9
          '7A5E3565C0780948B42C6233C5B2226AAF19A448'
          
            'DBXDb2Driver280.bpl'#9'(0x52BD0000)'#9'C:\Program Files (x86)\Embarcad' +
            'ero\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:38:46 AM'#9'C834582D2DF42839CBD91FFBF3' +
            '2BD1CD8AC90C81'
          
            'DBXSybaseASEDriver280.bpl'#9'(0x52CE0000)'#9'C:\Program Files (x86)\Em' +
            'barcadero\Studio'
          '\22.0\bin\'#9'28.0.42600.6491'#9'8/31/2021 12:38:50 AM'#9
          '4A51340E362BF1B9FFB0B48F38C40135D875CDC9'
          
            'DBXInformixDriver280.bpl'#9'(0x52BF0000)'#9'C:\Program Files (x86)\Emb' +
            'arcadero\Studio'
          '\22.0\bin\'#9'28.0.42600.6491'#9'8/31/2021 12:38:46 AM'#9
          'B5857531EA74FAD254023F42B374F89CA0DD7961'
          
            'DBXMSSQLDriver280.bpl'#9'(0x52C40000)'#9'C:\Program Files (x86)\Embarc' +
            'adero\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:38:48 AM'#9'B808D4E09F9DDAD04C1E6C51F7' +
            '0E33F3E94ECD8F'
          
            'DBXFirebirdDriver280.bpl'#9'(0x23FA0000)'#9'C:\Program Files (x86)\Emb' +
            'arcadero\Studio'
          '\22.0\bin\'#9'28.0.42600.6491'#9'8/31/2021 12:38:46 AM'#9
          'F6E67375751098D599DA7A66D7973A7DEF3CF450'
          
            'DBXOdbcDriver280.bpl'#9'(0x23FC0000)'#9'C:\Program Files (x86)\Embarca' +
            'dero\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:38:48 AM'#9'B8E8AC347DF004586CE43C698B' +
            'D074F2367E1EEE'
          
            'odbc32.dll'#9'(0x58740000)'#9'C:\WINDOWS\SYSTEM32\'#9'10.0.19041.1741'#9'6/1' +
            '5/2022 8:19:58 PM'#9
          'FAE16B8C46BC1BBC3B2806B2953963894E33E411'
          
            'DPAPI.DLL'#9'(0x6E7A0000)'#9'C:\WINDOWS\SYSTEM32\'#9'10.0.19041.546'#9'1/8/2' +
            '022 4:04:57 AM'#9
          '153DD612082759DEB440DE7E3B1C090848A1088D'
          
            'DataExplorerFireDACPlugin280.bpl'#9'(0x23FF0000)'#9'c:\program files (' +
            'x86)\embarcadero'
          '\studio\22.0\bin\'#9'28.0.42600.6491'#9'8/31/2021 12:38:38 AM'#9
          '24A9A34E4DE0F6218496625430B67B70583B8EED'
          
            'FireDACMySQLDriver280.bpl'#9'(0x24080000)'#9'C:\Program Files (x86)\Em' +
            'barcadero\Studio'
          '\22.0\bin\'#9'28.0.42600.6491'#9'8/31/2021 12:39:56 AM'#9
          'F572C960AF1BA9CC4834B24954BBC0B233C2951F'
          
            'FireDACMSAccDriver280.bpl'#9'(0x240D0000)'#9'C:\Program Files (x86)\Em' +
            'barcadero\Studio'
          '\22.0\bin\'#9'28.0.42600.6491'#9'8/31/2021 12:39:54 AM'#9
          '46C1C72B91955D180BDDDD65899EC75C8AE78ED0'
          
            'FireDACPgDriver280.bpl'#9'(0x240F0000)'#9'C:\Program Files (x86)\Embar' +
            'cadero\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:39:56 AM'#9'6CC50A438841F0B884A1BACDF9' +
            '205AB161C47CCF'
          
            'FireDACADSDriver280.bpl'#9'(0x24130000)'#9'C:\Program Files (x86)\Emba' +
            'rcadero\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:39:48 AM'#9'44F5B54029AD1B857664C9C835' +
            '084B764176DD08'
          
            'FireDACCommonODBC280.bpl'#9'(0x24180000)'#9'C:\Program Files (x86)\Emb' +
            'arcadero\Studio'
          '\22.0\bin\'#9'28.0.42600.6491'#9'8/31/2021 12:39:50 AM'#9
          '1FB00D1E044EF899E2A230D540967E76B42CE843'
          
            'FireDACSqliteDriver280.bpl'#9'(0x241D0000)'#9'C:\Program Files (x86)\E' +
            'mbarcadero\Studio'
          '\22.0\bin\'#9'28.0.42600.6491'#9'8/31/2021 12:39:56 AM'#9
          'CB8D6E3D5ABBAD77D0B88A035CB4DAE8B6EF6DAB'
          
            'FireDACIBDriver280.bpl'#9'(0x24300000)'#9'C:\Program Files (x86)\Embar' +
            'cadero\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:39:52 AM'#9'EC2BB6ACF991DB38FE91CDE132' +
            '69141D787EA1EC'
          
            'dclFireDAC280.bpl'#9'(0x24370000)'#9'C:\Program Files (x86)\Embarcader' +
            'o\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:39:06 AM'#9'065CF164AF54FF212FA0E4E021' +
            '0A507600A123D3'
          
            'dclBindCompFireDAC280.bpl'#9'(0x245D0000)'#9'c:\program files (x86)\em' +
            'barcadero\studio'
          '\22.0\bin\'#9'28.0.42600.6491'#9'8/31/2021 12:38:54 AM'#9
          '008A3EB4BAF08F80462CBC103E54AA8795D776F9'
          
            'dclFMXFireDAC280.bpl'#9'(0x24600000)'#9'c:\program files (x86)\embarca' +
            'dero\studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:39:06 AM'#9'217A2B35497CE6787B5B7CBF0A' +
            'D3137476C93880'
          
            'fmxFireDAC280.bpl'#9'(0x24620000)'#9'C:\Program Files (x86)\Embarcader' +
            'o\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:40:00 AM'#9'8A62F11B33F104955612E36756' +
            'F8B018133BA345'
          
            'dclVclFireDAC280.bpl'#9'(0x24650000)'#9'c:\program files (x86)\embarca' +
            'dero\studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:39:22 AM'#9'3387E424A955A8328CEEF857B6' +
            'D2340C441DFD69'
          
            'dclFireDACEntExt280.bpl'#9'(0x24670000)'#9'c:\program files (x86)\emba' +
            'rcadero\studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:39:06 AM'#9'C24F67C3D2185CC8C058CEC286' +
            'E67C3BED74E938'
          
            'FireDACDBXDriver280.bpl'#9'(0x24680000)'#9'C:\Program Files (x86)\Emba' +
            'rcadero\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:39:52 AM'#9'FBC2A65EBCB21ACC420AC6B0B8' +
            'E8B1D313850089'
          
            'FireDACDSDriver280.bpl'#9'(0x246B0000)'#9'C:\Program Files (x86)\Embar' +
            'cadero\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:39:52 AM'#9'59B1D3B1824E1E98A7A93F482C' +
            'F950DC885633AB'
          
            'dclfmxstd280.bpl'#9'(0x246E0000)'#9'c:\program files (x86)\embarcadero' +
            '\studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:39:06 AM'#9'526590A01D581E82EDB39B1E6C' +
            'AE856E60538073'
          
            'fmxobj280.bpl'#9'(0x24A60000)'#9'C:\Program Files (x86)\Embarcadero\St' +
            'udio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:40:00 PM'#9'5A3896908692EFA504553EAC46' +
            'D1814430FD4785'
          
            'fmxase280.bpl'#9'(0x24A80000)'#9'C:\Program Files (x86)\Embarcadero\St' +
            'udio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:39:58 PM'#9'CD57F992A6FC1ACA604BCC31AD' +
            'B6C7A617A997DF'
          
            'fmxdae280.bpl'#9'(0x24AA0000)'#9'C:\Program Files (x86)\Embarcadero\St' +
            'udio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 10:40:00 PM'#9'4AE742ECC026FA3CE07DFDC9CF' +
            '853F9F8E2D24F6'
          
            'fmxstyledesigner280.bpl'#9'(0x24DA0000)'#9'c:\program files (x86)\emba' +
            'rcadero\studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:40:02 AM'#9'C1BCCBE51ECB824525E6389DF3' +
            '92B8074C77C584'
          
            'dclIndyCore280.bpl'#9'(0x24E10000)'#9'c:\program files (x86)\embarcade' +
            'ro\studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 7:12:48 PM'#9'494D41569DDD13D4A3315EB447D' +
            '3CDF933DB6B1C'
          
            'dclIndyProtocols280.bpl'#9'(0x24EC0000)'#9'c:\program files (x86)\emba' +
            'rcadero\studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/30/2021 7:12:48 PM'#9'ED65008A767BB3723147F8D3220' +
            'F0BDB04E9E727'
          
            'dcledge280.bpl'#9'(0x24F20000)'#9'c:\program files (x86)\embarcadero\s' +
            'tudio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:39:02 AM'#9'9A91750DD3EEED2F290CA8FC41' +
            'D6128701DB675C'
          
            'dclie280.bpl'#9'(0x24F40000)'#9'c:\program files (x86)\embarcadero\stu' +
            'dio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:39:08 AM'#9'16764325A29BC50D0391E6BB52' +
            'E9110849D4A027'
          
            'DataExplorerDBXPlugin280.bpl'#9'(0x24F60000)'#9'c:\program files (x86)' +
            '\embarcadero\studio'
          '\22.0\bin\'#9'28.0.42600.6491'#9'8/31/2021 12:38:36 AM'#9
          '20FDD38867FDFA5C8511BC70EF70AC018BCA563F'
          
            'DataExplorerDBXPluginInt280.bpl'#9'(0x24F80000)'#9'C:\Program Files (x' +
            '86)\Embarcadero\Studio'
          '\22.0\bin\'#9'28.0.42600.6491'#9'8/31/2021 12:38:38 AM'#9
          '6EA428589EEE92864E59E6312067ADE03C9BB1E2'
          
            'dclbindcompdbx280.bpl'#9'(0x25060000)'#9'c:\program files (x86)\embarc' +
            'adero\studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:38:52 AM'#9'DFB7CC79D6AD5B298A6F361D66' +
            'D767B81D80EC42'
          
            'bindcompdbx280.bpl'#9'(0x25090000)'#9'C:\Program Files (x86)\Embarcade' +
            'ro\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:38:28 AM'#9'C392BA4DF07F79421BD0941141' +
            '8F67CEAF83F399'
          
            'dcldsnapxml280.bpl'#9'(0x250D0000)'#9'c:\program files (x86)\embarcade' +
            'ro\studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:39:02 AM'#9'AFC97333FF7214CE1D311967EA' +
            '399D077F8648E8'
          
            'dsnapxml280.bpl'#9'(0x250E0000)'#9'C:\Program Files (x86)\Embarcadero\' +
            'Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:39:38 AM'#9'4C9FF11E60FBBA858DE0D191C9' +
            '9755F9F83626B4'
          
            'dclmcn280.bpl'#9'(0x250F0000)'#9'c:\program files (x86)\embarcadero\st' +
            'udio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:39:10 AM'#9'F6452FE5AA0D2D9C37C0B1993D' +
            '2BF2AC857E84C9'
          
            'dsnapcon280.bpl'#9'(0x51C90000)'#9'C:\Program Files (x86)\Embarcadero\' +
            'Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:39:38 AM'#9'0D7F18339E62C08C17CCCDD629' +
            '1010DF10766873'
          
            'dclsoapmidas280.bpl'#9'(0x25130000)'#9'c:\program files (x86)\embarcad' +
            'ero\studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:39:18 AM'#9'01CCD8323A32EF813D57E4A7FC' +
            '95B460C80917CB'
          
            'soapmidas280.bpl'#9'(0x25150000)'#9'C:\Program Files (x86)\Embarcadero' +
            '\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:40:36 AM'#9'A087C2219FA73C48F76CFF1F7C' +
            '6521AB3FCFA2E6'
          
            'dclsoap280.bpl'#9'(0x25170000)'#9'C:\Program Files (x86)\Embarcadero\S' +
            'tudio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:39:18 AM'#9'AB42BD2494E6D2C6563D14A297' +
            'BFD37A4DFC8D01'
          
            'dclsoapserver280.bpl'#9'(0x25250000)'#9'c:\program files (x86)\embarca' +
            'dero\studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:39:18 AM'#9'05B5BC7A1F3E635532A63EDD5A' +
            '12EEB7ED4E0558'
          
            'soapserver280.bpl'#9'(0x25290000)'#9'C:\Program Files (x86)\Embarcader' +
            'o\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:40:36 AM'#9'0848F64128B5F7C7875F804B37' +
            'BB2BED650A4200'
          
            'dclnetdb280.bpl'#9'(0x252B0000)'#9'c:\program files (x86)\embarcadero\' +
            'studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:39:12 AM'#9'E8D62E810B4A7D28781D1DE971' +
            '0EE1EE163DE9BA'
          
            'inetdbxpress280.bpl'#9'(0x51CD0000)'#9'C:\Program Files (x86)\Embarcad' +
            'ero\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:40:18 AM'#9'2D6BAEC9F51ABA2ED4A4D1BF56' +
            '6EB85A0BCC59DB'
          
            'inetdb280.bpl'#9'(0x516F0000)'#9'C:\Program Files (x86)\Embarcadero\St' +
            'udio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:40:18 AM'#9'7BB3E24B2C5B1FD25C0D1A27A6' +
            '68A4B15CEADA39'
          
            'dclDataSnapClient280.bpl'#9'(0x252D0000)'#9'c:\program files (x86)\emb' +
            'arcadero\studio'
          '\22.0\bin\'#9'28.0.42600.6491'#9'8/31/2021 12:38:56 AM'#9
          'D6C3B2CAB30CFEA5608B07DFAE10F43EAD2C207F'
          
            'DataSnapServer280.bpl'#9'(0x52D40000)'#9'C:\Program Files (x86)\Embarc' +
            'adero\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:38:42 AM'#9'ACECCDE5F8560516E68F6EA8F9' +
            'BA03792ECBA0A8'
          
            'dclDataSnapCommon280.bpl'#9'(0x25380000)'#9'C:\Program Files (x86)\Emb' +
            'arcadero\Studio'
          '\22.0\bin\'#9'28.0.42600.6491'#9'8/31/2021 12:38:56 AM'#9
          'F83DD5E30F0DB54557575DC958C3877B23BCAF81'
          
            'dclDataSnapNativeClient280.bpl'#9'(0x25390000)'#9'c:\program files (x8' +
            '6)\embarcadero\studio'
          '\22.0\bin\'#9'28.0.42600.6491'#9'8/31/2021 12:38:58 AM'#9
          'A28E7229DB74B4595F16B8A3A6E2CC2A77DE8DE9'
          
            'DataSnapNativeClient280.bpl'#9'(0x253B0000)'#9'C:\Program Files (x86)\' +
            'Embarcadero\Studio'
          '\22.0\bin\'#9'28.0.42600.6491'#9'8/31/2021 12:38:42 AM'#9
          'A38FE75C36BED05EDB75A4ED32BDF15E4305BD42'
          
            'dclDataSnapServer280.bpl'#9'(0x253C0000)'#9'c:\program files (x86)\emb' +
            'arcadero\studio'
          '\22.0\bin\'#9'28.0.42600.6491'#9'8/31/2021 12:38:58 AM'#9
          '7484544E9FE3F40DAF43D51FEDA7DDC2FD1D86D2'
          
            'DataExplorerDBXPluginEnt280.bpl'#9'(0x254A0000)'#9'c:\program files (x' +
            '86)\embarcadero\studio'
          '\22.0\bin\'#9'28.0.42600.6491'#9'8/31/2021 12:38:38 AM'#9
          '6890C2781BC037F7A90C6E8657384EAD250DF54A'
          
            'dclDataSnapConnectors280.bpl'#9'(0x254C0000)'#9'c:\program files (x86)' +
            '\embarcadero\studio'
          '\22.0\bin\'#9'28.0.42600.6491'#9'8/31/2021 12:38:56 AM'#9
          'D40FA1E8E7DD3077D6EA2C67BF8281BC12BC6865'
          
            'DatasnapConnectorsFreePascal280.bpl'#9'(0x254E0000)'#9'C:\Program File' +
            's (x86)\Embarcadero'
          '\Studio\22.0\bin\'#9'28.0.42600.6491'#9'8/31/2021 12:38:40 AM'#9
          '9B9269FE0888B4492B86C49D977383C769DF1D5D'
          
            'DataSnapConnectors280.bpl'#9'(0x25530000)'#9'C:\Program Files (x86)\Em' +
            'barcadero\Studio'
          '\22.0\bin\'#9'28.0.42600.6491'#9'8/31/2021 12:38:40 AM'#9
          '429D6ACB279EBA62155E1FF639A97C0AA18DD4B3'
          
            'dclDataSnapIndy10ServerTransport280.bpl'#9'(0x25500000)'#9'c:\program ' +
            'files (x86)\embarcadero'
          '\studio\22.0\bin\'#9'28.0.42600.6491'#9'8/31/2021 12:38:56 AM'#9
          'BE301B34CDC2CAA1855278D04F499609F522C99C'
          
            'DataSnapIndy10ServerTransport280.bpl'#9'(0x52D10000)'#9'C:\Program Fil' +
            'es (x86)\Embarcadero'
          '\Studio\22.0\bin\'#9'28.0.42600.6491'#9'8/31/2021 12:38:42 AM'#9
          '57C83A31B61FB60328158095219829E1B569C994'
          
            'dclDataSnapNativeServer280.bpl'#9'(0x25560000)'#9'c:\program files (x8' +
            '6)\embarcadero\studio'
          '\22.0\bin\'#9'28.0.42600.6491'#9'8/31/2021 12:38:58 AM'#9
          '6AC61590FA5C4B9FAF0282F70DA0FCB800895D49'
          
            'DataSnapServerMidas280.bpl'#9'(0x25520000)'#9'C:\Program Files (x86)\E' +
            'mbarcadero\Studio'
          '\22.0\bin\'#9'28.0.42600.6491'#9'8/31/2021 12:38:42 AM'#9
          'BC7EC85EEDD905950E6E3DF9CA684D08658BA8E8'
          
            'dclDataSnapProviderClient280.bpl'#9'(0x25600000)'#9'c:\program files (' +
            'x86)\embarcadero'
          '\studio\22.0\bin\'#9'28.0.42600.6491'#9'8/31/2021 12:38:58 AM'#9
          '6BDFD1ED1635EEE8E9C3CE183C55859CCA533B38'
          
            'DataSnapProviderClient280.bpl'#9'(0x52D30000)'#9'C:\Program Files (x86' +
            ')\Embarcadero\Studio'
          '\22.0\bin\'#9'28.0.42600.6491'#9'8/31/2021 12:38:42 AM'#9
          '7E73EEEAB5F0F9839B7755F57E88080F64A00D6A'
          
            'dclDataSnapWebBrokerServer280.bpl'#9'(0x25620000)'#9'c:\program files ' +
            '(x86)\embarcadero'
          '\studio\22.0\bin\'#9'28.0.42600.6491'#9'8/31/2021 12:38:58 AM'#9
          '2CD2627B36CCFFA2036B3CBEFA92F23F2647CFB6'
          
            'dclFireDACEnt280.bpl'#9'(0x25640000)'#9'c:\program files (x86)\embarca' +
            'dero\studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:39:06 AM'#9'EAB16DC247E3EA8FF9CA9F79C4' +
            '1CE00C31D56F29'
          
            'FireDACTDataDriver280.bpl'#9'(0x25660000)'#9'C:\Program Files (x86)\Em' +
            'barcadero\Studio'
          '\22.0\bin\'#9'28.0.42600.6491'#9'8/31/2021 12:39:58 AM'#9
          'A9DCB61693D7D0B79E03392E1BB4795C3168BD2C'
          
            'FireDACOracleDriver280.bpl'#9'(0x256A0000)'#9'C:\Program Files (x86)\E' +
            'mbarcadero\Studio'
          '\22.0\bin\'#9'28.0.42600.6491'#9'8/31/2021 12:39:56 AM'#9
          '75253AB82CEF9385DB0E9FA5D7180793AA1C935E'
          
            'FireDACDb2Driver280.bpl'#9'(0x25680000)'#9'C:\Program Files (x86)\Emba' +
            'rcadero\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:39:52 AM'#9'72F4DE6846F51D7F88BA2FA8B3' +
            '4B574C17DEE488'
          
            'FireDACInfxDriver280.bpl'#9'(0x25700000)'#9'C:\Program Files (x86)\Emb' +
            'arcadero\Studio'
          '\22.0\bin\'#9'28.0.42600.6491'#9'8/31/2021 12:39:54 AM'#9
          '5F308AFBB32A23F0CC4594ECEB363B2FC6BADE07'
          
            'FireDACASADriver280.bpl'#9'(0x25720000)'#9'C:\Program Files (x86)\Emba' +
            'rcadero\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:39:48 AM'#9'75FF91D7672BB9FDADC4EDB7E8' +
            '0C42E1B4560377'
          
            'FireDACODBCDriver280.bpl'#9'(0x25740000)'#9'C:\Program Files (x86)\Emb' +
            'arcadero\Studio'
          '\22.0\bin\'#9'28.0.42600.6491'#9'8/31/2021 12:39:56 AM'#9
          'F98AB6B365C547BE7B46C7292A2CB6D21B29F942'
          
            'FireDACMongoDBDriver280.bpl'#9'(0x25780000)'#9'C:\Program Files (x86)\' +
            'Embarcadero\Studio'
          '\22.0\bin\'#9'28.0.42600.6491'#9'8/31/2021 12:39:54 AM'#9
          '5DF831963BB33229CC4624C0F945C8D2A1DE210E'
          
            'FireDACMSSQLDriver280.bpl'#9'(0x25760000)'#9'C:\Program Files (x86)\Em' +
            'barcadero\Studio'
          '\22.0\bin\'#9'28.0.42600.6491'#9'8/31/2021 12:39:54 AM'#9
          'C25A68A4135D3A582D1C56126F4245110151A93C'
          
            'dclDataSnapFireDAC280.bpl'#9'(0x25940000)'#9'c:\program files (x86)\em' +
            'barcadero\studio'
          '\22.0\bin\'#9'28.0.42600.6491'#9'8/31/2021 12:38:56 AM'#9
          'B75D4B7096EFF715F1C677852655E30B5309A675'
          
            'DataSnapFireDAC280.bpl'#9'(0x25950000)'#9'C:\Program Files (x86)\Embar' +
            'cadero\Studio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:38:40 AM'#9'3E5A102C921242517E287C5BD5' +
            '3F9DB5B18CDC9A'
          
            'dclado280.bpl'#9'(0x25980000)'#9'c:\program files (x86)\embarcadero\st' +
            'udio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:38:50 AM'#9'58FE68C97C30A46834B96F3817' +
            '43769D053D209A'
          
            'adortl280.bpl'#9'(0x51A80000)'#9'C:\Program Files (x86)\Embarcadero\St' +
            'udio\22.0\bin\'#9
          
            '28.0.42600.6491'#9'8/31/2021 12:37:34 AM'#9'0BD153D1ECD56497F3B1CDBA9C' +
            '1AED3A40C546AF'
          
            'CodeSiteExpressPkg_Design280.bpl'#9'(0x259B0000)'#9'C:\Program Files (' +
            'x86)\Raize\CS5\Bin\'#9
          
            '5.0.0.0'#9'9/8/2021 5:00:00 AM'#9'B3A2B5828D7C25A06C88AC47CAEDBFC13D6E' +
            'A795'
          
            'CodeSiteExpressPkg280.bpl'#9'(0x259C0000)'#9'C:\Program Files (x86)\Ra' +
            'ize\CS5\Deploy'
          
            '\Win32\'#9'5.0.0.0'#9'9/8/2021 5:00:00 AM'#9'0729703DFFE404847B3A9789826E' +
            'DD4D9A58EA0C'
          
            'msimg32.dll'#9'(0x6E580000)'#9'C:\WINDOWS\SYSTEM32\'#9'10.0.19041.1466'#9'1/' +
            '8/2022 4:04:59 AM'#9
          'AF63747CEC04BEBB25562309CE1F888AF33598CE'
          
            'AbbreviaVCLDDesign280.bpl'#9'(0x25B70000)'#9'C:\Users\Public\Documents' +
            '\Embarcadero\Studio'
          
            '\22.0\bpl\'#9'1.0.0.0'#9'1/31/2022 8:27:10 AM'#9'4EB8E0F7A84E8260710BA443' +
            '4FE8BDF955719320'
          
            'AbbreviaVCLD280.bpl'#9'(0x25BA0000)'#9'C:\Users\Public\Documents\Embar' +
            'cadero\Studio'
          
            '\22.0\Bpl\'#9'1.0.0.0'#9'1/31/2022 8:27:08 AM'#9'890BB7A225CE76A6050E2E34' +
            '6E3FBD66788D80CA'
          
            'AbbreviaD280.bpl'#9'(0x25BF0000)'#9'C:\Users\Public\Documents\Embarcad' +
            'ero\Studio'
          
            '\22.0\Bpl\'#9'5.1.0.0'#9'1/31/2022 8:27:06 AM'#9'B467D444ABD7919AED993BBF' +
            'AA651125DD10A14E'
          
            'RaizeComponentsVcl_Design280.bpl'#9'(0x25CB0000)'#9'C:\Users\Public\Do' +
            'cuments'
          '\Embarcadero\Studio\22.0\bpl\'#9'6.2.2.0'#9'10/6/2021 10:42:34 AM'#9
          '2DF41B19F93C399599AE9A2AE79D36B5D023681D'
          
            'RaizeComponentsVcl280.bpl'#9'(0x25EA0000)'#9'C:\Users\Public\Documents' +
            '\Embarcadero\Studio'
          
            '\22.0\Bpl\'#9'6.2.2.0'#9'10/6/2021 10:42:34 AM'#9'4CC1013E38ED4BBB891AB78' +
            '75CC24EDEC23F4C2C'
          
            'RaizeComponentsVclDb_Design280.bpl'#9'(0x26290000)'#9'C:\Users\Public\' +
            'Documents'
          '\Embarcadero\Studio\22.0\bpl\'#9'6.2.2.0'#9'10/6/2021 10:42:36 AM'#9
          '7DCF6C11BCA23C7289C75FD62D6435C206B04560'
          
            'RaizeComponentsVclDb280.bpl'#9'(0x262C0000)'#9'C:\Users\Public\Documen' +
            'ts\Embarcadero\Studio'
          
            '\22.0\Bpl\'#9'6.2.2.0'#9'10/6/2021 10:42:34 AM'#9'D43E02079B9FBC77026B8E4' +
            '9780A263246DB4086'
          
            'dclfrx28.bpl'#9'(0x26350000)'#9'C:\Program Files (x86)\FastReports\Lib' +
            'D28\'#9'9/7/2021 '
          '7:02:06 PM'#9'2FA715108DF0C3C523364C1F0C765E0D00D1A418'
          'frx28.bpl'#9'(0x26380000)'#9'C:\WINDOWS\SYSTEM32\'#9'9/7/2021 7:02:06 PM'#9
          'A74AF8F5362328297C60707CDBA76336187D5ED1'
          'fs28.bpl'#9'(0x26660000)'#9'C:\WINDOWS\SYSTEM32\'#9'9/7/2021 7:02:04 PM'#9
          '5A2C52B498192684A3C3AEF79A3B15BC360FCE1F'
          
            'HHCtrl.OCX'#9'(0x586A0000)'#9'C:\WINDOWS\SYSTEM32\'#9'10.0.19041.746'#9'1/8/' +
            '2022 4:05:24 AM'#9
          '6B8941D84C32C4961738B6CAE887AF00614B01CB'
          
            'Msftedit.DLL'#9'(0x266E0000)'#9'C:\WINDOWS\SYSTEM32\'#9'10.0.19041.1288'#9'1' +
            '/8/2022 4:04:49 AM'#9
          '4FD35E6A057621897EE55DB6D137B08D4CE4422A'
          
            'dclfrxDB28.bpl'#9'(0x25A70000)'#9'C:\Program Files (x86)\FastReports\L' +
            'ibD28\'#9'9/7/2021 '
          '7:02:08 PM'#9'C53FEA23B646E9ADA118A422AC6E38B69B7F71B4'
          
            'fsDB28.bpl'#9'(0x25AA0000)'#9'C:\WINDOWS\SYSTEM32\'#9'9/7/2021 7:02:06 PM' +
            #9
          'AC838E5FAEF2F47DFF1B41B87CF42E03B3D5A599'
          
            'frxDB28.bpl'#9'(0x25AC0000)'#9'C:\WINDOWS\SYSTEM32\'#9'9/7/2021 7:02:08 P' +
            'M'#9
          'FDC4E257C9B7B9E2D49AB686F51D19CB56040B99'
          
            'dclfrxe28.bpl'#9'(0x25AF0000)'#9'C:\Program Files (x86)\FastReports\Li' +
            'bD28\'#9'9/7/2021 '
          '7:02:08 PM'#9'AFB881D774D06E0DE5977E44D1D32B14A6E3AC8D'
          
            'frxe28.bpl'#9'(0x26AA0000)'#9'C:\WINDOWS\SYSTEM32\'#9'9/7/2021 7:02:08 PM' +
            #9
          'C6D9448A3CF54389D70E327BE65A374F978B2C4E'
          
            'usp10.dll'#9'(0x6DDE0000)'#9'C:\WINDOWS\SYSTEM32\'#9'10.0.19041.546'#9'1/8/2' +
            '022 4:04:59 AM'#9
          '69A007F51EA2827E507FA3867B1B637E0A450EC2'
          
            'dclfrxtee28.bpl'#9'(0x25B10000)'#9'C:\Program Files (x86)\FastReports\' +
            'LibD28\'#9'9/7/2021 '
          '7:02:10 PM'#9'3EAFDD96C259995FFBE5FE59518D5FFB213CC865'
          
            'fsTee28.bpl'#9'(0x25B40000)'#9'C:\WINDOWS\SYSTEM32\'#9'9/7/2021 7:02:04 P' +
            'M'#9
          '71219A3E3106D141315B21CAA065B198610845BA'
          
            'frxTee28.bpl'#9'(0x26B60000)'#9'C:\WINDOWS\SYSTEM32\'#9'9/7/2021 7:02:08 ' +
            'PM'#9
          '457D67119D82F006756212D12FC1BD54FDC05160'
          
            'LockBox3VCLDD280.bpl'#9'(0x26B90000)'#9'C:\Users\Public\Documents\Emba' +
            'rcadero\Studio'
          
            '\22.0\bpl\'#9'3.4.0.0'#9'1/31/2022 9:01:32 AM'#9'0E62E24449A320C977BC8390' +
            'BC89F1181CC8F995'
          
            'LockBox3DR280.bpl'#9'(0x26BD0000)'#9'C:\Users\Public\Documents\Embarca' +
            'dero\Studio'
          
            '\22.0\Bpl\'#9'3.4.1.0'#9'1/31/2022 9:01:30 AM'#9'5AC3EEFC9C09AF089D34E604' +
            '09A49B51E736D992'
          
            'SysToolsDD280.bpl'#9'(0x26C40000)'#9'C:\Users\Public\Documents\Embarca' +
            'dero\Studio'
          
            '\22.0\bpl\'#9'1.0.0.0'#9'1/31/2022 9:05:07 AM'#9'6BFAE57C361CE0A75919A6BC' +
            'FA0DF975065693E1'
          
            'SysToolsDR280.bpl'#9'(0x26C60000)'#9'C:\Users\Public\Documents\Embarca' +
            'dero\Studio'
          
            '\22.0\Bpl\'#9'1.0.0.0'#9'1/31/2022 9:05:06 AM'#9'6E2AFED01691151922825DFD' +
            'E748D00B2399187D'
          
            'SysToolsDBDD280.bpl'#9'(0x25B60000)'#9'C:\Users\Public\Documents\Embar' +
            'cadero\Studio'
          
            '\22.0\bpl\'#9'1.0.0.0'#9'1/31/2022 9:05:11 AM'#9'DECD0C1BF4151414DDFE0451' +
            '34D390EB344C7919'
          
            'SysToolsDBDR280.bpl'#9'(0x26DB0000)'#9'C:\Users\Public\Documents\Embar' +
            'cadero\Studio'
          
            '\22.0\Bpl\'#9'1.0.0.0'#9'1/31/2022 9:05:09 AM'#9'0B73FA828B24B7E7788F1D63' +
            'D828950D7AE70B5B'
          
            'IcsVclD110Design.bpl'#9'(0x26DD0000)'#9'C:\Users\Public\Documents\Emba' +
            'rcadero\Studio'
          
            '\22.0\bpl\'#9'1/31/2022 9:19:37 AM'#9'C40E0A263E81B99C9278508D14BC3B82' +
            '5B56B3A9'
          
            'IcsCommonD110Run.bpl'#9'(0x270B0000)'#9'C:\Users\Public\Documents\Emba' +
            'rcadero\Studio'
          
            '\22.0\Bpl\'#9'1.0.0.0'#9'1/31/2022 9:19:04 AM'#9'F277225F0989F6F5723B909C' +
            '051C1E8C3346FFF3'
          
            'IcsVclD110Run.bpl'#9'(0x274F0000)'#9'C:\Users\Public\Documents\Embarca' +
            'dero\Studio'
          
            '\22.0\Bpl\'#9'1.0.0.0'#9'1/31/2022 9:19:26 AM'#9'090BA99BE548601CE35ECFB0' +
            'D6FBE4E5D17ED160'
          
            'Cryptui.dll'#9'(0x585F0000)'#9'C:\WINDOWS\SYSTEM32\'#9'10.0.19041.2311'#9'12' +
            '/20/2022 5:48:17 AM'#9
          '50BB379CB56F22B8788AD331778570EB0E873EFD'
          
            'ncrypt.dll'#9'(0x749B0000)'#9'C:\WINDOWS\SYSTEM32\'#9'10.0.19041.546'#9'1/8/' +
            '2022 4:04:57 AM'#9
          '6D76737B2BE8B4AFB7287148E89801ED93B8B8CB'
          
            'NTASN1.dll'#9'(0x74230000)'#9'C:\WINDOWS\SYSTEM32\'#9'10.0.19041.546'#9'1/8/' +
            '2022 4:04:57 AM'#9
          '3739BAECE09B2253DE0A57E06043149A69C4D629'
          
            'IcsFmxD110Design.bpl'#9'(0x27F70000)'#9'C:\Users\Public\Documents\Emba' +
            'rcadero\Studio'
          
            '\22.0\bpl\'#9'1.0.0.0'#9'1/31/2022 9:19:39 AM'#9'0B2F8B98060B2248781E1F80' +
            'D0E48329596EC762'
          
            'IcsFmxD110Run.bpl'#9'(0x282A0000)'#9'C:\Users\Public\Documents\Embarca' +
            'dero\Studio'
          
            '\22.0\Bpl\'#9'1.0.0.0'#9'1/31/2022 9:19:36 AM'#9'F3D8DA2E86611489D8FDCAC8' +
            'BD059FEC3066B3BD'
          
            'IcsCommonD110Design.bpl'#9'(0x28B20000)'#9'C:\Users\Public\Documents\E' +
            'mbarcadero\Studio'
          
            '\22.0\bpl\'#9'1.0.0.0'#9'1/31/2022 9:19:41 AM'#9'A5DB2A482838CBD1DF8040D8' +
            'F017034FE8BA1731'
          
            'PowerPDFDD280.bpl'#9'(0x26990000)'#9'C:\Users\Public\Documents\Embarca' +
            'dero\Studio'
          
            '\22.0\bpl\'#9'1.0.0.0'#9'1/31/2022 9:24:22 AM'#9'18A9853A519372649023293C' +
            'AECA48CBF90A54DF'
          
            'PowerPDFDR280.bpl'#9'(0x269A0000)'#9'C:\Users\Public\Documents\Embarca' +
            'dero\Studio'
          
            '\22.0\Bpl\'#9'1.0.0.0'#9'1/31/2022 9:24:21 AM'#9'41DC19479D852F1506B6FD72' +
            '9EACEA4E78022DE7'
          
            'VirtualTreesDD280.bpl'#9'(0x269F0000)'#9'C:\Users\Public\Documents\Emb' +
            'arcadero\Studio'
          
            '\22.0\bpl\'#9'1/31/2022 9:55:41 AM'#9'80B40A93C0251672DC0BA9833647F2AF' +
            '5E08EB73'
          
            'VirtualTreesDR280.bpl'#9'(0x28D80000)'#9'C:\Users\Public\Documents\Emb' +
            'arcadero\Studio'
          
            '\22.0\Bpl\'#9'1/31/2022 9:55:39 AM'#9'938FF45D917E22B901F0991BA54B05A3' +
            'A6DA1CDC'
          
            'AsyncProDD280.bpl'#9'(0x26A10000)'#9'C:\Users\Public\Documents\Embarca' +
            'dero\Studio'
          
            '\22.0\bpl\'#9'1.0.0.0'#9'2/3/2022 12:02:40 PM'#9'5833A511172B3E67F28F8856' +
            '852C9A303402F22C'
          
            'AsyncProDR280.bpl'#9'(0x28E40000)'#9'C:\Users\Public\Documents\Embarca' +
            'dero\Studio'
          
            '\22.0\Bpl\'#9'1.0.0.0'#9'2/3/2022 12:02:36 PM'#9'8C1E84D943E6D487655E0CD5' +
            '4B9CFF14CE4B9A56'
          
            'HexEditor.bpl'#9'(0x29560000)'#9'C:\Users\Public\Documents\Embarcadero' +
            '\Studio\22.0\Bpl\'#9
          
            '1.0.0.0'#9'9/26/2022 7:00:54 AM'#9'1DF32C9D5ACFD1758AE40A48BFAAD0D9597' +
            '74845'
          
            'DragDropD2011.bpl'#9'(0x29840000)'#9'C:\Development Projects\DragAndDr' +
            'op\Library\Delphi '
          
            '2011\'#9'1.0.0.0'#9'9/27/2022 5:49:11 AM'#9'FD906644B2AE4CF4C79105973D286' +
            '7EABB7FFB27'
          
            'wpnapps.dll'#9'(0x29F10000)'#9'C:\Windows\System32\'#9'10.0.19041.2311'#9'12' +
            '/20/2022 5:47:54 AM'#9
          '667D54D6741F7A554E48ED475FF7B7A8761931E8'
          
            'XmlLite.dll'#9'(0x6F9A0000)'#9'C:\Windows\System32\'#9'10.0.19041.546'#9'1/8' +
            '/2022 4:04:59 AM'#9
          'C0F5BAEBFC8CF10639D9D5584288A5F0372D0DE0'
          
            'RMCLIENT.dll'#9'(0x5C580000)'#9'C:\Windows\System32\'#9'10.0.19041.746'#9'1/' +
            '8/2022 4:04:53 AM'#9
          '80855FC673B9B4D772DD60573A5E34EBCA8AB879'
          
            'usermgrcli.dll'#9'(0x5C0F0000)'#9'C:\WINDOWS\SYSTEM32\'#9'10.0.19041.546'#9 +
            '1/8/2022 4:04:59 AM'#9
          '43B0189433CFD095EECCBA7DE38031030641DF9B'
          
            'OneCoreUAPCommonProxyStub.dll'#9'(0x60D20000)'#9'C:\Windows\System32\'#9 +
            '10.0.19041.2311'#9
          '12/20/2022 5:47:56 AM'#9'7D29FA1C0EF5826C93539D4F8A6686815C4051CF'
          
            'LINKINFO.dll'#9'(0x77560000)'#9'C:\WINDOWS\SYSTEM32\'#9'10.0.19041.546'#9'1/' +
            '8/2022 4:05:04 AM'#9
          'C0CB99AED9853A20EEE2A8621505F556BB94F245')
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssBoth
        TabOrder = 1
      end
    end
    object tsStackTraceFile: TTabSheet
      Caption = 'StackTrace file'
      ImageIndex = 4
      object Panel5: TPanel
        Left = 0
        Top = 0
        Width = 986
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 0
        DesignSize = (
          986
          41)
        object lbedStackTraceFile: TLabeledEdit
          Left = 96
          Top = 10
          Width = 883
          Height = 25
          Anchors = [akLeft, akTop, akRight, akBottom]
          EditLabel.Width = 85
          EditLabel.Height = 25
          EditLabel.Caption = 'StackTrace file:'
          LabelPosition = lpLeft
          ReadOnly = True
          TabOrder = 0
          Text = ''
        end
      end
      object pcStackTrace: TPageControl
        Left = 0
        Top = 41
        Width = 986
        Height = 388
        ActivePage = tsStackTraceFormatted
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object tsStackTraceUnformatted: TTabSheet
          Caption = 'Stack Trace (file)'
          object memoStackTrace: TMemo
            AlignWithMargins = True
            Left = 5
            Top = 5
            Width = 968
            Height = 346
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Monoid'
            Font.Pitch = fpFixed
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            ScrollBars = ssBoth
            TabOrder = 0
          end
        end
        object tsStackTraceFormatted: TTabSheet
          Caption = 'Stack Trace (formatted)'
          ImageIndex = 1
          object reStackTrace: TRichEdit
            AlignWithMargins = True
            Left = 5
            Top = 5
            Width = 968
            Height = 346
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            Align = alClient
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Monoid'
            Font.Pitch = fpFixed
            Font.Style = []
            Lines.Strings = (
              'reStackTrace')
            ParentFont = False
            ScrollBars = ssBoth
            TabOrder = 0
            WordWrap = False
            OnContextPopup = reStackTraceContextPopup
            OnLinkClick = reStackTraceLinkClick
          end
        end
      end
    end
    object tsScreenshots: TTabSheet
      Caption = 'Screenshots'
      ImageIndex = 4
      object ControlListScreenshots: TControlList
        Left = 0
        Top = 0
        Width = 986
        Height = 429
        Align = alClient
        ItemHeight = 100
        ItemMargins.Left = 0
        ItemMargins.Top = 0
        ItemMargins.Right = 0
        ItemMargins.Bottom = 0
        ParentColor = False
        TabOrder = 0
        OnBeforeDrawItem = ControlListScreenshotsBeforeDrawItem
        object clbViewImage: TControlListButton
          Left = 184
          Top = 71
          Width = 105
          Height = 25
          Caption = 'View Image'
          OnClick = clbViewImageClick
        end
        object lblImageName: TLabel
          Left = 184
          Top = 4
          Width = 78
          Height = 17
          Caption = 'Image Name'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object lblImagePath: TLabel
          AlignWithMargins = True
          Left = 184
          Top = 47
          Width = 65
          Height = 17
          Caption = 'Image Path'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          StyleElements = [seClient, seBorder]
        end
        object VirtualImage1: TVirtualImage
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 163
          Height = 92
          Cursor = crHandPoint
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 0
          Margins.Bottom = 4
          Align = alLeft
          ImageCollection = ImageCollectionScreenshots
          ImageWidth = 0
          ImageHeight = 0
          ImageIndex = -1
          ImageName = 'MusicNote'
          OnClick = VirtualImage1Click
          ExplicitTop = 8
        end
        object lblImageDimensions: TLabel
          AlignWithMargins = True
          Left = 184
          Top = 25
          Width = 107
          Height = 17
          Caption = 'Image Dimensions'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          StyleElements = [seClient, seBorder]
        end
        object clbViewInExplorer: TControlListButton
          Left = 295
          Top = 71
          Width = 130
          Height = 25
          Caption = 'View In Explorer'
          OnClick = clbViewInExplorerClick
        end
      end
    end
    object tsDXDiagLogFile: TTabSheet
      Caption = 'DXDiag Log'
      ImageIndex = 2
      object Panel6: TPanel
        Left = 0
        Top = 0
        Width = 986
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 0
        DesignSize = (
          986
          41)
        object lbedDXDiagLogFile: TLabeledEdit
          Left = 80
          Top = 10
          Width = 899
          Height = 25
          Anchors = [akLeft, akTop, akRight, akBottom]
          EditLabel.Width = 68
          EditLabel.Height = 25
          EditLabel.Caption = 'DXDiag file:'
          LabelPosition = lpLeft
          ReadOnly = True
          TabOrder = 0
          Text = ''
        end
      end
      object memoDXDiagLog: TMemo
        AlignWithMargins = True
        Left = 5
        Top = 46
        Width = 976
        Height = 378
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Monoid'
        Font.Pitch = fpFixed
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssBoth
        TabOrder = 1
      end
    end
    object tsDescriptionFile: TTabSheet
      Caption = 'Description file'
      ImageIndex = 5
      object Panel8: TPanel
        Left = 0
        Top = 0
        Width = 986
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 0
        DesignSize = (
          986
          41)
        object lbedDescriptionFile: TLabeledEdit
          Left = 104
          Top = 10
          Width = 875
          Height = 25
          Anchors = [akLeft, akTop, akRight, akBottom]
          EditLabel.Width = 90
          EditLabel.Height = 25
          EditLabel.Caption = 'Description file:'
          LabelPosition = lpLeft
          ReadOnly = True
          TabOrder = 0
          Text = ''
        end
      end
      object memoDescription: TMemo
        AlignWithMargins = True
        Left = 5
        Top = 46
        Width = 976
        Height = 378
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Monoid'
        Font.Pitch = fpFixed
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssBoth
        TabOrder = 1
      end
    end
    object tsStepsFile: TTabSheet
      Caption = 'Steps file'
      ImageIndex = 6
      object Panel7: TPanel
        Left = 0
        Top = 0
        Width = 986
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 0
        DesignSize = (
          986
          41)
        object lbedStepsFile: TLabeledEdit
          Left = 72
          Top = 10
          Width = 907
          Height = 25
          Anchors = [akLeft, akTop, akRight, akBottom]
          EditLabel.Width = 56
          EditLabel.Height = 25
          EditLabel.Caption = 'Steps file:'
          LabelPosition = lpLeft
          ReadOnly = True
          TabOrder = 0
          Text = ''
        end
      end
      object memoSteps: TMemo
        AlignWithMargins = True
        Left = 5
        Top = 46
        Width = 976
        Height = 378
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Monoid'
        Font.Pitch = fpFixed
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssBoth
        TabOrder = 1
      end
    end
    object tsSettings: TTabSheet
      Caption = 'Settings'
      ImageIndex = 7
      DesignSize = (
        986
        429)
      object GroupBox1: TGroupBox
        Left = 3
        Top = 3
        Width = 278
        Height = 70
        Caption = 'Font'
        TabOrder = 0
        object lblFontSize: TLabel
          Left = 13
          Top = 27
          Width = 26
          Height = 17
          Caption = 'Size:'
          Enabled = False
        end
        object tbFontSize: TTrackBar
          Left = 45
          Top = 17
          Width = 174
          Height = 46
          Hint = 'Font Size'
          Enabled = False
          Max = 24
          Min = 8
          Position = 10
          TabOrder = 0
          OnChange = tbFontSizeChange
        end
        object edtFontSize: TEdit
          Left = 225
          Top = 23
          Width = 40
          Height = 25
          Alignment = taCenter
          ReadOnly = True
          TabOrder = 1
          Text = '10'
        end
      end
      object GroupBox2: TGroupBox
        Left = 3
        Top = 72
        Width = 278
        Height = 161
        Caption = 'Settings'
        TabOrder = 1
        object cbCreateLog: TCheckBox
          Left = 14
          Top = 27
          Width = 88
          Height = 17
          Caption = 'Create Log'
          Checked = True
          State = cbChecked
          TabOrder = 0
          OnClick = cbCreateLogClick
        end
        object cbMaximizeOnStartup: TCheckBox
          Left = 14
          Top = 50
          Width = 145
          Height = 17
          Caption = 'Maximize on Startup'
          TabOrder = 1
          OnClick = cbMaximizeOnStartupClick
        end
        object cbParseFileOnOpen: TCheckBox
          Left = 14
          Top = 73
          Width = 129
          Height = 17
          Caption = 'Parse on file open'
          TabOrder = 2
          OnClick = cbParseFileOnOpenClick
        end
        object cbAfterParsingView: TCheckBox
          Left = 14
          Top = 96
          Width = 195
          Height = 17
          Caption = 'After parsing view packages'
          TabOrder = 3
          OnClick = cbAfterParsingViewClick
        end
        object combobAfterParsing: TComboBox
          Left = 32
          Top = 119
          Width = 233
          Height = 25
          Style = csDropDownList
          Enabled = False
          TabOrder = 4
          OnChange = combobAfterParsingChange
          Items.Strings = (
            'Only 3rd-party'
            'Only <Empty>'
            '3rd-party & <Empty>'
            'All')
        end
      end
      object GroupBox3: TGroupBox
        Left = 287
        Top = 103
        Width = 258
        Height = 90
        Caption = 'Known Packages && Modules'
        TabOrder = 2
        object Button5: TButton
          Left = 12
          Top = 24
          Width = 235
          Height = 25
          Action = actPackagesEditor
          TabOrder = 0
        end
        object btnModulesEditor: TButton
          Left = 12
          Top = 55
          Width = 235
          Height = 25
          Action = actModulesEditor
          TabOrder = 1
        end
      end
      object Button6: TButton
        Left = 3
        Top = 401
        Width = 134
        Height = 25
        Action = actSettingsRestoreDefaults
        Anchors = [akLeft, akBottom]
        TabOrder = 3
      end
      object GroupBox6: TGroupBox
        Left = 3
        Top = 239
        Width = 278
        Height = 90
        Caption = 'ModulesList file parse Level'
        TabOrder = 4
        object cbParseLevel2: TCheckBox
          Left = 14
          Top = 32
          Width = 131
          Height = 17
          Caption = 'Compare Versions'
          TabOrder = 0
          OnClick = cbParseLevel2Click
        end
        object cbParseLevel3: TCheckBox
          Left = 14
          Top = 55
          Width = 179
          Height = 17
          Caption = 'RegEx compare file name'
          TabOrder = 1
          OnClick = cbParseLevel3Click
        end
      end
      object GroupBox7: TGroupBox
        Left = 287
        Top = 3
        Width = 258
        Height = 94
        Caption = 'Admin mode'
        TabOrder = 5
        object Button7: TButton
          Left = 12
          Top = 24
          Width = 235
          Height = 25
          Action = actEnableAdminMode
          TabOrder = 0
        end
        object Button8: TButton
          Left = 11
          Top = 55
          Width = 235
          Height = 25
          Action = actDisableAdminMode
          TabOrder = 1
        end
      end
      object GroupBox8: TGroupBox
        Left = 287
        Top = 199
        Width = 258
        Height = 65
        Caption = 'Style'
        TabOrder = 6
        object cbxStyles: TComboBox
          Left = 12
          Top = 24
          Width = 235
          Height = 25
          Style = csDropDownList
          Sorted = True
          TabOrder = 0
          OnChange = cbxStylesChange
        end
      end
      object GroupBox9: TGroupBox
        Left = 3
        Top = 332
        Width = 542
        Height = 53
        Caption = 'GitHub'
        TabOrder = 7
        object LinkLabel1: TLinkLabel
          Left = 14
          Top = 24
          Width = 271
          Height = 19
          Hint = 'GitHub: https://github.com/Fantella1978/IDEModuleParser'
          Caption = 
            '<a href="https://github.com/Fantella1978/IDEModuleParser">https:' +
            '//github.com/Fantella1978/IDEModuleParser</a>'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          UseVisualStyle = True
          OnLinkClick = LinkLabel1LinkClick
        end
      end
    end
    object tsLog: TTabSheet
      Caption = 'Log'
      ImageIndex = 3
      object memoLog: TMemo
        AlignWithMargins = True
        Left = 5
        Top = 5
        Width = 976
        Height = 378
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        Lines.Strings = (
          'memoLog')
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssBoth
        TabOrder = 0
      end
      object Panel4: TPanel
        Left = 0
        Top = 388
        Width = 986
        Height = 41
        Align = alBottom
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 1
        DesignSize = (
          986
          41)
        object lbedLogPath: TLabeledEdit
          Left = 58
          Top = 6
          Width = 923
          Height = 25
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 46
          EditLabel.Height = 25
          EditLabel.Caption = 'Log file:'
          LabelPosition = lpLeft
          ReadOnly = True
          TabOrder = 0
          Text = ''
        end
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 501
    Width = 994
    Height = 19
    Panels = <
      item
        Width = 50
      end>
  end
  object ActionList1: TActionList
    Left = 352
    Top = 285
    object actExit: TAction
      Caption = 'Exit'
      Hint = 'Close the program'
      OnExecute = actExitExecute
    end
    object actOpenModuleFile: TAction
      Caption = 'Open ModulesList.txt File'
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
    object actParseCancel: TAction
      Caption = 'Stop'
      OnExecute = actParseCancelExecute
    end
    object actPackagesEditor: TAction
      Caption = 'Packages Editor'
      OnExecute = actPackagesEditorExecute
    end
    object actModulesEditor: TAction
      Caption = 'Modules Editor'
      OnExecute = actModulesEditorExecute
    end
    object actModulesCopySelectedAsText: TAction
      Category = 'Modules Grid'
      Caption = 'Copy as Text'
      Hint = 'Copy modules list to clipboard'
      OnExecute = actModulesCopySelectedAsTextExecute
    end
    object actModulesSelectAll: TAction
      Category = 'Modules Grid'
      Caption = 'Select All'
      Hint = 'Select all modules'
      OnExecute = actModulesSelectAllExecute
    end
    object actModulesUnSelectAll: TAction
      Category = 'Modules Grid'
      Caption = 'Unselect All'
      Hint = 'Unselect all modules'
      OnExecute = actModulesUnSelectAllExecute
    end
    object actModulesAddSelectedToDB: TAction
      Category = 'Modules Grid'
      Caption = 'Add to Known Modules DB'
      Hint = 'Add selected modules to Known Modules DB'
      OnExecute = actModulesAddSelectedToDBExecute
    end
    object actSettingsRestoreDefaults: TAction
      Category = 'Settings'
      Caption = 'Restore Defaults'
      OnExecute = actSettingsRestoreDefaultsExecute
    end
    object actEnableAdminMode: TAction
      Category = 'Settings'
      Caption = 'Enable Admin Mode'
      OnExecute = actEnableAdminModeExecute
    end
    object actDisableAdminMode: TAction
      Category = 'Settings'
      Caption = 'Disable Admin Mode'
      OnExecute = actDisableAdminModeExecute
    end
    object actFilterPackagesTypesSelectAll: TAction
      Category = 'Filter Packages Types'
      Caption = 'Select All Types'
      Hint = 'Select All Types'
      OnExecute = actFilterPackagesTypesSelectAllExecute
    end
    object actFilterPackagesTypesUnselectAll: TAction
      Category = 'Filter Packages Types'
      Caption = 'Unselect All Types'
      Hint = 'Unselect All Types'
      OnExecute = actFilterPackagesTypesUnselectAllExecute
    end
    object actFilterPackagesSelectAll: TAction
      Category = 'Filter Packages'
      Caption = 'Select All Packages'
      Hint = 'Select all packages in filters list'
      OnExecute = actFilterPackagesSelectAllExecute
    end
    object actFilterPackagesUnSelectAll: TAction
      Category = 'Filter Packages'
      Caption = 'Unselect All Packages'
      Hint = 'Unselect all packages in filters list'
      OnExecute = actFilterPackagesUnSelectAllExecute
    end
    object actFiltersClear: TAction
      Caption = 'Clear Filters'
      OnExecute = actFiltersClearExecute
    end
    object actModulesFindSelectedInKnownDB: TAction
      Category = 'Modules Grid'
      Caption = 'Find In Known Modules DB'
      Hint = 'Find current module in Known Modules DB'
      OnExecute = actModulesFindSelectedInKnownDBExecute
    end
    object actFilterPackagesCopyToClipboard: TAction
      Category = 'Filter Packages'
      Caption = 'Copy to Clipboard'
      Hint = 'Copy packages list to clipboard'
      OnExecute = actFilterPackagesCopyToClipboardExecute
    end
    object actDisplayPackagesList: TAction
      Category = 'Modules Grid'
      Caption = 'Packages List'
      OnExecute = actDisplayPackagesListExecute
    end
    object actFilterPackagesTypesSelectOnlyEmpty: TAction
      Category = 'Filter Packages Types'
      Caption = 'Select only <Empty>'
      Hint = 'Select only <Empty> type'
      OnExecute = actFilterPackagesTypesSelectOnlyEmptyExecute
    end
    object actFilterPackagesSelectOnlyEmpty: TAction
      Category = 'Filter Packages'
      Caption = 'Select only <Empty>'
      Hint = 'Select only <Empty>'
      OnExecute = actFilterPackagesSelectOnlyEmptyExecute
    end
    object actFilterPackagesTypesSelectOnly3rdParty: TAction
      Category = 'Filter Packages Types'
      Caption = 'Select only 3rd-party'
      Hint = 'Select only 3rd-party types'
      OnExecute = actFilterPackagesTypesSelectOnly3rdPartyExecute
    end
    object actFilterPackagesSelectOnly3rdParty: TAction
      Category = 'Filter Packages'
      Caption = 'Select only 3rd-party packages'
      Hint = 'Select only 3rd-party packages'
      OnExecute = actFilterPackagesSelectOnly3rdPartyExecute
    end
    object actCopyFromVersionInfo: TAction
      Caption = 'Copy from Version Info'
      Hint = 'Copy modules info from RS Version Info'
      OnExecute = actCopyFromVersionInfoExecute
    end
    object actExploreHere: TAction
      Category = 'Modules Grid'
      Caption = 'Explore here...'
      Enabled = False
      Hint = 'Explore here'
      OnExecute = actExploreHereExecute
    end
    object actFilterPackagesSelect3rdPartyAndEmpty: TAction
      Category = 'Filter Packages'
      Caption = 'actFilterPackagesSelect3rdPartyAndEmpty'
      OnExecute = actFilterPackagesSelect3rdPartyAndEmptyExecute
    end
    object actFilterPackagesTypesSelect3rdPartyAndEmpty: TAction
      Category = 'Filter Packages Types'
      Caption = 'actFilterPackagesTypesSelect3rdPartyAndEmpty'
      OnExecute = actFilterPackagesTypesSelect3rdPartyAndEmptyExecute
    end
  end
  object OpenTextFileDialog1: TOpenTextFileDialog
    DefaultExt = '.txt'
    Filter = 'ModuleList Text file|*.txt'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    ShowEncodingList = False
    Left = 446
    Top = 285
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '.zip'
    Filter = 'Zip file|*.zip'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 545
    Top = 285
  end
  object ppmModulesGrid: TPopupMenu
    Left = 256
    Top = 261
    object Copytoclipboard1: TMenuItem
      Action = actModulesCopySelectedAsText
    end
    object AddtoKnownModulesDB1: TMenuItem
      Action = actModulesAddSelectedToDB
    end
    object FindInKnownModulesDB1: TMenuItem
      Action = actModulesFindSelectedInKnownDB
    end
    object actExploreHere1: TMenuItem
      Action = actExploreHere
    end
    object PackagesList1: TMenuItem
      Action = actDisplayPackagesList
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object actModulesSelectAll1: TMenuItem
      Action = actModulesSelectAll
    end
    object UnselectAll1: TMenuItem
      Action = actModulesUnSelectAll
    end
  end
  object ppmFilterPackagesTypes: TPopupMenu
    Left = 252
    Top = 389
    object SelectAll1: TMenuItem
      Action = actFilterPackagesTypesSelectAll
    end
    object actPackagesTypesUnselectAll1: TMenuItem
      Action = actFilterPackagesTypesUnselectAll
    end
    object actFilterPackagesTypesSelectOnlyEmpty1: TMenuItem
      Action = actFilterPackagesTypesSelectOnlyEmpty
    end
    object Selectonly3rdparty1: TMenuItem
      Action = actFilterPackagesTypesSelectOnly3rdParty
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object ClearFilters3: TMenuItem
      Action = actFiltersClear
    end
  end
  object ppmFilterPackages: TPopupMenu
    Left = 252
    Top = 325
    object SelectAll2: TMenuItem
      Action = actFilterPackagesSelectAll
    end
    object UnselectAll2: TMenuItem
      Action = actFilterPackagesUnSelectAll
    end
    object SelectonlyEmpty1: TMenuItem
      Action = actFilterPackagesSelectOnlyEmpty
    end
    object Selectonly3rdpartypackages1: TMenuItem
      Action = actFilterPackagesSelectOnly3rdParty
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object actFilterPackagesCopyToClipboard1: TMenuItem
      Action = actFilterPackagesCopyToClipboard
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object ClearFilters2: TMenuItem
      Action = actFiltersClear
    end
  end
  object ppmFilters: TPopupMenu
    Left = 256
    Top = 208
    object SelectAllPackages1: TMenuItem
      Action = actFilterPackagesSelectAll
    end
    object SelectonlyEmpty2: TMenuItem
      Action = actFilterPackagesSelectOnlyEmpty
    end
    object Selectonly3rdpartypackages2: TMenuItem
      Action = actFilterPackagesSelectOnly3rdParty
    end
    object UnselectAllPackages1: TMenuItem
      Action = actFilterPackagesUnSelectAll
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object SelectAll3: TMenuItem
      Action = actFilterPackagesTypesSelectAll
    end
    object SelectonlyEmpty3: TMenuItem
      Action = actFilterPackagesTypesSelectOnlyEmpty
    end
    object Selectonly3rdparty2: TMenuItem
      Action = actFilterPackagesTypesSelectOnly3rdParty
    end
    object UnselectAll3: TMenuItem
      Action = actFilterPackagesTypesUnselectAll
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object ClearFilters1: TMenuItem
      Action = actFiltersClear
    end
  end
  object ImageCollectionScreenshots: TImageCollection
    Images = <>
    Left = 348
    Top = 348
  end
end
