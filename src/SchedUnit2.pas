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
    optcanbutt: TWebButton;
    optokbutt: TWebButton;
    tpStartTime: TWebDateTimePicker;
    tpEndTime: TWebDateTimePicker;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SchedForm: TSchedForm;

implementation

{$R *.dfm}

end.
