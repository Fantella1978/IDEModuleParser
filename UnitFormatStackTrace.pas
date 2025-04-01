unit UnitFormatStackTrace;

interface

uses
  System.RegularExpressionsCore
  , System.Classes
  , System.StrUtils
  , Vcl.Graphics
  , Vcl.ComCtrls
  ;

type
  TFormattedStackTraceView = class
  private
    { Private declarations }
    FEdit: TRichEdit;
    Fregexp: TPerlRegEx;
    function GetStackTraceLineRegExp: string;
    function FindModuleIn3rdPartyList(Atext: string): boolean;
    function FindModuleInUnknownList(Atext: string): boolean;
  public
    { Public declarations }
    FModules3rdPartyList: TStringList;
    FModulesUnknownList: TStringList;
    constructor Create(AEdit: TRichEdit);
    destructor Destroy; override;
    procedure Clear;
    procedure Activate;
    function AddLine(Atext: string): string;
    procedure AddFormattedText(const AText: string; AStyle: TFontStyles); overload;
    procedure AddFormattedText(const AText: string; AStyle: TFontStyles; AColor: TColor); overload;
  end;

implementation

uses
  UnitMain;

procedure TFormattedStackTraceView.AddFormattedText(const AText: string; AStyle: TFontStyles);
begin
  FEdit.SelStart := FEdit.GetTextLen;
  FEdit.SelLength := 0;
  FEdit.SelAttributes.Style := AStyle;
  FEdit.SelText := AText;
end;

procedure TFormattedStackTraceView.Activate;
begin
  frmMain.pcStackTrace.ActivePage := frmMain.tsStackTraceFormatted;
end;

procedure TFormattedStackTraceView.AddFormattedText(const AText: string; AStyle: TFontStyles;
  AColor: TColor);
begin
  FEdit.SelAttributes.Color := AColor;
  AddFormattedText(AText, AStyle);
end;

function TFormattedStackTraceView.GetStackTraceLineRegExp: string;
begin
  Result := '\[(.*)\]' +                  // Groups[1] - Address
    '\s*' +
    '\{(.*?)\s*\}' +                      // Groups[2] - File name
    '\s*' +
    '(.*)';                               // Groups[3] - Function
end;

procedure TFormattedStackTraceView.Clear;
begin
  FEdit.Clear;
end;

constructor TFormattedStackTraceView.Create(AEdit: TRichEdit);
begin
  FEdit := AEdit;
  Fregexp := TPerlRegEx.Create;
end;

destructor TFormattedStackTraceView.Destroy;
begin
  FModulesUnknownList.Free;
  FModules3rdPartyList.Free;
  Fregexp.Free;
  inherited;
end;

function TFormattedStackTraceView.FindModuleIn3rdPartyList(Atext: string): boolean;
var
  ModuleName: string;
begin
  Result := false;
  if (FModules3rdPartyList = nil) then Exit;
  for ModuleName in FModules3rdPartyList do
    if ModuleName = Atext then Exit(true);
end;

function TFormattedStackTraceView.FindModuleInUnknownList(Atext: string): boolean;
var
  ModuleName: string;
begin
  Result := false;
  if (FModulesUnknownList = nil) then Exit;
  for ModuleName in FModulesUnknownList do
    if ModuleName = Atext then Exit(true);
end;

function TFormattedStackTraceView.AddLine(Atext: string): string;
begin
  with Fregexp do begin
    RegEx := GetStackTraceLineRegExp();
    Subject := Atext;
    if Match
      then
        begin
          // Groups[1]
          AddFormattedText('[' + Groups[1] + ']', [], clBlack);

          // Groups[2]
          AddFormattedText('{', [], clBlack);
          if FindModuleIn3rdPartyList(Groups[2])
            then AddFormattedText(Groups[2], [], clRed)
            else
              if FindModuleInUnknownList(Groups[2])
                then AddFormattedText(Groups[2], [], clFuchsia)
                else AddFormattedText(Groups[2], [], clBlue);
          AddFormattedText('}', [], clBlack);

          // Groups[3]
          var ufs := 'Unknown function';
          var ufp := Pos(ufs, Groups[3], 1);
          if ufp > 0                          // Unknown function check
          then
            begin
              AddFormattedText(' ' + ufs, [], clWebCoral);
              AddFormattedText(Copy(Groups[3], ufp + length(ufs), length(Groups[3]) - length(ufs)) + sLineBreak, [], clGray);
            end
          else
            AddFormattedText(' ' + Groups[3] + sLineBreak, [], clGray);
        end
    else
      AddFormattedText(Atext + sLineBreak, [], clBlack);
  end;
end;

end.
