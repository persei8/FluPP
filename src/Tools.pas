unit Tools;

{$MODE Delphi}

interface

uses SysUtils, Math, StrUtils, DateUtils, Classes, LCLIntf, LCLType, Dialogs,
  Grids, CheckLst, StdCtrls, LazFileUtils, csvdocument, fgl;

type
  TAirport = class
  public
    AirportName: String;
    ICAO: String;
    Country: String;
    Lat: String;
    Lon: String;
  end;

  type
    TAirportList = TFPGObjectList<TAirport>;

  TAirports = class
  private
    AirportList: TAirportList;
    function Get(Index: Integer): TAirport;
    procedure Put(Index: Integer; const Airport: TAirport);
    function GetCount: Integer;
  public
    constructor Create;
    property Airport[Index: Integer]: TAirport read Get write Put; default;
    function Add(const Airport: TAirport): Integer;
    property Count: Integer read GetCount;
    function ReadAirportData(FilePath: String): Boolean;
    function Find(AirportName: String; var Airport: TAirport): Boolean;
    function Distance(AirportName1: String; AirportName2: String; DistUnit: String): Real;
  end;

var
  WorkingDir : string = '';


function CalcSGesZeit(CTime: String; Time: String): String;
function AddTime(Time1: String; Time2: String): String;
function CalcSGesStart(CStarts: Integer; GesStarts: Integer): String;
function TimeToExact(Time: String): Real;
function avgTime(Time: String; Flights: Integer): String;
function avgSpeed(Distance: Integer; Time: String): Word;
function avgPassengers(Passengers, Flights: Word): Real;
function RoundTime(Time: String): String;
function ExtractYear(Date: String): Word;
function PosToDeg(Pos: String): Real;
function TimeToMinute(Time: String): Integer;
function TimeToHour(Time: String): Real;
function MinuteToTime(Minute: Integer): String;
function ConvertDistUnits(Value: Real; Unit1, Unit2: String): Real;
function GetSpeedUnit(aUnit: String): String;
function CalcDist(BreitTotStO, LaengTotStO, BreitTotLaO, LaengTotLaO: Real; DistUnit: String): Real;
function IsInteger(Value: String): Boolean;
function IsTime(Time: String): Boolean;
function IsDate(Date: String): Boolean;
function IsBool(Bool: String): Boolean;
function NormalCase(S: String): String;
function PipeToCR(S: String): String;
function StrToHTML(S: String): String;
procedure ReadTStrings(S: String; var Strings: TStringList);
function readValueTStrings(S: String; var Strings: TStringList): Integer;
procedure AssignValues(StringsFrom: TStringList; StringsTo: TStringList);
procedure AssignNames(StringsFrom: TStringList; StringsTo: TStrings);
function WriteTStrings(Strings: TStringList): String;
function ReplaceString(S: String; replaceString, withString: Char): String;
function InList(Value, ValueType: String): Boolean;
//function GetImageLinkTimeStamp(const FileName: string): DWORD;
function GetStringObject(StringList: TStringList; Name, ObjName: String): String;
procedure SetStringObject(StringList: TStringList; Name, ObjName, ObjValue: String);
procedure DeleteStringObject(StringList: TStringList; Index: Integer);
procedure FreeObjStringList(StringList: TStringList);
//function GetFileVersion(FileName: WideString): String;
function GetActualDir(Extract : boolean) : String;
procedure StringsToCLB(var Cat: TSTringList; Data: String; Grid: TStringGrid; CLB: TCheckListBox);  overload;
procedure StringsToCLB(var Cat: TSTringList; Data:String; CLB: TCheckListBox); overload;
procedure GrayCLB(var Cat: TSTringList; Data: String; CLB: TCheckListBox);
procedure StringToStringList(var List: TSTringList; Data: String);

implementation

{--\/-- TAirportList --\/--}

constructor TAirports.Create;
begin
  Inherited;

  AirportList := TAirportList.create;
end;

procedure TAirports.Put(Index: Integer; const Airport: TAirport);
begin
  AirportList[Index] := Airport;
end;

function TAirports.Get(Index: Integer): TAirport;
begin
  Result := AirportList[Index];
end;

function TAirports.Add(const Airport: TAirport): Integer;
begin
  Result := AirportList.Add(Airport);
end;

function TAirports.GetCount: Integer;
begin
  Result := AirportList.Count;
end;

// ----------------------------------------------------------------
// Read csv airport data
// "country_code","region_name","iata","icao","airport","latitude","longitude"
// ----------------------------------------------------------------
function TAirports.ReadAirportData(FilePath: String): Boolean;
var
  CSVDoc: TCSVDocument;
  row: Integer;
  TmpAirport: TAirport;
