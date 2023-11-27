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
  GlobalFontSize: integer; // DefaultFontSize
  GlobalLogCreate: boolean; // Create a Logging to file
  GlobalMaximizeOnStartup: boolean; // Maximize Application window on Startup
  GlobalParseOnFileOpen: boolean; // Parse on ModulesList file open
  GlobalAfterParsingView: boolean; // After Parsing View enabled
  GlobalAfterParsingViewOption: integer; // After Parsing View active option
  GlobalVCLStyle: string; // Application VCL Style

  GlobalModulesCompareLevel2: boolean; // Modules Compare Level 2 enabled (Compare with Module Version)
  GlobalModulesCompareLevel3: boolean; // Modules Compare Level 3 enabled (Compare with Module Name RegExp)

  GlobalAdminMode: boolean; // Admin Mode

implementation

uses
  Registry
    , System.SysUtils
    , VCL.Themes, Winapi.ActiveX
    ;

const
  RegGlobalKey = 'SOFTWARE\IDEModuleParser';

  Def_FontSize = 10; // default value for DefaultFontSize
  Def_LogCreate = true; // default value for LogCreate
  Def_MaximizeOnStartup = false; // default value for MaximizeOnStartup
  Def_ParseOnFileOpen = true; // default value for ParseOnFileOpen
  Def_AfterParsingView = true; // default value for AfterParsingView
  Def_AfterParsingViewOption = 0; // default value for AfterParsingViewOption
  Def_ModulesCompareLevel2 = false; // default value for ModulesCompareLevel2
  Def_ModulesCompareLevel3 = true; // default value for ModulesCompareLevel3
  Def_VCLStyle = 'Amethyst Kamri'; // default value (constant) for VCLStyle

var
  reg: TRegistry;

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
      reg.WriteInteger('FontSize', GlobalFontSize);
      reg.WriteInteger('AfterParsingViewOption', GlobalAfterParsingViewOption);
      reg.WriteBool('LogCreate', GlobalLogCreate);
      reg.WriteBool('MaximizeOnStartup', GlobalMaximizeOnStartup);
      reg.WriteBool('ParseOnFileOpen', GlobalParseOnFileOpen);
      reg.WriteBool('AfterParsingView', GlobalAfterParsingView);
      reg.WriteBool('ModulesCompareLevel2', GlobalModulesCompareLevel2);
      reg.WriteBool('ModulesCompareLevel3', GlobalModulesCompareLevel3);
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
      GlobalFontSize := LoadIntegerValue('FontSize', Def_FontSize);
      GlobalAfterParsingViewOption := LoadIntegerValue('AfterParsingViewOption', Def_AfterParsingViewOption);
      GlobalLogCreate       := LoadBooleanValue('LogCreate', Def_LogCreate);
      GlobalMaximizeOnStartup := LoadBooleanValue('MaximizeOnStartup', Def_MaximizeOnStartup);
      GlobalParseOnFileOpen := LoadBooleanValue('ParseOnFileOpen', Def_ParseOnFileOpen);
      GlobalAfterParsingView := LoadBooleanValue('AfterParsingView', Def_AfterParsingView);
      GlobalModulesCompareLevel2 := LoadBooleanValue('ModulesCompareLevel2', Def_ModulesCompareLevel2);
      GlobalModulesCompareLevel3 := LoadBooleanValue('ModulesCompareLevel3', Def_ModulesCompareLevel3);
      GlobalVCLStyle := LoadStringValue('VCLStyle', Def_VCLStyle);
      {$IFDEF DEBUG}
        GlobalAdminMode := true;
      {$ELSE}
        GlobalAdminMode := false;
      {$ENDIF}
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
  GlobalFontSize          := Def_FontSize;
  GlobalLogCreate         := Def_LogCreate;
  GlobalMaximizeOnStartup := Def_MaximizeOnStartup;
  GlobalParseOnFileOpen   := Def_ParseOnFileOpen;
  GlobalAfterParsingView  := Def_AfterParsingView;
  GlobalAfterParsingViewOption := Def_AfterParsingViewOption;
  GlobalModulesCompareLevel2 := Def_ModulesCompareLevel2;
  GlobalModulesCompareLevel3 := Def_ModulesCompareLevel3;
  {
  if Def_VCLStyle_const = TStyleManager.ActiveStyle.Name
    then Def_VCLStyle := Def_VCLStyle_const
    else Def_VCLStyle := TStyleManager.ActiveStyle.Name;
  }
  GlobalVCLStyle := Def_VCLStyle;

  GlobalAdminMode := false;
end;

end.
