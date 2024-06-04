unit UnitPackagesEditor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask, System.Actions,
  Vcl.ActnList, Vcl.Menus
  , UnitStaticFunctions, Vcl.Buttons
  ;

type
  TfrmPackagesEditor = class(TForm)
    ButtonOK: TButton;
    Panel1: TPanel;
    dbgPackages: TDBGrid;
    DBNavigator1: TDBNavigator;
    btnAdd: TButton;
    btnDelete: TButton;
    Button2: TButton;
    ActionList1: TActionList;
    actPackageAdd: TAction;
    actPackageDelete: TAction;
    actPackageEdit: TAction;
    GroupBox1: TGroupBox;
    lbedFilterFileName: TLabeledEdit;
    ppmPackagesEditor: TPopupMenu;
    Add1: TMenuItem;
    Delete1: TMenuItem;
    Edit1: TMenuItem;
    N1: TMenuItem;
    procedure ButtonOKClick(Sender: TObject);
    procedure dbgPackagesDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormResize(Sender: TObject);
    procedure actPackageAddExecute(Sender: TObject);
    procedure actPackageDeleteExecute(Sender: TObject);
    procedure actPackageEditExecute(Sender: TObject);
    procedure actPackagesSaveExecute(Sender: TObject);
    procedure actPackagesCancelExecute(Sender: TObject);
    procedure DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
    procedure dbgPackagesDblClick(Sender: TObject);
    procedure lbedFilterFileNameChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbgPackagesTitleClick(Column: TColumn);
  private
    dbgPackagesColumnsWidth: TDBGridColumnsWidthArray;
    dbgPackages_PrevIndexColumn : integer;
    procedure SetdbgPackagesDefaultColumnsWidth(Sender: TObject);
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
  , UnitPackageEditor
  ;

{$R *.dfm}

procedure TfrmPackagesEditor.SetdbgPackagesDefaultColumnsWidth(Sender: TObject);
begin
  // Set DBGridModules Default Columns Width
  SetLength(dbgPackagesColumnsWidth, dbgPackages.Columns.Count);
  dbgPackagesColumnsWidth := [-1, 150, 100, 150, 50, 150, 220];
  for var i := 0 to dbgPackages.Columns.Count - 1 do
    dbgPackages.Columns[i].Width := dbgPackagesColumnsWidth[i];
end;

procedure TfrmPackagesEditor.actPackageAddExecute(Sender: TObject);
begin
  // Package Add
  if not (DM1.fdtPackages.State in [dsInsert]) then DM1.fdtPackages.Append;
  frmPackageEditor.ShowModal;
end;

procedure TfrmPackagesEditor.actPackageDeleteExecute(Sender: TObject);
begin
  // Package Delete
  if MessageDlg('Delete package "' + DM1.fdtPackages.FieldByName('Name').AsString + '"?',
       TMsgDlgType.mtConfirmation, [mbOk, mbCancel], 0) = mrOk
    then DM1.fdtPackages.Delete;
end;

procedure TfrmPackagesEditor.actPackageEditExecute(Sender: TObject);
begin
  // Package Edit
  DM1.fdtPackages.Edit;
  // actPackageAdd.Enabled     := false;
  // actPackageEdit.Enabled    := false;
  // actPackageDelete.Enabled  := false;
  frmPackageEditor.ShowModal;
end;

procedure TfrmPackagesEditor.actPackagesCancelExecute(Sender: TObject);
begin
  // Cancel Package Edit or Insert
  if frmPackageEditor.Visible then frmPackageEditor.Close;
end;

procedure TfrmPackagesEditor.actPackagesSaveExecute(Sender: TObject);
begin
  // Save Package Info [Post]
end;

procedure TfrmPackagesEditor.ButtonOKClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPackagesEditor.dbgPackagesDblClick(Sender: TObject);
begin
  if DM1.fdtPackages.RecordCount > 0 then actPackageEditExecute(Sender);
end;

procedure TfrmPackagesEditor.dbgPackagesDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  // Rize Column width if text is a long
  AutoCalcDBGridColumnsWidth(dbgPackages, Column, dbgPackagesColumnsWidth);
