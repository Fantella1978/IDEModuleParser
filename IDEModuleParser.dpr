program IDEModuleParser;

uses
  Vcl.Forms,
  UnitMain in 'UnitMain.pas' {Form1},
  Vcl.Themes,
  Vcl.Styles,
  UnitDB in 'UnitDB.pas' {DataModule1: TDataModule},
  UnitLogger in 'UnitLogger.pas',
  UnitParser in 'UnitParser.pas' {frmParse},
  UnitIDEModule in 'UnitIDEModule.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Glow');
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TfrmParse, frmParse);
  Application.Run;
end.
