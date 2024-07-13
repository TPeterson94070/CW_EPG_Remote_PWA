program CW_EPG_Remote;

{$R *.dres}
{$Define idbdebug}
uses
  Vcl.Forms,
  WEBLib.Forms,
  CWRmainForm in 'CWRmainForm.pas' {CWRmainFrm: TWebForm} {*.html},
  SchedUnit in 'SchedUnit.pas' {SchedForm: TWebForm} {*.html};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TCWRmainFrm, CWRmainFrm);
  Application.CreateForm(TSchedForm, SchedForm);
  Application.Run;
end.
