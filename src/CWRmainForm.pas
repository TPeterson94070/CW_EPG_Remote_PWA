unit CWRmainForm;
                       { TODO : Add search function to Listings (and History?) }
                       { TODO : Add item deletion to Scheduled list }
                       { DONE : Add one-off scheduling of Listing item }
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
  WIDBCDS: TWebIndexedDbClientDataset;
  WebMemo2: TWebMemo;
  AlertLabel: TWebButton;
  SearchResults: TWebStringGrid;
  Captures: TWebStringGrid;
  HistoryTable: TWebStringGrid;
  Listings: TWebStringGrid;
  pnlCaptures: TWebPanel;
  pnlHistory: TWebPanel;
  pnlLog: TWebPanel;
  pnlOptions: TWebPanel;
  WebPanel1: TWebPanel;
  WebRESTClient1: TWebRESTClient;
  pnlListings: TWebPanel;
  NewCaptures: TWebStringGrid;
  WebPanel3: TWebPanel;
  WebMainMenu1: TWebMainMenu;
  Listing: TMenuItem;
  Scheduled: TMenuItem;
  History: TMenuItem;
  Options: TMenuItem;
  RefreshEPG: TMenuItem;
  RefreshHistory1: TMenuItem;
  ChangeHTPC1: TMenuItem;
  ViewLog1: TMenuItem;
  Settings1: TMenuItem;
  WebPanel2: TWebPanel;
  WebGroupBox3: TWebGroupBox;
  seNumHistEvents: TWebSpinEdit;
  WebGroupBox1: TWebGroupBox;
  seNumDisplayDays: TWebSpinEdit;
    WebDBGrid1: TWebDBGrid;
    WebDataSource1: TWebDataSource;
    WebButton1: TWebButton;
    WebGridPanel1: TWebGridPanel;
    WebLabel1: TWebLabel;
    WebLabel2: TWebLabel;

  [async]
  procedure LoadWIDBCDS;
  procedure WIDBCDSIDBError(DataSet: TDataSet; opCode: TIndexedDbOpCode;
    errorName, errorMsg: string);
  procedure WIDBCDSAfterOpen(DataSet: TDataSet);
  [async]
  procedure UpdateEPG(Sender: TObject);
  [async]
  procedure WebFormCreate(Sender: TObject);
  procedure WebStringGrid2DblClick(Sender: TObject);
  [async]
  procedure tbCapturesShow;
  procedure AllCapsGridGetCellData(Sender: TObject; ACol, ARow: Integer;
    AField: TField; var AValue: string);
  procedure HistoryTableFixedCellClick(Sender: TObject; ACol, ARow: Integer);
  [async]
  procedure UpdateHistory(Sender: TObject);
  [async]
  procedure ChangeTargetHTPC(Sender: TObject);
  procedure ListingClick(Sender: TObject);
  procedure HistoryClick(Sender: TObject);
  procedure ScheduledClick(Sender: TObject);
  procedure ViewLog1Click(Sender: TObject);
  procedure Settings1Click(Sender: TObject);
  [async]
    procedure WebDBGrid1ClickCell(Sender: TObject; ACol, ARow: Integer);
    procedure WebDBGrid1GetCellClass(Sender: TObject; ACol, ARow: Integer;
      AField: TField; AValue: string; var AClassName: string);
private
  { Private declarations }
  [async]
  procedure WebFormShow;
//  procedure ColorGridRow(WSG: TWebStringGrid; ARow: Integer);
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
  [async]
  procedure CheckSettingsForUpdate;

public
  { Public declarations }
end;

var
  CWRmainFrm: TCWRmainFrm;

implementation

uses
  System.Math, DateUtils, SchedUnit2, Details;

{$R *.dfm}

var
//  ClickedCol,  ClickedRow: Integer;
  ResetPrompt: string = 'none' ; //'&prompt=select_account';

const
//  DBFIELDS: array[0..13] of string = ('PSIP', 'Time', 'Title', 'SubTitle', 'Description',
//  	'StartTime', 'EndTime', 'programID', 'originalAirDate', 'new',
//    'audioProperties', 'videoProperties', 'movieYear', 'genres');
  NUMDAYS = 'NumDisplayDays';
  NUMHIST = 'NumHistoryItems';
  EMAILADDR = 'emailAddress';

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
const
  DBFIELDS: array[0..14] of string = ('PSIP', 'Time', 'Title', 'SubTitle', 'Description',
  	'StartTime', 'EndTime', 'programID', 'originalAirDate', 'new',
    'audioProperties', 'videoProperties', 'movieYear', 'genres', 'Class');
