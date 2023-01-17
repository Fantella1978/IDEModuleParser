unit UnitParser;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls
  , System.RegularExpressionsCore
  ;

type
  TfrmParse = class(TForm)
    Panel1: TPanel;
    pBarOverall: TProgressBar;
    btnStop: TButton;
    lblOverall: TLabel;
    pBarCurrentTask: TProgressBar;
    lblCurrentTask: TLabel;
    procedure ParseModuleListFile();
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    function parseTaskModuleFileParse(): boolean;
    function GetModuleLineRegExp(): string;
  private
    { Private declarations }
    function GetOverallTaskPosition(): Integer;
  public
    { Public declarations }
    parseCanceled: boolean;
    parseSuccess: boolean;
    Tasks: Integer;
    currentTask: Integer;
  end;

var
  frmParse: TfrmParse;
  regexp : TPerlRegEx;

implementation

{$R *.dfm}

uses
  UnitMain;

{ TfrmParse }

procedure TfrmParse.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if parseCanceled OR parseSuccess
  then
    begin
      CanClose := true;
      Exit;
    end
  else
    begin
      frmMain.actParseCancelExecute(Sender);
      if parseCanceled
        then CanClose := true
        else CanClose := false;
    end;
end;

procedure TfrmParse.FormShow(Sender: TObject);
begin
  pBarCurrentTask.Position := 0;
  pBarOverall.Position := 0;
  if Tasks < 1 then Tasks := 1;
  if currentTask < 1 then Tasks := 1;
end;

function TfrmParse.GetModuleLineRegExp: string;
begin

  // (.*)\t\(\d{1}x[0-9A-F]{8}\)\t([^\t]*)\t(?:(\d{1,6}\.\d{1,6}\.\d{1,6}\.\d{1,6})\t)?(\d{1,2}[\/\-\.]\d{1,2}[\/\-\.]\d{2,4})\s*(\d{1,2}:\d{1,2}:\d{1,2}(?:\s*[AP]M)?)\t([\dA-F]{40})

  Result := '(.*)\t' +                                // file name
    '\(\d{1}x[0-9A-F]{8}\)\t' +                       //
    '([^\t]*)\t' +                                    // path
    '(?:(\d{1,6}\.\d{1,6}\.\d{1,6}\.\d{1,6})\t)?' +   // version
    '(\d{1,2}[\/\-\.]\d{1,2}[\/\-\.]\d{2,4})\s*' +    // date
    '(\d{1,2}:\d{1,2}:\d{1,2}(?:\s*[AP]M)?)\t' +      // time
    '([\dA-F]{40})';                                  // hash

end;

function TfrmParse.GetOverallTaskPosition: Integer;
begin
  //
  Result := Round(100 / Tasks) * (currentTask - 1) +
          Round(100 / Tasks * pBarCurrentTask.Position / pBarCurrentTask.Max) ;
end;

procedure TfrmParse.ParseModuleListFile;
begin
  //
  frmMain.actParseCancel.Enabled := true;
  parseCanceled := not frmMain.actParseCancel.Enabled;

  pBarOverall.Max := 100;
  pBarOverall.Position := 0;
  Tasks := 2;
  currentTask := 1;
  parseTaskModuleFileParse();

  frmMain.actParseCancel.Enabled := false;
  parseSuccess := true;
  frmParse.Close;
end;

function TfrmParse.parseTaskModuleFileParse: boolean;
var
  i: Integer;
  cl : Integer;
  err : Integer;
  s: string;
begin
  Logger.AddToLog('Module file parsing started.');
  Result := false;
  err := 0;
  cl := frmMain.MemoTxtModuleFile.Lines.Count;
  pBarCurrentTask.Position := 0;
  pBarCurrentTask.Max := cl;
  if regexp = nil
    then regexp := TPerlRegEx.Create;

  with regexp do begin
    RegEx := GetModuleLineRegExp();
    for i := 0 to cl - 1 do
      begin
        pBarCurrentTask.Position := i;
        pBarOverall.Position := GetOverallTaskPosition();
        Application.ProcessMessages;
        Subject := frmMain.MemoTxtModuleFile.Lines[i];
        if Match
        then
          begin
            {
            for k := 0 to GroupCount do
              begin
                // Groups
              end;
              Groups[1] - file name
              Groups[2] -
              Groups[3] - path
              Groups[4] - version
              Groups[5] - date
              Groups[6] - time
              Groups[7] - hash
            }
            Logger.AddToLog('Parse line #' + IntToStr(i) + '. Found module: ' + Groups[1] );
          end
        else
          begin
            inc(err);
            Logger.AddToLog('Parse line #' + IntToStr(i) + '. Module not found in line: ' + Subject );
          end;

        if parseCanceled
        then
          begin
            Logger.AddToLog('Module file parsing canceled at line #' + IntToStr(i));
            Break;
          end;
        // sleep(1); // Sleep
      end;
  end;
  if err = 0
  then Logger.AddToLog('Module file parsing success.')
  else
    begin
      s := 'Module file parsing success. Can''t parse ' + IntToStr(err) + ' line';
      if err > 1 then s := s + 's';
      s := s + '.';
      Logger.AddToLog(s);
      ShowMessage(s);
    end;
end;

end.
