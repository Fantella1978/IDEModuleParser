unit UnitStaticFunctions;

interface

uses
    Vcl.DBGrids
  , Vcl.Forms
  , System.Types
  , System.IOUtils
  , System.StrUtils
  , System.Masks
  , Vcl.Controls
  , Vcl.ComCtrls
  , Clipbrd
  , Winapi.Messages
  ;

type

  IDEbittness = (ibUnknown, ib32bit, ib64bit);

  TDBGridColumnsWidthArray = array of integer;

  function GetFileVersionStr(const AFileName: string): string;
  function AutoCalcDBGridColumnsWidth(Grid: TDBGrid; Column: TColumn;
   var WidthArray: TDBGridColumnsWidthArray) : boolean;
  procedure AutoStretchDBGridColumns(Grid: TDBGrid; MinWidths: Array of integer);
  function GetFilesByMask(const Path, Masks: string): TStringDynArray;
  procedure RichEditPopupMenu(re: TRichEdit);

implementation

uses
  Winapi.Windows
  , System.SysUtils
  , System.Math
  , System.Classes
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

/// <summary>Get all files by Mask</summary>
function GetFilesByMask(const Path, Masks: string): TStringDynArray;
var
  MaskArray: TStringDynArray;
  Predicate: TDirectory.TFilterPredicate;
begin
  MaskArray := SplitString(Masks, ';');
  Predicate :=
    function(const Path: string; const SearchRec: TSearchRec): Boolean
    var
      Mask: string;
    begin
      for Mask in MaskArray do
        if MatchesMask(SearchRec.Name, Mask) then
          exit(True);
      exit(False);
    end;
  Result := TDirectory.GetFiles(Path, Predicate);
end;

function AutoCalcDBGridColumnsWidth(Grid: TDBGrid; Column: TColumn;
   var WidthArray: TDBGridColumnsWidthArray) : boolean;
{
Var
  i, TextWidth, AllColumnsWidth : Integer;
}
begin
  {
  if length(WidthArray) <> Grid.Columns.Count then Exit;
  TextWidth := 5 + Grid.Canvas.TextExtent(Column.Field.DisplayText).cx;
  if TextWidth > Column.Width
  then
    begin
      AllColumnsWidth := 0;
      for i := 0 to Grid.Columns.Count - 1 do
        if Grid.Columns[i].Visible
          then inc(AllColumnsWidth, Grid.Columns[i].Width + 1);
      if dgIndicator in Grid.Options
        then inc(AllColumnsWidth, IndicatorWidth);
      for i := 0 to Grid.Columns.Count - 1 do
        if (Grid.Columns[i].FieldName = Column.FieldName) AND Grid.Columns[i].Visible
          then WidthArray[i] := Max(TextWidth, WidthArray[i]);
    end;
  }
  Result := true;
end;

procedure AutoStretchDBGridColumns(Grid: TDBGrid; MinWidths: Array of integer);
var
  i, delta, AllColumnsWidth: integer;
  VisibleColumnsCount : integer;
begin
  // Stretches TDBGrid columns
  // Columns contains columns to stretch
  // MinWidths contains columns minimum widhts
  // Assert(ColumnsCount = Length(MinWidths), 'ColumnsCount <> Length(MinWidths)');
  VisibleColumnsCount := 0;
  AllColumnsWidth := 0;
  for i := 0 to Grid.Columns.Count - 1 do
  begin
    if Grid.Columns[i].Visible
    then
      begin
        inc(VisibleColumnsCount);
        inc(AllColumnsWidth, Grid.Columns[i].Width + 1);
      end;
  end;
  if length(MinWidths) <> Grid.Columns.Count then Exit;
  if dgIndicator in Grid.Options
    then inc(AllColumnsWidth, IndicatorWidth);
  delta := (Grid.ClientWidth - AllColumnsWidth) div VisibleColumnsCount;
  for i := 0 to Grid.Columns.Count - 1 do
    if Grid.Columns[i].Visible
      then Grid.Columns[i].Width := Max(Grid.Columns[i].Width + delta, MinWidths[i]);
end;

procedure RichEditPopupMenu(re: TRichEdit);
const
  IDM_UNDO   = WM_UNDO;
  IDM_CUT    = WM_CUT;
  IDM_COPY   = WM_COPY;
  IDM_PASTE  = WM_PASTE;
  IDM_DELETE = WM_CLEAR;
  IDM_SELALL = EM_SETSEL;
  IDM_RTL    = $8000; // WM_APP ?

  Enables: array[Boolean] of DWORD = (MF_DISABLED or MF_GRAYED, MF_ENABLED);
  Checks: array[Boolean] of DWORD = (MF_UNCHECKED, MF_CHECKED);
var
  hUser32: HMODULE;
  hmnu, hmenuTrackPopup: HMENU;
  Cmd: DWORD;
  Flags: Cardinal;
  HasSelText: Boolean;
  FormHandle: HWND;
  // IsRTL: Boolean;
begin
  hUser32 := LoadLibraryEx(user32, 0, LOAD_LIBRARY_AS_DATAFILE);
  if (hUser32 <> 0) then
  try
    hmnu := LoadMenu(hUser32, MAKEINTRESOURCE(1));
    if (hmnu <> 0) then
    try
      hmenuTrackPopup := GetSubMenu(hmnu, 0);

      HasSelText := Length(re.SelText) <> 0;
      EnableMenuItem(hmnu, IDM_UNDO,   Enables[re.CanUndo]);
      EnableMenuItem(hmnu, IDM_CUT,    Enables[HasSelText]);
      EnableMenuItem(hmnu, IDM_COPY,   Enables[HasSelText]);
      EnableMenuItem(hmnu, IDM_PASTE,  Enables[Clipboard.HasFormat(CF_TEXT)]);
      EnableMenuItem(hmnu, IDM_DELETE, Enables[HasSelText]);
      EnableMenuItem(hmnu, IDM_SELALL, Enables[Length(re.Text) <> 0]);

      // IsRTL := GetWindowLong(re.Handle, GWL_EXSTYLE) and WS_EX_RTLREADING <> 0;
      // EnableMenuItem(hmnu, IDM_RTL, Enables[True]);
      // CheckMenuItem(hmnu, IDM_RTL, Checks[IsRTL]);

      FormHandle := GetParentForm(re).Handle;
      Flags := TPM_LEFTALIGN or TPM_RIGHTBUTTON or TPM_NONOTIFY or TPM_RETURNCMD;
      Cmd := DWORD(TrackPopupMenu(hmenuTrackPopup, Flags,
        Mouse.CursorPos.X, Mouse.CursorPos.Y, 0, FormHandle, nil));
      if Cmd <> 0 then
      begin
        case Cmd of
          IDM_UNDO:   re.Undo;
          IDM_CUT:    re.CutToClipboard;
          IDM_COPY:   re.CopyToClipboard;
          IDM_PASTE:  re.PasteFromClipboard;
          IDM_DELETE: re.ClearSelection;
          IDM_SELALL: re.SelectAll;
          IDM_RTL:; // ?
        end;
      end;
    finally
      DestroyMenu(hmnu);
    end;
  finally
    FreeLibrary(hUser32);
  end;
end;


end.
