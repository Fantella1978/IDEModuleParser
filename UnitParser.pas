unit UnitParser;

interface

{comment to UTF-8 convert: конвертирование}

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls
  , System.RegularExpressionsCore
  , UnitIDEModule
  , Data.DB
  , FireDAC.Stan.Param
  , System.Generics.Collections
  , System.Diagnostics
  , UnitFormatStackTrace
  ;

type
  TCurrentModulePackageInfo = record
    ID: Integer;
    Name: string;
    Type_ID: Integer;
  end;

  TfrmParse = class(TForm)
    Panel1: TPanel;
    pBarOverall: TProgressBar;
    btnStop: TButton;
    lblOverall: TLabel;
    pBarCurrentTask: TProgressBar;
    lblCurrentTask: TLabel;
    procedure ParseModuleListFile();
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    function GetModuleLineRegExp(): string;
    procedure ShowCurrentTaskName(name: string);
    procedure StartAllTasks;
    procedure StartTask(taskName: string);
    procedure EndAllTasks;
    procedure EndTask;
    procedure SetCurrentTaskPosition(Position: integer);
    procedure SetCurrentTaskPositionsMinMax(PosMin, PosMax : integer);
  private
    { Private declarations }
    FCurrentModulePackage: TCurrentModulePackageInfo;
    Fregexp: TPerlRegEx;
    FTaskName: string;
    FTaskNum: Integer;
    FTasksCount: Integer;
    function GetOverallTaskPosition(): Integer;
    function DetermineCurrentModule: boolean;
    function GetKnownModulesForFileName(AFileName: string): boolean;
    function DetermineCurrentModuleLevel1() : boolean;
    function DetermineCurrentModuleLevel2() : boolean;
    function SaveCurrentModuleData : boolean;
    function TaskModuleFileParse(): boolean;
    function TaskCreateModulesDB(): boolean;
    function TaskFindAllKnowModules(): boolean;
    function TaskFindAllUsedPackages: boolean;
    function TaskFindModulesByFileNameRegExp: boolean;
    function TaskCreateFormattedStackTraceView(AMemo: TMemo): boolean;
    function DetermineModulesByFileNameRegExp: boolean;
    procedure SkipTask;
    function GetModules3rdPartyList: TStringList;
    function GetModulesUnknownList: TStringList;
  public
    { Public declarations }
    parseCanceled: boolean;
    parseSuccess: boolean;
    MFListIsVIList : boolean; // Modules File List copied from the RS Version Information text
    SW: TStopwatch;           // TStopwatch System.Diagnostics - One Task
    SWAll: TStopwatch;        // TStopwatch System.Diagnostics - All Tasks
  end;

var
  frmParse: TfrmParse;

implementation

{$R *.dfm}

uses
  UnitMain
  , UnitDB
  , System.IOUtils
  , UnitSettings
  ;

{ TfrmParse }

procedure TfrmParse.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if parseCanceled OR parseSuccess
  then
    begin
      CanClose := true;
      Exit;
    end
  else
    begin
      frmMain.actParseCancelExecute(Sender);
      if parseCanceled
        then CanClose := true
        else CanClose := false;
    end;
end;

procedure TfrmParse.FormShow(Sender: TObject);
begin
  pBarCurrentTask.Position := 0;
  pBarOverall.Position := 0;
  if FTasksCount < 3 then FTasksCount := 3;
  if FTaskNum < 1 then FTaskNum := 1;
end;

function TfrmParse.GetModuleLineRegExp: string;
begin

  case MFListIsVIList of
    false:
      // Modules File List opened from crash report
      //
      // (.*)\t\(\d{1}x[0-9A-F]{8,16}\)\t([^\t]*)\t(?:(\d{1,6}\.\d{1,6}\.\d{1,6}\.\d{1,6})\t)?(\d{1,2}[\/\-\.]\d{1,2}[\/\-\.]\d{2,4})[\.]?\s*(\d{1,2}:\d{1,2}:\d{1,2}(?:\s*[\S]{2})?)\t([\dA-F]{40})

      Result := '(.*)\t' +                                // Groups[1] - file name
        '\(\d{1}x[0-9A-F]{8,16}\)\t' +                    //
        '([^\t]*)\t' +                                    // Groups[2] - path
        '(?:(\d{1,6}\.\d{1,6}\.\d{1,6}\.\d{1,6})\t)?' +   // Groups[3] - version
