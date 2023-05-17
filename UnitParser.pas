unit UnitParser;

interface

{comment to UTF-8 convert: конвертирование}

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls
  , System.RegularExpressionsCore
  , UnitIDEModule
  , Data.DB
  , System.Generics.Collections
  ;

type
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
    function TaskModuleFileParse(): boolean;
    function TaskCreateModulesDB(): boolean;
    function TaskFindAllKnowModules(): boolean;
    function GetModuleLineRegExp(): string;
    procedure ShowCurrentTaskName(name: string);
    procedure StartTasks(Count: integer);
    procedure StartTask(name: string);
    procedure SetCurrentTaskPosition(Position: integer);
    procedure SetCurrentTaskPositionsMinMax(PosMin, PosMax : integer);
  private
    { Private declarations }
    FCurrentModulePackage_ID: Integer;
    FCurrentModulePackageName: string;
    FCurrentModulePackageType_ID: Integer;
    function GetOverallTaskPosition(): Integer;
    function DetermineCurrentModule: boolean;
    function GetKnownModulesForFileName: boolean;
    function DetermineCurrentModuleLevel1() : boolean;
    function DetermineCurrentModuleLevel2() : boolean;
    function SaveCurrentModuleData : boolean;
    function TaskFindAllUsedPackages: boolean;
    function TaskFindModulesByFileNameRegExp: boolean;
    function DetermineModulesByFileNameRegExp: boolean;
  public
    { Public declarations }
    parseCanceled: boolean;
    parseSuccess: boolean;
    Tasks: Integer;
    currentTask: Integer;
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
  if Tasks < 1 then Tasks := 1;
  if currentTask < 1 then Tasks := 1;
end;

function TfrmParse.GetModuleLineRegExp: string;
begin

  // (.*)\t\(\d{1}x[0-9A-F]{8}\)\t([^\t]*)\t(?:(\d{1,6}\.\d{1,6}\.\d{1,6}\.\d{1,6})\t)?(\d{1,2}[\/\-\.]\d{1,2}[\/\-\.]\d{2,4})[\.]?\s*(\d{1,2}:\d{1,2}:\d{1,2}(?:\s*[\S]{2})?)\t([\dA-F]{40})

  Result := '(.*)\t' +                                // file name Groups[1]
    '\(\d{1}x[0-9A-F]{8}\)\t' +                        //
    '([^\t]*)\t' +                                    // path Groups[2]
    '(?:(\d{1,6}\.\d{1,6}\.\d{1,6}\.\d{1,6})\t)?' +   // version Groups[3]
    '(\d{1,4}[\/\-\.]\d{1,2}[\/\-\.]\d{1,4})[\.]?\s*' +    // date Groups[4]
    '((?:\s*[\S]{2}\s*)?\d{1,2}[\:\.]\d{1,2}[\:\.]\d{1,2}(?:\s*[\S]{2})?|)\t' +    // time Groups[5]
    '([\dA-F]{40})';                                  // hash Groups[6]

end;

function TfrmParse.GetOverallTaskPosition: Integer;
begin
  //
  Result := Round(100 / Tasks) * (currentTask - 1) +
          Round(100 / Tasks * pBarCurrentTask.Position / pBarCurrentTask.Max) ;
end;

procedure TfrmParse.ParseModuleListFile;
begin
  //
  frmMain.actParseCancel.Enabled := true;
  parseCanceled := not frmMain.actParseCancel.Enabled;

  if GlobalModulesCompareLevel3
    then StartTasks(5)    // Start 5 Tasks
    else StartTasks(4);   // Start 4 Tasks

  // Tasks
  TaskModuleFileParse();
  TaskCreateModulesDB();
  TaskFindAllKnowModules();
  if GlobalModulesCompareLevel3 then TaskFindModulesByFileNameRegExp();
  TaskFindAllUsedPackages();

  frmMain.actParseCancel.Enabled := false;
  parseSuccess := true;
  frmParse.Close;
end;

procedure TfrmParse.SetCurrentTaskPosition(Position: integer);
begin
  pBarCurrentTask.Position := Position;
  pBarOverall.Position := GetOverallTaskPosition();
  Application.ProcessMessages;
  // sleep(1); // Sleep
end;

procedure TfrmParse.SetCurrentTaskPositionsMinMax(PosMin, PosMax: integer);
begin
  pBarCurrentTask.Position := PosMin;
  pBarCurrentTask.Max := PosMax;
end;

procedure TfrmParse.ShowCurrentTaskName(name: string);
begin
  lblCurrentTask.Caption := name;
end;

procedure TfrmParse.StartTask(name: string);
begin
  inc(currentTask);
  ShowCurrentTaskName(name);
  SetCurrentTaskPosition(0);
end;

procedure TfrmParse.StartTasks(Count: integer);
begin
  pBarOverall.Max := 100;
  pBarOverall.Position := 0;
  Tasks := Count;
  currentTask := 0;
end;

function TfrmParse.TaskCreateModulesDB: boolean;
var
  tempIDEModule : TIDEModule;
