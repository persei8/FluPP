unit FlightLog;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, SysUtils, Classes, Graphics, Controls, Dialogs,
  Grids, Menus, Buttons, SButton, LazLogger, TATransformations;

type

  { TFlightLog }

  TFlightLog = class
  private
    function GetData(Name: String; Row: Word): String;
    procedure SetData(Name: String; Row: Word; Value: String);
    procedure GridColsPopup;
    procedure PopupMenuColsClick(Sender: TObject);
    procedure KatAddClick(Sender: TObject);
    procedure KatRemClick(Sender: TObject);
    procedure FilesClick(Sender: TObject);
  public
    Settings: TSTringList;
    ACAircrafts,
    ACPilots,
    ACAirports,
    ACCategories,
    ACTimeCat,
    ACContestCat,
    ACEventCat : TSTringList;
    LicenseCategories,
    LicenseTimeCat,
    LicenseDates,
    AccLicenses,
    OptConditions,
    Events : TSTringList;
    GridCols: TSTringList;
    Undo: Array of String;
    SButton: TFSButton;
    Grid: TStringGrid;
    Caption: String;
    constructor Create;
    destructor Destroy;
    property Data[Name: String; Row: Word]: String read GetData write SetData;
    procedure ReCalcGridNr;
    procedure ReCalcGridtime;
    procedure NameCols;
    procedure CheckCols;
    procedure SetColWidth(S: String);
    function KeyInKat(Key: String; Kat: String; Row: Word): Boolean; overload;
    function KeyInKat(key: String; Kat: String; Row: Word; var Value: Array of String): Boolean; overload;


    procedure GridMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure GridDblClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure PUFlugloeschenClick(Sender: TObject);
    procedure PULoeschRueckClick(Sender: TObject);

    procedure GridColumnMoved(Sender: TObject; FromIndex,
      ToIndex: Integer);
    procedure GridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure GridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
  end;


implementation

uses Main, Input, Tools, ToolsGrid, Export;

{
Num: Flight number
Dat: Date
ATy: Aircraft type
AId: Aircraft registration
Pi1: Pilot
Pi2: CoPilot
Pas: Passengers
ToS: Start kind
StT: Start time
LaT: Landing time
FlT: Flight time
StB: Block off (BOf)
LaB: Block on (BOn)
BlT: Block time
NoL: # of landings
StL: Start airport
LaL: Landing airport
Rem: Remarks
Dst: Distance
Cat: Kategory
Via: Airports
CTi: Time Categoriess
Fil: Files
Con: Contest
CfF: Costs for flight
LaF: Landing fees
CfC: Costs for crew
EfF: Earnings for flight
Met: Meteo-Information
}

// ----------------------------------------------------------------
// From create
// ----------------------------------------------------------------
constructor TFlightLog.Create;
begin
  Inherited;

  ACAircrafts := TStringList.Create;
  ACPilots := TStringList.Create;
  ACAirports := TStringList.Create;

  ACCategories := TStringList.Create;
  ACTimeCat := TStringList.Create;
  ACEventCat := TStringList.Create;
  ACContestCat := TStringList.Create;

  GridCols := TStringList.Create;
  Settings := TStringList.Create;

  OptConditions := TStringList.Create;
  LicenseCategories := TStringList.Create;
  LicenseTimeCat := TStringList.Create;
  LicenseDates := TStringList.Create;
  AccLicenses := TStringList.Create;

  Events := TStringList.Create;

  Grid := TStringGrid.Create(FMain);
end;

// ----------------------------------------------------------------
// Form destroy
// ----------------------------------------------------------------
destructor TFlightLog.Destroy;
begin
  FreeObjStringList(AcAircrafts);
  FreeObjStringList(ACPilots);
  FreeObjStringList(ACAirports);

  FreeObjStringList(ACCategories);
  FreeObjStringList(ACTimeCat);
  FreeObjStringList(ACEventCat);
  FreeObjStringList(ACContestCat);

  GridCols.Free;
  Settings.Free;

  OptConditions.Free;
  LicenseCategories.Free;
  LicenseTimeCat.Free;
  LicenseDates.Free;
  AccLicenses.Free;

  Events.Free;
  Inherited;
end;

// ----------------------------------------------------------------
// Read table row
// ----------------------------------------------------------------
function TFlightLog.GetData(Name: String; Row: Word): String;
var
  Index: Integer;
