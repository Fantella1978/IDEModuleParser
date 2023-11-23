unit UnitCopyVersionInfo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  System.Actions, Vcl.ActnList;

type
  TfrmCopyVersionInfo = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    Panel1: TPanel;
    memVersionInformation: TMemo;
    Panel2: TPanel;
    Label1: TLabel;
    Button3: TButton;
    ActionList1: TActionList;
    actPasteFromClipboard: TAction;
    procedure FormShow(Sender: TObject);
    procedure memVersionInformationChange(Sender: TObject);
    procedure actPasteFromClipboardExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCopyVersionInfo: TfrmCopyVersionInfo;

implementation

{$R *.dfm}

uses
  ClipBrd
  ;

procedure TfrmCopyVersionInfo.actPasteFromClipboardExecute(Sender: TObject);
begin
  // Paste From Clipboard
  if Clipboard.HasFormat(CF_TEXT) then
  begin
    memVersionInformation.Text := Clipboard.AsText;
    actPasteFromClipboard.Enabled := false;
  end;
end;

procedure TfrmCopyVersionInfo.FormActivate(Sender: TObject);
begin
  if Clipboard.HasFormat(CF_TEXT)
    then actPasteFromClipboard.Enabled := true
    else actPasteFromClipboard.Enabled := false;
end;

procedure TfrmCopyVersionInfo.FormShow(Sender: TObject);
begin
  memVersionInformation.Clear;
  memVersionInformationChange(Sender);
end;

procedure TfrmCopyVersionInfo.memVersionInformationChange(Sender: TObject);
begin
  if memVersionInformation.Text = ''
    then btnOK.Enabled := false
    else btnOK.Enabled := true;
end;

end.
