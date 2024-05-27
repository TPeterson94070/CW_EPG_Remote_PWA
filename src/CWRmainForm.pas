unit CWRmainForm;
                       { TODO : Add search function to Listings (and History?) }
                       { TODO : Add item deletion to Scheduled list }
                       { TODO : Add one-off scheduling of Listing item }
interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Dialogs, WebLib.DB, WEBLib.IndexedDb, Vcl.Menus,
  WEBLib.Menus, WEBLib.ComCtrls, Vcl.Controls, WEBLib.Grids, WEBLib.ExtCtrls, DB,
  Vcl.Grids, System.StrUtils, Vcl.StdCtrls, WEBLib.StdCtrls, WEBLib.DBCtrls,
  WEBLib.FlexControls, WEBLib.WebCtrls, WEBLib.REST, {System.Types,} Types,
  WEBLib.Storage, WEBLib.CDS, WEBLib.Auth, WEBLib.JSON, WEBLib.WebTools;

type
  TGridDrawState = set of (gdSelected, gdFocused, gdFixed, gdRowSelected, gdHotTrack, gdPressed);
  TCWRmainFrm = class(TWebForm)
  WebStringGrid1: TWebStringGrid;
  WIDBCDS: TWebIndexedDbClientDataset;
  WebButton1: TWebButton;
  WebMemo1: TWebMemo;
  seNumDisplayDays: TWebSpinEdit;
  WebGroupBox1: TWebGroupBox;
//  WebHttpRequest1: TWebHttpRequest;
  WebGridPanel2: TWebGridPanel;
  WebGridPanel3: TWebGridPanel;
  lb01Title: TWebLabel;
  lb02New: TWebLabel;
  lb03Stereo: TWebLabel;
  lb04HD: TWebLabel;
  WebGridPanel4: TWebGridPanel;
  lb06SubTitle: TWebLabel;
  lb12Description: TWebLabel;
//  seHttpTimeoutSec: TWebSpinEdit;
  WebGridPanel1: TWebGridPanel;
  WebGridPanel7: TWebGridPanel;
  lb07Dolby: TWebLabel;
  lb08CC: TWebLabel;
  lb09OrigDate: TWebLabel;
  WebGridPanel6: TWebGridPanel;
  lb10Channel: TWebLabel;
  lb11Time: TWebLabel;
  WebMemo2: TWebMemo;
  WebLocalStorage1: TWebLocalStorage;
  WebProgressBar1: TWebProgressBar;
  WebRadioGroup1: TWebRadioGroup;
  AlertLabel: TWebButton;
  WebStringGrid2: TWebStringGrid;
  AllCapsGrid: TWebStringGrid;
    HistoryTable: TWebStringGrid;
    Listings: TWebStringGrid;
    pnlListings: TWebPanel;
    pnlCaptures: TWebPanel;
    pnlHistory: TWebPanel;
    pnlLog: TWebPanel;
    pnlOptions: TWebPanel;
    WebMessageDlg1: TWebMessageDlg;
    WebGroupBox3: TWebGroupBox;
    seNumHistEvents: TWebSpinEdit;
    WebPanel1: TWebPanel;
    WebButton2: TWebButton;
    WebDBGrid1: TWebDBGrid;
    WebRESTClient1: TWebRESTClient;

  procedure LoadWIDBCDS;
  procedure WIDBCDSIDBError(DataSet: TDataSet; opCode: TIndexedDbOpCode;
    errorName, errorMsg: string);
  procedure WIDBCDSAfterOpen(DataSet: TDataSet);
  [async]
  procedure WebButton1Click(Sender: TObject);
  procedure WebFormCreate(Sender: TObject);
  procedure seNumDisplayDaysChange(Sender: TObject);