begin
  if not Assigned(GridCols) then
  begin
    Result := '';
    Exit;
  end;
  Index := GridCols.IndexOf(Name);
  if Index = -1 then
  begin
    Result := '';
    Exit;
  end;
  Result := Grid.Cells[Index,Row];
end;

// ----------------------------------------------------------------
// write table row
// ----------------------------------------------------------------
procedure TFlightLog.SetData(Name: String; Row: Word; Value: String);
var
  Index: Integer;
begin
  Index := GridCols.IndexOf(Name);
  if Index = -1 then Exit;
  Grid.Cells[Index, Row] := Value;
end;

// ----------------------------------------------------------------
// Mouse down: DblClick
// ----------------------------------------------------------------
procedure TFlightLog.GridMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  Col,Row: Integer;
begin
  //Grid.MouseToCell(X,Y,Col,Row);
  //
  //if (Row > 0) and (data['Num',1] <> '') and (ssDouble in Shift) then
  //  if (FInput.CanEdit(true)) then FInput.Change(Grid.Row);
end;

// ----------------------------------------------------------------
// Fill GridCols popup menu
// ----------------------------------------------------------------
procedure TFlightLog.GridColsPopup;
var
  GridColsMenuItem: TMenuItem;
  i: Word;
begin
  //PopupMenuCols.Items.Clear;
  //for i := 1 to Grid.ColCount-1 do
  //begin
  //  GridColsMenuItem := TMenuItem.create(self);
  //  GridColsMenuItem.Name := 'GridCols'+InttoStr(i);
  //  GridColsMenuItem.Caption := Grid.Cells[i,0];
  //  GridColsMenuItem.Checked := Grid.ColWidths[i] > -1;
  //  GridColsMenuItem.OnClick := PopupMenuColsClick;
  //  PopupMenuCols.Items.Add(GridColsMenuItem);
  //end;
end;

// ----------------------------------------------------------------
// Hide / unhide GridCol
// ----------------------------------------------------------------
procedure TFlightLog.PopupMenuColsClick(Sender: TObject);
var
  GridCol: Word;
begin
  //GridCol := TMenuItem(Sender).MenuIndex+1;
  //if Sender = PopupMenuCols then
  //  Exit;
  //if TMenuItem(Sender).Checked then
  //  Grid.ColWidths[GridCol] := -1
  //else
  //  Grid.ColWidths[GridCol] := Grid.DefaultColWidth;
end;

// ----------------------------------------------------------------
// Mouse up: Popup Menu
// ----------------------------------------------------------------
procedure TFlightLog.GridMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  Col,Row: Integer;
  GridRect: TGridRect;
  KatAddMenuItem: TMenuItem;
  KatRemMenuItem: TMenuItem;
  FilesMenuItem: TMenuItem;
  i, Idx: Word;
  TempStr: String;
