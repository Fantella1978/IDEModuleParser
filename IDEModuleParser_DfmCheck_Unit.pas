unit IDEModuleParser_DfmCheck_Unit;

interface

implementation

uses
  UnitMain,
  UnitParser,
  UnitDB,
  UnitPackagesEditor,
  UnitCopyAsText,
  UnitModulesEditor,
  UnitAddModules,
  SysUtils;

procedure TestDfmFormConsistency;
begin
{ frmMain: TfrmMain }
  with TfrmMain(nil) do { UnitMain.pas }
  begin
    Panel1.ClassName; { Panel1: TPanel; }
    Button1.ClassName; { Button1: TButton; }
    Button2.ClassName; { Button2: TButton; }
    Button3.ClassName; { Button3: TButton; }
    Button4.ClassName; { Button4: TButton; }
    PageControl1.ClassName; { PageControl1: TPageControl; }
    tsHome.ClassName; { tsHome: TTabSheet; }
    lblStartMessageMain.ClassName; { lblStartMessageMain: TLabel; }
    lblStartMessageSecondary.ClassName; { lblStartMessageSecondary: TLabel; }
    tsModuleListFile.ClassName; { tsModuleListFile: TTabSheet; }
    Panel2.ClassName; { Panel2: TPanel; }
    lbedModuleFile.ClassName; { lbedModuleFile: TLabeledEdit; }
    MemoTxtModuleFile.ClassName; { MemoTxtModuleFile: TMemo; }
    tsModulesList.ClassName; { tsModulesList: TTabSheet; }
    SpeedButton1.ClassName; { SpeedButton1: TSpeedButton; }
    SpeedButton2.ClassName; { SpeedButton2: TSpeedButton; }
    lblModulesSelectedCount.ClassName; { lblModulesSelectedCount: TLabel; }
    SpeedButton3.ClassName; { SpeedButton3: TSpeedButton; }
    ledtBDSBuild.ClassName; { ledtBDSBuild: TLabeledEdit; }
    ledtBDSPath.ClassName; { ledtBDSPath: TLabeledEdit; }
    ledtBDSInstDate.ClassName; { ledtBDSInstDate: TLabeledEdit; }
    DBGrid1.ClassName; { DBGrid1: TDBGrid; }
    tsStackTraceFile.ClassName; { tsStackTraceFile: TTabSheet; }
    Panel5.ClassName; { Panel5: TPanel; }
    lbedStackTraceFile.ClassName; { lbedStackTraceFile: TLabeledEdit; }
    memoStackTrace.ClassName; { memoStackTrace: TMemo; }
    tsDXDiagLogFile.ClassName; { tsDXDiagLogFile: TTabSheet; }
    Panel6.ClassName; { Panel6: TPanel; }
    lbedDXDiagLogFile.ClassName; { lbedDXDiagLogFile: TLabeledEdit; }
    memoDXDiagLog.ClassName; { memoDXDiagLog: TMemo; }
    tsDescriptionFile.ClassName; { tsDescriptionFile: TTabSheet; }
    Panel8.ClassName; { Panel8: TPanel; }
    lbedDescriptionFile.ClassName; { lbedDescriptionFile: TLabeledEdit; }
    memoDescription.ClassName; { memoDescription: TMemo; }
    tsStepsFile.ClassName; { tsStepsFile: TTabSheet; }
    Panel7.ClassName; { Panel7: TPanel; }
    lbedStepsFile.ClassName; { lbedStepsFile: TLabeledEdit; }
    memoSteps.ClassName; { memoSteps: TMemo; }
    tsSettings.ClassName; { tsSettings: TTabSheet; }
    Panel3.ClassName; { Panel3: TPanel; }
    GroupBox1.ClassName; { GroupBox1: TGroupBox; }
    lblFontSize.ClassName; { lblFontSize: TLabel; }
    tbFontSize.ClassName; { tbFontSize: TTrackBar; }
    edtFontSize.ClassName; { edtFontSize: TEdit; }
    GroupBox2.ClassName; { GroupBox2: TGroupBox; }
    cbCreateLog.ClassName; { cbCreateLog: TCheckBox; }
    GroupBox3.ClassName; { GroupBox3: TGroupBox; }
    Button5.ClassName; { Button5: TButton; }
    btnModulesEditor.ClassName; { btnModulesEditor: TButton; }
    Button6.ClassName; { Button6: TButton; }
    tsLog.ClassName; { tsLog: TTabSheet; }
    memoLog.ClassName; { memoLog: TMemo; }
    Panel4.ClassName; { Panel4: TPanel; }
    lbedLogPath.ClassName; { lbedLogPath: TLabeledEdit; }
    ActionList1.ClassName; { ActionList1: TActionList; }
    actExit.ClassName; { actExit: TAction; }
    actOpenModuleFile.ClassName; { actOpenModuleFile: TAction; }
    actParseModuleFile.ClassName; { actParseModuleFile: TAction; }
    actOpenReportZipFile.ClassName; { actOpenReportZipFile: TAction; }
    actParseCancel.ClassName; { actParseCancel: TAction; }
    actPackagesEditor.ClassName; { actPackagesEditor: TAction; }
    actModulesEditor.ClassName; { actModulesEditor: TAction; }
    actModulesCopySelectedAsText.ClassName; { actModulesCopySelectedAsText: TAction; }
    actModulesSelectAll.ClassName; { actModulesSelectAll: TAction; }
    actModulesUnSelectAll.ClassName; { actModulesUnSelectAll: TAction; }
    actModulesAddSelectedToDB.ClassName; { actModulesAddSelectedToDB: TAction; }
    actSettingsRestoreDefaults.ClassName; { actSettingsRestoreDefaults: TAction; }
    OpenTextFileDialog1.ClassName; { OpenTextFileDialog1: TOpenTextFileDialog; }
    OpenDialog1.ClassName; { OpenDialog1: TOpenDialog; }
    ppmModulesGrid.ClassName; { ppmModulesGrid: TPopupMenu; }
    Copytoclipboard1.ClassName; { Copytoclipboard1: TMenuItem; }
    AddtoKnownModulesDB1.ClassName; { AddtoKnownModulesDB1: TMenuItem; }
    N1.ClassName; { N1: TMenuItem; }
    actModulesSelectAll1.ClassName; { actModulesSelectAll1: TMenuItem; }
    UnselectAll1.ClassName; { UnselectAll1: TMenuItem; }
  end;