begin
  Result := false;
  if parseCanceled then Exit;
  StartTask('Copy modules to DB...');
  Logger.AddToLog('Copy modules to DB started.');
  SetCurrentTaskPositionsMinMax(0, Length(ModulesArray) - 1);
  DM1.cdsModules.DisableControls;
  DM1.ClearModulesDB;
  for var i := 0 to Length(ModulesArray) - 1 do
    begin
      // sleep(1); // Sleep
      tempIDEModule := @ModulesArray[i]^;
      DM1.cdsModules.Append;
      DM1.cdsModules.FieldByName('Module_ID').AsInteger := i;
      DM1.cdsModules.FieldByName('FileName').AsString :=
        // UpperCase(TPath.GetFileNameWithoutExtension(tempIDEModule.FileName)) +
        // LowerCase(TPath.GetExtension(tempIDEModule.FileName));
        tempIDEModule.FileName;
      if Length(tempIDEModule.Path) < 255
        then DM1.cdsModules.FieldByName('Path').AsString := LowerCase(tempIDEModule.Path)
        else DM1.cdsModules.FieldByName('Path').AsString := LowerCase(copy(tempIDEModule.Path, 1, 255));
      DM1.cdsModules.FieldByName('Version').AsString := tempIDEModule.Version;
      DM1.cdsModules.FieldByName('DateAndTime').AsDateTime := tempIDEModule.DateTime;
      DM1.cdsModules.FieldByName('Hash').AsString := tempIDEModule.Hash;
      DM1.cdsModules.FieldByName('Package_ID').AsInteger := -1;
      DM1.cdsModules.FieldByName('PackageName').AsString := '';
      DM1.cdsModules.FieldByName('PackageType_ID').AsInteger := -1;

      DM1.cdsModules.Post;
      SetCurrentTaskPosition(i);

      if parseCanceled
      then
        begin
          Logger.AddToLog('Copy modules to DB canceled. Parsing canceled.');
          Break;
        end;

    end;
  DM1.cdsModules.First;
  DM1.cdsModules.EnableControls;

  if not parseCanceled
    then Logger.AddToLog('Copy modules to DB success.');

  Result := true;
end;

function TfrmParse.GetKnownModulesForFileName() : boolean;
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
      'WHERE lower(m.FileName)="' +
      LowerCase(DM1.cdsModules.FieldByName('FileName').AsString) +
      '"' +
      ';');
    Open;
  end;

  Result := true;
end;

function TfrmParse.DetermineCurrentModuleLevel1() : boolean;
begin
  if DM1.fdqModulesFromQuery.RecordCount > 0
  then
    begin
      FCurrentModulePackage_ID := DM1.fdqModulesFromQuery.FieldByName('Package_ID').AsInteger;
      FCurrentModulePackageName := DM1.fdqModulesFromQuery.FieldByName('PackageName').AsString;
      FCurrentModulePackageType_ID := DM1.fdqModulesFromQuery.FieldByName('PackageType_ID').AsInteger;
    end;

  Result := true;
end;

function TfrmParse.SaveCurrentModuleData() : boolean;
begin
  if (FCurrentModulePackage_ID = -1) AND (FCurrentModulePackageName = '')
  then
    begin
      Result := false;
      Exit;
    end;

  DM1.cdsModules.Edit;
  DM1.cdsModules.FieldByName('Package_ID').AsInteger := FCurrentModulePackage_ID;
  DM1.cdsModules.FieldByName('PackageName').AsString := FCurrentModulePackageName;
  DM1.cdsModules.FieldByName('PackageType_ID').AsInteger := FCurrentModulePackageType_ID;

  Result := true;
end;

function TfrmParse.DetermineCurrentModuleLevel2() : boolean;
var i : integer;
begin
  if DM1.fdqModulesFromQuery.RecordCount = 0 then Exit(false);

  DM1.fdqModulesFromQuery.First;
  for i := 0 to DM1.fdqModulesFromQuery.RecordCount - 1 do
  begin
    if DM1.cdsModules.FieldByName('Version').AsString = DM1.fdqModulesFromQuery.FieldByName('Version').AsString
      then
        begin
          FCurrentModulePackage_ID := DM1.fdqModulesFromQuery.FieldByName('Package_ID').AsInteger;
          FCurrentModulePackageType_ID := DM1.fdqModulesFromQuery.FieldByName('PackageType_ID').AsInteger;
          FCurrentModulePackageName := DM1.fdqModulesFromQuery.FieldByName('PackageName').AsString;
          if DM1.fdqModulesFromQuery.FieldByName('PackageSubName').AsString <> ''
            then FCurrentModulePackageName := FCurrentModulePackageName + ' ' +
              DM1.fdqModulesFromQuery.FieldByName('PackageSubName').AsString;
          Break;
        end;
    DM1.fdqModulesFromQuery.Next;
  end;

  Result := true;
end;

