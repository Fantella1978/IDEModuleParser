unit UnitPackagesEditor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask;

type
  TfrmPackagesEditor = class(TForm)
    Button1: TButton;
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    dbeName: TDBEdit;
    lblName: TLabel;
    DBNavigator1: TDBNavigator;
    btnAdd: TButton;
    btnDelete: TButton;
    dbeURL: TDBEdit;
    lblUrl: TLabel;
    dbeVersion: TDBEdit;
    DBEdit2: TDBEdit;
    lblVersion: TLabel;
    lblVersionRegExp: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormResize(Sender: TObject);
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
  ;

{$R *.dfm}

procedure TfrmPackagesEditor.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmPackagesEditor.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
Var
  wi, sw, i : Integer;
begin
  // Rize Column width if text is a long
  wi := 5 + DBGrid1.Canvas.TextExtent(Column.Field.DisplayText).cx;
  if wi > column.Width
  then
    begin
      sw := 0;
      for i := 0 to DBGrid1.Columns.Count - 1 do
        if DBGrid1.Columns[i].Visible AND (DBGrid1.Columns[i] <> Column)
          then sw := sw + DBGrid1.Columns[i].Width;
      if DBGrid1.Width > sw + wi then Column.Width := wi;
    end;
end;

procedure TfrmPackagesEditor.FormResize(Sender: TObject);
begin
   for var i := 0 to DBGrid1.Columns.Count - 1 do
    if DBGrid1.Columns[i].Visible AND (DBGrid1.Columns[i].Width > 100) then DBGrid1.Columns[i].Width := 100;
end;

end.
