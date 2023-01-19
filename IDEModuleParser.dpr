program IDEModuleParser;

uses
  Vcl.Forms,
  Vcl.Themes,
  Vcl.Styles,
  UnitMain in 'UnitMain.pas' {frmMain},
  UnitParser in 'UnitParser.pas' {frmParse},
  UnitDB in 'UnitDB.pas' {DataModule1: TDataModule},
  UnitLogger in 'UnitLogger.pas',
  UnitIDEModule in 'UnitIDEModule.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Glow');
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmParse, frmParse);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.
