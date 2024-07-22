unit CapNowOpts;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  JvExStdCtrls, JvCheckBox, Vcl.Samples.Spin, Vcl.Buttons, Vcl.ComCtrls,
  Vcl.WinXPanels, Vcl.ButtonGroup, Vcl.CheckLst,
  WEBLib.Graphics, WEBLib.Forms, WEBLib.StdCtrls, web, WEBLib.ExtCtrls,
  WEBLib.Controls;

type
  TCapOptForm = class(TWebForm)
    EventModeGroup: TWebRadioGroup;
    lblEndTime: TWebLabel;
    lblStartTime: TWebLabel;
    optcanbutt: TWebButton;
    optokbutt: TWebButton;
    StartDateTime: TWebDateTimePicker;
    EndDateTime: TWebDateTimePicker;
    CbChannel: TWebComboBox;
    LblChannel: TWebLabel;
    mmTitle: TWebMemo;
    mmDescrip: TWebMemo;
    mmSubTitle: TWebMemo;
    StackPanel1: TWebPanel;
    lbTitle: TWebLabel;
    lbSubTitle: TWebLabel;
    lbDescription: TWebLabel;
//    procedure DefPadClick(Sender: TObject);
//    procedure FormCreate(Sender: TObject);
    procedure optokbuttClick(Sender: TObject);
    procedure optcanbuttClick(Sender: TObject);
//    procedure FormShow(Sender: TObject);
//    procedure FormActivate(Sender: TObject);
//    procedure CbTunerChange(Sender: TObject);
    procedure StartDateTimeExit(Sender: TObject);
//    procedure CbTunerEnter(Sender: TObject);
//    procedure CbHostChange(Sender: TObject);
//    procedure BtnRecurringClick(Sender: TObject);
//    procedure CheckListBox1Exit(Sender: TObject);
//    procedure CheckListBox1ClickCheck(Sender: TObject);
//    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
//    procedure SetChannelList;
//    function TunerConflicted(ATuner: string; Silent: Boolean = False): Boolean;
    procedure ListParam(Title: string);
//    function TunerHasChannel(ATuner: string): Boolean;
  public
  end;

var
  CapOptForm: TCapOptForm;

implementation

uses
  {main, options, DimmerForm,} System.DateUtils, System.Math, System.StrUtils, AdvGrid;

var
  TunerListDone,
  ChanChangeEnabled : Boolean;

{$R *.dfm}

//===============================================================

//function TCapOptForm.TunerConflicted(ATuner: string; Silent: Boolean = False): Boolean;
//
//procedure ConflictNotice(Note: string);
//begin
//  if Silent then exit;
//  Console.Log('  ############################## (TunerConflicted) ' + Note);
//  Dimmer.ShowMessage('Note: ' + Note + #13'so you must choose a different tuner.');
//end;
//
//begin
//  if (ATuner = '') or (CbChannel.Text = '') then exit(True);   // Bogus call, null tuner/channel must be conflicted
//  var CurrTuner := ATuner.Split(['HR(',')'],TStringSplitOptions.ExcludeEmpty)[0];  // tunermaps name format
//  var CurrChan := string(CbChannel.Text).Split([': '])[1];   // PSIPname
//  Result := not CbChannel.Enabled  // Assume a conflict if fixed channel
//            and (CbChannel.Text{Items[CbChannel.ItemIndex]} <> '');  // but null channel can't conflict
//  if Result then                    // and check that ATuner owns it
//  begin
//    Form2.tunermaps.BeginUpdate;   // Speed up search?
//    for var i := 1 to Form2.tunermaps.RowCount-1 do
//    begin
//      if CurrTuner <> Form2.tunermaps.Cells[2,i] then continue;   // wrong tuner
//      if CurrChan <> Form2.tunermaps.Cells[3,i] then continue;    // PSIPnames <>
//      if Form2.tunermaps.Cells[0,i] <> CbHost.Text{Items[CbHost.ItemIndex]} then continue; // wrong host
//      Result := False;  // Found the selected channel so this tuner is not conflicted by lacking channel
//      break;
//    end;
//    Form2.tunermaps.EndUpdate;
//    if Result then
//    begin
//      ConflictNotice('Channel ' + CbChannel.Text{Items[CbChannel.ItemIndex]}
//        + ' not found on ' + ATuner);
//      exit;  // no need to check times
//    end;
//  end;
//  // Result False so far, channel OK or can be changed, check for time conflicts
////  Form1.AllCapsGrid.BeginUpdate; {No need, since no acg writes here}
//  for var i := 1 to (form1.AllCapsGrid.RowCount - 1) do
//  begin
//    if Form1.AllCapsGrid.Cells[2,i] <> ATuner then continue;  // wrong tuner
//    // Have the same tuner in AllCaps, does it conflict in time?
//    var sdate := form1.AllCapsGrid.Dates[3,i] + form1.AllCapsGrid.Times[4,i];
//    var edate := form1.AllCapsGrid.Dates[3,i] + form1.AllCapsGrid.Times[5,i];
////      if edate < sdate then edate := edate + 1;  // Superfluous, as we have full DateTimes
//    Result := ((StartDateTime.DateTime >= sdate) AND (StartDateTime.DateTime < edate)) OR // Part overlap: New Start within exist duration
//       ((EndDateTime.DateTime > sdate) AND (EndDateTime.DateTime < edate)) OR             // Part overlap: New End within exist duration
//       ((StartDateTime.DateTime <= sdate) AND (EndDateTime.DateTime >= edate));           // Full Overlap: New Start, End bracket exist duration
//    if Result then break; // Have conflict, we're done
//  end;
////  Form1.AllCapsGrid.EndUpdate;
//  if Result then ConflictNotice(DateTimeToStr(StartDateTime.DateTime)
//    + ' - ' + TimeToStr(EndDateTime.DateTime) + ' time conflicts for ' + ATuner);
//end;

