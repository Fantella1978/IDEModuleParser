program IDEModuleParser;

uses
  Vcl.Forms,
  Vcl.Themes,
  Vcl.Styles,
  System.SysUtils,
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
  UnitEnableAdminMode in 'UnitEnableAdminMode.pas' {frmEnableAdminMode},
  UnitPackageEditor in 'UnitPackageEditor.pas' {frmPackageEditor},
  UnitProgressWindow in 'UnitProgressWindow.pas' {frmProgress},
  UnitDisplayPackagesList in 'UnitDisplayPackagesList.pas' {frmPackagesList};

{$R *.res}

begin
  // TFormatSettings.Create;
  FormatSettings.DateSeparator := '/';
  FormatSettings.TimeSeparator := ':';
  FormatSettings.ShortDateFormat := 'yyyy/mm/dd';
  FormatSettings.LongTimeFormat := 'hh:nn:ss';

  ReportMemoryLeaksOnShutdown := true;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'IDE Module Parser';
  Application.CreateForm(TDM1, DM1);
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmParse, frmParse);
  Application.CreateForm(TfrmPackagesEditor, frmPackagesEditor);
  Application.CreateForm(TfrmCopyAsText, frmCopyAsText);
  Application.CreateForm(TfrmModulesEditor, frmModulesEditor);
  Application.CreateForm(TfrmAddModules, frmAddModules);
  Application.CreateForm(TfrmEnableAdminMode, frmEnableAdminMode);
  Application.CreateForm(TfrmPackageEditor, frmPackageEditor);
  Application.CreateForm(TfrmProgress, frmProgress);
  Application.CreateForm(TfrmPackagesList, frmPackagesList);
  TStyleManager.TrySetStyle('Amethyst Kamri');
  Application.Run;
end.
