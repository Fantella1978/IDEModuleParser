unit UnitDB;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.Provider, Datasnap.DBClient;

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
    dsPackages: TDataSource;
    DataSetProvider2: TDataSetProvider;
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
