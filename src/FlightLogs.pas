unit FlightLogs;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Buttons, LazLogger;

type
  TFFlightLogs = class(TForm)
    Panel1: TPanel;
    ButtonNew: TBitBtn;
    ButtonDelete: TBitBtn;
    ButtonEdit: TBitBtn;
    ButtonOK: TBitBtn;
    Label12: TLabel;
    LBFlu: TListBox;
    procedure FormShow(Sender: TObject);
    procedure ButtonEditClick(Sender: TObject);
    procedure ButtonNewClick(Sender: TObject);
    procedure ButtonDeleteClick(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure LBFluDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
  private
    procedure RefreshLBFlu;
  public
    { Public-Deklarationen }
  end;

var
  FFlightLogs: TFFlightLogs;

implementation

uses Main, Tools, ToolsGrid;

{$R *.lfm}

// ----------------------------------------------------------------
// On Create
// ----------------------------------------------------------------
procedure TFFlightLogs.FormCreate(Sender: TObject);
begin
  //TranslateComponent(Self);
end;

// ----------------------------------------------------------------
// Form Show
// ----------------------------------------------------------------
procedure TFFlightLogs.FormShow(Sender: TObject);
begin
  //ActiveControl := EditName;
  RefreshLBFlu;
end;

// ----------------------------------------------------------------
// Refresh flight log list
// ----------------------------------------------------------------
procedure TFFlightLogs.RefreshLBFlu;
var
  i: word;
begin
  LBFlu.Items.Clear;
  if FMain.FlightLogList.Count > 0 then
  begin
    for i := 0 to FMain.FlightLogList.Count-1 do
      LBFlu.Items.Add(GridChild(i).caption);
    LBFlu.ItemIndex := 0;
  end;
end;

// ----------------------------------------------------------------
// Add flight log
// ----------------------------------------------------------------
procedure TFFlightLogs.ButtonNewClick(Sender: TObject);
  var InputStr: String;
begin
  if InputQuery(('Please enter flight log name'), ('Name'), InputStr) then
  begin
    if LBFlu.Items.IndexOf(InputStr) > -1 then
      MessageDlg(format(('The name already exists!'), [InputStr]),mtInformation,[mbOK],0)
    else
      FMain.CreateNewFlightLog(InputStr, DefaultTableCols);
    RefreshLBFlu;
  end;
end;

// ----------------------------------------------------------------
// Edit flight log
// ----------------------------------------------------------------
procedure TFFlightLogs.ButtonEditClick(Sender: TObject);
var InputStr: String;
begin
  if LBFlu.ItemIndex = -1 then
    Exit;
  InputStr := LBFlu.Items[LBFlu.ItemIndex];
  if InputQuery(('Please enter flight log name'), ('Name'), InputStr) then
  begin
    if LBFlu.Items.IndexOf(InputStr) > -1 then
      MessageDlg(('The name already exists!'), mtInformation, [mbOK], 0)
    else
      GridChild(LBFlu.ItemIndex).caption := InputStr;
    RefreshLBFlu;
  end;
end;

// ----------------------------------------------------------------
// Remove flight log
// ----------------------------------------------------------------
procedure TFFlightLogs.ButtonDeleteClick(Sender: TObject);
var
  Answer: Integer;
begin
  if LBFlu.ItemIndex = -1 then
    Exit;
  Answer := MessageDlg(format(('Are you sure you want to delete the flightlog ''%s''?'),
    [GridChild(LBFlu.ItemIndex).caption]),mtConfirmation,[mbYes,mbNo],0);
  if answer = mrNo then Exit
  else
    GridChild(LBFlu.ItemIndex).Free;
  RefreshLBFlu;
end;

// ----------------------------------------------------------------
// Exit
// ----------------------------------------------------------------
procedure TFFlightLogs.ButtonOKClick(Sender: TObject);
begin
  if FMain.FlightLogList.Count = 0 then
  begin
    MessageDlg(('Please create at least one flightlog'),mtError,[mbOK],0);
    ModalResult := mrNone;
  end;
end;

// ----------------------------------------------------------------
// Exit
// ----------------------------------------------------------------
procedure TFFlightLogs.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if FMain.FlightLogList.Count = 0 then
  begin
    MessageDlg(('Please create at least one flightlog'),mtError,[mbOK],0);
    Action := caNone;
  end;
end;

procedure TFFlightLogs.LBFluDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
begin
  //TListBox(Control).Canvas.FillRect(Rect);
  //InflateRect(Rect, 0, -2);
  //DrawText(LBFlu.Canvas.Handle, PChar(LBFlu.Items[Index]), StrLen(PChar(LBFlu.Items[Index])), Rect,DT_CENTER);
end;

end.
