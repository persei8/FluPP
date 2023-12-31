unit Statistics;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, DateTimePicker,
  CheckLst, Grids, Math, ImgList, StrUtils;

type TTrendType = (ttYear, ttMonth, ttWeek, ttNone);

type

  TKat = array of record
    Name: String;
    Value: String;
    Value2: String;
  end;
  
  TStatStruct = class(TObject)
  private
    Name: String;
    Flights: Word;
    Time: String;
    Passengers: Word;
    F,W,E,A,G: Word;
    Distance: Real;
    LastStart : String;
    DistanceTime: String;
    CfF, CfC, LaF, EfF : Real;
    Kat: TKat;
    CTime: TKat;
    Contest: TKat;
  end;
  TSTatTrendData = class(TStatStruct)
  private
    TrendData: array of TStatStruct;
  end;
  TSTatData = class(TStatTrendData)
  private
    StatItems: array of TStatTrendData;
    procedure Add;
    constructor Create;
  end;

  TFStatistics = class(TForm)
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    PageControlStat: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel5: TPanel;
    SGDetail: TStringGrid;
    CBDetail: TComboBox;
    TsStart: TTabSheet;
    BitBtn2: TBitBtn;
    PanelFoundFlights: TPanel;
    Label26: TLabel;
    Label21: TLabel;
    LabelFrom: TLabel;
    Label22: TLabel;
    LabelTo: TLabel;
    Panel3: TPanel;
    Bevel13: TBevel;
    GroupBox1: TGroupBox;
    Label14: TLabel;
    LabelSName: TLabel;
    Label1: TLabel;
    LabelAlleine: TLabel;
    Label2: TLabel;
    LabelBegleiter: TLabel;
    Label8: TLabel;
    LabelGesamt: TLabel;
    Label9: TLabel;
    LabelDurchn: TLabel;
    LabelGesamt2: TLabel;
    Label17: TLabel;
    LabelPIC: TLabel;
    Label39: TLabel;
    LabelPassenger: TLabel;
    GroupBox2: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    LabelWinde: TLabel;
    LabelFSch: TLabel;
    LabelEigen: TLabel;
    Label10: TLabel;
    LabelGenFlights: TLabel;
    LabelFluege2: TLabel;
    Label19: TLabel;
    LabelAuto: TLabel;
    LabelGummi: TLabel;
    Label35: TLabel;
    GroupBox3: TGroupBox;
    CBKatGen: TComboBox;
    GridKatG: TStringGrid;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    Label31: TLabel;
    LabelGStrecke: TLabel;
    LabelGDGeschw: TLabel;
    Label33: TLabel;
    Label25: TLabel;
    LabelPassengers: TLabel;
    Label36: TLabel;
    LabelAvPassengers: TLabel;
    GroupBox7: TGroupBox;
    ButtonGraphGesamt: TBitBtn;
    ButtonTabGesamt: TBitBtn;
    GroupBox6: TGroupBox;
    ButtonTabDetail: TBitBtn;
    ButtonGraphDetail: TBitBtn;
    GroupBox8: TGroupBox;
    Label27: TLabel;
    Label28: TLabel;
    LabelSW: TLabel;
    Label29: TLabel;
    LabelSF: TLabel;
    LabelSE: TLabel;
    Label18: TLabel;
    LabelSA: TLabel;
    LabelSG: TLabel;
    Label20: TLabel;
    Label12: TLabel;
    LabelSGesStart: TLabel;
    GroupBox9: TGroupBox;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    TCSum: TLabel;
    TCEfF: TLabel;
    TCLaF: TLabel;
    TCCfC: TLabel;
    TCCfF: TLabel;
    GroupBox10: TGroupBox;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    SCCfF: TLabel;
    SCCfC: TLabel;
    SCLaF: TLabel;
    SCEfF: TLabel;
    SCSum: TLabel;
    Label40: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    LabelSDurchn: TLabel;
    LabelSGesZeit: TLabel;
    GroupBox11: TGroupBox;
    Label30: TLabel;
    LabelSStrecke: TLabel;
    Label32: TLabel;
    LabelSDGeschw: TLabel;
    Label34: TLabel;
    Label38: TLabel;
    LabelSDPassengers: TLabel;
    LabelSDAvPassengers: TLabel;
    LastStart: TLabel;
    GroupBox12: TGroupBox;
    CBKatDetail: TComboBox;
    GridKatDetail: TStringGrid;
    GroupBox13: TGroupBox;
    CBTopListDetail: TComboBox;
    GridTopDetail: TStringGrid;
    GroupBox14: TGroupBox;
    CBTopListGen: TComboBox;
    GridTopG: TStringGrid;
    RGDistUnit: TRadioGroup;
    RGDefaultTime: TRadioGroup;
    CBTrendGen: TComboBox;
    CBTrendDetail: TComboBox;
    GroupBox15: TGroupBox;
    LBFlu: TListBox;
    GroupBox16: TGroupBox;
    Bevel18: TBevel;
    Label4: TLabel;
    Label3: TLabel;
    PanelSchein: TPanel;
    PanelJahre: TPanel;
    CBJFrom: TComboBox;
    CBJTo: TComboBox;
    PanelStarts: TPanel;
    CBStFrom: TEdit;
    CBStTo: TEdit;
    RBJahre: TRadioButton;
    RBStarts: TRadioButton;
    RBSchein: TRadioButton;
    RBDatum: TRadioButton;
    PanelDatum: TPanel;
    CBDateFrom: TDateTimePicker;
    CBDateTo: TDateTimePicker;
    GroupBox17: TGroupBox;
    Label24: TLabel;
    CLBKat: TCheckListBox;
    Panel4: TPanel;
    RBKatAnd: TRadioButton;
    RBKatOr: TRadioButton;
    CheckBox1: TCheckBox;
    LabelFoundFlights: TLabel;
    LabelCalcTime: TLabel;
    Label15: TLabel;
    procedure ButtonStatStartClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CBJFromChange(Sender: TObject);
    procedure CBJToChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RBClick(Sender: TObject);
    procedure CBDateExit(Sender: TObject);
    procedure LBFluClick(Sender: TObject);
    procedure ButtonJVClick(Sender: TObject);
    procedure DetailChange(Sender: TObject);
    procedure CLBKatClickCheck(Sender: TObject);
    procedure CBKatGenChange(Sender: TObject);
    procedure CBKatDetailChange(Sender: TObject);
    procedure SGDetailSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure SGDetailGetCellAlignment(Sender: TStringGrid; AColumn, ARow: Integer; State: TGridDrawState; var CellAlignment: TAlignment);
    procedure FormCreate(Sender: TObject);
    procedure GridKatDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
  private
    SGDetailRow : Integer;
    PStatData: ^TStatData;
    GSNr: Word;
    Aircraft: TStatData;
    CoPilot: TStatData;
    Pilot: TStatData;
    AircraftID: TStatData;
    Startort: TStatData;
    Landeort: TStatData;
    TrendData: TStatData;
    CTime: TKat;
    Kat: TKat;
    Contest: TKat;
    procedure CalcStats(TrendType: TTrendType);
    procedure DrawTab;
    procedure ClearDetail;
    procedure FillSGDetail(Data: TStatData);
    function FindInKat(var Kat: TKat; Value: String):Word;
    function FindKat(KatName: String; Kat: TKat):Integer;
  public
    procedure DrawGraph;
    procedure onHint(Sender: TObject);
end;

var
  FStatistics: TFStatistics;

  StartYear, Years: Word;
  DGraphData: array of TStatStruct;
  StatDistUnit: String;
  LastTrendType: TTrendType;

implementation

uses Main, Settings, StatGraph, Tools, ToolsGrid;

{$R *.lfm}

// ----------------------------------------------------------------
// Functions for TSTatData
// ----------------------------------------------------------------
constructor TSTatData.Create;
begin
  inherited Create;
end;

procedure TSTatData.Add;
begin

end;


// ----------------------------------------------------------------
// Form Create
// ----------------------------------------------------------------
procedure TFStatistics.FormCreate(Sender: TObject);
begin
  //TranslateComponent(Self);
  CBKatGen.ItemIndex := 0;
  CBKatDetail.ItemIndex := 0;
  CBTopListGen.ItemIndex := 0;
  CBTopListDetail.ItemIndex := 0;
  CBTrendDetail.ItemIndex := 0;
  CBTrendGen.ItemIndex := 0;
  GridKatG.Selection := DeselectRect;
  GridKatDetail.Selection := DeselectRect;
  CBDetail.ItemIndex := 0;
end;

// ----------------------------------------------------------------
// Form show
// ----------------------------------------------------------------
procedure TFStatistics.FormShow(Sender: TObject);
var
  i,j: Word;
