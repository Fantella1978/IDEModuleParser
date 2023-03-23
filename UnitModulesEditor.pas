unit UnitModulesEditor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls, Vcl.Mask, System.Actions, Vcl.ActnList,
  Vcl.Buttons
  , UnitStaticFunctions
  ;

type
  TfrmModulesEditor = class(TForm)
    Button1: TButton;
    pnlBottom: TPanel;
    dbgModules: TDBGrid;
    DBNavigator1: TDBNavigator;
    pnlTop: TPanel;
    lbedFilterFileName: TLabeledEdit;
    GroupBox1: TGroupBox;
    ActionList1: TActionList;
    Button2: TButton;
    actFindDuplicates: TAction;
    actFindDuplicatesNext: TAction;
    Button3: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Button4: TButton;
    actFindAndDeleteDuplicates: TAction;
    actCopyFileNameAsRegExp: TAction;
    SpeedButton1: TSpeedButton;
    procedure dbgModulesDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure Button1Click(Sender: TObject);
    procedure lbedFilterFileNameChange(Sender: TObject);
    procedure actFindDuplicatesExecute(Sender: TObject);
    procedure actFindDuplicatesNextExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actFindAndDeleteDuplicatesExecute(Sender: TObject);
    procedure actCopyFileNameAsRegExpExecute(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    FFindNext : boolean;
    FFindNextNum : integer;
    FFindNextBookmark : TBookmark;
    dbgModulesColumnsWidth : TDBGridColumnsWidthArray;
    function FindModuleDuplicate() : integer;
    function FindModuleFullDuplicates(id : integer) : integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmModulesEditor: TfrmModulesEditor;

implementation

{$R *.dfm}

uses
    UnitDB
  , UnitProgressWindow
//   , UnitLogger
  , UnitMain
  ;

function TfrmModulesEditor.FindModuleDuplicate() : integer;
var
  sqlStr : string;
begin
  // Find Duplicates for module
  with DM1.fdqModulesFromQuery do
  begin
    try
      Close;
      SQL.Clear;
      sqlStr :=
        'SELECT count(Num) as CountNum ' +
        'FROM Modules ' +
        'WHERE FileName=' + QuotedStr(DM1.fdtModulesFileName.AsString) + ' AND ';
      if DM1.fdtModulesVersion.AsString = ''
        then sqlStr := sqlStr + '(Version is NULL or Version='''')' + ' AND '
        else sqlStr := sqlStr + 'Version=' + QuotedStr(DM1.fdtModulesVersion.AsString) + ' AND ';
      sqlStr := sqlStr + 'Num>=' + DM1.fdtModulesNum.AsString;

      SQL.Add(sqlStr);
      Open;
      // var s := SQL;
      Result := FieldByName('CountNum').AsInteger;
      Exit;
    except
      // Result := -1;
    end;
  end;
  Result := -1;
end;

function TfrmModulesEditor.FindModuleFullDuplicates(id : integer) : integer;
var
  sqlStr : string;
begin
  // Find Full Duplicates for module
  with DM1.fdqModulesFromQuery do
  begin
    try
      Close;
      SQL.Clear;
      sqlStr :=
        'SELECT count(Num) as CountNum, * ' +
        'FROM Modules ' +
        'WHERE Num<>' + IntToStr(id) + ' AND ' +
          'FileName=' + QuotedStr(DM1.fdtModulesFileName.AsString) + ' AND ';
      if DM1.fdtModulesVersion.AsString = ''
        then sqlStr := sqlStr + '(Version is NULL or Version='''') AND '
        else sqlStr := sqlStr + 'Version=' + QuotedStr(DM1.fdtModulesVersion.AsString) + ' AND ';
      if DM1.fdtModulesHash.AsString = ''
        then sqlStr := sqlStr + '(Hash is NULL or Hash='''') AND '
        else sqlStr := sqlStr + 'Hash=' + QuotedStr(DM1.fdtModulesHash.AsString) + ' AND ';
      if DM1.fdtModulesPathRegExp.AsString = ''
        then sqlStr := sqlStr + '(PathRegExp is NULL or PathRegExp='''') AND '
        else sqlStr := sqlStr + 'PathRegExp=' + QuotedStr(DM1.fdtModulesPathRegExp.AsString) + ' AND ';
      if DM1.fdtModulesVersionRegExp.AsString = ''
        then sqlStr := sqlStr + '(VersionRegExp is NULL or VersionRegExp='''') AND '
        else sqlStr := sqlStr + 'VersionRegExp=' + QuotedStr(DM1.fdtModulesVersionRegExp.AsString) + ' AND ';
      sqlStr := sqlStr +
        'PackageID=' + DM1.fdtModulesPackageID.AsString + ';';

      SQL.Add(sqlStr);
      Open;
      // var s := SQL.Text;
      Result := FieldByName('CountNum').AsInteger;
      Exit;
    except
      // Result := -1;
    end;
  end;
  Result := -1;
end;

procedure TfrmModulesEditor.FormCreate(Sender: TObject);
begin
  FFindNext := false;
  FFindNextNum := 0;
end;

procedure TfrmModulesEditor.FormResize(Sender: TObject);
begin
  // for DBGrid Columns Width adjust
  AutoStretchDBGridColumns(dbgModules, dbgModulesColumnsWidth);
end;

procedure TfrmModulesEditor.FormShow(Sender: TObject);
begin
  if DM1.fdtModules.RecordCount > 2
    then frmModulesEditor.actFindDuplicates.Enabled := true
    else frmModulesEditor.actFindDuplicates.Enabled := false;

  // for DBGrid Columns Width adjust
  SetLength(dbgModulesColumnsWidth, dbgModules.Columns.Count);
  for var i := 0 to dbgModules.Columns.Count - 1 do
    dbgModulesColumnsWidth[i] := dbgModules.Columns[i].Width;

end;

procedure TfrmModulesEditor.actCopyFileNameAsRegExpExecute(Sender: TObject);
begin
  // Copy FileName to FileNameRegExp
  if DM1.fdtModules.State in [dsBrowse]
    then DM1.fdtModules.Edit;
  if DM1.fdtModules.State in [dsInsert, dsEdit]
    then DM1.fdtModulesFileNameRegExp.AsString := DM1.fdtModulesFileName.AsString;
end;

procedure TfrmModulesEditor.actFindAndDeleteDuplicatesExecute(Sender: TObject);
var
  i : integer;
  bm: TBookmark;
  deletedDuplicatesCount : integer;
begin
  // Find and delete modules duplicates
  DM1.fdtModules.Filtered := false;
  frmProgress.Caption := 'Find and Delete duplicates';
  frmProgress.lblProgress.Caption := 'Searching progress';
  frmProgress.pbProgress.Min := 0;
  frmProgress.pbProgress.Max := DM1.fdtModules.RecordCount - 1;
  frmProgress.pbProgress.Position := 0;
  frmProgress.Show;
  Application.ProcessMessages;
  Logger.AddToLog('Start to find and delete duplicates.');

  DM1.fdtModules.DisableControls;
  DM1.fdtModules.First;
  deletedDuplicatesCount := 0;
  i := 0;
  while not DM1.fdtModules.eOf do
  begin
    if FindModuleFullDuplicates(DM1.fdtModulesNum.AsInteger) > 0
    then
      begin
        Logger.AddToLog('Duplicates found for "' + DM1.fdtModulesFileName.AsString + '". ' +
          'Duplicates count = ' + IntToStr(DM1.fdqModulesFromQuery.RecordCount) +
          '.');
        bm := DM1.fdtModules.GetBookmark;
        frmProgress.pbProgress.Max := frmProgress.pbProgress.Max - DM1.fdqModulesFromQuery.RecordCount;
        with DM1.fdqModulesFromQuery do
        begin
          First;
           while not Eof do
           begin
            Logger.AddToLog('Duplicate for "' + DM1.fdtModulesFileName.AsString +'" deleted. ' +
             'Deleted module record with Num = ' + DM1.fdqModulesFromQuery.FieldByName('Num').AsString +
              '.');
             inc(deletedDuplicatesCount);
             Delete;
           end;
        end;
        DM1.fdtModules.Refresh;
        DM1.fdtModules.GotoBookmark(bm);
        DM1.fdtModules.FreeBookMark(bm);
      end;
    inc(i);
    frmProgress.pbProgress.Position := i;
    DM1.fdtModules.Next;
    Application.ProcessMessages;
    if frmProgress.FCanceled then Break;
  end;

  DM1.fdtModules.First;
  DM1.fdtModules.EnableControls;
  frmProgress.Hide;
  Application.ProcessMessages;
  if deletedDuplicatesCount > 0
  then
    begin
      ShowMessage('Deleted ' + IntToStr(deletedDuplicatesCount) + ' duplicates.');
      Logger.AddToLog('Deleted ' + IntToStr(deletedDuplicatesCount) + ' duplicates.');
    end
  else
    begin
      ShowMessage('Duplicates not found.');
      Logger.AddToLog('Duplicates not found.');
    end;
end;

procedure TfrmModulesEditor.actFindDuplicatesExecute(Sender: TObject);
var
  i : integer;
begin
  // Find Duplicates
  actFindAndDeleteDuplicates.Enabled := false;
  DM1.fdtModules.DisableControls;
  DM1.fdtModules.Filtered := false;
  DM1.fdtModules.First;
  frmProgress.Caption := 'Find Duplicates';
  frmProgress.lblProgress.Caption := 'Searching progress';
  frmProgress.pbProgress.Min := 0;
  frmProgress.pbProgress.Max := DM1.fdtModules.RecordCount - 1;
  frmProgress.pbProgress.Position := FFindNextNum;
  frmProgress.Show;
  Application.ProcessMessages;
  Logger.AddToLog('Start to find duplicates.');

  sleep(100);
  if DM1.fdtModules.BookmarkValid(FFindNextBookmark)
    then
      begin
        DM1.fdtModules.GotoBookmark(FFindNextBookmark);
        DM1.fdtModules.FreeBookmark(FFindNextBookmark);
      end;
  // firstNum := DM1.fdtModulesNum.AsInteger;
  while not DM1.fdtModules.Eof AND (FFindNextNum >= DM1.fdtModulesNum.AsInteger)
    do DM1.fdtModules.Next;
  i := DM1.fdtModulesNum.AsInteger;
  while not DM1.fdtModules.eof do
  begin
    // firstNum := DM1.fdtModulesNum.AsInteger;
    inc(i);
    frmProgress.pbProgress.Position := i;
    Application.ProcessMessages;
    if FindModuleDuplicate() > 1
    then
      begin
        lbedFilterFileName.Text := DM1.fdtModulesFileName.AsString;
        // lbedFilterFileNameChange(Sender);
        if not DM1.fdtModules.Eof
          then
            begin
              actFindDuplicatesNext.Visible := true;
              FFindNextNum := DM1.fdtModulesNum.AsInteger;
              DM1.fdtModules.FreeBookmark(FFindNextBookmark);
              FFindNextBookmark := DM1.fdtModules.GetBookmark;
              // Label1.Caption := IntToStr(FFindNextNum);
            end;
        actFindDuplicates.Enabled := false;
        Break;
      end;
    DM1.fdtModules.Next;
  end;
  frmProgress.Hide;
  Application.ProcessMessages;
  sleep(100);
  if not DM1.fdtModules.eof
    then
      begin
        DM1.fdtModules.GotoBookmark(FFindNextBookmark);
        Logger.Add('Duplicates found for "' + DM1.fdtModulesFileName.AsString + '".');
      end
    else
      begin
        actFindDuplicatesNext.Visible := false;
        actFindDuplicates.Enabled := true;
        lbedFilterFileName.Text := '';
        DM1.fdtModules.First;
        ShowMessage('Duplicates not found.');
        Logger.Add('Duplicates search success. Duplicates not found.');
        FFindNextBookmark := [];
        FFindNext := false;
        FFindNextNum := 0;
      end;
  DM1.fdtModules.EnableControls;
end;

procedure TfrmModulesEditor.actFindDuplicatesNextExecute(Sender: TObject);
begin
  // Find Duplicates Next
  actFindDuplicatesNext.Visible := false;
  FFindNext := true;
  lbedFilterFileName.Text := '';
  Logger.Add('Duplicates find next.');
  actFindDuplicatesExecute(Sender);
  FFindNext := false;
end;

procedure TfrmModulesEditor.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmModulesEditor.dbgModulesDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  // Rize Column width if text is a long
  AutoCalcDBGridColumnsWidth(dbgModules, Column, dbgModulesColumnsWidth);
end;

procedure TfrmModulesEditor.lbedFilterFileNameChange(Sender: TObject);
begin
  if lbedFilterFileName.Text <> ''
  then
    begin
      DM1.fdtModules.Filter := 'FileName LIKE ''' + lbedFilterFileName.Text + '%''';
      DM1.fdtModules.FilterOptions := [foCaseInsensitive];
      DM1.fdtModules.Filtered := true;
      actFindDuplicates.Enabled := false;
      actFindAndDeleteDuplicates.Enabled := false;
    end
  else
    begin
      FFindNextBookmark := [];
      DM1.fdtModules.Filtered := false;
      if FFindNext AND not DM1.fdtModules.Eof
        then actFindDuplicatesNext.Visible := true
        else
          begin
            actFindDuplicatesNext.Visible := false;
            FFindNextNum := 0;
          end;
      actFindDuplicates.Enabled := true;
      actFindAndDeleteDuplicates.Enabled := true;
    end;
  // Label1.Caption := IntToStr(FFindNextNum);
end;

end.