begin
  ReadAirportData := False;
  CSVDoc := TCSVDocument.Create;
  if not(FileExistsUTF8(FilePath)) then exit;

  CSVDoc.Delimiter:=',';
  CSVDoc.QuoteChar:='"';
  CSVDoc.LoadFromFile(FilePath);
  TmpAirport := TAirport.create;
  for row := 1 to CSVDoc.RowCount-1 do
  begin
    TmpAirport.AirportName := CSVDoc.Cells[4, row];
    TmpAirport.ICAO := CSVDoc.Cells[3, row];
    TmpAirport.Country := CSVDoc.Cells[0, row];
    TmpAirport.Lat := CSVDoc.Cells[5, row];
    TmpAirport.Lon := CSVDoc.Cells[6, row];
    AirportList.Add(TmpAirport);
  end;
end;

// ----------------------------------------------------------------
// Search aiport in database
// ----------------------------------------------------------------
function TAirports.Find(AirportName: String; var Airport: TAirport): Boolean;
var
  i: integer;
begin
  Result := False;
  if AirportName = '' then Exit;
  for i := 0 to AirportList.Count-1 do
  begin
    if (Uppercase(AirportList[i].ICAO) = Uppercase(AirportName)) or
     (Uppercase(AirportList[i].AirportName) = Uppercase(AirportName)) then
    begin
      Result := True;
      Airport := AirportList[i];
      Break;
    end;
  end;
end;

// ----------------------------------------------------------------
// Calc distance between airports
// ----------------------------------------------------------------
function TAirports.Distance(AirportName1: String; AirportName2: String; DistUnit: String): Real;
var
  BreitTotStO, LaengTotStO, BreitTotLaO, LaengTotLaO: Real;
  Airport1, Airport2: TAirport;
begin
  if (AirportName1 = '') or (AirportName2 = '') then
  begin
    Result := 0;
    Exit;
  end;
  if Find(AirportName1, Airport1) and Find(AirportName2, Airport2) then
  begin
    BreitTotStO := PosToDeg(Airport1.Lat);
    LaengTotStO := PosToDeg(Airport1.Lon);
    BreitTotLaO := PosToDeg(Airport2.Lat);
    LaengTotLaO := PosToDeg(Airport2.Lon);
    Result := CalcDist(BreitTotStO, LaengTotStO, BreitTotLaO, LaengTotLaO, DistUnit);
  end
  else Result := 0;
end;

{--/\-- TAirportList --/\--}

// ----------------------------------------------------------------
// Calc % of ctime
// ----------------------------------------------------------------
function CalcSGesZeit(CTime: String; Time: String):String;
var
  i, GesMinuten, GesCMinuten: Integer;
  Minuten, CMinuten, Stunden, CStunden: String;
begin
  i := 1;
  Stunden :=''; CStunden := ''; Minuten := ''; CMinuten := '';
  while (CTime[i] <> ':') do
  begin
    CStunden := CStunden + CTime[i];
    inc(i);
  end;
  CMinuten := copy(CTime,i+1,2);

  i :=1;
  while (Time[i] <> ':') do
  begin
    Stunden := Stunden + Time[i];
    inc(i);
  end;
  Minuten := copy(Time,i+1,2);

  GesMinuten := StrtoInt(Minuten) + (StrtoInt(Stunden)*60);
  GesCMinuten := StrtoInt(CMinuten) + (StrtoInt(CStunden)*60);
  if GesMinuten = 0 then Result := '0 %'
  else Result := format('%0.1f',[GesCMinuten/GesMinuten*100])+' %';
end;

// ----------------------------------------------------------------
// Add two times
// ----------------------------------------------------------------
function AddTime(Time1: String; Time2: String):String;
var
  stunden1, stunden2, GesStrMinuten, GesStrStunden: String;
  i,minuten1, minuten2, Gesstunden, Gesminuten: Integer;
begin

  {  Time1 }
  if Time1 = '' then Time1 := '00:00';
  i := 1; stunden1 := '';
  while (Time1[i] <> ':') and (i <= length(Time1)) do
  begin
    stunden1 := stunden1 + Time1[i];
    inc(i);
  end;
  if length(Time1) >= i+2 then minuten1 := StrtoInt(copy(Time1,i+1,2))
  else minuten1 := 0;

  { Time2 }
  if Time2 = '' then Time2 := '00:00';
  i := 1; stunden2 := '';
  while (Time2[i] <> ':') and (i <= length(Time2)) do
  begin
    stunden2 := stunden2 + Time2[i];
    inc(i);
  end;
  if length(Time2) >= i+2 then minuten2 := StrtoInt(copy(Time2,i+1,2))
  else minuten2 := 0;

  GesStunden := StrtoInt(stunden1) + StrtoInt(stunden2) + ((minuten1 + minuten2) div 60);
  if StrtoInt(stunden1) < 0 then GesMinuten := (minuten1 - minuten2) mod 60
  else GesMinuten := (minuten1 + minuten2) mod 60;
  if GesMinuten < 0 then
  begin
    inc(GesStunden);
    GesMinuten := 60-abs(GesMinuten);
  end;
  GesStrMinuten := Inttostr(GesMinuten);
  GesStrStunden := Inttostr(abs(GesStunden));
  if length(GesStrMinuten) = 1 then insert('0',GesStrMinuten,1);
  Result := GesStrStunden+':'+ GesStrMinuten;