begin
  Application.OnHint := onHint;
  PageControlStat.TabIndex := 0;
  PanelFoundFlights.Visible := False;

  { costs }
  SCCfF.Caption := '0'+DecimalSeparator+'00 '+GenSettings.Values['Currency'];
  SCCfC.Caption := '0'+DecimalSeparator+'00 '+GenSettings.Values['Currency'];
  SCLaF.Caption := '0'+DecimalSeparator+'00 '+GenSettings.Values['Currency'];
  SCEfF.Caption := '0'+DecimalSeparator+'00 '+GenSettings.Values['Currency'];
  SCSum.Caption := '0'+DecimalSeparator+'00 '+GenSettings.Values['Currency'];

  TCCfF.Caption := '0'+DecimalSeparator+'00 '+GenSettings.Values['Currency'];
  TCCfC.Caption := '0'+DecimalSeparator+'00 '+GenSettings.Values['Currency'];
  TCLaF.Caption := '0'+DecimalSeparator+'00 '+GenSettings.Values['Currency'];
  TCEfF.Caption := '0'+DecimalSeparator+'00 '+GenSettings.Values['Currency'];
  TCSum.Caption := '0'+DecimalSeparator+'00 '+GenSettings.Values['Currency'];

  { general }
  LabelGenFlights.Caption := '0';
  LabelWinde.Caption := '0';
  LabelFSch.Caption := '0';
  LabelEigen.Caption := '0';
  LabelAuto.Caption := '0';
  LabelGummi.Caption := '0';
  LabelGesamt.Caption := '00:00';
  LabelGesamt2.Caption := '';
  LabelFluege2.Caption := '';
  LabelFrom.Caption := '';
  LabelTo.Caption := '' ;
  LabelPIC.Caption := '00:00';
  LabelAlleine.Caption := '00:00';
  LabelBegleiter.Caption := '00:00';
  LabelDurchn.Caption := '00:00';
  LabelCalcTime.Caption := '';

  CBDateFrom.Date := now();
  CBDateTo.Date := now();

  { grids }
  GridKatG.ColWidths[0] := 75;
  GridKatG.ColWidths[1] := 60;
  GridKatG.ColWidths[2] := 60;
  GridKatG.Cells[0,0]  := '';
  GridKatG.Cells[1,0]  := '';
  GridKatG.Cells[2,0]  := '';

  GridKatDetail.ColWidths[0] := 75;
  GridKatDetail.ColWidths[1] := 60;
  GridKatDetail.ColWidths[2] := 60;
  GridKatDetail.Cells[0,0]  := '';
  GridKatDetail.Cells[1,0]  := '';
  GridKatDetail.Cells[2,0]  := '';

  ClearDetail;

  for i := 0 to 5 do
    for j := 1 to SGDetail.RowCount do SGDetail.Cells[i,j] := '';
  SGDetail.RowCount := 2;

  //TODO SGDetail.HideCol(0);
  //TODO for i := 4 to 17 do SGDetail.HideCol(i);

  SGDetail.RowHeights[0] := 20;
  SGDetail.Cells[1,0]  := CBDetail.Text;
  SGDetail.Cells[2,0]  := ('Time');
  SGDetail.Cells[3,0]  := ('Flights');
  SGDetail.ColWidths[1] := 100;
  SGDetail.ColWidths[2] := 50;
  SGDetail.ColWidths[3] := 40;

  { trend stats }
  ButtonGraphGesamt.Enabled:= False;
  ButtonGraphDetail.Enabled:= False;
  ButtonTabGesamt.Enabled:= False;
  ButtonTabDetail.Enabled:= False;

  FStat_Graph.CBY1.ItemIndex := 0;
  FStat_Graph.CBY2.ItemIndex := 1;

  { add categories }
  LBFlu.Items.Clear;
  CLBKat.Clear;
  for i := 0 to FMain.FlightLogList.Count-1 do
  begin
    LBFlu.Items.Add(GridChild(i).Caption);
    if GridChild(i).ACCategories.Count > 0 then
    for j := 0 to GridChild(i).ACCategories.Count-1 do
    begin
      if CLBKat.Items.IndexOf(GridChild(i).ACCategories[j]) = -1 then
        CLBKat.Items.Add(GridChild(i).ACCategories[j]);
     end;
  end;

  RGDistUnit.ItemIndex := RGDistUnit.Items.IndexOf(GridActiveChild.Settings.Values['DistUnit']);
  RGDefaultTime.ItemIndex := StrToInt(GridActiveChild.Settings.Values['DefaultTime']);

  { units }
  LabelGStrecke.Caption := '0 '+RGDistUnit.Items[RGDistUnit.ItemIndex];
  LabelGDGeschw.Caption := '0 '+GetSpeedUnit(RGDistUnit.Items[RGDistUnit.ItemIndex]);
  LabelSStrecke.Caption := '0 '+RGDistUnit.Items[RGDistUnit.ItemIndex];
  LabelSDGeschw.Caption := '0 '+GetSpeedUnit(RGDistUnit.Items[RGDistUnit.ItemIndex]);

  { select flightlog }
  LBFlu.Selected[0] := True;
  LBFluClick(self);
end;

// ----------------------------------------------------------------
// Clear detail view
// ----------------------------------------------------------------
procedure TFStatistics.ClearDetail;
begin
  LabelSName.Caption := '';
  //LabelSName2.Caption := '';
  CBKatDetail.Enabled := False;
  LabelSW.Caption := '0';
  LabelSF.Caption := '0';
  LabelSE.Caption := '0';
  LabelSA.Caption := '0';
  LabelSG.Caption := '0';
  LabelSDurchn.Caption := '0:00';
  LabelSGesZeit.Caption := '0.00 %';
  LabelSGesStart.Caption := '0.00 %';
  LabelSStrecke.Caption := '0 '+RGDistUnit.Items[RGDistUnit.ItemIndex];
  LabelSDGeschw.Caption := '0 '+GetSpeedUnit(RGDistUnit.Items[RGDistUnit.ItemIndex]);
  LabelSDPassengers.Caption := '0';
  LabelSDAvPassengers.Caption := '0';

  GridKatDetail.RowCount := 1;
  GridKatDetail.Cells[0,0] := '';
  GridKatDetail.Cells[1,0] := '';
  GridKatDetail.Cells[2,0] := '';
end;

// ----------------------------------------------------------------
// on Hint
// ----------------------------------------------------------------
procedure TFStatistics.onHint(Sender: TObject);
begin
  StatusBar1.Panels[0].text := GetLongHint(Application.Hint);
end;

// ----------------------------------------------------------------
// Form close
// ----------------------------------------------------------------
procedure TFStatistics.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.OnHint := FMain.onHint;
end;

// ----------------------------------------------------------------
// Select flightlog
// ----------------------------------------------------------------
procedure TFStatistics.LBFluClick(Sender: TObject);
{----------}
  procedure AddYears(Nr: Word);
  var
    i: Word;
  begin
    if GridChild(Nr).Data['Num',1] <> '' then
    for i := 1 to (ExtractYear(GridChild(Nr).Data['Dat',GridChild(Nr).Grid.RowCount-1])-ExtractYear(GridChild(Nr).Data['Dat',1])) do
    begin
      CBJFrom.Items.Add(InttoStr(ExtractYear(GridChild(Nr).Data['Dat',1])+i));
      CBJTo.Items.Add(InttoStr(ExtractYear(GridChild(Nr).Data['Dat',1])+i));
    end;
  end;
{----------}
begin
  CBJTo.Items.Clear;
  CBJTo.Items.Add(('End'));
  CBJFrom.Items.Clear;
  CBJFrom.Items.Add(('Beginning'));

  if LBFlu.SelCount = 1 then AddYears(LBFlu.ItemIndex);
  { else
  begin
    for GridIdx := 0 to FMain.FlightLogList.Count do
     if GridIdx < LBFlu.Items.Count then
     if LBFlu.Selected[GridIdx] then
     begin

     end;
  end; }
  CBJFrom.ItemIndex := 0;
  CBJTo.ItemIndex := 0;
end;

// ----------------------------------------------------------------
// Fill grid for detail view
// ----------------------------------------------------------------
procedure TFStatistics.FillSGDetail(Data: TStatData);
var
  i: Word;
  canSelect : Boolean;
begin
  for i := 0 to 17 do
    SGDetail.Cells[i,1] := '';

  SGDetail.RowCount := 2;
  SGDetail.Cells[1,0]  := CBDetail.Text;
  SGDetail.Cells[2,0]  := ('Time');
  SGDetail.Cells[3,0]  := ('Flights');

  if length(Data.StatItems) = 0 then
    Exit;
  for i := 0 to high(Data.StatItems) do if Data.StatItems[i].Name <> '' then
  begin
    SGDetail.Cells[0,i+1] := InttoStr(i);
    SGDetail.Cells[1,i+1] := Data.StatItems[i].Name;
    SGDetail.Cells[2,i+1] := Data.StatItems[i].Time;
    SGDetail.Cells[3,i+1] := InttoStr(Data.StatItems[i].Flights);

    SGDetail.Cells[4,i+1] := InttoStr(Data.StatItems[i].W);
    SGDetail.Cells[5,i+1] := InttoStr(Data.StatItems[i].F);
    SGDetail.Cells[6,i+1] := InttoStr(Data.StatItems[i].E);
    SGDetail.Cells[7,i+1] := InttoStr(Data.StatItems[i].A);
    SGDetail.Cells[8,i+1] := InttoStr(Data.StatItems[i].G);
    SGDetail.Cells[9,i+1] := FormatFloat('0',Data.StatItems[i].Distance);
    SGDetail.Cells[10,i+1] := Data.StatItems[i].DistanceTime;
    SGDetail.Cells[11,i+1] := InttoStr(Data.StatItems[i].Passengers);

    SGDetail.Cells[12,i+1] := FormatFloat('0.00', Data.StatItems[i].CfF);
    SGDetail.Cells[13,i+1] := FormatFloat('0.00', Data.StatItems[i].CfC);
    SGDetail.Cells[14,i+1] := FormatFloat('0.00', Data.StatItems[i].LaF);
    SGDetail.Cells[15,i+1] := FormatFloat('0.00', Data.StatItems[i].EfF);
    SGDetail.Cells[16,i+1] := FormatFloat('0.00', Data.StatItems[i].EfF-(Data.StatItems[i].CfF+Data.StatItems[i].CfC+Data.StatItems[i].LaF));

    SGDetail.Cells[17,i+1] := Data.StatItems[i].LastStart;

    if i > 0 then SGDetail.RowCount := i+2;
  end;

  SGDetailRow := 1;
  SGDetailSelectCell(self, 1, 1, canSelect);

  //SortGridByCols([1], SGDetail);
end;

function TFStatistics.FindInKat(var Kat: TKat; Value: String):Word;
var i: Word;
begin
  if high(Kat) >= 0 then begin
    for i := 0 to High(Kat) do if Kat[i].Name = Value then begin
      Result := i;
      Exit;
    end;
  end;

  setlength(Kat,length(Kat)+1);
  Kat[length(Kat)-1].Name := Value;
  Kat[High(Kat)].Value := '0';
  Kat[High(Kat)].Value2 := '0';
  Result := length(Kat)-1;
end;

// ----------------------------------------------------------------
// Start statistics
// ----------------------------------------------------------------
procedure TFStatistics.ButtonStatStartClick(Sender: TObject);
begin
  CalcStats(ttNone);
end;

// ----------------------------------------------------------------
// Calculate statistics
// ----------------------------------------------------------------
procedure TFStatistics.CalcStats(TrendType: TTrendType);
var
  Row, j, k, FoundFlights: Integer;
  RCfF, RCfC, RLaF, REfF, RCalc : Real;
  GenTime, ZPIC, ZAlleine, ZBegleiter, BegleitTemp, DistanceTime, KatStr: String;
  ZWinde, ZFsch, ZEigen, ZAuto, ZGummi, StartDate, EndDate, GenFlights, FlightCount, Passengers: Integer;
  Distance: Real;
  TrendIdx: Word;
  TmpStrecke: Real;
  TmpStrList: TStringList;
  Accept, prevAccept, ItsIn, ItsInNot, KatSel, KatSelNot, ItsInNotP: Boolean;
  X,Faktor: Real;
  GridIdx: Word;
  tick_now: array[0..1] of Longint;
  ProgressBar: TProgressBar;

