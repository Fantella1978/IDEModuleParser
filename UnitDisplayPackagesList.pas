unit UnitDisplayPackagesList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.ExtCtrls,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ControlList
  , FireDAC.Comp.Client
  ;

type
  TfrmPackagesList = class(TForm)
    Button1: TButton;
    Panel1: TPanel;
    ControlList1: TControlList;
    lblName: TLabel;
    lblURL: TLabel;
    clbURL: TControlListButton;
    lblDescr: TLabel;
    lblGetIt: TLabel;
    lbl3rdParty: TLabel;
    procedure FormShow(Sender: TObject);
    procedure ControlList1BeforeDrawItem(AIndex: Integer; ACanvas: TCanvas;
      ARect: TRect; AState: TOwnerDrawState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure clbURLClick(Sender: TObject);
    procedure ControlList1Click(Sender: TObject);
    procedure lblURLClick(Sender: TObject);
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
  , UnitSettings
  ;

procedure TfrmPackagesList.ControlList1BeforeDrawItem(AIndex: Integer;
  ACanvas: TCanvas; ARect: TRect; AState: TOwnerDrawState);
var
  linePos: integer;
begin
  FPackagesQuery.RecNo := AIndex + 1;
  lblName.Caption := FPackagesQuery.FieldByName('Name').AsString;
  if FPackagesQuery.FieldByName('SubName').AsString <> ''
    then lblName.Caption := lblName.Caption + ' ' + FPackagesQuery.FieldByName('SubName').AsString;
  if GlobalModulesCompareLevel2 AND (FPackagesQuery.FieldByName('Version').AsString <> '')
    then lblName.Caption := lblName.Caption  + ' ' + FPackagesQuery.FieldByName('Version').AsString;

  linePos := lblName.Left + lblName.Width + 10;

  if FPackagesQuery.FieldByName('URL').AsString <> ''
    then
      begin
        lblURL.Caption := 'URL: ' + FPackagesQuery.FieldByName('URL').AsString;
        lblURL.Visible := true;
        clbURL.Visible := true;
        lblDescr.Top := lblURL.Top + lblURL.Height + 5; // 42
      end
    else
      begin
        lblURL.Visible := false;
        clbURL.Visible := false;
        lblDescr.Top := lblName.Top + lblName.Height + 5; // 24
      end;

  if FPackagesQuery.FieldByName('Type_ID').AsInteger in [THIRDPARTY_PACKAGES_TYPE_ID, THIRDPARTY_PACKAGES_WITH_GETIT_TYPE_ID] then
    begin
      lbl3rdParty.Visible := true;
      lbl3rdParty.Left := linePos;
      linePos := lbl3rdParty.Left + lbl3rdParty.Width + 10;
    end
  else
    begin
     lbl3rdParty.Visible := false;
    end;

  lblGetIt.Visible := FPackagesQuery.FieldByName('InGetIt').AsBoolean;
  if lblGetIt.Visible
    then
      begin
        lblGetIt.Left := linePos;
        // linePos := lblGetIt.Left + lblGetIt.Width + 10;
        lblDescr.Height := 15;
      end
    else
      begin
        lblDescr.Height := 30;
      end;

  if FPackagesQuery.FieldByName('Description').AsString <> ''
    then
      begin
        lblDescr.Caption := FPackagesQuery.FieldByName('Description').AsString;
        lblDescr.Visible := true;
        lblDescr.Constraints.MaxWidth := clbURL.Left - lblDescr.Left - 10;
      end
    else
      begin
        lblDescr.Visible := false;
      end;

end;

procedure TfrmPackagesList.ControlList1Click(Sender: TObject);
begin
  // clbURLClick(Sender);
end;

procedure TfrmPackagesList.clbURLClick(Sender: TObject);
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
      PackagesIDsListString := PackagesIDsListString + IntToStr(frmMain.FModulesPackages[i].Package_ID);
      if i <> Length(frmMain.FModulesPackages) - 1
        then PackagesIDsListString := PackagesIDsListString + ', ';
    end;

  if FPackagesQuery = nil
    then FPackagesQuery := TFDQuery.Create(self);
  FPackagesQuery.Connection := DM1.fdcSQLite;
  FPackagesQuery.SQL.Text := '' +
    'SELECT p.*, pt.* ' +
    'FROM Packages AS p ' +
    'LEFT JOIN PackageTypes AS pt ON p.Type_ID=pt.Type_ID ' +
    'WHERE p.Package_ID IN (' + PackagesIDsListString + ') ' +
    'ORDER BY p.Name ASC, p.SubName ASC';
   FPackagesQuery.Open;
   ControlList1.ItemCount := FPackagesQuery.RecordCount;
end;

procedure TfrmPackagesList.lblURLClick(Sender: TObject);
begin
  clbURLClick(Sender);
end;

end.
