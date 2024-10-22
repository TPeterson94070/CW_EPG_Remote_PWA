unit Details;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Dialogs, Vcl.Controls, Vcl.StdCtrls, WEBLib.StdCtrls,
  WEBLib.ExtCtrls;

type
  TDetailsFrm = class(TWebForm)
    pnlDetails: TWebPanel;
    lblTitle: TWebLabel;
    lblSubTitle: TWebLabel;
    lblDescription: TWebLabel;
    mmTitle: TWebMemo;
    mmSubTitle: TWebMemo;
    mmDescription: TWebMemo;
    btnAddCap: TWebButton;
    btnReturn: TWebButton;
    lb02New: TWebLabel;
    lb03Stereo: TWebLabel;
    lb04HD: TWebLabel;
    lb07Dolby: TWebLabel;
    lb08CC: TWebLabel;
    lb09OrigDate: TWebLabel;
    lb10Channel: TWebLabel;
    lb11Time: TWebLabel;
    procedure WebFormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DetailsFrm: TDetailsFrm;

implementation

uses CWRmainForm;

{$R *.dfm}

procedure TDetailsFrm.WebFormShow(Sender: TObject);
begin
  btnReturn.SetFocus;
  CWRmainFrm.WIDBCDS.EnableControls;
end;

end.
