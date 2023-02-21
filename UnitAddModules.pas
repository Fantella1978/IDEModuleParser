unit UnitAddModules;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.DBCtrls,
  Vcl.CheckLst;

type
  TfrmAddModules = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    GroupBox2: TGroupBox;
    CheckListBox1: TCheckListBox;
    Button5: TButton;
    GroupBox3: TGroupBox;
    ListBox1: TListBox;
    ComboBox1: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAddModules: TfrmAddModules;

implementation

{$R *.dfm}

uses
  UnitMain
  ;

procedure TfrmAddModules.btnOKClick(Sender: TObject);
begin
  //

end;

procedure TfrmAddModules.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmAddModules.FormShow(Sender: TObject);
var
  i : integer;
  colCaption : string;
begin
  CheckListBox1.Clear;
  // Memo1.Clear;
  for I := 0 to frmMain.DBGrid1.Columns.Count - 1 do
  begin
    if frmMain.DBGrid1.Columns[i].Visible
    then
      begin
        colCaption := frmMain.DBGrid1.Columns[i].Title.Caption;
        if (pos(' ˅', colCaption, Length(colCaption) - 2) <> 0) OR
           (pos(' ˄', colCaption, Length(colCaption) - 2) <> 0)
         then colCaption := copy(colCaption, 1, Length(colCaption) - 2);

        CheckListBox1.Items.Add(colCaption);
      end;
  end;
  if CheckListBox1.Items.Count > 0 then CheckListBox1.Checked[0] := true;
{
  Memo1.Text := ModulesGetText();
  if Memo1.Text = ''
    then btnOk.Enabled := false
    else btnOk.Enabled := true}

end;


end.