{----------}
  { Time categories }
  procedure AddCTime(var CTime: TKat);
  var
    l: word;
    TempKat, TempStr: String;
  begin
    for l := 1 to length(GridChild(GridIdx).data['CTi',Row]) do
    begin
      if (GridChild(GridIdx).data['CTi',Row][l] = '|') then
      begin
        TempKat := TempStr;
        TempStr := '';
      end
      else if (GridChild(GridIdx).data['CTi',Row][l] = '/') then
      begin
        CTime[FindInKat(CTime,TempKat)].Value := AddTime(CTime[FindInKat(CTime,TempKat)].Value,TempStr);
        TempStr := '';
      end
      else TempStr := TempStr + GridChild(GridIdx).data['CTi',Row][l];
    end;
  end;
{----------}
  { Categories }
  procedure AddKat(var Kat: TKat);
  var
    l, TempKat: word;
  begin
    try
      TmpStrList := TStringList.Create;
      StringToStringList(TmpStrList, GridChild(GridIdx).data['Cat',Row]);
      StringToStringList(TmpStrList, GetStringObject(GridChild(GridIdx).ACAircrafts, GridChild(GridIdx).data['AId',Row], 'AircraftCat'));

    if TmpStrList.Count = 0 then
      Exit;
    for l := 0 to TmpStrList.Count-1 do
    begin
      TempKat := FindInKat(Kat,TmpStrList[l]);
      Kat[TempKat].Value := InttoStr(StrtoInt(Kat[TempKat].Value) + FlightCount);
    end;
    finally
      TmpStrList.Free;
    end;
  end;
{----------}
  { Contest categories }
  procedure AddContest(var Contest: TKat);
  var
    l, pos: word;
    tempKat, tempStr: String;
    tmpDistance: Real;
  begin
    pos := 0;
    for l := 1 to length(GridChild(GridIdx).data['Con',Row]) do
    begin
      if (GridChild(GridIdx).data['Con',Row][l] = '|') then
      begin
        if pos = 0 then
        begin
          tempKat := tempStr;
          tempStr := '';
          inc(pos);
        end
        else
        if pos = 1 then
        begin
          tmpDistance := ConvertDistUnits(StrToFloat(Contest[FindInKat(Contest,tempKat)].Value),GridChild(GridIdx).Settings.Values['DistUnit'],StatDistUnit);
          Contest[FindInKat(Contest,tempKat)].Value := FloatToStr(tmpDistance + StrToFloat(tempStr));
          inc(pos);
          tempStr := '';
        end;
      end
      else if (GridChild(GridIdx).data['Con',Row][l] = '/') then
      begin
        Contest[FindInKat(Contest,tempKat)].Value2 := FloatToStr(StrToFloat(Contest[FindInKat(Contest,tempKat)].Value2) + StrToFloat(tempStr));
        tempStr := '';
        pos := 0;
      end
      else tempStr := tempStr + GridChild(GridIdx).data['Con',Row][l];
    end;
  end;
{----------}
  { TStatData-Records ausfüllen }
  procedure AddData(var StatData: TStatData; j: Word);
  begin
    StatData.StatItems[j].Time := CalcTime(GridIdx, StatData.StatItems[j].Time,Row,Row, RGDefaultTime.ItemIndex);
    StatData.StatItems[j].LastStart := GridChild(GridIdx).Data['Dat',Row];
    inc(StatData.StatItems[j].Flights,FlightCount);
    if GridChild(GridIdx).Data['Pas',Row] <> '' then
    begin
      inc(StatData.StatItems[j].Passengers, StrToInt(GridChild(GridIdx).Data['Pas',Row]));
      inc(StatData.StatItems[j].TrendData[TrendIdx].Passengers, StrToInt(GridChild(GridIdx).Data['Pas',Row]));
    end;
    AddCTime(StatData.StatItems[j].CTime);
    AddCTime(StatData.StatItems[j].TrendData[TrendIdx].CTime);
    AddKat(StatData.StatItems[j].Kat);
    AddKat(StatData.StatItems[j].TrendData[TrendIdx].Kat);
    AddContest(StatData.StatItems[j].Contest);
    AddContest(StatData.StatItems[j].TrendData[TrendIdx].Contest);
    if GridChild(GridIdx).Data['ToS',Row] = 'W' then
    begin
      inc(StatData.StatItems[j].W,FlightCount);
      inc(StatData.StatItems[j].TrendData[TrendIdx].W,FlightCount);
    end;
    if GridChild(GridIdx).Data['ToS',Row] = 'F' then
    begin
      inc(StatData.StatItems[j].F,FlightCount);
      inc(StatData.StatItems[j].TrendData[TrendIdx].F,FlightCount);
    end;
    if GridChild(GridIdx).Data['ToS',Row] = 'E' then
    begin
      inc(StatData.StatItems[j].E,FlightCount);
      inc(StatData.StatItems[j].TrendData[TrendIdx].E,FlightCount);
    end;
    if GridChild(GridIdx).Data['ToS',Row] = 'A' then
    begin
      inc(StatData.StatItems[j].A,FlightCount);
      inc(StatData.StatItems[j].TrendData[TrendIdx].A,FlightCount);
    end;
    if GridChild(GridIdx).Data['ToS',Row] = 'G' then
    begin
      inc(StatData.StatItems[j].G,FlightCount);
      inc(StatData.StatItems[j].TrendData[TrendIdx].G,FlightCount);
    end;
    if GridChild(GridIdx).Data['CfF',Row] > '' then begin
      try
        StatData.StatItems[j].CfF := StatData.StatItems[j].CfF + StrToFloat(GridChild(GridIdx).Data['CfF',Row]);
        StatData.StatItems[j].TrendData[TrendIdx].CfF := StatData.StatItems[j].TrendData[TrendIdx].CfF + StrToFloat(GridChild(GridIdx).Data['CfF',Row]);
      except end;
    end;
    if GridChild(GridIdx).Data['CfC',Row] > '' then begin
      try
        StatData.StatItems[j].CfC := StatData.StatItems[j].CfC + StrToFloat(GridChild(GridIdx).Data['CfC',Row]);
        StatData.StatItems[j].TrendData[TrendIdx].CfC := StatData.StatItems[j].TrendData[TrendIdx].CfC + StrToFloat(GridChild(GridIdx).Data['CfC',Row]);
      except end;
    end;
    if GridChild(GridIdx).Data['LaF',Row] > '' then begin
      try
        StatData.StatItems[j].LaF := StatData.StatItems[j].LaF + StrToFloat(GridChild(GridIdx).Data['LaF',Row]);
        StatData.StatItems[j].TrendData[TrendIdx].LaF := StatData.StatItems[j].TrendData[TrendIdx].LaF + StrToFloat(GridChild(GridIdx).Data['LaF',Row]);
      except end;
    end;
    if GridChild(GridIdx).Data['EfF',Row] > '' then begin
      try
        StatData.StatItems[j].EfF := StatData.StatItems[j].EfF + StrToFloat(GridChild(GridIdx).Data['EfF',Row]);
        StatData.StatItems[j].TrendData[TrendIdx].EfF := StatData.StatItems[j].TrendData[TrendIdx].EfF + StrToFloat(GridChild(GridIdx).Data['EfF',Row]);
      except end;
    end;

    inc(StatData.StatItems[j].TrendData[TrendIdx].Flights,FlightCount);
    StatData.StatItems[j].TrendData[TrendIdx].Time := CalcTime(GridIdx, StatData.StatItems[j].TrendData[TrendIdx].Time,Row,Row, RGDefaultTime.ItemIndex);
    if TmpStrecke > 0 then
    begin
      StatData.StatItems[j].Distance := StatData.StatItems[j].Distance + TmpStrecke;
      StatData.StatItems[j].DistanceTime := CalcTime(GridIdx, StatData.StatItems[j].DistanceTime,Row,Row, RGDefaultTime.ItemIndex);
      StatData.StatItems[j].TrendData[TrendIdx].DistanceTime := CalcTime(GridIdx, StatData.StatItems[j].TrendData[TrendIdx].DistanceTime,Row,Row, RGDefaultTime.ItemIndex);
      StatData.StatItems[j].TrendData[TrendIdx].Distance := StatData.StatItems[j].TrendData[TrendIdx].Distance + TmpStrecke;
    end;
  end;
{----------}
  { Prüfen ob TStatData-Record schon vorhanden }
  procedure AddDetail(StatData: TStatData; Data: String);
  var j: Integer;
  begin
    if Data = '' then Exit;
    ItsIn := False;
    if length(StatData.StatItems)>0 then
      for j := 0 to length(StatData.StatItems)-1 do
    begin
      if Data = StatData.StatItems[j].Name then
      begin
        Itsin := True;
        AddData(StatData,j);
        Break;
      end;
    end;
    if not ItsIn then
    begin
      StatData.Add;

      //SetLength(StatData, length(StatData)+1);
      //SetLength(StatData[length(StatData)-1].TrendData,years);
      StatData.StatItems[length(StatData.StatItems)-1].Name := Data;
      AddData(StatData,length(StatData.StatItems)-1);
    end;
  end;
{----------}
  procedure Reset(var StatData: TStatData);
  var Row: Word;
  begin
    if length(StatData.StatItems)=0 then
      Exit;
    for Row := 0 to length(StatData.StatItems)-1 do
    begin
      StatData.StatItems[Row].Name := '';
      StatData.StatItems[Row].Flights := 0;
      StatData.StatItems[Row].Time := '00:00';
      StatData.StatItems[Row].W := 0;
      StatData.StatItems[Row].F := 0;
      StatData.StatItems[Row].E := 0;
      StatData.StatItems[Row].A := 0;
      StatData.StatItems[Row].G := 0;
      StatData.StatItems[Row].Distance := 0;
      StatData.StatItems[Row].LastStart := '';
      StatData.StatItems[Row].DistanceTime := '00:00';
      StatData.StatItems[Row].CfF := 0;
      StatData.StatItems[Row].CfC := 0;
      StatData.StatItems[Row].LaF := 0;
      StatData.StatItems[Row].EfF := 0;
      SetLength(StatData.StatItems[Row].TrendData,0);
      SetLength(StatData.StatItems[Row].CTime,0);
      SetLength(StatData.StatItems[Row].Kat,0);
      SetLength(StatData.StatItems[Row].Contest,0);
    end;
    SetLength(STatData.StatItems,0);
  end;
{----------}
begin
  { Initialise }
  FoundFlights := 0;
  ZPIC := '00:00'; GenTime := '00:00'; ZAlleine := '00:00'; ZBegleiter := '00:00'; DistanceTime := '00:00';
  ZWinde := 0; ZFsch := 0; ZEigen := 0; ZAuto := 0; ZGummi := 0;
  GenFlights := 0; Distance := 0; Faktor := 0; StartYear := 0; Passengers := 0;
  RCfF := 0; RCfC := 0; RLaF := 0; REfF := 0; RCalc := 0;
  LabelFluege2.Caption := ''; LabelGesamt2.Caption := '';
  LabelCalcTime.Caption := '';
  prevAccept := False;
  Accept := False;
  LabelFrom.Caption := '';
  LabelTo.Caption := '';
  ButtonGraphGesamt.Enabled:= False;
  ButtonGraphDetail.Enabled:= False;
  ButtonTabGesamt.Enabled:= False;
  ButtonTabDetail.Enabled:= False;

  Reset(Aircraft);
  Reset(AircraftID);
  Reset(Pilot);
  Reset(CoPilot);
  Reset(Startort);
  Reset(Landeort);
  SetLength(CTime,0);
  SetLength(Kat,0);
  SetLength(Contest,0);

  GridKatG.RowCount := 1;
  GridKatG.Cells[0,0] := '';
  GridKatG.Cells[1,0] := '';

  CBKatGen.ItemIndex := 0;

  try
    tick_now[0] := GetTickCount;
    Screen.Cursor := crHourGlass;
    
    case RGDistUnit.ItemIndex of
      0: StatDistUnit := 'km';
      1: StatDistUnit := 'nm';
      2: StatDistUnit := 'miles';
    end;

    If LBFlu.SelCount = 0 then
    begin
      exit;
    end;

    { valid value in flights? }
    if RBStarts.checked then
    begin
      try StrToInt(CBSTFrom.Text)
      except
        on EConvertError do
        begin
          MessageDlg(('Please enter a number'),mtError,[mbOK],0);
          ActiveControl := CBSTFrom;
          Exit;
        end;
      end;
      try
        StrToInt(CBSTTo.Text)
      except
        on EConvertError do
        begin
          MessageDlg(('Please enter a number'),mtError,[mbOK],0);
          ActiveControl := CBSTTo;
          Exit;
        end;
      end;
    end;

    { Startjahr für Statistik }
  //  if TrendType = ttNone then
  //    PStatData := @


    //SetLength(TrendData,0);
    Years := 0;
    for GridIdx := 0 to FMain.FlightLogList.Count do if GridIdx < LBFlu.Items.Count then
    if LBFlu.Selected[GridIdx] then
    if GridChild(GridIdx).Data['Num',1] <> '' then
    begin

    { Auswahl nach Jahren }
    if RBJahre.checked then
    begin
      if CBJFrom.Text = ('Beginning') then StartDate := ExtractYear(GridChild(GridIdx).Data['Dat',1])
      else StartDate := StrtoInt(CBJFrom.Text);
      if CBJTo.Text = ('End') then EndDate := ExtractYear(GridChild(GridIdx).Data['Dat',GridChild(GridIdx).Grid.RowCount-1])+1
      else EndDate := StrtoInt(CBJTo.Text);
      if CBJFrom.Text = ('Beginning') then LabelFrom.Caption := ('Start')+' '
        +GridChild(GridIdx).Data['Dat',1]
        +' am '+GridChild(GridIdx).Data['Dat',1];
      if CBJTo.Text = ('End') then LabelTo.Caption := ('Start')+' '
        +GridChild(GridIdx).Data['Num',GridChild(GridIdx).Grid.RowCount-1]
        +' am '+GridChild(GridIdx).Data['Dat',GridChild(GridIdx).Grid.RowCount-1];
    end;

    if (StartYear > ExtractYear(GridChild(GridIdx).Data['Dat',1])) or (StartYear = 0) then
      StartYear := ExtractYear(GridChild(GridIdx).Data['Dat',1]);


    if years < ExtractYear(GridChild(GridIdx).Data['Dat',GridChild(GridIdx).Grid.RowCount-1])
      - ExtractYear(GridChild(GridIdx).Data['Dat',1])+1 then
         Years := ExtractYear(GridChild(GridIdx).Data['Dat',GridChild(GridIdx).Grid.RowCount-1])
         - ExtractYear(GridChild(GridIdx).Data['Dat',1])+1;
      { TODO : -> dynamic array, months, weeks }
  //    SetLength(TrendData,Length(TrendData)+years);
    end;

    { progress bar }
    PanelFoundFlights.Visible := True;
    ProgressBar := TProgressBar.Create(FStatistics);
    ProgressBar.Parent := TsStart;
    ProgressBar.Left := PanelFoundFlights.Left;
    ProgressBar.Top := PanelFoundFlights.Top;
    ProgressBar.Width := PanelFoundFlights.Width;
    ProgressBar.Height := PanelFoundFlights.Height;
    ProgressBar.Max := 0;
    ProgressBar.Step := 1;
    for GridIdx := 0 to FMain.FlightLogList.Count do if GridIdx < LBFlu.Items.Count then
      if LBFlu.Selected[GridIdx] then
        ProgressBar.Max := ProgressBar.Max + GridChild(GridIdx).Grid.RowCount-1;

  { loop over all flight logs }
    for GridIdx := 0 to FMain.FlightLogList.Count do if GridIdx < LBFlu.Items.Count then
    begin
      GSNr := GridIdx;
      if LBFlu.Selected[GridIdx] then
      if GridChild(GridIdx).Data['Num',1] <> '' then
      begin
        { if "since license" check date}
        if RBSchein.checked then
        begin
          if GridChild(GridIdx).Settings.Values['LicenseSince'] = '  .  .    ' then
          begin
            Messagedlg(('Please fill out "License obtained"!'),mtWarning,[mbOK],0);
            with FSettings.Create(Application) do
            try
              FSettings.PageControl.ActivePageIndex := 3;
              ShowModal;
            finally
              Free;
            end;
            if GridChild(GridIdx).Settings.Values['LicenseSince'] = '  .  .    ' then Exit;
          end;
        end;

  { Main loop }
        for Row := 1 to GridChild(GridIdx).Grid.RowCount-1 do
        begin
          ProgressBar.StepIt;
          { selected by years }
          if RBJahre.checked then
          begin
            Accept := False;
            if (ExtractYear(GridChild(GridIdx).Data['Dat',Row]) >= StartDate)
              and (ExtractYear(GridChild(GridIdx).Data['Dat',Row]) < EndDate)
            then  Accept := True;
          end;

          { selected by date }
          if RBDatum.checked then
          begin
            if (StrToDate(GridChild(GridIdx).Data['Dat',Row]) >= CBDateFrom.Date)
              and (StrToDate(GridChild(GridIdx).Data['Dat',Row]) <= CBDateTo.Date)
            then  Accept := True
            else  Accept := False;
          end;

          { selected by flights }
          if RBStarts.checked then
          begin
            Accept := False;
            if (StrtoInt(GridChild(GridIdx).Data['Num',Row]) >= (StrtoInt(CBStFrom.Text)))
              and (StrtoInt(GridChild(GridIdx).Data['Num',Row]) <= (StrtoInt(CBStTo.Text)))
            then Accept := True;
          end;

          { since license }
          if RBSchein.checked then
          begin
            if (StrToDate(GridChild(GridIdx).Data['Dat',Row]) > StrToDate(GridChild(GridIdx).Settings.Values['LicenseSince']))
            then Accept := True
            else Accept := False;
          end;

          { Categories }
          ItsIn := False;
          ItsInNot := False;
          KatSel := False;
          KatSelNot := False;
          ItsInNotP := False;

          try
            TmpStrList := TStringList.Create;
            StringToStringList(TmpStrList, GridChild(GridIdx).data['Cat',Row]);
            StringToStringList(TmpStrList, GetStringObject(GridChild(GridIdx).ACAircrafts, GridChild(GridIdx).data['AId',Row], 'AircraftCat'));

            if (Accept) and (CLBKat.Count > 0) then
            for j := 0 to CLBKat.Count-1 do if (CLBKat.State[j] = cbChecked) or (CLBKat.State[j] = cbGrayed) then
            begin
              if CLBKat.State[j] = cbChecked then KatSel := True;
              if CLBKat.State[j] = cbGrayed then KatSelNot := True;
              if RBKatAnd.Checked then ItsIn := False;
              if RBKatAnd.Checked then ItsInNot := False;

              if TmpStrList.IndexOf(CLBKat.Items.Strings[j]) > -1 then
              begin
                if CLBKat.State[j] = cbChecked then ItsIn := True;
                if CLBKat.State[j] = cbGrayed then ItsInNot := True;
              end
              else if RBKatOr.Checked and (CLBKat.State[j] = cbGrayed) then ItsInNotP := True;

              if RBKatAnd.Checked then
              begin
                if (CLBKat.State[j] = cbChecked) and (not ItsIn) then Accept := False;
                if (CLBKat.State[j] = cbGrayed) and (ItsinNot) then Accept := False;
              end;
            end;
            if RBKatOr.Checked then
            begin
              Accept := False;
              if (KatSel and ItsIn) or (KatSelNot and not ItsInNot) then Accept := True;
              if ItsInNotP then Accept := True;
              if CLBKat.SelCount = 0 then Accept := True;
            end;
          finally
            TmpStrList.Free;
          end;

          { first and last flight }
          if accept and not prevaccept then //first flight
            LabelFrom.Caption := ('Start')+' '+GridChild(GridIdx).Data['Num',Row]
                  +', '+GridChild(GridIdx).Data['Dat',Row];
          if not accept and prevaccept and (Row>1) then // last flight
            LabelTo.Caption := ('Start')+' '+GridChild(GridIdx).Data['Num',Row-1]
                  +', '+' '+GridChild(GridIdx).Data['Dat',Row-1];
          prevaccept := accept;

  { calc stats }
          if Accept then
          begin
            inc(FoundFlights);
            FlightCount := StrToInt(GridChild(GridIdx).Data['NoL', Row]);
            if GridChild(GridIdx).Data['Dst', Row] <> '' then
            TmpStrecke := ConvertDistUnits(StrtoInt(GridChild(GridIdx).Data['Dst',Row]), GridChild(GridIdx).Settings.Values['DistUnit'],StatDistUnit)
            else TmpStrecke := 0;

            inc(GenFlights, FlightCount);
            GenTime := CalcTime(GridIdx, GenTime,Row,Row, RGDefaultTime.ItemIndex);
            TrendIdx  := ExtractYear(GridChild(GridIdx).Data['Dat',Row])-StartYear; { TODO : Trend }
            inc(TrendData.StatItems[TrendIdx].Flights,FlightCount);
            if GridChild(GridIdx).Data['Pas',Row] <> '' then
            begin
              inc(Passengers, StrToInt(GridChild(GridIdx).Data['Pas',Row]));
              inc(TrendData.StatItems[TrendIdx].Passengers, StrToInt(GridChild(GridIdx).Data['Pas',Row]));
            end;
            TrendData.StatItems[TrendIdx].Time := CalcTime(GridIdx, TrendData.StatItems[TrendIdx].Time,Row,Row, RGDefaultTime.ItemIndex);
            AddCTime(CTime);
            AddCTime(TrendData.StatItems[TrendIdx].CTime);
            AddKat(Kat);
            AddKat(TrendData.StatItems[TrendIdx].Kat);
            AddContest(Contest);
            AddContest(TrendData.StatItems[TrendIdx].Contest);
            if TmpStrecke > 0 then
            begin
              Distance := Distance + TmpStrecke;
              DistanceTime := CalcTime(GridIdx, DistanceTime,Row,Row, RGDefaultTime.ItemIndex);
              TrendData.StatItems[TrendIdx].DistanceTime := CalcTime(GridIdx, TrendData.StatItems[TrendIdx].DistanceTime,Row,Row, RGDefaultTime.ItemIndex);
              TrendData.StatItems[TrendIdx].Distance := TrendData.StatItems[TrendIdx].Distance + TmpStrecke;
            end;
            if GridChild(GridIdx).Data['Pi1',Row] = GenSettings.Values['PilotName'] then
              ZPIC := CalcTime(GridIdx, ZPIC,Row,Row, RGDefaultTime.ItemIndex);
            if GridChild(GridIdx).Data['Pi2',Row] = '' then ZAlleine := CalcTime(GridIdx, ZAlleine,Row,Row, RGDefaultTime.ItemIndex)
            else
            if GridChild(GridIdx).Data['Pi2',Row] <> '' then ZBegleiter := CalcTime(GridIdx, ZBegleiter,Row,Row, RGDefaultTime.ItemIndex);
            if GridChild(GridIdx).Data['ToS',Row] = 'W' then
            begin
              inc(ZWinde, FlightCount);
              inc(TrendData.StatItems[TrendIdx].W, FlightCount)
            end;
            if GridChild(GridIdx).Data['ToS',Row] = 'F' then
            begin
              inc(ZFsch,FlightCount);
              inc(TrendData.StatItems[TrendIdx].F,FlightCount)
            end;
            if GridChild(GridIdx).Data['ToS',Row] = 'E' then
            begin
              inc(ZEigen,FlightCount);
              inc(TrendData.StatItems[TrendIdx].E,FlightCount)
            end;
            if GridChild(GridIdx).Data['ToS',Row] = 'A' then
            begin
              inc(ZAuto,FlightCount);
              inc(TrendData.StatItems[TrendIdx].A,FlightCount)
            end;
            if GridChild(GridIdx).Data['ToS',Row] = 'G' then
            begin
              inc(ZGummi,FlightCount);
              inc(TrendData.StatItems[TrendIdx].G,FlightCount)
            end;

            AddDetail(Aircraft,GridChild(GridIdx).Data['ATy',Row]);
            AddDetail(AircraftID,GridChild(GridIdx).Data['AId',Row]);
            AddDetail(Startort,GridChild(GridIdx).Data['StL',Row]);
            AddDetail(Landeort,GridChild(GridIdx).Data['LaL',Row]);
            AddDetail(Pilot,GridChild(GridIdx).Data['Pi1',Row]);

            if GridChild(GridIdx).Data['Pi2',Row] <> '' then
            begin
              AddDetail(CoPilot,GridChild(GridIdx).Data['Pi2',Row]);
              AddDetail(CoPilot,' '+('With passenger'));
            end
            else
              AddDetail(CoPilot,' '+('Solo'));

            { Costs }
            if GridChild(GridIdx).Data['CfF',Row] > '' then
              RCfF := RCfF + StrToFloat(GridChild(GridIdx).Data['CfF',Row]);
            if GridChild(GridIdx).Data['CfC',Row] > '' then
              RCfC := RCfC + StrToFloat(GridChild(GridIdx).Data['CfC',Row]);
            if GridChild(GridIdx).Data['LaF',Row] > '' then
              RLaF := RLaF + StrToFloat(GridChild(GridIdx).Data['LaF',Row]);
            if GridChild(GridIdx).Data['EfF',Row] > '' then
              REfF := REfF + StrToFloat(GridChild(GridIdx).Data['EfF',Row]);

          end; { if Accept then }
        end; { for Row := 1 to GridChild(LBFlu.ItemIndex).Grid.RowCount-1 do }

        if (CBJFrom.Text = ('Beginning')) and (RBJahre.checked) then
        begin
          if GridChild(GridIdx).Settings.Values['BFTime'] <> '00000:00' then
            LabelGesamt2.Caption := '('+AddTime(GenTime,GridChild(GridIdx).Settings.Values['BFTime'])+')';

          if StrtoInt(GridChild(GridIdx).Settings.Values['BFStarts']) > 0 then
            LabelFluege2.Caption := '('+InttoStr(GenFlights + StrtoInt(GridChild(GridIdx).Settings.Values['BFStarts']))+')';
        end;
      end; { if LBFlu.Selected[GridIdx] }
     end; { if GridIdx < LBFlu.Items.Count }

  { Auswertung  }
    if FoundFlights = 0 then
    begin
      CBDetail.ItemIndex := 0;
      DetailChange(Self);

      messagedlg(('No data found'),mtInformation,[mbOK],0);
      Exit;
    end
    else
    begin
      ButtonGraphGesamt.Enabled:= True;
      ButtontabGesamt.Enabled:= True;
    end;

    LabelFoundFlights.Caption := IntToStr(FoundFlights);
    if LBFlu.SelCount > 1 then { TODO : first, last flight }
    begin
      LabelFrom.Caption := '-';
      LabelTo.Caption := '-';
    end
    else
    { LabelTo oder LabelFrom leer --> letzter oder erster Flug }
    begin
      if LabelFrom.Caption = '' then LabelFrom.Caption := GridChild(LBFlu.ItemIndex).Data['Num',1]+', '+GridChild(LBFlu.ItemIndex).Data['Dat',1];
      if LabelTo.Caption = '' then LabelTo.Caption := GridChild(LBFlu.ItemIndex).Data['Num',GridChild(LBFlu.ItemIndex).Grid.RowCount-1]+
        ', '+GridChild(LBFlu.ItemIndex).Data['Dat',GridChild(LBFlu.ItemIndex).Grid.RowCount-1];
    end;

    CBDetail.ItemIndex := 0;
    DetailChange(Self);

    TCCfF.Caption := FormatFloat('0.00', RCfF)+' '+GenSettings.Values['Currency'];
    TCCfC.Caption := FormatFloat('0.00', RCfC)+' '+GenSettings.Values['Currency'];
    TCLaF.Caption := FormatFloat('0.00', RLaF)+' '+GenSettings.Values['Currency'];
    TCEfF.Caption := FormatFloat('0.00', REfF)+' '+GenSettings.Values['Currency'];
    TCSum.Caption := FormatFloat('0.00', REfF-(RCfF+RCfC+RLaF))+' '+GenSettings.Values['Currency'];

    LabelGesamt.Caption := GenTime;
    LabelPIC.Caption := ZPIC;
    LabelAlleine.Caption := ZAlleine;
    LabelBegleiter.Caption := ZBegleiter;
    LabelPassengers.Caption := InttoStr(Passengers);
    LabelAvPassengers.Caption := FormatFloat('0.00', Passengers/GenFlights);
    LabelWinde.Caption := InttoStr(ZWinde);
    LabelFsch.Caption := InttoStr(ZFsch);
    LabelEigen.Caption := InttoStr(ZEigen);
    LabelAuto.Caption := InttoStr(ZAuto);
    LabelGummi.Caption := InttoStr(ZGummi);
    LabelDurchn.Caption := avgTime(GenTime, GenFlights);
    LabelGenFlights.Caption := InttoStr(GenFlights);

    LabelGStrecke.Caption := FormatFloat('0',Distance)+' '+RGDistUnit.Items[RGDistUnit.ItemIndex];
    LabelGDGeschw.Caption := InttoStr(avgSpeed(Round(Distance),DistanceTime))+' '+GetSpeedUnit(RGDistUnit.Items[RGDistUnit.ItemIndex]);

    CBKatGenChange(Self);
    //CBKatDetailChange(Self);
    tick_now[1] := GetTickCount;
    LabelCalcTime.Caption := Format('%u ms', [tick_now[1] - tick_now[0]]);
  finally
    Screen.Cursor := crDefault;
    ProgressBar.Free;
  end;