//        '(\d{1,4}[\/\-\.](?:\d{1,2}|[A-Z,a-z]{3})[\/\-\.]\d{1,4})[\.]?\s*' +          // Groups[4] - date
//        '((?:\s*[\S]{2}\s*)?\d{1,2}[\:\.]\d{1,2}[\:\.]\d{1,2}(?:\s*[\S]{2})?|)\t' +   // Groups[5] - time
        '(.*)\t' + // Groups[4] - date & time
        '([\dA-F]{40})';                                  // Groups[5] - hash

    true:
      // Modules File List copied from the RS Version Information text
      //
      // (.*),\s(\d{1,6}\.\d{1,6}\.\d{1,6}\.\d{1,6}|),\s(.*)

      Result := '(.*),\s' +                               // Groups[1] - file name
        '(\d{1,6}\.\d{1,6}\.\d{1,6}\.\d{1,6}|),\s' +      // Groups[2] - version
        '(.*)';                                           // Groups[3] - path
  end;


end;

function TfrmParse.GetOverallTaskPosition: Integer;
begin
  //
  Result := Round(100 / FTasksCount) * (FTaskNum - 1) +
          Round(100 / FTasksCount * pBarCurrentTask.Position / pBarCurrentTask.Max) ;
end;

procedure TfrmParse.ParseModuleListFile;
begin

  FTasksCount := 4;
  if GlobalModulesCompareLevel3 then inc(FTasksCount);          // for Task #4
  if frmMain.tsStackTraceFile.TabVisible then inc(FTasksCount); // for Task #6

  // Tasks
  StartAllTasks;
  TaskModuleFileParse();                // Task #1
  TaskCreateModulesDB();                // Task #2
  TaskFindAllKnowModules();             // Task #3
  TaskFindModulesByFileNameRegExp();    // Task #4 - can be skipped
  TaskFindAllUsedPackages();            // Task #5
  TaskCreateFormattedStackTraceView(frmMain.memoStackTrace);  // Task #6
  EndAllTasks;

  frmParse.Close;
end;

procedure TfrmParse.SetCurrentTaskPosition(Position: integer);
begin
  pBarCurrentTask.Position := Position;
  pBarOverall.Position := GetOverallTaskPosition();
  if ((Position mod 10) = 0) or (Position = pBarCurrentTask.Max) then
    Application.ProcessMessages;
end;

procedure TfrmParse.SetCurrentTaskPositionsMinMax(PosMin, PosMax: integer);
begin
  pBarCurrentTask.Position := PosMin;
  pBarCurrentTask.Max := PosMax;
end;

procedure TfrmParse.ShowCurrentTaskName(name: string);
begin
  FTaskName := name;
  lblCurrentTask.Caption := name;
end;

procedure TfrmParse.StartTask(taskName: string);
begin
  SW := TStopwatch.StartNew;
  inc(FTaskNum);
  ShowCurrentTaskName(taskName);
  Logger.AddToLog('Task #' + FTaskNum.ToString + ': ' + taskName + '. Started.');
  SetCurrentTaskPosition(0);
end;

procedure TfrmParse.StartAllTasks;
begin
  Logger.AddToLog('Parse module list file. Stared.');
  frmMain.actParseCancel.Enabled := true;
  parseCanceled := not frmMain.actParseCancel.Enabled;

  SWAll := TStopwatch.StartNew;
  pBarOverall.Max := 100;
  pBarOverall.Position := 0;
  FTaskNum := 0;
end;

function TfrmParse.GetModules3rdPartyList(): TStringList;
begin
  Result := TStringList.Create;
  with DM1.cdsModules do
  begin
    First;
    while not Eof do
    begin
      if FieldByName('PackageType_ID').AsInteger in [THIRDPARTY_PACKAGES_TYPE_ID, THIRDPARTY_PACKAGES_WITH_GETIT_TYPE_ID]
        then Result.Add(FieldByName('FileName').AsString);
      Next;
    end;
  end;
end;

