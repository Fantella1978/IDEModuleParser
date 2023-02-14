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
  ;

type
  TModulesArray = array of PIDEModule;

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
    TabModulesList: TTabSheet;
    tsDXDiagLogFile: TTabSheet;
    tsLog: TTabSheet;
    ledtBDSBuild: TLabeledEdit;
    ledtBDSPath: TLabeledEdit;
    ledtBDSInstDate: TLabeledEdit;
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
    pnlStartMessage: TPanel;
    lblStartMessageMain: TLabel;
    lblStartMessageSecondary: TLabel;
    tsSettings: TTabSheet;
    Panel3: TPanel;
    lblFontSize: TLabel;
    tbFontSize: TTrackBar;
    edtFontSize: TEdit;
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
    procedure FormCreate(Sender: TObject);
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

  private
    { Private declarations }
    DBGrid1_PrevCol : Integer;
      LinfoSize: DWORD;
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

procedure TfrmMain.actExitExecute(Sender: TObject);
begin
  Close;
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
  PageControl1.ActivePage := tsStackTraceFile;
  UpdateDisplayDxDiagLogFileName();
  LoadTxtDxDiagLogFile();
end;

procedure TfrmMain.OpenTextModuleListFile(FileName: string);
begin
  // Open new text ModuleFile.txt file
  if not FileExists(FileName) OR not ConfirmNewModuleListFileLoad(AskConfirmOpenForAll) then Exit;
  mtfFileName := FileName;
  HideStartMessage;
  MemoTxtModuleFile.Visible := true;
  MemoTxtModuleFile.ScrollBars := ssBoth;
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

end;

procedure TfrmMain.actModulesEditorExecute(Sender: TObject);
begin
  // Show Modules Editor

end;

procedure TfrmMain.actModulesSelectAllExecute(Sender: TObject);
var
  bmark : TBookmark;
begin
  // Select All Modules in grid
  DM1.cdsModules.DisableControls;
  DBGrid1.SelectedRows.Clear;
  DM1.cdsModules.First;
  while not DM1.cdsModules.Eof do
  begin
    DBGrid1.SelectedRows.CurrentRowSelected := true;
    DM1.cdsModules.Next;
  end;
  DM1.cdsModules.EnableControls;
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
      end;
end;

procedure TfrmMain.actOpenReportZipFileExecute(Sender: TObject);
begin
  // Open Repot Zip file (QPInfo-XXXXXXXX-XXXX.zip) via Open File Dialog
  if OpenDialog1.InitialDir = '' then
    OpenDialog1.InitialDir := TPath.GetDirectoryName(Application.ExeName);
  if OpenDialog1.Execute then
    mzfFileName := OpenDialog1.FileName;
  OpenZipReportFile(Sender);
end;

procedure TfrmMain.actPackagesEditorExecute(Sender: TObject);
begin
  // Show Packages Editor
  frmPackagesEditor.ShowModal;
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
  tempIDEModule : TIDEModule;
begin
  // Parse Module file

  if (DM1.cdsModules.RecordCount > 0) AND
    (MessageDlg('Modules list not empty. Clear modules list and parse ModulesList file?',
       mtConfirmation, [mbYes, mbNo], 0) in [mrNo, mrCancel])
    then Exit;

  ledtBDSPath.Text := '';
  ledtBDSBuild.Text := '';
  ledtBDSInstDate.Text := '';

  frmParse.parseSuccess := false;
  frmParse.Show;
  frmParse.ParseModuleListFile();

  if frmParse.parseSuccess
  then
    begin
      DM1.cdsModules.First;

      TabModulesList.TabVisible := true;
      TabModulesList.Enabled := true;
      PageControl1.ActivePage := TabModulesList;

      if FindBDSIDEModule(BDSIDEModule) = true
      then
        begin
          ledtBDSPath.Text := BDSIDEModule.Path;
          ledtBDSBuild.Text := BDSIDEModule.Version;
          ledtBDSInstDate.Text := DateTimeToStr(BDSIDEModule.DateTime);
        end
      else BDSIDEModule := nil;
    end;
  actParseModuleFile.Enabled := false;
end;

procedure TfrmMain.actModulesCopySelectedAsTextExecute(Sender: TObject);
begin
  frmCopyAsText.ShowModal;
end;

