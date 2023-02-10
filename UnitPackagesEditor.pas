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
    DBEdit1: TDBEdit;
    lblUrl: TLabel;
    procedure Button1Click(Sender: TObject);
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

end.
