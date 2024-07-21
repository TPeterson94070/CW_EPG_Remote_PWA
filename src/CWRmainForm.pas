unit CWRmainForm;
                       { TODO : Add search function to Listings (and History?) }
                       { TODO : Add item deletion to Scheduled list }
                       { TODO : Add one-off scheduling of Listing item }
interface

uses
  System.SysUtils, System.Classes, WEBLib.Graphics, WEBLib.Forms, Vcl.StdCtrls,
  WEBLib.StdCtrls, Vcl.Controls, WEBLib.Dialogs, Vcl.Imaging.pngimage,
  WEBLib.ExtCtrls, WEBLib.Controls, Web, JS, WebLib.DB, WEBLib.IndexedDb,
  Vcl.Menus, WEBLib.Menus, WEBLib.ComCtrls, WEBLib.Grids, DB, Vcl.Grids,
  System.StrUtils, WEBLib.DBCtrls, WEBLib.FlexControls, WEBLib.WebCtrls,
  WEBLib.REST, Types, WEBLib.Storage, WEBLib.CDS, WEBLib.Auth, WEBLib.JSON,
  WEBLib.WebTools, WEBLib.Google;

type
  TGridDrawState = set of (gdSelected, gdFocused, gdFixed, gdRowSelected, gdHotTrack, gdPressed);
  TCWRmainFrm = class(TWebForm)
  WebStringGrid1: TWebStringGrid;
  WIDBCDS: TWebIndexedDbClientDataset;
  WebButton1: TWebButton;
  WebMemo1: TWebMemo;
  seNumDisplayDays: TWebSpinEdit;
  WebGroupBox1: TWebGroupBox;
  WebGridPanel2: TWebGridPanel;
  WebGridPanel3: TWebGridPanel;
  lb01Title: TWebLabel;
  lb02New: TWebLabel;
  lb03Stereo: TWebLabel;
  lb04HD: TWebLabel;
  WebGridPanel4: TWebGridPanel;
  lb06SubTitle: TWebLabel;
  lb12Description: TWebLabel;
  WebGridPanel1: TWebGridPanel;
  WebGridPanel7: TWebGridPanel;
  lb07Dolby: TWebLabel;
  lb08CC: TWebLabel;
  lb09OrigDate: TWebLabel;
  WebGridPanel6: TWebGridPanel;
  lb10Channel: TWebLabel;
  lb11Time: TWebLabel;
  WebMemo2: TWebMemo;
  WebProgressBar1: TWebProgressBar;
  WebRadioGroup1: TWebRadioGroup;
  AlertLabel: TWebButton;
  WebStringGrid2: TWebStringGrid;
  AllCapsGrid: TWebStringGrid;
    HistoryTable: TWebStringGrid;
    Listings: TWebStringGrid;
    pnlCaptures: TWebPanel;
    pnlHistory: TWebPanel;
    pnlLog: TWebPanel;
    pnlOptions: TWebPanel;
    WebMessageDlg1: TWebMessageDlg;
    WebGroupBox3: TWebGroupBox;
    seNumHistEvents: TWebSpinEdit;
    WebPanel1: TWebPanel;
    WebButton2: TWebButton;
    WebRESTClient1: TWebRESTClient;
    WebButton3: TWebButton;
    pnlListingsGrid: TWebGridPanel;
    WebPanel2: TWebPanel;
    pnlListings: TWebPanel;
    NewCapturesTable: TWebStringGrid;
    WebPanel3: TWebPanel;

  procedure LoadWIDBCDS;
  procedure WIDBCDSIDBError(DataSet: TDataSet; opCode: TIndexedDbOpCode;
    errorName, errorMsg: string);
  procedure WIDBCDSAfterOpen(DataSet: TDataSet);
  [async]
  procedure WebButton1Click(Sender: TObject);
  [async]
  procedure WebFormCreate(Sender: TObject);
  procedure seNumDisplayDaysChange(Sender: TObject);
  [async]
  procedure WebRadioGroup1Change(Sender: TObject);
  procedure WebStringGrid2DblClick(Sender: TObject);
  [async]
  procedure tbCapturesShow;
    procedure AllCapsGridGetCellData(Sender: TObject; ACol, ARow: Integer;
      AField: TField; var AValue: string);
    procedure ListingsDblClick(Sender: TObject);
    [async]
    procedure ListingsClickCell(Sender: TObject; ACol, ARow: Integer);
    procedure ListingsSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure seNumHistEventsChange(Sender: TObject);
    procedure HistoryTableFixedCellClick(Sender: TObject; ACol, ARow: Integer);
//    [async]
//    procedure AllCapsGridDblClick(Sender: TObject);
//    procedure AllCapsGridClickCell(Sender: TObject; ACol, ARow: Integer);
    [async]
    procedure WebButton2Click(Sender: TObject);
    [async]
    procedure WebButton3Click(Sender: TObject);
//    procedure WebClientDataSet1AfterOpen(DataSet: TDataSet);
private
  { Private declarations }
  [async]
  procedure WebFormShow;
  procedure ColorGridRow(WSG: TWebStringGrid; ARow: Integer);
  [async]
  procedure SetPage(PageNum: Integer);
  [async]
  procedure FetchCapReservations;
  [async]
  procedure RefreshCSV(WSG: TWebStringGrid; TableFile, Title: string; var id: string);
  [async]
  procedure FetchHistory;
  [async]
  procedure ReFreshListings;
  [async]
  procedure tbHistoryShow;
  [async]
  procedure FillHistoryDisplay;
  [async]
  procedure RefreshHistory;
  [async]
  procedure UpdateNewCaptures(RecordStart, RecordEnd: TDateTime);
  [async]
  function GetGoogleDriveFile(TableFile: string; var id: string): string;
  [async]
  procedure CreateGoogleFile(FName: string; var id: string);

public
  { Public declarations }
end;

var
  CWRmainFrm: TCWRmainFrm;

implementation

uses
  System.Math, SchedUnit2;

{$R *.dfm}

var
  ClickedCol,  ClickedRow: Integer;
  ResetPrompt: string = '&prompt=none' ; //'&prompt=select_account';