end;

{ Anpassen der Jahreszahlen in der Detailauswahl }
procedure TFStatistics.CBJFromChange(Sender: TObject);
var
  i: Word;
begin
  if CBJFrom.Text = ('Beginning') then CBJFrom.Itemindex := 0;
  CBJTo.Items.Clear;
  CBJTo.Items.Add(('End'));
  for i := 1 to (ExtractYear(GridActiveChild.Data['Dat',GridActiveChild.Grid.RowCount-1])
   -ExtractYear(GridActiveChild.Data['Dat',1])) do
  begin
    CBJTo.Items.Add(InttoStr(ExtractYear(GridActiveChild.Data['Dat',1])+i));
  end;
  if CBJFrom.ItemIndex <> 0 then for i := 1 to CBJFrom.ItemIndex do CBJTo.Items.Delete(1);
end;

{ Anpassen der Jahreszahlen in der Detailauswahl }
procedure TFStatistics.CBJToChange(Sender: TObject);
var
  i: Word;
begin
  if CBJTo.Text = ('End') then CBJTo.Itemindex := 0;
  CBJFrom.Items.Clear;
  CBJFrom.Items.Add(('Beginning'));
  for i := 1 to (ExtractYear(GridActiveChild.Data['Dat',GridActiveChild.Grid.RowCount-1])
   -ExtractYear(GridActiveChild.Data['Dat',1])) do
  begin
    CBJFrom.Items.Add(InttoStr(ExtractYear(GridActiveChild.Data['Dat',1])+i));
  end;
 if CBJTo.ItemIndex <> 0 then for i := 1 to (CBJTo.Items.Count-CBJTo.ItemIndex) do CBJFrom.Items.Delete(CBJFrom.Items.Count-1);
