unit UnitMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList,
  Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ExtDlgs, Vcl.Buttons
  , System.ImageList, System.UITypes, Vcl.Grids, Vcl.ImgList, Vcl.Graphics
  , Vcl.Mask, System.IOUtils
  , Winapi.ShellAPI
  , UnitLogger
  , UnitParser
  , UnitIDEModule
  , System.Zip
  , System.StrUtils, Data.DB, Vcl.DBGrids
  , UnitDB
  , UnitStaticFunctions, Vcl.Menus
  , UnitPackagesEditor
  , Vcl.Themes
  , Clipbrd
  , UnitCopyAsText
  , UnitDBGrid
  , UnitSettings
  , UnitModulesEditor
  , UnitAddModules, Vcl.CheckLst
  , UnitEnableAdminMode
  ;

type
  TModulesArray = array of PIDEModule;

  TDBGrid=Class(Vcl.DBGrids.TDBGrid)
  private
    FOnSelectionChanged: TNotifyEvent;
    procedure LinkActive(Value: Boolean); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState);override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
  published
    published
    property OnSelectionChanged:TNotifyEvent read  FOnSelectionChanged write FOnSelectionChanged;
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
    DBGrid1: TDBGrid;
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
    procedure FormCreate(Sender: TObject);
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
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure actPackagesEditorExecute(Sender: TObject);
    procedure actModulesEditorExecute(Sender: TObject);
    procedure actModulesCopySelectedAsTextExecute(Sender: TObject);
    procedure actModulesSelectAllExecute(Sender: TObject);
    procedure DBGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ModelsGridSelectRange;
    procedure DBGrid1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure actModulesUnSelectAllExecute(Sender: TObject);
    procedure ModulesSelectedCountDisplay();
    procedure DBGrid1Enter(Sender: TObject);
    procedure DBGrid1Exit(Sender: TObject);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure UpdateActionsWithSelectedModels();
    procedure DBGrid1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure UpdateObjectsAccordingSettings();
    procedure actSettingsRestoreDefaultsExecute(Sender: TObject);
    procedure DBGrid1MouseActivate(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y, HitTest: Integer;
      var MouseActivate: TMouseActivate);
    procedure FormResize(Sender: TObject);
    procedure actModulesAddSelectedToDBExecute(Sender: TObject);
    procedure cbMaximizeOnStartupClick(Sender: TObject);
    procedure cbParseFileOnOpenClick(Sender: TObject);
    procedure cbParseLevel2Click(Sender: TObject);
    procedure actEnableAdminModeExecute(Sender: TObject);
    procedure actDisableAdminModeExecute(Sender: TObject);
  private
    { Private declarations }
    DBGrid1_PrevCol : Integer;
    procedure ModulesCountDisplay;
    function IsAdminModeEnabled: boolean;
  public
    { Public declarations }
  end;

var
  frmMain : TfrmMain;
  mtfFileName : TFileName;  // ModuleList.txt filename
  stfFileName : TFileName;  // StackTrace.txt filename
  ddfFileName : TFileName;  // DxDiag_Log.txt filename
  spfFileName : TFileName;  // Step.txt filename
  defFileName : TFileName;  // Desc.txt filename
  mzfFileName : TFileName;  // QPInfo-XXXXXXXX-XXXX.zip filename
  Logger : TMyLogger;       // Logger
  ModulesArray : TModulesArray;   // IDE Modules Array
  BDSIDEModule : TIDEModule;      // BDS IDE Module
  ReportFolder : string;          // Report folder for unpack Report Zip
  ReportFilesInZip: TArray<string>;
  ConfirmOpenForAll: TModalResult;   // Confirm Open for All files
  AskConfirmOpenForAll: boolean;     // Ask confirm Open for All files

implementation

{$R *.dfm}

procedure TfrmMain.actDisableAdminModeExecute(Sender: TObject);
begin
  // Disable Admin Mode
  GlobalAdminMode := false;
  actEnableAdminMode.Enabled := true;
  actDisableAdminMode.Enabled := false;
end;

procedure TfrmMain.actEnableAdminModeExecute(Sender: TObject);
begin
  // Enable Admin Mode
  if (frmEnableAdminMode.ShowModal = mrOk) AND GlobalAdminMode
  then
    begin
      actEnableAdminMode.Enabled := false;
      actDisableAdminMode.Enabled := true;
    end;
end;

procedure TfrmMain.actExitExecute(Sender: TObject);
begin
  Close;
end;


procedure TfrmMain.cbParseFileOnOpenClick(Sender: TObject);
begin
  GlobalParseOnFileOpen := cbParseFileOnOpen.Checked;
end;

procedure TfrmMain.cbParseLevel2Click(Sender: TObject);
begin
  GlobalModulesCompareLevel2 := cbParseLevel2.Checked;
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
  if IsAdminModeEnabled then frmModulesEditor.ShowModal;
end;