//procedure TCapOptForm.BtnRecurringClick(Sender: TObject);
//begin
//  if Panel1.Visible then CheckListBox1Exit(Self)
//  else
//  begin
//    if Recurrence = '' then  // Set StartDate's DOW
//    begin
//      CheckListBox1.Checked[(DayOfTheWeek(StartDateTime.Date) mod 7)] := True;
//      CheckListBox1ClickCheck(Self);    // Update Recurrence
//    end;
//    Panel1.Show;
//    BtnRecurring.Caption := 'Close Panel';
//  end;
//end;

//procedure TCapOptForm.CbHostChange(Sender: TObject);
//begin
//  TunerListDone := False;
//  CbTunerEnter(Self);
//end;

//procedure TCapOptForm.CbTunerChange(Sender: TObject);
//begin
//  var CurrChan := CbChannel.Text;   // preserve channel name
//  SetChannelList;
//  optokbutt.Enabled := CbChannel.ItemIndex >= 0; // Prevent exit with bad channel
//  if not optokbutt.Enabled then
//  begin
//    CbChannel.Text := CurrChan;       // restore name
//    Dimmer.ShowMessage('The currently selected tuner'#13'does not have the requested channel!');
//    CbChannel.ItemIndex := 0;
//  end;
//end;

//procedure TCapOptForm.CbTunerEnter(Sender: TObject);
//begin
//  if TunerListDone then exit;
//  Screen.Cursor := crHourGlass;
//  if CbTuner.ItemIndex < 0 then CbTuner.ItemIndex := 0;
//  var CurrTuner := CbTuner.Text{Items[CbTuner.ItemIndex]};  // save current name
//  CbTuner.Items.Clear;
//  // Add currently live nonconflicted tuners with channels to combobox
//  if EndDateTime.DateTime > now then // Event at least partly in the future
//  begin
//    for var i := 1 to Form2.cardlist.RowCount-1 do
//    begin
//      if UpperCase(Form2.cardlist.Cells[7,i]) <> 'TRUE' then continue;              // tuner not live
//      if CbHost.Text{Items[CbHost.ItemIndex]} <> Form2.cardlist.Cells[3,i] then continue; // hosts <>
//      if not TunerHasChannel(Form2.cardlist.Cells[6,i]) then continue;              // no channels on this host
//      if TunerConflicted(Form2.cardlist.Cells[6,i], True) then continue;            // Don't report conflicts, just skip
//      CbTuner.Items.Add(Form2.cardlist.Cells[6,i]);
//    end;
//  end;
//  TunerListDone := True;
//  Screen.Cursor := crDefault;
//  optokbutt.Enabled := CbTuner.Items.Count > 0; // Prevent exit with bad tuner
//  if optokbutt.Enabled  then
//  begin
//    CbTuner.ItemIndex := Max(0, CbTuner.Items.IndexOf(CurrTuner));    // restore if possible
//    SetChannelList;
//  end
//  else
//  begin
//    CbTuner.Text := '';
//    Dimmer.ShowMessage('There are no unconflicted tuners for this schedule!'#13'Please change the parameters.');
//  end;
//end;

//procedure TCapOptForm.CheckListBox1ClickCheck(Sender: TObject);
//begin
//  Recurrence := '';
//  for var i := 0 to CheckListBox1.Count-1 do
//    if CheckListBox1.Checked[i] then
//      Recurrence := Recurrence + IntToStr(i + 1);
//end;

