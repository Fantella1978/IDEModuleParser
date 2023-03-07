unit UnitPackageEditor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.DBCtrls,
  Vcl.Mask, System.Actions, Vcl.ActnList;

type
  TfrmPackageEditor = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Panel1: TPanel;
    dbeName: TDBEdit;
    lblName: TLabel;
    lblSubName: TLabel;
    dbeSubName: TDBEdit;
    dbeVersion: TDBEdit;
    lblVersion: TLabel;
    lblUrl: TLabel;
    dbeURL: TDBEdit;
    lblVersionRegExp: TLabel;
    dbeVersioRgExp: TDBEdit;
    DBLookupComboBox1: TDBLookupComboBox;
    ActionList1: TActionList;
    actSave: TAction;
    actCancel: TAction;
    lblType: TLabel;
    procedure dbeNameChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure actSaveExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure dbeSubNameChange(Sender: TObject);
    procedure dbeVersionChange(Sender: TObject);
    procedure dbeVersioRgExpChange(Sender: TObject);
    procedure DBLookupComboBox1CloseUp(Sender: TObject);
    procedure dbeURLChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FPackageChanged : boolean;
  public
    { Public declarations }
  end;

var
  frmPackageEditor: TfrmPackageEditor;

implementation

{$R *.dfm}

uses
    UnitDB
  , Data.DB
  , UnitPackagesEditor
  ;

procedure TfrmPackageEditor.actCancelExecute(Sender: TObject);
begin
  Close;
end;

procedure TfrmPackageEditor.actSaveExecute(Sender: TObject);
begin
  if ((DM1.fdtPackages.State in [dsEdit]) AND (MessageDlg('Save edited package?', mtConfirmation, [mbYes, mbNo], 0) = mrYes)) OR
     ((DM1.fdtPackages.State in [dsInsert]) AND (MessageDlg('Save new package?', mtConfirmation, [mbYes, mbNo], 0) = mrYes))
  then
    begin
      DM1.fdtPackages.Post;
      Close;
    end;
end;

procedure TfrmPackageEditor.dbeNameChange(Sender: TObject);
begin
  if not (DM1.fdtPackages.State in [dsEdit, dsInsert]) or (dbeName.Text = '')
  then actSave.Enabled := false
  else actSave.Enabled := true;
  FPackageChanged := true;
  actSave.Enabled := true;
end;

procedure TfrmPackageEditor.dbeSubNameChange(Sender: TObject);
begin
  FPackageChanged := true;
  actSave.Enabled := true;
end;

procedure TfrmPackageEditor.dbeURLChange(Sender: TObject);
begin
  FPackageChanged := true;
  actSave.Enabled := true;
end;

procedure TfrmPackageEditor.dbeVersionChange(Sender: TObject);
begin
  FPackageChanged := true;
  actSave.Enabled := true;
end;

procedure TfrmPackageEditor.dbeVersioRgExpChange(Sender: TObject);
begin
  FPackageChanged := true;
  actSave.Enabled := true;
end;

procedure TfrmPackageEditor.DBLookupComboBox1CloseUp(Sender: TObject);
begin
  FPackageChanged := true;
  actSave.Enabled := true;
end;

procedure TfrmPackageEditor.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if (DM1.fdtPackages.State in [dsEdit, dsInsert]) AND not FPackageChanged
    then
      begin
        DM1.fdtPackages.Cancel;
        CanClose := true;
        Exit;
      end;
  if ((DM1.fdtPackages.State in [dsEdit]) AND (MessageDlg('Cancel edit package?', mtConfirmation, [mbYes, mbNo], 0) = mrYes)) OR
     ((DM1.fdtPackages.State in [dsInsert]) AND (MessageDlg('Cancel add package?', mtConfirmation, [mbYes, mbNo], 0) = mrYes))
  then
    begin
      DM1.fdtPackages.Cancel;
      CanClose := true;
    end
  else CanClose := false;
  if DM1.fdtPackages.State in [dsBrowse] then CanClose := true;
end;

procedure TfrmPackageEditor.FormShow(Sender: TObject);
begin
  FPackageChanged := false;
  actSave.Enabled := false;
  dbeName.SetFocus;
end;

end.