const
  DBFIELDS: array[0..13] of string = ('PSIP', 'Time', 'Title', 'SubTitle', 'Description',
  	'StartTime', 'EndTime', 'programID', 'originalAirDate', 'new',
    'audioProperties', 'videoProperties', 'movieYear', 'genres');
  NUMDAYS = 'NumDisplayDays';
  NUMHIST = 'NumHistoryItems';

procedure Log(const s: string);
begin
  CWRmainFrm.WebMemo2.Lines.Add(DateTimeToStr(now) + '--' + s);
  console.log(DateTimeToStr(now) + '--' + s);
end;

procedure SetTableDefaults(WSG: TWebStringGrid; C0, C1, C2, C3: Integer);
var
  i: Integer;
begin
  WSG.ColWidths[0] := C0;
  WSG.ColWidths[1] := C1;
  WSG.ColWidths[2] := C2;
  WSG.ColWidths[3] := C3;
  for i := 4 to WSG.ColCount-1 do WSG.ColWidths[i] := 0;
  WSG.ColAlignments[0] := taCenter;
  WSG.ColAlignments[1] := taCenter;

end;


procedure TCWRmainFrm.WebFormCreate(Sender: TObject);
var
  i: Integer;
  AppVersion: string;
begin
  Log('FormCreate is called');
{$IFDEF PAS2JS}
  asm
    console.log('Starting ' + ProjectName);
// Define sleep function used to allow screen updates
    window.sleep = async function(msecs) {return new Promise((resolve) => setTimeout(resolve, msecs)); }
// Retrieve JS version info in Delphi variable
    AppVersion = ProjectName;
// Discover if installed ("standalone") : Does not work!!
//   IsInstalled = (window.matchMedia('(display-mode: standalone)').matches) ||
//                 ('standalone' in window.navigator);
  end;
{$ENDIF}
  // Log Version Information
  Log('Running version:  ' + AppVersion);
  Log('App is ' + IfThen(not Application.IsOnline, 'NOT ') + 'online');
  WebRESTClient1.ReadTokens; // retrieve previous access token
  if TWebLocalStorage.GetValue(NUMDAYS) <> '' then
    seNumDisplayDays.Value := StrToInt(TWebLocalStorage.GetValue(NUMDAYS));
  if TWebLocalStorage.GetValue(NUMHIST) <> '' then
    seNumHistEvents.Value := StrToInt(TWebLocalStorage.GetValue(NUMHIST));
  FillHistoryDisplay;
  Listings.RowCount := 1;
  SetTableDefaults(Listings, 70, 150, ClientWidth, 0);
  WebStringGrid1.RowCount := 1;
  WebStringGrid1.ColCount := Length(DBFIELDS);
  WIDBCDS.FieldDefs.Clear;
  // add key field
  WIDBCDS.FieldDefs.Add('id',ftInteger, 0, true);
  // add normal fields
  for i := 0 to WebStringGrid1.ColCount - 1 do
  begin
    WIDBCDS.FieldDefs.Add(DBFIELDS[i],ftString);
    WebStringGrid1.Cells[i,0] := DBFIELDS[i];
    if i < 3 then Listings.Cells[i,0] := DBFIELDS[i];
  end;
  Log('FormCreate, calling DB.Open');
  WIDBCDS.Open;
  Log('FormCreate is finished');
end;

procedure TCWRmainFrm.WIDBCDSAfterOpen(DataSet: TDataSet);
begin
  Log('WIDBCDSAfterOpen, ' + DataSet.Name + ' field count: ' + WIDBCDS.FieldCount.ToString);
  WebFormShow;
end;

procedure TCWRmainFrm.WebFormShow;
begin
  Log('WebFormShow, calling RefreshListings');
  await(ReFreshListings);
  Log('WebFormShow, Listings refresh done');
  if Listings.RowCount > 2 then begin
    Listings.SetFocus;
    Listings.SelectCell(0,1);
  end;
end;

procedure TCWRmainFrm.WebButton1Click(Sender: TObject);
var
  id: string;
begin
  Log('======== "Refresh EPG" clicked');
  await (RefreshCSV(WebStringGrid1, 'cwr_epg.csv','EPG', id));
  await(LoadWIDBCDS);
  Log('Finished (re)loading WIDBCDS');
  await(FetchCapReservations);
  await(RefreshListings);
end;

procedure TCWRmainFrm.WebButton2Click(Sender: TObject);
begin
  await(RefreshHistory);
end;

procedure TCWRmainFrm.WebButton3Click(Sender: TObject);
begin
  Log('Server reset requested');
  if TAwait.ExecP<TModalResult> (MessageDlgAsync('Do you want to change HTPC source?',
    mtConfirmation, [mbYes,mbNo])) = mrYes then
  begin
    ResetPrompt := '&prompt=select_account';
    WebButton1Click(Self);
    WebButton2Click(Self);
  end;
  exit;
end;

procedure TCWRmainFrm.RefreshHistory;
begin
//  WebRadioGroup1.Enabled := False;
  await(FetchHistory);
  SetPage(2);
  {$IFDEF PAS2JS} asm await sleep(10) end; {$ENDIF}
//  WebRadioGroup1.Enabled := True;
end;

