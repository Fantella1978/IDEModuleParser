unit UnitDB;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.Provider, Datasnap.DBClient,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet;

type
  TDM1 = class(TDataModule)
    cdsModules: TClientDataSet;
    DataSource1: TDataSource;
    DataSetProvider1: TDataSetProvider;
    cdsModulesModule_ID: TIntegerField;
    cdsModulesPath: TStringField;
    cdsModulesVersion: TStringField;
    cdsModulesDateAndTime: TDateTimeField;
    cdsModulesHash: TStringField;
    fdcSQLite: TFDConnection;
    fdqModulesFromQuery: TFDQuery;
    fdtModules: TFDTable;
    dsModules: TDataSource;
    fdtPackages: TFDTable;
    dsPackages: TDataSource;
    dsModulesFromQuery: TDataSource;
    cdsModulesPackage_ID: TIntegerField;
    cdsModulesPackageName: TStringField;
    FDUpdateSQL1: TFDUpdateSQL;
    cdsModulesFileName: TStringField;
    fdtModulesModule_ID: TFDAutoIncField;
    fdtModulesFileName: TStringField;
    fdtModulesHash: TStringField;
    fdtModulesVersion: TStringField;
    fdtModulesPackage_ID: TIntegerField;
    fdtPackageTypes: TFDTable;
    dsPackageTypes: TDataSource;
    fdtPackagesPackage_ID: TFDAutoIncField;
    fdtPackagesName: TStringField;
    fdtPackagesSubName: TStringField;
    fdtPackagesUrl: TStringField;
    fdtPackagesVersionRegExp: TStringField;
    fdtPackagesVersion: TStringField;
    fdtPackagesType_ID: TIntegerField;
    cdsModulesPackageType_ID: TIntegerField;
    cdsModulesPackageVersion: TStringField;
    FDTransaction1: TFDTransaction;
    fdtModulesPathRegExp: TStringField;
    fdtModulesVersionRegExp: TStringField;
    fdtModulesFileNameRegExp: TStringField;
    fdtPackagesInGetIt: TBooleanField;
    fdtPackagesDescription: TWideMemoField;
    fdtPackagesPackage_Type: TStringField;
    fdtModulesPackage_Name: TStringField;
    fdtPackagesFullName: TStringField;
    procedure cdsModulesAfterScroll(DataSet: TDataSet);
    procedure fdtPackagesAfterRefresh(DataSet: TDataSet);
    procedure fdtPackagesAfterInsert(DataSet: TDataSet);
    procedure fdtModulesAfterScroll(DataSet: TDataSet);
    procedure fdtModulesAfterRefresh(DataSet: TDataSet);
    procedure fdtModulesFileNameRegExpValidate(Sender: TField);
    procedure DataModuleCreate(Sender: TObject);
    procedure fdtPackagesAfterScroll(DataSet: TDataSet);
    procedure dsPackagesStateChange(Sender: TObject);
    procedure fdtPackagesCalcFields(DataSet: TDataSet);
  private
    procedure UpdatePackagesActions;
    procedure UpdateModulesActions;
    { Private declarations }
  public
    { Public declarations }
    procedure ClearModulesDB;
    function FindPackageType_IDByName(name: string): integer;
  end;

  PModulesPackage = ^TModulesPackage;
  TModulesPackage = record
    Package_ID : integer;
    PackageName : string;
    PackageType_ID : integer;
    PackageVersion : string;
    class function FindSame(const value: TModulesPackage; const MyArr: array of TModulesPackage): boolean; static;
    // class function IndexOfArray<T:Class>(const value: T; const Things: array of T): Integer; static;
  private
  end;

const
  THIRDPARTY_PACKAGES_TYPE_ID = 3;
  THIRDPARTY_PACKAGES_WITH_GETIT_TYPE_ID = 4;

var
  DM1: TDM1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses
    UnitMain
  , UnitPackagesEditor
  , System.IOUtils
  , vcl.Forms
  , UnitModulesEditor
  , System.RegularExpressionsCore
  ;

{$R *.dfm}

{ TModulesPackage }

class function TModulesPackage.FindSame(const value: TModulesPackage; const MyArr: array of TModulesPackage): boolean;
var
  i: Integer;

begin
  for i := 0 to High(MyArr) do
    if // (value.Package_ID = MyArr[i].Package_ID) AND
       (value.PackageName = MyArr[i].PackageName)
      then Exit(true);
  Result := false;
end;

{
class function TModulesPackage.FindSame<T>(const value: T; const MyArr: array of T): boolean;
var
  i: Integer;
begin
  for i := 0 to High(MyArr) do
    if value = MyArr[i] then
      Exit(true);
  Result := false;
end;
}

{ TModulesPackage }

{ TDM1 }