function TfrmParse.DetermineCurrentModule() : boolean;
begin
  FCurrentModulePackage_ID := -1;
  FCurrentModulePackageName := '';
  FCurrentModulePackageType_ID := -1;

  GetKnownModulesForFileName();
  if GlobalModulesCompareLevel2 then DetermineCurrentModuleLevel2();
  if FCurrentModulePackage_ID = -1 then DetermineCurrentModuleLevel1();
  SaveCurrentModuleData();

  Result := true;
end;

function TfrmParse.DetermineModulesByFileNameRegExp() : boolean;
var
  regexp : TPerlRegEx;
begin
  Result := false;
  if parseCanceled then Exit;

  regexp := TPerlRegEx.Create;
  try
    // var count1 := DM1.cdsModules.RecordCount;
    DM1.cdsModules.Filter := 'Package_ID = -1';
    DM1.cdsModules.Filtered := true;
    DM1.cdsModules.First;
    // var count2 := DM1.cdsModules.RecordCount;
    with regexp do
    begin
      Options := [preCaseLess, preNoAutoCapture];
      RegEx := '^' + DM1.fdqModulesFromQuery.FieldByName('FileNameRegExp').AsString + '$';
      while not DM1.cdsModules.Eof do
      begin
        if parseCanceled then Break;
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
          end;
        DM1.cdsModules.Next;
      end;
    end;
  finally
    regexp.Free;
  end;

  Result := true;
end;

function TfrmParse.TaskFindModulesByFileNameRegExp() : boolean;
begin
  Result := false;
  if parseCanceled then Exit;
  StartTask('Find known modules in DB...');
  Logger.AddToLog('Find known modules by FileName RegExp in DB started.');
  DM1.cdsModules.DisableControls;

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
  end;
  SetCurrentTaskPositionsMinMax(0, DM1.fdqModulesFromQuery.RecordCount - 1);

  var i := -1;
  while not DM1.fdqModulesFromQuery.Eof do
  begin
    if parseCanceled then Break;

    inc(i);
    SetCurrentTaskPosition(i);

    DetermineModulesByFileNameRegExp();

    DM1.fdqModulesFromQuery.Next;
  end;

  DM1.cdsModules.Filter := '';
  DM1.cdsModules.Filtered := false;
  DM1.cdsModules.First;
  DM1.cdsModules.EnableControls;
  DM1.fdqModulesFromQuery.Close;

  if not parseCanceled
    then Logger.AddToLog('Find known modules by FileName RegExp success.')
    else Logger.AddToLog('Find known modules by FileName RegExp canceled. Parsing canceled.');

  Result := true;
end;

function TfrmParse.TaskFindAllUsedPackages: boolean;
var
  tmpPackage: TModulesPackage;
begin
  Result := false;
  if parseCanceled then Exit;
  StartTask('Find known Packages...');
  Logger.AddToLog('Find known Packages started.');
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

  if not parseCanceled
    then Logger.AddToLog('Find known Packages success.')
    else Logger.AddToLog('Find known Packages canceled. Parsing canceled.');

  Result := true;
end;

function TfrmParse.TaskFindAllKnowModules: boolean;
begin
  Result := false;
  if parseCanceled then Exit;
  StartTask('Find known modules in DB...');
  Logger.AddToLog('Find known modules in DB started.');
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

  if not parseCanceled
    then Logger.AddToLog('Find known modules in DB success.')
    else Logger.AddToLog('Find known modules in DB canceled. Parsing canceled.');

  Result := true;
end;

function TfrmParse.TaskModuleFileParse: boolean;
var
  i : Integer;
  cl : Integer;
  err : Integer;
  s : string;
  tempIDEModule : TIDEModule;
  regexp : TPerlRegEx;
begin
  Result := false;
  if parseCanceled then Exit;
  StartTask('Module file parsing...');
  Logger.AddToLog('Module file parsing started.');
  err := 0;
  cl := frmMain.MemoTxtModuleFile.Lines.Count;
  SetCurrentTaskPositionsMinMax(0, cl);
  frmMain.ModulesArrayClear;
  regexp := TPerlRegEx.Create;
  try
    with regexp do begin
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
                Groups[4] - date
                Groups[5] - time
                Groups[6] - hash
              }
              tempIDEModule := TIDEModule.Create;
              tempIDEModule.AssignFromRegExpGroups(regexp);
              SetLength(ModulesArray, Length(ModulesArray) + 1);
              ModulesArray[Length(ModulesArray) - 1] := Pointer(tempIDEModule);
              Logger.AddToLog('Parse line #' + IntToStr(i) + '. Found module: ' + tempIDEModule.FileName );
            end
          else
            begin
              inc(err);
              Logger.AddToLog('Parse line #' + IntToStr(i) + '. Module not found in line: ' + Subject );
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
    regexp.Free;
  end;

  if err = 0
  then Logger.AddToLog('Module file parsing success.')
  else
    begin
      s := 'Module file parsing success. Can''t parse ' + IntToStr(err) + ' line';
      if err > 1 then s := s + 's';
      s := s + '.';
      Logger.AddToLog(s);
      ShowMessage(s);
    end;
  // Logger.Clear; // Temporary the Log clearing to avoid raising memory usage
end;

end.