//  procedure seHttpTimeoutSecChange(Sender: TObject);
//  procedure WebHttpRequest1Abort(Sender: TObject);
//  procedure WebHttpRequest1Error(Sender: TObject;
//    ARequest: TJSXMLHttpRequestRecord; Event: TJSEventRecord;
//    var Handled: Boolean);
//  procedure WebHttpRequest1Timeout(Sender: TObject);
  [async]
  procedure WebRadioGroup1Change(Sender: TObject);
  procedure WebStringGrid2DblClick(Sender: TObject);
  [async]
  procedure tbCapturesShow;
    procedure AllCapsGridGetCellData(Sender: TObject; ACol, ARow: Integer;
      AField: TField; var AValue: string);
    procedure ListingsDblClick(Sender: TObject);
    procedure ListingsClickCell(Sender: TObject; ACol, ARow: Integer);
    procedure ListingsSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure seNumHistEventsChange(Sender: TObject);
    procedure HistoryTableFixedCellClick(Sender: TObject; ACol, ARow: Integer);
    [async]
    procedure AllCapsGridDblClick(Sender: TObject);
    procedure AllCapsGridClickCell(Sender: TObject; ACol, ARow: Integer);
    [async]
    procedure WebButton2Click(Sender: TObject);
//    procedure WebClientDataSet1AfterOpen(DataSet: TDataSet);
//    procedure WebAuth1GoogleSignIn(Sender: TObject; UserData: TGoogleUserData);
//    procedure WebButton3Click(Sender: TObject);
//    procedure WebButton4Click(Sender: TObject);
//    [async]
//    procedure WebButton5Click(Sender: TObject);
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
  procedure RefreshCSV(WSG: TWebStringGrid; TableFile, Title: string);
  [async]
  procedure FetchHistory;
  [async]
  procedure ReFreshListings;
  [async]
  procedure tbHistoryShow;
  [async]
  procedure FillHistoryDisplay;
  [async]
  function HttpReq(Cmd: string): {TJSXMLHttpRequest}string;
  [async]
  procedure RefreshHistory;
  procedure RemoteCaps(const rstr, URL: string);
  [async]
  function GetGoogleDriveFile(TableFile: string): string;
public
  { Public declarations }
end;

var
  CWRmainFrm: TCWRmainFrm;

implementation

uses
  System.Math;

{$R *.dfm}

var
  EPGChanged: Boolean;
  ClickedCol,  ClickedRow: Integer;
  CWHelperIP: String;

const
  DBFIELDS: array[0..13] of string = ('PSIP', 'Time', 'Title', 'SubTitle', 'Description',
  	'StartTime', 'EndTime', 'programID', 'originalAirDate', 'new',
    'audioProperties', 'videoProperties', 'movieYear', 'genres');
  NUMDAYS = 'NumDisplayDays';
  NUMHIST = 'NumHistoryItems';
  HTTPTIMEOUT = 'HttpTimeOut';

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
  IsInstalled: boolean;
  IPAddr: TArray<string>;
begin
  Log('FormCreate is called');
{$IFDEF PAS2JS}
  asm
    console.log('Starting ' + ProjectName);
// Define sleep function used to allow screen updates
    window.sleep = async function(msecs) {return new Promise((resolve) => setTimeout(resolve, msecs)); }
// Retrieve JS version info in Delphi variable
    AppVersion = ProjectName;
// Discover if installed ("standalone")
//   IsInstalled = (window.matchMedia('(display-mode: standalone)').matches) ||
//                 ('standalone' in window.navigator);
  end;
{$ENDIF}
//  showmessage(IsInstalled.ToString);
//  if not IsInstalled then
  // Log Version Information
  Log('Running version:  ' + AppVersion);
  Log('App is ' + IfThen(not Application.IsOnline, 'NOT ') + 'online');
  if TWebLocalStorage.GetValue(NUMDAYS) <> '' then
    seNumDisplayDays.Value := StrToInt(TWebLocalStorage.GetValue(NUMDAYS));
  if TWebLocalStorage.GetValue(NUMHIST) <> '' then
    seNumHistEvents.Value := StrToInt(TWebLocalStorage.GetValue(NUMHIST));
//  if TWebLocalStorage.GetValue(HTTPTIMEOUT) <> '' then
//    seHttpTimeoutSec.Value := StrToInt(TWebLocalStorage.GetValue(HTTPTIMEOUT));
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
  await (ReFreshListings);
  Log('WebFormShow, Listings refresh done');
  if Listings.RowCount > 2 then begin
    Listings.SetFocus;
    Listings.SelectCell(0,1);
  end;
