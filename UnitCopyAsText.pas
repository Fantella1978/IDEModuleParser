unit UnitCopyAsText;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.CheckLst;

type
  TfrmCopyAsText = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    CheckListBox1: TCheckListBox;
    GroupBox2: TGroupBox;
    Memo1: TMemo;
    Splitter1: TSplitter;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CheckListBox1ClickCheck(Sender: TObject);
  private
    procedure CopyModulesToClipboard();
    function ModulesGetText: PWideChar;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCopyAsText: TfrmCopyAsText;

implementation

{$R *.dfm}

uses
    Clipbrd
  , UnitMain
  , UnitDB
  , Data.DB
  ;

procedure TfrmCopyAsText.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmCopyAsText.CheckListBox1ClickCheck(Sender: TObject);
begin
  Memo1.Text := ModulesGetText();
end;

procedure TfrmCopyAsText.CopyModulesToClipboard();
var
  i : integer;
  ml : TStringList;
  cl : TClipboard;
begin
  // Copy Selected Modules to ....
  DM1.cdsModules.DisableControls;
  ml := TStringList.Create;
  for i := 0 to frmMain.DBGrid1.SelectedRows.Count - 1 do
  begin
    frmMain.DBGrid1.DataSource.DataSet.GotoBookmark(Tbookmark(frmMain.DBGrid1.SelectedRows[i]));
    ml.Add(frmMain.DBGrid1.Columns[1].field.asString);
  end;
  // DBGrid1.SelectedRows.Clear;
  cl := TClipboard.Create;
  cl.AsText := ml.GetText;
  // DM1.cdsModules.First;
  DM1.cdsModules.EnableControls;
end;

procedure TfrmCopyAsText.FormShow(Sender: TObject);
var
  i : integer;
begin
  CheckListBox1.Clear;
  Memo1.Clear;
  for I := 0 to frmMain.DBGrid1.Columns.Count - 1 do
  begin
    if frmMain.DBGrid1.Columns[i].Visible then
      CheckListBox1.Items.Add(frmMain.DBGrid1.Columns[i].DisplayName);
  end;
end;

function TfrmCopyAsText.ModulesGetText: PWideChar;
var
  i, k, kc : integer;
  ml : TStringList;
  s: string;
begin
  // Copy Selected Modules to ....
  DM1.cdsModules.DisableControls;
  ml := TStringList.Create;
  for i := 0 to frmMain.DBGrid1.SelectedRows.Count - 1 do
  begin
    s := '';
    kc := 0;
    frmMain.DBGrid1.DataSource.DataSet.GotoBookmark(Tbookmark(frmMain.DBGrid1.SelectedRows[i]));
    for k := 0 to frmMain.DBGrid1.Columns.Count - 1 do
    begin
      if not frmMain.DBGrid1.Columns[k].Visible
        then continue;
      if frmMain.DBGrid1.Columns[k].Visible AND CheckListBox1.Checked[kc]
        then
          begin
            s := s + frmMain.DBGrid1.Columns[k].Field.asString + #9;
          end;
      if frmMain.DBGrid1.Columns[k].Visible then inc(kc);
    end;
    ml.Add(s);
  end;
  DM1.cdsModules.EnableControls;

  Result := ml.GetText;
end;

procedure TfrmCopyAsText.Button1Click(Sender: TObject);
begin
  CopyModulesToClipboard();
end;

end.
