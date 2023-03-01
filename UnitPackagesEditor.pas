unit UnitPackagesEditor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask, System.Actions,
  Vcl.ActnList;

type
  TfrmPackagesEditor = class(TForm)
    ButtonOK: TButton;
    Panel1: TPanel;
    dbgPackages: TDBGrid;
    dbeName: TDBEdit;
    lblName: TLabel;
    DBNavigator1: TDBNavigator;
    btnAdd: TButton;
    btnDelete: TButton;
    dbeURL: TDBEdit;
    lblUrl: TLabel;
    dbeVersion: TDBEdit;
    dbeVersioRgExp: TDBEdit;
    lblVersion: TLabel;
    lblVersionRegExp: TLabel;
    Button2: TButton;
    ActionList1: TActionList;
    actPackageAdd: TAction;
    actPackageDelete: TAction;
    actPackageEdit: TAction;
    Button3: TButton;
    actPackagesSave: TAction;
    Button4: TButton;
    actPackagesCancel: TAction;
    lblSurName: TLabel;
    dbeSurName: TDBEdit;
    DBLookupComboBox1: TDBLookupComboBox;
    procedure ButtonOKClick(Sender: TObject);
    procedure dbgPackagesDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormResize(Sender: TObject);
    procedure actPackageAddExecute(Sender: TObject);
    procedure actPackageDeleteExecute(Sender: TObject);
    procedure actPackageEditExecute(Sender: TObject);
    procedure actPackagesSaveExecute(Sender: TObject);
    procedure dbeNameChange(Sender: TObject);
    procedure actPackagesCancelExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure dbeVersionChange(Sender: TObject);
    procedure dbeVersioRgExpChange(Sender: TObject);
    procedure dbeURLChange(Sender: TObject);
    procedure dbeSurNameChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPackagesEditor: TfrmPackagesEditor;

implementation

uses
    UnitDB
  , System.UITypes
  ;

{$R *.dfm}


procedure TfrmPackagesEditor.actPackageAddExecute(Sender: TObject);
begin
  // Package Add
  DM1.fdtPackages.Append;
  actPackageAdd.Enabled     := false;
  actPackageEdit.Enabled    := false;
  actPackageDelete.Enabled  := false;
  actPackagesSave.Enabled   := false;
  actPackagesCancel.Enabled := true;
end;

procedure TfrmPackagesEditor.actPackageDeleteExecute(Sender: TObject);
begin
  // Package Delete
  if MessageDlg('Delete Record?', TMsgDlgType.mtConfirmation, [mbOk, mbCancel], 0) = mrOk
    then DM1.fdtPackages.Delete;
end;

procedure TfrmPackagesEditor.actPackageEditExecute(Sender: TObject);
begin
  // Package Edit
  DM1.fdtPackages.Edit;
  actPackageAdd.Enabled     := false;
  actPackageEdit.Enabled    := false;
  actPackageDelete.Enabled  := false;
  actPackagesSave.Enabled   := true;
  actPackagesCancel.Enabled := true;
end;

procedure TfrmPackagesEditor.actPackagesCancelExecute(Sender: TObject);
begin
  // Cancel Package Edit
  DM1.fdtPackages.Cancel;
  actPackageAdd.Enabled     := true;
  actPackagesSave.Enabled   := false;
  actPackagesCancel.Enabled := false;
end;

procedure TfrmPackagesEditor.actPackagesSaveExecute(Sender: TObject);
begin
  // Save Package Info [Post]
  DM1.fdtPackages.Post;
  actPackageAdd.Enabled     := true;
  actPackageEdit.Enabled    := true;
  actPackageDelete.Enabled  := true;
  actPackagesSave.Enabled   := false;
  actPackagesCancel.Enabled := false;
end;

procedure TfrmPackagesEditor.ButtonOKClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPackagesEditor.dbeVersioRgExpChange(Sender: TObject);
begin
  if DM1.fdtPackages.State in [dsEdit, dsInsert]
  then
    begin
      actPackagesSave.Enabled   := true;
      actPackagesCancel.Enabled := true;
    end;
end;

procedure TfrmPackagesEditor.dbeNameChange(Sender: TObject);
begin
  if not (DM1.fdtPackages.State in [dsEdit, dsInsert]) or (dbeName.Text = '')
  then
    actPackagesSave.Enabled := false
  else
    actPackagesSave.Enabled := true
end;

procedure TfrmPackagesEditor.dbeSurNameChange(Sender: TObject);
begin
  if DM1.fdtPackages.State in [dsEdit, dsInsert]
  then
    begin
      actPackagesSave.Enabled   := true;
      actPackagesCancel.Enabled := true;
    end;
end;

procedure TfrmPackagesEditor.dbeURLChange(Sender: TObject);
begin
  if DM1.fdtPackages.State in [dsEdit, dsInsert]
  then
    begin
      actPackagesSave.Enabled   := true;
      actPackagesCancel.Enabled := true;
    end;
end;

procedure TfrmPackagesEditor.dbeVersionChange(Sender: TObject);
begin
  if DM1.fdtPackages.State in [dsEdit, dsInsert]
  then
    begin
      actPackagesSave.Enabled   := true;
      actPackagesCancel.Enabled := true;
    end;
end;

procedure TfrmPackagesEditor.dbgPackagesDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  wi, sw, i: Integer;
begin
  // Rize Column width if text is a long
  wi := 10 + dbgPackages.Canvas.TextExtent(Column.Field.DisplayText).cx;
  if wi > Column.Width
  then
  begin
    sw    := 0;
    for i := 0 to dbgPackages.Columns.Count - 1 do
      if dbgPackages.Columns[i].Visible and (dbgPackages.Columns[i] <> Column)
      then
        sw := sw + dbgPackages.Columns[i].Width;
    if dbgPackages.Width > sw + wi then
      Column.Width := wi;
  end;
end;

procedure TfrmPackagesEditor.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if DM1.fdtPackages.State in [dsEdit, dsInsert]
  then
  begin
    var
    res := MessageDlg('Save edited data before exit?', mtInformation, [mbYes, mbNo, mbCancel], 0);
    case res of
      mrCancel:
        CanClose := false;
      mrYes:
        begin
          try
            DM1.fdtPackages.Post;
            CanClose := true;
          except
            CanClose := false;
          end;
        end;
      mrNo:
        begin
          DM1.fdtPackages.Cancel;
          CanClose := true;
        end;
    end;
  end
  else
    CanClose := true;
end;

procedure TfrmPackagesEditor.FormResize(Sender: TObject);
begin
  for var i := 0 to dbgPackages.Columns.Count - 1 do
    if dbgPackages.Columns[i].Visible and (dbgPackages.Columns[i].Width > 100) then
      dbgPackages.Columns[i].Width := 100;
end;

end.
