unit UnitStaticFunctions;

interface

uses
    Vcl.DBGrids
  , System.Types
  , System.IOUtils
  , System.StrUtils
  , System.Masks
  ;

type
  TDBGridColumnsWidthArray = array of integer;

  function GetFileVersionStr(const AFileName: string): string;
  function AutoCalcDBGridColumnsWidth(Grid: TDBGrid; Column: TColumn;
   var WidthArray: TDBGridColumnsWidthArray) : boolean;
  procedure AutoStretchDBGridColumns(Grid: TDBGrid; MinWidths: Array of integer);
  function GetFilesByMask(const Path, Masks: string): TStringDynArray;

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

end.
