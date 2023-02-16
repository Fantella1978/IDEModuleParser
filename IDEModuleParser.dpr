program IDEModuleParser;

uses
  Vcl.Forms,
  Vcl.Themes,
  Vcl.Styles,
  UnitMain in 'UnitMain.pas' {frmMain},
  UnitParser in 'UnitParser.pas' {frmParse},
  UnitDB in 'UnitDB.pas' {DM1: TDataModule},
  UnitLogger in 'UnitLogger.pas',
  UnitIDEModule in 'UnitIDEModule.pas',
  UnitStaticFunctions in 'UnitStaticFunctions.pas',
  UnitPackagesEditor in 'UnitPackagesEditor.pas' {frmPackagesEditor},
  UnitCopyAsText in 'UnitCopyAsText.pas' {frmCopyAsText},
  UnitDBGrid in 'UnitDBGrid.pas',
  UnitSettings in 'UnitSettings.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Amethyst Kamri');
  Application.CreateForm(TDM1, DM1);
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmParse, frmParse);
  Application.CreateForm(TfrmPackagesEditor, frmPackagesEditor);
  Application.CreateForm(TfrmCopyAsText, frmCopyAsText);
  Application.Run;
end.
