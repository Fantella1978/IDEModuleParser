unit UnitProgressWindow;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls;

type
  TfrmProgress = class(TForm)
    Button2: TButton;
    Panel1: TPanel;
    pbProgress: TProgressBar;
    lblProgress: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    FCanceled : boolean;
    FSuccess : boolean;
  end;

var
  frmProgress: TfrmProgress;

implementation

{$R *.dfm}

procedure TfrmProgress.Button2Click(Sender: TObject);
begin
  FCanceled := true;
  Close;
end;

procedure TfrmProgress.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if FCanceled OR FSuccess
    then CanClose := true
    else CanClose := true;
end;

end.
