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
    Panel3: TPanel;
    PageControl1: TPageControl;
    TabModuleListFile: TTabSheet;
    TabModulesList: TTabSheet;
    tsDXDiagLog: TTabSheet;
    TabLog: TTabSheet;
    tbFontSize: TTrackBar;
    lblFontSize: TLabel;
    edtFontSize: TEdit;
    ledtBDSBuild: TLabeledEdit;
    ledtBDSPath: TLabeledEdit;
    ledtBDSInstDate: TLabeledEdit;
    memoLog: TMemo;
    Panel4: TPanel;
    lbedLogPath: TLabeledEdit;
    actParseCancel: TAction;
    tsStackTrace: TTabSheet;
    OpenDialog1: TOpenDialog;
    Panel5: TPanel;
    lbedStackTraceFile: TLabeledEdit;
    memoStackTrace: TMemo;
    Panel6: TPanel;
    lbedDXDiagFile: TLabeledEdit;
    memoDXDiag: TMemo;
    tsDescription: TTabSheet;
    tsSteps: TTabSheet;
    Panel7: TPanel;
    lbedStepFile: TLabeledEdit;
    Panel8: TPanel;
    LabeledEdit1: TLabeledEdit;
    memoDescription: TMemo;
    memoSteps: TMemo;
    DBGrid1: TDBGrid;
    procedure FormCreate(Sender: TObject);
    /// <summary>Exit from application</summary>
    procedure actExitExecute(Sender: TObject);
    /// <summary>Open Module text file (ModuleList.txt) via Open File Dialog</summary>
    procedure actOpenModuleFileExecute(Sender: TObject);
    /// <summary>Open Repot Zip file (QPInfo-XXXXXXXX-XXXX.zip) via Open File Dialog</summary>
    procedure actOpenReportZipFileExecute(Sender: TObject);
    /// <summary>Parse Module file</summary>
    procedure actParseModuleFileExecute(Sender: TObject);
    /// <summary>Module file changed, update display FileName</summary>
    procedure UpdateDisplayFileName();
    /// <summary>Load new Text Module file</summary>
    procedure LoadTxtModuleFile();
    procedure tbFontSizeChange(Sender: TObject);
    /// <summary>Enable Font Size Change</summary>
    procedure EnableFontSizeChange();
    /// <summary>Disable Font Size Change</summary>
    procedure DisableFontSizeChange();
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    /// <summary>Drag and Drop TXT or ZIP files in App</summary>
    procedure WMDropFiles(var Msg: TWMDropFiles); message WM_DROPFILES;
    /// <summary>Confirm new Txt Module file load</summary>
    function ConfirmNewTxtModuleFileLoad : boolean;

    function AddAllModulesToStringGrid : boolean;

    procedure OpenTextModuleFile(Sender: TObject);
    procedure OpenZipReportFile(Sender: TObject);
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
    function TryOpenStepFileInReport(): boolean;

    function FileExistsInReport(var FileName: string): boolean;

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain : TfrmMain;
  mtfFileName : TFileName;  // ModuleList.txt filename
  mzfFileName : TFileName;  // QPInfo-XXXXXXXX-XXXX.zip filename
  Logger : TMyLogger;       // Logger
  ModulesArray : TModulesArray;   // IDE Modules Array
  BDSIDEModule : TIDEModule;      // BDS IDE Module
  ReportFolder : string;          // Report folder for unpack Report Zip
  ReportFilesInZip: TArray<string>;

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

function TfrmMain.ConfirmNewTxtModuleFileLoad : boolean;
begin
  Result := false;
  if (MemoTxtModuleFile.Lines.Text <> '') AND
    (MessageDlg('The ModuleFile is opened. Open another file?', mtConfirmation, mbYesNo, 0) = mrNo)
    then
      begin
        Logger.AddToLog('The opening of a new text ModuleFile has not been confirmed.');
        Exit;
      end;
  Result := true;
end;


procedure TfrmMain.OpenTextModuleFile(Sender: TObject);
begin
  // Open new text ModuleFile.txt file
  if not FileExists(mtfFileName) then Exit;

  UpdateDisplayFileName();
  LoadTxtModuleFile();

  if PageControl1.ActivePage <> TabModuleListFile
    then PageControl1.ActivePage := TabModuleListFile;

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

  TryOpenDescFileInReport();
  TryOpenDXDiagFileInReport();
  TryOpenModuleListFileInReport();
  TryOpenReportDataFileInReport();
  TryOpenStackTraceFileInReport();
  TryOpenStepFileInReport();

end;

