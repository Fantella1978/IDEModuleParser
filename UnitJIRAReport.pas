unit UnitJIRAReport;

interface

uses
  System.Classes, System.SysUtils
  , UnitLogger
  ;

type
  TJIRAReport = class(TStringList)
  private
    FKnownThirdPartyPackagesCount: integer;
    FUnknownBPLPackagesCount: integer;
    FKnownThirdPartyPackagesList: TStringList;
    FLogger: TMyLogger;
    procedure AddStackTrace;
    procedure AddPackagesInformation;
    //
  public
    property Logger: TMyLogger read FLogger write FLogger;
    procedure CreateReport;
  end;

implementation

uses
  UnitMain, UnitStaticFunctions;

const
  STR_STACKTRACE_TITLE                    = 'Customer''s Stack Trace (expand)';
  STR_HAS_INSTALLED_SOME_3RD_PARTY        = 'The customer has installed known 3rd-party package(s) in 32-bit IDE:';
  STR_HAS_INSTALLED_SOME_3RD_PARTY_IDE64  = 'The customer has installed known 3rd-party package(s) in 64-bit IDE:';
  STR_HAS_INSTALLED_SOME_UNKNOWN_3RD_PARTY        = 'The customer has installed some unknown 3rd-party package(s) in 32-bit IDE.';
  STR_HAS_INSTALLED_SOME_UNKNOWN_3RD_PARTY_IDE64  = 'The customer has installed some unknown 3rd-party package(s) in 64-bit IDE.';
  STR_DOES_NOT_HAVE_3RD_PARTY             = 'The customer''s 32-bit IDE does not have any known 3rd-party packages or plugins installed.';
  STR_DOES_NOT_HAVE_3RD_PARTY_IDE64       = 'The customer''s 64-bit IDE does not have any known 3rd-party packages or plugins installed.';
  STR_AND_SOME_OTHER                      = 'and some other unknown .bpl packages';
  STR_AND_MANY_OTHERS                     = 'and many (%s) others unknown .bpl packages';

{ TJIRAReport }

procedure TJIRAReport.AddPackagesInformation;
var
  Index: integer;
begin
  if not frmMain.tsModulesList.TabVisible then Exit;
  Add('');
  FUnknownBPLPackagesCount := frmMain.GetUnknownBPLPackagesCount;
  FKnownThirdPartyPackagesCount := frmMain.Get3rdPartyPackagesCount;
  case frmMain.GetIDEBittness(BDSIDEModule) of
    ib32bit: // 32-bit IDE
      begin
        if FKnownThirdPartyPackagesCount = 0 then
          begin
            if FUnknownBPLPackagesCount > 0 then
              Add(STR_HAS_INSTALLED_SOME_UNKNOWN_3RD_PARTY) // Known = 0 and UnKnown > 0
            else
              Add(STR_DOES_NOT_HAVE_3RD_PARTY); // Known = 0 and UnKnown = 0
          end
        else
          begin
            Add(STR_HAS_INSTALLED_SOME_3RD_PARTY); // Known > 0
            FKnownThirdPartyPackagesList := frmMain.Get3rdPartyPackagesList;
            try
              for Index := 0 to FKnownThirdPartyPackagesList.Count - 1 do
                Add('- ' + FKnownThirdPartyPackagesList[Index]);
            finally
              FKnownThirdPartyPackagesList.Free;
            end;
            if FUnknownBPLPackagesCount in [1..5] then
              Add(STR_AND_SOME_OTHER); // and UnKnown 1 - 5 item(s)
            if FUnknownBPLPackagesCount > 5 then
              Add(Format(STR_AND_MANY_OTHERS, [FUnknownBPLPackagesCount.ToString])); // and UnKnown > 5 items
          end;
      end;
    ib64bit: // 64-bit IDE
      begin
        if FKnownThirdPartyPackagesCount = 0 then
          begin
            if FUnknownBPLPackagesCount > 0 then
              Add(STR_HAS_INSTALLED_SOME_UNKNOWN_3RD_PARTY_IDE64) // Known = 0 and UnKnown > 0
            else
              Add(STR_DOES_NOT_HAVE_3RD_PARTY_IDE64); // Known = 0 and UnKnown = 0
          end
        else
          begin
            Add(STR_HAS_INSTALLED_SOME_3RD_PARTY_IDE64); // Known > 0
            FKnownThirdPartyPackagesList := frmMain.Get3rdPartyPackagesList;
            try
              for Index := 0 to FKnownThirdPartyPackagesList.Count - 1 do
                Add('- ' + FKnownThirdPartyPackagesList[Index]);
            finally
              FKnownThirdPartyPackagesList.Free;
            end;
            if FUnknownBPLPackagesCount in [1..5] then
              Add(STR_AND_SOME_OTHER); // and UnKnown 1 - 5 item(s)
            if FUnknownBPLPackagesCount > 5 then
              Add(Format(STR_AND_MANY_OTHERS, [FUnknownBPLPackagesCount.ToString])); // and UnKnown > 5 items
          end;
      end;
    ibUnknown:;
  end;
end;

procedure TJIRAReport.AddStackTrace;
begin
  if not frmMain.tsStackTraceFile.TabVisible then Exit;
  Add(STR_STACKTRACE_TITLE);
  // Add('');
  AddStrings(frmMain.memoStackTrace.Lines);
end;

procedure TJIRAReport.CreateReport;
begin
  // Create Report
  FLogger.AddToLog('Create Report for JIRA.');

  Clear;
  AddStackTrace;
  AddPackagesInformation;

  FLogger.AddToLog('Create Report for JIRA. Success.');
end;

end.
