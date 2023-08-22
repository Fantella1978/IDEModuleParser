unit UnitCopyVersionInfo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TfrmCopyVersionInfo = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Panel1: TPanel;
    memVersionInformation: TMemo;
    Panel2: TPanel;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure memVersionInformationChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCopyVersionInfo: TfrmCopyVersionInfo;

implementation

{$R *.dfm}

procedure TfrmCopyVersionInfo.FormShow(Sender: TObject);
begin
  memVersionInformation.Clear;
  memVersionInformationChange(Sender);
end;

procedure TfrmCopyVersionInfo.memVersionInformationChange(Sender: TObject);
begin
  if memVersionInformation.Text = ''
    then Button1.Enabled := false
    else Button1.Enabled := true;
end;

end.