procedure TfrmMain.actOpenModuleFileExecute(Sender: TObject);
begin
  // Open Module file (ModuleList.txt)
  if not ConfirmNewTxtModuleFileLoad then Exit;
  if OpenTextFileDialog1.InitialDir = '' then
    OpenTextFileDialog1.InitialDir := TPath.GetDirectoryName(Application.ExeName);
  if OpenTextFileDialog1.Execute then
    mtfFileName := OpenTextFileDialog1.FileName;
  OpenTextModuleFile(Sender);
end;

procedure TfrmMain.actOpenReportZipFileExecute(Sender: TObject);
begin
  // Open Repot Zip file (QPInfo-XXXXXXXX-XXXX.zip) via Open File Dialog
  if not ConfirmNewTxtModuleFileLoad then Exit;

  if OpenDialog1.InitialDir = '' then
    OpenDialog1.InitialDir := TPath.GetDirectoryName(Application.ExeName);
  if OpenDialog1.Execute then
    mzfFileName := OpenDialog1.FileName;
  OpenZipReportFile(Sender);
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
  ledtBDSPath.Text := '';
  ledtBDSBuild.Text := '';
  ledtBDSInstDate.Text := '';

  frmParse.parseSuccess := false;
  frmParse.Show;
  frmParse.ParseModuleListFile();

  if frmParse.parseSuccess
  then
    begin
      TabModulesList.TabVisible := true;

      if FindBDSIDEModule(BDSIDEModule) = true
      then
        begin
          ledtBDSPath.Text := BDSIDEModule.Path;
          ledtBDSBuild.Text := BDSIDEModule.Version;
          ledtBDSInstDate.Text := DateTimeToStr(BDSIDEModule.DateTime);
        end
      else BDSIDEModule := nil;

      for var i := 0 to Length(ModulesArray) - 1 do
        begin
          tempIDEModule := @ModulesArray[i]^;
          DM1.cdsModules.Append;
          DM1.cdsModules.FieldByName('Num').AsInteger := i;
          DM1.cdsModules.FieldByName('Name').AsString := tempIDEModule.FileName;
          DM1.cdsModules.Post;
        end;
      DM1.cdsModules.First;
      TabModulesList.Enabled := true;
      PageControl1.ActivePage := TabModulesList;

    end;
end;

function TfrmMain.AddAllModulesToStringGrid: boolean;
begin
  //
  Result := true;
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
  // ImageList1.GetBitmap(0, Image1.Picture.Bitmap);
  MemoTxtModuleFile.Clear;

  TabModulesList.TabVisible := false;
  tsDXDiagLog.TabVisible := false;
  tsStackTrace.TabVisible := false;
  tsSteps.TabVisible := false;
  tsDescription.TabVisible := false;
  PageControl1.ActivePage := TabModuleListFile;

  // Disable Font Size Change
  EnableFontSizeChange();

  DragAcceptFiles(Self.Handle, True);

  TFormatSettings.Create;
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

procedure TfrmMain.LoadTxtModuleFile;
begin
  // Load new Text Module file
  MemoTxtModuleFile.Lines.LoadFromFile(mtfFileName, TEncoding.UTF8);
  // Enable Parse Action
  actParseModuleFile.Enabled := true;
  // Enable Font Size Change
  EnableFontSizeChange();

  Logger.AddToLog('New Text Module file opened: ' + mtfFileName);
  frmParse.parseSuccess := false;
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
  memoLog.Font.Size := tbFontSize.Position;
end;

function TfrmMain.TryOpenDescFileInReport: boolean;
begin
  //
  var tempFileName := 'desc.txt';
  if FileExistsInReport(tempFileName)
  then
    begin
      // Open desc.txt
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
      mtfFileName := tempFileName;
      OpenTextModuleFile(frmMain);
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
      Result := true;
    end
  else Result := false;
end;

function TfrmMain.TryOpenStepFileInReport: boolean;
begin
  //
  var tempFileName := 'step.txt';
  if FileExistsInReport(tempFileName)
  then
    begin
      // Open step.txt
      Result := true;
    end
  else Result := false;
end;

procedure TfrmMain.UpdateDisplayFileName;
begin
  //
  lbedModuleFile.Text := mtfFileName;

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
  // DroppedFileCount := -1;
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
      Logger.AddToLog('Drag and drop error. Only one TXT or ZIP file accepted.');
      ShowMessage('Please drag and drop only one TXT or ZIP file.');
      Exit;
    end;

  if not ConfirmNewTxtModuleFileLoad then Exit;

  if (FileExtension = '.txt')
  then
    begin
      mtfFileName := FileName;
      OpenTextModuleFile(frmMain);
    end;

  if (FileExtension = '.zip')
  then
    begin
      mzfFileName := FileName;
      OpenZipReportFile(frmMain);
    end;
end;


end.