end;

//procedure TCWRmainFrm.WebHttpRequest1Abort(Sender: TObject);
//begin
//  WebRadioGroup1.Enabled := True;
//  ShowMessage('Request aborted');
//  Log('Http request aborted, no reason supplied');
//end;
//
//procedure TCWRmainFrm.WebHttpRequest1Error(Sender: TObject;
//  ARequest: TJSXMLHttpRequestRecord; Event: TJSEventRecord;
//  var Handled: Boolean);
//begin
//  WebRadioGroup1.Enabled := True;
//  ShowMessage('Request ERROR:  ' + ARequest.req.ToString
//    + #13#13'Make sure that the Master HTPC is awake');
//  log('HttpRequest ERROR: ' + ARequest.req.toString);
//end;
//
//procedure TCWRmainFrm.WebHttpRequest1Timeout(Sender: TObject);
//begin
//  WebRadioGroup1.Enabled := True;
//  ShowMessage('Request timed out'#13#13'Cannot refresh EPG data while CWHelper is offline');
//  log('HttpRequest timed out. Presume CWHelper offline');
//end;

//procedure TCWRmainFrm.WebAuth1GoogleSignIn(Sender: TObject;
//  UserData: TGoogleUserData);
//begin
//ShowMessage('WAGSI UserData: '+UserData.ToString);
//end;

procedure TCWRmainFrm.WebButton1Click(Sender: TObject);
begin
  Log('======== "Refresh EPG" clicked');
  WebRadioGroup1.Enabled := False;
  asm await sleep(100) end;
  await (RefreshCSV(WebStringGrid1, 'cwr_epg.csv','EPG'));
  await (LoadWIDBCDS);
  Log('Finished (re)loading WIDBCDS');
//  EPGChanged := True;
  await (FetchCapReservations);
//  await (FetchHistory);
  await (RefreshListings);
  WebRadioGroup1.Enabled := True;
end;

procedure TCWRmainFrm.WebButton2Click(Sender: TObject);
begin
  await (RefreshHistory);
end;

//procedure TCWRmainFrm.WebButton3Click(Sender: TObject);
//begin
//asm
//      /**
//       *  Sign in the user upon button click.
//       */
//      // function handleAuthClick()
//      {
//        tokenClient.callback = async (resp) => {
//          if (resp.error !== undefined) {
//            throw (resp);
//          }
//          document.getElementById('signout_button').style.visibility = 'visible';
//          document.getElementById('authorize_button').innerText = 'Refresh';
//          await listFiles();
//        };
//
//        if (gapi.client.getToken() === null) {
//          // Prompt the user to select a Google Account and ask for consent to share their data
//          // when establishing a new session.
//          tokenClient.requestAccessToken({prompt: 'consent'});
//        } else {
//          // Skip display of account chooser and consent dialog for an existing session.
//          tokenClient.requestAccessToken({prompt: ''});
//        }
//      }
//end;
//end;

//procedure TCWRmainFrm.WebButton4Click(Sender: TObject);
//begin
//asm
//      /**
//       *  Sign out the user upon button click.
//       */
//      // function handleSignoutClick()
//      {
//        const token = gapi.client.getToken();
//        if (token !== null) {
//          google.accounts.oauth2.revoke(token.access_token);
//          gapi.client.setToken('');
//          document.getElementById('content').innerText = '';
//          document.getElementById('authorize_button').innerText = 'Authorize';
//          document.getElementById('signout_button').style.visibility = 'hidden';
//        }
//      }
//
//end;
//end;

//procedure TCWRmainFrm.WebButton5Click(Sender: TObject);
//begin
//asm
//      /**
//       * Print metadata for first 25 files.
//       */
//      //async function listFiles()
//      {
//        let response;
//        try {
//          response = await gapi.client.drive.files.list({
//            'pageSize': 25,
//            'fields': 'files(id, name)',
//          });
//        } catch (err) {
//          console.log(err.message);
//          return;
//        }
//        const files = response.result.files;
//        if (!files || files.length == 0) {
//          console.log('No files found')
//          return;
//        }
//        // Flatten to string to display
//        const output = files.reduce(
//            (str, file) => `${str}${file.name} (${file.id})\n`,
//            'Files:\n');
//        console.log(output);
//      }
//end;
//end;

