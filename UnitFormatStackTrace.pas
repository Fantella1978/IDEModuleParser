unit UnitFormatStackTrace;

interface

uses
  System.RegularExpressionsCore
  , System.Classes
  , System.StrUtils
  , System.SysUtils
  , Vcl.Graphics
  , Vcl.ComCtrls
  , WinApi.RichEdit
  , Winapi.Windows
  , Generics.Collections
  ;

type
  TLinkInfo = record
    RangeStart: Integer;
    RangeEnd: Integer;
    URL: string;
  end;
  TFormattedStackTraceView = class
  private
    { Private declarations }
    FEdit: TRichEdit;
    Fregexp: TPerlRegEx;
    FLinkList: TList<TLinkInfo>;
    function GetStackTraceLineRegExp: string;
    function FindModuleIn3rdPartyList(Atext: string): boolean;
    function FindModuleInUnknownList(Atext: string): boolean;
    // procedure AddStyledLink(ARichEdit: TRichEdit; const DisplayText, HiddenURL: string;
    //   AColor: TColor = clBlue; AddUnderline: Boolean = True);
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
    procedure AddHyperLink(const AURL: string; const AText: string = '');
    procedure AddColorHyperLink(const AURL: string; const AText: string; AColor: TColor);
    (* procedure MakeLinksRed(); *)
  end;

implementation

uses
  UnitMain;

procedure TFormattedStackTraceView.AddFormattedText(const AText: string; AStyle: TFontStyles);
begin
  FEdit.SelLength := 0;
  FEdit.SelStart := FEdit.GetTextLen;
  FEdit.SelAttributes.Style := AStyle;
  FEdit.SelText := AText;
  FEdit.SelLength := 0;
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
  FLinkList := TList<TLinkInfo>.Create;
end;

destructor TFormattedStackTraceView.Destroy;
begin
  FModulesUnknownList.Free;
  FModules3rdPartyList.Free;
  Fregexp.Free;
  FLinkList.Free;
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

