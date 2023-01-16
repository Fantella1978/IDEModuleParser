program IDEModuleParser;

uses
  Vcl.Forms,
  UnitMain in 'UnitMain.pas' {Form1},
  Vcl.Themes,
  Vcl.Styles,
  UnitDB in 'UnitDB.pas' {DataModule1: TDataModule},
  UnitLogger in 'UnitLogger.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Glow');
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.
