unit SchedUnit2;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Dialogs, Vcl.StdCtrls, WEBLib.StdCtrls, Vcl.Controls,
  WEBLib.ExtCtrls;

type
  TSchedForm = class(TWebForm)
    EventModeGroup: TWebRadioGroup;
    pnlDetails: TWebPanel;
    lblTitle: TWebLabel;
    mmTitle: TWebMemo;
    mmSubTitle: TWebMemo;
    mmDescription: TWebMemo;
    lblSubTitle: TWebLabel;
    lblDescription: TWebLabel;
    lblChannel: TWebLabel;
    lblChannelValue: TWebLabel;
    lblStartTime: TWebLabel;
    lblEndTime: TWebLabel;
    lblStartDateValue: TWebLabel;
    btnCancel: TWebButton;
    btnOK: TWebButton;
    tpStartTime: TWebDateTimePicker;
    tpEndTime: TWebDateTimePicker;
    procedure WebFormEnter(Sender: TObject);
    procedure WebFormExit(Sender: TObject);
    procedure WebFormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SchedForm: TSchedForm;

implementation

{$R *.dfm}

uses CWRmainForm;

//(*
//Source - https://stackoverflow.com/a/78210803
//Posted by Shaun Roselt
//Retrieved 2025-11-08, License - CC BY-SA 4.0
//*)
//
//procedure SwipeDownRefresh(Enabled: Boolean);
//begin
//  if Enabled then
//  begin
//    TJSHTMLElement(document.body).style.removeProperty('overscroll-behavior-y');
//    TJSHTMLElement(document.body.parentElement).style.removeProperty('overscroll-behavior-y');
//  end else
//  begin
//    TJSHTMLElement(document.body).style.setProperty('overscroll-behavior-y','contain');
//    TJSHTMLElement(document.body.parentElement).style.setProperty('overscroll-behavior-y','contain');
//  end;
//end;

procedure TSchedForm.WebFormEnter(Sender: TObject);
begin
  CWRmainFrm.SwipeDownRefresh(False);
end;

procedure TSchedForm.WebFormExit(Sender: TObject);
begin
  CWRmainFrm.SwipeDownRefresh(True);
end;

procedure TSchedForm.WebFormShow(Sender: TObject);
begin
  // Start with Cancel button active
  btnCancel.SetFocus;
end;

end.