end;

{ Detailauswahl }
procedure TFStatistics.DetailChange(Sender: TObject);
begin
  ButtonTabDetail.Enabled := False;
  ButtonGraphDetail.Enabled := False;
  ClearDetail;

  case CBDetail.ItemIndex of
    0:
      begin
        PStatData := @Aircraft;
        FillSGDetail(Aircraft);
      end;
    1:
      begin
        PStatData := @AircraftID;
        FillSGDetail(AircraftID);
      end;
    2:
      begin
        PStatData := @Pilot;
        FillSGDetail(Pilot);
      end;
    3:
      begin
        PStatData := @CoPilot;
        FillSGDetail(CoPilot);
      end;
    4:
      begin
        PStatData := @StartOrt;
        FillSGDetail(StartOrt);
      end;
    5:
      begin
        PStatData := @LandeOrt;
        FillSGDetail(LandeOrt);
      end;
  end;
end;

{ Anzeigen des richtigen Panels in der Detailauswahl }
procedure TFStatistics.RBClick(Sender: TObject);
begin
  PanelJahre.visible := False;
  PanelStarts.visible := False;
  PanelSchein.visible := False;
  PanelDatum.visible := False;

  if RBJahre.checked then PanelJahre.visible := True;
  if RBStarts.checked then PanelStarts.visible := True;
  if RBDatum.checked then PanelDatum.visible := True;
  if RBSchein.checked then PanelSchein.visible := True;
end;

{ Datum checken }
procedure TFStatistics.CBDateExit(Sender: TObject);
begin

end;

