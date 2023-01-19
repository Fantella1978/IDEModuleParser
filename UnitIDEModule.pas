unit UnitIDEModule;

interface

uses
  System.RegularExpressionsCore;


type
  PIDEModule = ^TIDEModule;
  TIDEModule = class(TObject)
  private
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


procedure TIDEModule.AssignFromRegExpGroups(regexp : TPerlRegEx);
begin
  with regexp do
  begin
    FileName := Groups[1];
    Path := Groups[2];
    Version := Groups[3];
    DateTime := StrToDateTime(Groups[4] + ' ' + Groups[5]);
    Hash := Groups[6];
  end;
end;

end.
