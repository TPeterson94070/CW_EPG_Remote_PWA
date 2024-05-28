program CW_EPG_Remote;

{$R *.dres}
{$Define idbdebug}
uses
  Vcl.Forms,
  WEBLib.Forms,
  CWRmainForm in 'CWRmainForm.pas' {CWRmainFrm: TWebForm} {*.html}
//  ,Vcl.Themes,
//  Vcl.Styles
;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TCWRmainFrm, CWRmainFrm);
  Application.Run;
end.