// ----------------------------------------------------------------
// SGDetail alignment
// ----------------------------------------------------------------
procedure TFStatistics.SGDetailGetCellAlignment(Sender: TStringGrid;
  AColumn, ARow: Integer; State: TGridDrawState;
  var CellAlignment: TAlignment);
begin
  if (AColumn = 2) or (AColumn = 3) then CellAlignment := taRightJustify
  else CellAlignment := taLeftJustify
end;

// ----------------------------------------------------------------
// select detail cell
// ----------------------------------------------------------------
procedure TFStatistics.SGDetailSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
begin
  if (SGDetail.Cells[1,1] = '') then Exit;
  ClearDetail;
  
  { Detailanzeige }
  ButtonGraphDetail.Enabled:= True;
  ButtonTabDetail.Enabled:= True;
  LabelSName.Caption := SGDetail.Cells[1,ARow];
  //LabelSName2.Caption := SGDetail.Cells[1,ARow];
  CBKatDetail.Enabled := True;
  LabelSW.Caption := SGDetail.Cells[4,ARow];
  LabelSF.Caption := SGDetail.Cells[5,ARow];
  LabelSE.Caption := SGDetail.Cells[6,ARow];
  LabelSA.Caption := SGDetail.Cells[7,ARow];
  LabelSG.Caption := SGDetail.Cells[8,ARow];
  LabelSStrecke.Caption := SGDetail.Cells[9,ARow]+' '+RGDistUnit.Items[RGDistUnit.ItemIndex];
  LabelSDGeschw.Caption := InttoStr(avgSpeed(Round(StrtoFloat(SGDetail.Cells[9,ARow])),SGDetail.Cells[10,ARow]))+' '+GetSpeedUnit(RGDistUnit.Items[RGDistUnit.ItemIndex]);
  LabelSStrecke.Caption := SGDetail.Cells[9,ARow]+' '+RGDistUnit.Items[RGDistUnit.ItemIndex];

  LabelSDPassengers.Caption := SGDetail.Cells[11,ARow];
  LabelSDAvPassengers.Caption := FormatFloat('0.00',StrToInt(SGDetail.Cells[11,ARow]) / StrToInt(SGDetail.Cells[3,ARow])) ;

  LabelSDurchn.Caption := avgTime(SGDetail.Cells[2,ARow], StrToInt(SGDetail.Cells[3,ARow]));
  LabelSGesZeit.Caption := CalcSGesZeit(SGDetail.Cells[2,ARow],LabelGesamt.Caption);
  LabelSGesStart.Caption := CalcSGesStart(StrtoInt(SGDetail.Cells[3,ARow]),StrtoInt(LabelGenFlights.Caption));

  SCCfF.Caption := SGDetail.Cells[12,ARow]+' '+GenSettings.Values['Currency'];
  SCCfC.Caption := SGDetail.Cells[13,ARow]+' '+GenSettings.Values['Currency'];
  SCLaF.Caption := SGDetail.Cells[14,ARow]+' '+GenSettings.Values['Currency'];
  SCEfF.Caption := SGDetail.Cells[15,ARow]+' '+GenSettings.Values['Currency'];
  SCSum.Caption := SGDetail.Cells[16,ARow]+' '+GenSettings.Values['Currency'];

  LastStart.Caption := SGDetail.Cells[17,ARow];

  if (StrToDate(LastStart.Caption) >= now-90) then
    LastStart.Font.Color := clGreen else LastStart.Font.Color := clRed;

  SGDetailRow := ARow;
  CBKatDetailChange(Self);
end;

// ----------------------------------------------------------------
// year stats
// ----------------------------------------------------------------
procedure TFStatistics.ButtonJVClick(Sender: TObject);
var i: Word;
begin
  { Detail }
  if (Sender = ButtonGraphDetail) or (Sender = ButtonTabDetail) then
  begin
    if SGDetailRow = 0 then
       Exit;
    CalcStats(TTrendType(CBTrendDetail.ItemIndex));
    FStat_Graph.Caption := format(('Statistics from -->''%s''<-- in selected area'),[LabelSName.Caption]);
 //   DGraphData := PStatData^[StrToInt(SGDetail.Cells[0,SGDetailRow])].TrendData;
  end;

  { General }
  if (Sender = ButtonGraphGesamt) or (Sender = ButtonTabGesamt) then
  begin
    CalcStats(TTrendType(CBTrendGen.ItemIndex));
    FStat_Graph.Caption := ('Selection of all flights in selected area');
    DGraphData := @TrendData;
  end;

  { Tab }
  if (Sender = ButtonTabGesamt) or (Sender = ButtonTabDetail) then
  begin
    DrawTab;
  end;

  { Graph }
  if (Sender = ButtonGraphGesamt) or (Sender = ButtonGraphDetail) then
  begin
    { fill CB }
    FSTat_Graph.CBY1.Clear;
    FSTat_Graph.CBY1.Items.Add(('Flights'));
    FSTat_Graph.CBY1.Items.Add(('Time'));
    FSTat_Graph.CBY1.Items.Add(('Ø-Flight Time:'));
    FSTat_Graph.CBY1.Items.Add(('Distance'));
    FSTat_Graph.CBY1.Items.Add(('Ø-Speed'));
    FSTat_Graph.CBY1.Items.Add(('Passengers'));
    FSTat_Graph.CBY1.Items.Add(('Ø-Passengers'));
    FSTat_Graph.CBY1.Items.Add('------------------------------');
    FSTat_Graph.CBY1.Items.Add(('Costs:')+' '+('Aircraft'));
    FSTat_Graph.CBY1.Items.Add(('Costs:')+' '+('Crew'));
    FSTat_Graph.CBY1.Items.Add(('Costs:')+' '+('Landing'));
    FSTat_Graph.CBY1.Items.Add(('Costs:')+' '+('Earning'));
    FSTat_Graph.CBY1.Items.Add(('Costs:')+' '+('Total Overview'));

    if high(Kat) >= 0 then begin
      FSTat_Graph.CBY1.Items.Add('------------------------------');
      for i := 0 to high(Kat) do FSTat_Graph.CBY1.Items.Add(('Cat:')+' '+Kat[i].Name);
    end;
    if high(CTime) >= 0 then begin
      FSTat_Graph.CBY1.Items.Add('------------------------------');
      for i := 0 to high(CTime) do FSTat_Graph.CBY1.Items.Add(('Time:')+' '+CTime[i].Name);
    end;
    if high(Contest) >= 0 then begin
      FSTat_Graph.CBY1.Items.Add('------------------------------');
      for i := 0 to high(Contest) do FSTat_Graph.CBY1.Items.Add(('ConD:')+' '+Contest[i].Name);
    end;
    if high(Contest) >= 0 then begin
      FSTat_Graph.CBY1.Items.Add('------------------------------');
      for i := 0 to high(Contest) do FSTat_Graph.CBY1.Items.Add(('ConP:')+' '+Contest[i].Name);
    end;

    FSTat_Graph.CBY2.Items := FSTat_Graph.CBY1.Items;
    FSTat_Graph.CBY1.ItemIndex := 0;
    FSTat_Graph.CBY2.ItemIndex := 1;
    FStat_Graph.PanelGraph.visible := True;
    DrawGraph;
  end;
  FStat_Graph.Showmodal;
end;

function TFStatistics.FindKat(KatName: String; Kat: TKat):Integer;
var i: Word;
begin
  Result := -1;
  if high(Kat) >= 0 then
  for i := 0 to High(Kat) do
    if Kat[i].Name = KatName then
      Result := i;
end;

