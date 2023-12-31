unit Airports;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Grids, ComCtrls, MaskEdit;

type
  TFAirports = class(TForm)
    Panel1: TPanel;
    ButtonOK: TBitBtn;
    ButtonBeenden: TBitBtn;
    StatusBar1: TStatusBar;
    ButtonFlp: TSpeedButton;
    ButtonOwnFlp: TSpeedButton;
    PanelOwnFlp: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    ButtonChange: TBitBtn;
    ButtonDelete: TBitBtn;
    ButtonNeu: TBitBtn;
    EditName: TEdit;
    EditICAO: TEdit;
    MEBreit: TMaskEdit;
    RBBreitN: TRadioButton;
    RBBreitS: TRadioButton;
    Panel3: TPanel;
    RBLaengO: TRadioButton;
    RBLaengW: TRadioButton;
    MELaeng: TMaskEdit;
    GridOwnFlp: TStringGrid;
    GridFlp: TStringGrid;
    Bevel1: TBevel;
    LabelGetAirports: TLabel;
    PanelFindEingabe: TPanel;
    RBName: TRadioButton;
    RBKennung: TRadioButton;
    Label4: TLabel;
    EditFind: TEdit;
    procedure ButtonNeuClick(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ButtonDeleteClick(Sender: TObject);
    procedure GridOwnFlpClick(Sender: TObject);
    procedure ButtonChangeClick(Sender: TObject);
    procedure ButtonFlpClick(Sender: TObject);
    procedure ButtonOwnFlpClick(Sender: TObject);
    procedure EditFindChange(Sender: TObject);
    procedure LabelEmailClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure LabelGetAirportsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure GridFlpDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
  private
    procedure onHint(Sender: TObject);
  public
    { Public-Deklarationen }
  end;

var
  FAirports: TFAirports;

implementation

uses Main, Input, Tools, ToolsGrid;

{$R *.lfm}


// ----------------------------------------------------------------
// Form create
// ----------------------------------------------------------------
procedure TFAirports.FormCreate(Sender: TObject);
begin
  //TranslateComponent(Self);
  //LabelGetAirports.Hint := FluPPDomain+'/airports/'+StrToHTML(GetFileVersion(ParamStr(0)));
end;

// ----------------------------------------------------------------
// Form show
// ----------------------------------------------------------------
procedure TFAirports.FormShow(Sender: TObject);
var
  l,i,n,Zeile: Word;
  Airport: TAirport;
begin
  Application.OnHint := onHint;
  with GridOwnFlp  do
  begin
    RowCount := 2;

    ColWidths[0]  := 132;
    ColWidths[1]  := 50;
    ColWidths[2]  := 70;
    ColWidths[3]  := 70;

    Cells[0,0]  := ('Name');
    Cells[1,0]  := ('ICAO');
    Cells[2,0]  := ('Latitude');
    Cells[3,0]  := ('Longitude');
  end;

  with GridFlp do
  begin
    RowCount := 2;
    ColWidths[0]  := 132;
    ColWidths[1]  := 50;
    ColWidths[2]  := 70;
    ColWidths[3]  := 70;

    Cells[0,0]  := ('Name');
    Cells[1,0]  := ('ICAO');
    Cells[2,0]  := ('Latitude');
    Cells[3,0]  := ('Longitude');
  end;
  Zeile := 1;

  for Airport in FMain.AirportData do
  begin

  end;

  if Zeile > 1 then GridFlp.RowCount := Zeile
  else GridFlp.RowCount := 2;

  ButtonFlp.Down := True;
  ButtonFlpClick(Self);
  GridFlp.Row := 1;
  ActiveControl := EditFind;
end;

// ----------------------------------------------------------------
// onHint
// ----------------------------------------------------------------
procedure TFAirports.onHint(Sender: TObject);
begin
  StatusBar1.Panels[0].Text := GetLongHint(Application.Hint);
end;

// ----------------------------------------------------------------
// Add new airport
// ----------------------------------------------------------------
procedure TFAirports.ButtonNeuClick(Sender: TObject);
begin
  if EditName.Text = '' then
  begin
    MessageDlg(('Please enter airport name!'),mtInformation,[mbOK],0);
    FAirports.ActiveControl := EditName;
    Exit;
  end;
  if (MEBreit.Text = '  �  ''  "') or (MElaeng.Text = '  �  ''  "') then
  begin
    MessageDlg(('Please enter airport position!'),mtInformation,[mbOK],0);
    Exit
  end;
  if ((EditICAO.Text <> '') and (SearchInGrid(GridOwnFlp, EditICAO.Text))) or
    (SearchInGrid(GridOwnFlp, EditName.Text)) then
    begin
      MessageDlg(('Airport already exists!'),mtInformation,[mbOK],0);
      Exit;
    end;
  with GridOwnFlp do
  begin
    if (RowCount = 2) and (cells[0,1] = '') then
    begin
      Row := 1;
    end
    else Row := RowCount;
    if Row > 1 then RowCount := RowCount +1;
    Cells[0,Row] := EditName.Text;
    Cells[1,Row] := EditICAO.Text;
    if RBBreitN.checked then Cells[2,Row] := 'N'+MEBreit.Text;
    if RBBreitS.checked then Cells[2,Row] := 'S'+MEBreit.Text;
    if RBLaengO.checked then Cells[3,Row] := 'O'+MELaeng.Text;
    if RBLaengW.checked then Cells[3,Row] := 'W'+MELaeng.Text;
  end;
end;

// ----------------------------------------------------------------
// Save user airports
// ----------------------------------------------------------------
procedure TFAirports.ButtonOKClick(Sender: TObject);
var
  Datei: TextFile;
  i,j: Word;
  stream: String;
begin
  if GridOwnFlp.cells[0,1] <> '' then begin
    AssignFile(Datei, FlpTempDir+'\userairports.txt');
    ReWrite(Datei);
    for i := 1 to GridOwnFlp.RowCount -1 do begin
      for j := 0 to 3 do stream := stream + GridOwnFlp.Cells[j,i]+';';
      writeln(Datei, stream);
      stream := '';
    end;
    CloseFile(Datei);

    FMain.ReadAirportData;
  end else
    DeleteFile(FlpTempDir+'\userairports.txt');

  Modalresult := mrOK;
end;

// ----------------------------------------------------------------
// Delete airport
// ----------------------------------------------------------------
procedure TFAirports.ButtonDeleteClick(Sender: TObject);
var i: word;
begin
  if GridOwnFlp.RowCount > 2 then
    GridOwnFlp.DeleteRow(GridOwnFlp.Row)
  else
    for i := 0 to 3 do GridOwnFlp.Cells[i,1] := '';
end;

// ----------------------------------------------------------------
// Select airport
// ----------------------------------------------------------------
procedure TFAirports.GridOwnFlpClick(Sender: TObject);
begin
  if GridOwnFlp.Cells[0,1] = '' then Exit;
  EditName.Text := GridOwnFlp.Cells[0,GridOwnFlp.Row];
  EditICAO.Text := GridOwnFlp.Cells[1,GridOwnFlp.Row];
  if GridOwnFlp.Cells[2,GridOwnFlp.Row][1] = 'N' then RBBreitN.checked := True
  else RBBreitS.checked := True;
  if GridOwnFlp.Cells[3,GridOwnFlp.Row][1] = 'O' then RBLaengO.checked := True
  else RBLaengW.checked := True;

  MEBreit.Text := copy(GridOwnFlp.Cells[2,GridOwnFlp.Row],2,length(GridOwnFlp.Cells[2,GridOwnFlp.Row])-1);
  MELaeng.Text := copy(GridOwnFlp.Cells[3,GridOwnFlp.Row],2,length(GridOwnFlp.Cells[3,GridOwnFlp.Row])-1);
end;

// ----------------------------------------------------------------
// Change airport
// ----------------------------------------------------------------
procedure TFAirports.ButtonChangeClick(Sender: TObject);
begin
  with GridOwnFlp do
  begin
    Cells[0,Row] := EditName.Text;
    Cells[1,Row] := EditICAO.Text;
    if RBBreitN.checked then Cells[2,Row] := 'N'+MEBreit.Text;
    if RBBreitS.checked then Cells[2,Row] := 'S'+MEBreit.Text;
    if RBLaengO.checked then Cells[3,Row] := 'O'+MELaeng.Text;
    if RBLaengW.checked then Cells[3,Row] := 'W'+MELaeng.Text;
  end;
end;

// ----------------------------------------------------------------
// Show airport darabase
// ----------------------------------------------------------------
procedure TFAirports.ButtonFlpClick(Sender: TObject);
begin
  GridOwnFlp.visible := False;
  GridFlp.visible := True;
  PanelOwnFlp.visible := False;
  LabelGetAirports.Visible := true;
end;

// ----------------------------------------------------------------
// Show custom airport darabase
// ----------------------------------------------------------------
procedure TFAirports.ButtonOwnFlpClick(Sender: TObject);
begin
  GridOwnFlp.visible := True;
  GridFlp.visible := False;
  PanelOwnFlp.visible := True;
  LabelGetAirports.Visible := false;
end;

// ----------------------------------------------------------------
// Find airport
// ----------------------------------------------------------------
procedure TFAirports.EditFindChange(Sender: TObject);
var aRow: Integer; 
begin
  if ButtonFlp.Down = True then
  begin
    if SearchInGrid(GridFlp, EditFind.Text, aRow) then
      GridFlp.Row := aRow
  end
  else
    if SearchInGrid(GridOwnFlp, EditFind.Text, aRow) then
      GridOwnFlp.Row := aRow;
end;

// ----------------------------------------------------------------
// Email
// ----------------------------------------------------------------
procedure TFAirports.LabelEmailClick(Sender: TObject);
begin
end;

// ----------------------------------------------------------------
// Close
// ----------------------------------------------------------------
procedure TFAirports.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Application.OnHint := FMain.onHint;
end;

// ----------------------------------------------------------------
// Download new airports
// ----------------------------------------------------------------
procedure TFAirports.LabelGetAirportsClick(Sender: TObject);
begin
//   OpenDocument(PAnsiChar(FluPPDomain+'/airports/'+StrToHTML(GetFileVersion(ParamStr(0))))); { *Converted from ShellExecute* }
end;

// ----------------------------------------------------------------
// Draw cell (colorbands)
// ----------------------------------------------------------------
procedure TFAirports.GridFlpDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  DrawColorbands(TSTringGrid(Sender), ACol, ARow, Rect, State, taLeftJustify);
end;

end.
