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
    cdsModulesName: TStringField;
    cdsModulesNum: TIntegerField;
    cdsModulesPath: TStringField;
    cdsModulesVersion: TStringField;
    cdsModulesDateAndTime: TDateTimeField;
    cdsModulesHash: TStringField;
    cdsPackages: TClientDataSet;
    cdsPackagesNum: TIntegerField;
    cdsPackagesName: TStringField;
    cdsPackagesUrl: TStringField;
    dsLocalPackages: TDataSource;
    DataSetProvider2: TDataSetProvider;
    FDConnection1: TFDConnection;
    fdqModulesFromQuery: TFDQuery;
    fdtModules: TFDTable;
    dsModules: TDataSource;
    fdtPackages: TFDTable;
    dsPackages: TDataSource;
    dsModulesFromQuery: TDataSource;
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

{$R *.dfm}

{ TDM1 }

procedure TDM1.ClearModulesDB;
var
  i : integer;
begin
  if cdsModules.RecordCount = 0 then Exit;
  cdsModules.First;
  for i := 0 to cdsModules.RecordCount - 1 do
    begin
      cdsModules.Delete;
    end;
end;

end.
