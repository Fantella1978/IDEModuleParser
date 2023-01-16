unit UnitLogger;

interface

uses
  System.Classes
  , System.SysUtils
  , Vcl.StdCtrls
  ;

type
  TMyLogger = class(TStringList)
  private
    FLogMemo: TMemo;
    FLogFileName: string;
    function GetLogMemo: TMemo;
    procedure SetLogMemo(const Value: TMemo);
    procedure AddLineToLogFile(s: string);
    function AddTextToFile(const aFileName, aText: string; AddCRLF: Boolean): Boolean;
    function GetLogFileName(): string;
    procedure SetLogFileName(const Value: string);
  public
    property LogMemo : TMemo read GetLogMemo write SetLogMemo;
    property LogFile : string read GetLogFileName write SetLogFileName;
    function AddToLog(s: string): boolean;
    constructor Create;
  end;

implementation

{ TMyLogger }

function TMyLogger.AddTextToFile(const aFileName, aText: string; AddCRLF: Boolean): Boolean;
var
  lF: Integer;
  lS: string;
begin
  Result := False;
  if FileExists(aFileName) then lF := FileOpen(aFileName, fmOpenWrite + fmShareDenyNone)
                           else lF := FileCreate(aFileName);
  if (lF = 0) then
    try
      FileSeek(lF, 0, 2);
      if AddCRLF then lS := aText + #13#10
                 else lS := aText;
      FileWrite(lF, lS[1], Length(lS));
    finally
      FileClose(lF);
    end;
end;

procedure TMyLogger.AddLineToLogFile(s: string);
begin
  // Add line to log file
  if not AddTextToFile(FLogFileName, s, true)
  then
    begin
      FLogFileName := '';
    end;
end;

function TMyLogger.AddToLog(s: string): boolean;
var
  dt: TDateTime;
  dts: string;
  LogString: string;
begin
  // Add line to log
  dt := Now();
  DateTimeToString(dts, 'dd-mm-yyyy hh:nn:ss', dt);
  LogString := dts + ' - ' + s;
  Add(LogString);
  if FLogFileName <> '' then AddLineToLogFile(LogString);
  if FLogMemo <> nil then FLogMemo.Lines := (Self as TStringList);
end;

constructor TMyLogger.Create;
begin
  //
  FLogFileName := '';
  FLogMemo := nil;
end;

function TMyLogger.GetLogFileName: string;
begin
  //
  Result := FLogFileName;
end;

function TMyLogger.GetLogMemo: TMemo;
begin
  //
  Result := FLogMemo;
end;

procedure TMyLogger.SetLogFileName(const Value: string);
begin
  //
  FLogFileName := Value;
end;

procedure TMyLogger.SetLogMemo(const Value: TMemo);
begin
  //
  FLogMemo := Value;
end;

end.
