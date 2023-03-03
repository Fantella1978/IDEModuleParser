unit UnitSettings;

interface

uses
  Winapi.Windows;

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
  GlobalParseOnFileOpen: boolean; // Parese on ModulesList file open
  GlobalModulesCompareLevel2: boolean; // Modules Compare Level 2 enabled (Compare with Package SurName)
  GlobalVCLStyle: string; // Application VCL Style

  GlobalAdminMode: boolean; // Admin Mode

implementation

uses
  Registry
    , System.SysUtils
    , VCL.Themes, Winapi.ActiveX
    ;

const
  RegGlobalKey = 'SOFTWARE\IDEModuleParser';

  Def_DefaultFontSize = 10; // default value for DefaultFontSize
  Def_LogCreate = true; // default value for LogCreate
  Def_MaximizeOnStartup = false; // default value for MaximizeOnStartup
  Def_ParseOnFileOpen = true; // default value for ParseOnFileOpen
  Def_ModulesCompareLevel2 = true; // default value for ModulesCompareLevel2
  Def_VCLStyle_const = 'Amethyst Kamri'; // default value (constant) for VCLStyle

var
  reg: TRegistry;
  Def_VCLStyle : string; // default value for VCLStyle

function LoadIntegerValue(name: string; defValue: integer): integer;
begin
  try
    if reg.ValueExists(name)
      then Result := reg.ReadInteger(name)
      else Result := defValue;
  except
    Result := defValue;
  end;
end;

function LoadBooleanValue(name: string; defValue: boolean): boolean;
begin
  try
    if reg.ValueExists(name)
      then Result := reg.ReadBool(name)
      else Result := defValue;
  except
    Result := defValue;
  end;
end;

function LoadStringValue(name: string; defValue: string): string;
begin
  try
    if reg.ValueExists(name)
      then Result := reg.ReadString(name)
      else Result := defValue;
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
      reg.WriteBool('ParseOnFileOpen', GlobalParseOnFileOpen);
      reg.WriteBool('ModulesCompareLevel2', GlobalModulesCompareLevel2);
      reg.WriteString('VCLStyle', GlobalVCLStyle);

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
      GlobalParseOnFileOpen := LoadBooleanValue('ParseOnFileOpen', Def_ParseOnFileOpen);
      GlobalModulesCompareLevel2 := LoadBooleanValue('ModulesCompareLevel2', Def_ModulesCompareLevel2);
      if Def_VCLStyle_const = TStyleManager.ActiveStyle.Name
        then Def_VCLStyle := Def_VCLStyle_const
        else Def_VCLStyle := TStyleManager.ActiveStyle.Name;
      GlobalVCLStyle := LoadStringValue('VCLStyle', Def_VCLStyle);

      GlobalAdminMode := false;
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
  GlobalParseOnFileOpen := Def_ParseOnFileOpen;
  GlobalModulesCompareLevel2 := Def_ModulesCompareLevel2;
  if Def_VCLStyle_const = TStyleManager.ActiveStyle.Name
    then Def_VCLStyle := Def_VCLStyle_const
    else Def_VCLStyle := TStyleManager.ActiveStyle.Name;
  if Def_VCLStyle_const = Def_VCLStyle
    then GlobalVCLStyle := Def_VCLStyle_const
    else GlobalVCLStyle := Def_VCLStyle;

  GlobalAdminMode := false;
end;

end.