// ----------------------------------------------------------------
// Draw graph
// ----------------------------------------------------------------
procedure TFStatistics.DrawGraph;
var
  i, incrBb, IncrYear, StartIndex, EndIndex, TempYears: Word;
  myPoints: array of TPoint;
  myRect: TRect;
  xLeft, xRight, yTop, yBottom: Word;
{----------}
  procedure DrawYAxis(ComboBoxY: TComboBox; ColorY: TColor; YAxis: Word);
  type
    TGraphData = record
      Data: Real;
      Text: String;
  end;
  var
    GraphDataY: array of TGraphData;
    CTimeIndex, KatIndex: integer;
    MaxY, IncrY: Real;
    i: Word;
    YLabel: String;

  begin
    { TrendData
       herausfinden des höchsten Datensatzes
       skalieren
       Text für Beschriftung erstellen }
    SetLength(GraphDataY,Years);

    case ComboBoxY.ItemIndex of
      0: begin { Start }
           for i := 0 to Years-1 do
           begin
             GraphDataY[i].Data := DGraphData[i].Flights;
             GraphDataY[i].Text := InttoStr(DGraphData[i].Flights);
           end;
           YLabel := ('Flights');
         end;
      1: begin { Time }
           for i := 0 to Years-1 do
           begin
             GraphDataY[i].Data := TimeToHour(DGraphData[i].Time);
             GraphDataY[i].Text := DGraphData[i].Time;
           end;
           YLabel := ('Time')+' [hh:mm]';
         end;
      2: begin  { Ø-Flugzeit }
           for i := 0 to Years-1 do
           begin
             GraphDataY[i].Data := TimeToHour(avgTime(DGraphData[i].Time,DGraphData[i].Flights));
             GraphDataY[i].Text := avgTime(DGraphData[i].Time,DGraphData[i].Flights);
           end;
           YLabel := ('Ø-Flight Time:')+' [hh:mm]';
         end;
      3: begin { Distance }
           for i := 0 to Years-1 do
           begin
             GraphDataY[i].Data := DGraphData[i].Distance;
             GraphDataY[i].Text := FormatFloat('0',DGraphData[i].Distance);
           end;
           YLabel := ('Distance')+' ['+StatDistUnit+']';
         end;
      4: begin  { Ø-Speed }
           for i := 0 to Years-1 do
           begin
             GraphDataY[i].Data := avgSpeed(Round(DGraphData[i].Distance),DGraphData[i].DistanceTime);
             GraphDataY[i].Text := InttoStr(avgSpeed(Round(DGraphData[i].Distance),DGraphData[i].DistanceTime));
           end;
           YLabel := ('Ø-speed')+' ['+GetSpeedUnit(StatDistUnit)+']';
         end;
      5: begin  { Passengers }
           for i := 0 to Years-1 do
           begin
             GraphDataY[i].Data := DGraphData[i].Passengers;
             GraphDataY[i].Text := InttoStr(DGraphData[i].Passengers);
           end;
           YLabel := ('Passengers');
         end;
      6: begin  { Ø-Passengers }
           for i := 0 to Years-1 do
           begin
             GraphDataY[i].Data := avgPassengers(DGraphData[i].Passengers, DGraphData[i].Flights);
             GraphDataY[i].Text := FormatFloat('0.00',avgPassengers(DGraphData[i].Passengers, DGraphData[i].Flights));
           end;
           YLabel := ('Ø-Passengers');
         end;
      8: begin
           for i := 0 to Years-1 do begin
             GraphDataY[i].Data := DGraphData[i].CfF;
             GraphDataY[i].Text := FormatFloat('0.00', DGraphData[i].CfF)+' '+GenSettings.Values['Currency'];
           end;
           YLabel := ('Costs:')+' '+('Aircraft');
         end;
      9: begin
           for i := 0 to Years-1 do begin
             GraphDataY[i].Data := DGraphData[i].CfC;
             GraphDataY[i].Text := FormatFloat('0.00', DGraphData[i].CfC)+' '+GenSettings.Values['Currency'];
           end;
           YLabel := ('Costs:')+' '+('Crew');
         end;
      10: begin
           for i := 0 to Years-1 do begin
             GraphDataY[i].Data := DGraphData[i].LaF;
             GraphDataY[i].Text := FormatFloat('0.00', DGraphData[i].LaF)+' '+GenSettings.Values['Currency'];
           end;
           YLabel := ('Costs:')+' '+('Landing');
         end;
      11: begin
           for i := 0 to Years-1 do begin
             GraphDataY[i].Data := DGraphData[i].EfF;
             GraphDataY[i].Text := FormatFloat('0.00', DGraphData[i].EfF)+' '+GenSettings.Values['Currency'];
           end;
           YLabel := ('Costs:')+' '+('Earning');
         end;
      12: begin
           for i := 0 to Years-1 do begin
             GraphDataY[i].Data := (DGraphData[i].EfF-(DGraphData[i].CfF+DGraphData[i].CfC+DGraphData[i].LaF));
             if GraphDataY[i].Data < 0 then GraphDataY[i].Data := 0;
             GraphDataY[i].Text := FormatFloat('0.00', (DGraphData[i].EfF-(DGraphData[i].CfF+DGraphData[i].CfC+DGraphData[i].LaF)))+' '+GenSettings.Values['Currency'];
           end;
           YLabel := ('Costs:')+' '+('Total Overview');
         end;
      14..255: begin
           { ZeitCategories }
           if PosEx(('Time:'),ComboBoxY.Items[ComboBoxY.ItemIndex],1) = 1 then
           begin
             for i := 0 to Years-1 do
             begin
               CTimeIndex := FindKat(copy(ComboBoxY.Items[ComboBoxY.ItemIndex],7,length(ComboBoxY.Items[ComboBoxY.ItemIndex])-6),DGraphData[i].CTime);
               if CTimeIndex >= 0 then
               begin
                 GraphDataY[i].Data := TimeToHour(DGraphData[i].CTime[CTimeIndex].Value);
                 GraphDataY[i].Text := DGraphData[i].CTime[CTimeIndex].value;
               end
               else GraphDataY[i].Data := 0;
             end;
             YLabel := ('Time')+' [hh:mm]';
           end;

           { Categories }
           if PosEx(('Cat:'),ComboBoxY.Items[ComboBoxY.ItemIndex],1) = 1 then
           begin
             for i := 0 to Years-1 do
             begin
               KatIndex := FindKat(copy(ComboBoxY.Items[ComboBoxY.ItemIndex],6,length(ComboBoxY.Items[ComboBoxY.ItemIndex])-5),DGraphData[i].Kat);
               if KatIndex >= 0 then
               begin
                 GraphDataY[i].Data := StrtoInt(DGraphData[i].Kat[KatIndex].Value);
                 GraphDataY[i].Text := DGraphData[i].Kat[KatIndex].Value;
               end
               else GraphDataY[i].Data := 0;
             end;
             YLabel := ('Flights');
           end;

           { Contest dist }
           if PosEx(('ConD:'),ComboBoxY.Items[ComboBoxY.ItemIndex],1) = 1 then
           begin
             for i := 0 to Years-1 do
             begin
               KatIndex := FindKat(copy(ComboBoxY.Items[ComboBoxY.ItemIndex],6,length(ComboBoxY.Items[ComboBoxY.ItemIndex])-5),DGraphData[i].Contest);
               if KatIndex >= 0 then
               begin
                 GraphDataY[i].Data := StrtoFloat(DGraphData[i].Contest[KatIndex].Value);
                 GraphDataY[i].Text := DGraphData[i].Contest[KatIndex].Value;
               end
               else GraphDataY[i].Data := 0;
             end;
             YLabel := ('Contests')+' ['+StatDistUnit+']';
           end;

           { Contest points }
           if PosEx(('ConP:'),ComboBoxY.Items[ComboBoxY.ItemIndex],1) = 1 then
           begin
             for i := 0 to Years-1 do
             begin
               KatIndex := FindKat(copy(ComboBoxY.Items[ComboBoxY.ItemIndex],6,length(ComboBoxY.Items[ComboBoxY.ItemIndex])-5),DGraphData[i].Contest);
               if KatIndex >= 0 then
               begin
                 GraphDataY[i].Data := StrtoFloat(DGraphData[i].Contest[KatIndex].Value2);
                 GraphDataY[i].Text := DGraphData[i].Contest[KatIndex].Value2;
               end
               else GraphDataY[i].Data := 0;
             end;
             YLabel := ('Contests')+' [pt]';
           end;
         end;
    end; { case }

    MaxY := 0.001; // sonst evt. Division durch Null
    { Höchsten Wert ermitteln }
    for i := StartIndex to EndIndex do
    if GraphDataY[i].Data > MaxY then MaxY := GraphDataY[i].Data;



    { Skalierung }
    IncrY := 5000;
    if MaxY < 20000 then IncrY := 2000;
    if MaxY < 10000 then IncrY := 1000;
    if MaxY < 5000 then IncrY := 500;
    if MaxY < 2000 then IncrY := 200;
    if MaxY < 1000 then IncrY := 100;
    if MaxY < 500 then IncrY := 50;
    if MaxY < 200 then IncrY := 20;
    if MaxY < 100 then IncrY := 10;
    if MaxY < 50 then IncrY := 5;
    if MaxY < 20 then IncrY := 2;
    if MaxY < 10 then IncrY := 1;
    if MaxY < 5 then IncrY := 0.5;
    if MaxY < 1 then IncrY := 0.1;
    if MaxY < 0.1 then
    begin
      MaxY := 0.1;
      IncrY := 0.01;
    end;

    { Scale }
    for i := StartIndex to EndIndex do
    GraphDataY[i].Data := Round(GraphDataY[i].Data /MaxY*(yBottom-50));

    { Draw }
    with FStat_Graph.DrawArea.Canvas do
    begin
      { Bars }
      if FStat_Graph.RBBalken.checked then
      begin
        for i := StartIndex to EndIndex do
        begin
          myRect := Rect((50+YAxis*IncrBb)+(i-StartIndex)*IncrYear,yBottom,50+IncrBb+YAxis*IncrBb
            +(i-StartIndex)*IncrYear,yBottom-Round(GraphDataY[i].Data));
          Brush.Color := ColorY;
          Fillrect(myrect);
          FStat_Graph.VertText(GraphDataY[i].Text, myRect.Left+(IncrBb div 2)-7,myRect.Bottom-4, 'Left');
        end;
      end
      else
      begin
        { Lines }
        for i := StartIndex to EndIndex do
        begin
          SetLength(myPoints,TempYears+1);
          myPoints[i-StartIndex].X := 50+IncrBB+(i-StartIndex)*IncrYear;
          myPoints[i-StartIndex].Y := yBottom-Round(GraphDataY[i].Data);
        end;
        Pen.Color := ColorY;
        Pen.Width := 2;
        Polyline(myPoints);
      end;

      { Label y-axis }
      Pen.Color := clBlack;
      Pen.Width := 1;
      Brush.Color := clBtnFace;
      Font.Color := ColorY;
      SetRoundMode(rmDown);
      { Label for minutes }
      if (COmboBoxY.ItemIndex in [1,2,7..255]) and (MaxY < 1) then
      begin
        for i := 1 to Round(MaxY*60 / 20) do
        begin
          TextOut(23+YAxis*(xRight-10), yBottom-6-Round(i*20*(yBottom-50)/MaxY/60), InttoStr(i*20));
          Rectangle(49+YAxis*(xRight-45),yBottom-Round(i*20*(yBottom-50)/MaxY/60),45+YAxis
            *(xRight-45),yBottom+1-Round(i*20*(yBottom-50)/MaxY/60));
        end;
        YLabel := copy(YLabel,1,Length(Ylabel)-7)+ '[min]';
      end
      else
      { Other labels }
      begin
        for i := 1 to Round(MaxY / IncrY) do
        begin
          TextOut(20+YAxis*(xRight-10), yBottom-6-Round(i*IncrY*(yBottom-50)/MaxY), FormatFloat('0.##',i*IncrY));
          Rectangle(49+YAxis*(xRight-45),yBottom-Round(i*IncrY*(yBottom-50)/MaxY),45+YAxis
            *(xRight-45),yBottom+1-Round(i*IncrY*(yBottom-50)/MaxY));
        end;
      end;
      SetRoundMode(rmNearest);
      FStat_Graph.VertText(YLabel,YAxis*(xRight+35),yBottom div 2 + 50,'Left');
    end;
  end; { Procedure DrawYAxis }
{----------}
begin
  FStat_Graph.CreateDrawArea;

  xLeft := 50;
  xRight := FStat_Graph.DrawArea.Width-70;
  yTop := 40;
  yBottom := FStat_Graph.DrawArea.Height-85;

  { Find first and last year with data }
  StartIndex := 0;
  EndIndex := Years-1;

  for i := high(DGraphData) downto 0 do
  if DGraphData[i].Flights > 0 then
  StartIndex := i;

  for i := 0 to high(DGraphData) do
  if DGraphData[i].Flights > 0 then
  EndIndex := i;
  TempYears := EndIndex-StartIndex;

  { Bar width }
  IncrYear := (FStat_Graph.DrawArea.Width-70-49) div (TempYears+1);
  if IncrYear > 100 then IncrYear := 100;
  IncrBb := IncrYear div 5*2;

  with FStat_Graph.DrawArea.Canvas do
  begin
    myRect := Rect(0,0,FStat_Graph.DrawArea.Width,FStat_Graph.DrawArea.Height);
    Brush.Color := clBtnFace;
    Fillrect(myrect);

    { Canvas }
    Pen.Color := clBlack;
    SetLength(myPoints,4);
    myPoints[0].X := xLeft;
    myPoints[0].Y := yTop;
    myPoints[1].X := xLeft;
    myPoints[1].Y := yBottom;
    myPoints[2].X := xRight;
    myPoints[2].Y := yBottom;
    myPoints[3].X := xRight;
    myPoints[3].Y := yTop;
    Polyline(myPoints);

    { Label year axis }
    Brush.Color := clBtnFace;
    for i := StartIndex to EndIndex do TextOut(xLeft-10+IncrBb+(i-StartIndex)*IncrYear,yBottom+5,Copy(InttoStr(StartYear+i),3,2));
  end;
  DrawYAxis(FStat_Graph.CBY1,clFRed,0);
  DrawYAxis(FStat_Graph.CBY2,clFBlue,1);