procedure TCWRmainFrm.RefreshHistory;
begin
  WebRadioGroup1.Enabled := False;
  asm await sleep(100) end;
  await (FetchHistory);
  SetPage(2);
  asm await sleep(100) end;
  WebRadioGroup1.Enabled := True;
end;

//function TCWRmainFrm.HttpReq(Cmd: string): string;
//var
//  req: TJSXMLHttpRequest;
//begin
//  Log('Sending command: ' + Cmd);
//  WebHttpRequest1.URL := Cmd;
//  WebHttpRequest1.Timeout := seHttpTimeoutSec.Value * 1000;
//  try
//    req := await(TJSXMLHttpRequest, WebHttpRequest1.Perform);
//    Log('Status: ' + req.Status.ToString);
//    Result := IfThen(req.Status=200, req.responseText);
////    Log('Result: ' + Result);
//  except
//    on E:Exception do
//    begin
//      Log('HttpRequest Exception: ' + E.Message);
//      ShowMessage('Cannot send request while CWHelper is offline');
//    end;
//  end;
//end;

function TCWRmainFrm.GetGoogleDriveFile(TableFile: string): string;
var
  q,id,AResponse: string;
  rq: TJSXMLHttpRequest;
  jso: TJSONObject;
  ja: TJSONArray;
  i: integer;