//procedure TCapOptForm.CheckListBox1Exit(Sender: TObject);
//begin
//  Panel1.Hide;
//  CheckListBox1ClickCheck(Self);  // Update Recurrence
//  BtnRecurring.Caption := IfThen(Length(Recurrence)=0, 'Make Recurring', 'Edit Recursion');
//end;

//procedure TCapOptForm.FormActivate(Sender: TObject);
//begin
//  if Abs(100*Height - 45*Screen.Height) < 10000 then exit;
//  Scaleby(45*Screen.Height,100*Height);
//  Position := poScreenCenter;
//end;

//procedure TCapOptForm.FormClose(Sender: TObject; var Action: TCloseAction);
//begin
//  Dimmer.Hide;
//end;

//procedure TCapOptForm.FormCreate(Sender: TObject);
//begin
//  Scaleby(45*Screen.Height,100*Height);
//  Position := poScreenCenter;
//end;

procedure TCapOptForm.ListParam(Title: string);
begin
  Console.Log(Title
    + #13'  Title: ' + mmTitle.Text
//    + #13'  Computer: ' + CbHost.Text{Items[CbHost.ItemIndex]}
    + #13'  Tuner: ' + CbTuner.Text{Items[CbTuner.ItemIndex]}
    + #13'  Channel: ' + CbChannel.Text{Items[CbChannel.ItemIndex]}
    + #13'  StartTime: ' + DateTimeToStr(StartDateTime.DateTime)
    + #13'  EndTime: ' + DateTimeToStr(EndDateTime.DateTime));
end;

procedure TCapOptForm.FormShow(Sender: TObject);
begin
//  Dimmer.Display;
  BringToFront;
  Panel1.Hide;
  var AFmt := TFormatSettings.Create;
  for var i := 0 to 6 do
//    CheckListBox1.Items[i] := AFmt.ShortDayNames[i+1];
//  BtnRecurring.Caption := IfThen(Length(Recurrence)=0, 'Make Recurring', 'Edit Recursion');
//  for var i := 0 to CheckListBox1.Count-1 do
//    CheckListBox1.Checked[i] := Recurrence.Contains(IntToStr(i + 1));
//  ChanChangeEnabled := CbChannel.Enabled;
//  TunerListDone := False;
  ListParam(' TCapOptForm called with init. params:');
  // Indicate "read only" status of memo items
  mmTitle.Enabled := not mmTitle.ReadOnly;
  mmSubTitle.Enabled := not mmSubTitle.ReadOnly;
  mmDescrip.Enabled := not mmDescrip.ReadOnly;
  if CbTuner.Enabled then CbTuner.SetFocus;
end;

procedure TCapOptForm.optcanbuttClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TCapOptForm.optokbuttClick(Sender: TObject);
begin
//  StartDateTimeExit(Self);  // Make sure tuner is
//  CheckListBox1.OnClickCheck(Self);  // Make sure Recurrence updated
  ListParam(' TCapOptForm exited with final params: ');
end;

//procedure TCapOptForm.SetChannelList;
//
//  function Traditional(i: integer): Boolean;
//  begin
//    Result := (Form2.tunermaps.Cells[7,i] <> Form2.tunermaps.Cells[5,i]) or  // RF <> VC major
//              (Form2.tunermaps.Cells[8,i] <> Form2.tunermaps.Cells[6,i]);   // PID <> VC minor
//  end;
//
//  procedure AddChannel(i: Integer);
//  begin
//    if Traditional(i) then // Show the RF.PID too (but avoid IfThen overhead)
//      CbChannel.Items.Add(Format('%4d',[Form2.tunermaps.Ints[7,i]]) + '.' + Form2.tunermaps.Cells[8,i]   // VC
//        + '(' + Form2.tunermaps.Cells[5,i] + '.' + Form2.tunermaps.Cells[6,i] + ')'                      // (RFPID) if traditional tuning
//        + ': ' + Form2.tunermaps.Cells[3,i])                                                             // : PSIP name
//    else
//      CbChannel.Items.Add(Format('%4d',[Form2.tunermaps.Ints[7,i]]) + '.' + Form2.tunermaps.Cells[8,i]   // VC
//        + ': ' + Form2.tunermaps.Cells[3,i]);                                                            // : PSIP name
//  end;
//
//begin
//  var CurrChan: string := CbChannel.Text;  //  save current channel
//  var SaveChan := CurrChan;
////  if CbChannel.ItemIndex < 0 then CbChannel.ItemIndex := 0;
////  var TraditionalTuning := CurrChan.Contains('(');  // use format of input item to set mode
//  { This simple method of setting the mode works when both prior and current tuners
//    are using the same mode.  But it fails in a VC-only environment that mixes
//    old and new tuners. The challenge is to accommodate that without a big
//    performance hit. Hint: we need to look at the mode of the current tuner
//    and render the prior tuner's CbChannel (CurrChan) in the same mode. }
//  CbChannel.Items.Clear;
//  CbChannel.Sorted := True;
//  CbChannel.Enabled := ChanChangeEnabled;  // Restore inital state
//  // Strip off punctuation of HDHR tuner (Fusion/MyHD not affected)
//  var CurrTuner := string(CbTuner.Text){Items[CbTuner.ItemIndex]}.Split(['HR(',')'],TStringSplitOptions.ExcludeEmpty)[0];
//  // Build full channel list only if CbChannel.Enabled
//  if not CbChannel.Enabled then  // Look up translations for matching VC to current channel; N.B. on OTA (VC[1]<>"0") also need to match VC+100 for ATSC 3.0
//  begin
//    if CurrChan <> '' then
//    begin
//      var VC := CurrChan.Split(['(',':'])[0].Split([' ','.'],TStringSplitOptions.ExcludeEmpty);
//      var jmax := IfThen(VC[1] = '0', 0, 1);  // check for ATSC 1.0 and 3.0 VC iff OTA
//      for var j := 0 to jmax do begin
//        if jmax > 0 then VC[0] := (VC[0].ToInteger MOD 100 + j * 100).ToString;
//        var i := Form2.tunermaps.FindMulti([CurrTuner,                             // Current tuner
//                                            CbHost.Text{Items[CbHost.ItemIndex]},  // Current host
//                                            VC[0],VC[1]],                          // Target VC
//                                            [2,0,7,8],                             // match cols
//                                            [stEqual,stEqual,stEqual,stEqual],     // match types
//                                            [False,False,False,False]);            // case sensitive
//        while i > 0 do
//        begin
//          AddChannel(i);
//          i := Form2.tunermaps.FindMultiNext;
//        end;
//      end;
//      CbChannel.Enabled := CbChannel.Items.Count > 1;           // Override if dup VC found
//    end;
//  end
//  else    // build full channel list
//  begin
//    for var i := 1 to Form2.tunermaps.RowCount-1 do
//    begin
//      if CurrTuner <> Form2.tunermaps.Cells[2,i] then continue; // Tuners <>
//      if CbHost.Text{Items[CbHost.ItemIndex]} <> Form2.tunermaps.Cells[0,i] then continue; // Hosts <>
//      AddChannel(i);
//    end;
//  end;
//  if (CurrChan <> '') and
//    (CurrChan.Contains('(') <> CbChannel.Items[0].Contains('(')) then // old and new tuner modes <>
//  begin                                                              // translate CurrChan
//    var CC := CurrChan.Split(['(',')']);
//    if length(CC) = 3 then                                           // old tuner = Traditional
//      CurrChan := CC[0] + CC[2]                                      // translate to VC + ':' + PSIP name
//    else                                                             // old tuner = VC-only
//    begin                                                            // need to match with VC on new tuner
//      CC := CurrChan.Split([':']);
//      for var i := 0 to CbChannel.Items.Count-1 do
//      begin
//        if CC[0] <> CbChannel.Items[i].Split(['('])[0] then continue;  // VCs <>
//        CurrChan := CbChannel.Items[i];
//        break;
//      end;
//    end;
//  end;
//  CbChannel.ItemIndex := CbChannel.Items.IndexOf(CurrChan); // Restore chan if possible, -1 if not
//  if CbChannel.ItemIndex < 0 then CbChannel.Text := SaveChan;  // Avoid losing track of initial channel
//end;
//
//function TCapOptForm.TunerHasChannel(ATuner: string): Boolean;
//begin
//  for var i := 1 to Form2.tunermaps.RowCount-1 do
//  begin
//    if not ATuner.Contains(Form2.tunermaps.Cells[2,i]) then continue; // Tuners <>
//    if CbHost.Text{Items[CbHost.ItemIndex]} <> Form2.tunermaps.Cells[0,i] then continue; // Hosts <>
//    exit(True);  // Found a channel
//  end;
//  Result := False;  // No channels
//end;


procedure TCapOptForm.StartDateTimeExit(Sender: TObject);
begin
  // Guard against multiday settings
  if EndDateTime.DateTime - StartDateTime.DateTime > 1 then EndDateTime.Date := StartDateTime.Date;
  if StartDateTime.DateTime > EndDateTime.DateTime then
    EndDateTime.DateTime := EndDateTime.DateTime + 1;
//  if TunerConflicted(CbTuner.Text, False) then // Shout at conflicts
//  begin
//    CbTuner.Enabled := True;  // Relent tuner restriction
//    CbTuner.SetFocus;
//  end;
end;

end.
