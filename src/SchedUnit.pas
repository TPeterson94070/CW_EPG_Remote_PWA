unit SchedUnit;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Dialogs, WEBLib.StdCtrls, Vcl.StdCtrls, WEBLib.ExtCtrls,
  Vcl.Controls;

type
  TSchedForm = class(TWebForm)
    EventModeGroup: TWebRadioGroup;
    lbChannelValue: TWebLabel;
    LblChannel: TWebLabel;
    lblEndTime: TWebLabel;
    lblStartDate: TWebLabel;
    lblStartTime: TWebLabel;
    lbStartDate: TWebLabel;
    optcanbutt: TWebButton;
    optokbutt: TWebButton;
    pnlDetails: TWebPanel;
    lbTitle: TWebLabel;
    lbSubTitle: TWebLabel;
    lbDescription: TWebLabel;
    mmTitle: TWebMemo;
    mmSubTitle: TWebMemo;
    mmDescrip: TWebMemo;
    tpEndTime: TWebDateTimePicker;
    tpStartTime: TWebDateTimePicker;
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