var
  i: Integer;
  AppVersion: string;
begin
  Log('FormCreate is called');
//  WebMainMenu1.Height := 20;   // Works someday, I hope
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
//  if TWebLocalStorage.GetValue(EMAILADDR) <> '' then
    WebMainMenu1.Appearance.HamburgerMenu.Caption := '['+TWebLocalStorage.GetValue(EMAILADDR)+']';
//  WebButton1.Caption := 'Preparing EPG Display. Please wait... <i class="fa-solid fa-spinner fa-spin"></>';
  SetPage(0);
  {$IFDEF PAS2JS} asm await sleep(10) end; {$ENDIF}

  FillHistoryDisplay;
  WebDBGrid1.OnGetCellClass := nil;
  WIDBCDS.FieldDefs.Clear;
  // add key field
  WIDBCDS.FieldDefs.Add('id',ftInteger, 0, False);
  // add normal fields
  for i := 0 to Length(DBFIELDS) - 1 do
  begin
    if (DBFIELDS[i] = 'StartTime') or (DBFIELDS[i] = 'EndTime') then
      WIDBCDS.FieldDefs.Add(DBFIELDS[i],ftDateTime)
    else
      WIDBCDS.FieldDefs.Add(DBFIELDS[i],ftString);
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
  await(ReFreshListings);
end;

procedure TCWRmainFrm.UpdateEPG(Sender: TObject);
var
  id: string; {param used only by UpdateNewcaptures}
begin
  Log('======== "Update EPG" clicked');
  // Turn off WebDBGrid1 formatting...superfluous?
  WebDBGrid1.OnGetCellClass := nil;
  WebDBGrid1.BeginUpdate;
  await(RefreshCSV(Listings, 'cwr_epg.csv','EPG', id));
  await(LoadWIDBCDS);
  await(FetchCapReservations);
  WebDBGrid1.EndUpdate;
  await(RefreshListings);
end;

procedure TCWRmainFrm.UpdateHistory(Sender: TObject);
begin
  await(RefreshHistory);
end;

procedure TCWRmainFrm.ChangeTargetHTPC(Sender: TObject);
begin
  Log('Server reset requested');
  if TAwait.ExecP<TModalResult> (MessageDlgAsync('Current HTPC account: '
    + TWebLocalStorage.GetValue(EMAILADDR)
    + #13#13'Do you want to change it?',
    mtConfirmation, [mbYes,mbNo])) = mrYes then
  begin
    ResetPrompt := 'select_account';
    await (UpdateHistory(Self));
    await (UpdateEPG(Self));
  end;
end;

procedure TCWRmainFrm.RefreshHistory;
begin
  await(FetchHistory);
  SetPage(2);
  {$IFDEF PAS2JS} asm await sleep(10) end; {$ENDIF}
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
    rq := TAwait.ExecP<TJSXMLHttpRequest> (WebRESTClient1.httprequest('GET','https://www.googleapis.com/drive/v3/about/?fields=kind,user'));
    if rq.Status = 200 then
    begin
//      console.log('rq.responseText:', rq.responseText);
      jso := TJSONOBJect(TJSONObject.ParseJSONValue(rq.responseText));
      jso := TJSONObject(jso.GetValue('user'));
      TWebLocalStorage.SetValue(EMAILADDR, string(jso.GetJSONValue('emailAddress')));