function TfrmParse.GetModulesUnknownList: TStringList;
begin
  Result := TStringList.Create;
  with DM1.cdsModules do
  begin
    First;
    while not Eof do
    begin
      if FieldByName('PackageType_ID').AsInteger = -1
        then Result.Add(FieldByName('FileName').AsString);
      Next;
    end;
  end;
end;

function TfrmParse.TaskCreateFormattedStackTraceView(AMemo: TMemo): boolean;
var
  i: integer;
  FSTView: TFormattedStackTraceView;
begin
  Result := false;
  if not frmMain.tsStackTraceFile.TabVisible then
  begin
    SkipTask();
    Exit(true);
  end;
  if parseCanceled then Exit;
  StartTask('Stack Trace formatting');
  FSTView := TFormattedStackTraceView.Create(frmMain.reStackTrace);
  try
    FSTView.Clear;
    FSTView.FModules3rdPartyList := GetModules3rdPartyList();
    FSTView.FModulesUnknownList := GetModulesUnknownList();
    SetCurrentTaskPositionsMinMax(0, AMemo.Lines.Count - 1);
    for I := 0 to AMemo.Lines.Count - 1 do
    begin
      FSTView.AddLine(AMemo.Lines[i]);
      SetCurrentTaskPosition(i);
      if parseCanceled then Break;
    end;
    if not parseCanceled then FSTView.Activate;
    EndTask();
  finally
    FSTView.Free;
  end;
  Result := true;
end;

function TfrmParse.TaskCreateModulesDB: boolean;
var
  tempIDEModule : TIDEModule;
  i: integer;
begin
  Result := false;
  if parseCanceled then Exit;
  StartTask('Copy modules to DB');
  SetCurrentTaskPositionsMinMax(0, Length(ModulesArray) - 1);
  DM1.cdsModules.DisableControls;
  DM1.ClearModulesDB;
  for i := 0 to Length(ModulesArray) - 1 do
    begin
      tempIDEModule := @ModulesArray[i]^;
      with DM1.cdsModules do
      begin
        Append;
        FieldByName('Module_ID').AsInteger := i;
        FieldByName('FileName').AsString := tempIDEModule.FileName;
          // UpperCase(TPath.GetFileNameWithoutExtension(tempIDEModule.FileName)) +
          // LowerCase(TPath.GetExtension(tempIDEModule.FileName));
        if Length(tempIDEModule.Path) < 255
          then FieldByName('Path').AsString := LowerCase(tempIDEModule.Path)
          else FieldByName('Path').AsString := LowerCase(copy(tempIDEModule.Path, 1, 255));
        FieldByName('Version').AsString := tempIDEModule.Version;
        FieldByName('DateAndTime').AsDateTime := tempIDEModule.DateTime;
        FieldByName('Hash').AsString := tempIDEModule.Hash;
        FieldByName('Package_ID').AsInteger := -1;
        FieldByName('PackageName').AsString := '';
        FieldByName('PackageType_ID').AsInteger := -1;
        Post;
      end;
      SetCurrentTaskPosition(i);
      if parseCanceled then Break;
    end;
  DM1.cdsModules.First;
  DM1.cdsModules.EnableControls;

  EndTask();
  Result := true;
end;

function TfrmParse.GetKnownModulesForFileName(AFileName: string) : boolean;
begin
  {
    SELECT m.*, p.Package_ID AS Package_ID, p.Name AS PackageName
    FROM Modules AS m LEFT OUTER JOIN Packages AS p ON m.Package_ID=p.Package_ID
    WHERE lower(m.FileName)="bds.exe"
  }
  with DM1.fdqModulesFromQuery do
  begin
    if Active then Close;
    SQL.Clear;
    SQL.Add(
      'SELECT m.*, p.Package_ID AS Package_ID, p.Name AS PackageName, p.SubName AS PackageSubName, pt.Type_ID AS PackageType_ID, ' +
      'p.Version AS PackageVersion ' +
      'FROM Modules AS m ' +
      'LEFT JOIN Packages AS p ON m.Package_ID=p.Package_ID ' +
      'LEFT JOIN PackageTypes AS pt ON p.Type_ID=pt.Type_ID ' +
      'WHERE lower(m.FileName)= :FileName' +
      ';');
    ParamByName('FileName').AsString := AFileName;
    Open;
  end;

  Result := true;
