unit Main;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, SysUtils, FileUtil, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ComCtrls, StdCtrls, Buttons, IniFiles, Grids,
  SButton, ExtCtrls, ActnList, ImgList, Tools,
  DateUtils, DOM, XMLRead, Zipper, LazLogger, FlightLog, DefaultTranslator, fgl;

const
  {$I FluPP.inc}

type
  TFlightLogList = TFPGObjectList<TFlightLog>;

type

  { TFMain }

  TFMain = class(TForm)
    ActionManager: TActionList;
    GridSched: TStringGrid;
    KatAdd: TMenuItem;
    KatRem: TMenuItem;
    MainMenu: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem20: TMenuItem;
    MenuItem21: TMenuItem;
    MenuItem22: TMenuItem;
    MenuItem23: TMenuItem;
    MenuItem24: TMenuItem;
    MenuItem25: TMenuItem;
    MenuItem26: TMenuItem;
    MenuItem27: TMenuItem;
    MenuItem28: TMenuItem;
    MenuItem29: TMenuItem;
    N1: TMenuItem;
    N5: TMenuItem;
    Panel2: TPanel;
    PanelFlightLog: TPanel;
    PanelSButtons: TPanel;
    PopupMenu: TPopupMenu;
    PUFiles: TMenuItem;
    PUFlightEdit: TMenuItem;
    PUFlightNew: TMenuItem;
    PUFlugEinfuegen: TMenuItem;
    PUFlugloeschen: TMenuItem;
    PUGoogleEarth: TMenuItem;
    PUGoogleMap: TMenuItem;
    PUKategorieZuordnen: TMenuItem;
    PUloeschrueck: TMenuItem;
    PUSepFiles: TMenuItem;
    Separator4: TMenuItem;
    Separator3: TMenuItem;
    Separator2: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    Separator1: TMenuItem;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    StartTimer: TTimer;
    ActionExit: TAction;
    ActionToolBar: TToolBar;
    ActionFileNew: TAction;
    ActionFileOpen: TAction;
    ActionFileSave: TAction;
    ActionFileSaveAs: TAction;
    ActionPrint: TAction;
    ActionSettings: TAction;
    ActionClose: TAction;
    LF1: TAction;
    LF2: TAction;
    LF3: TAction;
    LF4: TAction;
    LF5: TAction;
    ActionFlightNew: TAction;
    ActionFlightEdit: TAction;
    ActionFlightInsert: TAction;
    ActionFlightDelete: TAction;
    ActionFlightDeleteUndo: TAction;
    ActionScheduler: TAction;
    ActionNinetyDays: TAction;
    ActionStatistic: TAction;
    ActionLicense: TAction;
    ActionTrainBaro: TAction;
    ImageList: TImageList;
    ActionAirports: TAction;
    ActionSortFlights: TAction;
    ActionInfo: TAction;
    StatusBar1: TStatusBar;
    ActionBasicSettings: TAction;
    ActionFlightLogs: TAction;
    ActionFileImport: TAction;
    ActionHelpOnline: TAction;
    ActionHP: TAction;
    ActionHPAirports: TAction;
    ActionHPLicenses: TAction;
    ActionHPLanguages: TAction;
    ActionHPBugs: TAction;
    ActionHPRFE: TAction;
    ActionHPSupport: TAction;
    PanelScheduler: TPanel;
    ActionFileExport: TAction;
    ActionExportGoogleMap: TAction;
    ActionExportGoogleEarth: TAction;
    ActionResetColumns: TAction;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    procedure ExitClick(Sender: TObject);
    procedure FileSave(Sender: TObject);
    procedure FileOpen(Sender: TObject);
    procedure FileNew(Sender: TObject);
    procedure MMStatisticsClick(Sender: TObject);
    procedure InfoClick(Sender: TObject);
    procedure SettingsClick(Sender: TObject);
    procedure FileSaveAsClick(Sender: TObject);
    procedure FlightEdit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LastFifeClick(Sender: TObject);
    procedure StartTimerTimer(Sender: TObject);
    procedure LicenseClick(Sender: TObject);
    procedure Print(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CloseClick(Sender: TObject);
    procedure FlightNew(Sender: TObject);
    procedure FlightDeleteUndo(Sender: TObject);
    procedure FlightDelete(Sender: TObject);
    procedure BasicSettingsClick(Sender: TObject);
    procedure AirportsClick(Sender: TObject);
    procedure FlightInsert(Sender: TObject);
    procedure SortAllFlightsClick(Sender: TObject);
    procedure MMTrainBaroClick(Sender: TObject);
    procedure MMNinetyDaysClick(Sender: TObject);
    procedure SchedulerClick(Sender: TObject);
    procedure FlightLogsClick(Sender: TObject);
    procedure ActionHPExecute(Sender: TObject);
    procedure ActionHPAirportsExecute(Sender: TObject);
    procedure ActionHPLicensesExecute(Sender: TObject);
    procedure ActionHPLanguagesExecute(Sender: TObject);
    procedure ActionHPRFEExecute(Sender: TObject);
    procedure ActionHPBugsExecute(Sender: TObject);
    procedure ActionHPSupportExecute(Sender: TObject);
    procedure GridSchedDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure ActionFileExportExecute(Sender: TObject);
    procedure ActionExportGoogleMapExecute(Sender: TObject);
    procedure ActionExportGoogleEarthExecute(Sender: TObject);
    procedure ActionResetColumnsExecute(Sender: TObject);
    procedure ActionFileImportExecute(Sender: TObject);
  private
    ProgressBar: TProgressBar;
    procedure LoadFluFile;
    procedure SaveFile(SaveFileName: String);
    procedure LoadDefaultGenSettings;
    procedure LoadDefaultSettings(FlightLog: TFlightLog);
  public
    FlightLogList: TFlightLogList;
    ActiveFlightLog: TFlightLog;
    AirportData: TAirports;
    procedure CreateNewFlightLog(Name, GridCols: String); overload;
    procedure CreateNewFlightLog(Name: String); overload;
    function SpeichernAbfrage: Boolean;
    procedure InsertData;
    procedure onHint(Sender: TObject);
    procedure ReadAirportData;
    procedure UpdateButtonState;
    procedure UpdateScheduleGrid;
    procedure LastFife(FileName: String);
    procedure CreateSButtons;
    procedure ActivateSButton;
    procedure UpdateSButtons;
  end;

var
  FMain: TFMain;
  DataChanged: Boolean;

  GenSettings: TStringList;
  Medicals: TStringList;
  Schedules: TStringList;
  SchedValidity: TStringList;
  FluFileName: String;
  FlpTempDir: String;

implementation

uses
  Input, Info, Settings, Statistics, Licenses, Print,
  Airports, BasicSettings, TrainBaro, NinetyDays, FlightLogs,
  ToolsGrid, ToolsShell, CalendarView, Import, Export;

{$R *.lfm}

// ----------------------------------------------------------------
// Form create
// ----------------------------------------------------------------
procedure TFMain.FormCreate(Sender: TObject);
var IniFile: TIniFile;
begin
  //Caption := 'FluPP - ' + GetFileVersion(ParamStr(0));
  FluFileName := '';

  ShortTimeFormat := 'hh:mm';
  TimeSeparator := ':';

  //ShortDateFormat := 'dd.MM.yyyy';
  //DateSeparator := '.';

  { read inifile }
  Inifile := Tinifile.create(GetActualDir(false)+'\FluPP.Ini');
  LF1.Caption := Inifile.ReadString('LastFife', '1', '');
  LF2.Caption := Inifile.ReadString('LastFife', '2', '');
  LF3.Caption := Inifile.ReadString('LastFife', '3', '');
  LF4.Caption := Inifile.ReadString('LastFife', '4', '');
  LF5.Caption := Inifile.ReadString('LastFife', '5', '');
  if Inifile.ReadBool('General', 'AutoLoad', False) = True then
  begin
    FluFileName := Inifile.ReadString('General', 'AutoLoadFile', '');
    StartTimer.Enabled := True;
  end;  
  Height := Inifile.ReadInteger('General', 'Height', 480);
  Width := Inifile.ReadInteger('General', 'Width', 640);
  Left := (Screen.Width div 2) - (width div 2);
  if IniFile.ReadBool('General', 'WMaximized', False) then
    WindowState := wsMaximized;

  //DefaultInstance.UseLanguage(Inifile.ReadString('General', 'Language', copy(DefaultInstance.GetCurrentLanguage,1,2)));
  Inifile.Free;

  GenSettings := TSTringList.Create;
  GenSettings.Values['WarningMonth'] := '2';
  GenSettings.Values['ExportICal'] := '0';
  Medicals := TStringList.Create;
  Schedules := TStringList.Create;
  SchedValidity := TStringList.Create;
  AirportData := TAirports.Create;

  FlightLogList := TFlightLogList.create;

  DebugLn('create GridSched');
  with GridSched do
  begin
    ColWidths[0] := 47;
    ColWidths[1] := GridSched.Width - ColWidths[0] - 2;
    Selection := DeSelectRect;
  end;

  PanelSButtons.Width := 0;
  DebugLn('UpdateButtonState');
  UpdateButtonState;

  //TranslateComponent(Self);

  Application.OnHint := onHint;

  LF1.visible := LF1.Caption <> '';
  LF2.visible := LF2.Caption <> '';
  LF3.visible := LF3.Caption <> '';
  LF4.visible := LF4.Caption <> '';
  LF5.visible := LF5.Caption <> '';

  { Load with params }
  if (ParamStr(1) <> '') and (ExtractFileExt(ParamStr(1)) = '.flu') then
  begin
    FluFileName := ParamStr(1);
    StartTimer.Enabled := True;
  end;
  DebugLn('ReadAirportData');
  AirportData.ReadAirportData(GetActualDir(true)+'iata-icao.csv');
end;

// ----------------------------------------------------------------
// Timer for param file opening
// ----------------------------------------------------------------
procedure TFMain.StartTimerTimer(Sender: TObject);
begin
  StartTimer.Enabled := False;
  LoadFluFile;
end;

// ----------------------------------------------------------------
// On hint
// ----------------------------------------------------------------
procedure TFMain.onHint(Sender: TObject);
begin
  StatusBar1.Panels[1].text := GetLongHint(Application.Hint);
end;

// ----------------------------------------------------------------
// Load default GenSettings
// ----------------------------------------------------------------
procedure TFMain.LoadDefaultGenSettings;
begin
  GenSettings.Values['WarningMonth'] := '2';
  GenSettings.Values['ExportICal'] := '0';
end;

// ----------------------------------------------------------------
// Load default Settings
// ----------------------------------------------------------------
procedure TFMain.LoadDefaultSettings(FlightLog: TFlightLog);
begin
  with FlightLog do
  begin
    Settings.Values['BFStarts'] := '0';
    Settings.Values['BFTime'] := '00000:00';
    Settings.Values['LicenseSince'] := '  .  .    ';
    Settings.Values['IDPrefix'] := '';
    Settings.Values['DistUnit'] := 'nm';
    Settings.Values['License'] := '';
    Settings.Values['Numeration'] := '0'; // Continuous
    Settings.Values['ShowFlightTime'] := 'False';
    Settings.Values['ShowBlockTime'] := 'True';
    Settings.Values['ShowStartType'] := 'False';
    Settings.Values['DefaultTime'] := '0'; // BlockTime
    Settings.Values['DefPosition'] := '0'; // Pilot

    Settings.Values['DisallowChange'] := '0';
    Settings.Values['AllowLastEdit'] := '0';
  end;
end;

// ----------------------------------------------------------------
// Load airport database
// ----------------------------------------------------------------
procedure TFMain.ReadAirportData;
{----------}
  procedure GetData(FileName: String);
  var
    AFile: TextFile;
    RowText, Cell: String;
    l,i,Col: Word;
    TmpAirport: TAirport;
  begin
    if not FileExists(FileName) then
      Exit;
    AssignFile(AFile,FileName);
    try
      Reset(AFile);
      while not Eof(AFile) do
      begin
        Readln(AFile,RowText);
        Col := 1;
        i := 1;
        l := length(RowText);
        while i < l do
        begin
          Cell := '';
          begin
            while (RowText[i] <> ';') and (i < length(RowText)) do
            begin
              Cell := Cell + RowText[i];
              inc(i);
            end;
            case Col of
              1: TmpAirport.AirportName := Cell;
              2: TmpAirport.ICAO := Cell;
              3: TmpAirport.Lat :=Cell;
              4: TmpAirport.Lon := Cell;
            end;
            inc(Col);
            inc(i);
          end;
        end;
        AirportData.Add(TmpAirport);
      end;
    finally
      CloseFile(AFile);
    end;
  end;
{----------}
var
  Found: Word;
  SearchRec: TSearchRec;
begin
  { FluPP 1.08 -> 1.09 }
  if FileExists(GetActualDir(true)+'Eigene Flugplaetze.txt') then
    RenameFile(PChar(GetActualDir(true)+'Eigene Flugplaetze.txt'), PChar(GetActualDir(true)+'airports'+PathDelim+'airports.txt'));

  DebugLn(GetActualDir(true)+'airports');
  if (SysUtils.DirectoryExists(GetActualDir(true)+'airports')) then
  begin
    Found := FindFirst(GetActualDir(true)+'airports'+PathDelim+'airports*.txt', faAnyFile, SearchRec);
    while Found = 0 do
    begin
      DebugLn(GetActualDir(true)+'airports'+PathDelim +SearchRec.Name);
      GetData(GetActualDir(true)+'airports'+PathDelim +SearchRec.Name);
      Found := FindNext(SearchRec);
    end;
    FindClose(SearchRec);
  end;
  DebugLn('Exit ReadAirportData');
end;

// ----------------------------------------------------------------
// create new flightlog
// ----------------------------------------------------------------
procedure TFMain.FileNew(Sender: TObject);
begin
  if not SpeichernAbfrage then Exit;
  CloseClick(Sender);

  FlpTempDir := SysUtils.GetTempDir(false);
  DeleteFile(FlpTempDir);
  CreateDir(FlpTempDir);
  CreateDir(FlpTempDir+PathDelim+'Files');

  DebugLn('LoadDefaultGenSettings');
  LoadDefaultGenSettings;

  with TFFlightLogs.Create(Application) do
  try
    ButtonNewClick(FMain);
  finally
    Release;
  end;
  UpdateButtonState;
  CreateSButtons;

  with TFSettings.Create(Application) do
  try
    NewFlightLog;
  finally
    Release;
  end;

  UpdateButtonState;
  CreateSButtons;
end;

// ----------------------------------------------------------------
// Create new flight log
// ----------------------------------------------------------------
procedure TFMain.CreateNewFlightLog(Name, GridCols: String);
begin
  DebugLn('CreateNewFlightLog');
  CreateNewFlightLog(Name);
  DebugLn('ReadTStrings(GridCols, ActiveFlightLog.GridCols);');
  ReadTStrings(GridCols, ActiveFlightLog.GridCols);
  ActiveFlightLog.Grid.ColCount := ActiveFlightLog.GridCols.Count;
  ActiveFlightLog.NameCols;
  SetLength(ActiveFlightLog.Undo, ActiveFlightLog.GridCols.Count);
end;

// ----------------------------------------------------------------
// create fligtlog grid
// ----------------------------------------------------------------
procedure TFMain.CreateNewFlightLog(Name: String);
var
  Flightlog: TFlightLog;
begin
  Flightlog := TFlightLog.Create;
  ActiveFlightLog := Flightlog;
  Flightlog.Caption := Name;
  Flightlog.Grid := TStringGrid.Create(PanelFlightLog);
  Flightlog.Grid.Parent := PanelFlightLog;
  Flightlog.Grid.Align := alClient;
  FlightlogList.Add(Flightlog);

  with Flightlog do
  begin
    Grid.ColCount := NumberOfGridRows + 1;
    setColWidth(DefaultColWidth);
  end;

  LoadDefaultSettings(Flightlog);
end;

// ----------------------------------------------------------------
// Set button state
// ----------------------------------------------------------------
procedure TFMain.UpdateButtonState;
var State, GridAssigned: Boolean;
begin
  State := False;
  if Assigned(ActiveFlightLog) then
    if (ActiveFlightLog.Data['Dat',1] <> '') then
      State := True;

  { Undo }
  ActionFlightDeleteUndo.Enabled := False;
  if State then
  begin
    if length(ActiveFlightLog.Undo) > 0 then
      if ActiveFlightLog.Undo[1] <> '' then
        ActionFlightDeleteUndo.Enabled := True;
  end;

  { Enable when data available }
  ActionFlightEdit.Enabled := State;
  ActionFlightInsert.Enabled := State;
  ActionFlightDelete.Enabled := State;
  ActionPrint.Enabled := State;
  ActionExportGoogleMap.Enabled := State;
  ActionExportGoogleEarth.Enabled := State;

  if Assigned(ActiveFlightLog) then
  begin
    //ActiveFlightLog.PUFlightEdit.Enabled := State;
    //ActiveFlightLog.PUFlugEinfuegen.Enabled := State;
    //ActiveFlightLog.PUFlugloeschen.Enabled := State;
    //ActiveFlightLog.PUKategorieZuordnen.Enabled := State;
    //
    //ActionFlightEdit.Enabled := FInput.CanEdit(State);
    //ActiveFlightLog.PUFlightEdit.Enabled := FInput.CanEdit(State);
  end;

  { Enable when flight log available }
  GridAssigned := Assigned(ActiveFlightLog);
  ActionFileSave.Enabled := GridAssigned;
  ActionFileSaveAs.Enabled := GridAssigned;
  ActionFileImport.Enabled := GridAssigned;
  ActionFileExport.Enabled := GridAssigned;
  ActionFlightNew.Enabled := GridAssigned;
  ActionSettings.Enabled := GridAssigned;
  ActionScheduler.Enabled := GridAssigned;
  ActionFlightLogs.Enabled := GridAssigned;
  ActionClose.Enabled := GridAssigned;

  ActionScheduler.Enabled := GridAssigned;
  ActionNinetyDays.Enabled := GridAssigned;
  ActionStatistic.Enabled := GridAssigned;
  ActionLicense.Enabled := GridAssigned;
  ActionTrainBaro.Enabled := GridAssigned;
  ActionAirports.Enabled := GridAssigned;
  ActionSortFlights.Enabled := GridAssigned;
  ActionResetColumns.Enabled := GridAssigned;

  UpdateScheduleGrid;
end;

// ----------------------------------------------------------------
// Form close
// ----------------------------------------------------------------
procedure TFMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caNone;
  ExitClick(self);
end;

// ----------------------------------------------------------------
// Exit, write ini-file
// ----------------------------------------------------------------
procedure TFMain.ExitClick(Sender: TObject);
var
  IniFile: TIniFile;
begin
  if FlightLogList.Count = 0 then
    Application.Terminate
  else
    if SpeichernAbfrage then
      Application.Terminate
    else
      Exit;

  FileUtil.DeleteDirectory(FlpTempDir, False);

  Inifile := Tinifile.create(GetActualDir(false)+'\FluPP.Ini');
  Inifile.WriteString('LastFife', '1', LF1.Caption);
  Inifile.WriteString('LastFife', '2', LF2.Caption);
  Inifile.WriteString('LastFife', '3', LF3.Caption);
  Inifile.WriteString('LastFife', '4', LF4.Caption);
  Inifile.WriteString('LastFife', '5', LF5.Caption);
  Inifile.WriteBool('General', 'WMaximized', WindowState = wsMaximized);
  if not (WindowState = wsMaximized) then
  begin
    Inifile.WriteInteger('General','Height',Height);
    Inifile.WriteInteger('General','Width',Width);
  end;
  Inifile.Free;

  GenSettings.Free;
  Medicals.Free;
  Schedules.Free;
  SchedValidity.Free;
  AirportData.Free;
end;

// ----------------------------------------------------------------
// Closes all flight logs
// ----------------------------------------------------------------
procedure TFMain.CloseClick(Sender: TObject);
var
  i: Integer;
begin
  if FlightLogList.Count <= 0 then exit;
  if (Sender <> ActionFileNew) then
    if not SpeichernAbfrage then Exit;

  for i:= FlightLogList.Count - 1 downto 0 do
    GridChild(i).Free;

  FileUtil.DeleteDirectory(FlpTempDir, False);

  GenSettings.Clear;
  Medicals.Clear;
  Schedules.Clear;
  GridSched.Clear;
  SchedValidity.Clear;
  PanelScheduler.Visible := False;

  DataChanged := False;
  StatusBar1.Panels[0].Text := '';
  StatusBar1.Panels[2].Text := '';
  StatusBar1.Panels[3].Text := '';
  FluFileName := '';
  UpdateButtonState;
end;

// ----------------------------------------------------------------
// Opens a file from LastFife
// ----------------------------------------------------------------
procedure TFMain.LastFifeClick(Sender: TObject);
begin
 if not SpeichernAbfrage then Exit;
 CloseClick(Self);
 FluFileName := TAction(Sender).Caption;
 LoadFluFile;
end;

// ----------------------------------------------------------------
// Add "File" to LastFife
// ----------------------------------------------------------------
procedure TFMain.LastFife(FileName: String);
var
  i,j: Word;
  SLastFife: Array[0..4] of String;
  Found: Boolean;
begin
  { is file already in list -> move to 1st position }
  found := False;
  SLastFife[0] := LF1.Caption;
  SLastFife[1] := LF2.Caption;
  SLastFife[2] := LF3.Caption;
  SLastFife[3] := LF4.Caption;
  SLastFife[4] := LF5.Caption;
  i := 0;
  while (not found) and (i < 5) do
  begin
    if FileName = SLastFife[i] then
    begin
      if i > 0 then for j := i downto 1 do
      begin
        SLastFife[j] := SLastFife[j-1];
      end;
      SLastFife[0] := FileName;
      Found := True;
    end;
    inc(i);
  end;
  { Not in list yet }
  if not found then
  begin
    for i := 3 downto 0 do SLastFife[i+1] := SLastFife[i];
    SLastFife[0] := FileName;
  end;

  { Hide empty entries }
  LF1.Caption := SLastFife[0];
  LF2.Caption := SLastFife[1];
  LF3.Caption := SLastFife[2];
  LF4.Caption := SLastFife[3];
  LF5.Caption := SLastFife[4];

  LF1.visible := LF1.Caption <> '';
  LF2.visible := LF2.Caption <> '';
  LF3.visible := LF3.Caption <> '';
  LF4.visible := LF4.Caption <> '';
  LF5.visible := LF5.Caption <> '';
end;

// ----------------------------------------------------------------
// Insert data
// ----------------------------------------------------------------
procedure TFMain.InsertData;
begin
  ActiveFlightLog.ReCalcGridTime;
  ActiveFlightLog.ReCalcGridNr;
  UpdateButtonState;
  UpdateSButtons;
end;

// ----------------------------------------------------------------
// Open flightlog
// ----------------------------------------------------------------
procedure TFMain.FileOpen(Sender: TObject);
begin
  CloseClick(Self);
  OpenDialog.Filter := ('FluPP File')+' (*.flu)'+'|*.flu'+'|';
  if not OpenDialog.Execute then Exit;
  FluFileName := OpenDialog.FileName;
  LoadFluFile;
end;

// ----------------------------------------------------------------
// Read data from flightlog
// ----------------------------------------------------------------
procedure TFMain.LoadFluFile;
var IGCDir, TempFileName: String;
    XML : TXMLDocument;
    i : Word;
    UnZipper: TUnZipper;
begin
  if not FileExists(FluFileName) then
  begin
    MessageDlg(format(('File ''%s'' does not exist'), [FluFileName]), mtWarning, [mbOK], 0);
    Exit;
  end;

  LastFife(FluFileName);
  DataChanged := False;
  StatusBar1.Panels[2].Text := '';
  Statusbar1.Panels[3].Text := FluFileName;

  GenSettings.Clear;
  Medicals.Clear;
  Schedules.Clear;
  SchedValidity.Clear;
  LoadDefaultGenSettings;

  FlpTempDir := SysUtils.GetTempDir(False)+'\flp';
  DeleteFile(FlpTempDir);
  CreateDir(FlpTempDir);
  CreateDir(FlpTempDir+'\Files');
  TempFileName := FlpTempDir+'\flightlog.xml';

  try
    ProgressBar := TProgressBar.Create(FMain);
    ProgressBar.Parent := StatusBar1;
    ProgressBar.Top := 2;
    ProgressBar.Width := StatusBar1.Panels.Items[0].Width;
    ProgressBar.Height := StatusBar1.Height - 2;
    StatusBar1.Repaint;
    Screen.Cursor := crHourGlass;
    UnZipper := TUnZipper.Create;
    try
      UnZipper.Filename := FluFileName;
      UnZipper.OutputPath := FlpTempDir;
    except
      on E: Exception do
      begin
        CopyFile(pChar(FluFileName), pChar(TempFileName), False);
        IGCDir := copy(FluFileName, 1, length(FluFileName)-length(ExtractFileExt(FluFileName)));
        if DirectoryExists(IGCDir) then
          ShellCopyFile(IGCDir+'\*.*', FlpTempDir+'\Files', False);
        OpenOldFile4;
        Exit;
      end;
    end;
  finally
    ProgressBar.Free;
    Screen.Cursor := crDefault;
    StatusBar1.Repaint;
  end;

  with XML do try
    try
      ReadXMLFile(XML, TempFileName);
    except
      on E: Exception do begin
        OpenOldFile5;
        Exit;
      end;
    end;

    if (XML.DocumentElement.NodeName = 'FluPP') then begin
      case StrToInt(XML.DocumentElement.GetAttribute('Version')) of
        1 : OpenFluFile1(XML);
      end;
    end;

    if (XML.DocumentElement.NodeName = 'FliPS') then
      OpenFlpFile7(XML);

  finally
    XML.Free;
  end;

  for i := 0 to FlightLogList.Count-1 do
  begin
    GridChild(i).ReCalcGridNr;
    GridChild(i).Grid.FixedCols := 1;
    GridChild(i).Grid.Row := GridChild(i).Grid.RowCount-1;
    GridChild(i).Grid.ColCount := GridChild(i).GridCols.Count;
    GridChild(i).NameCols;
  end;

  //MDIChildren[FlightLogList.Count-1].show;
  ActiveFlightLog.ReCalcGridTime;

  UpdateButtonState;
  CreateSButtons;
end;

// ----------------------------------------------------------------
// Save changes
// ----------------------------------------------------------------
function TFMain.SpeichernAbfrage: Boolean;
var
  answer: Integer;
begin
  result := true;
  answer := mrNo;

  if DataChanged then
    answer := MessageDlg(format(('Do you want to save the file ''%s''?'),
      [extractFilename(FluFileName)]),mtConfirmation,[mbYes,mbNo,mbCancel],0);

  if answer = mrYes then FileSave(self);
  if answer = mrCancel then result := false;
end;

// ----------------------------------------------------------------
// Save
// ----------------------------------------------------------------
procedure TFMain.FileSave(Sender: TObject);
begin
  if FluFileName = '' then
  begin
    SaveDialog.Filter := ('FluPP File')+' (*.flu)'+'|*.flu';
    if not SaveDialog.Execute then Exit;
    SaveFile(SaveDialog.FileName);
    FluFileName := SaveDialog.FileName;
    LastFife(FluFileName);
    Statusbar1.Panels[3].Text := FluFileName;
  end
  else SaveFile(FluFileName)
end;

// ----------------------------------------------------------------
// Save as
// ----------------------------------------------------------------
procedure TFMain.FileSaveAsClick(Sender: TObject);
begin
  SaveDialog.Filter := ('FluPP File')+' (*.flu)'+'|*.flu';
  if not SaveDialog.Execute then Exit;

  SaveFile(SaveDialog.FileName);

  FluFileName := SaveDialog.FileName;
  LastFife(FluFileName);

  Statusbar1.Panels[3].Text := FluFileName;
end;

// ----------------------------------------------------------------
// Write data
// ----------------------------------------------------------------
procedure TFMain.SaveFile(SaveFileName: String);
begin
  SaveFluFile(SaveFileName);

  DataChanged := False;
  StatusBar1.Panels[2].Text := '';

  UpdateButtonState;
end;

// ----------------------------------------------------------------
// Export
// ----------------------------------------------------------------
procedure TFMain.ActionFileExportExecute(Sender: TObject);
begin
  SaveDialog.Filter := ('Comma-Separated Variables')+' (*.csv)'+'|*.csv';
  if not SaveDialog.Execute then exit;
  ExportCSV(SaveDialog.FileName);
end;

// ----------------------------------------------------------------
// View flight in GoogleMaps
// ----------------------------------------------------------------
procedure TFMain.ActionExportGoogleMapExecute(Sender: TObject);
begin
  ExportGoogleMap;
end;

// ----------------------------------------------------------------
// Export KMl file
// ----------------------------------------------------------------
procedure TFMain.ActionExportGoogleEarthExecute(Sender: TObject);
begin
  ExportGoogleEarth;
end;

// ----------------------------------------------------------------
// Info Dialog
// ----------------------------------------------------------------
procedure TFMain.InfoClick(Sender: TObject);
begin
  with TFInfo.Create(Application) do
  try
    ShowModal;
  finally
    Release;
  end;
end;

// ----------------------------------------------------------------
// Settings
// ----------------------------------------------------------------
procedure TFMain.SettingsClick(Sender: TObject);
var LastFile : string;
begin
  with TFSettings.Create(Application) do
  try
    TabSheetGeneral.TabVisible := True;
    TabSheetLicenses.TabVisible := True;
    TabSheetMedicals.TabVisible := True;
    TabSheetAutoComplete.TabVisible := True;
    TabSheetCat.TabVisible := True;
    ButtonNext.Visible := False;
    ButtonOK.Enabled := True;
    ButtonExit.Visible := True;

    ShowModal;

   { if ModalResult = idOK then
      FileSave(self)
    else begin
      LastFile := FluFileName;
      CloseClick(Self);

      FluFileName := LastFile;
      LoadFluFile;
    end;    }  { TODO -ounPoint : wieso? }
  finally
    Release;
  end;
end;

// ----------------------------------------------------------------
// Basic settings
// ----------------------------------------------------------------
procedure TFMain.BasicSettingsClick(Sender: TObject);
begin
  with TFBasicSettings.Create(Application) do
  try
    ShowModal;
  finally
    Release;
  end;
end;

// ----------------------------------------------------------------
// Sheduler
// ----------------------------------------------------------------
procedure TFMain.SchedulerClick(Sender: TObject);
begin
  with TFCalendarView.Create(Application) do try
    ShowModal;
  finally
    Release;
  end;
  UpdateScheduleGrid;
end;

// ----------------------------------------------------------------
// 90 day regulation
// ----------------------------------------------------------------
procedure TFMain.MMNinetyDaysClick(Sender: TObject);
begin
  with TFNinetyDays.Create(Application) do try
    ShowModal;
  finally
    Release;
  end;
end;

// ----------------------------------------------------------------
// Statistics
// ----------------------------------------------------------------
procedure TFMain.MMStatisticsClick(Sender: TObject);
begin
  with TFStatistics.Create(Application) do
  try
    ShowModal;
  finally
    Release;
  end;
end;

// ----------------------------------------------------------------
// Training barometer
// ----------------------------------------------------------------
procedure TFMain.MMTrainBaroClick(Sender: TObject);
begin
  with TFTrainBaro.Create(Application) do
  try
    ShowModal;
  finally
    Release;
  end;
end;

// ----------------------------------------------------------------
// Licenses
// ----------------------------------------------------------------
procedure TFMain.LicenseClick(Sender: TObject);
begin
  with TFLicenses.Create(Application) do
  try
    ShowModal;
  finally
    Release;
  end;
end;

// ----------------------------------------------------------------
// Printing
// ----------------------------------------------------------------
procedure TFMain.Print(Sender: TObject);
begin
  with TFPrint.Create(Application) do
  try
    ShowModal;
  finally
    Release;
  end;
end;

// ----------------------------------------------------------------
// Manage flight logs
// ----------------------------------------------------------------
procedure TFMain.FlightLogsClick(Sender: TObject);
begin
  with TFFlightLogs.Create(Application) do
  try
    ShowModal;
  finally
    Release;
  end;
  UpdateButtonState;
  CreateSButtons;
end;

// ----------------------------------------------------------------
// Airports
// ----------------------------------------------------------------
procedure TFMain.AirportsClick(Sender: TObject);
begin
  with TFAirports.Create(Application) do
  try
    PanelFindEingabe.Visible := False;
    ShowModal;
  finally
    Release;
  end;
end;

// ----------------------------------------------------------------
// sort all flights
// ----------------------------------------------------------------
procedure TFMain.SortAllFlightsClick(Sender: TObject);
begin
  SortGridByCols([ActiveFlightLog.GridCols.IndexOf('Dat'),ActiveFlightLog.GridCols.IndexOf('StB'),ActiveFlightLog.GridCols.IndexOf('StT')], ActiveFlightLog.Grid);
  ActiveFlightLog.ReCalcGridNr;
end;

// ----------------------------------------------------------------
// Edit flight
// ----------------------------------------------------------------
procedure TFMain.FlightEdit(Sender: TObject);
begin
  FInput.Change(ActiveFlightLog.Grid.Row);
end;

// ----------------------------------------------------------------
// New flight
// ----------------------------------------------------------------
procedure TFMain.FlightNew(Sender: TObject);
begin
  with TFInput.Create(Application) do
  try
    if ActiveFlightLog.Grid.Cells[0,1] = '' then
      Neu(1)
    else
    begin
      ActiveFlightLog.Grid.InsertColRow(False, ActiveFlightLog.Grid.RowCount);
      Neu(ActiveFlightLog.Grid.RowCount-1);
    end;
  finally
  end;
end;

// ----------------------------------------------------------------
// Insert flight
// ----------------------------------------------------------------
procedure TFMain.FlightInsert(Sender: TObject);
begin
  ActiveFlightLog.Grid.InsertColRow(False, ActiveFlightLog.Grid.Row);
  FInput.Neu(ActiveFlightLog.Grid.Row);
  ActiveFlightLog.ReCalcGridNr;
end;

// ----------------------------------------------------------------
// Delete flight
// ----------------------------------------------------------------
procedure TFMain.FlightDelete(Sender: TObject);
begin
  ActiveFlightLog.PUFlugloeschenClick(Self);
end;

// ----------------------------------------------------------------
// Undo delete flight
// ----------------------------------------------------------------
procedure TFMain.FlightDeleteUndo(Sender: TObject);
begin
  ActiveFlightLog.PUloeschrueckClick(Self);
end;

// ----------------------------------------------------------------
// Create SButtons
// ----------------------------------------------------------------
procedure TFMain.CreateSButtons;
var
  i: Word;
begin
  for i:= 0 to FlightLogList.Count -1 do
  begin
    if not Assigned(GridChild(i).SButton) then
    begin
      GridChild(i).SButton := TFSButton.Create(FMain);
      GridChild(i).SButton.Parent := PanelSButtons;

      GridChild(i).SButton.Top := 2;
      GridChild(i).SButton.Width := 94;

      GridChild(i).SButton.PanelSB.ControlStyle := ControlStyle - [csParentBackground];
      GridChild(i).SButton.Panel90.ControlStyle := ControlStyle - [csParentBackground];
      GridChild(i).SButton.PanelT.ControlStyle  := ControlStyle - [csParentBackground];

      //TranslateComponent(GridChild(i).SButton);
    end;
    GridChild(i).SButton.Left := i*94+2;
    GridChild(i).SButton.LabelHeading.Caption := GridChild(i).Caption;
    UpdateSButtons;
  end;
  if FlightLogList.Count > 0 then PanelSButtons.width := FlightLogList.Count*94+4;
  ActivateSButton;
  UpdateSButtons;
end;

// ----------------------------------------------------------------
// Activate SButton
// ----------------------------------------------------------------
procedure TFMain.ActivateSButton;
var
  i: Word;
begin
  if FlightLogList.Count <= 0 then Exit;
  for i:= 0 to FlightLogList.Count -1 do
    if Assigned(GridChild(i).SButton) then
      GridChild(i).SButton.Color := clBtnFace;

  if Assigned(ActiveFlightLog.SButton) then
    ActiveFlightLog.SButton.Color := clFOrange;
end;

// ----------------------------------------------------------------
// SButton CheckSButton
// ----------------------------------------------------------------
procedure TFMain.UpdateSButtons;
var
  FlightTime: String;
  TotalPoints : Real;
  Flights, GridIdx, Row: Word;
begin
  for GridIdx := 0 to FlightLogList.Count -1 do
    if Assigned(GridChild(GridIdx).SButton) then
      with GridChild(GridIdx).SButton do
      begin
        FlightTime := '00:00';;
        Flights := 0;

        if (GridChild(GridIdx).Data['Dat',1] = '') then
          Continue;

        { 90 days }
        for Row := 1 to GridChild(GridIdx).Grid.RowCount -1 do
          if StrToDate(GridChild(GridIdx).Data['Dat',Row]) >= now -90 then
            inc(Flights,StrtoInt(GridChild(GridIdx).Data['NoL',Row]));
        if Flights >= 3 then
          Panel90.Color := clFGreen
        else
          Panel90.Color := clFRed;
        Panel90.Hint := format(('90 Day Regulation')+': '+#13+
          ('In the last 90 days you have %s flights'),[InttoStr(Flights)]);

        { TrainBaro }
        Flights := 0;
        for Row := GridChild(GridIdx).Grid.RowCount-1 downto 1 do
        begin
          if StrToDate(GridChild(GridIdx).Grid.Cells[1,Row]) >= IncMonth(Now,-6) then
          begin
            inc(Flights,StrToInt(GridChild(GridIdx).Data['NoL',Row]));

            FlightTime := CalcTime(GridIdx,FlightTime,Row,Row);
          end;
        end;
        TotalPoints := ((Flights/30)+(TimeToExact(FlightTime))/45)/2;
        if TotalPoints < 1/3 then
        begin
          PanelT.Color := clFRed;
          PanelT.Hint := ('Training Barometer')+': '+#13+
            ('Red Area')+' - '+('Exercise is necessary - Flying can be risky.');
        end;
        if (TotalPoints >= 1/3) and (TotalPoints < 2/3) then
        begin
          PanelT.Color := clFYellow;
          PanelT.Hint := ('Training Barometer')+': '+#13+
            ('Yellow Area')+' - '+('More exercise helpful - Unexpected events could be dangerous');
        end;
        if TotalPoints >= 2/3 then
        begin
          PanelT.Color := clFGreen;
          PanelT.Hint := ('Training Barometer')+': '+#13+
            ('Green Area')+' - '+('The level of exercise is good - but stay cautious!');
        end;
      end;
end;

// ----------------------------------------------------------------
// Load schedules
// ----------------------------------------------------------------
procedure TFMain.UpdateScheduleGrid;
{----------}
  procedure LoadSchedule(Schedule: TSTrings);
  var i: Word;
  begin
    if Schedule.Count > 0 then
      for i := 0 to Schedule.Count-1 do
        if isDate(Schedule.ValueFromIndex[i]) then
        begin
          if GridSched.Cells[0,0] <> '' then
             GridSched.RowCount := GridSched.RowCount + 1;
           GridSched.Cells[0,GridSched.RowCount-1] := Schedule.ValueFromIndex[i];
           GridSched.Cells[1,GridSched.RowCount-1] := Schedule.Names[i];
        end;
  end;
{----------}
var
  GridIdx: Integer;
begin
  Exit;
  if FlightLogList.Count <= 0 then Exit;
  GridSched.RowCount := 1;
  GridSched.Clear;

  with TFLicenses.Create(Application) do
  try
    FillVST;
  finally
    Release;
  end;

  { Load Schedules }
  LoadSchedule(Schedules);
  for GridIdx := 0 to FlightLogList.Count-1 do begin
    LoadSchedule(GridChild(GridIdx).LicenseDates);
    LoadSchedule(GridChild(GridIdx).Events);
  end;
  LoadSchedule(Medicals);
  LoadSchedule(SchedValidity);

  if GridSched.Cells[0,0] = '' then
    PanelScheduler.Visible := False
  else
  begin
    PanelScheduler.Visible := True;
    SortGridByCols([0], GridSched);
  end;
end;

// ----------------------------------------------------------------
// Draw schedule grid
// ----------------------------------------------------------------
procedure TFMain.GridSchedDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  Exit;
  Rect.Top := Rect.Top -1 ;
  with TStringGrid(Sender) do
  begin
    Canvas.Font := Font;
    Canvas.Brush.Color := clBtnFace;
    if GridSched.Cells[0,ARow] <> '' then
    begin
      if MonthsBetween(now, StrToDate(Cells[0, ARow])) <  StrToInt(GenSettings.Values['WarningMonth']) then
        Canvas.Brush.Color := clFYellow;
      if now >= StrToDate(Cells[0, ARow]) then
        Canvas.Brush.Color := clFRed;
    end;
    Canvas.FillRect(Rect);
    DrawText(Canvas.Handle, PChar(Cells[ACol, ARow]), StrLen(PChar(Cells[ACol, ARow])), Rect, DT_LEFT);
  end;
end;

// ----------------------------------------------------------------
// Links to HP
// ----------------------------------------------------------------
procedure TFMain.ActionHPExecute(Sender: TObject);
begin
   OpenDocument(FluPPDomain); { *Converted from ShellExecute* }
end;

procedure TFMain.ActionHPAirportsExecute(Sender: TObject);
begin
   //OpenDocument(PAnsiChar(FluPPDomain+'/airports/'+StrToHTML(GetFileVersion(ParamStr(0))))); { *Converted from ShellExecute* }
end;

procedure TFMain.ActionHPLicensesExecute(Sender: TObject);
begin
   //OpenDocument(PAnsiChar(FluPPDomain+'/licenses/'+StrToHTML(GetFileVersion(ParamStr(0))))); { *Converted from ShellExecute* }
end;

procedure TFMain.ActionHPLanguagesExecute(Sender: TObject);
begin
   //OpenDocument(PAnsiChar(FluPPDomain+'/languages/'+StrToHTML(GetFileVersion(ParamStr(0))))); { *Converted from ShellExecute* }
end;

procedure TFMain.ActionHPRFEExecute(Sender: TObject);
begin
   //OpenDocument(PAnsiChar(FluPPDomain+'/request/'+StrToHTML(GetFileVersion(ParamStr(0))))); { *Converted from ShellExecute* }
end;

procedure TFMain.ActionHPBugsExecute(Sender: TObject);
begin
   //OpenDocument(PAnsiChar(FluPPDomain+'/bug/'+StrToHTML(GetFileVersion(ParamStr(0))))); { *Converted from ShellExecute* }
end;

procedure TFMain.ActionHPSupportExecute(Sender: TObject);
begin
   //OpenDocument(PAnsiChar(FluPPDomain+'/support/'+StrToHTML(GetFileVersion(ParamStr(0))))); { *Converted from ShellExecute* }
end;

procedure TFMain.ActionResetColumnsExecute(Sender: TObject);
begin
  if ActionResetColumns.Checked then
    ActionResetColumns.Checked := false
  else begin
    MessageDlg('Please save your flightlog and restart FliPS so that'+#13+#10+'restoring of default column values can take place.', mtInformation, [mbOK], 0);
    ActionResetColumns.Checked := true;
  end;
end;

procedure TFMain.ActionFileImportExecute(Sender: TObject);
begin
  OpenDialog.Filter := ('Comma-Separated Variables')+' (*.csv)'+'|*.csv';
  if not OpenDialog.Execute then Exit;
  ImportCSV(OpenDialog.FileName);
  InsertData;
end;

end.
