unit UnitSettings;

interface

/// <summary>Save Global Sattings To Registry</summary>
function SaveSattingsToRegistry(): boolean;
/// <summary></summary>
function LoadSattingsFromRegistry(): boolean;
/// <summary>Restore Global Sattings To Defaults</summary>
procedure RestoreSettingsToDefaults();

var
  // Global Settings
  GlobalDefaultFontSize: integer; // DefaultFontSize
  GlobalLogCreate: boolean; // Create a Logging to file
  GlobalMaximizeOnStartup: boolean; // Maximize Application window on Startup
  GlobalModulesCompareLevel2: boolean; // Modules Compare Level 2 enabled (Compare with Package SurName)

implementation

uses
  Registry
    , Winapi.Windows
    , System.SysUtils
    ;

const
  RegGlobalKey = 'SOFTWARE\IDEModuleParser';

  Def_DefaultFontSize = 10; // default value for DefaultFontSize
  Def_LogCreate = true; // default value for LogCreate
  Def_MaximizeOnStartup = false; // default value for MaximizeOnStartup
  Def_ModulesCompareLevel2 = true; // default value for GlobalModulesCompareLevel2

var
  reg: TRegistry;

function LoadIntegerValue(name: string; defValue: integer): integer;
begin
  try
    Result := reg.ReadInteger(name);
  except
    Result := defValue;
  end;
end;

function LoadBooleanValue(name: string; defValue: boolean): boolean;
begin
  try
    Result := reg.ReadBool(name);
  except
    Result := defValue;
  end;
end;

function SaveSattingsToRegistry(): boolean;
begin
  // Save Global Sattings To Registry
  Result := false;
  try
    reg         := TRegistry.Create;
    reg.RootKey := HKEY_CURRENT_USER;
    if reg.OpenKey(RegGlobalKey, true)
    then
    begin
      // Save each global setting
      reg.WriteInteger('DefaultFontSize', GlobalDefaultFontSize);
      reg.WriteBool('LogCreate', GlobalLogCreate);
      reg.WriteBool('MaximizeOnStartup', GlobalMaximizeOnStartup);
      reg.WriteBool('ModulesCompareLevel2', GlobalModulesCompareLevel2);

      reg.CloseKey;
      Result := true;
    end;
  finally
    reg.Free;
  end;
end;

function LoadSattingsFromRegistry(): boolean;
begin
  // Load Global Sattings To Registry
  Result := false;
  try
    reg         := TRegistry.Create;
    reg.RootKey := HKEY_CURRENT_USER;
    if reg.OpenKey(RegGlobalKey, false)
    then
    begin
      // Load each global setting
      GlobalDefaultFontSize := LoadIntegerValue('DefaultFontSize', Def_DefaultFontSize);
      GlobalLogCreate       := LoadBooleanValue('LogCreate', Def_LogCreate);
      GlobalMaximizeOnStartup := LoadBooleanValue('MaximizeOnStartup', Def_MaximizeOnStartup);
      GlobalModulesCompareLevel2 := LoadBooleanValue('ModulesCompareLevel2', Def_ModulesCompareLevel2);

      reg.CloseKey;
      Result := true;
    end
    else
      RestoreSettingsToDefaults();
  finally
    reg.Free;
  end;
end;

procedure RestoreSettingsToDefaults();
begin
  // Restore Global Sattings To Defaults
  GlobalDefaultFontSize := Def_DefaultFontSize;
  GlobalLogCreate       := Def_LogCreate;
  GlobalMaximizeOnStartup := Def_MaximizeOnStartup;
  GlobalModulesCompareLevel2 := Def_ModulesCompareLevel2;
end;

end.