//      console.log('jso:',jso);
      WebMainMenu1.Appearance.HamburgerMenu.Caption := '['+TWebLocalStorage.GetValue(EMAILADDR)+']';
    end;
    ResetPrompt := 'none';
    q :='name = ''' + TableFile + ''' and trashed = false';

    Result := TAwait.ExecP<TJSXMLHttpRequest> (WEBRESTClient1.HttpRequest('GET',
      'https://www.googleapis.com/drive/v3/files?q='+WEBRestClient1.URLEncode(q)));
  end;

begin
  Result := '';
  rq := TAwait.ExecP<TJSXMLHttpRequest> (TryLogIn);
  if Assigned(rq) then
  begin
    // Check for error
    if rq.Status <> 200 then // Set up a retry
    begin
// if rq.Status = 401 then Access token expired, but <>200 is enough for a retry
      console.log(rq.StatusText);
      WebRESTClient1.ClearTokens;
      console.log('Retrying login');
      rq := TAwait.ExecP<TJSXMLHttpRequest> (TryLogIn);
      if rq.Status <> 200 then exit('');
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
    WebPanel2.Show;
  {$IFDEF PAS2JS} asm await sleep(10) end; {$ENDIF}

    WSG.BeginUpdate;
    try
      Log('Requesting: ' + TableFile);
      try
        Reply := TAwait.ExecP<string>{await} (GetGoogleDriveFile(TableFile, id));

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
      WebPanel2.Hide;
  {$IFDEF PAS2JS} asm await sleep(10) end; {$ENDIF}
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
var
  i,j: Integer;
  t: TDateTime;
  AColor: string;
  Text: string;
begin
  Log('Starting LoadWIDBCDS, DB is ' + IfThen(not WIDBCDS.Active, 'not ') + 'Active');
  WIDBCDS.Filtered := False;
  WIDBCDS.DisableControls;
  WebDBGrid1.BeginUpdate;
  try
    if WIDBCDS.Active and (Listings.RowCount > 1) then
    begin
      Log('LoadWIDBCDS, DB is ' + IfThen(not WIDBCDS.IsEmpty, 'not ') + 'empty');
      Log('LoadWIDBCDS (before empty) DB.RecordCount: ' + WIDBCDS.RecordCount.ToString);
      // Empty the DB
      while not WIDBCDS.IsEmpty do
      begin
        WIDBCDS.Delete;
      end;
      Log('LoadWIDBCDS (after empty) DB.RecordCount: ' + WIDBCDS.RecordCount.ToString);
      Log('LoadWIDBCDS, Listings Row Count: ' + Listings.RowCount.ToString);
      for j := 1 to Listings.RowCount - 1 do
      begin
        // Lose superfluous <">
        Listings.Cells[0,j] := ReplaceStr(Listings.Cells[0,j],'"','');
        WIDBCDS.Append;
        WIDBCDS.Fields[0].Value := j;
        for i := 1 to Listings.ColCount do
          if WIDBCDS.Fields[i].DataType = ftString then
            WIDBCDS.Fields[i].Value := Listings.Cells[i-1,j]
          else  // Keep UTC StartTime/EndTime strings
            if TryStrToDateTime(Listings.Cells[i-1,j],t) then
              WIDBCDS.Fields[i].Value := t;
        Text := WIDBCDS.Fields[8].AsString; // i.e. ProgramID
        if Text.Contains('MV') then  // Movie item
          AColor := 'goldenRod'
        else if Text.Contains('SH') then  // Generic item
          AColor := 'gray'
        else begin
          if WIDBCDS.Fields[10].AsString <> '' then  // New item
            AColor := 'green'
          else                                // Rerun item
            AColor := 'rose';
        end;
        WIDBCDS.Fields[15].Value := AColor;
        WIDBCDS.Post;
      end;
    end;
  finally
    await(WIDBCDS.EnableControls);
//    WebDBGrid1.OnGetCellClass := WebDBGrid1GetCellClass;
    await(WebDBGrid1.EndUpdate);
//    await(WebDBGrid1.Refresh);
//    WebDBGrid1.OnGetCellClass := nil;
    Log('Finished LoadWIDBCDS, DB.RecordCount: ' + WIDBCDS.RecordCount.ToString);
  end;
end;

procedure TCWRmainFrm.CheckSettingsForUpdate;
begin
  if TWebLocalStorage.GetValue(NUMDAYS) <> seNumDisplayDays.Value.ToString then
  begin
    TWebLocalStorage.SetValue(NUMDAYS,seNumDisplayDays.Value.ToString);
    Log('New number EPG Display Days: ' + seNumDisplayDays.Value.ToString);
    await(ReFreshListings);
  end;

  if TWebLocalStorage.GetValue(NUMHIST) <> seNumHistEvents.Value.ToString then
  begin
    TWebLocalStorage.SetValue(NUMHIST,seNumHistEvents.Value.ToString);
    Log('New number History Items: ' + seNumHistEvents.Value.ToString);
    await(FillHistoryDisplay);
  end;

end;

procedure TCWRmainFrm.ReFreshListings;
var
  NRows: Integer;

begin
  Log('ReFreshListings, DB is ' + IfThen(not WIDBCDS.Active, 'not ')
    + 'Active and ' + IfThen(not WIDBCDS.IsEmpty, 'not ') + 'Empty');
  Log('Days to Display: ' + seNumDisplayDays.Value.ToString);
  WebDBGrid1.BeginUpdate;
  try
    if WIDBCDS.Active and not WIDBCDS.IsEmpty then
    begin
      WIDBCDS.DisableControls;
      WebPanel1.BringToFront;
      {$IFDEF PAS2JS} asm await sleep(10) end; {$ENDIF}
      Log('Memo1 is showing');
      WIDBCDS.Filtered := False;
      Log('WIDBCDS Filter is '+IfThen(WIDBCDS.Filtered,'enabled','disabled'));
      WIDBCDS.First;
      Log('StartTime of First (unfiltered) record ('+WIDBCDS.RecNo.ToString+'): '
        +DateTimeToStr(TTimeZone.Local.ToLocalTime(WIDBCDS.FieldByName('StartTime').AsDateTime)));
      Log('Unfiltered IDBCDS records: ' + WIDBCDS.RecordCount.ToString);
      WIDBCDS.Filter := '(StartTime > ' + FloatToStr(TTimeZone.Local.ToUniversalTime(Now))
        + ') and (StartTime < ' + FloatToStr(TTimeZone.Local.ToUniversalTime(Now) + seNumDisplayDays.Value)+')';
      Log('Filter: ' + WIDBCDS.Filter);
      try
        WIDBCDS.Filtered := True;
        Log('WIDBCDS Filter is '+IfThen(WIDBCDS.Filtered,'enabled','disabled'));
        Log('Filtered IDBCDS record count: '+WIDBCDS.RecordCount.ToString);
        WIDBCDS.First;
        NRows := WIDBCDS.RecNo;
        Log('StartTime of First (filtered) record ('+WIDBCDS.RecNo.ToString+'): '
        +DateTimeToStr(TTimeZone.Local.ToLocalTime(WIDBCDS.FieldByName('StartTime').AsDateTime)));
        WIDBCDS.Last;
        Log('StartTime of Last (filtered) record ('+WIDBCDS.RecNo.ToString+'): '
        +DateTimeToStr(TTimeZone.Local.ToLocalTime(WIDBCDS.FieldByName('StartTime').AsDateTime)));
        NRows := WIDBCDS.RecNo - NRows;
        Log('ReFreshListings, No. recs to display: ' + NRows.ToString);
      except
        on E:Exception do
        begin
          NRows := 0;
        end;
      end;
      if NRows < 2 then
      begin
        Log('No current DB items, prompting for EPG fetch');
        if TAwait.ExecP<TModalResult> (MessageDlgAsync('There are no current listings.'
          + #13#13'Do you want to refresh them?',mtConfirmation, [mbYes,mbNo]))
          = mrYes then await (UpdateEPG(Self));
        exit;
      end;
      Log('WIDBCDS Controls: '+IfThen(WIDBCDS.ControlsDisabled,'Disabled','Enabled'));
      await(WIDBCDS.EnableControls);
      Log('WIDBCDS Controls: '+IfThen(WIDBCDS.ControlsDisabled,'Disabled','Enabled'));
      WebDBGrid1.Columns[0].Alignment := taCenter;
      WebDBGrid1.Columns[2].Alignment := taLeftJustify;
    end else begin
      ShowMessage('Please select "Refresh EPG" from Options submenu');
    end;
  finally
    WebPanel1.SendToBack;
    WebDBGrid1.OnGetCellClass := WebDBGrid1GetCellClass;
    pnlListings.BringToFront;
    await(WebDBGrid1.EndUpdate);
    await(WebDBGrid1.Refresh);
    WebDBGrid1.OnGetCellClass := nil;
    Log('RefreshListings finished');
  end;
end;

procedure TCWRmainFrm.ScheduledClick(Sender: TObject);
begin
  SetPage(1);
end;

//procedure TCWRmainFrm.seNumDisplayDaysChange(Sender: TObject);
//begin
//  Log('Number EPG Display Days: ' + seNumDisplayDays.Value.ToString);
//  TWebLocalStorage.SetValue(NUMDAYS,seNumDisplayDays.Value.ToString);
//end;

//procedure TCWRmainFrm.seNumHistEventsChange(Sender: TObject);
//begin
//  Log('Number History Items: ' + seNumHistEvents.Value.ToString);
//  TWebLocalStorage.SetValue(NUMHIST,seNumHistEvents.Value.ToString);
//end;

procedure TCWRmainFrm.tbCapturesShow;
var
  sl: TStrings;
  i: Integer;
  st, et: TDateTime;

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
    Captures.LoadFromStrings(sl, ',', True);
    Log('Captures Row Count: ' + Captures.RowCount.ToString);
    sl.Free;
    // Discard stale entries (End DateTime < now)
    for i := Captures.RowCount-1 downto 1 do
      if Captures.Cells[3,i] > '' then // not null row
      begin
        st := StrToDateTime(Captures.Cells[3,i] + ' ' + Captures.Cells[4,i]);
        et := StrToDateTime(Captures.Cells[3,i] + ' ' + Captures.Cells[5,i]);
        if et < st then et := et + 1;     // wraps midnight
        if et < now then
        begin
          console.log('Stale entry date: ' + DateTimeToStr(et));
          Captures.RemoveRow(i);
        end;
      end;
  end;
  for i := 0 to Captures.ColCount-1 do Captures.ColWidths[i] := 0;
  Captures.ColWidths[1] := 80;  // Computer
  Captures.ColWidths[2] := 100; // Tuner
  Captures.ColWidths[3] := 65; // Date
  Captures.ColWidths[4] := 45; // Start
  Captures.ColWidths[5] := 45; // End
  Captures.ColWidths[6] := 70; // Channel
  Captures.ColWidths[8] := Captures.ClientWidth; // Title
  for i := 1 to 6 do Captures.ColAlignments[i] := taCenter;
  Log('AllCapsGrid.RowCount after stale check: ' + Captures.RowCount.ToString);
//  Log('AllCapsGrid.Cells[25,1]: <' + AllCapsGrid.Cells[25,1] + '>');
  if (Captures.RowCount = 2) and (Captures.Cells[25,1] = '-1') then  // Valid list, no captures, reload??
  begin
    Log('No captures listed, prompting for EPG fetch');
    if TAwait.ExecP<TModalResult> (MessageDlgAsync('There were no scheduled items at last fetch.'
      + #13#13'Do you want to refresh the list?',mtConfirmation, [mbYes,mbNo]))
      = mrYes then
    begin
      await (UpdateEPG(Self));
    end;
  end
  else if Captures.RowCount < 2 then // Invalid list
  begin
    Log('No fresh captures, prompting for EPG fetch');
    if TAwait.ExecP<TModalResult> (MessageDlgAsync('The list appears to be stale.'
      + #13#13'Do you want to refresh the list?',mtConfirmation, [mbYes,mbNo]))
      = mrYes then
    begin
      await (UpdateEPG(Self));
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
  Log('FillHistoryDisplay finished');
end;

procedure TCWRmainFrm.HistoryClick(Sender: TObject);
begin
  SetPage(2);
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
  HistoryTable.Visible := True;
end;

procedure TCWRmainFrm.SetPage(PageNum: Integer);

begin
  await(CheckSettingsForUpdate);
  case PageNum of
    0: begin          {Listings page}
      pnlListings.BringToFront;
//      Listings.SetFocus;
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
end;

procedure TCWRmainFrm.Settings1Click(Sender: TObject);
begin
  SetPage(4);
end;

procedure SetLabelStyle(lbl: TWebLabel; State: Boolean);
//  Show detail items in red (on) or lt. gray (off)
begin
  lbl.Font.Color := IfThen(State, clRed, clLtGray);
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

procedure TCWRmainFrm.ListingClick(Sender: TObject);
begin
  SetPage(0);
end;

procedure TCWRmainFrm.WebDBGrid1GetCellClass(Sender: TObject; ACol,
  ARow: Integer; AField: TField; AValue: string; var AClassName: string);
{ show listings in color code for type based on current IDB record }
//var
//  AColor: string;
//  Text: string;
begin
  if (ARow = 0) then exit;
  AClassName := WIDBCDS.Fields[15].AsString;
///// Following has been superseded by setting in LoadWIDBCDS of Fields[15]
//  if ACol>0 then
////  ACla/ssName := WebDBGrid1.Cells[0,ARow].
//  AColor := '';
//  if WIDBCDS.Locate('id', WebDBGrid1.Cells[3,ARow],[]) then
//  begin
//    Text := WIDBCDS.Fields[8].AsString; // i.e. ProgramID
//  //  if not Text.Contains('EP') then console.log(Text);
//    if Text.Contains('MV') then  // Movie item
//      AColor := 'goldenRod'
//    else if Text.Contains('SH') then  // Generic item
//      AColor := 'gray'
//    else begin
//      if WIDBCDS.Fields[10].AsString <> '' then  // New item
//        AColor := 'green'
//      else                                // Rerun item
//        AColor := 'rose';
//    end;
//    if AColor > '' then AClassName := AColor;
//  end;
end;

procedure TCWRmainFrm.WebDBGrid1ClickCell(Sender: TObject; ACol, ARow: Integer);
var
  DetailsFrm: TDetailsFrm;
  SchedFrm: TSchedForm;
  x: TArray<string>;

begin
  Log('WebDBGrid1SelectCell() called from RC ' + ARow.ToString + ', ' + ACol.ToString);
  DetailsFrm := TDetailsFrm.Create(Self);
  DetailsFrm.Popup := True;
  DetailsFrm.Border := fbSingle;
  try
    // load file HTML template + controls
    TAwait.ExecP<TDetailsFrm>(DetailsFrm.Load());

  // init controls after loading
    if WIDBCDS.Locate('id', WebDBGrid1.Cells[3,ARow],[]) then
    begin
      DetailsFrm.mmTitle.Text := WIDBCDS.Fields[1+2].AsString;
      DetailsFrm.mmSubTitle.Text := WIDBCDS.Fields[1+3].AsString;
      DetailsFrm.lb09OrigDate.Caption := IfThen(WIDBCDS.Fields[1+12].AsString > '', 'Movie Yr', '1st Aired') + '  ';
      DetailsFrm.lb11Time.Caption := WIDBCDS.Fields[1+1].AsString;
      DetailsFrm.lb10Channel.Caption := WIDBCDS.Fields[1+0].AsString;
      x := WIDBCDS.Fields[1+8].AsString.Split(['-']);
      if Length(x) = 3 then
        DetailsFrm.lb09OrigDate.Caption := DetailsFrm.lb09OrigDate.Caption + x[1] + '/' + x[2] + '/' + RightStr(x[0],2)
      else
        DetailsFrm.lb09OrigDate.Caption := DetailsFrm.lb09OrigDate.Caption + WIDBCDS.Fields[1+12].AsString;
      SetLabelStyle(DetailsFrm.lb02New, WIDBCDS.Fields[1+9].AsString <> '');
      SetLabelStyle(DetailsFrm.lb08CC, WIDBCDS.Fields[1+10].AsString.Contains('cc'));
      SetLabelStyle(DetailsFrm.lb03Stereo, WIDBCDS.Fields[1+10].AsString.Contains('stereo'));
      SetLabelStyle(DetailsFrm.lb07Dolby, WIDBCDS.Fields[1+10].AsString.Contains('DD'));
      DetailsFrm.lb04HD.Caption := 'SD';
      if WIDBCDS.Fields[1+11].AsString > '' then
        DetailsFrm.lb04HD.Caption := WIDBCDS.Fields[1+11].AsString.Split(['["HD ','"'])[1] ; //,[TStringSplitOptions.ExcludeEmpty]);
      SetLabelStyle(DetailsFrm.lb04HD, DetailsFrm.lb04HD.Caption <> 'SD');
      DetailsFrm.mmDescription.Text := WIDBCDS.Fields[1+4].AsString;
    // execute form and wait for close
      TAwait.ExecP<TModalResult>(DetailsFrm.Execute);
      if DetailsFrm.ModalResult = mrOk then
      begin
        SchedFrm := TSchedForm.Create(Self);
        SchedFrm.Caption := 'Schedule Capture Event';
        SchedFrm.Popup := True;
        SchedFrm.Border := fbSingle;

        // used to manage Back button handling to close subform  (???)
        window.location.hash := 'subform';
        try
          // load file HTML template + controls
          TAwait.ExecP<TSchedForm>(SchedFrm.Load());

        // init controls after loading
          SchedFrm.mmTitle.Text := DetailsFrm.mmTitle.Text;
          SchedFrm.mmSubTitle.Text := DetailsFrm.mmSubTitle.Text;
          SchedFrm.mmDescription.Text := DetailsFrm.mmDescription.Text;
          SchedFrm.lblChannelValue.Caption := DetailsFrm.lb10Channel.Caption;
          // N.B.:  WIDBCDS DateTimes are UTC, but we need to specify HTPC's TZ for capture!
          // So we decode the times from the "Time" field (format: mm/yy HH:nn--HH:nn)
          x := string(DetailsFrm.lb11Time.Caption).Split([' ','--']);
          console.log(x);
          SchedFrm.lblStartDateValue.Caption := x[0];
          SchedFrm.tpStartTime.DateTime := StrToDateTime(x[0] + ' ' + x[1]);
          SchedFrm.tpEndTime.DateTime := StrToDateTime(x[0] + ' ' + x[2]);
          if SchedFrm.tpEndTime.DateTime < SchedFrm.tpStartTime.DateTime then  // wrapped midnight
            SchedFrm.tpEndTime.DateTime := SchedFrm.tpEndTime.DateTime + 1;
          // execute form and wait for close
          TAwait.ExecP<TModalResult>(SchedFrm.Execute);
          if SchedFrm.ModalResult = mrOk then
            await (UpdateNewCaptures(SchedFrm.tpStartTime.DateTime, SchedFrm.tpEndTime.DateTime));
        finally
          SchedFrm.Free;
        end;
      end;
    end
  finally
    DetailsFrm.Free;
  end;
end;


//procedure TCWRmainFrm.ListingsDblClick(Sender: TObject);
//var
//  i: Integer;
//begin
//  Log('DblClick at [' + ClickedCol.ToString + ',' + ClickedRow.ToString + ']');
//  case ClickedCol of
//    0, 2: begin  // Filter channels, Titles
//      Log('Filtering Channels on ' + Listings.Cells[ClickedCol, ClickedRow]);
//      WebStringGrid2.RowCount := 1;
//      WebStringGrid2.ColCount := Listings.ColCount;
//      for i := 0 to Listings.ColCount-1 do
//        WebStringGrid2.ColWidths[i] := Listings.ColWidths[i];
//      WebStringGrid2.ColAlignments[0] := taCenter;
//      WebStringGrid2.ColAlignments[1] := taCenter;
//      WebStringGrid2.Cells[1,0] := 'List of matching ';
//      WebStringGrid2.Cells[2,0] :=  Listings.Cells[ClickedCol,0] + ' (Dbl clk to return)';
//      WebStringGrid2.Show;
//      WebGridPanel2.Hide;
//      WebStringGrid2.BringToFront;
//      WebStringGrid2.BeginUpdate;
//      for i := 1 to Listings.RowCount - 1 do
//        if Listings.Cells[ClickedCol, i] = Listings.Cells[ClickedCol, ClickedRow] then
//        begin
//          WebStringGrid2.RowCount := WebStringGrid2.RowCount + 1;
//          WebStringGrid2.Rows[WebStringGrid2.RowCount-1].Assign(Listings.Rows[i]);
//          ColorGridRow(WebStringGrid2, WebStringGrid2.RowCount-1);
//        end;
//      WebStringGrid2.EndUpdate;
//    end;
//  end;
//end;

procedure TCWRmainFrm.WebStringGrid2DblClick(Sender: TObject);
// Hide WSG2 to go back to EPG list
begin
  SearchResults.Hide;
//  WebGridPanel2.Show;
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
  Captures.OnGetCellData := nil;
  await(RefreshCSV(Captures, 'cwr_captures.csv', 'Scheduled', id));
  // Save unmodified capture data to Local Storage
  sl := TStringList.Create;
  Captures.SaveToStrings(sl, ',', True);
  for i := 0 to sl.Count - 1 do
    TWebLocalStorage.SetValue('sl'+i.ToString, sl[i]);
  TWebLocalStorage.RemoveKey('sl'+sl.Count.ToString);  // dump old value
  sl.Free;
  // Turn GetCellData formatting back on
  Captures.OnGetCellData := AllCapsGridGetCellData;
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
  id: string;
  res: TJSXMLHttpRequest;
  data: Tstrings;
begin
  Log(' ====== UpdateNewCaptures called =========');
  await(RefreshCSV(NewCaptures, 'cwr_newcaptures.csv','NewCaptures', id));
  Log('NewCaptures Rows: '+NewCaptures.RowCount.ToString);
  if NewCaptures.RowCount = 0 then // fnf, create new one
  begin
    NewCaptures.RowCount := 1;
    NewCaptures.ColCount := 7;
    for i := 0 to NewCaptures.ColCount-1 do
      NewCaptures.Cells[i,0] := HEADINGS[i];
    await(CreateGoogleFile('cwr_newcaptures.csv', id));
  end
  else
    for i := NewCaptures.RowCount-1 downto 1 do // Remove blank rows
      if NewCaptures.Cells[0,i] = '' then NewCaptures.RemoveRow(i);
// Add the new capture to the list
  NewCaptures.RowCount := NewCaptures.RowCount + 1;
  NewCaptures.Cells[0,NewCaptures.RowCount-1] := WIDBCDS.FieldByName('PSIP').AsString;
  NewCaptures.Cells[1,NewCaptures.RowCount-1] := DateTimeToStr(RecordStart);
  NewCaptures.Cells[2,NewCaptures.RowCount-1] := DateTimeToStr(RecordEnd);
  NewCaptures.Cells[3,NewCaptures.RowCount-1] := ReplaceStr(WIDBCDS.FieldByName('Title').AsString, '&', '&&');
  NewCaptures.Cells[4,NewCaptures.RowCount-1] := WIDBCDS.FieldByName('SubTitle').AsString;
  NewCaptures.Cells[5,NewCaptures.RowCount-1] := WIDBCDS.FieldByName('Time').AsString.Split(['--'])[0]; // EPG StartTime (HTPC TZ)
  NewCaptures.Cells[6,NewCaptures.RowCount-1] := WIDBCDS.FieldByName('ProgramID').AsString; // Episode No.
  // Update the file
  data := TStringList.Create;
  data.LineBreak := #13#10;
  NewCaptures.SaveToStrings(data, ',', True);
  console.log('id: '+id);
  console.log('data.text: ', data.Text);
  res := TAwait.ExecP<TJSXMLHttpRequest>(WEBRESTClient1.HttpRequest('PATCH','https://www.googleapis.com/upload/drive/v3/files/'+id, data.Text));
  console.log(res);
  if res.Status = 200 then
    ShowMessage('Request successfully posted.'#13#13'N.B.:  It will NOT be scheduled until CW_EPG''s next run.')
  else ShowMessage('Request submission FAILED.'#13#13'If this is the first failure, please retry.');

  // ==============================
  Log('Final NewCaptures Table Rows: '+NewCaptures.RowCount.ToString);
  Log(' ====== UpdateNewCaptures finished =========');
end;

procedure TCWRmainFrm.ViewLog1Click(Sender: TObject);
begin
  SetPage(3);
end;

procedure TCWRmainFrm.CreateGoogleFile(FName: string; var id: string);
var
  rq: TJSXMLHttpRequest;
  jso: TJSONObject;
begin

  rq := TAwait.ExecP<TJSXMLHttpRequest>(WEBRestClient1.HttpRequest('POST','https://www.googleapis.com/upload/drive/v3/files'));

  console.log(rq);

  jso := TJSONObject(TJSONObject.ParseJSONValue(rq.responseText));

  if Assigned(jso) then
  begin
    id := string(jso.GetJSONValue('id'));
    console.log('file ID'+id);

    rq := TAwait.ExecP<TJSXMLHttpRequest>(WEBRestClient1.HttpRequest('PATCH','https://www.googleapis.com/drive/v3/files/'+id,
      '{"name":"'+ FName + '", "description":"New Captures CSV list"}'));

  end;
end;

end.