{ frmParse: TfrmParse }
  with TfrmParse(nil) do { UnitParser.pas }
  begin
    lblOverall.ClassName; { lblOverall: TLabel; }
    lblCurrentTask.ClassName; { lblCurrentTask: TLabel; }
    Panel1.ClassName; { Panel1: TPanel; }
    btnStop.ClassName; { btnStop: TButton; }
    pBarOverall.ClassName; { pBarOverall: TProgressBar; }
    pBarCurrentTask.ClassName; { pBarCurrentTask: TProgressBar; }
  end;

{ DM1: TDM1 }
  with TDM1(nil) do { UnitDB.pas }
  begin
    cdsModules.ClassName; { cdsModules: TClientDataSet; }
    cdsModulesNum.ClassName; { cdsModulesNum: TIntegerField; }
    cdsModulesName.ClassName; { cdsModulesName: TStringField; }
    cdsModulesPath.ClassName; { cdsModulesPath: TStringField; }
    cdsModulesVersion.ClassName; { cdsModulesVersion: TStringField; }
    cdsModulesDateAndTime.ClassName; { cdsModulesDateAndTime: TDateTimeField; }
    cdsModulesHash.ClassName; { cdsModulesHash: TStringField; }
    cdsModulesPackageID.ClassName; { cdsModulesPackageID: TIntegerField; }
    cdsModulesPackageName.ClassName; { cdsModulesPackageName: TStringField; }
    DataSource1.ClassName; { DataSource1: TDataSource; }
    DataSetProvider1.ClassName; { DataSetProvider1: TDataSetProvider; }
    cdsPackages.ClassName; { cdsPackages: TClientDataSet; }
    cdsPackagesNum.ClassName; { cdsPackagesNum: TIntegerField; }
    cdsPackagesName.ClassName; { cdsPackagesName: TStringField; }
    cdsPackagesUrl.ClassName; { cdsPackagesUrl: TStringField; }
    dsLocalPackages.ClassName; { dsLocalPackages: TDataSource; }
    DataSetProvider2.ClassName; { DataSetProvider2: TDataSetProvider; }
    fdcSQLite.ClassName; { fdcSQLite: TFDConnection; }
    fdqModulesFromQuery.ClassName; { fdqModulesFromQuery: TFDQuery; }
    fdtModules.ClassName; { fdtModules: TFDTable; }
    dsModules.ClassName; { dsModules: TDataSource; }
    fdtPackages.ClassName; { fdtPackages: TFDTable; }
    dsPackages.ClassName; { dsPackages: TDataSource; }
    dsModulesFromQuery.ClassName; { dsModulesFromQuery: TDataSource; }
    FDUpdateSQL1.ClassName; { FDUpdateSQL1: TFDUpdateSQL; }
  end;

