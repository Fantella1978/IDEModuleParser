unit UnitCopyAsText;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.CheckLst;

type
  TfrmCopyAsText = class(TForm)
    btnOk: TButton;
    btnCancel: TButton;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    CheckListBox1: TCheckListBox;
    GroupBox2: TGroupBox;
    Memo1: TMemo;
    Splitter1: TSplitter;
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure CheckListBox1ClickCheck(Sender: TObject);
  private
    procedure CopyModulesToClipboard();
    function ModulesGetText: string;
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

procedure TfrmCopyAsText.btnCancelClick(Sender: TObject);
begin
  // ShowMessage('Canceled');
  Close;
end;

procedure TfrmCopyAsText.CheckListBox1ClickCheck(Sender: TObject);
begin
  Memo1.Text := ModulesGetText();
  if Memo1.Text = ''
    then
      btnOk.Enabled := false
    else
      btnOk.Enabled := true
end;

procedure TfrmCopyAsText.CopyModulesToClipboard();
var
  cl: TClipboard;
begin
  // Copy Selected Modules to ....
  cl := TClipboard.Create;
  try
    cl.AsText := ModulesGetText();
  finally
    cl.Free;
  end;
end;

procedure TfrmCopyAsText.FormShow(Sender: TObject);
var
  i: integer;
  colCaption: string;
begin
  CheckListBox1.Clear;
  Memo1.Clear;
  for i := 0 to frmMain.DBGridModules.Columns.Count - 1 do
    begin
      if frmMain.DBGridModules.Columns[i].Visible
        then
          begin
            colCaption := frmMain.DBGridModules.Columns[i].Title.Caption;
            if (pos(' ˅', colCaption, Length(colCaption) - 2) <> 0) or
              (pos(' ˄', colCaption, Length(colCaption) - 2) <> 0)
            then
              colCaption := copy(colCaption, 1, Length(colCaption) - 2);

            CheckListBox1.Items.Add(colCaption);
          end;
    end;
  if CheckListBox1.Items.Count > 0
    then CheckListBox1.Checked[0] := true;

  Memo1.Text := ModulesGetText();
  if Memo1.Text = ''
    then btnOk.Enabled := false
    else btnOk.Enabled := true;
end;

//function TfrmCopyAsText.ModulesGetText: PWideChar;
function TfrmCopyAsText.ModulesGetText: string;
var
  i, k, kc: integer;
  ml: TStringList;
  s: string;
begin
  // Get Selected Modules as Text
  DM1.cdsModules.DisableControls;
  ml := TStringList.Create;
  try
    for i := 0 to frmMain.DBGridModules.SelectedRows.Count - 1 do
    begin
      s  := '';
      kc := 0;
      frmMain.DBGridModules.DataSource.DataSet.GotoBookmark(Tbookmark(frmMain.DBGridModules.SelectedRows[i]));
      for k := 0 to frmMain.DBGridModules.Columns.Count - 1 do
      begin
        if not frmMain.DBGridModules.Columns[k].Visible
          then continue;
        if frmMain.DBGridModules.Columns[k].Visible and CheckListBox1.Checked[kc]
          then
            begin
              if s <> ''
                then s := s + #9;
              s := s + frmMain.DBGridModules.Columns[k].Field.asString;
            end;
        if frmMain.DBGridModules.Columns[k].Visible
          then inc(kc);
      end;
      if s <> ''
        then ml.Add(s);
    end;
    DM1.cdsModules.EnableControls;

    Result := ml.Text;
  finally
    ml.Free;
  end;
end;

procedure TfrmCopyAsText.btnOkClick(Sender: TObject);
begin
  CopyModulesToClipboard();
end;

end.