end;

// ----------------------------------------------------------------
//
// ----------------------------------------------------------------
function CalcSGesStart(CStarts: Integer; GesStarts: Integer):String;
begin
  if GesStarts = 0 then Result := '0 %'
  else Result := format('%0.1f',[CStarts/GesStarts*100])+' %';
end;

// ----------------------------------------------------------------
//
// ----------------------------------------------------------------
function TimeToExact(Time: String): Real;
var
  j: Integer;
  Minuten, Stunden: String;
begin
  if Time = '' then
  begin
    Result := 0;
    Exit;
  end;
  Minuten := ''; Stunden := ''; j:= 1;
  while (Time[j] <> ':') do
    begin
      Stunden := Stunden + Time[j];
      inc(j);
    end;
    Minuten := copy(Time,j+1,2);
    Result := Strtoint(Stunden) + Strtoint(Minuten)/60;
end;

// ----------------------------------------------------------------
// Calcualate average flight time
// ----------------------------------------------------------------
function avgTime(Time: String; Flights: Integer): String;
var
  j, z: Integer;
  Minuten, DMinuten, Stunden: String;
begin
  if Flights = 0 then
  begin
    Result := '0:00';
    exit;
  end;
  Minuten := ''; Stunden := ''; j:= 1;
  while (Time[j] <> ':') do
  begin
    Stunden := Stunden + Time[j];
    inc(j);
  end;
  Minuten := copy(Time,j+1,2);
  z := (Strtoint(Stunden)*60 + Strtoint(Minuten))div Flights;
  DMinuten := InttoStr(z mod 60);
  if length(DMinuten) = 1 then insert('0',DMinuten,1);
  Result := Inttostr(z div 60) + ':' + DMinuten;
end;

// ----------------------------------------------------------------
// Calcualate average speed
// ----------------------------------------------------------------
function avgSpeed(Distance: Integer; Time: String): Word;
var
  j: Integer;
  Minuten, Stunden: String;
begin
  if (Distance = 0) or (Time = '0:00') or (Time = '') then
  begin
    Result := 0;
    exit;
  end;
  Minuten := ''; Stunden := ''; j:= 1;
  while (Time[j] <> ':') do
  begin
    Stunden := Stunden + Time[j];
    inc(j);
  end;
  Minuten := copy(Time,j+1,2);
  Result := Round(Distance / (Strtoint(Stunden) + Strtoint(Minuten)/60));
end;

// ----------------------------------------------------------------
// Average Passengers
// ----------------------------------------------------------------
function avgPassengers(Passengers, Flights: Word): Real;
begin
  if Flights = 0 then
    Result := 0
  else
    Result := Passengers / Flights;
end;

// ----------------------------------------------------------------
// Round Time [xx:xx:xx] to [xx:xx]
// ----------------------------------------------------------------
function RoundTime(Time: String): String;
var ATime: TDateTime;
begin
  ATime := StrToTime(Time);
  if SecondOf(ATime) > 29 then
    incMinute(ATime,1);
  Result := FormatDateTime(ShortTimeFormat, ATime);
end;

// ----------------------------------------------------------------
// Extract hours from a date
// ----------------------------------------------------------------
function ExtractYear(Date: String): Word;
begin
   Result := YearOf(StrToDate(Date));
end;

// ----------------------------------------------------------------
// convert position [Nxxx°xx'xx''] to degree
// ----------------------------------------------------------------
function PosToDeg(Pos: String): Real;
var
  i,n: Word;
  zelle: String;
