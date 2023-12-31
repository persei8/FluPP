unit ToolsLicense;

{$MODE Delphi}

interface

uses DOM, XMLRead, SysUtils, Dialogs;

const
  ValueTypeStarts = ',Starts,FStarts,WStarts,EStarts,';
  ValueTypeTime = ',FlightTime,BlockTime,PICFlightTime,PICBlockTime,TimeCat,';

type
  ELicenseInvalid = class(Exception);

function LoadXMLLicense(FileName: String; var JvSimpleXML: TXMLDocument): Boolean;
function VerifyXMLLicense(JvSimpleXML: TXMLDocument; Flb: Word): Boolean;

implementation

uses Tools, ToolsGrid;

// ----------------------------------------------------------------
// Load xml license
// ----------------------------------------------------------------
function LoadXMLLicense(FileName: String; var JvSimpleXML: TXMLDocument): Boolean;
begin
  Result := True;
    try
      ReadXMLFile(JvSimpleXML, FileName);
    except
      on E: Exception do
    begin
      Showmessage(E.Message);
      Result := False;
    end;
  end;
end;

// ----------------------------------------------------------------
// Verify xml license
// ----------------------------------------------------------------
function VerifyXMLLicense(JvSimpleXML: TXMLDocument; Flb: Word): Boolean;
{-----------}
  //function IsValidXMLProperty(XMLElem: TDOMNode; Tag: String; Flb: Word = 0): Boolean;
  //begin
  //  Result := True;
  //  { name }
  //  if Tag = 'name' then
  //    if XMLElem.Attributes.GetNamedItem(Tag) = '' then
  //    begin
  //      raise ELicenseInvalid.Create(
  //        format(('Attribute ''%s'' does not exist in XML-tag ''%s''!'),[Tag, XMLElem.Name]));
  //      Result := False;
  //    end;
  //  { date }
  //  if Tag = 'date' then
  //    if not IsDate(GridChild(Flb).LicenseDates.Values[XMLElem.Properties.Value('date')]) then
  //    begin
  //      raise ELicenseInvalid.Create(
  //        format(('The date ''%s'' is not valid!'),[XMLElem.Properties.Value(Tag)]));
  //      Result := False;
  //    end;
  //  { duration }
  //  if Tag = 'duration' then
  //    if not IsInteger(XMLElem.Properties.Value('duration')) then
  //    begin
  //      raise ELicenseInvalid.Create(
  //        format(('The duration ''%s'' is not valid!'),[XMLElem.Properties.Value(Tag)]));
  //      Result := False;
  //    end
  //end;
{-----------}
  //function IsValidXMLCondition(XMLElem: TDOMNode; Flb: Word = 0): Boolean;
  //begin
  //  Result := True;
  //  if not InList(XMLElem.Properties.Value('value'),ValueTypeStarts) and
  //    not InList(XMLElem.Properties.Value('value'),ValueTypeTime) then
  //  begin
  //    raise ELicenseInvalid.Create(
  //      format(('''%s'' is not a valid property!'),[XMLElem.Properties.Value('value')]));
  //    Result := False;
  //  end;
  //  if not IsValidXMLProperty(XMLElem,'name') then
  //    Result := False;
  //  if not IsValidXMLProperty(XMLElem,'duration') then
  //    Result := False;
  //
  //  if InList(XMLElem.Properties.Value('value'),ValueTypeTime) then
  //    if not isTime(XMLElem.Properties.Value('required')) then
  //    begin
  //      raise ELicenseInvalid.Create(
  //        format(('The time ''%s'' is not valid!'),[XMLElem.Properties.Value('value')]));
  //      Result := False;
  //    end;
  //
  //  if InList(XMLElem.Properties.Value('value'),ValueTypeStarts) then
  //    if not isInteger(XMLElem.Properties.Value('required')) then
  //    begin
  //      raise ELicenseInvalid.Create(
  //        format(('The number ''%s'' is not valid!'),[XMLElem.Properties.Value('value')]));
  //      Result := False;
  //    end;
  //end;
{-----------}
var
  i, j: Word;
  XMLElem: TDOMNode;
begin
 // Result := True;
 // if AnsiLowerCase(JvSimpleXML.ParentNode.NodeName) = 'license' then
	//begin
	//	if not IsValidXMLProperty(JvSimpleXML.Root,'name') then Result := False;
 //
	//	{ Currency & Validation }
	//	if JvSimpleXML.Root.Items.Count > 0 then
	//	begin
	//		for i := 0 to JvSimpleXML.Root.Items.Count-1 do
	//		begin
	//			if (AnsiLowerCase(JvSimpleXML.Root.Items[i].Name) = 'currency') or
	//				 (AnsiLowerCase(JvSimpleXML.Root.Items[i].Name) = 'extension') then
	//			begin
	//				{ Validation }
	//				if AnsiLowerCase(JvSimpleXML.Root.Items[i].Name) = 'extension' then
 //           if not IsValidXMLProperty(JvSimpleXML.Root.Items[i],'date', Flb) then Result := False;
	//				{ Conditions }
	//				if JvSimpleXML.Root.Items[i].Items.Count > 0 then
	//				begin
	//					for j := 0 to JvSimpleXML.Root.Items[i].Items.Count-1 do
	//					begin
	//						XMLElem := JvSimpleXML.Root.Items[i].items[j];
	//						if (XMLElem.Name = 'condition') then
 //               if not IsValidXMLCondition(XMLElem,Flb) then
 //                 Result := False;
	//					end;
	//				end;
	//			end;
	//		end;
	//	end;
	//end;
end;


end.
 
