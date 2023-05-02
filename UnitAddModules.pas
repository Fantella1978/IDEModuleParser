unit UnitAddModules;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.DBCtrls,
  Vcl.CheckLst, System.Actions, Vcl.ActnList, Vcl.ComCtrls;

type
  TfrmAddModules = class(TForm)
    btnAdd: TButton;
    btnCancel: TButton;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    GroupBox2: TGroupBox;
    clbFields: TCheckListBox;
    Button5: TButton;
    GroupBox3: TGroupBox;
    lbxModules: TListBox;
    cbPackages: TComboBox;
    Panel2: TPanel;
    ActionList1: TActionList;
    actPackagesEditor: TAction;
    ProgressBarAddModules: TProgressBar;
    CheckBox1: TCheckBox;
    cbOptionsFileNameRegExp: TCheckBox;
    Panel3: TPanel;
    GroupBox4: TGroupBox;
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure cbPackagesCloseUp(Sender: TObject);
    function GetModulesListItems(): boolean;
    procedure clbFieldsClickCheck(Sender: TObject);
    function AddAllSelectedModulesToDB() : boolean;
    function AddCurrentModuleToKnown() : boolean;
    procedure actPackagesEditorExecute(Sender: TObject);
    function UpdatePackagesInfo() : boolean;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure clbFieldsAllCheck();
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAddModules: TfrmAddModules;
  PackageIDs : TStringList;

implementation

{$R *.dfm}

uses
    UnitMain
  , UnitDB
  , Data.DB
  , UnitSettings
  , UnitPackagesEditor
  , System.UITypes
  ;

procedure TfrmAddModules.btnAddClick(Sender: TObject);
begin
  //
  if cbPackages.ItemIndex = -1
    then
      begin
        frmAddModules.SetFocusedControl(cbPackages);
        Exit
      end;
  AddAllSelectedModulesToDB();
  Close;
  if MessageDlg('ReParse recomended. ReParse ModulesList file?', mtConfirmation, [mbYes, mbNo], 0) in [mrYes]
    then
      begin
        DM1.ClearModulesDB();
        frmMain.actParseModuleFileExecute(Sender);
      end;
end;

procedure TfrmAddModules.cbPackagesCloseUp(Sender: TObject);
begin
  cbPackages.Text := cbPackages.Items[cbPackages.ItemIndex];
end;

procedure TfrmAddModules.clbFieldsAllCheck;
var
  i : integer;
begin
  for i := 0 to clbFields.Items.Count - 1 do clbFields.Checked[i] := true;
end;

procedure TfrmAddModules.clbFieldsClickCheck(Sender: TObject);
begin
  if (clbFields.Items.Count > 0) AND (clbFields.ItemIndex < 0)
    then clbFields.ItemIndex := 0;
  if clbFields.Items[clbFields.ItemIndex] = 'File Name'
    then clbFields.Checked[clbFields.ItemIndex] := true;
  GetModulesListItems();
  {
  if lbxModules.Items.Count = 0
    then btnAdd.Enabled := false
    else btnAdd.Enabled := true;
    }
end;

procedure TfrmAddModules.actPackagesEditorExecute(Sender: TObject);
var
  PackageID : integer;
  i : integer;
begin
  // Run Packages Editor
  frmPackagesEditor.ShowModal;
  // Set Packages ComboBox item index
  PackageID := DM1.fdtPackages.FieldByName('Num').AsInteger;
  UpdatePackagesInfo();
  for i := 0 to PackageIDs.Count - 1 do
    if PackageIDs[i].ToInteger = PackageID
      then
        begin
          cbPackages.ItemIndex := i;
          Break;
        end;
end;

function TfrmAddModules.AddAllSelectedModulesToDB: boolean;
var
  i : integer;
  CurrentBookMark: TBookmark;
begin
  //
  ProgressBarAddModules.Min := 0;
  ProgressBarAddModules.Max := frmMain.DBGridModules.SelectedRows.Count;
  ProgressBarAddModules.Position := 0;
  ProgressBarAddModules.Visible := true;
  Application.ProcessMessages;
  with DM1.cdsModules do
  begin
    CurrentBookMark := GetBookmark;
    DisableControls;
    for i := 0 to frmMain.DBGridModules.SelectedRows.Count - 1 do
    begin
      GotoBookmark(Tbookmark(frmMain.DBGridModules.SelectedRows[i]));
      AddCurrentModuleToKnown();
    end;
    EnableControls;
    GotoBookmark(CurrentBookMark);
    FreeBookMark(CurrentBookMark);
  end;
  Sleep(100);
  Result := true;
