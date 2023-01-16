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
  public
    property LogMemo : TMemo read GetLogMemo write SetLogMemo;
    // property FileName : string read FLogFileName write FLogFileName;
    function AddToLog(s: string): boolean;
    procedure SetLogFileName(const Value: string);
    constructor Create;
  end;

implementation

{ TMyLogger }

function TMyLogger.AddToLog(s: string): boolean;
var
  dt: TDateTime;
  dts: string;
begin
  // Add line to log
  dt := Now();
  DateTimeToString(dts, 'dd-mm-yyyy hh:nn:ss',dt);
  Add(dts + ' - ' + s);
  if FLogMemo <> nil then FLogMemo.Lines := (Self as TStringList);
end;

constructor TMyLogger.Create;
begin
  //
  FLogFileName := '';
  FLogMemo := nil;
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