procedure TfrmMain.actModulesSelectAllExecute(Sender: TObject);
var
  CurrentBookMark : TBookmark;
begin
  // Select All Modules in grid
  DM1.cdsModules.DisableControls;
  CurrentBookMark := DM1.cdsModules.GetBookmark;
  DBGrid1.SelectedRows.Clear;
  DM1.cdsModules.First;
  while not DM1.cdsModules.Eof do
  begin
    DBGrid1.SelectedRows.CurrentRowSelected := true;
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
  DBGrid1.SelectedRows.Clear;
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
  if OpenTextFileDialog1.Execute AND ConfirmNewModuleListFileLoad(false)
    then
      begin
        OpenTextModuleListFile(OpenTextFileDialog1.FileName);
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

procedure TfrmMain.actPackagesEditorExecute(Sender: TObject);
begin
  // Show Packages Editor
  if IsAdminModeEnabled then frmPackagesEditor.ShowModal;
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

  DM1.cdsModules.DisableControls;

  oldIndex := DM1.cdsModules.IndexName;
  DM1.cdsModules.IndexName := 'cdsModulesNumIndexUNIQ'; // Set Num Index

  frmParse.parseSuccess := false;
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
        end
      else BDSIDEModule := nil;


      // Restore IndexName
      if oldIndex = ''
        then DBGrid1TitleClick(DBGrid1.Columns[0])
        else DM1.cdsModules.IndexName := oldIndex;

      tsModulesList.TabVisible := true;
      tsModulesList.Enabled := true;
      PageControl1.ActivePage := tsModulesList;

      ModulesCountDisplay();
      ModulesSelectedCountDisplay();

      DBGrid1.SelectedRows.Clear;
      DM1.cdsModules.EnableControls;
      DM1.cdsModules.First;

    end;

  // actParseModuleFile.Enabled := false;
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

procedure TfrmMain.ModulesSelectedCountDisplay();
begin
  frmMain.lblModulesSelectedCount.Caption := 'Selected count: ' + IntToStr(frmMain.DBGrid1.SelectedRows.Count);
end;

procedure TfrmMain.ModulesCountDisplay();
begin
  frmMain.lblModulesCount.Caption := 'Modules count: ' + IntToStr(DM1.cdsModules.RecordCount);
end;

procedure TfrmMain.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
Var
  wi, sw, i : Integer;
begin
  // Rize Column width if text is a long
  wi := 10 + DBGrid1.Canvas.TextExtent(Column.Field.DisplayText).cx;
  if wi > column.Width
  then
    begin
      sw := 0;
      for i := 0 to DBGrid1.Columns.Count - 1 do
        if DBGrid1.Columns[i].Visible AND (DBGrid1.Columns[i] <> Column)
          then sw := sw + DBGrid1.Columns[i].Width;
      if DBGrid1.Width > sw + wi then Column.Width := wi;
    end;
end;

procedure TfrmMain.DBGrid1Enter(Sender: TObject);
begin
  //  ShowMessage('DBGrid1 Enter');
  // UpdateActionsWithSelectedModels();
end;

procedure TfrmMain.DBGrid1Exit(Sender: TObject);
begin
  // ShowMessage('DBGrid1 Exit');
  // ModulesSelectedCountDisplay();
  // UpdateActionsWithSelectedModels();
end;

procedure TfrmMain.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  // ModulesSelectedCountDisplay();
  // ShowMessage('DBGrid1 KeyPress');
end;

procedure TfrmMain.DBGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  // ShowMessage('DBGrid1 KeyUp');
  // UpdateActionsWithSelectedModels();
end;

procedure TfrmMain.DBGrid1MouseActivate(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y, HitTest: Integer;
  var MouseActivate: TMouseActivate);
begin
  // ShowMessage('DBGrid1 MouseActivate');
  // MouseActivate := maActivate;
  // inherited;
  // if Shift = [ssCtrl, ssShift, ssLeft] then
  if Shift = [ssShift] then
  begin
    // ShowMessage('ssCtrl, ssShift, ssLeft');
    // frmMain.ModelsGridSelectRange;
  end;
end;

procedure TfrmMain.DBGrid1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  // ShowMessage('DBGrid1 MouseDown');
end;

procedure TfrmMain.DBGrid1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  // ShowMessage('DBGrid1 MouseUp');
  // ModulesSelectedCountDisplay();
  // inherited;
end;

