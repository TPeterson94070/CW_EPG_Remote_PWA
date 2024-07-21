unit SchedUnit;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Dialogs, WEBLib.StdCtrls, Vcl.StdCtrls, WEBLib.ExtCtrls,
  Vcl.Controls, WEBLib.Menus;

type
  TSchedForm = class(TWebForm)
    EventModeGroup: TWebRadioGroup;
    lbChannelValue: TWebLabel;
    LblChannel: TWebLabel;
    lblEndTime: TWebLabel;
    lblStartDate: TWebLabel;
    lblStartTime: TWebLabel;
    lblStartDateValue: TWebLabel;
    optcanbutt: TWebButton;
    optokbutt: TWebButton;
    pnlDetails: TWebPanel;
    lbTitle: TWebLabel;
    lbSubTitle: TWebLabel;
    lbDescription: TWebLabel;
    mmTitle: TWebMemo;
    mmSubTitle: TWebMemo;
    mmDescrip: TWebMemo;
    tpStartTime: TWebDateTimePicker;
    tpEndTime: TWebDateTimePicker;
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

procedure TSchedForm.WebFormShow(Sender: TObject);
begin
//  tpStartTime.ShowSeconds := False;
//  tpEndTime.ShowSeconds := False;
//  lblStartDateValue.Caption := DateToStr(tpStartTime.DateTime);
end;

end.