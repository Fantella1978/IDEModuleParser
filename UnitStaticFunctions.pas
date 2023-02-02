unit UnitStaticFunctions;

interface

function GetFileVersionStr(const AFileName: string): string;

implementation

uses
  Winapi.Windows
  , System.SysUtils
  ;

function GetFileVersionStr(const AFileName: string): string;
var
  FileName: string;
  LinfoSize: DWORD;
  lpdwHandle: DWORD;
  lpData: Pointer;
  lplpBuffer: PVSFixedFileInfo;
  puLen: DWORD;
begin
  Result := '';
  FileName := AFileName;
  UniqueString(FileName);
  LinfoSize := GetFileVersionInfoSize(PChar(FileName), lpdwHandle);
  if LinfoSize <> 0 then
  begin
    GetMem(lpData, LinfoSize);
    try
      if GetFileVersionInfo(PChar(FileName), lpdwHandle, LinfoSize, lpData) then
        if VerQueryValue(lpData, '\', Pointer(lplpBuffer), puLen) then
          Result := Format('%d.%d.%d.%d', [
            HiWord(lplpBuffer.dwFileVersionMS),
            LoWord(lplpBuffer.dwFileVersionMS),
            HiWord(lplpBuffer.dwFileVersionLS),
            LoWord(lplpBuffer.dwFileVersionLS)]);
    finally
      FreeMem(lpData);
    end;
  end;

end;

end.
