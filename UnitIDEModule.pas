unit UnitIDEModule;

interface

uses
  System.RegularExpressionsCore
  , System.DateUtils
  , UnitLogger
  ;


type
  PIDEModule = ^TIDEModule;
  TIDEModule = class(TObject)
  private
    function DateAndTimeStrToDateTime(str : string): TDateTime;
  public
    FileName : string;
    Path : string;
    Version : string;
    DateTime : TDateTime;
    Hash : string;
    constructor Create();
    procedure AssignFromRegExpGroups(regexp : TPerlRegEx);
  end;

implementation

uses
    System.SysUtils
  , UnitMain
  ;

{ TIDEModule }

constructor TIDEModule.Create;
begin
  FileName := '';
  Path := '';
  Version := '';
  DateTime := now();
  Hash := '';
end;


function TIDEModule.DateAndTimeStrToDateTime(str : string): TDateTime;
var
  DateTimeRegexp : TPerlRegEx;
  AYear, AMonth, ADay : word;
  AHour, AMinute, ASecond, AMilliSecond : word;
begin
  //
  // \d{1,2}[\/\-\.]\d{1,2}[\/\-\.]\d{2,4}    // date Groups[4]
  // \d{1,2}:\d{1,2}:\d{1,2}(?:\s*([\S]{2}))?     // time Groups[5]
  //
  DateTimeRegexp := TPerlRegEx.Create;
  try
    with DateTimeRegexp do begin
      RegEx := '(\d{1,4})[\/\-\.](\d{1,2})[\/\-\.](\d{1,4}) (\d{1,2})[\:\.](\d{1,2})[\:\.](\d{1,2})(?:\s*([\S]{2}))?';
      Subject := str;
      if Match
      then
        begin
          AYear := StrToInt(Groups[3]);
          AMonth := StrToInt(Groups[2]);
          ADay := StrToInt(Groups[1]);
          if (ADay > 31) AND (AYear <= 31)
          then
            begin
              var t := AYear;
              AYear := ADay;
              ADay := t;
            end;
          if (AMonth > 12) AND (ADay <= 12)
          then
            begin
              var t := AMonth;
              AMonth := ADay;
              ADay := t;
            end;
          AHour := StrToInt(Groups[4]);
          AMinute := StrToInt(Groups[5]);
          ASecond := StrToInt(Groups[6]);
          if Groups[7] = 'PM' then AHour := AHour + 12;
          if AHour >= 24 then AHour := AHour - 24;
          AMilliSecond := 0;
        end
      else
        begin
          Logger.AddToLog('[Error] Can''t convert string to DateTime: ' + str);
          DecodeDateTime( 0 , AYear, AMonth, ADay, AHour, AMinute, ASecond, AMilliSecond);
          {
          AYear := 0;
          AMonth := 0;
          ADay := 0;
          AHour := 0;
          AMinute := 0;
          ASecond := 0;
          AMilliSecond := 0;
          }
        end;
    end;
  finally
    DateTimeRegexp.Free;
  end;
  Result := EncodeDateTime(AYear, AMonth, ADay, AHour, AMinute, ASecond, AMilliSecond);
end;

procedure TIDEModule.AssignFromRegExpGroups(regexp : TPerlRegEx);
var
  str: string;
begin
  with regexp do
  begin
    FileName := Groups[1];
    Path := Groups[2];
    Version := Groups[3];
    str := Groups[4] + ' ' + Groups[5];
    if TryStrToDateTime(str, DateTime) = false
    then
      DateTime := DateAndTimeStrToDateTime(str);
    Hash := Groups[6];
  end;
end;

end.
