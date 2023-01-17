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
    fs: TFileStream;
    preamble:TBytes;
    tempString: RawByteString;
    amode: Integer;
begin
  Result := False;
  if not FileExists(aFileName)
    then amode := fmCreate
    else amode := fmOpenReadWrite;
  fs := TFileStream.Create(aFileName, { mode } amode, fmShareDenyWrite);
  { sharing mode allows read during our writes }
  try

    {internal Char (UTF16) codepoint, to UTF8 encoding conversion:}
    tempString := Utf8Encode(aText); // this converts UnicodeString to WideString, sadly.

    if amode = fmCreate
    then
      begin
        preamble := TEncoding.UTF8.GetPreamble;
        fs.WriteBuffer( PAnsiChar(preamble)^, Length(preamble));
      end
    else
      begin
        fs.Seek(fs.Size, 0); { go to the end, append }
      end;

    if AddCRLF // Add CRLF line end
      then tempString := tempString + AnsiChar(#13) + AnsiChar(#10);

    fs.WriteBuffer(PAnsiChar(tempString)^, Length(tempString));
  finally
    fs.Free;
  end;
  Result := true;

{
var
  FileHandle: Integer;
  iFileLength: Integer;
  tempString: string;
begin
  Result := False;
  if FileExists(aFileName)
    then FileHandle := FileOpen(aFileName, fmOpenWrite + fmShareDenyNone)
    else FileHandle := FileCreate(aFileName);
  if FileHandle > 0 then
    try
      iFileLength := FileSeek(FileHandle, 0, 2);
      if AddCRLF then tempString := aText + #13#10
                 else tempString := aText;
      FileWrite(FileHandle, tempString, Length(tempString));
    finally
      FileClose(FileHandle);
    end;
    }
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
  if FLogMemo <> nil then FLogMemo.Lines.Add(LogString);
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