end;

procedure TfrmPackagesEditor.dbgPackagesTitleClick(Column: TColumn);
var
  ci : integer;
  CurrentBookMark : TBookmark;
  CurrentColumnFieldName : string;
begin

  CurrentColumnFieldName := column.FieldName;   // for Ordering by Lookup field Package_Type
  if column.FieldName = 'Package_Type'
    then CurrentColumnFieldName := 'Type_ID';

  with DM1.fdtPackages do
    try
      CurrentBookMark := GetBookmark;
      DisableControls;
      ci:= Column.Index;
      if ci <> dbgPackages_PrevIndexColumn
      then
        begin
          dbgPackages.Columns[dbgPackages_PrevIndexColumn].Title.Font.Style :=
            dbgPackages.Columns[dbgPackages_PrevIndexColumn].Title.Font.Style - [fsBold];
          dbgPackages.Columns[dbgPackages_PrevIndexColumn].Title.Caption := dbgPackages.Columns[dbgPackages_PrevIndexColumn].FieldName;
        end;
      Column.Title.Font.Style := Column.Title.Font.Style + [fsBold];
      dbgPackages_PrevIndexColumn := ci;

      if (IndexFieldNames = CurrentColumnFieldName + ':DN') OR
         (IndexFieldNames = '')
        then IndexFieldNames := CurrentColumnFieldName + ':AN'
        else IndexFieldNames := CurrentColumnFieldName + ':DN';

      var colCaption := Column.Title.Caption;
      if (pos(' ˅', colCaption, Length(colCaption) - 2) <> 0) or
        (pos(' ˄', colCaption, Length(colCaption) - 2) <> 0)
      then
        colCaption := copy(colCaption, 1, Length(colCaption) - 2);
      Column.Title.Caption := colCaption;

      if IndexFieldNames = CurrentColumnFieldName + ':DN'
        then Column.Title.Caption := Column.Title.Caption + ' ˄'
        else Column.Title.Caption := Column.Title.Caption + ' ˅';

    finally
      GotoBookmark(CurrentBookMark);
      FreeBookMark(CurrentBookMark);
      EnableControls;
    end;
end;

procedure TfrmPackagesEditor.DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
begin
  if Button = nbInsert then actPackageAddExecute(Sender);
  if Button = nbEdit then actPackageEditExecute(Sender);
  if Button = nbDelete then actPackageDeleteExecute(Sender);
end;

procedure TfrmPackagesEditor.FormResize(Sender: TObject);
begin
  {
  for var i := 0 to dbgPackages.Columns.Count - 1 do
    if dbgPackages.Columns[i].Visible and (dbgPackages.Columns[i].Width > 100) then
      dbgPackages.Columns[i].Width := 100;
  }
  AutoStretchDBGridColumns(dbgPackages, dbgPackagesColumnsWidth);
end;

procedure TfrmPackagesEditor.FormShow(Sender: TObject);
begin
  // DM1.fdtPackages.IndexName := 'NameSubNameIndex';
  // DM1.fdtPackages.IndexName := '';
  lbedFilterFileName.Text := '';
  DM1.fdtPackages.DisableControls;
  DM1.fdtPackages.IndexFieldNames := 'Name:DN';
  DM1.fdtPackages.Filtered := false;
  dbgPackagesTitleClick(dbgPackages.Columns[1]);
  DM1.fdtPackages.First;
  DM1.fdtPackages.EnableControls;
  SetdbgPackagesDefaultColumnsWidth(Sender);
  AutoStretchDBGridColumns(dbgPackages, dbgPackagesColumnsWidth);
end;

procedure TfrmPackagesEditor.lbedFilterFileNameChange(Sender: TObject);
begin
  if lbedFilterFileName.Text <> ''
  then
    begin
      DM1.fdtPackages.Filter := 'Name LIKE ''' + lbedFilterFileName.Text + '%''';
      DM1.fdtPackages.FilterOptions := [foCaseInsensitive];
      DM1.fdtPackages.Filtered := true;
    end
  else
    DM1.fdtPackages.Filtered := false;
end;

end.