begin
  Result := '';
  if WebRESTClient1.AccessToken = '' then
    Exit;

  q :='name contains ''' + TableFile + '''';

  rq := await(TJSXMLHttpRequest, WEBRESTClient1.HttpRequest('GET','https://www.googleapis.com/drive/v3/files?q='+WEBRestClient1.URLEncode(q)));

  if Assigned(rq) then
  begin
    AResponse := rq.responseText;
    console.log(rq.responseText);

    jso := TJSONObject(TJSONObject.ParseJSONValue(AResponse));

    if Assigned(jso) then
    begin
      ja := TJSONArray(jso.GetValue('files'));
      for i := 0 to ja.Count - 1 do
      begin
        jso := TJSONObject(ja.Items[i]);
        if jso.GetJSONValue('name') = TableFile then
          id := string(jso.GetJSONValue('id'));
//        console.log('add id',jso.GetValue('id'), s);
//        WebListbox1.Items.AddPair(jso.GetJSONValue('name'),jso.GetJSONValue('id'));
      end;
      jso.Free;
      console.log(id);
      rq := await(TJSXMLHttpRequest, WebRESTClient1.httprequest('GET','https://www.googleapis.com/drive/v3/files/'+id+'?alt=media').catch(
        function(AValue: JSValue): JSValue
        begin
          console.log('error here',AValue);
        end));

      if Assigned(rq) then Result := rq.responseText;
    end;
  end;
end;

procedure TCWRmainFrm.RefreshCSV(WSG: TWebStringGrid; TableFile, Title: string);
var
  Reply: string;
  sl: TStrings;
begin
  Log('ReFreshCSV called for ' + TableFile);
  if application.IsOnline then
  begin
    AlertLabel.Caption := 'Refreshing '+Title+' data <i class="fa-solid fa-spinner fa-spin"></>';
    AlertLabel.Show;
    AlertLabel.BringToFront;
    asm await sleep(50) end;

    WSG.BeginUpdate;
    try
      Log('Requesting: ' + TableFile);
      try
        Reply := await(string, GetGoogleDriveFile(TableFile));

        if Reply <> '' then  // Got a response
        begin
          sl := TStringList.Create;
          Log('Begin extract strings');
          Log(ExtractStrings([],[],Reply, sl).ToString
            + ' strings extracted, begin ' + WSG.Name + '.LoadFromStrings');
          WSG.LoadFromStrings(sl, ',', True);
          Log(WSG.Name+'.RowCount: ' + WSG.RowCount.ToString);
          Log('Done loading '+WSG.Name);
          sl.Free; // := nil;
        end;
      except
        on E:Exception do
        begin
          Log('HttpRequest Exception: ' + E.Message);
          ShowMessage('Cannot refresh EPG data while CWHelper is offline');
        end;
      end;
    finally
      Log('Enter finally section');
      WSG.EndUpdate;
      Log('"Finishing" AlertLabel');
      AlertLabel.Caption := 'Finishing up '+Title+' data <i class="fa-solid fa-spinner fa-spin"></>';
      asm await sleep(100) end;
      AlertLabel.Hide;
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
    WebRadioGroup1.Enabled := False;
    WebPanel1.BringToFront;
    asm await sleep(100) end;
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
        if await (TModalResult, MessageDlgAsync('There are no current listings.'
          + #13#13'Do you want to refresh them?',mtConfirmation, [mbYes,mbNo]))
          = mrYes then
        begin
          SetPage(4);
          WebButton1Click(Self);
        end;
        exit;
      end;
      asm await sleep(100) end;
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
          asm await sleep(2) end;
        end;
      end;
      Listings.Cells[0,0] := 'Channel';
    finally
      Listings.EndUpdate;
      SetPage(0);
    end;
  end else begin
    SetPage(4);
    asm await sleep(10) end;
    ShowMessage('Please click "Refresh EPG" button');
  end;
  WebRadioGroup1.Enabled := True;
  asm await sleep(10) end;
  EPGChanged := False;
  DBIncRecs := nil;
end;

//procedure TCWRmainFrm.seHttpTimeoutSecChange(Sender: TObject);
//begin
//  Log('Http Timeout set to: ' + seHttpTimeoutSec.Value.ToString);
//  TWebLocalStorage.SetValue(HTTPTIMEOUT,seHttpTimeoutSec.Value.ToString);
//end;

procedure TCWRmainFrm.seNumDisplayDaysChange(Sender: TObject);
begin
  Log('Number EPG Display Days: ' + seNumDisplayDays.Value.ToString);
  TWebLocalStorage.SetValue(NUMDAYS,seNumDisplayDays.Value.ToString);
  EPGChanged := True;
end;

procedure TCWRmainFrm.seNumHistEventsChange(Sender: TObject);
begin
  Log('Number History Items: ' + seNumHistEvents.Value.ToString);
  TWebLocalStorage.SetValue(NUMHIST,seNumHistEvents.Value.ToString);
//  HistoryChanged := True;
end;

procedure TCWRmainFrm.tbCapturesShow;
var
  sl: TStrings;
  i: Integer;

begin
//  Log('AllCapsGrid.RowCount: ' + AllCapsGrid.RowCount.ToString);
  if TWebLocalStorage.GetValue('sl1') > '' then  // but have stored value(s)
  begin
    sl := TStringList.Create;
    i := 0;
    while ReplaceStr(ReplaceStr(TWebLocalStorage.GetValue('sl'+i.ToString),'""',''),',','') > '' do
    begin
      sl.Add(TWebLocalStorage.GetValue('sl'+i.ToString));
      Inc(i);
    end;
    AllCapsGrid.LoadFromStrings(sl, ',', True);
    sl.Free;
  end;
  for i := 0 to AllCapsGrid.ColCount-1 do AllCapsGrid.ColWidths[i] := 0;
  AllCapsGrid.ColWidths[1] := 80; //(08*AllCapsGrid.ClientWidth) div 100;  // Computer
  AllCapsGrid.ColWidths[2] := 100; // (05*AllCapsGrid.ClientWidth) div 100; // Tuner
  AllCapsGrid.ColWidths[3] := 65; //(08*AllCapsGrid.ClientWidth) div 100;  // Date
  AllCapsGrid.ColWidths[4] := 45; // (05*AllCapsGrid.ClientWidth) div 100; // Start
  AllCapsGrid.ColWidths[5] := 45; // (05*AllCapsGrid.ClientWidth) div 100; // End
  AllCapsGrid.ColWidths[6] := 60; // (07*AllCapsGrid.ClientWidth) div 100; // Channel
  AllCapsGrid.ColWidths[8] :=  {(35*}AllCapsGrid.ClientWidth{) div 100}; // Title
  for i := 1 to 6 do AllCapsGrid.ColAlignments[i] := taCenter;
//  Log('AllCapsGrid.RowCount: ' + AllCapsGrid.RowCount.ToString);
  if AllCapsGrid.RowCount < 2 then  // No captures, reload??
  begin
//    ShowMessage('AllCapsGrid.RowCount: ' + AllCapsGrid.RowCount.ToString);
    Log('No captures listed, prompting for EPG fetch');
    if await (TModalResult, MessageDlgAsync('There are no scheduled items listed.'
      + #13#13'Do you want to refresh the list?',mtConfirmation, [mbYes,mbNo]))
      = mrYes then
    begin
      SetPage(4);
      WebButton1Click(Self);
    end;
  end;
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
  if HistoryTable.RowCount <> seNumHistEvents.Value + 1 then FillHistoryDisplay;
  if {HistoryChanged or}  (HistoryTable.RowCount <> seNumHistEvents.Value + 1) then  // may need History data
  begin
    Log('The History list is empty/incomplete. Prompt for refresh');
    if await (TModalResult, MessageDlgAsync('The History list '
     + IfThen(HistoryTable.RowCount < 2,'is empty','may be incomplete')
      + #13#13'Do you want to refresh it now?',mtConfirmation, [mbYes,mbNo]))
      = mrYes then await (RefreshHistory);
  end;
//  {await (}FillHistoryDisplay{)};
//  asm await sleep(10) end;
  HistoryTable.Visible := True;
end;

procedure TCWRmainFrm.SetPage(PageNum: Integer);
begin
  if PageNum <> WebRadioGroup1.ItemIndex then begin
    Log('Leaving Page: ' + WebRadioGroup1.Items[WebRadioGroup1.ItemIndex]);
  end;
  WebRadioGroup1.ItemIndex := PageNum;
  await (WebRadioGroup1Change(Application));
end;

procedure TCWRmainFrm.WebRadioGroup1Change(Sender: TObject);
begin
  Log('Showing Page: ' + WebRadioGroup1.Items[WebRadioGroup1.ItemIndex]);
  WebRadioGroup1.Enabled := False;
  asm await sleep(100) end;
  case WebRadioGroup1.ItemIndex of
    0: begin          {Listings page}
      pnlListings.BringToFront;
      Log('Sender: ' + Sender.ToString);
      if EPGChanged and (Sender = Application) then await(RefreshListings);
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
  WebRadioGroup1.Enabled := True;
  asm await sleep(100) end;
end;

procedure SetLabelStyle(lbl: TWebLabel; State: Boolean);
//  Show detail items in red (on) or lt. gray (off)
begin
  lbl.Font.Color := IfThen(State, clRed, clLtGray);
end;

procedure TCWRmainFrm.AllCapsGridClickCell(Sender: TObject; ACol,
  ARow: Integer);
begin
  ClickedCol := ACol;
  ClickedRow := ARow;
  Log('Clicked Col, Row: ' + ACol.ToString + ', ' + ARow.ToString);
end;

procedure TCWRmainFrm.AllCapsGridDblClick(Sender: TObject);
var
  i: Integer;
  URL, Response: string;
begin
  i := ClickedRow;

  if AllCapsGrid.cells[1,i] = '' then exit;

//  AllCapsGrid.OnGetCellData := nil;
  if await (TModalResult, MessageDlgAsync('Erase "' + AllCapsGrid.cells[8,i] + '" ' + AllCapsGrid.cells[3,i] + ' ' + AllCapsGrid.cells[4,i] + ' - ' + AllCapsGrid.cells[5,i] + ' '
    + ' Schedule Entry?', mtConfirmation, [mbYes, mbNo])) = mrNo then exit;
//    Start the delete here...............                                           // Delete schedule Entry
  Log('  >>>>>  ' + AllCapsGrid.cells[1,i] + ' - ' + AllCapsGrid.cells[2,i]
    + '  Delete : (' + AllCapsGrid.cells[0,i]
    + ') ' + AllCapsGrid.cells[8,i] + ' - ' + AllCapsGrid.cells[3,i] + ' '
    + AllCapsGrid.cells[4,i] + '-' + AllCapsGrid.cells[5,i]);
  URL := 'https://' + CWHelperIP + ':8443/decapture?sequence=' + AllCapsGrid.cells[0,i];
  Response := await(HttpReq(URL));
  // Assume success, delete AllCapsGrid row i
//  showmessage('Response: ' + Response);
  if Response<>'' then AllCapsGrid.RemoveRow(i);
//  AllCapsGrid.OnGetCellData := AllCapsGridGetCellData;
end;

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
  Text := {WSG.Cells[7,ARow]}WIDBCDS.Fields[8].AsString; // i.e. ProgramID
  if Text.Contains('MV') then  // Movie item
    AColor := '#EEE8AA'        // PaleGoldenRod
  else if Text.Contains('SH') then  // Generic item
    AColor := '#D3D3D3'        // LightGray
  else begin
    if {WSG.Cells[9,ARow]}WIDBCDS.Fields[10].AsString <> '' then  // New item
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
begin
  ClickedCol := ACol;
  ClickedRow := ARow;
  Log('Clicked Col, Row: ' + ACol.ToString + ', ' + ARow.ToString);
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

//procedure TCWRmainFrm.WebStringGrid1FixedCellClick(Sender: TObject; ACol,
//  ARow: Integer);
// TBD:  Pop up genre-selection ComboBox
//var
//  i: Integer;
//  FilterBox: TWebComboBox;
//begin
//end;

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
  sl: TStrings;
begin
  Log(' ====== FetchCapReservations called =========');
  // Turn off GetCellData (modifies Cols 1, 2 for display)
  AllCapsGrid.OnGetCellData := nil;
  await (RefreshCSV(AllCapsGrid, 'cwr_captures.csv', 'Scheduled'));
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

//procedure TCWRmainFrm.FetchCapReservations;  // Fetch directly from CWHelper
//var
//  i: Integer;
//  URL, Response: string;
//  sl: TStrings;
//begin
//  Log(' ====== FetchCapReservations called =========');
//    URL := 'https://'+ CWHelperIP + ':8443/captures';
//  Log(' Calling "' + URL + '"');
//  try
//    try
//      Response := await(HttpReq(URL));
//      if Response > '' then RemoteCaps(Response, URL);
//    except
//      on E: Exception do
//          ShowMessage(' Fetching Captures -- Oops '#10 + E.Message);
//    end;
//  // Save unmodified capture data to Local Storage
////  sl := TStringList.Create;
////  RemoteCapsGrid.SaveToStrings(sl, ',', True);
////  for i := 0 to sl.Count - 1 do
////    TWebLocalStorage.SetValue('sl'+i.ToString, sl[i]);
////  TWebLocalStorage.RemoveKey('sl'+sl.Count.ToString);  // dump old value
////  sl.Free;
//  finally
//
//  end;
//  Log(' ====== FetchCapReservations finished =========');
//end;

function ParameterVal(const pname, Capture: string): string;
var
  ps: Integer;
begin
  ps := pos(pname + '="', Capture) + Length(pname) + 2;       // +2 for '="' after name
  Result := copy(Capture,ps,PosEx('"',Capture,ps)-ps);
end;

//===============================================================
  { Parses reply (rstr) from one server's CWHelper instruction and
    constructs current capture list (nulled for "decaptureall") }
procedure TCWRmainFrm.RemoteCaps(const rstr, URL: string);
//
var
  Captures: TArray<System.string>;
begin
  Log('  >>>>>>>> remotecaps called ......');
  Log('  ########## ' + URL + ' Output ###########');
  Log(rstr);
//  RemoteCapGrid.Height := 0;
  if rstr.Contains('<xml id="captures">') then               //  Read Remotes Scheduled Entries
  begin
    Captures := rstr.Split(['<capture ']);
//    RemoteCapGrid.BeginUpdate;
//    RemoteCapGrid.RowCount := Length(Captures) - 1;
//    for var i := 1 to Length(Captures) - 1 do
//    begin
//      remotecapgrid.cells[0,i-1] := ParameterVal('sequence', Captures[i]); //.ToInteger;
//      var x := ParameterVal('start', Captures[i]);
//      var Splt := {ParameterVal('start', Captures[i])}x.Split([' '], 2);
//      remotecapgrid.cells[1,i-1] := Splt[0];      // Date
//      remotecapgrid.cells[2,i-1] := Splt[1];      // StartTime
//      remotecapgrid.cells[3,i-1] :=               // EndTime
//        FormatDateTime('hh:nn:ss',StrToDateTime(ParameterVal('end', Captures[i])) + OneSecond);
//      var channelname := ParameterVal('channelName', Captures[i]);
//      remotecapgrid.cells[4,i-1] := channelname;
//      remotecapgrid.cells[15,i-1] := ParameterVal('alphaDescription', Captures[i]);
////      remotecapgrid.cells[5,i-1] := ParameterVal('input', Captures[i]);
//      remotecapgrid.cells[12,i-1] := ParameterVal('tuner', Captures[i]);
//      remotecapgrid.cells[9,i-1] := ParameterVal('deviceId', Captures[i]);
//      remotecapgrid.cells[14,i-1] := ParameterVal('tunerType', Captures[i]);
//      var channelvirtual := ParameterVal('channelVirtual', Captures[i]);
//      remotecapgrid.cells[16,i-1] := channelvirtual;
//      remotecapgrid.cells[12,i-1] := 'HR('
//        + remotecapgrid.cells[12,i-1] + ')';
//      var ts1 := copy(remotecapgrid.cells[12,i-1],
//        pos('-',remotecapgrid.cells[12,i-1])+1,1);
//      remotecapgrid.cells[5,i-1] := ts1;
//      remotecapgrid.cells[13,i-1] := ParameterVal('fileName', Captures[i]);
//      remotecapgrid.cells[8,i-1] := IfThen
//        (remotecapgrid.cells[13,i-1] = '(watch)', 'W', 'C');
//      remotecapgrid.cells[6,i-1] := ParameterVal('title', Captures[i]);
//      remotecapgrid.cells[11,i-1] := IfThen
//        (uppercase(ParameterVal('recurring', Captures[i])) = 'TRUE', 'R');
//      remotecapgrid.cells[10,i-1] := compname;  // Computername
    end;
//    SaveRemoteCapFile;
//    RemoteCapGrid.EndUpdate;
//    RemoteCapGrid.Height := 0;  //118;
//  end;
//  // Find Caps in Listings...need to wait for ShowGrid update!
//
  Log('  >>>>>>>> remotecaps finished ......');
end;

procedure TCWRmainFrm.FetchHistory;
var
  i: Integer;
  sl: TStrings;
begin
  Log(' ====== FetchHistory called =========');
  HistoryTable.BeginUpdate;
  HistoryTable.Visible := False;
  HistoryTable.ColCount := 32;
  await (RefreshCSV(HistoryTable, 'cwr_history.csv','History'));
//  Log('History Rows: '+HistoryTable.RowCount.ToString);
  for i := HistoryTable.RowCount-1 downto 1 do // Remove blanks, add leading zeroes
  begin
    if HistoryTable.Cells[0,i] = '' then HistoryTable.RemoveRow(i)
    else HistoryTable.Cells[0,i] := RightStr('000000' + HistoryTable.Cells[0,i],6);
  end;
  // Sort Table by ID (field 0)
  HistoryTable.Sort(0,siAscending);
  // Dump extra History data
//  for i := 0 to HistoryTable.RowCount-1 do TWebLocalStorage.RemoveKey('hl' + i.ToString);
//  for i := HistoryTable.RowCount-seNumHistEvents.Value-1 downto 1 do
//    HistoryTable.RemoveRow(i);
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
  await (FillHistoryDisplay);
  HistoryTable.EndUpdate;
//  HistoryChanged := False;
  Log(' ====== FetchHistory finished =========');
end;


end.