unit InputBox;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, LMessages, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Masks, Buttons, ExtCtrls, {gnugettext, JvExStdCtrls,}
  JvButton{, JvCtrls};

type
  TFInputBox = class(TForm)
    Panel1: TPanel;
    ButtonCancel: TBitBtn;
    ButtonOK: TBitBtn;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FInputBox: TFInputBox;

implementation

{$R *.lfm}

end.