begin
  i := 2;
  n := 0;
  Result := 0;
  while i < length(Pos) do
  begin
    while (Pos[i] <> '°') and (Pos[i] <> '''') and (Pos[i] <> '"') and (i < length(Pos)) do
    begin
      zelle := zelle + Pos[i];
      inc(i);
    end;
    if n = 0 then Result := StrtoInt(zelle);
    if n = 1 then Result := Result + StrtoInt(zelle)/60;
    if n = 2 then Result := Result + StrtoInt(zelle)/3600;
    inc(n);
    inc(i);
    zelle := '';
  end;
  if (copy(Pos,1,1) = 'S') or (copy(Pos,1,1) = 'W') then Result := 0-Result;
end;

// ----------------------------------------------------------------
// hh:mm to [m]
// ----------------------------------------------------------------
function TimeToMinute(Time: String): Integer;
var
  j: Integer;
  Stunden: String;
  GesStunden, GesMinuten: Integer;
begin
  Stunden := ''; j:= 1;
  if Time = '' then Time := '0:00'  ;
  while (Time[j] <> ':') do
    begin
      Stunden := Stunden + Time[j];
      inc(j);
    end;
  GesStunden := StrToInt(Stunden);
  GesMinuten := StrToInt(copy(Time,j+1,2));

  Result := GesStunden*60+GesMinuten;
end;

// ----------------------------------------------------------------
// hh:mm to [h]
// ----------------------------------------------------------------
function TimeToHour(Time: String): Real;
var
  j: Integer;
  Stunden: String;
  GesStunden, GesMinuten: Integer;
begin
  Stunden := ''; j:= 1;
  if Time = '' then Time := '0:00'  ;
  while (Time[j] <> ':') do
    begin
      Stunden := Stunden + Time[j];
      inc(j);
    end;
  GesStunden := StrToInt(Stunden);
  GesMinuten := StrToInt(copy(Time,j+1,2));

  Result := GesStunden+GesMinuten/60;
end;

// ----------------------------------------------------------------
// [m] to hh:mm
// ----------------------------------------------------------------
function MinuteToTime(Minute: Integer): String;
begin
  Result := format('%d:%0.2d',[Minute div 60, Minute mod 60]);
end;

// ----------------------------------------------------------------
// Convert distance units
// ----------------------------------------------------------------
function ConvertDistUnits(Value: Real; Unit1, Unit2: String): Real;
var
  temp: Real;
begin
  temp := 0;
  if (Value = 0) or (Unit1 = Unit2) then
  begin
    Result := Value;
    Exit;
  end;
  if LowerCase(Unit1) = 'nm' then temp := Value
  else if LowerCase(Unit1) = 'km' then temp := Value/1.853178
  else if LowerCase(Unit1) = 'miles' then temp := Value/1.609341;

  if LowerCase(Unit2) = 'km' then temp := temp*1.853178
  else if LowerCase(Unit2) = 'miles' then temp := temp*1.609341;

  Result := temp;
end;

// ----------------------------------------------------------------
// Speed units
// ----------------------------------------------------------------
function GetSpeedUnit(aUnit: String): String;
begin
  if LowerCase(aUnit) = 'km' then Result := 'km/h'
  else if LowerCase(aUnit) = 'nm' then Result := 'kn'
  else if LowerCase(aUnit) = 'miles' then Result := 'mph';
end;

// ----------------------------------------------------------------
// Calc distance (lat, lon)
// ----------------------------------------------------------------
function CalcDist(BreitTotStO, LaengTotStO, BreitTotLaO, LaengTotLaO: Real; DistUnit: String): Real;
var
  dtr, dist: Real;
begin
  Result := 0;
  if (BreitTotStO = BreitTotLaO) or (BreitTotStO = 0) or (BreitTotLaO = 0)
    then Result := 0
    else begin
      dtr := pi/180;
      dist := Round(60/dtr*ArcCos((sin(BreitTotStO*dtr)*sin(BreitTotLaO*dtr))+
       (cos(BreitTotStO*dtr)*cos(BreitTotLaO*dtr)* cos((LaengTotLaO-LaengTotStO)*dtr))));
      if LowerCase(DistUnit) = 'nm' then Result := dist;
      if LowerCase(DistUnit) = 'km' then Result := dist*1.853178;
      if LowerCase(DistUnit) = 'miles' then Result := dist*1.609341;
    end;
end;

// ----------------------------------------------------------------
// Checks if value is a valid integer
// ----------------------------------------------------------------
function IsInteger(Value: String): Boolean;
begin
  Result := True;
  try
    StrToInt(Value);
  except
     on E: Exception do Result := False;
  end;
end;

// ----------------------------------------------------------------
// Checks if value is a valid time
// ----------------------------------------------------------------
function IsTime(Time: String): Boolean;
var hIdx: Word;
begin
  hIdx := pos(':',Time);
  if hIdx = 0 then
    Result := False
  else begin
    if IsInteger(copy(Time,1,hIdx-1)) and
      (IsInteger(copy(Time,hIdx+1,length(Time)-hIdx)) and (StrToINt(copy(Time,hIdx+1,length(Time)-hIdx)) in [0..59]) )
        then
      Result := True
    else
      Result := False;
  end;
end;

// ----------------------------------------------------------------
// Checks if value is a valid date
// ----------------------------------------------------------------
function IsDate(Date: String): Boolean;
begin
  Result := True;
  try
    StrtoDate(Date);
  except
    Result := False;
  end;
end;


// ----------------------------------------------------------------
// Checks if value is a valid date
// ----------------------------------------------------------------
function isBool(Bool: String): Boolean;
begin
  Result := StrToBool(Bool);
end;

// ----------------------------------------------------------------
// First letter uppercase
// ----------------------------------------------------------------
function NormalCase(S: String): String;
var
  i: Word;
begin
  Result := AnsiLowercase(S);
  Result[1] := AnsiUppercase(s)[1];
  for i:= 1 to length(Result) do
    if Result[i] = ' ' then Result[i+1] := AnsiUppercase(s)[i+1];
end;

// ----------------------------------------------------------------
// Converts '|' to '#13'
// ----------------------------------------------------------------
function PipeToCR(S: String): String;
begin
  Result := StringReplace(S,'|',#13,[rfReplaceAll])
end;

// ----------------------------------------------------------------
// Escape string for html
// ----------------------------------------------------------------
function StrToHTML(S: String): String;
begin
  S := StringReplace(S,'ä','&auml;',[rfReplaceAll]);
  S := StringReplace(S,'ü','&uuml;',[rfReplaceAll]);
  S := StringReplace(S,'ö','&ouml;',[rfReplaceAll]);
  S := StringReplace(S,'Ä','&Auml;',[rfReplaceAll]);
  S := StringReplace(S,'Ü','&Uuml;',[rfReplaceAll]);
  S := StringReplace(S,'Ö','&Ouml;',[rfReplaceAll]);
  Result := S;
end;

// ----------------------------------------------------------------
// Read the content of a TStringList from a String
// ----------------------------------------------------------------
procedure readTStrings(S: String; var Strings: TStringList);
type TString = String;
var
  i: Integer;
  TempStr: String;
begin
  if not Assigned(Strings) then
    Exit;
  TempStr := '';
  Strings.Clear;
  if length(S) = 0 then exit;
  i := 0;
  repeat
    inc(i);
    if S[i] <> ';' then
      TempStr := TempStr + S[i];
    if (S[i] = ';') or (i = length(S)) then
    begin
      if TempStr <> '' then
        Strings.Add(TempStr);
      TempStr := '';
    end;
  until i >= length(S);
end;

// ----------------------------------------------------------------
// Read the values of a TStringList from a String
// don't allow duplicate names
// ----------------------------------------------------------------
function readValueTStrings(S: String; var Strings: TStringList): Integer;
type TString = String;
var
  i: Integer;
  TempStr: String;
  TempStrList: TSTrings;
begin
  TempStr := '';
  Result := 0;
  TempStrList := TSTringList.Create;
  if length(S) = 0 then exit;
  i := 0;
  repeat
    inc(i);
    if S[i] <> ';' then
      TempStr := TempStr + S[i];
    if (S[i] = ';') or (i = length(S)) then
    begin
      if TempStr <> '' then
        TempStrList.Add(TempStr);
      TempStr := '';
    end;
  until i >= length(S);

  Result := TempStrList.Count;
  for i := 0 to TempStrList.Count-1 do
    if pos('=', TempStrList.Text) = 0 then
    begin
      Result := -1;
      Exit;
    end;
  for i := 0 to TempStrList.Count-1 do
    Strings.Values[TempStrList.Names[i]] := TempStrList.Values[TempStrList.Names[i]];
end;

// ----------------------------------------------------------------
// Assign only values
// ----------------------------------------------------------------
procedure AssignValues(StringsFrom: TStringList; StringsTo: TStringList);
var
  i: Word;
begin
  StringsTo.Clear;
  for i := 0 to StringsFrom.Count-1 do
    StringsTo.Add(StringsFrom.ValueFromIndex[i]);
end;

// ----------------------------------------------------------------
// Assign only names
// ----------------------------------------------------------------
procedure AssignNames(StringsFrom: TStringList; StringsTo: TStrings);
var
  i: Word;
begin
  StringsTo.Clear;
  if StringsFrom.Count > 0 then
    for i := 0 to StringsFrom.Count-1 do
      StringsTo.Add(StringsFrom.Names[i]);
end;

// ----------------------------------------------------------------
// Write the content of a TStringList into a String
// ----------------------------------------------------------------
function writeTStrings(Strings: TStringList): String;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to Strings.Count-1 do
    Result := Result + Strings[i]+';';
end;

// ----------------------------------------------------------------
// Replace string
// ----------------------------------------------------------------
function replaceString(S: String; replaceString, withString: Char): String;
begin
  while Pos(replaceString, S) > 0 do
  S[Pos(replaceString, S)] := withString;
  Result := S;
end;

// ----------------------------------------------------------------
// Value is in ValueType
// ----------------------------------------------------------------
function InList(Value, ValueType: String): Boolean;
begin
  if Pos(','+Value+',',ValueType) > 0 then
    Result := True
  else
    Result := False;
end;

// ----------------------------------------------------------------
// Compile Date
// ----------------------------------------------------------------
//function GetImageLinkTimeStamp(const FileName: string): DWORD;
//const
//  INVALIDSETFILEPOINTER = DWORD(-1);
//  BorlandMagicTimeStamp = $2A425E19;  // Delphi 4-6 (and above?)
//  FileTime1970: TFileTime = (dwLowDateTime:$D53E8000; dwHighDateTime:$019DB1DE);
//type
//  PImageSectionHeaders = ^TImageSectionHeaders;
//  TImageSectionHeaders = array [Word] of TImageSectionHeader;
//type
//  PImageResourceDirectory = ^TImageResourceDirectory;
//  TImageResourceDirectory = packed record
//    Characteristics: DWORD;
//    TimeDateStamp: DWORD;
//    MajorVersion: Word;
//    MinorVersion: Word;
//    NumberOfNamedEntries: Word;
//    NumberOfIdEntries: Word;
//  end;
//var
//  FileHandle: THandle;
//  BytesRead: DWORD;
//  ImageDosHeader: TImageDosHeader;
//  ImageNtHeaders: TImageNtHeaders;
//  SectionHeaders: PImageSectionHeaders;
//  Section: Word;
//  ResDirRVA: DWORD;
//  ResDirSize: DWORD;
//  ResDirRaw: DWORD;
//  ResDirTable: TImageResourceDirectory;
//  FileTime: TFileTime;
//begin
//  Result := 0;
//  // Open file for read access
//  FileHandle := CreateFile(PChar(FileName), GENERICREAD, FILESHAREREAD, nil,
//    OPENEXISTING, 0, 0);
//  if (FileHandle <> INVALIDHANDLEVALUE) then
//  try
//    // Read MS-DOS header to get the offset of the PE32 header
//    // (not required on WinNT based systems - but mostly available)
//    if not ReadFile(FileHandle, ImageDosHeader, SizeOf(TImageDosHeader),
//      BytesRead, nil) or (BytesRead <> SizeOf(TImageDosHeader)) or
//      (ImageDosHeader.emagic <> IMAGEDOSSIGNATURE) then
//    begin
//      ImageDosHeader.lfanew := 0;
//    end;
//    // Read PE32 header (including optional header
//    if (SetFilePointer(FileHandle, ImageDosHeader.lfanew, nil, FILEBEGIN) =
//      INVALIDSETFILEPOINTER) then
//    begin
//      Exit;
//    end;
//    if not(ReadFile(FileHandle, ImageNtHeaders, SizeOf(TImageNtHeaders),
//      BytesRead, nil) and (BytesRead = SizeOf(TImageNtHeaders))) then
//    begin
//      Exit;
//    end;
//    // Validate PE32 image header
//    if (ImageNtHeaders.Signature <> IMAGENTSIGNATURE) then
//    begin
//      Exit;
//    end;
//    // Seconds since 1970 (UTC)
//    Result := ImageNtHeaders.FileHeader.TimeDateStamp;
//
//    // Check for Borland's magic value for the link time stamp
//    // (we take the time stamp from the resource directory table)
//    if (ImageNtHeaders.FileHeader.TimeDateStamp = BorlandMagicTimeStamp) then
//    with ImageNtHeaders, FileHeader, OptionalHeader do
//    begin
//      // Validate Optional header
//      if (SizeOfOptionalHeader < IMAGESIZEOFNTOPTIONALHEADER) or
//        (Magic <> IMAGENTOPTIONALHDRMAGIC) then
//      begin
//        Exit;
//      end;
//      // Read section headers
//      SectionHeaders :=
//        GetMemory(NumberOfSections * SizeOf(TImageSectionHeader));
//      if Assigned(SectionHeaders) then
//      try
//        if (SetFilePointer(FileHandle,
//          SizeOfOptionalHeader - IMAGESIZEOFNTOPTIONALHEADER, nil,
//          FILECURRENT) = INVALIDSETFILEPOINTER) then
//        begin
//          Exit;
//        end;
//        if not(ReadFile(FileHandle, SectionHeaders^, NumberOfSections *
//          SizeOf(TImageSectionHeader), BytesRead, nil) and (BytesRead =
//          NumberOfSections * SizeOf(TImageSectionHeader))) then
//        begin
//          Exit;
//        end;
//        // Get RVA and size of the resource directory
//        with DataDirectory[IMAGEDIRECTORYENTRYRESOURCE] do
//        begin
//          ResDirRVA := VirtualAddress;
//          ResDirSize := Size;
//        end;
//        // Search for section which contains the resource directory
//        ResDirRaw := 0;
//        for Section := 0 to NumberOfSections - 1 do
//        with SectionHeaders[Section] do
//          if (VirtualAddress <= ResDirRVA) and
//            (VirtualAddress + SizeOfRawData >= ResDirRVA + ResDirSize) then
//          begin
//            ResDirRaw := PointerToRawData - (VirtualAddress - ResDirRVA);
//            Break;
//          end;
//        // Resource directory table found?
//        if (ResDirRaw = 0) then
//        begin
//          Exit;
//        end;
//        // Read resource directory table
//        if (SetFilePointer(FileHandle, ResDirRaw, nil, FILEBEGIN) =
//          INVALIDSETFILEPOINTER) then
//        begin
//          Exit;
//        end;
//        if not(ReadFile(FileHandle, ResDirTable,
//          SizeOf(TImageResourceDirectory), BytesRead, nil) and
//          (BytesRead = SizeOf(TImageResourceDirectory))) then
//        begin
//          Exit;
//        end;
//        // Convert from DosDateTime to SecondsSince1970
//        if DosDateTimeToFileTime(HiWord(ResDirTable.TimeDateStamp),
//          LoWord(ResDirTable.TimeDateStamp), FileTime) then
//        begin
//          // FIXME: Borland's linker uses the local system time
//          // of the user who linked the executable image file.
//          // (is that information anywhere?)
//          Result := (ULARGEINTEGER(FileTime).QuadPart -
//            ULARGEINTEGER(FileTime1970).QuadPart) div 10000000;
//        end;
//      finally
//        FreeMemory(SectionHeaders);
//      end;
//    end;
//  finally
//    FileClose(FileHandle); { *Converted from CloseHandle* }
//  end;
//end;

// ----------------------------------------------------------------
// Read string object
// ----------------------------------------------------------------
function GetStringObject(StringList: TStringList; Name, ObjName: String): String;
var
  StringIndex: Integer;
begin
  StringIndex := -1;
  if (StringList.IndexOf(Name) <> -1) then
    StringIndex := StringList.IndexOf(Name)
  else if (StringList.IndexOfName(Name) <> -1) then
    StringIndex := StringList.IndexOfName(Name);
  if StringIndex = -1 then
    Exit;

  Result := '';
  if Assigned(StringList.Objects[StringIndex]) then
    Result := TStringList(StringList.Objects[StringIndex]).Values[ObjName];
end;

// ----------------------------------------------------------------
// Write string object
// ----------------------------------------------------------------
procedure SetStringObject(StringList: TStringList; Name, ObjName, ObjValue: String);
var
  StringIndex: Integer;
begin
  StringIndex := -1;
  if (StringList.IndexOf(Name) <> -1) then
    StringIndex := StringList.IndexOf(Name)
  else if (StringList.IndexOfName(Name) <> -1) then
    StringIndex := StringList.IndexOfName(Name);
  if StringIndex = -1 then
    Exit;

  if not Assigned(StringList.Objects[StringIndex]) then
    StringList.Objects[StringIndex] := TStringList.Create;

  TStringList(StringList.Objects[StringIndex]).Values[ObjName] := ObjValue;
end;

// ----------------------------------------------------------------
// Delete String  in StringListwith objects
// ----------------------------------------------------------------
procedure DeleteStringObject(StringList: TStringList; Index: Integer);
begin
  if Assigned(StringList.Objects[Index]) then
    StringList.Objects[Index].Free;
  StringList.Delete(Index);
end;

// ----------------------------------------------------------------
// Free StringList with objects
// ----------------------------------------------------------------
procedure FreeObjStringList(StringList: TStringList);
var i: Word;
begin
  if StringList.Count > 0 then
    for i := 0 to StringList.Count -1 do
      if Assigned(StringList.Objects[i]) then
        StringList.Objects[i].Free;
  StringList.Free;
end;

// ----------------------------------------------------------------
// Get File Information
// ----------------------------------------------------------------
//function GetFileVersion(FileName: WideString): String;
//var VersionInfoSize, VerInfoSize, GetInfoSizeJunk: LongWord;
//    VersionInfo, Translation, InfoPointer: Pointer;
//    VersionValue: WideString;
//begin
//  VerInfoSize := GetFileVersionInfoSizeW(PWideChar(FileName), GetInfoSizeJunk);
//  if VerInfoSize > 0 then begin
//    GetMem(VersionInfo, VerInfoSize);
//    try
//      GetFileVersionInfoW(PWideChar(FileName), 0, VerInfoSize, VersionInfo);
//
//      VerQueryValue(VersionInfo, '\\VarFileInfo\\Translation', Translation, VerInfoSize);
//      VersionValue := '\\StringFileInfo\\' + IntToHex((PLongInt(Translation)^ shl 16)
//        or (PLongInt(Translation)^ shr 16), 8) + '\\';
//
//      VersionInfoSize := 0;
//      VerQueryValueW(VersionInfo, PWideChar(VersionValue + 'FileVersion'), InfoPointer, VersionInfoSize);
//
//      Result := Trim(PWideChar(InfoPointer));
//    finally
//      FreeMem(VersionInfo);
//    end;
//  end;
//end;

function GetActualDir(Extract : boolean) : String;
begin
   if Extract then Result := ExtractFilePath(Paramstr(0))
   else begin
     if WorkingDir = '' then GetDir(0, WorkingDir); {0 = Current drive / dir}
     Result := IncludeTrailingPathDelimiter(WorkingDir);
   end;
end;

// ----------------------------------------------------------------
//  Fill & Check CheckListBox and StringList with TSrings
// ----------------------------------------------------------------
procedure StringsToCLB(var Cat: TStringList; Data: String; Grid: TStringGrid; CLB: TCheckListBox);  overload;
var
  i, pos: Word;
  TempStr: String;
begin
  Pos := 0;
  if Data = '' then exit;

  for i := 1 to length(Data) do
  begin
    if (Data[i] = '|') then
    begin
      if Pos = 0 then
      begin
        if Cat.IndexOf(TempStr) = -1 then
        begin
          Cat.Add(TempStr);
          CLB.Items.Add(TempStr);
        end;
        CLB.Checked[CLB.Items.IndexOf(TempStr)] := True;
        if Grid.Cells[1,1] <> '' then Grid.RowCount := Grid.RowCount +1;
        Grid.Cells[0,Grid.RowCount-1] := InttoStr(CLB.Items.IndexOf(TempStr));
      end;
      Grid.Cells[Pos+1,Grid.RowCount-1] := TempStr;
      TempStr := '';
      inc(Pos);
    end
    else if (Data[i] = '/') then
    begin
      Grid.Cells[Pos+1,Grid.RowCount-1] := TempStr;
      TempStr := '';
      Pos := 0;
    end
    else TempStr := TempStr + Data[i];
  end;
end;

// ----------------------------------------------------------------
// Fill & Check CheckListBox with TSrings
// ----------------------------------------------------------------
procedure StringsToCLB(var Cat: TStringList; Data: String; CLB: TCheckListBox); overload;
var
  i: Word;
  TempStr: String;
begin
  CLB.Items := Cat;
  if Data = '' then
    Exit;

  for i := 1 to length(Data) do
  begin
    if (Data[i] = '/') then
      begin
      if CLB.Items.IndexOf(TempStr) = -1 then
      begin
        Cat.Add(TempStr);
        CLB.Items.Add(TempStr);
      end;
      CLB.Checked[CLB.Items.IndexOf(TempStr)] := True;
      TempStr := '';
    end
    else TempStr := TempStr + Data[i];
  end;
end;

// ----------------------------------------------------------------
//
// ----------------------------------------------------------------
procedure GrayCLB(var Cat: TSTringList; Data: String; CLB: TCheckListBox);
var
  i: Word;
  TempStr: String;
begin
  if Data = '' then
    Exit;

  for i := 1 to length(Data) do
  begin
    if (Data[i] = '/') then
    begin
      if CLB.Items.IndexOf(TempStr) = -1 then
      begin
        Cat.Add(TempStr);
        CLB.Items.Add(TempStr);
      end;
      CLB.State[CLB.Items.IndexOf(TempStr)] := cbGrayed;
      CLB.ItemEnabled[CLB.Items.IndexOf(TempStr)] := False;
      TempStr := '';
    end
    else TempStr := TempStr + Data[i];
  end;
end;

// ----------------------------------------------------------------
// convert "/"-seperated string list in TStringList
// ----------------------------------------------------------------
procedure StringToStringList(var List: TSTringList; Data: String);
var
  i: Word;
  TempStr: String;
begin
  if Data = '' then
    Exit;

  for i := 1 to length(Data) do
  begin
    if (Data[i] = '/') then
    begin
      List.Add(TempStr);
      TempStr := '';
    end
    else TempStr := TempStr + Data[i];
  end;
end;



end.