end;

function TfrmAddModules.AddCurrentModuleToKnown: boolean;
begin
  //
  with DM1.fdtModules do
  begin
    Append;
    FieldByName('FileName').AsString := DM1.cdsModules.FieldByName('FileName').AsString;
    FieldByName('PackageID').AsInteger := StrToInt(PackageIDs[cbPackages.ItemIndex]);
    if clbFields.Checked[1]
      then FieldByName('Version').AsString := DM1.cdsModules.FieldByName('Version').AsString
      else FieldByName('Version').AsString := '';
    {
    if clbFields.Checked[2]
      then FieldByName('DateAndTime').AsDateTime := DM1.cdsModules.FieldByName('DateAndTime').AsDateTime
      else FieldByName('DateAndTime').AsString := '';
    if clbFields.Checked[3]
      then FieldByName('Path').AsString := DM1.cdsModules.FieldByName('Path').AsString
      else FieldByName('Path').AsString := '';
    }
    if clbFields.Checked[2]
      then FieldByName('Hash').AsString := DM1.cdsModules.FieldByName('Hash').AsString
      else FieldByName('Hash').AsString := '';
    if cbOptionsFileNameRegExp.Checked
      then FieldByName('FileNameRegExp').AsString := DM1.cdsModules.FieldByName('FileName').AsString;

    DM1.fdtModules.Post;
  end;
  // ShowMessage('Module ' + DM1.cdsModules.FieldByName('Name').AsString + ' successfuly added to DB.');
  ProgressBarAddModules.Position := ProgressBarAddModules.Position + 1;
  Application.ProcessMessages;
  Result := true;
end;

procedure TfrmAddModules.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmAddModules.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ProgressBarAddModules.Visible := false;
  FreeAndNil(PackageIDs);
end;

procedure TfrmAddModules.FormShow(Sender: TObject);
begin
  lbxModules.Font.Size := UnitSettings.GlobalDefaultFontSize;
  UpdatePackagesInfo();
  clbFieldsAllCheck();
  clbFieldsClickCheck(Sender);
end;

function TfrmAddModules.GetModulesListItems(): boolean;
var
  i, k : integer;
  s : string;
begin
  lbxModules.Items.Clear;
  // Get Selected Modules as List
  DM1.cdsModules.DisableControls;
  lbxModules.Columns := 0;
  with frmMain.DBGridModules do
  begin
    for i := 0 to SelectedRows.Count - 1 do
    begin
      s := '';
      DataSource.DataSet.GotoBookmark(Tbookmark(frmMain.DBGridModules.SelectedRows[i]));
      for k := 0 to Columns.Count - 1 do
      begin
        if ((Columns[k].FieldName = 'FileName') AND clbFields.Checked[0]) OR
           ((Columns[k].FieldName = 'Version') AND clbFields.Checked[1]) OR
          { ((Columns[k].FieldName = 'DateAndTime') AND clbFields.Checked[2]) OR}
          { ((Columns[k].FieldName = 'Path') AND clbFields.Checked[3]) OR }
           ((Columns[k].FieldName = 'Hash') AND clbFields.Checked[2])
          then
            begin
              if s <> '' then s := s + #9;
              s := s + Columns[k].Field.asString;
            end;
      end;
      if s <> '' then lbxModules.Items.Add(s);
    end;
  end;
  DM1.cdsModules.EnableControls;
  lbxModules.TabWidth := 8;

  Result := true;
end;

function TfrmAddModules.UpdatePackagesInfo: boolean;
var
  i : integer;
  PackageName : string;
begin
  if not Assigned(PackageIDs) then PackageIDs := TStringList.Create;
  PackageIDs.Clear;
  cbPackages.Clear;
  with DM1.fdtPackages do
  begin
    DisableControls;
    Filtered := false;
    Filter := '';
    IndexName := 'NameSubNameIndex';
    // IndexFieldNames := 'Name;SubName';
    First;
    for i := 0 to RecordCount - 1 do
    begin
      PackageName := FieldByName('Name').AsString;
      if FieldByName('SubName').AsString <> ''
        then PackageName := PackageName + ' ' + FieldByName('SubName').AsString;
      if FieldByName('Version').AsString <> ''
        then PackageName := PackageName + ' ' + FieldByName('Version').AsString;
      cbPackages.Items.Add(PackageName);
      PackageIDs.Add(FieldByName('Num').AsString);
      Next;
    end;
    if cbPackages.Items.Count > 0 then cbPackages.ItemIndex := 0;
    EnableControls;
  end;

  Result := true;
end;

end.