{ frmPackagesEditor: TfrmPackagesEditor }
  with TfrmPackagesEditor(nil) do { UnitPackagesEditor.pas }
  begin
    lblName.ClassName; { lblName: TLabel; }
    lblUrl.ClassName; { lblUrl: TLabel; }
    lblVersion.ClassName; { lblVersion: TLabel; }
    lblVersionRegExp.ClassName; { lblVersionRegExp: TLabel; }
    Panel1.ClassName; { Panel1: TPanel; }
    ButtonOK.ClassName; { ButtonOK: TButton; }
    dbgPackages.ClassName; { dbgPackages: TDBGrid; }
    dbeName.ClassName; { dbeName: TDBEdit; }
    DBNavigator1.ClassName; { DBNavigator1: TDBNavigator; }
    btnAdd.ClassName; { btnAdd: TButton; }
    btnDelete.ClassName; { btnDelete: TButton; }
    dbeURL.ClassName; { dbeURL: TDBEdit; }
    dbeVersion.ClassName; { dbeVersion: TDBEdit; }
    DBEdit2.ClassName; { DBEdit2: TDBEdit; }
    Button2.ClassName; { Button2: TButton; }
    Button3.ClassName; { Button3: TButton; }
    Button4.ClassName; { Button4: TButton; }
    ActionList1.ClassName; { ActionList1: TActionList; }
    actPackageAdd.ClassName; { actPackageAdd: TAction; }
    actPackageDelete.ClassName; { actPackageDelete: TAction; }
    actPackageEdit.ClassName; { actPackageEdit: TAction; }
    actPackagesSave.ClassName; { actPackagesSave: TAction; }
    actPackagesCancel.ClassName; { actPackagesCancel: TAction; }
  end;

{ frmCopyAsText: TfrmCopyAsText }
  with TfrmCopyAsText(nil) do { UnitCopyAsText.pas }
  begin
    Splitter1.ClassName; { Splitter1: TSplitter; }
    Panel1.ClassName; { Panel1: TPanel; }
    btnOk.ClassName; { btnOk: TButton; }
    btnCancel.ClassName; { btnCancel: TButton; }
    GroupBox2.ClassName; { GroupBox2: TGroupBox; }
    Memo1.ClassName; { Memo1: TMemo; }
    GroupBox1.ClassName; { GroupBox1: TGroupBox; }
    CheckListBox1.ClassName; { CheckListBox1: TCheckListBox; }
  end;

{ frmModulesEditor: TfrmModulesEditor }
  with TfrmModulesEditor(nil) do { UnitModulesEditor.pas }
  begin
    Panel1.ClassName; { Panel1: TPanel; }
    Button1.ClassName; { Button1: TButton; }
    dbgModules.ClassName; { dbgModules: TDBGrid; }
    Panel2.ClassName; { Panel2: TPanel; }
    DBNavigator1.ClassName; { DBNavigator1: TDBNavigator; }
  end;

{ frmAddModules: TfrmAddModules }
  with TfrmAddModules(nil) do { UnitAddModules.pas }
  begin
    Panel1.ClassName; { Panel1: TPanel; }
    Button1.ClassName; { Button1: TButton; }
    Button2.ClassName; { Button2: TButton; }
    GroupBox1.ClassName; { GroupBox1: TGroupBox; }
    Label1.ClassName; { Label1: TLabel; }
    DBLookupComboBox1.ClassName; { DBLookupComboBox1: TDBLookupComboBox; }
  end;

end;

end.
