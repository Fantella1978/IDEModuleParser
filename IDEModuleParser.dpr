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
  UnitSettings in 'UnitSettings.pas',
  UnitModulesEditor in 'UnitModulesEditor.pas' {frmModulesEditor},
  UnitAddModules in 'UnitAddModules.pas' {frmAddModules},
  UnitEnableAdminMode in 'UnitEnableAdminMode.pas' {frmEnableAdminMode};

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
  Application.CreateForm(TfrmModulesEditor, frmModulesEditor);
  Application.CreateForm(TfrmAddModules, frmAddModules);
  Application.CreateForm(TfrmEnableAdminMode, frmEnableAdminMode);
  Application.Run;
end.
