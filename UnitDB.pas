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
    cdsModulesNum: TIntegerField;
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
    cdsModulesPackageID: TIntegerField;
    cdsModulesPackageName: TStringField;
    FDUpdateSQL1: TFDUpdateSQL;
    cdsModulesFileName: TStringField;
    fdtModulesNum: TFDAutoIncField;
    fdtModulesFileName: TStringField;
    fdtModulesHash: TStringField;
    fdtModulesPathRegExp: TWideStringField;
    fdtModulesVersion: TStringField;
    fdtModulesVersionRegExp: TWideStringField;
    fdtModulesPackageID: TIntegerField;
    fdtPackageTypes: TFDTable;
    dsPackageTypes: TDataSource;
    fdtPackagesNum: TFDAutoIncField;
    fdtPackagesName: TStringField;
    fdtPackagesSubName: TStringField;
    fdtPackagesUrl: TStringField;
    fdtPackagesVersionRegExp: TStringField;
    fdtPackagesVersion: TStringField;
    fdtPackagesType: TIntegerField;
    procedure cdsModulesAfterScroll(DataSet: TDataSet);
    procedure fdtPackagesAfterCancel(DataSet: TDataSet);
    procedure fdtPackagesAfterEdit(DataSet: TDataSet);
    procedure fdtPackagesAfterOpen(DataSet: TDataSet);
    procedure fdtPackagesAfterRefresh(DataSet: TDataSet);
    procedure dsPackagesStateChange(Sender: TObject);
    procedure fdtPackagesAfterInsert(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ClearModulesDB;
  end;

var
  DM1: TDM1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses
    UnitMain
  , UnitPackagesEditor
  , System.IOUtils
  , vcl.Forms
  ;

{$R *.dfm}

{ TDM1 }

procedure TDM1.cdsModulesAfterScroll(DataSet: TDataSet);
begin
  frmMain.UpdateActionsWithSelectedModels();
end;

procedure TDM1.ClearModulesDB;
begin
  if cdsModules.RecordCount = 0 then Exit;
  cdsModules.DisableControls;
  cdsModules.First;
  while not cdsModules.Eof do
  begin
    cdsModules.Delete;
  end;
  cdsModules.Close;
  cdsModules.Open;
  cdsModules.EnableControls;
end;

procedure TDM1.dsPackagesStateChange(Sender: TObject);
begin
  if (frmPackagesEditor = nil) OR not frmPackagesEditor.Visible then Exit;
  if dsPackages.State in [dsEdit, dsInsert]
    then
      begin
        frmPackagesEditor.actPackageAdd.Enabled := false;
        frmPackagesEditor.actPackageEdit.Enabled := false;
        frmPackagesEditor.actPackageDelete.Enabled := false;
        frmPackagesEditor.actPackagesSave.Enabled := true;
        frmPackagesEditor.actPackagesCancel.Enabled := true;
      end;
  if dsPackages.State in [dsBrowse]
    then
      begin
        frmPackagesEditor.actPackageAdd.Enabled := true;
        frmPackagesEditor.actPackageEdit.Enabled := true;
        if dsPackages.DataSet.RecordCount > 0
          then frmPackagesEditor.actPackageDelete.Enabled := true
          else frmPackagesEditor.actPackageDelete.Enabled := false;
        frmPackagesEditor.actPackagesSave.Enabled := false;
        frmPackagesEditor.actPackagesCancel.Enabled := false;
      end;
end;

procedure TDM1.fdtPackagesAfterCancel(DataSet: TDataSet);
begin
  frmPackagesEditor.actPackageAdd.Enabled := true;
  frmPackagesEditor.actPackageEdit.Enabled := true;
  frmPackagesEditor.actPackageDelete.Enabled := true;
  frmPackagesEditor.actPackagesSave.Enabled := false;
  frmPackagesEditor.actPackagesCancel.Enabled := false;
end;

procedure TDM1.fdtPackagesAfterEdit(DataSet: TDataSet);
begin
  frmPackagesEditor.actPackageAdd.Enabled := true;
  frmPackagesEditor.actPackageEdit.Enabled := true;
  frmPackagesEditor.actPackageDelete.Enabled := true;
  frmPackagesEditor.actPackagesSave.Enabled := false;
  frmPackagesEditor.actPackagesCancel.Enabled := false;
end;

procedure TDM1.fdtPackagesAfterInsert(DataSet: TDataSet);
begin
  fdtPackages.FieldByName('Type').AsInteger := 1; // Default Package Type
end;

procedure TDM1.fdtPackagesAfterOpen(DataSet: TDataSet);
begin
  if (frmPackagesEditor = nil) OR not frmPackagesEditor.Visible then Exit;
  frmPackagesEditor.actPackageAdd.Enabled := true;
  frmPackagesEditor.actPackageEdit.Enabled := false;
  frmPackagesEditor.actPackageDelete.Enabled := false;
  frmPackagesEditor.actPackagesSave.Enabled := false;
  frmPackagesEditor.actPackagesCancel.Enabled := false;
end;

procedure TDM1.fdtPackagesAfterRefresh(DataSet: TDataSet);
begin
  if (frmPackagesEditor = nil) OR not frmPackagesEditor.Visible then Exit;
  frmPackagesEditor.actPackageAdd.Enabled := true;
  if DataSet.RecordCount >0
  then
    begin
      frmPackagesEditor.actPackageEdit.Enabled := false;
      frmPackagesEditor.actPackageDelete.Enabled := false;
    end;
  frmPackagesEditor.actPackagesSave.Enabled := false;
  frmPackagesEditor.actPackagesCancel.Enabled := false;
end;

end.
