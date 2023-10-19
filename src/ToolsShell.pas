unit ToolsShell;

{$MODE Delphi}

interface

uses Forms;

function ShellCopyFile(const ASource, ADest: String;
 ARenameCheck: boolean = false): boolean;
function ShellCopyDir(const fromDir, toDir: string): Boolean;
function ShellMoveFile(FormHandle : THandle; StrFrom, StrTo : string;
  BlnSilent : Boolean = False) : Boolean;

implementation

// ----------------------------------------------------------------
// Copy files
// ----------------------------------------------------------------
function ShellCopyFile(const ASource, ADest: String;
  ARenameCheck: boolean = false): boolean;
begin
//var
//  sh: TSHFileOpStruct;
//begin
//  sh.Wnd := Application.Handle;
//  sh.wFunc := FOCOPY;
//
//  sh.pFrom := PChar(ASource + #0);
//  sh.pTo := PChar(ADest + #0);
//  sh.fFlags := fofSilent or fofMultiDestFiles;
//  if ARenameCheck then
//    sh.fFlags := sh.fFlags or fofRenameOnCollision;
//  Result:=ShFileOperation(sh)=0;
end;

// ----------------------------------------------------------------
// Copy Directory
// ----------------------------------------------------------------
function ShellCopyDir(const fromDir, toDir: string): Boolean;
begin
//var
//  fos: TSHFileOpStruct;
//begin
//  with fos do
//  begin
//    wFunc  := FOCOPY;
//    fFlags := FOFFILESONLY;
//    pFrom  := PChar(fromDir + #0);
//    pTo    := PChar(toDir)
//  end;
//  Result := (0 = ShFileOperation(fos));
end;

// ----------------------------------------------------------------
// Move files
// ----------------------------------------------------------------
function ShellMoveFile(FormHandle : THandle; StrFrom, StrTo : string;
  BlnSilent : Boolean = False) : Boolean;
begin
//var
//  F : TShFileOpStruct;
//begin
//  F.Wnd:=FormHandle;
//  F.wFunc:=FOMOVE;
//  F.pFrom:=PChar(StrFrom+#0);
//  F.pTo:=PChar(StrTo+#0);
//  F.fFlags := FOFALLOWUNDO or FOFRENAMEONCOLLISION;
//  if BlnSilent then
//    F.fFlags := F.fFlags or FOFSILENT;
//  if ShFileOperation(F) <> 0 then
//    result:=False
//  else
//    result:=True;
end;

end.