end;

function TfrmParse.DetermineCurrentModuleLevel1() : boolean;
begin
  with DM1.fdqModulesFromQuery do
    if RecordCount > 0
    then
      begin
        FCurrentModulePackage.ID := FieldByName('Package_ID').AsInteger;
        FCurrentModulePackage.Name := FieldByName('PackageName').AsString;
        FCurrentModulePackage.Type_ID := FieldByName('PackageType_ID').AsInteger;
      end;
  Result := true;
end;

function TfrmParse.SaveCurrentModuleData() : boolean;
begin
  if (FCurrentModulePackage.ID = -1) AND (FCurrentModulePackage.Name = '') then
    Exit(false);
  with DM1.cdsModules do
  begin
    Edit;
    FieldByName('Package_ID').AsInteger := FCurrentModulePackage.ID;
    FieldByName('PackageName').AsString := FCurrentModulePackage.Name;
    FieldByName('PackageType_ID').AsInteger := FCurrentModulePackage.Type_ID;
  end;
  Result := true;
end;

function TfrmParse.DetermineCurrentModuleLevel2() : boolean;
var
  i : integer;
  AVersion : string;
begin
  with DM1.fdqModulesFromQuery do
  begin
    if RecordCount = 0 then Exit(false);
    AVersion := DM1.cdsModules.FieldByName('Version').AsString;
    First;
    for i := 0 to RecordCount - 1 do
    begin
      if parseCanceled then Exit(false);
      if AVersion = FieldByName('Version').AsString
      then
        begin
          FCurrentModulePackage.ID := FieldByName('Package_ID').AsInteger;
          FCurrentModulePackage.Type_ID := FieldByName('PackageType_ID').AsInteger;
          FCurrentModulePackage.Name := FieldByName('PackageName').AsString;
          if FieldByName('PackageSubName').AsString <> ''
            then FCurrentModulePackage.Name := FCurrentModulePackage.Name + ' ' + FieldByName('PackageSubName').AsString;
          Break;
        end;
      Next;
    end;
  end;
  Result := true;
end;

function TfrmParse.DetermineCurrentModule() : boolean;
begin
  FCurrentModulePackage.ID := -1;
  FCurrentModulePackage.Name := '';
  FCurrentModulePackage.Type_ID := -1;

  GetKnownModulesForFileName(LowerCase(DM1.cdsModules.FieldByName('FileName').AsString));
  // Determine Module Level 2
  if GlobalModulesCompareLevel2 then DetermineCurrentModuleLevel2();
  // Determine Module Level 1
  if FCurrentModulePackage.ID = -1 then DetermineCurrentModuleLevel1();
  // Save Module
  SaveCurrentModuleData();

  Result := true;
end;

function TfrmParse.DetermineModulesByFileNameRegExp() : boolean;
begin
  if parseCanceled then Exit(false);
  if DM1.cdsModules.RecordCount = 0 then Exit(false);
  DM1.cdsModules.First;
  with Fregexp do
  begin
    Options := [preCaseLess, preNoAutoCapture];
    RegEx := '^' + DM1.fdqModulesFromQuery.FieldByName('FileNameRegExp').AsString + '$';
    while not DM1.cdsModules.Eof do
    begin
      if parseCanceled then Exit(false);
      Subject := DM1.cdsModulesFileName.AsString;
      if Match
      then
        begin
          // Module File Name Match RegExp
          DM1.cdsModules.Edit;
          DM1.cdsModulesPackage_ID.AsInteger := DM1.fdqModulesFromQuery.FieldByName('Package_ID').AsInteger;
          DM1.cdsModulesPackageName.AsString := DM1.fdqModulesFromQuery.FieldByName('PackageName').AsString;
          DM1.cdsModulesPackageType_ID.AsInteger := DM1.fdqModulesFromQuery.FieldByName('PackageType_ID').AsInteger;
          // ShowMessage('Found module ' + Subject + ' by RegExp: ' + RegEx);
          Logger.AddToLog('Module found by FileNameRegExp: ' + Subject);
          Break;
        end;
      DM1.cdsModules.Next;
    end;
  end;
  Result := true;
end;