begin
  GridREct := Grid.Selection;
  //Grid.MouseToCell(X,Y,Col,Row);
  if (Row = 0) and (Button = mbRight) then
  begin
    GridColsPopup;
    //PopupMenuCols.Popup(Mouse.CursorPos.x,Mouse.CursorPos.Y);
    Exit;
  end;
  if Row <= 0 then
    Exit;
  { Only one col selected }
  if GridRect.Top = GridRect.Bottom then
  begin
    if (Grid.RowCount > 2) and (data['Num',1] <> '') then
      if Button = mbLeft then
        FMain.StatusBar1.Panels[1].Text :=
          format(('To flight %s: %s h [%s h], %s flights'), [
            Data['Num',Row],
            CalcTime(0,Settings.Values['BFTime'],1,Row,1),
            CalcTime(0,Settings.Values['BFTime'],1,Row,0),
            InttoStr(CalcFlights(0,StrToInt(Settings.Values['BFStarts']),1,Row))
          ]);
    Grid.Row := Row;

    if (Row > 0) and (Col > 0) and (Button = mbRight) then
      FMain.UpdateButtonState;
  end
  { several cols selected }
  else
  begin
    if Button = mbRight then
    begin
      //PUFlightEdit.Enabled := False;
      //PUFlugEinfuegen.Enabled := False;
      //PUFlugloeschen.Enabled := False;
    end;
    if button = mbleft then
      FMain.StatusBar1.Panels[1].Text :=
        format(('From flight %s to %s: %s h [%s h], %s flights'), [
          Data['Num',GridRect.Top], Data['Num',GridRect.Bottom],
          CalcTime(0,Settings.Values['BFTime'],GridRect.Top,GridRect.Bottom,1),
          CalcTime(0,Settings.Values['BFTime'],GridRect.Top,GridRect.Bottom,0),
          InttoStr(CalcFlights(0,StrToInt(Settings.Values['BFStarts']),GridRect.Top,GridRect.Bottom))
        ]);
  end;
  { Context menu }
  if button = mbRight then
  begin
  { Categories }
    //KatAdd.Clear;
    //KatRem.Clear;
    //if ACCategories.Count > 0 then
    //for i := 0 to ACCategories.Count-1 do
    //begin
    //  KatAddMenuItem := TMenuItem.create(self);
    //  KatAddMenuItem.Name := 'KatAdd'+InttoStr(i);
    //  KatAddMenuItem.Caption := ACCategories[i];
    //  KatAddMenuItem.OnClick := KatAddClick;
    //  KatAdd.Add(KatAddMenuItem);
    //
    //  KatRemMenuItem := TMenuItem.create(self);
    //  KatRemMenuItem.Name := 'KatRem'+InttoStr(i);
    //  KatRemMenuItem.Caption := ACCategories[i];
    //  KatRemMenuItem.OnClick := KatRemClick;
    //  KatRem.Add(KatRemMenuItem);
    //end;
    //{ Files }
    //TempStr := ''; Idx := 0;
    //PUFiles.Clear;
    //if length(TFlightLog(FMain.ActiveMDIChild).data['Fil',Row]) = 0 then
    //  PUFiles.Enabled := False
    //else
    //for i := 1 to length(TFlightLog(FMain.ActiveMDIChild).data['Fil',Row]) do
    //if (TFlightLog(FMain.ActiveMDIChild).data['Fil',Row][i] = ',') then
    //begin
    //  FilesMenuItem := TMenuItem.create(self);
    //  FilesMenuItem.Name := 'Files'+InttoStr(Idx);
    //  FilesMenuItem.Caption := TempStr;
    //  FilesMenuItem.OnClick := FilesClick;
    //  PUFiles.Add(FilesMenuItem);
    //  TempStr := '';
    //end
    //else TempStr := TempStr + TFlightLog(FMain.ActiveMDIChild).data['Fil',Row][i];
    //
    //PopupMenu.Popup(Mouse.CursorPos.x,Mouse.CursorPos.Y);
  end;
end;

// ----------------------------------------------------------------
// Add Category
// ----------------------------------------------------------------
procedure TFlightLog.KatAddClick(Sender: TObject);
var
  GridRect: TGridRect;
  Row: Word;
begin
  GridREct := Grid.Selection;
  for Row := GridRect.Top to GridRect.Bottom do
  begin
    if pos(TMenuItem(Sender).Caption+'/',data['Cat',Row]) = 0 then
    begin
      data['Cat',Row] := data['Cat',Row] + TMenuItem(Sender).Caption+'/';
      DataChanged := True;
    end;
  end;
end;

// ----------------------------------------------------------------
// Remove Category
// ----------------------------------------------------------------
procedure TFlightLog.KatRemClick(Sender: TObject);
var
  GridRect: TGridRect;
  Row, PosIdx: Word;
  TmpStr: String;
begin
  GridREct := Grid.Selection;
  for Row := GridRect.Top to GridRect.Bottom do
  begin
    if length(data['Cat',Row]) > 0 then
    begin
      PosIdx := pos(TMenuItem(Sender).Caption+'/',data['Cat',Row]);
      if PosIdx > 0 then
      begin
          //TmpStr := TFlightLog(FMain.ActiveMDIChild).data['Cat',Row];
          //delete(TmpStr,PosIdx,length(TMenuItem(Sender).Caption)+1);
          //TFlightLog(FMain.ActiveMDIChild).data['Cat',Row] := TmpStr;
          //DataChanged := True;
      end;
    end;
  end;
end;

// ----------------------------------------------------------------
// execute file
// ----------------------------------------------------------------
procedure TFlightLog.FilesClick(Sender: TObject);
var FileName: String;
begin
  FileName := TMenuItem(Sender).Caption;
   OpenDocument(PChar(FileName)); { *Converted from ShellExecute* }
end;

