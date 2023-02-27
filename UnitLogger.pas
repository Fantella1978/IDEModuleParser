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
    FLogEnabled: boolean;
    function GetLogMemo: TMemo;
    procedure SetLogMemo(const Value: TMemo);
    procedure AddLineToLogFile(line: string);
    function AddTextToFile(const aFileName, aText: string; AddCRLF: boolean): boolean;
    function GetLogFileName(): string;
    procedure SetLogFileName(const Value: string);
    procedure SetLogEnabled(Value: boolean);
    function GetLogEnabled: boolean;
  public
    property LogMemo: TMemo read GetLogMemo write SetLogMemo;
    property LogFile: string read GetLogFileName write SetLogFileName;
    property LogEnabled: boolean read GetLogEnabled write SetLogEnabled;
    function AddToLog(s: string): boolean;
    procedure Clear; override;
    constructor Create;
  end;

implementation

{ TMyLogger }

function TMyLogger.AddTextToFile(const aFileName, aText: string; AddCRLF: boolean): boolean;
var
  fs: TFileStream;
  preamble: TBytes;
  tempString: RawByteString;
  aMode: Integer;
begin
  Result := true;
  if not FileExists(aFileName)
  then
    aMode := fmCreate
  else
    aMode := fmOpenWrite;
  fs      := TFileStream.Create(aFileName, { mode } aMode, fmShareDenyWrite);
  { sharing mode allows read during our writes }
  try
    { internal Char (UTF16) codepoint, to UTF8 encoding conversion: }
    tempString := Utf8Encode(aText); // this converts UnicodeString to WideString, sadly.
    if aMode = fmCreate
    then
    begin
      preamble := TEncoding.UTF8.GetPreamble;
      try
        fs.WriteBuffer(PAnsiChar(preamble)^, Length(preamble));
      except
        Result := False;
      end;
    end
    else
    begin
      fs.Seek(fs.Size, 0); { go to the end, append }
    end;
    if AddCRLF // Add CRLF line end
    then
      tempString := tempString + AnsiChar(#13) + AnsiChar(#10);
    try
      fs.WriteBuffer(PAnsiChar(tempString)^, Length(tempString));
    except
      Result := False;
    end;
  finally
    fs.Free;
  end;
end;

procedure TMyLogger.AddLineToLogFile(line: string);
begin
  // Add line to log file
  if not AddTextToFile(FLogFileName, line, true)
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
  Result := true;
  if not FLogEnabled then
    Exit;
  dt := Now();
  DateTimeToString(dts, 'dd-mm-yyyy hh:nn:ss', dt);
  LogString := dts + ' - ' + s;

  Add(LogString);
  if FLogFileName <> '' then
    AddLineToLogFile(LogString);
  if FLogMemo <> nil then
    FLogMemo.Lines.Add(LogString);
end;

procedure TMyLogger.Clear;
begin
  inherited;
  if not FLogEnabled then
    Exit;
  if FLogMemo <> nil then
    FLogMemo.Clear;
end;

constructor TMyLogger.Create;
begin
  //
  FLogFileName := '';
  FLogMemo     := nil;
  FLogEnabled  := true;
end;

function TMyLogger.GetLogEnabled: boolean;
begin
  Result := FLogEnabled;
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

procedure TMyLogger.SetLogEnabled(Value: boolean);
begin
  FLogEnabled := Value;
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