procedure TfrmMain.cbCreateLogClick(Sender: TObject);
begin
  if cbCreateLog.Checked
  then
    begin
      tsLog.TabVisible := true;
      Logger.LogEnabled := cbCreateLog.Checked;
      Logger.AddToLog('Logging enabled.');
      // tsLog.Visible := true;
      // tsLog.Enabled := true;
    end
  else
    begin
      tsLog.TabVisible := false;
      Logger.AddToLog('Logging disabled.');
      Logger.LogEnabled := cbCreateLog.Checked;
      // tsLog.Visible := false;
      // tsLog.Enabled := false;
    end;
end;

procedure TfrmMain.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
Var
  wi, sw, i : Integer;
begin
  // Rize Column width if text is a long
  wi := 5 + DBGrid1.Canvas.TextExtent(Column.Field.DisplayText).cx;
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

procedure TfrmMain.DBGrid1TitleClick(Column: TColumn);
var
  ci : integer;
begin
  if column.FieldName = 'Hash' then Exit;
  
  with DM1.cdsModules do
    try
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
      if Column.Title.Caption = Column.FieldName + ' ˅'
        then Column.Title.Caption := Column.FieldName + ' ˄'
        else Column.Title.Caption := Column.FieldName + ' ˅';
      DisableControls;

      if IndexName = 'cdsModules' + Column.FieldName + 'Index'
        then IndexName := 'cdsModules' + Column.FieldName + 'IndexASC'
        else IndexName := 'cdsModules' + Column.FieldName + 'Index';
      {
      if Column.FieldName = 'Name'
        then
          if IndexName = 'cdsModulesNameIndex'
            then IndexName := 'cdsModulesNameIndexASC'
            else IndexName := 'cdsModulesNameIndex';
      if Column.FieldName = 'Path'
        then
          if IndexName = 'cdsModulesPathIndex'
            then IndexName := 'cdsModulesPathIndexASC'
            else IndexName := 'cdsModulesPathIndex';
      if Column.FieldName = 'Version'
        then
          if IndexName = 'cdsModulesVersionIndex'
            then IndexName := 'cdsModulesVersionIndexASC'
            else IndexName := 'cdsModulesVersionIndex';
      if Column.FieldName = 'DateAndTime'
        then
          if IndexName = 'cdsModulesDateAndTimeIndex'
            then IndexName := 'cdsModulesDateAndTimeIndexASC'
            else IndexName := 'cdsModulesDateAndTimeIndex';
      }
    finally
      First;
      EnableControls
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
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  //
  if not DM1.cdsModules.Active then DM1.cdsModules.Open;
  Caption := 'IDE Module Parser' + ' ' + GetFileVersionStr(Application.ExeName);
  // ImageList1.GetBitmap(0, Image1.Picture.Bitmap);
  MemoTxtModuleFile.Clear;

  lblStartMessageSecondary.Caption := 'QPInfo Report QPInfo-ХХХХХХХХ-0000.zip file' + #13 +
    'or separately' + #13 +
    'ModuleList.txt, StackTrace.txt, DXDiag_log.txt,' +#13 +
    'Desc.txt, Step.txt, ReportData.xml files.';

  TabModulesList.TabVisible := false;
  tsDXDiagLogFile.TabVisible := false;
  tsStackTraceFile.TabVisible := false;
  tsStepsFile.TabVisible := false;
  tsDescriptionFile.TabVisible := false;
  PageControl1.ActivePage := tsModuleListFile;

  // Disable Font Size Change
  EnableFontSizeChange();

  DragAcceptFiles(Self.Handle, True);
  AskConfirmOpenForAll := false;

  TFormatSettings.Create;
  // Logger
  cbCreateLog.Checked := true;
  Logger := TMyLogger.Create;
  Logger.LogMemo := frmMain.memoLog;
  Logger.LogFile := TPath.GetDirectoryName(Application.ExeName) +
    TPath.DirectorySeparatorChar +
    TPath.GetFileNameWithoutExtension(Application.ExeName) + '.log';
  lbedLogPath.Text := Logger.LogFile;
  Logger.Clear;
  Logger.AddToLog('Application started');
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
  pnlStartMessage.Visible := false;
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

  TabModulesList.TabVisible := false;
  TabModulesList.Enabled := false;
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
  edtFontSize.Text := IntToStr(tbFontSize.Position);
  MemoTxtModuleFile.Font.Size := tbFontSize.Position;
  memoStackTrace.Font.Size := tbFontSize.Position;
  memoDescription.Font.Size := tbFontSize.Position;
  memoDXDiagLog.Font.Size := tbFontSize.Position;
  memoSteps.Font.Size := tbFontSize.Position;
  memoLog.Font.Size := tbFontSize.Position;
  DBGrid1.Font.Size := tbFontSize.Position;
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


end.
