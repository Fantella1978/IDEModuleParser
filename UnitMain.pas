unit UnitMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList,
  Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ExtDlgs, Vcl.Buttons
  , System.ImageList
  , Vcl.ImgList
  , System.IOUtils
  , Vcl.Mask
  , Winapi.ShellAPI
  ;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Panel1: TPanel;
    ActionList1: TActionList;
    actExit: TAction;
    actOpenModuleFile: TAction;
    OpenTextFileDialog1: TOpenTextFileDialog;
    Button3: TButton;
    actParseModuleFile: TAction;
    Button4: TButton;
    actOpenReportZipFile: TAction;
    LabeledEdit1: TLabeledEdit;
    Panel2: TPanel;
    MemoTxtModuleFile: TMemo;
    Panel3: TPanel;
    PageControl1: TPageControl;
    TabModuleListFile: TTabSheet;
    TabModulesList: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    tbFontSize: TTrackBar;
    lblFontSize: TLabel;
    edtFontSize: TEdit;
    LabeledEdit2: TLabeledEdit;
    ledtBDSBuild: TLabeledEdit;
    ledtBDSPath: TLabeledEdit;
    ledtBDSInstDate: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    /// <summary>Exit from application</summary>
    procedure actExitExecute(Sender: TObject);
    /// <summary>Open Module text file (ModuleList.txt)</summary>
    procedure actOpenModuleFileExecute(Sender: TObject);
    /// <summary>Open Repot Zip file (QPInfo-XXXXXXXX-XXXX.zip)</summary>
    procedure actOpenReportZipFileExecute(Sender: TObject);
    /// <summary>Parse Module file</summary>
    procedure actParseModuleFileExecute(Sender: TObject);
    /// <summary>Module file changed, update display FileName</summary>
    procedure UpdateDisplayFileName();
    /// <summary>Load new Text Module file</summary>
    procedure LoadTxtModuleFile();
    procedure tbFontSizeChange(Sender: TObject);
    /// <summary>Enable Font Size Change</summary>
    procedure EnableFontSizeChange();
    /// <summary>Disable Font Size Change</summary>
    procedure DisableFontSizeChange();
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    procedure WMDropFiles(var Msg: TWMDropFiles); message WM_DROPFILES;

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

  mtfFileName : TFileName;  // ModuleList.txt filename
  mzfFileName : TFileName;  // QPInfo-XXXXXXXX-XXXX.zip filename

implementation

{$R *.dfm}

procedure TForm1.actExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TForm1.actOpenModuleFileExecute(Sender: TObject);
begin
  // Open Module file (ModuleList.txt)
  if (MemoTxtModuleFile.Lines.Text <> '') AND
    (MessageDlg('ModuleFile is opened. Open another file?', TMsgDlgType.mtConfirmation, mbYesNo, 0) = mrNo)
    then Exit;

  if OpenTextFileDialog1.InitialDir = '' then
    OpenTextFileDialog1.InitialDir := TPath.GetDirectoryName(Application.ExeName);

  if OpenTextFileDialog1.Execute then
    mtfFileName := OpenTextFileDialog1.FileName;

  UpdateDisplayFileName();

  LoadTxtModuleFile();

end;

procedure TForm1.actOpenReportZipFileExecute(Sender: TObject);
begin
  // Open Repot Zip file (QPInfo-XXXXXXXX-XXXX.zip)

end;

procedure TForm1.actParseModuleFileExecute(Sender: TObject);
begin
  // Parse Module file

  ledtBDSPath.Text := '';
  ledtBDSBuild.Text := '';
  ledtBDSInstDate.Text := '';

  TabModulesList.TabVisible := true;
end;

procedure TForm1.DisableFontSizeChange;
begin
  // Disable Font Size Change
  lblFontSize.Enabled := false;
  tbFontSize.Enabled := false;
  edtFontSize.Enabled := false;
end;

procedure TForm1.EnableFontSizeChange;
begin
  // Enable Font Size Change
  lblFontSize.Enabled := true;
  tbFontSize.Enabled := true;
  edtFontSize.Enabled := true;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // Close the Application
  DragAcceptFiles(Self.Handle, False);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  //
  // ImageList1.GetBitmap(0, Image1.Picture.Bitmap);
  MemoTxtModuleFile.Clear;

  TabModulesList.TabVisible := false;
  TabSheet3.TabVisible := false;
  TabSheet4.TabVisible := false;

  // Disable Font Size Change
  EnableFontSizeChange();

  DragAcceptFiles(Self.Handle, True);
end;

procedure TForm1.LoadTxtModuleFile;
begin
  // Load new Text Module file
  MemoTxtModuleFile.Lines.LoadFromFile(mtfFileName);
  // Enable Parse Action
  actParseModuleFile.Enabled := true;
  // Enable Font Size Change
  EnableFontSizeChange();

end;

procedure TForm1.tbFontSizeChange(Sender: TObject);
begin
  // Change Font Size
  edtFontSize.Text := IntToStr(tbFontSize.Position);
  MemoTxtModuleFile.Font.Size := tbFontSize.Position;
end;

procedure TForm1.UpdateDisplayFileName;
begin
  //
  LabeledEdit1.Text := mtfFileName;

end;

procedure TForm1.WMDropFiles(var Msg: TWMDropFiles);
var
  DropH: HDROP;
  DroppedFileCount : integer;
  FileNameLength: Integer;
  FileName: string;
  Parse: boolean;
begin
  DroppedFileCount := -1;
  // Parse := false;
  DropH := Msg.Drop;
  try
    DroppedFileCount  := DragQueryFile(DropH, $FFFFFFFF, nil, 0);
    if DroppedFileCount = 1 then begin
      Application.BringToFront;
      FileNameLength := DragQueryFile(DropH, 0, nil , 0);
      SetLength(FileName, FileNameLength);
      DragQueryFile(DropH, 0, PChar(FileName), FileNameLength + 1);
      // Parse := True;
      ShowMessage(FileName);
    end
    else
      ShowMessage('Please drag and drop only one TXT or ZIP file.')
  finally
    DragFinish(DropH);
  end;
  Msg.Result := 0;

  {
  if parse then
  begin
    btnLogFile.Text := FileName;
    btnParse.Click;
  end;
  }
end;

end.