procedure TfrmParse.SkipTask();
begin
  SetCurrentTaskPositionsMinMax(0, 100);
  SetCurrentTaskPosition(100);
  Logger.AddToLog('Task #' + FTaskNum.ToString + ': ' + FTaskName + '. Skipped.');
  inc(FTaskNum);
end;

procedure TfrmParse.EndAllTasks;
begin
  SWAll.Stop;
  if not parseCanceled
    then Logger.AddToLog('Parse module list file. Success. [' + format('%f', [SWAll.Elapsed.TotalSeconds]) + ' sec]')
    else Logger.AddToLog('Parse module list file. Canceled.');

  frmMain.actParseCancel.Enabled := false;
  parseSuccess := true;
end;

procedure TfrmParse.EndTask();
begin
  SW.Stop;
  if not parseCanceled
    then Logger.AddToLog('Task #' + FTaskNum.ToString + ': ' + FTaskName + '. Success. [' +
      format('%f', [SW.Elapsed.TotalSeconds]) + ' sec]')
    else Logger.AddToLog('Task #' + FTaskNum.ToString + ': ' + FTaskName + '. Canceled.');
end;

function TfrmParse.TaskFindModulesByFileNameRegExp() : boolean;
var
  id: integer;
begin
  Result := false;
  if not GlobalModulesCompareLevel3 then
    begin
      SkipTask();
      Exit(true);
    end;
  if parseCanceled then Exit;
  StartTask('Find known modules in DB (RegExp method)');

  Fregexp := TPerlRegEx.Create;
  try
    Logger.AddToLog('Find known modules by FileName RegExp in DB started.');
    DM1.cdsModules.DisableControls;
    DM1.cdsModules.Filter := 'Package_ID = -1';
    DM1.cdsModules.Filtered := true;

    with DM1.fdqModulesFromQuery do
    begin
      if Active then Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM ModulesWithFileNameRegExp'); // Use SQLite Views
      {
      SQL.Add(
        'SELECT m.FileNameRegExp as FileNameRegExp, ' +
        'p.Package_ID AS Package_ID, p.Name AS PackageName, pt.Type_ID AS PackageType_ID ' +
        'FROM Modules AS m ' +
        'LEFT JOIN Packages AS p ON m.Package_ID=p.Package_ID ' +
        'LEFT JOIN PackageTypes AS pt ON p.Type_ID=pt.Type_ID ' +
        'WHERE m.FileNameRegExp<>""' +
        ';');
      }
      Open;
      Last;
      SetCurrentTaskPositionsMinMax(0, RecordCount - 1);
      First;
      id := -1;
      while not Eof do
      begin
        inc(id);
        SetCurrentTaskPosition(id);
        if not DetermineModulesByFileNameRegExp() or parseCanceled
          then Break;
        Next;
      end;
      Close;
    end;

    DM1.cdsModules.Filter := '';
    DM1.cdsModules.Filtered := false;
    DM1.cdsModules.First;
    DM1.cdsModules.EnableControls;

  finally
    Fregexp.Free;
  end;

  EndTask();
  Result := true;
end;

function TfrmParse.TaskFindAllUsedPackages: boolean;
var
  tmpPackage: TModulesPackage;
begin
  Result := false;
  if parseCanceled then Exit;
  StartTask('Find known Packages');
  SetCurrentTaskPositionsMinMax(0, DM1.cdsModules.RecordCount - 1);
  DM1.cdsModules.DisableControls;
  DM1.cdsModules.First;
  var i := -1;
  DM1.cdsModules.Filter := 'Package_ID is not NULL';
  DM1.cdsModules.Filtered := true;
  frmMain.FModulesPackages := [];
  while not DM1.cdsModules.Eof do
  begin
    if parseCanceled then Break;
    inc(i);
    SetCurrentTaskPosition(i);
    if DM1.cdsModules.FieldByName('Package_ID').AsInteger <> -1
    then
      begin
        tmpPackage.Package_ID := DM1.cdsModules.FieldByName('Package_ID').AsInteger;
        tmpPackage.PackageName := string(DM1.cdsModules.FieldByName('PackageName').AsString);
        tmpPackage.PackageType_ID := DM1.cdsModules.FieldByName('PackageType_ID').AsInteger;
        tmpPackage.PackageVersion := string(DM1.cdsModules.FieldByName('PackageVersion').AsString);

        {if not TModulesPackage.FindSame<TModulesPackage>(tmpPackage, frmMain.FModulesPackages)
          then frmMain.FModulesPackages := frmMain.FModulesPackages + [tmpPackage];}

        if not TModulesPackage.FindSame(tmpPackage, frmMain.FModulesPackages)
          then frmMain.FModulesPackages := frmMain.FModulesPackages + [tmpPackage];
      end;
    DM1.cdsModules.Next;
  end;

  DM1.cdsModules.Filter := '';
  DM1.cdsModules.Filtered := false;
  DM1.cdsModules.First;
  DM1.cdsModules.EnableControls;

  EndTask();
  Result := true;