function TCWRmainFrm.GetGoogleDriveFile(TableFile: string; var id: string): string;
var
  q, AResponse: string;
  rq: TJSXMLHttpRequest;
  jso: TJSONObject;
  ja: TJSONArray;
  i: integer;

  [async]
  function TryLogIn: TJSXMLHttpRequest;
  begin
  // AccessExpiry is number of seconds, not a DateTime/Timestamp !!
    console.log('AccessExpiry: ' + Double(WebRESTClient1.AccessExpiry).toString
      + ' or DateTime?: ' + DateTimeToStr(WebRESTClient1.AccessExpiry));
    console.log('AccessToken: ' + WebRESTClient1.AccessToken);
    if WebRESTClient1.AccessToken = '' then ResetPrompt := 'select_account';
    WebRESTClient1.App.Key := '654508083810-kdj6ob7srm922egkvdmcj36hfa1hitav.apps.googleusercontent.com';
    WEBRESTClient1.App.CallBackURL := window.location.href;
    WEBRESTClient1.App.AuthURL := 'https://accounts.google.com/o/oauth2/v2/auth'
      + '?client_id=' + WebRESTCLient1.App.Key
      + '&include_granted_scopes'
      + '&scope=https://www.googleapis.com/auth/drive'
      + '&state=bf'
      + '&response_type=token'
      + '&redirect_uri=' + WEBRESTClient1.App.CallbackURL
      + '&prompt=' + ResetPrompt;
    console.log('WEBRESTClient1.App.CallBackURL: ' + WEBRESTClient1.App.CallbackURL);
    if (WebRESTClient1.AccessToken = '') or (ResetPrompt <> 'none') then
    begin
      console.log('Performing OAuth');
      TAwait.ExecP<TJSPromiseResolver> (WebRESTClient1.Authenticate);
    end;
    ResetPrompt := 'none';
    console.log('AccessExpiry: ' + Double(WebRESTClient1.AccessExpiry).toString
      + ' or DateTime?: ' + DateTimeToStr(WebRESTClient1.AccessExpiry));
    q :='name = ''' + TableFile + ''' and trashed = false';

    Result := TAwait.ExecP<TJSXMLHttpRequest> (WEBRESTClient1.HttpRequest('GET',
      'https://www.googleapis.com/drive/v3/files?q='+WEBRestClient1.URLEncode(q)));
  end;

begin
  Result := '';
  rq := await(TJSXMLHttpRequest, TryLogIn);
  if Assigned(rq) then
  begin
    // Check for error
    if rq.Status <> 200 then // Set up a retry
    begin
      if rq.Status = 301 then // Access token expired
      begin
        console.log(rq.StatusText);
        WebRESTClient1.ClearTokens;
        console.log('Retrying login');
        rq := await(TJSXMLHttpRequest, TryLogIn);
        if rq.Status <> 200 then exit('');
      end;
    end;
    AResponse := rq.responseText;
    console.log(rq.responseText);

    jso := TJSONObject(TJSONObject.ParseJSONValue(AResponse));

    if Assigned(jso) then
    begin
      ja := TJSONArray(jso.GetValue('files'));
      Log(ja.count.tostring + ' files found');
      for i := 0 to ja.Count - 1 do
      begin
        jso := TJSONObject(ja.Items[i]);
        if jso.GetJSONValue('name') = TableFile then
          id := string(jso.GetJSONValue('id'));
      end;
      jso.Free;
      ja.Free;
      console.log(id);
      if id = '' then exit('');
{$IF PAS2JS}
      rq := TAwait.ExecP<TJSXMLHttpRequest> (WebRESTClient1.httprequest('GET',
        'https://www.googleapis.com/drive/v3/files/'+id+'?alt=media').catch(
        function(AValue: JSValue): JSValue
        begin
          console.log('error here',AValue);
        end));
{$ENDIF}
      if Assigned(rq) then Result := rq.responseText;
    end;
  end;
end;

procedure TCWRmainFrm.RefreshCSV(WSG: TWebStringGrid; TableFile, Title: string; var id: string);
var
  Reply, Line: string;
  sl: TStrings;
  ReplyArray: TArray<string>;
begin
  Log('ReFreshCSV called for ' + TableFile);
  if application.IsOnline then
  begin
    AlertLabel.Caption := 'Refreshing '+Title+' data <i class="fa-solid fa-spinner fa-spin"></>';
    WebRadioGroup1.Hide;
    AlertLabel.Show;
    AlertLabel.BringToFront;
  {$IFDEF PAS2JS} asm await sleep(10) end; {$ENDIF}

    WSG.BeginUpdate;
    try
      Log('Requesting: ' + TableFile);
      try
        Reply := {TAwait.Exec<string>}await (GetGoogleDriveFile(TableFile, id));

        if Reply <> '' then  // Got a response
        begin
          Log(copy(Reply,1,500));
          sl := TStringList.Create;
          Reply := ReplaceStr(Reply, #10, ''); // dump linefeeds
          Reply := ReplaceStr(Reply, #160, ''); // dump &nbsp too
          ReplyArray := Reply.Split([#13],TStringSplitOptions.ExcludeEmpty);
          Log('Begin extract ' + IntToStr(Length(ReplyArray)) + ' strings');
          for Line in ReplyArray do sl.Add(Line);
          WSG.LoadFromStrings(sl, ',', True);
          Log(WSG.Name+'.RowCount: ' + WSG.RowCount.ToString);
          Log('Done loading '+WSG.Name);
          sl.Free; // := nil;
        end
        else WSG.RowCount := 0;
      except
        on E:Exception do
        begin
          Log('HttpRequest Exception: ' + E.Message);
          ShowMessage('Cannot refresh EPG data while CW_EPG_Remote is offline');
        end;
      end;
    finally
      Log('Enter finally section');
      WSG.EndUpdate;
      Log('"Finishing" AlertLabel');
      AlertLabel.Caption := 'Finishing up '+Title+' data <i class="fa-solid fa-spinner fa-spin"></>';
  {$IFDEF PAS2JS} asm await sleep(10) end; {$ENDIF}
      AlertLabel.Hide;
      WebRadioGroup1.Show;
      Log('Done hiding');
    end;
  end
  else
  begin
    ShowMessage('Cannot refresh EPG data while offline.');
    Log('No LAN connection');
  end;
  Log('ReFreshCSV, '+WSG.Name+' RowCount: ' + WSG.RowCount.ToString);
end;

procedure TCWRmainFrm.LoadWIDBCDS;
var i,j: Integer;
begin
  Log('LoadWIDBCDS, DB is ' + IfThen(not WIDBCDS.Active, 'not ') + 'Active');
  if WIDBCDS.Active and (WebStringGrid1.RowCount > 1) then
  begin
    Log('LoadWIDBCDS, DB is ' + IfThen(not WIDBCDS.IsEmpty, 'not ') + 'empty');
    if not WIDBCDS.IsEmpty then
    begin
      Log('LoadWIDBCDS, DB.RecordCount: ' + WIDBCDS.RecordCount.ToString);
      WIDBCDS.RecNo := 1;
    end;
    // Empty the DB
    while not WIDBCDS.IsEmpty do WIDBCDS.Delete;
    Log('LoadWIDBCDS (after empty), DB.RecordCount: ' + WIDBCDS.RecordCount.ToString);
    Log('LoadWIDBCDS, WSG1.RowCount: ' + WebStringGrid1.RowCount.ToString);
    // Lose superfluous <">
    for j := 1 to WebStringGrid1.RowCount - 1 do
      WebStringGrid1.Cells[0,j] := ReplaceStr(WebStringGrid1.Cells[0,j],'"','');
    for j := 1 to WebStringGrid1.RowCount - 1 do
    begin
      WIDBCDS.Append;
      for i := 1 to WebStringGrid1.ColCount do
        WIDBCDS.Fields[i].Value := WebStringGrid1.Cells[i-1,j];
    end;
    WIDBCDS.Post;
    Log('LoadWIDBCDS, DB.RecordCount: ' + WIDBCDS.RecordCount.ToString);
    WebStringGrid1.RowCount := 0;
  end;
end;

procedure TCWRmainFrm.ReFreshListings;
var
  i, j, k: Integer;
  EndDT, MinDT, MaxDT: TDateTime;
  DBincRecs: TStringList;

begin
  Log('ReFreshListings, DB is ' + IfThen(not WIDBCDS.Active, 'not ')
    + 'Active and ' + IfThen(not WIDBCDS.IsEmpty, 'not ') + 'Empty');
  if WIDBCDS.Active and not WIDBCDS.IsEmpty then
  begin
//    WebRadioGroup1.Enabled := False;
    WebRadioGroup1.ItemIndex := 4;
    WebPanel1.BringToFront;
  {$IFDEF PAS2JS} asm await sleep(10) end; {$ENDIF}
    Log('Memo1 is showing');
    DBIncRecs := TStringList.Create;
    MinDT := now;
    Log('EPG Starting time: ' + DateTimeToStr(MinDT));
    MaxDT := MinDT + seNumDisplayDays.Value;
    Log('EPG Ending time: ' + DateTimeToStr(MaxDT));
    Log('DB Record Count: ' + WIDBCDS.RecordCount.ToString);
    k := 1;
    for i := {1}2 to WIDBCDS.RecordCount do
    begin
      // Add only records between now and now + NumDisplayDays
      WIDBCDS.RecNo := i;
      if WIDBCDS.Fields[6].AsString > '' then // trap nulls
      begin
        EndDT := WIDBCDS.Fields[6].AsDateTime;
        if (EndDT >= MinDT) and (EndDT < MaxDT) then
        begin
          DBIncRecs.Add(WIDBCDS.RecNo.ToString);
          inc(k);
        end;
      end;
    end;
    Listings.BeginUpdate;
    try
      Listings.RowCount := k;
      Log('ReFreshListings, No. recs to add: ' + (k - 1).ToString);
      if k < 2 then
      begin
        Log('No hits in current DB, prompting for EPG fetch');
        if TAwait.ExecP<TModalResult> (MessageDlgAsync('There are no current listings.'
          + #13#13'Do you want to refresh them?',mtConfirmation, [mbYes,mbNo]))
          = mrYes then
        begin
          SetPage(4);
          WebButton1Click(Self);
        end;
        exit;
      end;
  {$IFDEF PAS2JS} asm await sleep(10) end; {$ENDIF}
      WebProgressBar1.Position := 0;
      WebProgressBar1.Max := k - 2;
      for j := 0 to k - 2  do
      begin
        WIDBCDS.RecNo := DBIncRecs[j].ToInteger;
        Listings.Cells[3,j+1] := DBIncRecs[j];
        for i := 0 to 2 do
          Listings.Cells[i,j+1] := WIDBCDS.Fields[i+1].AsString;
        ColorGridRow(Listings, j+1);
        if (j mod (k div 100)) = 0 then
        begin
          WebProgressBar1.Position := j;
//          Log('j: ' + j.ToString);
  {$IFDEF PAS2JS} asm await sleep(10) end; {$ENDIF}
        end;
      end;
      Listings.Cells[0,0] := 'Channel';
    finally
      Listings.EndUpdate;
//      WebRadioGroup1.Enabled := True;
      SetPage(0);
    end;
  end else begin
    SetPage(4);
  {$IFDEF PAS2JS} asm await sleep(10) end; {$ENDIF}
    ShowMessage('Please click "Refresh EPG" button');
  end;
//  WebRadioGroup1.Enabled := True;
  {$IFDEF PAS2JS} asm await sleep(10) end; {$ENDIF}
  DBIncRecs := nil;
end;

procedure TCWRmainFrm.seNumDisplayDaysChange(Sender: TObject);
begin
  Log('Number EPG Display Days: ' + seNumDisplayDays.Value.ToString);
  TWebLocalStorage.SetValue(NUMDAYS,seNumDisplayDays.Value.ToString);
end;

procedure TCWRmainFrm.seNumHistEventsChange(Sender: TObject);
begin
  Log('Number History Items: ' + seNumHistEvents.Value.ToString);
  TWebLocalStorage.SetValue(NUMHIST,seNumHistEvents.Value.ToString);
end;

procedure TCWRmainFrm.tbCapturesShow;
var
  sl: TStrings;
  i: Integer;

begin
  if TWebLocalStorage.GetValue('sl1') > '' then  // have stored value(s)
  begin
    sl := TStringList.Create;
    i := 0;
    while ReplaceStr(ReplaceStr(TWebLocalStorage.GetValue('sl'+i.ToString),'"',''),',','') > '' do
    begin
      sl.Add(TWebLocalStorage.GetValue('sl'+i.ToString));
      Inc(i);
    end;
    AllCapsGrid.LoadFromStrings(sl, ',', True);
    Log('AllCapsGrid.RowCount: ' + AllCapsGrid.RowCount.ToString);
    sl.Free;
    // Discard stale entries (End DateTime < now)
    for i := AllCapsGrid.RowCount-1 downto 1 do
      if AllCapsGrid.Cells[3,i] > '' then // not null row
        if StrToDateTime(AllCapsGrid.Cells[3,i] + ' ' + AllCapsGrid.Cells[5,i]) < now then
          AllCapsGrid.RemoveRow(i);
  end;
  for i := 0 to AllCapsGrid.ColCount-1 do AllCapsGrid.ColWidths[i] := 0;
  AllCapsGrid.ColWidths[1] := 80;  // Computer
  AllCapsGrid.ColWidths[2] := 100; // Tuner
  AllCapsGrid.ColWidths[3] := 65; // Date
  AllCapsGrid.ColWidths[4] := 45; // Start
  AllCapsGrid.ColWidths[5] := 45; // End
  AllCapsGrid.ColWidths[6] := 70; // Channel
  AllCapsGrid.ColWidths[8] := AllCapsGrid.ClientWidth; // Title
  for i := 1 to 6 do AllCapsGrid.ColAlignments[i] := taCenter;
  Log('AllCapsGrid.RowCount after stale check: ' + AllCapsGrid.RowCount.ToString);
//  Log('AllCapsGrid.Cells[25,1]: <' + AllCapsGrid.Cells[25,1] + '>');
  if (AllCapsGrid.RowCount = 2) and (AllCapsGrid.Cells[25,1] = '-1') then  // Valid list, no captures, reload??
  begin
    Log('No captures listed, prompting for EPG fetch');
    if TAwait.ExecP<TModalResult> (MessageDlgAsync('There were no scheduled items at last fetch.'
      + #13#13'Do you want to refresh the list?',mtConfirmation, [mbYes,mbNo]))
      = mrYes then
    begin
      SetPage(4);
      WebButton1Click(Self);
    end;
  end
  else if AllCapsGrid.RowCount < 2 then // Invalid list
  begin
    Log('No fresh captures, prompting for EPG fetch');
    if TAwait.ExecP<TModalResult> (MessageDlgAsync('The list appears to be stale.'
      + #13#13'Do you want to refresh the list?',mtConfirmation, [mbYes,mbNo]))
      = mrYes then
    begin
      SetPage(4);
      WebButton1Click(Self);
    end;
  end  ;
end;

procedure TCWRmainFrm.FillHistoryDisplay;
var
  sl: TStrings;
  i: Integer;

begin
  Log('FillHistoryDisplay called');
  sl := TStringList.Create;
  for i := 0 to seNumHistEvents.Value do
    if TWebLocalStorage.GetValue('hl'+i.ToString) > '' then
      sl.Add(TWebLocalStorage.GetValue('hl'+i.ToString));
  Log('sl.Count: ' + sl.Count.ToString);
  if sl.Count > 1 then begin
    Log('HistoryTable.BeginUpdate');
    HistoryTable.BeginUpdate;
    Log('HistoryTable.LoadFromStrings');
    HistoryTable.LoadFromStrings(sl,',',True);
    Log('HistoryTable.RowCount: ' + HistoryTable.RowCount.ToString);
  end;
  HistoryTable.RowCount := Min(seNumHistEvents.Value + 1,sl.Count);
  Log('sl.Free');
  sl.Free;
  Log('HistoryTable.RowCount: ' + HistoryTable.RowCount.ToString);
  for i := HistoryTable.ColCount-1 downto 0 do
  begin
    if i in [8,10,12,13,14] then continue;
    HistoryTable.RemoveColumn(i);
  end;
  HistoryTable.ColCount := 5;
  SetTableDefaults(HistoryTable, 120, 150, 250, 300);
  for i := 1 to HistoryTable.RowCount - 1 do
  begin
    HistoryTable.Cells[4,i] := Format('%10.3f',[StrToDateTime(HistoryTable.Cells[0,i])]);
    HistoryTable.Cells[0,i] := FormatDateTime('mm/dd/yy h:nna/p', StrToDateTime(HistoryTable.Cells[0,i]))
  end;
  HistoryTable.Cells[0,0] := HistoryTable.Cells[0,0] + ' v'; // Show descending time sort
  HistoryTable.EndUpdate;
//  HistoryChanged := False;
  Log('FillHistoryDisplay finished');
end;

procedure TCWRmainFrm.HistoryTableFixedCellClick(Sender: TObject; ACol,
  ARow: Integer);
var
  i: Integer;
  SortDir: TGridSortIndicator;
begin
  if RightStr(HistoryTable.Cells[ACol,0],1) = '^' then SortDir := siDescending
  else SortDir := siAscending;
  Log('HistoryTableFixedCellClick, ACol: '+ACol.ToString+', RowCount: '+HistoryTable.RowCount.ToString);
  i := IfThen(ACol=0, 4, ACol);
  HistoryTable.BeginUpdate;
  HistoryTable.Sort(i,SortDir);
  HistoryTable.EndUpdate;
  Log('HistoryTableFixedCellClick, after sort, RowCount: '+HistoryTable.RowCount.ToString);
  // Remove previous direction flags
  for i := 0 to HistoryTable.ColCount-1 do
  if '^v'.Contains(RightStr(HistoryTable.Cells[i,0],1)) then
    HistoryTable.Cells[i,0] := LeftStr(HistoryTable.Cells[i,0],Length(HistoryTable.Cells[i,0])-2);
  // Add current direction flag
  HistoryTable.Cells[ACol,0] := HistoryTable.Cells[ACol,0] + IfThen(SortDir=siDescending, ' v', ' ^');
end;

procedure TCWRmainFrm.tbHistoryShow;
begin
  HistoryTable.Visible := False;
  Log('HistoryTable.RowCount: ' + HistoryTable.RowCount.ToString);
  if HistoryTable.RowCount <> seNumHistEvents.Value + 1 then  // may need History data
  begin
    Log('The History list is empty/incomplete. Prompt for refresh');
    if TAwait.ExecP<TModalResult> (MessageDlgAsync('The History list '
     + IfThen(HistoryTable.RowCount < 2,'is empty','may be incomplete')
      + #13#13'Do you want to refresh it now?',mtConfirmation, [mbYes,mbNo]))
      = mrYes then await(RefreshHistory);
  end;
  await(FillHistoryDisplay);
//  asm await sleep(10) end;
  HistoryTable.Visible := True;
end;

procedure TCWRmainFrm.SetPage(PageNum: Integer);

begin
  if PageNum <> WebRadioGroup1.ItemIndex then begin
    Log('Leaving Page: ' + WebRadioGroup1.Items[WebRadioGroup1.ItemIndex]);
  end;
  WebRadioGroup1.ItemIndex := PageNum;
  WebRadioGroup1Change(Self);
end;

procedure TCWRmainFrm.WebRadioGroup1Change(Sender: TObject);
begin
  Log('Showing Page: ' + WebRadioGroup1.Items[WebRadioGroup1.ItemIndex]);
//  WebRadioGroup1.Enabled := False;
  {$IFDEF PAS2JS} asm await sleep(10) end; {$ENDIF}
  case WebRadioGroup1.ItemIndex of
    0: begin          {Listings page}
      pnlListings.BringToFront;
      Log('Sender: ' + Sender.ToString);
      Listings.SetFocus;
    end;
    1: begin          {Captures}
      pnlCaptures.BringToFront;
      tbCapturesShow;
    end;
    2: begin {History}
      pnlHistory.BringToFront;
      tbHistoryShow;
    end;
    3: begin  {Log}
      pnlLog.BringToFront;
    end;
    4: begin {Options}
      pnlOptions.BringToFront;
    end;
  end;
//  WebRadioGroup1.Enabled := True;
  {$IFDEF PAS2JS} asm await sleep(10) end; {$ENDIF}
end;

procedure SetLabelStyle(lbl: TWebLabel; State: Boolean);
//  Show detail items in red (on) or lt. gray (off)
begin
  lbl.Font.Color := IfThen(State, clRed, clLtGray);
end;

//procedure TCWRmainFrm.AllCapsGridClickCell(Sender: TObject; ACol,
//  ARow: Integer);
//begin
//  ClickedCol := ACol;
//  ClickedRow := ARow;
//  Log('Clicked Col, Row: ' + ACol.ToString + ', ' + ARow.ToString);
//end;

//procedure TCWRmainFrm.AllCapsGridDblClick(Sender: TObject);
//var
//  i: Integer;
//  URL, Response: string;
//begin
//  i := ClickedRow;
//
//  if AllCapsGrid.cells[1,i] = '' then exit;
//
////  AllCapsGrid.OnGetCellData := nil;
//  if TAwait.ExecP<TModalResult> (MessageDlgAsync('Erase "' + AllCapsGrid.cells[8,i] + '" ' + AllCapsGrid.cells[3,i] + ' ' + AllCapsGrid.cells[4,i] + ' - ' + AllCapsGrid.cells[5,i] + ' '
//    + ' Schedule Entry?', mtConfirmation, [mbYes, mbNo])) = mrNo then exit;
////    Start the delete here...............                                           // Delete schedule Entry
//  Log('  >>>>>  ' + AllCapsGrid.cells[1,i] + ' - ' + AllCapsGrid.cells[2,i]
//    + '  Delete : (' + AllCapsGrid.cells[0,i]
//    + ') ' + AllCapsGrid.cells[8,i] + ' - ' + AllCapsGrid.cells[3,i] + ' '
//    + AllCapsGrid.cells[4,i] + '-' + AllCapsGrid.cells[5,i]);
//  URL := 'https://' + CWHelperIP + ':8443/decapture?sequence=' + AllCapsGrid.cells[0,i];
//  Response := await(HttpReq(URL));
//  // Assume success, delete AllCapsGrid row i
////  showmessage('Response: ' + Response);
//  if Response<>'' then AllCapsGrid.RemoveRow(i);
////  AllCapsGrid.OnGetCellData := AllCapsGridGetCellData;
//end;

procedure TCWRmainFrm.AllCapsGridGetCellData(Sender: TObject; ACol,
  ARow: Integer; AField: TField; var AValue: string);
begin
  if ARow > 0 then
  case ACol of
  1: if Length(AValue) > 10 then
     AValue := LeftStr(AValue,4) + '...' + RightStr(AValue,3);
  2: AValue := copy(AValue,4,10);
  end;
end;

procedure TCWRmainFrm.ColorGridRow(WSG: TWebStringGrid; ARow: Integer);
{ show listings in color code for type based on current IDB record }
var
  i: Integer;
  AColor: string;
  Text: string;
  el: TJSHTMLElement;
begin
  WIDBCDS.RecNo := WSG.Cells[3,ARow].ToInteger;
  Text := WIDBCDS.Fields[8].AsString; // i.e. ProgramID
  if Text.Contains('MV') then  // Movie item
    AColor := '#EEE8AA'        // PaleGoldenRod
  else if Text.Contains('SH') then  // Generic item
    AColor := '#D3D3D3'        // LightGray
  else begin
    if WIDBCDS.Fields[10].AsString <> '' then  // New item
      AColor := '#98FB98'      // SpringGreen
    else                                // Rerun item
      AColor := '#FFD0DB';
  end;
  for i := 0 to 2 do
  begin
    el := WSG.CellElements[i,ARow];
    el['bgcolor'] := AColor;
  end;
end;

procedure TCWRmainFrm.ListingsClickCell(Sender: TObject; ACol,
  ARow: Integer);
var
  newform: TSchedForm;
begin
  ClickedCol := ACol;
  ClickedRow := ARow;
  Log('Clicked Col, Row: ' + ACol.ToString + ', ' + ARow.ToString + ' contains: ' + Listings.Cells[ACol,ARow] );
  newform := TSchedForm.Create(Self);
  newform.Caption := 'Schedule Capture Event';
  newform.Popup := True;
  newform.Border := fbDialog;

  // used to manage Back button handling to close subform
  window.location.hash := 'subform';
  try
    // load file HTML template + controls
    TAwait.ExecP<TSchedForm>(newform.Load());

  // init controls after loading
    newform.mmTitle.Text := Listings.Cells[2,ARow];
    newform.mmSubTitle.Text := lb06SubTitle.Caption;
    newform.mmDescription.Text := lb12Description.Caption;
    newform.lblChannelValue.Caption := lb10Channel.Caption;
    newform.lblStartDateValue.Caption := WIDBCDS.FieldByName('StartTime').AsString.Split([' '])[0];
    newform.tpStartTime.DateTime := WIDBCDS.FieldByName('StartTime').AsDateTime;
    newform.tpEndTime.DateTime := WIDBCDS.FieldByName('EndTime').AsDateTime;
  // execute form and wait for close
    TAwait.ExecP<TModalResult>(newform.Execute);
    if newform.ModalResult = mrOk then
      await (UpdateNewCaptures(newform.tpStartTime.DateTime, newform.tpEndTime.DateTime));
  finally
    newform.Free;
  end;
end;

procedure TCWRmainFrm.ListingsDblClick(Sender: TObject);
var
  i: Integer;
begin
  Log('DblClick at [' + ClickedCol.ToString + ',' + ClickedRow.ToString + ']');
  case ClickedCol of
    0, 2: begin  // Filter channels, Titles
      Log('Filtering Channels on ' + Listings.Cells[ClickedCol, ClickedRow]);
      WebStringGrid2.RowCount := 1;
      WebStringGrid2.ColCount := Listings.ColCount;
      for i := 0 to Listings.ColCount-1 do
        WebStringGrid2.ColWidths[i] := Listings.ColWidths[i];
      WebStringGrid2.ColAlignments[0] := taCenter;
      WebStringGrid2.ColAlignments[1] := taCenter;
      WebStringGrid2.Cells[1,0] := 'List of matching ';
      WebStringGrid2.Cells[2,0] :=  Listings.Cells[ClickedCol,0] + ' (Dbl clk to return)';
      WebStringGrid2.Show;
      WebGridPanel2.Hide;
      WebStringGrid2.BringToFront;
      WebStringGrid2.BeginUpdate;
      for i := 1 to Listings.RowCount - 1 do
        if Listings.Cells[ClickedCol, i] = Listings.Cells[ClickedCol, ClickedRow] then
        begin
          WebStringGrid2.RowCount := WebStringGrid2.RowCount + 1;
          WebStringGrid2.Rows[WebStringGrid2.RowCount-1].Assign(Listings.Rows[i]);
          ColorGridRow(WebStringGrid2, WebStringGrid2.RowCount-1);
        end;
      WebStringGrid2.EndUpdate;
    end;
  end;
end;

procedure TCWRmainFrm.ListingsSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var x: TArray<string>;
begin
  { display details of the new record}
  WIDBCDS.RecNo := Listings.Cells[3,ARow].ToInteger;
  lb01Title.Caption := ReplaceStr(WIDBCDS.Fields[1+2].AsString, '&', '&&');
  lb06SubTitle.Caption := WIDBCDS.Fields[1+3].AsString;
  lb09OrigDate.Caption := IfThen(WIDBCDS.Fields[1+12].AsString > '', 'Movie Yr', '1st Aired') + '  ';
  lb11Time.Caption := WIDBCDS.Fields[1+1].AsString;
  lb10Channel.Caption := WIDBCDS.Fields[1+0].AsString;
  x := WIDBCDS.Fields[1+8].AsString.Split(['-']);
  if Length(x) = 3 then
    lb09OrigDate.Caption := lb09OrigDate.Caption + x[1] + '/' + x[2] + '/' + RightStr(x[0],2)
  else
    lb09OrigDate.Caption := lb09OrigDate.Caption + WIDBCDS.Fields[1+12].AsString;
  SetLabelStyle(lb02New, WIDBCDS.Fields[1+9].AsString <> '');
  SetLabelStyle(lb08CC, WIDBCDS.Fields[1+10].AsString.Contains('cc'));
  SetLabelStyle(lb03Stereo, WIDBCDS.Fields[1+10].AsString.Contains('stereo'));
  SetLabelStyle(lb07Dolby, WIDBCDS.Fields[1+10].AsString.Contains('DD'));
  lb04HD.Caption := 'SD';
  if WIDBCDS.Fields[1+11].AsString > '' then
    lb04HD.Caption := WIDBCDS.Fields[1+11].AsString.Split(['["HD ','"'])[1] ; //,[TStringSplitOptions.ExcludeEmpty]);
  SetLabelStyle(lb04HD, lb04HD.Caption <> 'SD');
  lb12Description.Caption := WIDBCDS.Fields[1+4].AsString;
end;

procedure TCWRmainFrm.WebStringGrid2DblClick(Sender: TObject);
// Hide WSG2 to go back to EPG list
begin
  WebStringGrid2.Hide;
  WebGridPanel2.Show;
end;

procedure TCWRmainFrm.WIDBCDSIDBError(DataSet: TDataSet;
  opCode: TIndexedDbOpCode; errorName, errorMsg: string);
begin
  ShowMessage(DataSet.Name + ' error: ' + errorName + ', msg: ' + errorMsg);
end;

procedure TCWRmainFrm.FetchCapReservations;  // Fetch CW_EPG-saved file

var
  i: Integer;
  id: string;
  sl: TStrings;
begin
  Log(' ====== FetchCapReservations called =========');
  // Turn off GetCellData (modifies Cols 1, 2 for display)
  AllCapsGrid.OnGetCellData := nil;
  await(RefreshCSV(AllCapsGrid, 'cwr_captures.csv', 'Scheduled', id));
  // Save unmodified capture data to Local Storage
  sl := TStringList.Create;
  AllCapsGrid.SaveToStrings(sl, ',', True);
  for i := 0 to sl.Count - 1 do
    TWebLocalStorage.SetValue('sl'+i.ToString, sl[i]);
  TWebLocalStorage.RemoveKey('sl'+sl.Count.ToString);  // dump old value
  sl.Free;
  // Turn GetCellData formatting back on
  AllCapsGrid.OnGetCellData := AllCapsGridGetCellData;
  Log(' ====== FetchCapReservations finished =========');
end;

procedure TCWRmainFrm.FetchHistory;

var
  i: Integer;
  id: string;
  sl: TStrings;
begin
  Log(' ====== FetchHistory called =========');
  HistoryTable.BeginUpdate;
  HistoryTable.Visible := False;
  HistoryTable.ColCount := 32;
  await(RefreshCSV(HistoryTable, 'cwr_history.csv','History', id));
//  Log('History Rows: '+HistoryTable.RowCount.ToString);
  for i := HistoryTable.RowCount-1 downto 1 do // Remove blanks, add leading zeroes
  begin
    if HistoryTable.Cells[0,i] = '' then HistoryTable.RemoveRow(i)
    else HistoryTable.Cells[0,i] := RightStr('000000' + HistoryTable.Cells[0,i],6);
  end;
  // Sort Table by ID (field 0)
  HistoryTable.Sort(0,siAscending);
  Log('History Rows: '+HistoryTable.RowCount.ToString);
  // Save history data to Local Storage
  sl := TStringList.Create;
  HistoryTable.SaveToStrings(sl, ',', True);
  HistoryTable.RowCount := 1;  // Free memory??
  Log('sl Count: '+sl.Count.ToString);
  // Save Headings in Fixed Row
  TWebLocalStorage.SetValue('hl0', sl[0]);
  // Save Num History Events in reverse order
  for i := 1 to sl.Count-1 do
    TWebLocalStorage.SetValue('hl' + i.ToString, sl[sl.Count - i]);
  sl.Free;
  await(FillHistoryDisplay);
  HistoryTable.EndUpdate;
  Log(' ====== FetchHistory finished =========');
end;

procedure TCWRmainFrm.UpdateNewCaptures(RecordStart, RecordEnd: TDateTime);

const
  HEADINGS: array [0..6] of string = ('PSIP','RecordStart','RecordEnd','Title','SubTitle','StartTime','ProgramID');
var
  i: Integer;
  id, res: string;
  data: Tstrings;
begin
  Log(' ====== UpdateNewCaptures called =========');
  await(RefreshCSV(NewCapturesTable, 'cwr_newcaptures.csv','NewCaptures', id));
  Log('NewCaptures Rows: '+NewCapturesTable.RowCount.ToString);
  if NewCapturesTable.RowCount = 0 then // fnf, create new one
  begin
    NewCapturesTable.RowCount := 1;
    NewCapturesTable.ColCount := 7;
    for i := 0 to NewCapturesTable.ColCount-1 do
      NewCapturesTable.Cells[i,0] := HEADINGS[i];
    await(CreateGoogleFile('cwr_newcaptures.csv', id));
  end
  else
    for i := NewCapturesTable.RowCount-1 downto 1 do // Remove blank rows
      if NewCapturesTable.Cells[0,i] = '' then NewCapturesTable.RemoveRow(i);
// Add the new capture to the list
  NewCapturesTable.RowCount := NewCapturesTable.RowCount + 1;
  NewCapturesTable.Cells[0,NewCapturesTable.RowCount-1] := lb10Channel.Caption; // PSIP
  NewCapturesTable.Cells[1,NewCapturesTable.RowCount-1] := DateTimeToStr(RecordStart);
  NewCapturesTable.Cells[2,NewCapturesTable.RowCount-1] := DateTimeToStr(RecordEnd);
  NewCapturesTable.Cells[3,NewCapturesTable.RowCount-1] := lb01Title.Caption; // Title
  NewCapturesTable.Cells[4,NewCapturesTable.RowCount-1] := lb06SubTitle.Caption; // Subtitle
  NewCapturesTable.Cells[5,NewCapturesTable.RowCount-1] := WIDBCDS.FieldByName('StartTime').AsString;  // EPG StartTime
  NewCapturesTable.Cells[6,NewCapturesTable.RowCount-1] := WIDBCDS.FieldByName('ProgramID').AsString; // Episode No.
  // for debugging:
//  NewCapturesTable.Visible := True;
//  NewCapturesTable.BringToFront;
//  asm await sleep(20000) end;
//  NewCapturesTable.Visible := False;
  // Update the file
  data := TStringList.Create;
  data.LineBreak := #13;
  NewCapturesTable.SaveToStrings(data, ',', True);
  console.log('id: '+id);
//  console.log('data: ', data);
  console.log('data.text: ', data.Text);
  res := await(string, WEBRESTClient1.HttpRequest('PATCH','https://www.googleapis.com/upload/drive/v3/files/'+id, data.Text));
  console.log(res);

  // ==============================
  Log('Final NewCapturesTable Rows: '+NewCapturesTable.RowCount.ToString);
  Log(' ====== UpdateNewCaptures finished =========');
end;

//procedure TCWRmainFrm.btnSaveClick(Sender: TObject);
//var
//  data: string;
//  res: TJSXMLHttpRequest;
//begin
////  WEBRestClient1.OnRequestResponse := HandleSaveFile;
//
//  data := WebMemo1.Lines.Text;
//
////  WEBRestClient1.HttpsCommand('PATCH','https://www.googleapis.com/upload/drive/v3/files/'+id, data,'',nil);
//
//  res := await(TJSXMLHttpRequest, WEBRESTClient1.HttpRequest('PATCH','https://www.googleapis.com/upload/drive/v3/files/'+id, data));
//  console.log(res);
//end;

procedure TCWRmainFrm.CreateGoogleFile(FName: string; var id: string);
var
//  id: string;
  rq: TJSXMLHttpRequest;
  jso: TJSONObject;
begin

  rq := TAwait.ExecP<TJSXMLHttpRequest> {await(TJSXMLHttpRequest,} (WEBRestClient1.HttpRequest('POST','https://www.googleapis.com/upload/drive/v3/files'));

  console.log(rq);

  jso := TJSONObject(TJSONObject.ParseJSONValue(rq.responseText));

  if Assigned(jso) then
  begin
    id := string(jso.GetJSONValue('id'));
    console.log('file ID'+id);

    rq := TAwait.ExecP<TJSXMLHttpRequest>{await(TJSXMLHttpRequest,} (WEBRestClient1.HttpRequest('PATCH','https://www.googleapis.com/drive/v3/files/'+id,
      '{"name":"'+ FName + '", "description":"New Captures CSV list"}'));

//    WebListBox1.Items.AddPair(fname, id);
//    WebListBox1.ItemIndex := WebListBox1.Items.Count - 1;
  end;

//  WebMemo1.Lines.Clear;
end;

end.