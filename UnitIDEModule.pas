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
    isVIList : boolean;
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
  isVIList := false;
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
  timeStr: string;
  temp : TDateTime;
  NYear, NMonth, NDay : word;
begin
  //
  // (\d{1,4})[\/\-\.](?:\d{1,2}|[A-Z,a-z]{3})[\/\-\.](\d{1,4})   // Groups[4] - date
  // (\d{1,2})[\:\.](\d{1,2})[\:\.](\d{1,2})(?:\s*([\S]{2}))?     // Groups[5] - time
  //
  // (\d{1,4}[\/\-\.](?:\d{1,2}|[A-Z,a-z]{3})[\/\-\.]\d{1,4})[\.]?\s*          // Groups[4] - date
  // ((?:\s*[\S]{2}\s*)?\d{1,2}[\:\.]\d{1,2}[\:\.]\d{1,2}(?:\s*[\S]{2})?|)\t   // Groups[5] - time

  if TryStrToDateTime(str, Result)
    then DecodeDateTime( Result , AYear, AMonth, ADay, AHour, AMinute, ASecond, AMilliSecond)
    else
      begin
        DateTimeRegexp := TPerlRegEx.Create;
        try
          with DateTimeRegexp do begin
            RegEx := '(\d{1,4})[\/\-\.](\d{1,2}|[A-Z,a-z]{3})[\/\-\.](\d{1,4})\s*' +         // date
              '' +
              '(' +                                                                             // time
                '(?:\s*[\S]{2}\s*)?' +
                '(?:' +
                '\d{1,2}[\:\.]\d{2}[\:\.]\d{2}' +
                '|' +
                '\d{1,2}[\:\.]\d{2}' +
                ')' +
                '(?:\s{1}\S{2})?' +
              ')';
            Subject := str;
            if Match
            then
              begin
                if (StrToInt(Groups[1]) > 31) AND (StrToInt(Groups[3]) <= 99)
                  then
                    begin
                      ADay := StrToInt(Groups[3]);
                      AYear := StrToInt(Groups[1]);
                    end
                  else
                    begin
                      ADay := StrToInt(Groups[1]);
                      AYear := StrToInt(Groups[3]);
                    end;
                if (ADay > 31) AND (AYear <= 31)
                then
                  begin
                    var t := AYear;
                    AYear := ADay;
                    ADay := t;
                  end;
                if AYear < 100 then AYear := 2000 + AYear;
                if Length(Groups[2]) = 3
                  then
                    begin
                      var tempG2 := lowercase(Groups[2]);
                      AMonth := 1;
                      if tempG2 = 'jan' then else
                      if tempG2 = 'feb' then AMonth := 2 else
                      if tempG2 = 'mar' then AMonth := 3 else
                      if tempG2 = 'apr' then AMonth := 4 else
                      if tempG2 = 'may' then AMonth := 5 else
                      if tempG2 = 'jun' then AMonth := 6 else
                      if tempG2 = 'jul' then AMonth := 7 else
                      if tempG2 = 'aug' then AMonth := 8 else
                      if tempG2 = 'sep' then AMonth := 9 else
                      if tempG2 = 'oct' then AMonth := 10 else
                      if tempG2 = 'nov' then AMonth := 11 else
                      if tempG2 = 'dec' then AMonth := 12;
                    end
                  else AMonth := StrToInt(Groups[2]);
                if (AMonth > 12) AND (ADay <= 12)
                then
                  begin
                    var t := AMonth;
                    AMonth := ADay;
                    ADay := t;
                  end;

                timeStr := Groups[4];
                if TryStrToTime(timeStr, temp)
                  then DecodeDateTime( temp , NYear, NMonth, NDay, AHour, AMinute, ASecond, AMilliSecond)
                  else
                    begin
                      {

                      AHour := StrToInt(Groups[4]);
                      AMinute := StrToInt(Groups[5]);
                      ASecond := StrToInt(Groups[6]);
                      if (Groups[7] = 'PM') AND (AHour < 12)
                        then AHour := AHour + 12;
                      //
                      if AHour >= 24 then AHour := AHour - 24;
                      //

                      }
                      AHour := 0;
                      AMinute := 0;
                      ASecond := 0;
                      AMilliSecond := 0;
                      Logger.AddToLog('[Error] Can''t convert string to Time: ' + timeStr);
                    end;
              end
            else
              begin
                Logger.AddToLog('[Error] Can''t convert string to DateTime: ' + str);
                DecodeDateTime( 0 , AYear, AMonth, ADay, AHour, AMinute, ASecond, AMilliSecond);
              end;
          end;
        finally
          DateTimeRegexp.Free;
        end;
      end;
  Result := EncodeDateTime(AYear, AMonth, ADay, AHour, AMinute, ASecond, AMilliSecond);
end;

procedure TIDEModule.AssignFromRegExpGroups(regexp : TPerlRegEx);
begin
  with regexp do
  begin
    case isVIList of
      false:
        begin
          FileName := Groups[1];
          Path := Groups[2];
          Version := Groups[3];
          DateTime := DateAndTimeStrToDateTime(Groups[4]);
          Hash := Groups[5];
        end;
      true:
        begin
          FileName := Groups[1];
          Version := Groups[2];
          Path := Groups[3];
        end;
    end;
  end;
end;

end.