procedure TDM1.cdsModulesAfterScroll(DataSet: TDataSet);
begin
  frmMain.UpdateActionsWithSelectedModels();
end;

procedure TDM1.ClearModulesDB;
var
  oldIndex : string;
begin
  if cdsModules.RecordCount = 0 then Exit;
  cdsModules.DisableControls;
  oldIndex := DM1.cdsModules.IndexName;
  DM1.cdsModules.IndexName := 'cdsModulesModule_IDIndexUNIQ';
  DM1.cdsModules.Filtered := false;
  cdsModules.First;
  while not cdsModules.Eof do
  begin
    cdsModules.Delete;
  end;
  cdsModules.Close;
  cdsModules.Open;
  DM1.cdsModules.IndexName := oldIndex;
  cdsModules.EnableControls;
end;

procedure TDM1.DataModuleCreate(Sender: TObject);
begin
  fdcSQLite.Close;
end;

procedure TDM1.dsPackagesStateChange(Sender: TObject);
begin
  UpdatePackagesActions();
end;

function TDM1.FindPackageType_IDByName(name : string) : integer;
begin
  fdtPackageTypes.First;
  while not fdtPackageTypes.Eof do
  begin
    if fdtPackageTypes.FieldByName('Name').AsString = name
      then
        begin
          Result := fdtPackageTypes.FieldByName('Type_ID').AsInteger;
          Exit;
        end;
    fdtPackageTypes.Next;
  end;
  Result := -1;
end;

procedure TDM1.fdtModulesAfterRefresh(DataSet: TDataSet);
begin
  UpdateModulesActions();
end;

procedure TDM1.fdtModulesAfterScroll(DataSet: TDataSet);
begin
  UpdateModulesActions();
end;

procedure TDM1.UpdateModulesActions();
begin
  if frmModulesEditor <> nil
   then
    begin
      if DM1.fdtModules.FieldByName('FileNameRegExp').AsString = ''
        then frmModulesEditor.actCopyFileNameAsRegExp.Enabled := true
        else frmModulesEditor.actCopyFileNameAsRegExp.Enabled := false;
    end;
end;

procedure TDM1.fdtModulesFileNameRegExpValidate(Sender: TField);
var
  regexp : TPerlRegEx;
  CompileResult : boolean;
begin
  if Sender.Value = '' then Exit;
  // Check FileNameRegExp Regular Expression
  CompileResult := false;
  regexp := TPerlRegEx.Create;
  try
    regexp.RegEx := Sender.Value;
    regexp.Subject := fdtModulesFileName.AsString;
    if regexp.Match then CompileResult := true;
  finally
    regexp.Free;
  end;
  if not CompileResult
    then raise Exception.Create('Incorrect Regular Expression');
end;

procedure TDM1.fdtPackagesAfterInsert(DataSet: TDataSet);
begin
  fdtPackages.FieldByName('Type_ID').AsInteger := 1; // Default Package Type_ID
end;

procedure TDM1.fdtPackagesAfterRefresh(DataSet: TDataSet);
begin
  UpdatePackagesActions();
end;

procedure TDM1.fdtPackagesAfterScroll(DataSet: TDataSet);
begin
  UpdatePackagesActions();
end;

procedure TDM1.fdtPackagesCalcFields(DataSet: TDataSet);
begin
  DataSet.FieldByName('FullName').AsString := DataSet.FieldByName('Name').AsString;
  if DataSet.FieldByName('SubName').AsString <> ''
    then DataSet.FieldByName('FullName').AsString := DataSet.FieldByName('FullName').AsString + ' ' +
      DataSet.FieldByName('SubName').AsString;
  if DataSet.FieldByName('Version').AsString <> ''
    then DataSet.FieldByName('FullName').AsString := DataSet.FieldByName('FullName').AsString + ' ' +
      DataSet.FieldByName('Version').AsString;
end;

procedure TDM1.UpdatePackagesActions();
begin
  if (frmPackagesEditor = nil) OR not frmPackagesEditor.Visible then Exit;

  if dsPackages.State in [dsEdit, dsInsert]
    then
      begin
        frmPackagesEditor.actPackageAdd.Enabled := false;
        frmPackagesEditor.actPackageEdit.Enabled := false;
        frmPackagesEditor.actPackageDelete.Enabled := false;
      end;
  if dsPackages.State in [dsBrowse]
    then
      begin
        frmPackagesEditor.actPackageAdd.Enabled := true;
        if fdtPackages.RecordCount > 0
        then
          begin
            frmPackagesEditor.actPackageEdit.Enabled := true;
            frmPackagesEditor.actPackageDelete.Enabled := true;
          end
        else
          begin
            frmPackagesEditor.actPackageEdit.Enabled := false;
            frmPackagesEditor.actPackageDelete.Enabled := false;
          end;
      end;
end;

end.