{
procedure TFormattedStackTraceView.AddStyledLink(ARichEdit: TRichEdit; const DisplayText, HiddenURL: string;
  AColor: TColor = clBlue; AddUnderline: Boolean = True);
var
  StartPos, EndPos: Integer;
  cf: CHARFORMAT2W; // Use CHARFORMAT2W for Unicode support
begin
  // 1. Append text and get its range
  ARichEdit.SelStart := ARichEdit.GetTextLen;
  StartPos := ARichEdit.SelStart;
  // StartPos := ARichEdit.GetTextLen - ARichEdit.ActiveLineNo; // Position before adding text
  ARichEdit.SelLength := 0;
  ARichEdit.SelAttributes.Color := AColor;
  if AddUnderline then
    ARichEdit.SelAttributes.Style := ARichEdit.SelAttributes.Style + [fsUnderline]
  else
    ARichEdit.SelAttributes.Style := ARichEdit.SelAttributes.Style - [fsUnderline];
  ARichEdit.SelText := DisplayText;
  ARichEdit.SelStart := ARichEdit.SelStart - length(DisplayText);
  ARichEdit.SelLength := length(DisplayText);
  // EndPos := ARichEdit.SelStart; // Position after adding text

  // Ensure we have a valid range
  // if StartPos >= EndPos then Exit;

  // 2. Select the newly added text
  // ARichEdit.SelStart := StartPos;
  // ARichEdit.SelLength := EndPos - StartPos;

  // 3. Apply basic formatting (Color, Underline via SelAttributes - often sufficient)
  {
  // 4. Apply the CFE_LINK effect using SendMessage
  FillChar(cf, SizeOf(cf), 0);
  cf.cbSize := SizeOf(cf);
  // We only want to modify the link effect state
  cf.dwMask := CFM_LINK;
  cf.dwEffects := CFE_LINK;

  // Send the message to apply the format to the selection
  SendMessage(ARichEdit.Handle, EM_SETCHARFORMAT, SCF_SELECTION, LPARAM(@cf));

  // 5. Store the link info externally
  // Make sure FLinkList is initialized (e.g., in FormCreate: FLinkList := TList<TLinkInfo>.Create;)
  if Assigned(FLinkList) then
  begin
    var LinkInfo: TLinkInfo;
    LinkInfo.RangeStart := StartPos;
    LinkInfo.RangeEnd := EndPos; // Store end position (exclusive or inclusive depending on how you use it)
    LinkInfo.URL := HiddenURL;
    FLinkList.Add(LinkInfo);
  end;
  }

  // Optional: Deselect text
  {
  ARichEdit.SelLength := 0;
  ARichEdit.SelStart := ARichEdit.GetTextLen;
end;
}

(*
procedure TFormattedStackTraceView.MakeLinksRed();
var
  i: Integer;
  StartLink: Integer;
  CurrentFmt: TCharFormat2; // Use TCharFormat2 for link support
  SetFmt: TCharFormat2;
  CurrentSelStart, CurrentSelLen: Integer;
begin
  if FEdit.Lines.Count = 0 then Exit; // Nothing to do

  // --- Save current selection ---
  CurrentSelStart := FEdit.SelStart;
  CurrentSelLen := FEdit.SelLength;

  FEdit.Lines.BeginUpdate; // Prevent flickering and speed up
  try
    i := 0;
    while i < FEdit.GetTextLen do
    begin
      // --- Check character format at position i ---
      FEdit.SelStart := i;
      FEdit.SelLength := 1; // Check one character

      FillChar(CurrentFmt, SizeOf(TCharFormat2), 0);
      CurrentFmt.cbSize := SizeOf(TCharFormat2);
      // Use SCF_SELECTION even for one char - asks for format of the selection
      FEdit.Perform(EM_GETCHARFORMAT, SCF_SELECTION, LPARAM(@CurrentFmt));

      // --- Is it a link character? ---
      if ((CurrentFmt.dwMask and CFM_LINK) = CFM_LINK) and
         ((CurrentFmt.dwEffects and CFE_LINK) = CFE_LINK) then
      begin
        StartLink := i; // Found the start of a link

        // --- Find the end of this link segment ---
        Inc(i); // Move to the next character
        while i < FEdit.GetTextLen do
        begin
          FEdit.SelStart := i;
          FEdit.SelLength := 1;
          FillChar(CurrentFmt, SizeOf(TCharFormat2), 0);
          CurrentFmt.cbSize := SizeOf(TCharFormat2);
          FEdit.Perform(EM_GETCHARFORMAT, SCF_SELECTION, LPARAM(@CurrentFmt));

          if not (((CurrentFmt.dwMask and CFM_LINK) = CFM_LINK) and
                  ((CurrentFmt.dwEffects and CFE_LINK) = CFE_LINK)) then
          begin
            // No longer a link character, the segment ended at i-1
            break;
          end;
          Inc(i); // Continue checking next character
        end;

        // --- Select the entire link segment ---
        FEdit.SelStart := StartLink;
        FEdit.SelLength := i - StartLink; // Length of the segment

        // --- Prepare format to set: ONLY change color ---
        FillChar(SetFmt, SizeOf(TCharFormat2), 0);
        SetFmt.cbSize := SizeOf(TCharFormat2);
        SetFmt.dwMask := CFM_COLOR; // We only want to change the color
        SetFmt.crTextColor := RGB(255, 0, 0); // Set color to red

        // --- Apply the format change ---
        FEdit.Perform(EM_SETCHARFORMAT, SCF_SELECTION, LPARAM(@SetFmt));

        // i is already positioned after the link segment, loop continues correctly
      end
      else
      begin
        // Not a link character, just move to the next one
        Inc(i);
      end;
    end; // while
  finally
    // --- Restore original selection ---
    FEdit.SelStart := CurrentSelStart;
    FEdit.SelLength := CurrentSelLen;
    FEdit.Lines.EndUpdate;
  end;
end;
*)

procedure TFormattedStackTraceView.AddColorHyperLink(const AURL: string; const AText: string; AColor: TColor);
var
  StartLink, EndLink: Integer;
  SetFmt: CHARFORMAT2W; // Use CHARFORMAT2W for Unicode support
begin
  FEdit.SelStart := FEdit.GetTextLen;
  StartLink := FEdit.SelStart;
  FEdit.SetSelTextToFriendlyURL(AText, AURL);
  EndLink := FEdit.SelStart;

  FEdit.SelStart := StartLink;
  FEdit.SelLength := EndLink - StartLink;

  // --- Prepare format to set: ONLY change color ---
  FillChar(SetFmt, SizeOf(SetFmt), 0);
  SetFmt.cbSize := SizeOf(SetFmt);
  SetFmt.dwMask := CFM_COLOR;   // We only want to change the color
  SetFmt.crTextColor := AColor; // Set color
  FEdit.Perform(EM_SETCHARFORMAT, SCF_SELECTION, LPARAM(@SetFmt));

  FEdit.SelStart := EndLink;
  FEdit.SelLength := 0;
end;

procedure TFormattedStackTraceView.AddHyperLink(const AURL: string; const AText: string = '');
begin
  if AText = '' then
    FEdit.SetSelTextToFriendlyURL(AURL, AURL)
  else
    FEdit.SetSelTextToFriendlyURL(AText, AURL);
end;

function TFormattedStackTraceView.AddLine(Atext: string): string;
const
  ufs_e: string = 'Unknown function';
  ufs_g: string = 'Unbekannte Funktion';
  ufs_f: string = 'Fonction inconnue';
  ufs_j: string = '不明な機能';
var
  Lregexp: TPerlRegEx;
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
            then
              begin
                // AddHyperLink('file://' + Groups[2], Groups[2]);
                AddColorHyperLink('file://' + Groups[2], Groups[2], clRed);
              end
            else
              if FindModuleInUnknownList(Groups[2])
                then AddColorHyperLink('file://' + Groups[2], Groups[2], clFuchsia)
                else AddColorHyperLink('file://' + Groups[2], Groups[2], clBlue);
          AddFormattedText('}', [], clBlack);

          // Groups[3]
          Lregexp := TPerlRegEx.Create; // "Unknown function" check
          try
            Lregexp.RegEx := '\s*(' + ufs_e + '|' + ufs_g + '|' + ufs_f + '|' + ufs_j + ')(.*)';
            Lregexp.Subject := Groups[3];
            if Lregexp.Match
              then
                begin
                  AddFormattedText(' ' + Lregexp.Groups[1], [], clWebCoral);
                  AddFormattedText(Lregexp.Groups[2], [], clGray);
                end
              else AddFormattedText(' ' + Groups[3], [], clGray);
          finally
            Lregexp.Free;
          end;
        end
    else
      AddFormattedText(Atext, [], clBlack);
  end;
  AddFormattedText(sLineBreak, []);
end;

end.