// ----------------------------------------------------------------
// Form activate
// ----------------------------------------------------------------
procedure TFlightLog.FormActivate(Sender: TObject);
begin
  if DataChanged = True then FMain.StatusBar1.Panels[2].Text := '*'
  else FMain.StatusBar1.Panels[2].Text := '';

  FMain.UpdateButtonState;

  ReCalcGridTime;
  FMain.ActivateSButton;
end;

// ----------------------------------------------------------------
// Edit flight
// ----------------------------------------------------------------
procedure TFlightLog.GridDblClick(Sender: TObject);
var
  mousePoint: TPoint;
  col, row: Integer;
begin
  mousePoint := Mouse.CursorPos;
  Grid.MouseToCell(mousePoint.X-FMain.Left, mousePoint.Y-FMain.Top,Col,Row);

  FMain.UpdateButtonState;
  if (Data['Num',1] <> '') and (Row > 0) then
    if (FInput.CanEdit(true)) then FInput.Change(Grid.Row);
end;

// ----------------------------------------------------------------
// Delete flight
// ----------------------------------------------------------------
procedure TFlightLog.PUFlugloeschenClick(Sender: TObject);
var i: Integer;
begin
  SetLength(Undo, Grid.ColCount);
  Undo[0] := InttoStr(Grid.Row);

  for i := 1 to Grid.ColCount-1 do begin
    Undo[i] := Grid.Cells[i,Grid.Row];
  end;

  if (StrToBool(Settings.Values['DisallowChange'])) then begin
    if Grid.Cells[GridCols.IndexOf('Del'), Grid.Row] > '' then begin
      for i := 0 to Grid.ColCount-1 do Undo[i] := ''; exit;
    end;

    Grid.Cells[GridCols.IndexOf('Del'), Grid.Row] := DateToStr(Now());

    for i := 0 to Grid.ColCount-1 do
      Grid.Cells[i, Grid.Row] := Grid.Cells[i, Grid.Row];
  end else begin
    if Grid.RowCount > 2 then
      Grid.DeleteRow(Grid.Row)
    else
      for i := 0 to Grid.ColCount-1 do
        Grid.Cells[i,1] := '';
  end;

  FMain.InsertData;

  DataChanged := True;
  FMain.StatusBar1.Panels[2].Text := '*';
end;

// ----------------------------------------------------------------
// Undo delete
// ----------------------------------------------------------------
procedure TFlightLog.PUloeschrueckClick(Sender: TObject);
var
  i: Integer;
begin
  if (StrToBool(Settings.Values['DisallowChange'])) then begin
    Grid.Cells[GridCols.IndexOf('Del'), StrToInt(Undo[0])] := '';

    for i := 0 to Grid.ColCount-1 do
      Grid.Cells[i, StrToInt(Undo[0])] := Grid.Cells[i, StrToInt(Undo[0])];
  end
  else begin
    if FMain.ActiveFlightLog.Data['Num',1] <> '' then
    Grid.InsertColRow(False, StrToInt(Undo[0]));

    for i := 0 to Grid.ColCount-1 do
      Grid.Cells[i,StrToInt(Undo[0])] := Undo[i];
  end;

  for i := 0 to Grid.ColCount-1 do Undo[i] := '';

  FMain.InsertData;
end;

// ----------------------------------------------------------------
// Col moving
// ----------------------------------------------------------------
procedure TFlightLog.GridColumnMoved(Sender: TObject; FromIndex,
  ToIndex: Integer);
begin
  GridCols.Move(FromIndex,ToIndex);
end;

