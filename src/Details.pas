unit Details;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Dialogs, Vcl.Controls, Vcl.StdCtrls, WEBLib.StdCtrls,
  WEBLib.ExtCtrls;

type
  TDetailsFrm = class(TWebForm)
    lb12Description: TWebLabel;
    lb01Title: TWebLabel;
    lb02New: TWebLabel;
    lb03Stereo: TWebLabel;
    lb04HD: TWebLabel;
    lb06SubTitle: TWebLabel;
    lb07Dolby: TWebLabel;
    lb08CC: TWebLabel;
    lb09OrigDate: TWebLabel;
    lb10Channel: TWebLabel;
    lb11Time: TWebLabel;
    btnAddCap: TWebButton;
    btnReturn: TWebButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DetailsFrm: TDetailsFrm;

implementation

{$R *.dfm}

end.