unit UnitParser;

interface

{comment to UTF-8 convert: конвертирование}

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls
  , System.RegularExpressionsCore
  , UnitIDEModule
  , Data.DB
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
    function GetOverallTaskPosition(): Integer;
    function DetermineCurrentModule: boolean;
    function GetKnownModulesForFileName: boolean;
    function DetermineCurrentModuleLevel1() : boolean;
    function DetermineCurrentModuleLevel2() : boolean;
    function SaveCurrentModuleData : boolean;
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

  StartTasks(3); // Start 2 Tasks
  TaskModuleFileParse();
  TaskCreateModulesDB();
  TaskFindAllKnowModules();

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
  StartTask('Copy modules to DB...');
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

      DM1.cdsModules.Post;
      SetCurrentTaskPosition(i);
    end;
  DM1.cdsModules.First;
  DM1.cdsModules.EnableControls;

  Result := true;
end;

function TfrmParse.GetKnownModulesForFileName() : boolean;
begin

  // SELECT m.*, p.Num AS PackageID, p.Name AS PackageName FROM Modules AS m LEFT OUTER JOIN Packages AS p ON m.Package=p.Num WHERE lower(m.FileName)="bds.exe" LIMIT 0,1
  if DM1.fdqModulesFromQuery.Active then DM1.fdqModulesFromQuery.Close;
  DM1.fdqModulesFromQuery.SQL.Clear;
  DM1.fdqModulesFromQuery.SQL.Add(
    'SELECT m.*, p.Num AS PackageID, p.Name AS PackageName, p.SubName AS PackageSubName ' +
    'FROM Modules AS m ' +
    'LEFT OUTER JOIN Packages AS p ON m.PackageID=p.Num ' +
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

  Result := true;
end;

function TfrmParse.DetermineCurrentModuleLevel2() : boolean;
var i : integer;
begin
  if DM1.fdqModulesFromQuery.RecordCount <= 1
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

  GetKnownModulesForFileName();
  DetermineCurrentModuleLevel1();
  if GlobalModulesCompareLevel2 then DetermineCurrentModuleLevel2();
  SaveCurrentModuleData();

    {
    var S := LowerCase(DM1.cdsModules.FieldByName('FileName').AsString);
    var L := length(LowerCase(DM1.cdsModules.FieldByName('FilName').AsString));
    if LowerCase(DM1.cdsModules.FieldByName('FileName').AsString) = 'bds.exe' + #9
    then
      begin
        var p := 2;
      end;
    }

  Result := true;
end;

function TfrmParse.TaskFindAllKnowModules: boolean;
begin
  StartTask('Find known modules in DB...');
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
    Logger.AddToLog('Determine Current Module [' + IntToStr(i) + '] for FileName: ' + DM1.cdsModules.FieldByName('FileName').AsString );

    DM1.cdsModules.Next;
  end;
  DM1.cdsModules.First;
  DM1.cdsModules.EnableControls;

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
  StartTask('Module file parsing...');
  Logger.AddToLog('Module file parsing started.');
  Result := false;
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