// ----------------------------------------------------------------
// Grid Colorbands
// ----------------------------------------------------------------
procedure TFlightLog.GridDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var Alignment: TAlignment;
begin
  Alignment := taLeftJustify;
  Grid.Canvas.Font.Style := [];

  if not (gdFixed in State) then
  begin
    if ACol = GridCols.IndexOf('Num') then Alignment := taRightJustify;
    if ACol = GridCols.IndexOf('NoL') then Alignment := taRightJustify;
    if ACol = GridCols.IndexOf('Dst') then Alignment := taRightJustify;
    if ACol = GridCols.IndexOf('StT') then Alignment := taRightJustify;
    if ACol = GridCols.IndexOf('LaT') then Alignment := taRightJustify;
    if ACol = GridCols.IndexOf('FlT') then Alignment := taRightJustify;
    if ACol = GridCols.IndexOf('StB') then Alignment := taRightJustify;
    if ACol = GridCols.IndexOf('LaB') then Alignment := taRightJustify;
    if ACol = GridCols.IndexOf('BlT') then Alignment := taRightJustify;
    if ACol = GridCols.IndexOf('Pas') then Alignment := taRightJustify;

    if ACol = GridCols.IndexOf('CfF') then Alignment := taRightJustify;
    if ACol = GridCols.IndexOf('LaF') then Alignment := taRightJustify;
    if ACol = GridCols.IndexOf('CfC') then Alignment := taRightJustify;
    if ACol = GridCols.IndexOf('EfF') then Alignment := taRightJustify;

    if ACol = GridCols.IndexOf('AId') then Alignment := taCenter;
    if ACol = GridCols.IndexOf('ATy') then Alignment := taCenter;
    if ACol = GridCols.IndexOf('ToS') then Alignment := taCenter;
    if ACol = GridCols.IndexOf('StL') then Alignment := taCenter;
    if ACol = GridCols.IndexOf('LaL') then Alignment := taCenter;

    try Grid.Canvas.Font.Style := [];
      if Grid.Cells[GridCols.IndexOf('Del'), ARow] > '' then
      Grid.Canvas.Font.Style := [fsStrikeOut];
    except end;
  end;

  DrawColorbands(Grid, ACol, ARow, Rect, State, Alignment);
end;

