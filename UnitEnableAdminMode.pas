unit UnitEnableAdminMode;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask;

type
  TfrmEnableAdminMode = class(TForm)
    btnOk: TButton;
    Button2: TButton;
    Panel1: TPanel;
    MaskEdit1: TMaskEdit;
    lblRandomeCode: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure MaskEdit1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEnableAdminMode: TfrmEnableAdminMode;

implementation

{$R *.dfm}

uses
  UnitSettings
  ;

procedure TfrmEnableAdminMode.btnOkClick(Sender: TObject);
begin
  GlobalAdminMode := true;
end;

procedure TfrmEnableAdminMode.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmEnableAdminMode.FormShow(Sender: TObject);
begin
  lblRandomeCode.Caption := IntToStr(1000 + Random(8999));
  MaskEdit1.Text := '';
  MaskEdit1Change(Sender);
end;

procedure TfrmEnableAdminMode.MaskEdit1Change(Sender: TObject);
begin
  if MaskEdit1.Text = lblRandomeCode.Caption
  then btnOk.Enabled := true
  else btnOk.Enabled := false;
end;

end.