end;

function TfrmParse.TaskFindAllKnowModules: boolean;
begin
  Result := false;
  if parseCanceled then Exit;
  StartTask('Find all known modules in DB');
  SetCurrentTaskPositionsMinMax(0, DM1.cdsModules.RecordCount - 1);
  DM1.cdsModules.DisableControls;
  DM1.cdsModules.First;
  var i := -1;
  while not DM1.cdsModules.Eof do
  begin
    if parseCanceled then Break;
    inc(i);
    SetCurrentTaskPosition(i);
    DetermineCurrentModule();
    Logger.AddToLog('Determine current Module [' + IntToStr(i) + '] for FileName: ' + DM1.cdsModules.FieldByName('FileName').AsString );
    DM1.cdsModules.Next;
  end;

  DM1.cdsModules.Filter := '';
  DM1.cdsModules.Filtered := false;
  DM1.cdsModules.First;
  DM1.cdsModules.EnableControls;

  EndTask();
  Result := true;
end;

procedure AddModuleToModulesArray(AModule : TIDEModule);
begin
  SetLength(ModulesArray, Length(ModulesArray) + 1);
  ModulesArray[Length(ModulesArray) - 1] := Pointer(AModule);
end;

function TfrmParse.TaskModuleFileParse: boolean;
var
  i : Integer;
  cl : Integer;
  Errors : Integer;
  s : string;
  tempIDEModule : TIDEModule;
begin
  Result := false;
  if parseCanceled then Exit;
  StartTask('Module file parsing');
  Errors := 0;
  cl := frmMain.MemoTxtModuleFile.Lines.Count;
  SetCurrentTaskPositionsMinMax(0, cl);
  frmMain.ModulesArrayClear;
  Fregexp := TPerlRegEx.Create;
  try
    with Fregexp do begin
      RegEx := GetModuleLineRegExp();
      for i := 0 to cl - 1 do
        begin
          SetCurrentTaskPosition(i);
          Subject := frmMain.MemoTxtModuleFile.Lines[i];
          if Match
          then
            begin
              {
              for k := 0 to GroupCount do
                begin
                  // Groups
                end;
                Groups[1] - file name
                Groups[2] - path
                Groups[3] - version
                Groups[4] - date & time
                Groups[5] - hash

                or

                Groups[1] - file name
                Groups[2] - version
                Groups[3] - path
              }
              tempIDEModule := TIDEModule.Create;
              tempIDEModule.isVIList := MFListIsVIList;
              tempIDEModule.AssignFromRegExpGroups(Fregexp);
              AddModuleToModulesArray(tempIDEModule);
              Logger.AddToLog('Parse line #' + i.ToString + '. Found module: ' + tempIDEModule.FileName );
            end
          else
            begin
              inc(Errors);
              Logger.AddToLog('Parse line #' + i.ToString + '. Module not found in line: ' + Subject );
            end;

          if parseCanceled
          then
            begin
              Logger.AddToLog('Module file parsing canceled at line #' + IntToStr(i));
              Break;
            end;
        end;
    end;
  finally
    Fregexp.Free;
  end;

  if Errors <> 0
  then
    begin
      s := FTaskName + '. Can''t parse ' + Errors.ToString + ' line';
      if Errors > 1 then s := s + 's';
      s := s + '.';
      Logger.AddToLog(s);
      ShowMessage(s);
    end;

  EndTask();
end;

end.