procedure TfrmMain.DBGrid1TitleClick(Column: TColumn);
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
          DBGrid1.Columns[DBGrid1_PrevCol].Title.Font.Style :=
            DBGrid1.Columns[DBGrid1_PrevCol].Title.Font.Style - [fsBold];
          DBGrid1.Columns[DBGrid1_PrevCol].Title.Caption := DBGrid1.Columns[DBGrid1_PrevCol].FieldName;
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
      DBGrid1.SelectedRows.Clear; // Clear Selected Rows TEMPORARILY
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

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // Close the Application
  DragAcceptFiles(Self.Handle, False);
  ModulesArrayClear();
  DeleteTempReportFolder();
  if SaveSattingsToRegistry()
    then Logger.AddToLog('Application settings successfuly saved')
    else Logger.AddToLog('[Error] Can''t save application settings');
  Logger.AddToLog('Application closed');
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

  // Logger
  Logger := TMyLogger.Create;
  Logger.LogMemo := frmMain.memoLog;
  Logger.LogFile := TPath.GetDirectoryName(Application.ExeName) +
    TPath.DirectorySeparatorChar +
    TPath.GetFileNameWithoutExtension(Application.ExeName) + '.log';
  lbedLogPath.Text := Logger.LogFile;
  Logger.Clear;

  var loadSettingsRes := LoadSattingsFromRegistry();
  UpdateObjectsAccordingSettings();

  Logger.LogEnabled := cbCreateLog.Checked;
  Logger.AddToLog('Application started');
  if loadSettingsRes
    then Logger.AddToLog('Application settings successfuly loaded')
    else Logger.AddToLog('[Error] Can''t load application settings');

  if GlobalMaximizeOnStartup
    then frmMain.WindowState := TWindowState.wsMaximized
    else frmMain.WindowState := TWindowState.wsNormal;
  Caption := 'IDE Module Parser' + ' ' + GetFileVersionStr(Application.ExeName);

  MemoTxtModuleFile.Clear;

  lblStartMessageSecondary.Caption := 'QPInfo Report QPInfo-ХХХХХХХХ-0000.zip file' + #13 +
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

  DragAcceptFiles(Self.Handle, True);
  AskConfirmOpenForAll := false;

  TFormatSettings.Create;

  DBGrid1.OnSelectionChanged := ModulesGridSelectionChanged;
end;

procedure TfrmMain.FormResize(Sender: TObject);
begin
  lblStartMessageMain.Top := lblStartMessageSecondary.Top - lblStartMessageMain.Height -
    lblStartMessageSecondary.Margins.Top - lblStartMessageMain.Margins.Bottom -
      lblStartMessageMain.Margins.Top;
end;

procedure TfrmMain.ModulesGridSelectionChanged(Sender: TObject);
begin
  // Caption := IntToStr(TDBGrid(Sender).SelectedRows.Count);
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
  // pnlStartMessage.Visible := false;
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
  GlobalDefaultFontSize := tbFontSize.Position;
  edtFontSize.Text := IntToStr(GlobalDefaultFontSize);
  MemoTxtModuleFile.Font.Size := GlobalDefaultFontSize;
  memoStackTrace.Font.Size := GlobalDefaultFontSize;
  memoDescription.Font.Size := GlobalDefaultFontSize;
  memoDXDiagLog.Font.Size := GlobalDefaultFontSize;
  memoSteps.Font.Size := GlobalDefaultFontSize;
  memoLog.Font.Size := GlobalDefaultFontSize;
  DBGrid1.Font.Size := GlobalDefaultFontSize;

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
  if not frmMain.DBGrid1.Visible then Exit;

  // Enable/Disable action - Modules Select All
  if (frmMain.DBGrid1.DataSource.DataSet.RecordCount > 0) AND
    (frmMain.DBGrid1.DataSource.DataSet.RecordCount <> frmMain.DBGrid1.SelectedRows.Count)
    then frmMain.actModulesSelectAll.Enabled := true
    else frmMain.actModulesSelectAll.Enabled := false;
  // Enable action - Modules UnSelect All
  if (frmMain.DBGrid1.DataSource.DataSet.RecordCount > 0) AND
    (frmMain.DBGrid1.SelectedRows.Count < frmMain.DBGrid1.DataSource.DataSet.RecordCount)
    then frmMain.actModulesUnSelectAll.Enabled := true;
  // Enable action - Modules Copy Selected As Text
  if (frmMain.DBGrid1.DataSource.DataSet.RecordCount > 0) AND
    (frmMain.DBGrid1.SelectedRows.Count > 0)
    then frmMain.actModulesCopySelectedAsText.Enabled := true;
  // Enable action - Modules Add to Known Modules DB
  if (frmMain.DBGrid1.DataSource.DataSet.RecordCount > 0) AND
    (frmMain.DBGrid1.SelectedRows.Count > 0)
    then frmMain.actModulesAddSelectedToDB.Enabled := true;

  if (frmMain.DBGrid1.DataSource.DataSet.RecordCount > 0) AND
    (frmMain.DBGrid1.SelectedRows.Count = 0)
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
  tbFontSize.Position := GlobalDefaultFontSize;
  cbCreateLog.Checked := GlobalLogCreate;
  cbMaximizeOnStartup.Checked := GlobalMaximizeOnStartup;
  cbParseFileOnOpen.Checked := GlobalParseOnFileOpen;
  cbParseLevel2.Checked := GlobalModulesCompareLevel2;
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
  with frmMain.DBGrid1 do
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
