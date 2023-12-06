unit UnitMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants
  , System.Classes, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions
  , Vcl.ActnList, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ExtDlgs
  , Vcl.Buttons, System.ImageList, System.UITypes, Vcl.Grids, Vcl.ImgList
  , Vcl.Graphics, Vcl.Mask, System.IOUtils, Clipbrd, System.Zip
  , System.StrUtils, Data.DB, Vcl.DBGrids, Winapi.ShellAPI, Generics.Defaults
  , Vcl.Themes, Vcl.Menus, Vcl.CheckLst
  , UnitDB
  , UnitDBGrid
  , UnitLogger
  , UnitParser
  , UnitSettings
  , UnitIDEModule
  , UnitAddModules
  , UnitCopyAsText
  , UnitModulesEditor
  , UnitPackagesEditor
  , UnitCopyVersionInfo
  , UnitStaticFunctions
  , UnitEnableAdminMode
  , UnitDisplayPackagesList
  ;

type
  TModulesArray = array of PIDEModule;

  TModulesPackagesArray = TArray<TModulesPackage>;

  TDBGrid=Class(Vcl.DBGrids.TDBGrid)
  private
    FOnSelectionChanged: TNotifyEvent;
    procedure LinkActive(Value: Boolean); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState);override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  published
    property OnSelectionChanged: TNotifyEvent read  FOnSelectionChanged write FOnSelectionChanged;
  End;

  TfrmMain = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Panel1: TPanel;
    ActionList1: TActionList;
    actExit: TAction;
    actOpenModuleFile: TAction;
    OpenTextFileDialog1: TOpenTextFileDialog;
    Button3: TButton;
    actParseModuleFile: TAction;
    Button4: TButton;
    actOpenReportZipFile: TAction;
    lbedModuleFile: TLabeledEdit;
    Panel2: TPanel;
    MemoTxtModuleFile: TMemo;
    PageControl1: TPageControl;
    tsModuleListFile: TTabSheet;
    tsModulesList: TTabSheet;
    tsDXDiagLogFile: TTabSheet;
    tsLog: TTabSheet;
    memoLog: TMemo;
    Panel4: TPanel;
    lbedLogPath: TLabeledEdit;
    actParseCancel: TAction;
    tsStackTraceFile: TTabSheet;
    OpenDialog1: TOpenDialog;
    Panel5: TPanel;
    lbedStackTraceFile: TLabeledEdit;
    memoStackTrace: TMemo;
    Panel6: TPanel;
    lbedDXDiagLogFile: TLabeledEdit;
    memoDXDiagLog: TMemo;
    tsDescriptionFile: TTabSheet;
    tsStepsFile: TTabSheet;
    Panel7: TPanel;
    lbedStepsFile: TLabeledEdit;
    Panel8: TPanel;
    lbedDescriptionFile: TLabeledEdit;
    memoDescription: TMemo;
    memoSteps: TMemo;
    DBGridModules: TDBGrid;
    lblStartMessageMain: TLabel;
    lblStartMessageSecondary: TLabel;
    tsSettings: TTabSheet;
    lblFontSize: TLabel;
    tbFontSize: TTrackBar;
    cbCreateLog: TCheckBox;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    ppmModulesGrid: TPopupMenu;
    GroupBox3: TGroupBox;
    Button5: TButton;
    actPackagesEditor: TAction;
    btnModulesEditor: TButton;
    actModulesEditor: TAction;
    actModulesCopySelectedAsText: TAction;
    Copytoclipboard1: TMenuItem;
    actModulesSelectAll: TAction;
    actModulesSelectAll1: TMenuItem;
    actModulesUnSelectAll: TAction;
    UnselectAll1: TMenuItem;
    actModulesAddSelectedToDB: TAction;
    AddtoKnownModulesDB1: TMenuItem;
    N1: TMenuItem;
    Button6: TButton;
    actSettingsRestoreDefaults: TAction;
    tsHome: TTabSheet;
    edtFontSize: TEdit;
    Panel9Top: TPanel;
    ledtBDSBuild: TLabeledEdit;
    SpeedButton1: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton2: TSpeedButton;
    ledtBDSInstDate: TLabeledEdit;
    ledtBDSPath: TLabeledEdit;
    GroupBox4: TGroupBox;
    lblModulesSelectedCount: TLabel;
    lblModulesCount: TLabel;
    GroupBox5: TGroupBox;
    Splitter1: TSplitter;
    cbMaximizeOnStartup: TCheckBox;
    Panel10Left: TPanel;
    Panel11Right: TPanel;
    clbVisiblePackages: TCheckListBox;
    Label1: TLabel;
    gbModulesList: TGroupBox;
    cbParseFileOnOpen: TCheckBox;
    GroupBox6: TGroupBox;
    cbParseLevel2: TCheckBox;
    GroupBox7: TGroupBox;
    actEnableAdminMode: TAction;
    actDisableAdminMode: TAction;
    Button7: TButton;
    Button8: TButton;
    GroupBox8: TGroupBox;
    cbxStyles: TComboBox;
    StatusBar1: TStatusBar;
    lbedFilterFileName: TLabeledEdit;
    lblModulesFilteredCount: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    clbVisiblePackagesTypes: TCheckListBox;
    Label5: TLabel;
    ppmFilterPackagesTypes: TPopupMenu;
    ppmFilterPackages: TPopupMenu;
    actFilterPackagesTypesSelectAll: TAction;
    actFilterPackagesTypesUnselectAll: TAction;
    SelectAll1: TMenuItem;
    actPackagesTypesUnselectAll1: TMenuItem;
    actFilterPackagesSelectAll: TAction;
    actFilterPackagesUnSelectAll: TAction;
    SelectAll2: TMenuItem;
    UnselectAll2: TMenuItem;
    sbPackagesPlus: TSpeedButton;
    sbPackagesMinus: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    ppmFilters: TPopupMenu;
    actFiltersClear: TAction;
    SelectAllPackages1: TMenuItem;
    UnselectAllPackages1: TMenuItem;
    N2: TMenuItem;
    SelectAll3: TMenuItem;
    UnselectAll3: TMenuItem;
    N3: TMenuItem;
    ClearFilters1: TMenuItem;
    actModulesFindSelectedInKnownDB: TAction;
    FindInKnownModulesDB1: TMenuItem;
    actFilterPackagesCopyToClipboard: TAction;
    actFilterPackagesCopyToClipboard1: TMenuItem;
    N4: TMenuItem;
    sbPackagesC: TSpeedButton;
    cbParseLevel3: TCheckBox;
    actDisplayPackagesList: TAction;
    SpeedButton9: TSpeedButton;
    SpeedButton10: TSpeedButton;
    actFilterPackagesTypesSelectOnlyEmpty: TAction;
    actFilterPackagesTypesSelectOnlyEmpty1: TMenuItem;
    actFilterPackagesSelectOnlyEmpty: TAction;
    sbPackagesE: TSpeedButton;
    SelectonlyEmpty1: TMenuItem;
    SelectonlyEmpty2: TMenuItem;
    SelectonlyEmpty3: TMenuItem;
    N5: TMenuItem;
    ClearFilters2: TMenuItem;
    N6: TMenuItem;
    ClearFilters3: TMenuItem;
    SpeedButton12: TSpeedButton;
    sbPackages3rd: TSpeedButton;
    actFilterPackagesTypesSelectOnly3rdParty: TAction;
    actFilterPackagesSelectOnly3rdParty: TAction;
    Selectonly3rdpartypackages1: TMenuItem;
    Selectonly3rdparty1: TMenuItem;
    PackagesList1: TMenuItem;
    Selectonly3rdpartypackages2: TMenuItem;
    Selectonly3rdparty2: TMenuItem;
    edRSBuild: TEdit;
    actCopyFromVersionInfo: TAction;
    Button9: TButton;
    actExploreHere: TAction;
    actExploreHere1: TMenuItem;
    cbAfterParsingView: TCheckBox;
    combobAfterParsing: TComboBox;
    actFilterPackagesSelect3rdPartyAndEmpty: TAction;
    actFilterPackagesTypesSelect3rdPartyAndEmpty: TAction;
    procedure FormCreate(Sender: TObject);
    /// <summary>Connect to Data Base</summary>
    function ConnectToDB : boolean;
    procedure ModulesGridSelectionChanged(Sender: TObject);
    /// <summary>Exit from application</summary>
    procedure actExitExecute(Sender: TObject);
    /// <summary>Open Module text file (ModuleList.txt) via Open File Dialog</summary>
    procedure actOpenModuleFileExecute(Sender: TObject);
    /// <summary>Open Repot Zip file (QPInfo-XXXXXXXX-XXXX.zip) via Open File Dialog</summary>
    procedure actOpenReportZipFileExecute(Sender: TObject);
    /// <summary>Parse Module file</summary>
    procedure actParseModuleFileExecute(Sender: TObject);
    /// <summary>ModuleList file changed, update display FileName</summary>
    procedure UpdateDisplayModuleListFileName();
    /// <summary>StackTrace file changed, update display FileName</summary>
    procedure UpdateDisplayStackTraceFileName();
    /// <summary>DxDiag_Log file changed, update display FileName</summary>
    procedure UpdateDisplayDxDiagLogFileName();
    /// <summary>Description file changed, update display FileName</summary>
    procedure UpdateDisplayDescriptionFileName();
    /// <summary>Steps file changed, update display FileName</summary>
    procedure UpdateDisplayStepsFileName();
    procedure tbFontSizeChange(Sender: TObject);
    /// <summary>Enable Font Size Change</summary>
    procedure EnableFontSizeChange();
    /// <summary>Disable Font Size Change</summary>
    procedure DisableFontSizeChange();
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    /// <summary>Drag and Drop TXT or ZIP files in App</summary>
    procedure WMDropFiles(var Msg: TWMDropFiles); message WM_DROPFILES;
    procedure HideStartMessage;

    /// <summary>Confirm new text ModuleList file load</summary>
    function ConfirmNewModuleListFileLoad(AskForAll: boolean) : boolean;
    /// <summary>Confirm new text StackTrace file load</summary>
    function ConfirmNewStackTraceFileLoad(AskForAll: boolean): boolean;
    /// <summary>Confirm new text DxDiag_Log file load</summary>
    function ConfirmNewDxDiagLogFileLoad(AskForAll: boolean): boolean;
    /// <summary>Confirm new text Description file load</summary>
    function ConfirmNewDescriptionFileLoad(AskForAll: boolean): boolean;
    /// <summary>Confirm new text Steps file load</summary>
    function ConfirmNewStepsFileLoad(AskForAll: boolean): boolean;

    procedure OpenTextStackTraceFile(FileName: string);
    procedure OpenTextModuleListFile(FileName: string);
    procedure OpenTextDxDiagLogFile(FileName: string);
    procedure OpenTextDescriptionFile(FileName: string);
    procedure OpenTextStepsFile(FileName: string);
    procedure OpenZipReportFile(Sender: TObject);
    /// <summary>Load new text ModuleList file</summary>
    procedure LoadTxtModuleFile();
    /// <summary>Load new text StackTrace file</summary>
    procedure LoadTxtStackTraceFile();
    /// <summary>Load new text DxDiag_Log file</summary>
    procedure LoadTxtDxDiagLogFile();
    /// <summary>Load new text Description file</summary>
    procedure LoadTxtDescriptionFile();
    /// <summary>Load new text Steps file</summary>
    procedure LoadTxtStepsFile();
    /// <summary>Check Zip Report file before extract</summary>
    function CheckZipReportFile(Sender: TObject): boolean;
    procedure actParseCancelExecute(Sender: TObject);

    /// <summary>Clear the ModulesArray</summary>
    procedure ModulesArrayClear();
    /// <summary>Find BDS.exe IDE Module</summary>
    function FindBDSIDEModule(var Module: TIDEModule): boolean;
    /// <summary>Delete temp Report folder</summary>
    function DeleteTempReportFolder(): boolean;

    function GetKnownReportFiles: TArray<string>;

    function TryOpenDescFileInReport(): boolean;
    function TryOpenDXDiagFileInReport(): boolean;
    function TryOpenModuleListFileInReport(): boolean;
    function TryOpenReportDataFileInReport(): boolean;
    function TryOpenStackTraceFileInReport(): boolean;
    function TryOpenStepsFileInReport(): boolean;

    function FileExistsInReport(var FileName: string): boolean;
    procedure cbCreateLogClick(Sender: TObject);
    procedure DBGridModulesTitleClick(Column: TColumn);
    procedure DBGridModulesDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure actPackagesEditorExecute(Sender: TObject);
    procedure actModulesEditorExecute(Sender: TObject);
    procedure actModulesCopySelectedAsTextExecute(Sender: TObject);
    procedure actModulesSelectAllExecute(Sender: TObject);
    procedure ModelsGridSelectRange;
    procedure actModulesUnSelectAllExecute(Sender: TObject);
    procedure ModulesSelectedCountDisplay();
    procedure UpdateActionsWithSelectedModels();
    procedure UpdateObjectsAccordingSettings();
    procedure actSettingsRestoreDefaultsExecute(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure actModulesAddSelectedToDBExecute(Sender: TObject);
    procedure cbMaximizeOnStartupClick(Sender: TObject);
    procedure cbParseFileOnOpenClick(Sender: TObject);
    procedure cbParseLevel2Click(Sender: TObject);
    procedure actEnableAdminModeExecute(Sender: TObject);
    procedure actDisableAdminModeExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lbedFilterFileNameChange(Sender: TObject);
    procedure clbVisiblePackagesClickCheck(Sender: TObject);
    procedure clbVisiblePackagesTypesClickCheck(Sender: TObject);
    procedure actFilterPackagesTypesSelectAllExecute(Sender: TObject);
    procedure actFilterPackagesTypesUnselectAllExecute(Sender: TObject);
    procedure actFilterPackagesSelectAllExecute(Sender: TObject);
    procedure actFilterPackagesUnSelectAllExecute(Sender: TObject);
    procedure actFiltersClearExecute(Sender: TObject);
    procedure actModulesFindSelectedInKnownDBExecute(Sender: TObject);
    procedure actFilterPackagesCopyToClipboardExecute(Sender: TObject);
    procedure cbParseLevel3Click(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure SetDBGridModulesDefaultColumnsWidth(Sender: TObject);
    procedure actDisplayPackagesListExecute(Sender: TObject);
    procedure actFilterPackagesTypesSelectOnlyEmptyExecute(Sender: TObject);
    procedure actFilterPackagesSelectOnlyEmptyExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cbxStylesChange(Sender: TObject);
    procedure actFilterPackagesTypesSelectOnly3rdPartyExecute(Sender: TObject);
    function FilterPackagesSelectOnly3rdParty : boolean;
    procedure DisplayRSBuild(module: TIDEModule);
    function FindRSBuildName(build: string): string;
    procedure actCopyFromVersionInfoExecute(Sender: TObject);
    procedure GetMemoTxtModuleFileFromVersionInfo(Sender: TObject);
    procedure actExploreHereExecute(Sender: TObject);
    procedure DBGridModulesDblClick(Sender: TObject);
    procedure cbAfterParsingViewClick(Sender: TObject);
    procedure combobAfterParsingChange(Sender: TObject);
    procedure actFilterPackagesSelect3rdPartyAndEmptyExecute(Sender: TObject);
    procedure actFilterPackagesTypesSelect3rdPartyAndEmptyExecute(
      Sender: TObject);
    procedure actFilterPackagesSelectOnly3rdPartyExecute(Sender: TObject);
  private
    { Private declarations }
    DBGrid1_PrevCol : Integer;
    FModulesFilterFileNameString : string;
    FModulesFilterPackagesString : string;
    FModulesFilterPackagesTypesString: string;
    DBGridModulesColumnsWidth: TDBGridColumnsWidthArray;
    procedure ModulesCountDisplay;
    function IsAdminModeEnabled: boolean;
    procedure ModulesFilteredCountDisplay;
    procedure ModulesStatisticDisplay;
    procedure PackagesFilterCreate(Sender: TObject);
    procedure ApplyAllFiltres;
    procedure StylesChange;
    function GetPackageType_IDByName(name: string): integer;
    function DeleteTempFolder: boolean;
    procedure AfterParsingView(Sender: TObject);
  public
    { Public declarations }
    FModulesPackages : TArray<TModulesPackage>;
    // FModulesPackages : TList;
  end;

var
  frmMain : TfrmMain;
  mtfFileName : TFileName;  // ModuleList.txt filename
  stfFileName : TFileName;  // StackTrace.txt filename
  ddfFileName : TFileName;  // DxDiag_Log.txt filename
  spfFileName : TFileName;  // Step.txt filename
  defFileName : TFileName;  // Desc.txt filename
  mzfFileName : TFileName;  // QPInfo-XXXXXXXX-XXXX.zip filename
  vifFileName : TFileName;  // Version Info temp filename (for Version Information parse)
  Logger : TMyLogger;       // Logger
  ModulesArray : TModulesArray;   // IDE Modules Array
  ModulesFileListIsVersionInfoList : boolean;
  BDSIDEModule : TIDEModule;      // BDS IDE Module
  ReportFolder : string;          // Report folder for unpack Report Zip
  ReportFilesInZip: TArray<string>;
  TempFolder : string;          // Temp folder for paste Version Info text
  ConfirmOpenForAll: TModalResult;   // Confirm Open for All files
  AskConfirmOpenForAll: boolean;     // Ask confirm Open for All files

implementation

{$R *.dfm}

procedure TfrmMain.actDisableAdminModeExecute(Sender: TObject);
begin
  // Disable Admin Mode
  GlobalAdminMode := false;
  Logger.AddToLog('Admin Mode disabled.');
  actEnableAdminMode.Enabled := true;
  actDisableAdminMode.Enabled := false;
end;

procedure TfrmMain.actDisplayPackagesListExecute(Sender: TObject);
begin
  // Display Packages List window
  frmPackagesList.ShowModal;
end;

procedure TfrmMain.actEnableAdminModeExecute(Sender: TObject);
begin
  // Enable Admin Mode
  if (frmEnableAdminMode.ShowModal = mrOk) AND GlobalAdminMode
  then
    begin
      Logger.AddToLog('Admin Mode enabled.');
      actEnableAdminMode.Enabled := false;
      actDisableAdminMode.Enabled := true;
    end;
end;

procedure TfrmMain.actExitExecute(Sender: TObject);
begin
  Close;
end;


procedure TfrmMain.actExploreHereExecute(Sender: TObject);
var
   sFilename : string;
begin
  // Explore Here (Open Explorer and show the module in folder)
  sFilename := DM1.cdsModules.FieldByName('Path').AsString +
    // TPath.DirectorySeparatorChar +
    DM1.cdsModules.FieldByName('FileName').AsString;
  ShellExecute(Application.Handle, 'open', 'explorer.exe',
    PChar(Format('/select,"%s"', [sFilename])), nil, SW_NORMAL);
end;

procedure TfrmMain.actFilterPackagesCopyToClipboardExecute(Sender: TObject);
var
  i : integer;
  pl : TStringList;
  cl : TClipboard;
begin
  // Copy Packages to clipboard
  pl := TStringList.Create;
  try
    for i := 0 to clbVisiblePackages.Items.Count - 1 do
    begin
      if clbVisiblePackages.Checked[i]
        then
          begin
            if clbVisiblePackages.Items[i] <> '<Empty>'
              then pl.Add(clbVisiblePackages.Items[i]);
          end;
    end;
    cl := TClipboard.Create;
    try
      cl.AsText := pl.Text;
      if pl.Text <> '' then ShowMessage('Packages list copied to clipboard');
    finally
      cl.Free;
    end;
  finally
    pl.Free;
  end;
end;

procedure TfrmMain.actFilterPackagesSelect3rdPartyAndEmptyExecute(
  Sender: TObject);
begin
  // Select 3rd-party and Empty packages
  clbVisiblePackages.CheckAll(cbUnchecked, false, false);
  for var i := 0 to clbVisiblePackages.Items.Count - 1 do
    begin
      var tempPackage_ID := GetPackageType_IDByName(clbVisiblePackages.Items[i]);
      if (tempPackage_ID = THIRDPARTY_PACKAGES_TYPE_ID) OR
        (tempPackage_ID = THIRDPARTY_PACKAGES_WITH_GETIT_TYPE_ID)
      then
         begin
           clbVisiblePackages.Checked[i] := true;
         end
      else
      if clbVisiblePackages.Items[i] = '<Empty>'
        then clbVisiblePackages.Checked[i] := true
        else clbVisiblePackages.Checked[i] := false;
    end;
  clbVisiblePackagesClickCheck(Sender);
end;

procedure TfrmMain.actFilterPackagesSelectAllExecute(Sender: TObject);
begin
  clbVisiblePackages.CheckAll(cbChecked, false, false);
  clbVisiblePackagesClickCheck(Sender);
end;

function TfrmMain.GetPackageType_IDByName(name: string): integer;
begin
  for var i := 0 to Length(FModulesPackages) - 1 do
  if FModulesPackages[i].PackageName = name
    then
      begin
        Result := FModulesPackages[i].PackageType_ID;
        Exit;
      end;
  Result := -1;
end;

function TfrmMain.FilterPackagesSelectOnly3rdParty : boolean;
var
  ThirdPartyPackagesFound: boolean;
begin
  // Select only 3rd-party packages
  ThirdPartyPackagesFound := false;
  for var i := 0 to clbVisiblePackages.Items.Count - 1 do
    begin
      var tempPackage_ID := GetPackageType_IDByName(clbVisiblePackages.Items[i]);
      if (tempPackage_ID = THIRDPARTY_PACKAGES_TYPE_ID) OR
        (tempPackage_ID = THIRDPARTY_PACKAGES_WITH_GETIT_TYPE_ID)
      then
         begin
           clbVisiblePackages.Checked[i] := true;
           ThirdPartyPackagesFound := true;
         end
      else clbVisiblePackages.Checked[i] := false;
    end;
  if ThirdPartyPackagesFound
    then
      begin
        result := true;
        clbVisiblePackagesClickCheck(frmMain);
      end
    else result := false;


  if GlobalAfterParsingView and not ThirdPartyPackagesFound then
    begin
      if MessageDlg('No 3rd-party packages found. Show <Empty> packages?', TMsgDlgType.mtConfirmation, [mbYes, mbNo], 0) = mrYes
      then
        begin
          actFilterPackagesSelectOnlyEmptyExecute(frmMain);
          actFilterPackagesTypesSelectOnlyEmptyExecute(frmMain);
        end
      else
        begin
          actFilterPackagesSelectAllExecute(frmMain);
          actFilterPackagesTypesSelectAllExecute(frmMain);
        end;
    end;
end;

procedure TfrmMain.actFilterPackagesSelectOnly3rdPartyExecute(Sender: TObject);
begin
  //
  FilterPackagesSelectOnly3rdParty();
end;

procedure TfrmMain.actFilterPackagesSelectOnlyEmptyExecute(Sender: TObject);
var
  i: integer;
begin
  //
  clbVisiblePackages.CheckAll(cbUnchecked, false, false);
  for i := 0 to clbVisiblePackages.Items.Count - 1 do
    if clbVisiblePackages.Items[i] = '<Empty>'
      then clbVisiblePackages.Checked[i] := true;
  clbVisiblePackagesClickCheck(Sender);
end;

procedure TfrmMain.actFilterPackagesUnSelectAllExecute(Sender: TObject);
begin
  clbVisiblePackages.CheckAll(cbUnchecked, false, false);
  clbVisiblePackagesClickCheck(Sender);
end;

procedure TfrmMain.actFiltersClearExecute(Sender: TObject);
begin
  lbedFilterFileName.Text := '';
  lbedFilterFileNameChange(Sender);
  actFilterPackagesSelectAllExecute(Sender);
  actFilterPackagesTypesSelectAllExecute(Sender);
end;

function TfrmMain.DeleteTempFolder: boolean;
begin
  // Delete temp Report folder
  if (TempFolder <> '') and TDirectory.Exists(TempFolder, true)
  then
    begin
      try
        TDirectory.Delete(TempFolder, true);
        Logger.AddToLog('Temp folder deleted: ' + TempFolder);
      except
        Logger.AddToLog('[Error] Can''t delete temp folder: ' + TempFolder);
        Result := false;
        Exit;
      end;
    end;
  Result := true;
end;

procedure TfrmMain.GetMemoTxtModuleFileFromVersionInfo(Sender: TObject);
begin
  try
    // Delete old temp folder
    DeleteTempFolder();
    TempFolder := TPath.GetTempPath() + 'TempFolder_' + TPath.GetGUIDFileName(false);
    vifFileName := TempFolder + TPath.DirectorySeparatorChar + 'VersionInfo.txt';

    // Create a new temp folder
    if not TDirectory.Exists(TempFolder, true)
    then
      begin
        TDirectory.CreateDirectory(TempFolder);
        Logger.AddToLog('Create temp folder: ' + TempFolder);
      end
    else
      Logger.AddToLog('Temp folder already exists: ' + TempFolder);

    // Save Version Info text to file
    frmCopyVersionInfo.memVersionInformation.Lines.SaveToFile(vifFileName);
    Logger.AddToLog('The ' + vifFileName + ' file created.');

    // Open saved Version Info text file as a Module List file
    OpenTextModuleListFile(vifFileName);
    ModulesFileListIsVersionInfoList := true;
  finally

  end;
end;

procedure TfrmMain.actCopyFromVersionInfoExecute(Sender: TObject);
begin
  // Copy modules information from RS Version Information
  if frmCopyVersionInfo.ShowModal = mrOk
  then
    begin
      if frmCopyVersionInfo.memVersionInformation.Text <> ''
        then GetMemoTxtModuleFileFromVersionInfo(Sender);
      PageControl1.ActivePage := tsModuleListFile;
      if actParseModuleFile.Enabled
        then actParseModuleFileExecute(Sender);
    end;
end;

procedure TfrmMain.actModulesFindSelectedInKnownDBExecute(Sender: TObject);
begin
  // Find current Module in In Known Modules DB
  frmModulesEditor.lbedFilterFileName.Text := DM1.cdsModules.FieldByName('FileName').AsString;
  frmModulesEditor.WindowState := TWindowState.wsNormal;
  if IsAdminModeEnabled then frmModulesEditor.ShowModal;
end;

procedure TfrmMain.cbParseFileOnOpenClick(Sender: TObject);
begin
  GlobalParseOnFileOpen := cbParseFileOnOpen.Checked;
end;

procedure TfrmMain.cbParseLevel2Click(Sender: TObject);
begin
  GlobalModulesCompareLevel2 := cbParseLevel2.Checked;
end;

procedure TfrmMain.cbParseLevel3Click(Sender: TObject);
begin
  GlobalModulesCompareLevel3 := cbParseLevel3.Checked;
end;

procedure TfrmMain.cbxStylesChange(Sender: TObject);
begin
  if GlobalVCLStyle <> cbxStyles.Text then StylesChange();
end;

procedure TfrmMain.StylesChange();
begin
  TStyleManager.TrySetStyle(cbxStyles.Text);
  GlobalVCLStyle := TStyleManager.ActiveStyle.Name;
  if TStyleManager.ActiveStyle.Name = cbxStyles.Text
    then Logger.AddToLog('Application VCL Style applied: ' + TStyleManager.ActiveStyle.Name);
end;

function TfrmMain.CheckZipReportFile(Sender: TObject): boolean;
var
  zip : TZipFile;
  i : integer;
begin
  // Check ZIP file
  Result := false;
  if not FileExists(mzfFileName) then Exit;
  zip := TZipFile.Create;
  try
    zip.Open(mzfFileName, zmRead);
    var knowReportFiles := GetKnownReportFiles();
    ReportFilesInZip := TArray<string>.Create();
    for i := 0 to zip.FileCount - 1 do
    begin
      if MatchStr(LowerCase(zip.FileName[i]), knowReportFiles)
      then
        begin
          SetLength(ReportFilesInZip, Length(ReportFilesInZip) + 1);
          ReportFilesInZip[Length(ReportFilesInZip) - 1] := zip.FileName[i];
        end;
    end;
    if Length(ReportFilesInZip) = 0
    then
      begin
        Logger.AddToLog('[Error] Can''t find the necessary files inside the Zip archive.');
        Exit;
      end;
  finally
    zip.Free;
  end;
  Result := true;
end;

procedure TfrmMain.ApplyAllFiltres();
var
  FilterString : string;
begin
  if FModulesFilterFileNameString <> ''
    then FilterString := FModulesFilterFileNameString;
  if FModulesFilterPackagesString <> ''
    then
      begin
        if FilterString <> ''
          then FilterString := FilterString + ' AND ';
        FilterString := FilterString + FModulesFilterPackagesString;
      end;
  if FModulesFilterPackagesTypesString <> ''
    then
      begin
        if FilterString <> ''
          then FilterString := FilterString + ' AND ';
        FilterString := FilterString + FModulesFilterPackagesTypesString;
      end;
  if FilterString <> ''
    then
      begin
        DM1.cdsModules.Filter := FilterString;
        DM1.cdsModules.FilterOptions := [foCaseInsensitive];
        DM1.cdsModules.Filtered := true;
      end
    else DM1.cdsModules.Filtered := false;
  DBGridModules.SelectedRows.Clear;
  ModulesFilteredCountDisplay();
  ModulesSelectedCountDisplay();
end;

procedure TfrmMain.clbVisiblePackagesClickCheck(Sender: TObject);
var
  FilterString : string;
  checkedCount : integer;
begin
  FilterString := '';
  checkedCount := 0;
  for var i := 0 to clbVisiblePackages.Items.Count - 1 do
    begin
      if not clbVisiblePackages.Checked[i]
        then
          begin
            if FilterString <> '' then FilterString := FilterString + ', ';
            if clbVisiblePackages.Items[i] = '<Empty>'
              then FilterString := FilterString + QuotedStr('')
              else FilterString := FilterString + QuotedStr(clbVisiblePackages.Items[i]);
          end
        else inc(checkedCount);
    end;
  if FilterString <> ''
    then FModulesFilterPackagesString := 'NOT PackageName IN (' + FilterString + ')'
    else FModulesFilterPackagesString := '';
  if checkedCount = clbVisiblePackages.Items.Count
    then actFilterPackagesSelectAll.Enabled := false
    else actFilterPackagesSelectAll.Enabled := true;
  if checkedCount = 0
    then actFilterPackagesUnSelectAll.Enabled := false
    else actFilterPackagesUnSelectAll.Enabled := true;

  ApplyAllFiltres();
end;

procedure TfrmMain.clbVisiblePackagesTypesClickCheck(Sender: TObject);
var
  tempFilterString : string;
  checkedCount : integer;
begin
  tempFilterString := '';
  checkedCount := 0;
  for var i := 0 to clbVisiblePackagesTypes.Items.Count - 1 do
    begin
      if not clbVisiblePackagesTypes.Checked[i]
        then
          begin
            if tempFilterString <> '' then tempFilterString := tempFilterString + ', ';
            if clbVisiblePackagesTypes.Items[i] = '<Empty>'
              then tempFilterString := tempFilterString + '-1'
              else
                begin
                  var PackageType_ID := DM1.FindPackageType_IDByName(clbVisiblePackagesTypes.Items[i]);
                  if PackageType_ID >= 0
                    then tempFilterString := tempFilterString + IntToStr(PackageType_ID);
                end;
          end
        else inc(checkedCount);
    end;
  if tempFilterString <> ''
    then FModulesFilterPackagesTypesString := 'NOT PackageType_ID IN (' + tempFilterString + ')'
    else FModulesFilterPackagesTypesString := '';
  if checkedCount = clbVisiblePackagesTypes.Items.Count
    then actFilterPackagesTypesSelectAll.Enabled := false
    else actFilterPackagesTypesSelectAll.Enabled := true;
  if checkedCount = 0
    then actFilterPackagesTypesUnSelectAll.Enabled := false
    else actFilterPackagesTypesUnSelectAll.Enabled := true;

  ApplyAllFiltres();
end;

procedure TfrmMain.combobAfterParsingChange(Sender: TObject);
begin
  GlobalAfterParsingViewOption := combobAfterParsing.ItemIndex;
end;

function TfrmMain.ConfirmNewStackTraceFileLoad(AskForAll: boolean): boolean;
var
  res: TModalResult;
begin
  Result := true;
  if (memoStackTrace.Lines.Text = '') OR (ConfirmOpenForAll in [mrYes, mrYesToAll]) then Exit;
  if ConfirmOpenForAll in [mrNo, mrNoToAll]
  then
    begin
      Result := false;
      Exit;
    end;

  if PageControl1.ActivePage <> tsStackTraceFile then PageControl1.ActivePage := tsStackTraceFile;
  if (not AskForAll)
  then
    res := MessageDlg('The StackTrace file is opened. Open another file?', mtConfirmation, mbYesNo, 0)
  else
    begin
      res := MessageDlg('The StackTrace file is opened. Open another file?', mtConfirmation, [mbYes, mbNo, mbYesToAll, mbNoToAll], 0);
      if res in [mrYesToAll, mrNoToAll]
      then
        begin
          ConfirmOpenForAll := res;
          AskConfirmOpenForAll := false;
        end;
    end;

  if res in [mrNo, mrNoToAll, mrCancel]
  then
    begin
      Result := false;
      Logger.AddToLog('The opening of a new StackTrace file has not been confirmed.');
      Exit;
    end;
end;

function TfrmMain.ConfirmNewStepsFileLoad(AskForAll: boolean): boolean;
var
  res: TModalResult;
begin
  Result := true;
  if (memoSteps.Lines.Text = '') OR (ConfirmOpenForAll in [mrYes, mrYesToAll]) then Exit;
  if ConfirmOpenForAll in [mrNo, mrNoToAll]
  then
    begin
      Result := false;
      Exit;
    end;

  if PageControl1.ActivePage <> tsStepsFile then PageControl1.ActivePage := tsStepsFile;
  if (not AskForAll)
  then
    res := MessageDlg('The Steps file is opened. Open another file?', mtConfirmation, mbYesNo, 0)
  else
    begin
      res := MessageDlg('The Steps file is opened. Open another file?', mtConfirmation, [mbYes, mbNo, mbYesToAll, mbNoToAll], 0);
      if res in [mrYesToAll, mrNoToAll]
      then
        begin
          ConfirmOpenForAll := res;
          AskConfirmOpenForAll := false;
        end;
    end;

  if res in [mrNo, mrNoToAll, mrCancel]
  then
    begin
      Result := false;
      Logger.AddToLog('The opening of a new Steps file has not been confirmed.');
      Exit;
    end;
end;

function TfrmMain.ConnectToDB : boolean;
begin
  // Connect To DB
  try
    DM1.cdsModules.CreateDataSet;
    DM1.cdsModules.Active := true;
    DM1.cdsModules.IndexName := '';

    DM1.fdcSQLite.Close;
    var DBFileName := 'IDEModuleParser.db3';
    var DBFileNameWithPath := TPath.GetDirectoryName(Application.ExeName) +
      TPath.DirectorySeparatorChar + DBFileName;
    if FileExists(DBFileNameWithPath)
      then DM1.fdcSQLite.Params.Database := DBFileNameWithPath
      else
        begin
          var DBDirectory := TPath.GetFullPath(TPath.GetDirectoryName(Application.ExeName) + '\..\..');
          if TDirectory.Exists(DBDirectory)
            then
              begin
                DBFileNameWithPath := DBDirectory + TPath.DirectorySeparatorChar + DBFileName;
                if FileExists(DBFileNameWithPath)
                then DM1.fdcSQLite.Params.Database := DBFileNameWithPath
                else
                  begin
                    ShowMessage('DB file ' + DBFileNameWithPath +' not found.');
                    Result := false;
                    Exit;
                  end;
              end
            else
        end;
    DM1.fdcSQLite.Connected := true;
    DM1.fdtPackages.Active := true;
    DM1.fdtPackageTypes.Active := true;
    DM1.fdtModules.Active := true;
  except
    on E:Exception do
    begin
      ShowMessage(E.Message);
      Result := false;
      Exit;
    end;
  end;
  Result := true;
end;

function TfrmMain.ConfirmNewDxDiagLogFileLoad(AskForAll: boolean): boolean;
var
  res: TModalResult;
begin
  Result := true;
  if (memoDxDiagLog.Lines.Text = '') OR (ConfirmOpenForAll in [mrYes, mrYesToAll]) then Exit;
  if ConfirmOpenForAll in [mrNo, mrNoToAll]
  then
    begin
      Result := false;
      Exit;
    end;

  if PageControl1.ActivePage <> tsDxDiagLogFile then PageControl1.ActivePage := tsDxDiagLogFile;
  if (not AskForAll)
  then
    res := MessageDlg('The DxDiag_Log file is opened. Open another file?', mtConfirmation, mbYesNo, 0)
  else
    begin
      res := MessageDlg('The DxDiag_Log file is opened. Open another file?', mtConfirmation, [mbYes, mbNo, mbYesToAll, mbNoToAll], 0);
      if res in [mrYesToAll, mrNoToAll]
      then
        begin
          ConfirmOpenForAll := res;
          AskConfirmOpenForAll := false;
        end;
    end;

  if res in [mrNo, mrNoToAll, mrCancel]
  then
    begin
      Result := false;
      Logger.AddToLog('The opening of a new DxDiag_Log file has not been confirmed.');
      Exit;
    end;
end;

function TfrmMain.ConfirmNewDescriptionFileLoad(AskForAll: boolean): boolean;
var
  res: TModalResult;
begin
  Result := true;
  if (memoDescription.Lines.Text = '') OR (ConfirmOpenForAll in [mrYes, mrYesToAll]) then Exit;
  if ConfirmOpenForAll in [mrNo, mrNoToAll]
  then
    begin
      Result := false;
      Exit;
    end;

  if PageControl1.ActivePage <> tsDescriptionFile then PageControl1.ActivePage := tsDescriptionFile;
  if (not AskForAll)
  then
    res := MessageDlg('The Description file is opened. Open another file?', mtConfirmation, mbYesNo, 0)
  else
    begin
      res := MessageDlg('The Description file is opened. Open another file?', mtConfirmation, [mbYes, mbNo, mbYesToAll, mbNoToAll], 0);
      if res in [mrYesToAll, mrNoToAll]
      then
        begin
          ConfirmOpenForAll := res;
          AskConfirmOpenForAll := false;
        end;
    end;

  if res in [mrNo, mrNoToAll, mrCancel]
  then
    begin
      Result := false;
      Logger.AddToLog('The opening of a new Description file has not been confirmed.');
      Exit;
    end;
end;

function TfrmMain.ConfirmNewModuleListFileLoad(AskForAll: boolean) : boolean;
var
  res: TModalResult;
begin
  Result := true;
  if (MemoTxtModuleFile.Lines.Text = '') OR (ConfirmOpenForAll in [mrYes, mrYesToAll]) then Exit;
  if ConfirmOpenForAll in [mrNo, mrNoToAll]
  then
    begin
      Result := false;
      Exit;
    end;

  if PageControl1.ActivePage <> tsModuleListFile then PageControl1.ActivePage := tsModuleListFile;
  if (not AskForAll)
  then
    res := MessageDlg('The ModuleList file is opened. Open another file?', mtConfirmation, mbYesNo, 0)
  else
    begin
      res := MessageDlg('The ModuleList file is opened. Open another file?', mtConfirmation, [mbYes, mbNo, mbYesToAll, mbNoToAll], 0);
      if res in [mrYesToAll, mrNoToAll]
      then
        begin
          ConfirmOpenForAll := res;
          AskConfirmOpenForAll := false;
        end;
    end;

  if res in [mrNo, mrNoToAll, mrCancel]
  then
    begin
      Result := false;
      Logger.AddToLog('The opening of a new ModuleList file has not been confirmed.');
      Exit;
    end;
end;


procedure TfrmMain.OpenTextDescriptionFile(FileName: string);
begin
  // Open new text DxDiag_Log.txt file
  if not FileExists(FileName) OR not ConfirmNewDescriptionFileLoad(AskConfirmOpenForAll) then Exit;
  HideStartMessage;
  defFileName := FileName;
  PageControl1.ActivePage := tsDescriptionFile;
  UpdateDisplayDescriptionFileName();
  LoadTxtDescriptionFile();
end;

procedure TfrmMain.OpenTextDxDiagLogFile(FileName: string);
begin
  // Open new text DxDiag_Log.txt file
  if not FileExists(FileName) OR not ConfirmNewDxDiagLogFileLoad(AskConfirmOpenForAll) then Exit;
  HideStartMessage;
  ddfFileName := FileName;
  PageControl1.ActivePage := tsDXDiagLogFile;
  UpdateDisplayDxDiagLogFileName();
  LoadTxtDxDiagLogFile();
end;

procedure TfrmMain.OpenTextModuleListFile(FileName: string);
begin
  // Open new text ModuleFile.txt file
  if not FileExists(FileName) OR not ConfirmNewModuleListFileLoad(AskConfirmOpenForAll) then Exit;
  mtfFileName := FileName;
  HideStartMessage;
  tsModuleListFile.TabVisible := true;
  PageControl1.ActivePage := tsModuleListFile;
  UpdateDisplayModuleListFileName();
  LoadTxtModuleFile();
end;

procedure TfrmMain.OpenTextStackTraceFile(FileName: string);
begin
  // Open new text StackTrace.txt file
  if not FileExists(FileName) OR not ConfirmNewStackTraceFileLoad(AskConfirmOpenForAll) then Exit;
  HideStartMessage;
  stfFileName := FileName;
  PageControl1.ActivePage := tsStackTraceFile;
  UpdateDisplayStackTraceFileName();
  LoadTxtStackTraceFile();
end;

procedure TfrmMain.OpenTextStepsFile(FileName: string);
begin
  // Open new text StackTrace.txt file
  if not FileExists(FileName) OR not ConfirmNewStepsFileLoad(AskConfirmOpenForAll) then Exit;
  HideStartMessage;
  spfFileName := FileName;
  PageControl1.ActivePage := tsStepsFile;
  UpdateDisplayStepsFileName();
  LoadTxtStepsFile();
end;

procedure TfrmMain.OpenZipReportFile(Sender: TObject);
var
  zip : TZipFile;
begin
  // Open Report Zip file (QPInfo-XXXXXXXX-XXXX.zip)
  if not FileExists(mzfFileName) then Exit;

  if not CheckZipReportFile(Sender) then Exit;

  // Unpack Report Zip file in temp folder
  zip := TZipFile.Create;
  try
    zip.Open(mzfFileName, zmRead);

    // Delete old temp Report folder
    DeleteTempReportFolder();
    // Create a new temp Report folder
    ReportFolder := TPath.GetTempPath() +
      // TPath.DirectorySeparatorChar +
      TPath.GetFileNameWithoutExtension(mzfFileName) + '_' +
      TPath.GetGUIDFileName(false);
    if not TDirectory.Exists(ReportFolder, true)
    then
      begin
        TDirectory.CreateDirectory(ReportFolder);
        Logger.AddToLog('Create temp Report folder: ' + ReportFolder);
      end
    else
      Logger.AddToLog('Temp Report folder already exists: ' + ReportFolder);
    for var i:integer := 0 to Length(ReportFilesInZip) - 1 do
      begin
        zip.Extract(ReportFilesInZip[i], ReportFolder);
        Logger.AddToLog('The ' + ReportFilesInZip[i] + ' file unpacked form Zip.');
      end;
  finally
    zip.Free;
  end;

  ConfirmOpenForAll := -1;
  AskConfirmOpenForAll := true;
  TryOpenReportDataFileInReport();
  TryOpenDescFileInReport();
  TryOpenStepsFileInReport();
  TryOpenDXDiagFileInReport();
  TryOpenStackTraceFileInReport();
  TryOpenModuleListFileInReport();
  ConfirmOpenForAll := -1;

  if actParseModuleFile.Enabled
    then actParseModuleFileExecute(Sender);

end;

procedure TfrmMain.actModulesEditorExecute(Sender: TObject);
begin
  // Show Modules Editor
  if not IsAdminModeEnabled then Exit;
  if frmMain.WindowState = wsMaximized
    then frmModulesEditor.WindowState := TWindowState.wsMaximized
    else frmModulesEditor.WindowState := TWindowState.wsNormal;
  frmModulesEditor.ShowModal;
end;

procedure TfrmMain.actModulesSelectAllExecute(Sender: TObject);
var
  CurrentBookMark : TBookmark;
begin
  // Select All Modules in grid
  DM1.cdsModules.DisableControls;
  CurrentBookMark := DM1.cdsModules.GetBookmark;
  DBGridModules.SelectedRows.Clear;
  DM1.cdsModules.First;
  while not DM1.cdsModules.Eof do
  begin
    DBGridModules.SelectedRows.CurrentRowSelected := true;
    DM1.cdsModules.Next;
  end;
  DM1.cdsModules.GotoBookmark(CurrentBookMark);
  DM1.cdsModules.FreeBookMark(CurrentBookMark);
  DM1.cdsModules.EnableControls;
  actModulesSelectAll.Enabled := false;
  ModulesSelectedCountDisplay();
end;

procedure TfrmMain.actModulesUnSelectAllExecute(Sender: TObject);
var
  CurrentBookMark : TBookmark;
begin
  // UnSelect All Modules in grid
  DM1.cdsModules.DisableControls;
  CurrentBookMark := DM1.cdsModules.GetBookmark;
  DBGridModules.SelectedRows.Clear;
  DM1.cdsModules.GotoBookmark(CurrentBookMark);
  DM1.cdsModules.FreeBookMark(CurrentBookMark);
  DM1.cdsModules.EnableControls;
  actModulesUnSelectAll.Enabled := false;
  actModulesCopySelectedAsText.Enabled := false;
  ModulesSelectedCountDisplay();
end;

procedure TfrmMain.actOpenModuleFileExecute(Sender: TObject);
begin
  // Open Module file (ModuleList.txt)
  if OpenTextFileDialog1.InitialDir = ''
    then OpenTextFileDialog1.InitialDir := TPath.GetDirectoryName(Application.ExeName);
  if OpenTextFileDialog1.Execute
     // AND ConfirmNewModuleListFileLoad(false)
    then
      begin
        OpenTextModuleListFile(OpenTextFileDialog1.FileName);
        ModulesFileListIsVersionInfoList := false;
        PageControl1.ActivePage := tsModuleListFile;
        if actParseModuleFile.Enabled
          then actParseModuleFileExecute(Sender);
      end;
end;

procedure TfrmMain.actOpenReportZipFileExecute(Sender: TObject);
begin
  // Open Repot Zip file (QPInfo-XXXXXXXX-XXXX.zip) via Open File Dialog
  if OpenDialog1.InitialDir = '' then
    OpenDialog1.InitialDir := TPath.GetDirectoryName(Application.ExeName);
  if OpenDialog1.Execute
    then
      begin
        mzfFileName := OpenDialog1.FileName;
        OpenZipReportFile(Sender);
      end;
end;

function TfrmMain.IsAdminModeEnabled() : boolean;
begin
  if not GlobalAdminMode
  then
    begin
      if PageControl1.ActivePage = tsSettings
        then ShowMessage('This action requires Administrator Mode to be enabled. Enable Administrator Mode first.')
        else
          begin
            if MessageDlg('This action requires Administrator Mode to be enabled. Go to settings and enable this mode.',
            TMsgDlgType.mtInformation, [mbOk, mbCancel], 0) = mrOk
            then PageControl1.ActivePage := tsSettings;
          end;
      Result := false;
      Exit;
    end;
  Result := true;
end;

procedure TfrmMain.lbedFilterFileNameChange(Sender: TObject);
begin
  if lbedFilterFileName.Text <> ''
    then FModulesFilterFileNameString := 'FileName LIKE ''' + lbedFilterFileName.Text + '%'''
    else FModulesFilterFileNameString := '';
  ApplyAllFiltres();
end;

procedure TfrmMain.actPackagesEditorExecute(Sender: TObject);
begin
  // Show Packages Editor
  if not IsAdminModeEnabled then Exit;
  frmPackagesEditor.ShowModal;
end;

procedure TfrmMain.actFilterPackagesTypesSelect3rdPartyAndEmptyExecute(
  Sender: TObject);
begin
  // Select 3rd-party and Empty packages types
  clbVisiblePackagesTypes.CheckAll(cbUnchecked, false, false);
  for var i := 0 to clbVisiblePackagesTypes.Items.Count - 1 do
  begin
    var PackageType_ID := DM1.FindPackageType_IDByName(clbVisiblePackagesTypes.Items[i]);
    if (PackageType_ID = THIRDPARTY_PACKAGES_TYPE_ID) OR
      (PackageType_ID = THIRDPARTY_PACKAGES_WITH_GETIT_TYPE_ID)
      then clbVisiblePackagesTypes.Checked[i] := true
      else
        if clbVisiblePackagesTypes.Items[i] = '<Empty>'
          then clbVisiblePackagesTypes.Checked[i] := true
          else clbVisiblePackagesTypes.Checked[i] := false;
  end;
  clbVisiblePackagesTypesClickCheck(Sender);
end;

procedure TfrmMain.actFilterPackagesTypesSelectAllExecute(Sender: TObject);
begin
  clbVisiblePackagesTypes.CheckAll(cbChecked, false, false);
  clbVisiblePackagesTypesClickCheck(Sender);
end;

procedure TfrmMain.actFilterPackagesTypesSelectOnly3rdPartyExecute(
  Sender: TObject);
var
  i : integer;
begin
  for i := 0 to clbVisiblePackagesTypes.Items.Count - 1 do
  begin
    var PackageType_ID := DM1.FindPackageType_IDByName(clbVisiblePackagesTypes.Items[i]);
    if (PackageType_ID = THIRDPARTY_PACKAGES_TYPE_ID) OR
      (PackageType_ID = THIRDPARTY_PACKAGES_WITH_GETIT_TYPE_ID)
      then clbVisiblePackagesTypes.Checked[i] := true
      else clbVisiblePackagesTypes.Checked[i] := false;
  end;
  clbVisiblePackagesTypesClickCheck(Sender);
end;

procedure TfrmMain.actFilterPackagesTypesSelectOnlyEmptyExecute(
  Sender: TObject);
var
  i: integer;
begin
  //
  clbVisiblePackagesTypes.CheckAll(cbUnchecked, false, false);
  for i := 0 to clbVisiblePackagesTypes.Items.Count - 1 do
    if clbVisiblePackagesTypes.Items[i] = '<Empty>'
      then clbVisiblePackagesTypes.Checked[i] := true;
  clbVisiblePackagesTypesClickCheck(Sender);
end;

procedure TfrmMain.actFilterPackagesTypesUnselectAllExecute(Sender: TObject);
var
  i: integer;
begin
  clbVisiblePackagesTypes.CheckAll(cbUnchecked, false, false);
  clbVisiblePackagesTypesClickCheck(Sender);
end;

procedure TfrmMain.actParseCancelExecute(Sender: TObject);
begin
  // Cancel Parsing
  if MessageDlg('Cancel parsing?', mtConfirmation, [mbYes, mbNo], 0) = mrYes
  then
    begin
      frmParse.parseCanceled := true;
      frmParse.Close;
    end
end;

procedure TfrmMain.PackagesFilterCreate(Sender: TObject);
var
  i : integer;
begin
  clbVisiblePackages.Clear;
  var L := Length(FModulesPackages);
  for i := 0 to L - 1 do
    begin
      clbVisiblePackages.Items.Add(string(FModulesPackages[i].PackageName));
      // clbVisiblePackages.Items.AddPair(FModulesPackages[i].PackageName, IntToStr(FModulesPackages[i].Package_ID));
    end;
  clbVisiblePackages.Items.Add('<Empty>');
  // if not GlobalAfterParsingView then actFilterPackagesSelectAllExecute(Sender);
  actFilterPackagesSelectAllExecute(Sender);

  clbVisiblePackagesTypes.Clear;
  DM1.fdtPackageTypes.First;
  for i := 0 to DM1.fdtPackageTypes.RecordCount - 1 do
    begin
      clbVisiblePackagesTypes.Items.Add(DM1.fdtPackageTypes.FieldByName('Name').AsString);
      DM1.fdtPackageTypes.Next;
    end;
  clbVisiblePackagesTypes.Items.Add('<Empty>');
  // if not GlobalAfterParsingView then actFilterPackagesTypesSelectAllExecute(Sender);
  actFilterPackagesTypesSelectAllExecute(Sender);
end;

procedure TfrmMain.PageControl1Change(Sender: TObject);
begin
  if PageControl1.ActivePage = tsModulesList
    then AutoStretchDBGridColumns(DBGridModules, DBGridModulesColumnsWidth);
end;

procedure TfrmMain.SetDBGridModulesDefaultColumnsWidth(Sender: TObject);
begin
  // Set DBGridModules Default Columns Width
  SetLength(DBGridModulesColumnsWidth, DBGridModules.Columns.Count);
  DBGridModulesColumnsWidth := [150, 100, 200, 300, 140, 250, -1];
  for var i := 0 to DBGridModules.Columns.Count - 1 do
    DBGridModules.Columns[i].Width := DBGridModulesColumnsWidth[i];
end;

procedure TfrmMain.actParseModuleFileExecute(Sender: TObject);
var
  oldIndex : string;
begin
  // Parse ModulesList file

  if (DM1.cdsModules.RecordCount > 0) AND
    (MessageDlg('ModulesList already parsed. ReParse ModulesList file?',
       mtConfirmation, [mbYes, mbNo], 0) in [mrNo, mrCancel])
    then Exit;

  ledtBDSPath.Text := '';
  ledtBDSBuild.Text := '';
  ledtBDSInstDate.Text := '';
  edRSBuild.Text := '';

  SetDBGridModulesDefaultColumnsWidth(Sender);
  DM1.cdsModules.DisableControls;

  oldIndex := DM1.cdsModules.IndexName;
  DM1.cdsModules.IndexName := 'cdsModulesModule_IDIndexUNIQ'; // Set Module_ID Index
  DM1.cdsModules.Filtered := false;
  lbedFilterFileName.Text := '';

  frmParse.parseSuccess := false;
  frmParse.MFListIsVIList := ModulesFileListIsVersionInfoList;
  frmParse.Show;
  frmParse.ParseModuleListFile();

  if frmParse.parseSuccess
  then
    begin
      if FindBDSIDEModule(BDSIDEModule) = true
      then
        begin
          ledtBDSPath.Text := BDSIDEModule.Path;
          ledtBDSBuild.Text := BDSIDEModule.Version;
          ledtBDSInstDate.Text := DateTimeToStr(BDSIDEModule.DateTime);
          DisplayRSBuild(BDSIDEModule);
        end
      else BDSIDEModule := nil;

      // Restore IndexName
      if oldIndex = ''
        then DBGridModulesTitleClick(DBGridModules.Columns[0])
        else DM1.cdsModules.IndexName := oldIndex;

      tsModulesList.TabVisible := true;
      tsModulesList.Enabled := true;
      PageControl1.ActivePage := tsModulesList;
      AutoStretchDBGridColumns(DBGridModules, DBGridModulesColumnsWidth);

      ModulesStatisticDisplay();
      PackagesFilterCreate(Sender);

      if GlobalAfterParsingView then AfterParsingView(Sender);

      DBGridModules.SelectedRows.Clear;
      DM1.cdsModules.EnableControls;
      DM1.cdsModules.First;
    end;

end;

procedure TfrmMain.AfterParsingView(Sender: TObject);
begin
  case GlobalAfterParsingViewOption of
    0:
      begin
        if FilterPackagesSelectOnly3rdParty
          then actFilterPackagesTypesSelectOnly3rdPartyExecute(Sender);
      end;
    1:
      begin
        actFilterPackagesSelectOnlyEmptyExecute(Sender);
        actFilterPackagesTypesSelectOnlyEmptyExecute(Sender);
      end;
    2:
      begin
        actFilterPackagesSelect3rdPartyAndEmptyExecute(Sender);
        actFilterPackagesTypesSelect3rdPartyAndEmptyExecute(Sender);
      end;
    3:
      begin
        actFilterPackagesSelectAllExecute(Sender);
        actFilterPackagesTypesSelectAllExecute(Sender);
      end;
  end;
end;

procedure TfrmMain.actSettingsRestoreDefaultsExecute(Sender: TObject);
begin
  // Restore settings to Defaults
  if MessageDlg('Are you sure restore settings to Defaults?', mtConfirmation, [mbYes, mbNo], 0) = mrYes
    then
      begin
        RestoreSettingsToDefaults();
        actSettingsRestoreDefaults.Enabled := false;
        UpdateObjectsAccordingSettings();
      end;
end;

procedure TfrmMain.actModulesAddSelectedToDBExecute(Sender: TObject);
begin
  //
  if IsAdminModeEnabled then frmAddModules.Show;
end;

procedure TfrmMain.actModulesCopySelectedAsTextExecute(Sender: TObject);
var
  CurrentBookMark : TBookmark;
begin
  // Select All Modules in grid
  DM1.cdsModules.DisableControls;
  CurrentBookMark := DM1.cdsModules.GetBookmark;

  frmCopyAsText.ShowModal;

  DM1.cdsModules.GotoBookmark(CurrentBookMark);
  DM1.cdsModules.FreeBookMark(CurrentBookMark);
  DM1.cdsModules.EnableControls;
end;

procedure TfrmMain.cbAfterParsingViewClick(Sender: TObject);
begin
  GlobalAfterParsingView := cbAfterParsingView.Checked;
  combobAfterParsing.Enabled := cbAfterParsingView.Checked;
end;

procedure TfrmMain.cbCreateLogClick(Sender: TObject);
begin
  if cbCreateLog.Checked
  then
    begin
      tsLog.TabVisible := true;
      Logger.LogEnabled := true;
      Logger.AddToLog('Logging enabled.');
    end
  else
    begin
      tsLog.TabVisible := false;
      if GlobalLogCreate then Logger.AddToLog('Logging disabled.');
      Logger.LogEnabled := false;
    end;
  GlobalLogCreate := cbCreateLog.Checked;
  actSettingsRestoreDefaults.Enabled := true;
end;

procedure TfrmMain.cbMaximizeOnStartupClick(Sender: TObject);
begin
  GlobalMaximizeOnStartup := cbMaximizeOnStartup.Checked;
end;

procedure TfrmMain.ModulesFilteredCountDisplay();
begin
  if DM1.cdsModules.Filtered
    then frmMain.lblModulesFilteredCount.Caption := IntToStr(DM1.cdsModules.RecordCount)
    else frmMain.lblModulesFilteredCount.Caption := '-';
end;

procedure TfrmMain.ModulesSelectedCountDisplay();
begin
  lblModulesSelectedCount.Caption := IntToStr(DBGridModules.SelectedRows.Count);
end;

procedure TfrmMain.ModulesCountDisplay();
begin
  frmMain.lblModulesCount.Caption := IntToStr(DM1.cdsModules.RecordCount);
end;

procedure TfrmMain.ModulesStatisticDisplay();
begin
  ModulesCountDisplay();
  ModulesSelectedCountDisplay();
  ModulesFilteredCountDisplay();
end;

procedure TfrmMain.DBGridModulesDblClick(Sender: TObject);
begin
  if actExploreHere.Enabled
    then actExploreHereExecute(Sender);
end;

procedure TfrmMain.DBGridModulesDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  // Rize Column width if text is a long
  AutoCalcDBGridColumnsWidth(DBGridModules, Column, DBGridModulesColumnsWidth);
end;

procedure TfrmMain.DBGridModulesTitleClick(Column: TColumn);
var
  ci : integer;
  CurrentBookMark : TBookmark;
begin
  if column.FieldName = 'Hash' then Exit;

  with DM1.cdsModules do
    try
      CurrentBookMark := GetBookmark;
      DisableControls;
      ci:= column.Index;
      if ci <> DBGrid1_PrevCol
      then
        begin
          DBGridModules.Columns[DBGrid1_PrevCol].Title.Font.Style :=
            DBGridModules.Columns[DBGrid1_PrevCol].Title.Font.Style - [fsBold];
          DBGridModules.Columns[DBGrid1_PrevCol].Title.Caption := DBGridModules.Columns[DBGrid1_PrevCol].FieldName;
        end;
      Column.Title.Font.Style := Column.Title.Font.Style + [fsBold];
      DBGrid1_PrevCol := ci;
      if IndexName = 'cdsModules' + Column.FieldName + 'IndexASC'
        then IndexName := 'cdsModules' + Column.FieldName + 'Index'
        else IndexName := 'cdsModules' + Column.FieldName + 'IndexASC';

      var colCaption := Column.Title.Caption;
      if (pos(' ˅', colCaption, Length(colCaption) - 2) <> 0) or
        (pos(' ˄', colCaption, Length(colCaption) - 2) <> 0)
      then
        colCaption := copy(colCaption, 1, Length(colCaption) - 2);
      Column.Title.Caption := colCaption;
      if IndexName = 'cdsModules' + Column.FieldName + 'Index'
        then Column.Title.Caption := Column.Title.Caption + ' ˄'
        else Column.Title.Caption := Column.Title.Caption + ' ˅';

    finally
      // First;
      GotoBookmark(CurrentBookMark);
      FreeBookMark(CurrentBookMark);
      DBGridModules.SelectedRows.Clear; // Clear Selected Rows TEMPORARILY
      EnableControls;
    end;
end;

function TfrmMain.DeleteTempReportFolder: boolean;
begin
  // Delete temp Report folder
  if (ReportFolder <> '') and TDirectory.Exists(ReportFolder, true)
  then
    begin
      try
        TDirectory.Delete(ReportFolder, true);
        Logger.AddToLog('Temp Report folder deleted: ' + ReportFolder);
      except
        Logger.AddToLog('[Error] Can''t delete temp Report folder: ' + ReportFolder);
        Result := false;
        Exit;
      end;
    end;
  Result := true;
end;

procedure TfrmMain.DisableFontSizeChange;
begin
  // Disable Font Size Change
  lblFontSize.Enabled := false;
  tbFontSize.Enabled := false;
  edtFontSize.Enabled := false;
end;

procedure TfrmMain.DisplayRSBuild(module: TIDEModule);
begin
  edRSBuild.Text := FindRSBuildName(module.Version);
  if edRSBuild.Text <> ''
  then edRSBuild.Visible := true
  else edRSBuild.Visible := false;
end;

procedure TfrmMain.EnableFontSizeChange;
begin
  // Enable Font Size Change
  lblFontSize.Enabled := true;
  tbFontSize.Enabled := true;
  edtFontSize.Enabled := true;
end;

function TfrmMain.FileExistsInReport(var FileName: string): boolean;
begin
  //
  Result := false;
  for var I := 0 to Length(ReportFilesInZip) - 1 do
    if LowerCase(ReportFilesInZip[i]) = LowerCase(FileName)
      then
        begin
          var tempFileName := ReportFolder + TPath.DirectorySeparatorChar + ReportFilesInZip[i];
          if FileExists(tempFileName)
          then
            begin
              FileName := tempFileName;
              Result := true;
            end;
          Break;
        end;
end;

function TfrmMain.FindBDSIDEModule(var Module: TIDEModule): boolean;
var
  i : Integer;
  tempIDEModule : TIDEModule;
begin
  // Find BDS.exe IDE Module
  Result := false;
  for I := 0 to Length(ModulesArray) - 1 do
  begin
    tempIDEModule := @ModulesArray[i]^;
    if LowerCase(tempIDEModule.FileName) = 'bds.exe'
    then
      begin
        Module := tempIDEModule;
        Result := true;
        Break;
      end;
  end;
end;

function TfrmMain.FindRSBuildName(build: string): string;
begin
  Result := '';
  DM1.fdtPackages.DisableControls;
  DM1.fdtPackages.Filtered := false;
  DM1.fdtPackages.Filter := 'Version = ''' + build +'''';
  DM1.fdtPackages.Filtered := true;
  if DM1.fdtPackages.RecordCount = 1
  then
    begin
      Result := DM1.fdtPackages.FieldByName('Name').AsString;
      if DM1.fdtPackages.FieldByName('SubName').AsString <> ''
        then Result := Result + ' ' +
          DM1.fdtPackages.FieldByName('SubName').AsString;
    end;
  DM1.fdtPackages.EnableControls;
end;

procedure TfrmMain.FormActivate(Sender: TObject);
begin
  if GlobalVCLStyle <> TStyleManager.ActiveStyle.Name
    then cbxStylesChange(Sender);
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // Close the Application
  DragAcceptFiles(Self.Handle, False);
  ModulesArrayClear();
  DeleteTempFolder();
  DeleteTempReportFolder();
  if SaveSattingsToRegistry()
    then Logger.AddToLog('Application settings successfuly saved')
    else Logger.AddToLog('[Error] Can''t save application settings');
  Logger.AddToLog('Application closed');
  Logger.Free;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  //
  if not ConnectToDB()
    then
      begin
        Application.Terminate;
        Exit;
      end;

  // for DBGrid Columns Width adjust
  SetLength(DBGridModulesColumnsWidth, DBGridModules.Columns.Count);
  for var i := 0 to DBGridModules.Columns.Count - 1 do
    DBGridModulesColumnsWidth[i] := DBGridModules.Columns[i].Width;
  {
  for var i := 0 to DBGridModules.Columns.Count - 1 do
    Memo1.Lines.Add(IntToStr(i) + ' > ' + IntToStr(DBGridModulesColumnsWidth[i]));
  }

  // Logger
  Logger := TMyLogger.Create;
  Logger.LogMemo := frmMain.memoLog;
  Logger.LogFile := TPath.GetDirectoryName(Application.ExeName) +
    TPath.DirectorySeparatorChar +
    TPath.GetFileNameWithoutExtension(Application.ExeName) + '.log';
  lbedLogPath.Text := Logger.LogFile;
  Logger.Clear;

  for var StyleName in TStyleManager.StyleNames do
    cbxStyles.Items.Add(StyleName);

  var loadSettingsRes := LoadSattingsFromRegistry();

  Logger.LogEnabled := cbCreateLog.Checked;
  Logger.AddToLog('Application started');
  if loadSettingsRes
    then Logger.AddToLog('Application settings successfuly loaded')
    else Logger.AddToLog('[Error] Can''t load application settings');

  if GlobalMaximizeOnStartup
    then frmMain.WindowState := TWindowState.wsMaximized
    else frmMain.WindowState := TWindowState.wsNormal;
  Caption := 'IDE Module Parser' + ' ' + GetFileVersionStr(Application.ExeName);

  UpdateObjectsAccordingSettings();

  MemoTxtModuleFile.Clear;

  lblStartMessageSecondary.Caption := 'QPInfo Report QPInfo-ХХХХХХХХ-ХХХХ.zip file' + #13 +
    'or separately' + #13 +
    'ModuleList.txt, StackTrace.txt, DXDiag_log.txt,' +#13 +
    'Desc.txt, Step.txt, ReportData.xml files.';

  tsModulesList.TabVisible := false;
  tsModuleListFile.TabVisible := false;
  tsDXDiagLogFile.TabVisible := false;
  tsStackTraceFile.TabVisible := false;
  tsStepsFile.TabVisible := false;
  tsDescriptionFile.TabVisible := false;
  PageControl1.ActivePage := tsHome;

  // Disable Font Size Change
  EnableFontSizeChange();

  AskConfirmOpenForAll := false;

  DBGridModules.OnSelectionChanged := ModulesGridSelectionChanged;
end;

procedure TfrmMain.FormResize(Sender: TObject);
begin
  lblStartMessageMain.Top := lblStartMessageSecondary.Top - lblStartMessageMain.Height -
    lblStartMessageSecondary.Margins.Top - lblStartMessageMain.Margins.Bottom -
      lblStartMessageMain.Margins.Top;

  AutoStretchDBGridColumns(DBGridModules, DBGridModulesColumnsWidth);
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  DragAcceptFiles(Self.Handle, True);
end;

procedure TfrmMain.ModulesGridSelectionChanged(Sender: TObject);
begin
  ModulesSelectedCountDisplay();
  UpdateActionsWithSelectedModels();
end;

function TfrmMain.GetKnownReportFiles: TArray<string>;
begin
  Result := TArray<string>.Create('desc.txt',
        'dxdiag_log.txt', 'modulelist.txt',
        'reportdata.xml', 'stacktrace.txt',
        'step.txt'
        );
end;

procedure TfrmMain.HideStartMessage;
begin
  tsHome.TabVisible := false;
end;

procedure TfrmMain.LoadTxtDescriptionFile;
begin
  // Load new text Description file
  memoDescription.Lines.LoadFromFile(defFileName, TEncoding.UTF8);
  // Enable Font Size Change
  EnableFontSizeChange();
  tsDescriptionFile.TabVisible := true;
  PageControl1.ActivePage := tsDescriptionFile;
  Logger.AddToLog('New Description file opened: ' + defFileName);
end;

procedure TfrmMain.LoadTxtDxDiagLogFile;
begin
  // Load new text DxDiag_Log file
  memoDxDiagLog.Lines.LoadFromFile(ddfFileName, TEncoding.UTF8);
  // Enable Font Size Change
  EnableFontSizeChange();
  tsDxDiagLogFile.TabVisible := true;
  PageControl1.ActivePage := tsDxDiagLogFile;
  Logger.AddToLog('New DxDiag_Log file opened: ' + ddfFileName);
end;

procedure TfrmMain.LoadTxtModuleFile;
begin
  // Load new text ModuleList file
  MemoTxtModuleFile.Lines.LoadFromFile(mtfFileName, TEncoding.UTF8);
  Logger.AddToLog('New ModuleList file opened: ' + mtfFileName);
  // Enable Parse Action
  actParseModuleFile.Enabled := true;
  frmParse.parseSuccess := false;
  // Enable Font Size Change
  EnableFontSizeChange();

  tsModulesList.TabVisible := false;
  tsModulesList.Enabled := false;
  PageControl1.ActivePage := tsModuleListFile;

  DM1.ClearModulesDB;
  Logger.AddToLog('Module List DB cleared.');
end;

procedure TfrmMain.LoadTxtStackTraceFile;
begin
  // Load new text StackTrace file
  memoStackTrace.Lines.LoadFromFile(stfFileName, TEncoding.UTF8);
  // Enable Font Size Change
  EnableFontSizeChange();
  tsStackTraceFile.TabVisible := true;
  PageControl1.ActivePage := tsStackTraceFile;
  Logger.AddToLog('New StackTrace file opened: ' + stfFileName);
end;

procedure TfrmMain.LoadTxtStepsFile;
begin
  // Load new text Steps file
  memoSteps.Lines.LoadFromFile(spfFileName, TEncoding.UTF8);
  // Enable Font Size Change
  EnableFontSizeChange();
  tsStepsFile.TabVisible := true;
  PageControl1.ActivePage := tsStepsFile;
  Logger.AddToLog('New Steps file opened: ' + spfFileName);
end;

procedure TfrmMain.ModulesArrayClear;
var
  i : Integer;
  tempIDEModule : TIDEModule;
begin
  // Clear the Modules Array
  for I := 0 to Length(ModulesArray) - 1 do
  begin
    tempIDEModule := @ModulesArray[i]^;
    FreeAndNil(tempIDEModule);
  end;
  SetLength(ModulesArray, 0);
end;

procedure TfrmMain.tbFontSizeChange(Sender: TObject);
begin
  // Change Font Size
  GlobalFontSize := tbFontSize.Position;
  edtFontSize.Text := IntToStr(GlobalFontSize);

  MemoTxtModuleFile.Font.Size := GlobalFontSize;
  memoStackTrace.Font.Size := GlobalFontSize;
  memoDescription.Font.Size := GlobalFontSize;
  memoDXDiagLog.Font.Size := GlobalFontSize;
  memoSteps.Font.Size := GlobalFontSize;
  memoLog.Font.Size := GlobalFontSize;
  DBGridModules.Font.Size := GlobalFontSize;
  if Assigned(frmCopyVersionInfo)
    then frmCopyVersionInfo.memVersionInformation.Font.Size := GlobalFontSize;

  actSettingsRestoreDefaults.Enabled := true;
end;

function TfrmMain.TryOpenDescFileInReport: boolean;
begin
  //
  var tempFileName := 'desc.txt';
  if FileExistsInReport(tempFileName)
  then
    begin
      // Open desc.txt
      OpenTextDescriptionFile(tempFileName);
      Result := true;
    end
  else Result := false;
end;

function TfrmMain.TryOpenDXDiagFileInReport: boolean;
begin
  //
  var tempFileName := 'dxdiag_log.txt';
  if FileExistsInReport(tempFileName)
  then
    begin
      // Open dxdiag_log.txt
      OpenTextDxDiagLogFile(tempFileName);
      Result := true;
    end
  else Result := false;
end;

function TfrmMain.TryOpenModuleListFileInReport: boolean;
begin
  // Try open ModuleList file in Report folder
  var tempFileName := 'modulelist.txt';
  if FileExistsInReport(tempFileName)
  then
    begin
      OpenTextModuleListFile(tempFileName);
      ModulesFileListIsVersionInfoList := false;
      Result := true;
    end
  else Result := false;
end;

function TfrmMain.TryOpenReportDataFileInReport: boolean;
begin
  //
  var tempFileName := 'reportdata.xml';
  if FileExistsInReport(tempFileName)
  then
    begin
      // Open reportdata.xml
      Result := true;
    end
  else Result := false;
end;

function TfrmMain.TryOpenStackTraceFileInReport: boolean;
begin
  //
  var tempFileName := 'stacktrace.txt';
  if FileExistsInReport(tempFileName)
  then
    begin
      // Open stacktrace.txt
      OpenTextStackTraceFile(tempFileName);
      Result := true;
    end
  else Result := false;
end;

function TfrmMain.TryOpenStepsFileInReport: boolean;
begin
  //
  var tempFileName := 'step.txt';
  if FileExistsInReport(tempFileName)
  then
    begin
      // Open step.txt
      OpenTextStepsFile(tempFileName);
      Result := true;
    end
  else Result := false;
end;

procedure TfrmMain.UpdateActionsWithSelectedModels;
begin
  //
  if not DBGridModules.Visible then Exit;

  // Enable/Disable action - Modules Select All
  if (DBGridModules.DataSource.DataSet.RecordCount > 0) AND
    (DBGridModules.DataSource.DataSet.RecordCount <> DBGridModules.SelectedRows.Count)
    then frmMain.actModulesSelectAll.Enabled := true
    else frmMain.actModulesSelectAll.Enabled := false;
  // Enable action - Modules UnSelect All
  if (DBGridModules.DataSource.DataSet.RecordCount > 0) AND
    (DBGridModules.SelectedRows.Count < DBGridModules.DataSource.DataSet.RecordCount)
    then frmMain.actModulesUnSelectAll.Enabled := true;
  // Enable action - Modules Copy Selected As Text
  if (DBGridModules.DataSource.DataSet.RecordCount > 0) AND
    (DBGridModules.SelectedRows.Count > 0)
    then frmMain.actModulesCopySelectedAsText.Enabled := true;
  // Enable action - Modules Add to Known Modules DB
  if (DBGridModules.DataSource.DataSet.RecordCount > 0) AND
    (DBGridModules.SelectedRows.Count > 0)
    then frmMain.actModulesAddSelectedToDB.Enabled := true;
  // Enable action - Modules Explore here...
  if (DBGridModules.DataSource.DataSet.RecordCount > 0) AND
    (DBGridModules.SelectedRows.Count = 1)
    then
      begin
        var sFilename : string := DM1.cdsModules.FieldByName('Path').AsString +
          // TPath.DirectorySeparatorChar +
          DM1.cdsModules.FieldByName('FileName').AsString;
        if FileExists(sFilename)
          then actExploreHere.Enabled := true
          else actExploreHere.Enabled := false;
      end
    else actExploreHere.Enabled := false;
  // Enable action - Modules Find current Module in Known Modules DB
  if (DBGridModules.DataSource.DataSet.RecordCount > 0) AND
    (DBGridModules.SelectedRows.Count = 1)
    then
      begin
        actModulesFindSelectedInKnownDB.Enabled := true;
        actModulesFindSelectedInKnownDB.Caption := 'Find ' +
          DM1.cdsModules.FieldByName('FileName').AsString + ' in Known Modules DB';
      end
    else
      begin
        actModulesFindSelectedInKnownDB.Enabled := false;
        actModulesFindSelectedInKnownDB.Caption := 'Find in Known Modules DB';
      end;

  if (DBGridModules.DataSource.DataSet.RecordCount > 0) AND
    (DBGridModules.SelectedRows.Count = 0)
    then
      begin
        // Disable action - Modules UnSelect All
        frmMain.actModulesUnSelectAll.Enabled := false;
        // Disable action - Modules Copy Selected As Text
        frmMain.actModulesCopySelectedAsText.Enabled := false;
        // Disable action - Modules Add to Known Modules DB
        frmMain.actModulesAddSelectedToDB.Enabled := false;
      end;
end;

procedure TfrmMain.UpdateDisplayDescriptionFileName;
begin
  //
  lbedDescriptionFile.Text := defFileName;
end;

procedure TfrmMain.UpdateDisplayDxDiagLogFileName;
begin
  //
  lbedDxDiagLogFile.Text := ddfFileName;
end;

procedure TfrmMain.UpdateDisplayModuleListFileName;
begin
  //
  lbedModuleFile.Text := mtfFileName;
end;

procedure TfrmMain.UpdateDisplayStackTraceFileName;
begin
  //
  lbedStackTraceFile.Text := stfFileName;
end;

procedure TfrmMain.UpdateDisplayStepsFileName;
begin
  //
  lbedStepsFile.Text := spfFileName;
end;

procedure TfrmMain.UpdateObjectsAccordingSettings;
begin
  // Update Objects according loaded global Settings
  tbFontSize.Position := GlobalFontSize;
  cbCreateLog.Checked := GlobalLogCreate;
  cbMaximizeOnStartup.Checked := GlobalMaximizeOnStartup;
  cbParseFileOnOpen.Checked := GlobalParseOnFileOpen;
  cbAfterParsingView.Checked := GlobalAfterParsingView;
  if (GlobalAfterParsingViewOption >= 0) AND
    (GlobalAfterParsingViewOption <= combobAfterParsing.Items.Count - 1)
  then combobAfterParsing.ItemIndex := GlobalAfterParsingViewOption
  else
    begin
      combobAfterParsing.ItemIndex := 0;
      GlobalAfterParsingViewOption := 0;
    end;
  cbParseLevel2.Checked := GlobalModulesCompareLevel2;
  cbParseLevel3.Checked := GlobalModulesCompareLevel3;
  if cbxStyles.Items.Count <= 1
    then cbxStyles.Enabled := false
    else
      begin
        cbxStyles.Enabled := true;
        if cbxStyles.Items.IndexOf(GlobalVCLStyle) > -1
          then cbxStyles.ItemIndex := cbxStyles.Items.IndexOf(GlobalVCLStyle)
          else cbxStyles.ItemIndex := 0;
        if (GlobalVCLStyle <> cbxStyles.Text) OR
           (GlobalVCLStyle <> TStyleManager.ActiveStyle.Name)
          then StylesChange();
      end;
  // cbCreateLogClick(frmMain);

  if GlobalAdminMode
  then
    begin
      actEnableAdminMode.Enabled := false;
      actDisableAdminMode.Enabled := true;
    end
  else
    begin
      actEnableAdminMode.Enabled := true;
      actDisableAdminMode.Enabled := false;
    end;

  actSettingsRestoreDefaults.Enabled := true;

end;

procedure TfrmMain.WMDropFiles(var Msg: TWMDropFiles);
var
  DropH: HDROP;
  DroppedFileCount : integer;
  FileNameLength: Integer;
  FileName: string;
  FileExtension: string;
  DropError: boolean;
begin
  DropError := true;
  DropH := Msg.Drop;
  try
    DroppedFileCount := DragQueryFile(DropH, $FFFFFFFF, nil, 0);
    if DroppedFileCount = 1
    then
      begin
        Application.BringToFront;
        FileNameLength := DragQueryFile(DropH, 0, nil , 0);
        SetLength(FileName, FileNameLength);
        DragQueryFile(DropH, 0, PChar(FileName), FileNameLength + 1);
        FileExtension := LowerCase(TPath.GetExtension(FileName));
        if (FileExtension = '.txt') OR
           (FileExtension = '.zip')
          then DropError := false;
      end;
  finally
    DragFinish(DropH);
  end;
  Msg.Result := 0;
  if DropError
  then
    begin
      Logger.AddToLog('Drag and drop error. Only one TXT or ZIP files accepted.');
      ShowMessage('Please drag and drop only one TXT or ZIP file.');
      Exit;
    end;

  if (FileExtension = '.txt')
  then
    begin
      var fn:= Lowercase(TPath.GetFileNameWithoutExtension(FileName));

      if (fn = 'modulelist')
        then
          begin
            OpenTextModuleListFile(FileName);
            Exit;
          end;
      if (fn = 'stacktrace')
        then
          begin
            OpenTextStackTraceFile(FileName);
            Exit;
          end;
      if (fn = 'dxdiag_log')
        then
          begin
            OpenTextDxDiagLogFile(FileName);
            Exit;
          end;
      if (fn = 'desc')
        then
          begin
            OpenTextDescriptionFile(FileName);
            Exit;
          end;
      if (fn = 'step')
        then
          begin
            OpenTextStepsFile(FileName);
            Exit;
          end;

      if (PageControl1.ActivePage = tsModuleListFile)
        then
          begin
            OpenTextModuleListFile(FileName);
            exit;
          end;
      if (PageControl1.ActivePage = tsStackTraceFile)
        then
          begin
            OpenTextStackTraceFile(FileName);
            Exit;
          end;
      if (PageControl1.ActivePage = tsDxDiagLogFile)
        then
          begin
            OpenTextDxDiagLogFile(FileName);
            Exit;
          end;
      if (PageControl1.ActivePage = tsDescriptionFile)
        then
          begin
            OpenTextDescriptionFile(FileName);
            Exit;
          end;
      if (PageControl1.ActivePage = tsStepsFile)
        then
          begin
            OpenTextStepsFile(FileName);
            Exit;
          end;
    end;

  if (FileExtension = '.zip')
  then
    begin
      mzfFileName := FileName;
      OpenZipReportFile(frmMain);
    end;
end;

{ TDBGrid }

procedure TfrmMain.ModelsGridSelectRange;
var
  CurrentBookMark, CursorBookMark, FirstBookMark, LastBookMark: TBookmark;
  Dir: integer;
begin
  with DBGridModules do
  begin
    if SelectedRows.Count <= 1 then
      exit;

    DataSource.DataSet.DisableControls;
    try
      FirstBookMark := SelectedRows.Items[0];
      LastBookMark := SelectedRows.Items[SelectedRows.Count - 1];
      SelectedRows.Clear;
      CurrentBookMark := DataSource.DataSet.GetBookmark;
      Dir := DataSource.DataSet.CompareBookmarks(FirstBookMark, CurrentBookMark);

      if Dir = 0 then
        Dir := DataSource.DataSet.CompareBookmarks(LastBookMark, CurrentBookMark);

      if Dir > 0 then
        DataSource.DataSet.GotoBookmark(LastBookMark)
      else if Dir < 0 then
        DataSource.DataSet.GotoBookmark(FirstBookMark)
      else
        Exit;

      while not DataSource.DataSet.eof do
      begin
        CursorBookMark := DataSource.DataSet.GetBookmark;
        SelectedRows.CurrentRowSelected := true;

        if DataSource.DataSet.CompareBookmarks(CurrentBookMark, CursorBookMark) = 0 then
        begin
          DataSource.DataSet.FreeBookMark(CursorBookMark);
          break;
        end;
        DataSource.DataSet.FreeBookMark(CursorBookMark);

        if Dir < 0 then
          DataSource.DataSet.Next
        else
          DataSource.DataSet.Prior;
      end;

      DataSource.DataSet.FreeBookMark(CurrentBookMark);
    finally
      DataSource.DataSet.EnableControls;
    end;
  end;
end;

{ TDBGrid }


procedure TDBGrid.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Assigned(FOnSelectionChanged) then FOnSelectionChanged(self);
end;

procedure TDBGrid.LinkActive(Value: Boolean);
begin
  inherited;
  if Assigned(FOnSelectionChanged) then FOnSelectionChanged(self);
end;

procedure TDBGrid.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if Assigned(FOnSelectionChanged) then FOnSelectionChanged(self);
end;

end.
