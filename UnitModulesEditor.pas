unit UnitModulesEditor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls, Vcl.Mask;

type
  TfrmModulesEditor = class(TForm)
    Button1: TButton;
    pnlBottom: TPanel;
    dbgModules: TDBGrid;
    DBNavigator1: TDBNavigator;
    pnlTop: TPanel;
    lbedFilterFileName: TLabeledEdit;
    GroupBox1: TGroupBox;
    procedure dbgModulesDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure Button1Click(Sender: TObject);
    procedure lbedFilterFileNameChange(Sender: TObject);
  private
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
  ;

procedure TfrmModulesEditor.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmModulesEditor.dbgModulesDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
Var
  wi, sw, i : Integer;
begin
  // Rize Column width if text is a long
  wi := 10 + dbgModules.Canvas.TextExtent(Column.Field.DisplayText).cx;
  if wi > column.Width
  then
    begin
      sw := 0;
      for i := 0 to dbgModules.Columns.Count - 1 do
        if dbgModules.Columns[i].Visible AND (dbgModules.Columns[i] <> Column)
          then sw := sw + dbgModules.Columns[i].Width;
      if dbgModules.Width > sw + wi then Column.Width := wi;
    end;
end;

procedure TfrmModulesEditor.lbedFilterFileNameChange(Sender: TObject);
begin
  if lbedFilterFileName.Text <> ''
  then
    begin
      DM1.fdtModules.Filter := 'FileName LIKE ''' + lbedFilterFileName.Text + '%''';
      DM1.fdtModules.FilterOptions := [foCaseInsensitive];
      DM1.fdtModules.Filtered := true;
    end
  else
    begin
      DM1.fdtModules.Filtered := false;
    end;
end;

end.
