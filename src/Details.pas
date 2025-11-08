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
    procedure WebFormEnter(Sender: TObject);
    procedure WebFormExit(Sender: TObject);
    procedure WebFormShow(Sender: TObject);
//    procedure WebFormShow(Sender: TObject);
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

(*
Source - https://stackoverflow.com/a/78210803
Posted by Shaun Roselt
Retrieved 2025-11-08, License - CC BY-SA 4.0
*)

procedure SwipeDownRefresh(Enabled: Boolean);
begin
  if Enabled then
  begin
    TJSHTMLElement(document.body).style.removeProperty('overscroll-behavior-y');
    TJSHTMLElement(document.body.parentElement).style.removeProperty('overscroll-behavior-y');
  end else
  begin
    TJSHTMLElement(document.body).style.setProperty('overscroll-behavior-y','contain');
    TJSHTMLElement(document.body.parentElement).style.setProperty('overscroll-behavior-y','contain');
  end;
end;

procedure TDetailsFrm.WebFormEnter(Sender: TObject);
begin
  SwipeDownRefresh(False);
end;

procedure TDetailsFrm.WebFormExit(Sender: TObject);
begin
  SwipeDownRefresh(True);
end;

procedure TDetailsFrm.WebFormShow(Sender: TObject);
begin
  btnReturn.SetFocus;
end;

end.
