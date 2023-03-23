unit UnitStaticFunctions;

interface

uses
  Vcl.DBGrids;

type
  TDBGridColumnsWidthArray = array of integer;

  function GetFileVersionStr(const AFileName: string): string;
  function AutoCalcDBGridColumnsWidth(DBGrid: TDBGrid; Column: TColumn;
     var WidthArray: TDBGridColumnsWidthArray) : boolean;
  procedure AutoStretchDBGridColumns(Grid: TDBGrid; MinWidths: Array of integer);

implementation

uses
  Winapi.Windows
  , System.SysUtils
  , System.Math
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

function AutoCalcDBGridColumnsWidth(DBGrid: TDBGrid; Column: TColumn;
   var WidthArray: TDBGridColumnsWidthArray) : boolean;
Var
  TextWidth, sw, i : Integer;
  DBGridColumnsWidthArray : TDBGridColumnsWidthArray;
begin
  // DBGridColumnsWidthArray := [];
  // SetLength(DBGridColumnsWidthArray, DBGrid.Columns.Count);
  TextWidth := 10 + DBGrid.Canvas.TextExtent(Column.Field.DisplayText).cx;
  if TextWidth > Column.Width
  then
    begin
      sw := 0;
      for i := 0 to DBGrid.Columns.Count - 1 do
        if DBGrid.Columns[i].Visible AND (DBGrid.Columns[i].FieldName <> Column.FieldName)
          then sw := sw + DBGrid.Columns[i].Width;
      for i := 0 to DBGrid.Columns.Count - 1 do
        if DBGrid.Columns[i].FieldName = Column.FieldName
          then WidthArray[i] := TextWidth;
    end;
  Result := true;
end;

procedure AutoStretchDBGridColumns(Grid: TDBGrid; MinWidths: Array of integer);
var
  x, i, ww: integer;
  ColumnsCount : integer;
begin
  // Stretches TDBGrid columns
  // Columns contains columns to stretch
  // MinWidths contains columns minimum widhts
  ColumnsCount := Grid.Columns.Count;
  // Assert(ColumnsCount = Length(MinWidths), 'ColumnsCount <> Length(MinWidths)');
  ww := 0;
  for i := 0 to Grid.Columns.Count - 1 do
  begin
    if Grid.Columns[i].Visible then
      ww := ww + Grid.Columns[i].Width + 1;
  end;
  if dgIndicator in Grid.Options then
    ww := ww + IndicatorWidth;
  x := (Grid.ClientWidth - ww) div ColumnsCount;
  // x := 0;
  for i := 0 to  ColumnsCount - 1 do
    Grid.Columns[i].Width := Max(Grid.Columns[i].Width + x, MinWidths[i]);
end;

end.
