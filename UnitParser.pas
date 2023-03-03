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
    FCurrentModulePackageID: Integer;
    FCurrentModulePackageName: string;
    FCurrentModulePackageTypeID: Integer;
    function GetOverallTaskPosition(): Integer;
    function DetermineCurrentModule: boolean;
    function GetKnownModulesForFileName: boolean;
    function DetermineCurrentModuleLevel1() : boolean;
    function DetermineCurrentModuleLevel2() : boolean;
    function SaveCurrentModuleData : boolean;
    function TaskFindAllUsedPackages: boolean;
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
    '(\d{1,2}[\/\-\.]\d{1,2}[\/\-\.]\d{2,4})[\.]?\s*' +    // date Groups[4]
    '(\d{1,2}:\d{1,2}:\d{1,2}(?:\s*[\S]{2})?)\t' +    // time Groups[5]
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

  StartTasks(4); // Start 4 Tasks
  TaskModuleFileParse();
  TaskCreateModulesDB();
  TaskFindAllKnowModules();
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
      DM1.cdsModules.FieldByName('Num').AsInteger := i;
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
      DM1.cdsModules.FieldByName('PackageID').AsInteger := -1;
      DM1.cdsModules.FieldByName('PackageName').AsString := '';
      DM1.cdsModules.FieldByName('PackageTypeID').AsInteger := -1;

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
    SELECT m.*, p.Num AS PackageID, p.Name AS PackageName
    FROM Modules AS m LEFT OUTER JOIN Packages AS p ON m.Package=p.Num
    WHERE lower(m.FileName)="bds.exe"
  }
  if DM1.fdqModulesFromQuery.Active then DM1.fdqModulesFromQuery.Close;
  DM1.fdqModulesFromQuery.SQL.Clear;
  DM1.fdqModulesFromQuery.SQL.Add(
    'SELECT m.*, p.Num AS PackageID, p.Name AS PackageName, p.SubName AS PackageSubName, pt.ID AS PackageTypeID, ' +
    'p.Version AS PackageVersion ' +
    'FROM Modules AS m ' +
    'LEFT JOIN Packages AS p ON m.PackageID=p.Num ' +
    'LEFT JOIN PackageTypes AS pt ON p.Type=pt.ID ' +
    'WHERE lower(m.FileName)="' +
    LowerCase(DM1.cdsModules.FieldByName('FileName').AsString) +
    '"' +
    ';');
  DM1.fdqModulesFromQuery.Open;

  Result := true;
end;

function TfrmParse.DetermineCurrentModuleLevel1() : boolean;
begin
  if DM1.fdqModulesFromQuery.RecordCount > 0
  then
    begin
      FCurrentModulePackageID := DM1.fdqModulesFromQuery.FieldByName('PackageID').AsInteger;
      FCurrentModulePackageName := DM1.fdqModulesFromQuery.FieldByName('PackageName').AsString;
      FCurrentModulePackageTypeID := DM1.fdqModulesFromQuery.FieldByName('PackageTypeID').AsInteger;
    end;

  Result := true;
end;

function TfrmParse.SaveCurrentModuleData() : boolean;
begin
  if (FCurrentModulePackageID = -1) AND (FCurrentModulePackageName = '')
  then
    begin
      Result := false;
      Exit;
    end;

  DM1.cdsModules.Edit;
  DM1.cdsModules.FieldByName('PackageID').AsInteger := FCurrentModulePackageID;
  DM1.cdsModules.FieldByName('PackageName').AsString := FCurrentModulePackageName;
  DM1.cdsModules.FieldByName('PackageTypeID').AsInteger := FCurrentModulePackageTypeID;

  Result := true;
end;

function TfrmParse.DetermineCurrentModuleLevel2() : boolean;
var i : integer;
begin
  if DM1.fdqModulesFromQuery.RecordCount = 0
  then
    begin
      Result := false;
      Exit;
    end;

  DM1.fdqModulesFromQuery.First;
  for i := 0 to DM1.fdqModulesFromQuery.RecordCount - 1 do
  begin
    if DM1.cdsModules.FieldByName('Version').AsString = DM1.fdqModulesFromQuery.FieldByName('Version').AsString
      then
        begin
          FCurrentModulePackageID := DM1.fdqModulesFromQuery.FieldByName('PackageID').AsInteger;
          FCurrentModulePackageTypeID := DM1.fdqModulesFromQuery.FieldByName('PackageTypeID').AsInteger;
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
  FCurrentModulePackageID := -1;
  FCurrentModulePackageName := '';
  FCurrentModulePackageTypeID := -1;

  GetKnownModulesForFileName();
  DetermineCurrentModuleLevel1();
  if GlobalModulesCompareLevel2 then DetermineCurrentModuleLevel2();
  SaveCurrentModuleData();

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
  DM1.cdsModules.Filter := 'PackageID is not NULL';
  DM1.cdsModules.Filtered := true;
  frmMain.FModulesPackages := [];
  while not DM1.cdsModules.Eof do
  begin
    inc(i);
    SetCurrentTaskPosition(i);

    if DM1.cdsModules.FieldByName('PackageID').AsInteger <> -1
    then
      begin
        tmpPackage.PackageID := DM1.cdsModules.FieldByName('PackageID').AsInteger;
        tmpPackage.PackageName := DM1.cdsModules.FieldByName('PackageName').AsString;
        tmpPackage.PackageTypeID := DM1.cdsModules.FieldByName('PackageTypeID').AsInteger;
        tmpPackage.PackageVersion := DM1.cdsModules.FieldByName('PackageVersion').AsString;;

        {if not TModulesPackage.FindSame<TModulesPackage>(tmpPackage, frmMain.FModulesPackages)
          then frmMain.FModulesPackages := frmMain.FModulesPackages + [tmpPackage];}

        if not TModulesPackage.FindSame(tmpPackage, frmMain.FModulesPackages)
          then frmMain.FModulesPackages := frmMain.FModulesPackages + [tmpPackage];
      end;
    DM1.cdsModules.Next;

    if parseCanceled
    then
      begin
        Logger.AddToLog('Find known Packages canceled. Parsing canceled.');
        Break;
      end;
  end;
  Logger.AddToLog('Find known Packages started.');
  DM1.cdsModules.Filter := '';
  DM1.cdsModules.Filtered := false;
  DM1.cdsModules.First;
  DM1.cdsModules.EnableControls;

  if not parseCanceled
    then Logger.AddToLog('Find known Packages success.');

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
    inc(i);
    SetCurrentTaskPosition(i);
    {
    if DM1.cdsModules.FieldByName('FileName').AsString = 'tethering280.bpl'
      then var k := 470;
    }
    DetermineCurrentModule();
    Logger.AddToLog('Determine current Module [' + IntToStr(i) + '] for FileName: ' + DM1.cdsModules.FieldByName('FileName').AsString );

    DM1.cdsModules.Next;

    if parseCanceled
    then
      begin
        Logger.AddToLog('Find known modules in DB canceled. Parsing canceled.');
        Break;
      end;
  end;
  DM1.cdsModules.First;
  DM1.cdsModules.EnableControls;

  if not parseCanceled
    then Logger.AddToLog('Find known modules in DB success.');

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
          // sleep(1); // Sleep
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
