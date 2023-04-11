unit UnitDisplayPackagesList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ControlList,
  Vcl.ExtCtrls
  , FireDAC.Comp.Client
  ;

type
  TfrmPackagesList = class(TForm)
    Button1: TButton;
    Panel1: TPanel;
    ControlList1: TControlList;
    lblTitle: TLabel;
    Label1: TLabel;
    ControlListButton1: TControlListButton;
    procedure FormShow(Sender: TObject);
    procedure ControlList1BeforeDrawItem(AIndex: Integer; ACanvas: TCanvas;
      ARect: TRect; AState: TOwnerDrawState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ControlListButton1Click(Sender: TObject);
    procedure ControlList1Click(Sender: TObject);
  private
    FPackagesQuery: TFDQuery;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPackagesList: TfrmPackagesList;

implementation

{$R *.dfm}

uses
    UnitMain
  , UnitDB
  , Winapi.ShellAPI
  ;

procedure TfrmPackagesList.ControlList1BeforeDrawItem(AIndex: Integer;
  ACanvas: TCanvas; ARect: TRect; AState: TOwnerDrawState);
begin
  FPackagesQuery.RecNo := AIndex + 1;
  lblTitle.Caption := FPackagesQuery.FieldByName('Name').AsString;
  if FPackagesQuery.FieldByName('SubName').AsString <> ''
    then lblTitle.Caption := lblTitle.Caption + ' ' + FPackagesQuery.FieldByName('SubName').AsString;
  if FPackagesQuery.FieldByName('Version').AsString <> ''
    then lblTitle.Caption := lblTitle.Caption  + ' ' + FPackagesQuery.FieldByName('Version').AsString;

  if FPackagesQuery.FieldByName('URL').AsString <> ''
    then
      begin
        Label1.Caption := 'URL: ' + FPackagesQuery.FieldByName('URL').AsString;
        ControlListButton1.Visible := true;
      end
    else
      begin
        Label1.Caption := 'URL: none';
        ControlListButton1.Visible := false;
      end;
end;

procedure TfrmPackagesList.ControlList1Click(Sender: TObject);
begin
  ControlListButton1Click(Sender);
end;

procedure TfrmPackagesList.ControlListButton1Click(Sender: TObject);
var
  LURL : string;
begin
  FPackagesQuery.RecNo := ControlList1.ItemIndex + 1;
  LURL := FPackagesQuery.FieldByName('URL').AsString;
  if LURL <> ''
    then ShellExecute(0, nil, PChar(LURL), nil, nil, SW_SHOWNOACTIVATE);
end;

procedure TfrmPackagesList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(FPackagesQuery);
end;

procedure TfrmPackagesList.FormShow(Sender: TObject);
var
  PackagesIDsListString : string;
  i : integer;
begin
  PackagesIDsListString := '';
  for i := 0 to Length(frmMain.FModulesPackages) - 1 do
    begin
      PackagesIDsListString := PackagesIDsListString + IntToStr(frmMain.FModulesPackages[i].PackageID);
      if i <> Length(frmMain.FModulesPackages) - 1
        then PackagesIDsListString := PackagesIDsListString + ', ';
    end;

  if FPackagesQuery = nil
    then FPackagesQuery := TFDQuery.Create(self);
  FPackagesQuery.Connection := DM1.fdcSQLite;
  FPackagesQuery.SQL.Text := '' +
    'SELECT p.*, pt.* ' +
    'FROM Packages AS p ' +
    'LEFT JOIN PackageTypes AS pt ON p.Type=pt.ID ' +
    'WHERE p.Num IN (' + PackagesIDsListString + ') ' +
    'ORDER BY p.Name ASC, p.SubName ASC';
   FPackagesQuery.Open;
   ControlList1.ItemCount := FPackagesQuery.RecordCount;
end;

end.