// ----------------------------------------------------------------
// Renumber flightlog
// ----------------------------------------------------------------
procedure TFlightLog.ReCalcGridNr;
var i: Integer;

  procedure RenumberFile(Actual, New : String);
  var ActualDirName : string;
  begin
    if ((Actual = '') or (Actual = New)) then Exit;

    If DirectoryExists(FlpTempDir+'\Files\~'+Actual) then
      ActualDirName := FlpTempDir+'\Files\~'+Actual
    else ActualDirName := FlpTempDir+'\Files\'+Actual;

    If DirectoryExists(ActualDirName) then begin
      if DirectoryExists(FlpTempDir+'\Files\'+New) then
        RenameFile(FlpTempDir+'\Files\'+New, FlpTempDir+'\Files\~'+New);
      RenameFile(ActualDirName, FlpTempDir+'\Files\'+New);
    end;
  end;

begin
  if Data['Dat',1] = '' then Exit;

  if Settings.Values['Numeration'] = '1' then
  { Start number }
  begin
    Data['Num',1] := InttoStr(StrtoInt(Settings.Values['BFStarts']) +1);
    if Grid.RowCount > 2 then
      for i:= 2 to Grid.RowCount-1 do begin
        RenumberFile(Data['Num',i], IntToStr(StrToInt(Data['Num',i-1]) + StrToInt(Data['NoL',i-1])));
        Data['Num',i] := InttoStr(StrToInt(Data['Num',i-1]) + StrToInt(Data['NoL',i-1]));
      end;
  end
  { Contiunous }
  else for i:= 1 to Grid.RowCount-1 do begin
    RenumberFile(Data['Num',i], IntToStr(i+StrtoInt(Settings.Values['BFStarts'])));
    Data['Num',i] := InttoStr(i+StrToInt(Settings.Values['BFStarts']));
  end;
end;

// ----------------------------------------------------------------
// Calc over-all time
// ----------------------------------------------------------------
procedure TFlightLog.ReCalcGridtime;
begin
  if Data['Dat',1] = '' then Exit;

  FMain.StatusBar1.Panels[0].Text :=
    format(('Over-all: %s flights, %s: %s h, %s: %s h'), [
      IntToStr(CalcFlights(0, StrToInt(Settings.Values['BFStarts']), 1, Grid.RowCount-1)),
      ('Flight time'),
      CalcTime(0, Settings.Values['BFTime'], 1, Grid.RowCount-1, 1),
      ('Block time'),
      CalcTime(0, Settings.Values['BFTime'], 1, Grid.RowCount-1, 0)
    ]);
end;

// ----------------------------------------------------------------
// Name table cols
// ----------------------------------------------------------------
procedure TFlightLog.NameCols;
begin
  Data['Num',0] := ('Nr.');
  Data['Dat',0] := ('Date');
  Data['ATy',0] := ('Type');
  Data['AId',0] := ('ID');

  Data['Pi1',0] := ('Pilot');
  Data['Pi2',0] := ('Copilot');
  Data['Pas',0] := ('Passengers');

  Data['StT',0] := ('Dep.');
  Data['LaT',0] := ('Arr.');
  Data['FlT',0] := ('Fl. Time');

  Data['StB',0] := ('Block off');
  Data['LaB',0] := ('Block on');
  Data['BlT',0] := ('Bl. Time');

  Data['NoL',0] := ('Ld.');
  Data['StL',0] := ('From');
  Data['LaL',0] := ('To');
  Data['Rem',0] := ('Remarks');
  Data['Dst',0] := ('Distance');
  Data['Cat',0] := ('Category');
  Data['Via',0] := ('Via');
  Data['CTi',0] := ('Times');
  Data['Fil',0] := ('File');
  Data['Con',0] := ('Contest');
  Data['ToS',0] := ('Type of start');

  Data['Met',0] := ('Weather');

  Data['CfF',0] := GenSettings.Values['Currency']+'-'+('Aircraft');
  Data['LaF',0] := GenSettings.Values['Currency']+'-'+('Ld.-fees');
  Data['CfC',0] := GenSettings.Values['Currency']+'-'+('Crew');
  Data['EfF',0] := GenSettings.Values['Currency']+'-'+('Earnings');

  Data['Del',0] := ('Deleted');
end;

// ----------------------------------------------------------------
// Check if all cols exist
// ----------------------------------------------------------------
procedure TFlightLog.CheckCols;
var
  TmpGridCols: TStringList;
  i: Word;
begin
  TmpGridCols := TStringList.Create;
  try
    ReadTStrings(DefaultTableCols, TmpGridCols);

    { Add Rows }
    for i := 0 to TmpGridCols.Count-1 do
      if GridCols.IndexOf(TmpGridCols[i]) = -1 then
        GridCols.Add(TmpGridCols[i]);

    { Remove Rows }
     for i := GridCols.Count-1 downto 0 do
       if TmpGridCols.IndexOf(GridCols[i]) = -1 then
         GridCols.Delete(i);
  finally
    TmpGridCols.Free;
  end;
end;

// ----------------------------------------------------------------
// Set column width
// ----------------------------------------------------------------
procedure TFlightLog.SetColWidth(S: String);
var
  Cell: String;
  i,Col: Word;
begin
  i := 1;
  Col := 0;
  while (i < length(S)) and (Grid.ColCount > Col) do
  begin
    Cell := '';
    if S <> '' then
    begin
      while (S[i] <> ';') and (i < length(S)) do
      begin
        Cell := Cell + S[i];
        inc(i);
      end;
      Grid.ColWidths[Col] := StrtoInt(Cell);
      inc(i);
      inc(Col);
    end;
  end;
end;

// ----------------------------------------------------------------
// Checks if key is in Kat
// ----------------------------------------------------------------
function TFlightLog.KeyInKat(Key: String; Kat: String; Row: Word): Boolean;
var
  TempStr: String;
  i: Word;
  klength: Word;
begin
  Result := False;
  klength := length(Data[Kat,Row]);
  for i := 1 to klength do
  begin
    if (Data[Kat,Row][i] = '/')
      or (i = klength) then
    begin
      If TempStr = Key then
      begin
        Result := True;
        Exit;
      end;
      TempStr := '';
    end
    else TempStr := TempStr + Data[Kat,Row][i];
  end;
  if Key = '' then
    Result := True;
end;

// ----------------------------------------------------------------
// Checks if key is in kat, var value
// ----------------------------------------------------------------
function TFlightLog.KeyInKat(Key: String; Kat: String; Row: Word; var Value: Array of String): Boolean;
var
  i, ValueNum: word;
  TempStr: String;
begin
  result := False;
  value[0] := '';
  value[1] := '';
  valueNum := 0;
  for i := 1 to length(Data[Kat,Row]) do
  begin
    if Data[Kat,Row][i] = '|' then
    begin
      if Result = True then
      begin
        Value[valueNum] := tempStr;
        inc(valueNum);
        tempStr := '';
      end;
      if (valueNum = 0) then
      begin
        If Key = tempStr then Result := True;
        tempStr := '';
      end
    end
    else if Data[Kat,Row][i] = '/' then
    begin
      if Result = True then
      begin
        Value[valueNum] := tempStr;
        exit;
      end;
      tempStr := '';
    end
    else tempStr := tempStr + Data[Kat,Row][i];
  end;
end;

end.
