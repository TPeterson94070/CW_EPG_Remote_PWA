unit Unit1;

interface

uses
  System.SysUtils, System.Classes, WEBLib.Graphics, WEBLib.Forms, Vcl.StdCtrls,
  WEBLib.StdCtrls, Vcl.Controls, WEBLib.Dialogs, Vcl.Imaging.pngimage,
  WEBLib.ExtCtrls, WEBLib.Controls, Web, JS;

type
  TForm1 = class(TWebForm)
    WebLabel1: TWebLabel;
    WebButton1: TWebButton;
    WebEdit1: TWebEdit;
    WebLabel2: TWebLabel;
    WebLabel6: TWebLabel;
    [async]
    procedure WebButton1Click(Sender: TObject);
    procedure WebFormCreate(Sender: TObject);
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  SchedUnit;

procedure TForm1.WebButton1Click(Sender: TObject);
var
  newform: TSchedForm;

begin
  newform := SchedForm.Create(Self);
  newform.Caption := 'Schedule Item';
  newform.Popup := True;
  newform.Border := fbDialog;

  // used to manage Back button handling to close subform
  window.location.hash := 'subform';

  // load file HTML template + controls
  TAwait.ExecP<TSchedForm>(newform.Load());

  // init control after loading
  newform.mmTitle.Text := WebEdit1.Text;

  try
    // excute form and wait for close
    TAwait.ExecP<TModalResult>(newform.Execute);
    if newform.ModalResult = mrOk then
    begin
      ShowMessage('SchedForm closed with new value:"'+newform.mmTitle.Text+'"');
      WebEdit1.Text := newform.mmTitle.Text;
    end;
  finally
    newform.Free;
  end;
end;

procedure TForm1.WebFormCreate(Sender: TObject);
begin
  Application.ThemeColor := clTMSWEB;
end;

end.