end;

// ----------------------------------------------------------------
// Draw tab
// ----------------------------------------------------------------
procedure TFStatistics.DrawTab;
const
  FixedCols = 18;
var
  i, j, CTimeIndex, KatIndex, Year: Integer;
  StartIndex, EndIndex, TempYears, RowIdx: Word;
  KatIdx, CTimeIdx: Word;
begin
  FStat_Graph.CreateTab;
  FStat_Graph.PanelGraph.visible := False;

  { find first and last year with data }
  StartIndex := 0;
  EndIndex := Years-1;

  for i := high(DGraphData) downto 0 do
  if DGraphData[i].Flights > 0 then
  StartIndex := i;

  for i := 0 to high(DGraphData) do
  if DGraphData[i].Flights > 0 then
  EndIndex := i;
  TempYears := EndIndex-StartIndex;

  CTimeIdx := length(CTime);
  KatIdx := {KatIdx +} length(Kat);

  FStat_Graph.Tab.ColCount := FixedCols+length(CTime)+length(Kat)+length(Contest)*2;
  for i := 0 to high(CTime) do FStat_Graph.Tab.Cells[FixedCols+i,0] := CTime[i].Name;
  for i := 0 to high(Kat) do FStat_Graph.Tab.Cells[FixedCols+i+CTimeIdx,0] := Kat[i].Name;
  for i := 0 to high(Contest) do FStat_Graph.Tab.Cells[FixedCols+i*2+KatIdx,0] := Contest[i].Name;
  for i := 0 to high(Contest) do FStat_Graph.Tab.Cells[FixedCols+i*2+KatIdx+1,0] := Contest[i].Name;

  FStat_Graph.Tab.RowCount := TempYears+2;
  for Year := StartIndex to EndIndex do
  begin
    RowIdx := Year-StartIndex+1;
    FStat_Graph.Tab.Cells[0,RowIdx] := InttoStr(StartYear+Year);
    if DGraphData[Year].Flights > 0 then
      FStat_Graph.Tab.Cells[1,RowIdx] := InttoStr(DGraphData[Year].Flights);
    if DGraphData[Year].W > 0 then
      FStat_Graph.Tab.Cells[2,RowIdx] := InttoStr(DGraphData[Year].W);
    if DGraphData[Year].F > 0 then
      FStat_Graph.Tab.Cells[3,RowIdx] := InttoStr(DGraphData[Year].F);
    if DGraphData[Year].E > 0 then
      FStat_Graph.Tab.Cells[4,RowIdx] := InttoStr(DGraphData[Year].E);
    if DGraphData[Year].A > 0 then
      FStat_Graph.Tab.Cells[5,RowIdx] := InttoStr(DGraphData[Year].A);
    if DGraphData[Year].G > 0 then
      FStat_Graph.Tab.Cells[6,RowIdx] := InttoStr(DGraphData[Year].G);
    if DGraphData[Year].Time <> '0:00' then
      FStat_Graph.Tab.Cells[7,RowIdx] := DGraphData[Year].Time;
    if DGraphData[Year].Flights > 0 then
      FStat_Graph.Tab.Cells[8,RowIdx] := avgTime(DGraphData[Year].Time,DGraphData[Year].Flights);
    if DGraphData[Year].Distance > 0 then
      FStat_Graph.Tab.Cells[9,RowIdx] := FormatFloat('0',DGraphData[Year].Distance)+' '+StatDistUnit;
    if DGraphData[Year].Distance > 0 then
      FStat_Graph.Tab.Cells[10,RowIdx] := InttoStr(avgSpeed(Round(DGraphData[Year].Distance),DGraphData[Year].DistanceTime))+' '+GetSpeedUnit(StatDistUnit);
    if DGraphData[Year].Passengers > 0 then
      FStat_Graph.Tab.Cells[11,RowIdx] := IntToStr(DGraphData[Year].Passengers);
    if (DGraphData[Year].Passengers > 0) and (DGraphData[Year].Flights > 0) then
      FStat_Graph.Tab.Cells[12,RowIdx] := FormatFloat('0.00',DGraphData[Year].Passengers / DGraphData[Year].Flights);

    FStat_Graph.Tab.Cells[13,RowIdx] := FormatFloat('0.00',DGraphData[Year].CfF)+' '+GenSettings.Values['Currency'];
    FStat_Graph.Tab.Cells[14,RowIdx] := FormatFloat('0.00',DGraphData[Year].CfC)+' '+GenSettings.Values['Currency'];
    FStat_Graph.Tab.Cells[15,RowIdx] := FormatFloat('0.00',DGraphData[Year].LaF)+' '+GenSettings.Values['Currency'];
    FStat_Graph.Tab.Cells[16,RowIdx] := FormatFloat('0.00',DGraphData[Year].EfF)+' '+GenSettings.Values['Currency'];
    FStat_Graph.Tab.Cells[17,RowIdx] := FormatFloat('0.00',(DGraphData[Year].EfF-(DGraphData[Year].CfF+DGraphData[Year].CfC+DGraphData[Year].LaF)))+' '+GenSettings.Values['Currency'];

    CTimeIdx := FixedCols + length(CTime);
    KatIdx := CTimeIdx + length(Kat);

    { time cat }
    for j := FixedCols to CTimeIdx-1 do
    begin
      CTimeIndex := FindKat(FStat_Graph.Tab.Cells[j,0],DGraphData[Year].CTime);
      if CTimeIndex >= 0 then FStat_Graph.Tab.Cells[j,RowIdx] := DGraphData[Year].CTime[CTimeIndex].Value;
    end;

    { categories }
    for j := CTimeIdx to KatIdx-1 do
    begin
      KatIndex := FindKat(FStat_Graph.Tab.Cells[j,0],DGraphData[Year].Kat);
      if KatIndex >= 0 then FStat_Graph.Tab.Cells[j,RowIdx] := DGraphData[Year].Kat[KatIndex].Value;
    end;

    { contests }
    for j := 0 to length(Contest)-1 do
    begin
      KatIndex := FindKat(FStat_Graph.Tab.Cells[KatIdx+j*2,0],DGraphData[Year].Contest);
      if KatIndex >= 0 then
      begin
        FStat_Graph.Tab.Cells[KatIdx+j*2,RowIdx] := FormatFloat('0',StrtoFloat(DGraphData[Year].Contest[KatIndex].Value))+' '+StatDistUnit;
        FStat_Graph.Tab.Cells[KatIdx+j*2+1,RowIdx] := FormatFloat('0',StrtoFloat(DGraphData[Year].Contest[KatIndex].Value2))+' pt';
      end;
    end;
  end;
  FStat_Graph.Tab.Selection := DeSelectRect;
end;

procedure TFStatistics.CLBKatClickCheck(Sender: TObject);
begin
  with CLBKat do
  begin
    if State[ItemIndex] = cbChecked then State[ItemIndex] := cbUnchecked
    else if State[ItemIndex] = cbGrayed then State[ItemIndex] := cbChecked
    else if State[ItemIndex] = cbUnchecked then State[ItemIndex] := cbGrayed;
  end;
end;

procedure TFStatistics.CBKatGenChange(Sender: TObject);
var
  PKat: ^TKat;
  i: word;
begin
  PKat := nil;
  case CBKatGen.ItemIndex of
    0: PKat := @Kat;
    1: PKat := @CTime;
    2: PKat := @Contest;
  end;

  if not Assigned(PKat^) then
  begin
    GridKatG.visible := False;
    exit;
  end;

  GridKatG.Cells[0,0]  := '';
  GridKatG.Cells[1,0]  := '';
  GridKatG.Cells[2,0]  := '';

  if PKat^ = Contest then GridKatG.ColWidths[0] := 75
  else GridKatG.ColWidths[0] := 135;

  GridKatG.visible := True;
  GridKatG.RowCount := length(PKat^);
  for i := 0 to high(PKat^) do
  begin
    GridKatG.Cells[0,i] := PKat^[i].Name;
    GridKatG.Cells[1,i] := PKat^[i].Value;
    if PKat^ = Contest then
    begin
      GridKatG.Cells[1,i] := FormatFloat('0',StrToFloat(PKat^[i].Value))+' '+RGDistUnit.Items[RGDistUnit.ItemIndex];;
      GridKatG.Cells[2,i] := FormatFloat('0',StrToFloat(PKat^[i].Value2))+' pt';
    end;
  end;
end;

procedure TFStatistics.CBKatDetailChange(Sender: TObject);
var PKat  : ^TKat;
    Nr, i : Integer;
begin
  Pkat := nil;
  Nr := StrtoInt(SGDetail.Cells[0, SGDetailRow]);

  case CBKatDetail.ItemIndex of
    0: PKat := @PStatData^.StatItems[Nr].Kat;
    1: PKat := @PStatData^.StatItems[Nr].CTime;
    2: PKat := @PStatData^.StatItems[Nr].Contest;
  end;

  if not Assigned(PKat) then
  begin
    GridKatDetail.visible := False;
    exit;
  end;
  GridKatDetail.visible := True;

  GridKatDetail.Cells[0,0] := '';
  GridKatDetail.Cells[1,0] := '';
  GridKatDetail.Cells[2,0] := '';

  if PKat^ = PStatData^.StatItems[nr].Contest then GridKatDetail.ColWidths[0] := 75
  else GridKatDetail.ColWidths[0] := 135;

  GridKatDetail.RowCount := high(PKat^)+1;
  for i := 0 to high(PKat^) do
  begin
    GridKatDetail.Cells[0,i] := PKat^[i].Name;
    GridKatDetail.Cells[1,i] := PKat^[i].Value;

    if PKat^ = PStatData^.StatItems[nr].Contest then
    begin
      GridKatDetail.Cells[1,i] := FormatFloat('0',StrToFloat(PKat^[i].Value))+' '+RGDistUnit.Items[RGDistUnit.ItemIndex];
      GridKatDetail.Cells[2,i] := FormatFloat('0',StrToFloat(PKat^[i].Value2))+' pt';
    end;
  end;
end;

// ----------------------------------------------------------------
// Draw kat grid
// ----------------------------------------------------------------
procedure TFStatistics.GridKatDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  with TStringGrid(Sender) do
  begin
    //Canvas.Brush.Color := clInfoBk;
    Canvas.FillRect(Rect);

    if (ACol = 1) or (ACol = 2) then
      DrawText(Canvas.Handle, PChar(Cells[ACol, ARow]), StrLen(PChar(Cells[ACol, ARow])), Rect, DT_RIGHT)
    else
      DrawText(Canvas.Handle, PChar(Cells[ACol, ARow]), StrLen(PChar(Cells[ACol, ARow])), Rect, DT_LEFT);
  end;
end;

end.
