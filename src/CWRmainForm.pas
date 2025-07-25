unit CWRmainForm;
                       { TODO : Add search function to Listings (and History?) }
                       { TODO : Add item deletion to Scheduled list }
                       { DONE : Add one-off scheduling of Listing item }
interface

uses
  JSONDataSet,
  System.SysUtils, System.Classes, WEBLib.Graphics, WEBLib.Forms, Vcl.StdCtrls,
  WEBLib.StdCtrls, Vcl.Controls, WEBLib.Dialogs, Vcl.Imaging.pngimage,
  WEBLib.ExtCtrls, WEBLib.Controls, Web, JS, WebLib.DB, WEBLib.IndexedDb,
  Vcl.Menus, WEBLib.Menus, WEBLib.ComCtrls, WEBLib.Grids, DB, Vcl.Grids,
  System.StrUtils, WEBLib.DBCtrls, WEBLib.FlexControls, WEBLib.WebCtrls,
  WEBLib.REST, Types, WEBLib.Storage, WEBLib.CDS, WEBLib.Auth, WEBLib.JSON,
  WEBLib.WebTools, WEBLib.Google;

type
  TOpen = class(TIndexedDBClientDataSet);
  TGridDrawState = set of (gdSelected, gdFocused, gdFixed, gdRowSelected, gdHotTrack, gdPressed);
  TCWRmainFrm = class(TWebForm)
  WIDBCDS: TWebIndexedDbClientDataset;
  WebMemo2: TWebMemo;
  Captures: TWebStringGrid;
  HistoryTable: TWebStringGrid;
  BufferGrid: TWebStringGrid;
  pnlCaptures: TWebPanel;
  pnlHistory: TWebPanel;
  pnlLog: TWebPanel;
  pnlOptions: TWebPanel;
  pnlWaitPls: TWebPanel;
  WebRESTClient1: TWebRESTClient;
  pnlListings: TWebPanel;
  NewCaptures: TWebStringGrid;
  pnlMenu: TWebPanel;        // Container for MainMenu
  WebMainMenu1: TWebMainMenu;
  Scheduled: TMenuItem;
  History: TMenuItem;
  Options: TMenuItem;
  RefreshEPG: TMenuItem;
  ChangeHTPC1: TMenuItem;
  ViewLog1: TMenuItem;
  Settings1: TMenuItem;
  WebGroupBox3: TWebGroupBox;
  WebGroupBox1: TWebGroupBox;
  EPG: TWebDBGrid;
  WebDataSource1: TWebDataSource;
  WebButton1: TWebButton;
  WebGridPanel1: TWebGridPanel;
  WebLabel1: TWebLabel;
  WebLabel2: TWebLabel;
  WebComboBox1: TWebComboBox;
  WebComboBox2: TWebComboBox;
  lblEmptyEPG: TWebLabel;
  ByAll: TMenuItem;
  ByChannel: TMenuItem;
  ByGenre: TMenuItem;
  ByTitle: TMenuItem;
  WebComboBox3: TWebComboBox;
    WebHTMLDiv1: TWebHTMLDiv;
    WebHTMLDiv2: TWebHTMLDiv;
    WebHTMLDiv3: TWebHTMLDiv;
    pnlFilterComboBox: TWebPanel;
    lblFilterSelect: TWebLabel;
    WebHTMLDiv4: TWebHTMLDiv;
    HistoryGrid: TWebStringGrid;
    EpgDb: TWebClientDataSet;
    CurrEpgDb: TWebClientDataSet;
    cbNumDisplayDays: TWebComboBox;
    cbNumHistList: TWebComboBox;
    btnOptOK: TWebButton;
  procedure SetNewCapturesFixedRow;
  procedure EPGGetCellClass(Sender: TObject; ACol, ARow: Integer;  // Lead with non-async proc to avoid mess-up on new comp add
    AField: TField; AValue: string; var AClassName: string);
  [async] procedure SaveNewCapturesFile(id: string);
  [async] procedure LoadWIDBCDS;
  [async] procedure WIDBCDSIDBError(DataSet: TDataSet; opCode: TIndexedDbOpCode;
    errorName, errorMsg: string);
  [async] procedure RefreshData(Sender: TObject);
  [async] procedure WebFormCreate(Sender: TObject);
  [async] procedure tbCapturesShow;
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
//  [async]
//  procedure FinalizeWIDBCDSUpdate;
  [async]
  procedure EPGClickCell(Sender: TObject; ACol, ARow: Integer);
  procedure HistoryTableGetCellClass(Sender: TObject; ACol, ARow: Integer;
    AField: TField; AValue: string; var AClassName: string);
  [async] procedure ByGenreClick(Sender: TObject);
  [async] procedure WebComboBox1Change(Sender: TObject);
  [async] procedure ByTitleClick(Sender: TObject);
  [async] procedure WebComboBox2Change(Sender: TObject);
  [async] procedure ByAllClick(Sender: TObject);
//  procedure ClearExcept(FilterType: string);
  [async] procedure ByChannelClick(Sender: TObject);
  [async] procedure WebComboBox3Change(Sender: TObject);
  [async] procedure cbNumDisplayDaysChange(Sender: TObject);
  [async]
    procedure NewCapturesClickCell(Sender: TObject; ACol, ARow: Integer);
    procedure NewCapturesGetCellData(Sender: TObject; ACol, ARow: Integer;
      AField: TField; var AValue: string);
    procedure WebComboBox1FocusOut(Sender: TObject);
    procedure WebComboBox2FocusOut(Sender: TObject);
    procedure WebComboBox3FocusOut(Sender: TObject);
    procedure btnOptOKClick(Sender: TObject);
private
  { Private declarations }
  procedure LogDataRange;
  procedure ClearMenuChecks;
  procedure ReloadSG(SG: TWebStringGrid; LSName: string);  [async]
  procedure SetPage(PageNum: Integer);
  [async]
  procedure FetchCapReservations;
  [async]
  procedure FetchNewCapRequests;
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
  procedure UpdateNewCaptures(RecordStart, RecordEnd: TDateTime);
  [async]
  function GetGoogleDriveFile(TableFile: string; var id: string): string;
  [async]
  procedure CreateGoogleFile(FName: string; var id: string);
  [async] procedure SetupWIDBCDS;
  [async] procedure SetupEpgDb;
  [async] procedure SetupFilterList(cb: TWebComboBox; fn: string);
  [async] procedure SetFilter(fltr: string);
  procedure ShowPlsWait(PlsWaitCap: string);
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
  ResetPrompt:      string = 'none' ;
  VisiblePanelNum:  Integer = 0;
  FirstEndDate,
  LastStartDate:    TDate;

const
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

procedure TCWRmainFrm.ClearMenuChecks;
begin
  ByAll.Checked := False;
  ByGenre.Checked := False;
  ByTitle.Checked := False;
  ByChannel.Checked := False;
end;

procedure TCWRmainFrm.WebComboBox1Change(Sender: TObject);
begin
  EPG.Columns[2].Title := IfThen(WebComboBox1.Text = 'All', 'Title', 'Programs in genre "' + WebComboBox1.Text + '"');
  Log('WebComboBox1.Text: ' + WebComboBox1.Text);
  ClearMenuChecks;
  ByGenre.Checked := WebComboBox1.Text <> 'All';
  // Replace esc "\" with wildcard "_"
  SetFilter(IfThen(ByGenre.Checked, 'genres like '
    + QuotedStr('%"'+ReplaceStr(WebComboBox1.Text, '/', '_')+'"%'), ''));
  ByAll.Checked := not ByGenre.Checked;
  if ByAll.Checked then WebComboBox1FocusOut(Sender);
end;

procedure TCWRmainFrm.WebComboBox1FocusOut(Sender: TObject);
begin
  pnlFilterComboBox.Hide;
  WebComboBox1.Hide;
end;

procedure TCWRmainFrm.WebComboBox2Change(Sender: TObject);
begin
  EPG.Columns[2].Title := 'Title'
    + IfThen(WebComboBox2.Text <> 'All', ': "' + WebComboBox2.Text + '"');
  Log('WebComboBox2.Text: ' + WebComboBox2.Text);
  ClearMenuChecks;
  ByTitle.Checked := WebComboBox2.Text <> 'All';
  SetFilter(IfThen(ByTitle.Checked, 'Title = ' + QuotedStr(WebComboBox2.Text)));
  ByAll.Checked := not ByTitle.Checked;
  if ByAll.Checked then WebComboBox2FocusOut(Sender);
end;

procedure TCWRmainFrm.WebComboBox2FocusOut(Sender: TObject);
begin
  pnlFilterComboBox.Hide;
  WebComboBox2.Hide;
end;

procedure TCWRmainFrm.WebComboBox3Change(Sender: TObject);
begin
  EPG.Columns[2].Title := IfThen(WebComboBox1.Text = 'All', 'Title', 'Programs on channel "' + WebComboBox3.Text + '"');
  Log('WebComboBox3.Text: ' + WebComboBox3.Text);
  ClearMenuChecks;
  ByChannel.Checked := WebComboBox3.Text <> 'All';
  SetFilter(IfThen(ByChannel.Checked, 'PSIP = ' + QuotedStr(WebComboBox3.Text), ''));
  ByAll.Checked := not ByChannel.Checked;
  if ByAll.Checked then WebComboBox3FocusOut(Sender);
end;

procedure TCWRmainFrm.WebComboBox3FocusOut(Sender: TObject);
begin
  pnlFilterComboBox.Hide;
  WebComboBox3.Hide;
end;

procedure TCWRmainFrm.WebFormCreate(Sender: TObject);
var
  AppVersion: string;
begin
  Log('========== FormCreate is called');
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
    cbNumDisplayDays.ItemIndex := cbNumDisplayDays.Items.IndexOf(TWebLocalStorage.GetValue(NUMDAYS));
  if TWebLocalStorage.GetValue(NUMHIST) <> '' then
    cbNumHistList.ItemIndex := cbNumHistList.Items.IndexOf(TWebLocalStorage.GetValue(NUMHIST));
    WebMainMenu1.Appearance.HamburgerMenu.Caption := '['+TWebLocalStorage.GetValue(EMAILADDR)+']';
  await(SetupWIDBCDS);
  Log('FormCreate, ' + WIDBCDS.Name + ' record count: ' + WIDBCDS.RecordCount.ToString);
//  await(SetupEpgDb);
//  EpgDb.First;
//  if EpgDb.RecordCount > 1 then
    await(RefreshListings);
  Log('========== FormCreate is finished');
end;

procedure TCWRmainFrm.RefreshData(Sender: TObject);
var
  id: string; {param used only by UpdateNewcaptures}
  StartT: TDateTime;
begin
  Log('======== "Refresh Data" clicked');
  await(RefreshCSV(BufferGrid, 'cwr_epg.csv','EPG', id));
  if BufferGrid.RowCount > 0 then
  begin
    Log('********* Starting timer');
    StartT := Now;
    await(LoadWIDBCDS);
    await(FetchCapReservations);
    await(FetchNewCapRequests);
    await(FetchHistory);
  end
  else
  begin
    TAwait.ExecP<TModalResult> (MessageDlgAsync('The data update failed!'#13'Please make sure that the HTPC'
      + #13' is connected to Google Drive',mtInformation, [mbOK]))
  end;
  if VisiblePanelNum <> 3 then ReFreshListings
  else SetupEpgDb;
  Log('*********** Delta t (sec): ' + SecondsBetween(Now, StartT).ToString);
  Log('*********** Rate (ms/rec): ' + (MilliSecondsBetween(Now, StartT)/WIDBCDS.RecordCount).ToString);
end;

procedure TCWRmainFrm.UpdateHistory(Sender: TObject);
begin
  await(FetchHistory);
  SetPage(2);
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
    RefreshData(Sender);
  end;
end;

procedure TCWRmainFrm.btnOptOKClick(Sender: TObject);
begin
  TWebLocalStorage.SetValue(NUMDAYS, cbNumDisplayDays.Text);
  Log('New number EPG Display Days: ' + cbNumDisplayDays.Text);
  TWebLocalStorage.SetValue(NUMHIST, cbNumHistList.Text);
  Log('New number History Display Days: ' + cbNumHistList.Text);
  ReFreshListings;
end;

procedure TCWRmainFrm.ByAllClick(Sender: TObject);
begin
  Log('ByAllClick called');
  EPG.Columns[2].Title := 'Title';
  ClearMenuChecks;
  ByAll.Checked := True;
  SetFilter('');
  SetPage(0);
end;

procedure TCWRmainFrm.ByChannelClick(Sender: TObject);
begin
  Log('ByChannelClick called');
  await(SetupFilterList(WebComboBox3, 'PSIP'));
  ByChannel.Checked := True;
end;

procedure TCWRmainFrm.ByGenreClick(Sender: TObject);
begin
  Log('ByGenreClick called');
  await(SetupFilterList(WebComboBox1, 'genres'));
  ByGenre.Checked := True;
end;

procedure TCWRmainFrm.ByTitleClick(Sender: TObject);
begin
  Log('byTitleClick called');
  await(SetupFilterList(WebComboBox2, 'Title'));
  WebComboBox2.ItemIndex := WebComboBox2.Items.IndexOf(EpgDb.FieldByName('Title').AsString);
  ByTitle.Checked := True;
end;

procedure TCWRmainFrm.cbNumDisplayDaysChange(Sender: TObject);
begin
  // Make sure that current dataset supports the requested number
  if Trunc(LastStartDate - Now) < StrToInt(cbNumDisplayDays.Text) then
  begin
    TAwait.ExecP<TModalResult> (MessageDlgAsync('I currently have less than the requested '
      + cbNumDisplayDays.Text + ' days of listings stored.'
      + #13'To display more, please use Options | Refresh Data',mtInformation, [mbOK]));
    cbNumDisplayDays.ItemIndex := cbNumDisplayDays.Items.IndexOf(Trunc(LastStartDate - Now).ToString);
  end;
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
  ShowPlsWait('Refreshing ' + Title);
  {$IFDEF PAS2JS} asm await sleep(10) end; {$ENDIF}
  if application.IsOnline then
  begin
    WSG.BeginUpdate;
    try
      Log('Requesting: ' + TableFile);
      try
        Reply := TAwait.ExecP<string>(GetGoogleDriveFile(TableFile, id));

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
          TAwait.ExecP<TModalResult> (MessageDlgAsync('Cannot refresh EPG data while CW_EPG_Remote is offline', mtInformation, [mbOK]));
        end;
      end;
    finally
      Log('ReFreshCSV in finally section');
      WSG.EndUpdate;
    end;
  end
  else
  begin
    TAwait.ExecP<TModalResult> (MessageDlgAsync('Cannot refresh EPG data while CW_EPG_Remote is offline', mtInformation, [mbOK]));
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
  Log('======= Starting LoadWIDBCDS, DB is ' + IfThen(not WIDBCDS.Active, 'not ') + 'Active');
  ShowPlsWait('Updating IndexedDB');
  {$IFDEF PAS2JS} asm await sleep(10) end; {$ENDIF}
  WIDBCDS.DisableControls;
  WIDBCDS.Filtered := False;
  Log('WIDBCDS is ' + IfThen(not WIDBCDS.Filtered, 'UN') + 'filtered');
  WIDBCDS.Close;
  TAwait.ExecP<Boolean>(WIDBCDS.OpenAsync);
  try
    if WIDBCDS.Active and (BufferGrid.RowCount > 1) then
    begin
      Log('LoadWIDBCDS, CDS.RecordCount: ' + WIDBCDS.RecordCount.ToString);
      Log('LoadWIDBCDS, Buffer Row Count: ' + BufferGrid.RowCount.ToString);
      WIDBCDS.Edit;
      await(WIDBCDS.EmptyDataSet);
      Log('LoadWIDBCDS, After EmptyDataSet CDS.RecordCount: ' + WIDBCDS.RecordCount.ToString);
      for j := 1 to BufferGrid.RowCount - 1 do
      begin
        // Lose superfluous <">
        BufferGrid.Cells[0,j] := ReplaceStr(BufferGrid.Cells[0,j],'"','');
        WIDBCDS.Insert;
        WIDBCDS.Fields[0].Value := j;
        for i := 1 to BufferGrid.ColCount do
          if WIDBCDS.Fields[i].DataType = ftString then
            WIDBCDS.Fields[i].Value := BufferGrid.Cells[i-1,j]
          else  // Keep UTC StartTime/EndTime strings
            if TryStrToDateTime(BufferGrid.Cells[i-1,j],t) then
              WIDBCDS.Fields[i].Value := t;
        Text := WIDBCDS.Fields[8].AsString; // i.e. ProgramID
        if Text.StartsWith('MV') then  // Movie item
          AColor := 'goldenRod'
        else if Text.StartsWith('SH') then  // Generic item
          AColor := IfThen(WIDBCDS.Fields[14].AsString.Contains('"News"'),
            'green',  // News genre assumed "new"
            'gray')   // Otherwise generic episode is "unknown time"
        else
          AColor := IfThen(WIDBCDS.Fields[10].AsString <> '',
            'green',  // Non-generic episode declared "new"
            'rose');  // Otherwise "rerun"
        WIDBCDS.Fields[15].Value := AColor;
        TAwait.ExecP<Boolean>(WIDBCDS.PostAsync);
      end;
      Log('Finished editing WIDBCDS, RecordCount: ' + WIDBCDS.RecordCount.ToString);
    end
    else
    begin
      Log('LoadWIDBCDS, skipped WIDBCDS update because' + IfThen(not WIDBCDS.Active, ' CDS not active')
        + IfThen(BufferGrid.RowCount < 2, ' BufferGrid empty'));
    end;
  finally
    Log('WIDBCDS is ' + IfThen(WIDBCDS.Active, 'NOT ') + 'closed');
    Log('calling WIDBCDS.EnableControls');
    WIDBCDS.EnableControls;
    Log('WIDBCDS Controls are ' + IfThen(WIDBCDS.ControlsDisabled,'NOT ') + 'Enabled');
    Log('WIDBCDS is ' + IfThen(not WIDBCDS.Active,'NOT ') + 'Open');
    Log('WIDBCDS RecordCount: ' + WIDBCDS.RecordCount.ToString);
    WIDBCDS.Close;  // This seems necessary to finish update    250313 TMP -- still true on Android
    TAwait.ExecP<Boolean>(WIDBCDS.OpenAsync);
    LogDataRange;
    TOpen(WIDBCDS).NestedDataSetClass := TBaseJSONDataSet;
    CurrEpgDb := TWebClientDataSet(WIDBCDS.GetClonedDataSet(False));
    Log('========= Finished LoadWIDBCDS');
    pnlWaitPls.Hide;
    {$IFDEF PAS2JS} asm await sleep(10) end; {$ENDIF}

  end;
end;

procedure TCWRmainFrm.NewCapturesClickCell(Sender: TObject; ACol,
  ARow: Integer);
var
  PSIP, Title, ProgID, id: string;
  RecordStart, RecordEnd: TDateTime;
  i: Integer;
begin
  if ARow = 0 then exit;
  if TAwait.ExecP<TModalResult> (MessageDlgAsync('Remove selected program?'
    ,mtConfirmation, [mbYes,mbNo])) = mrYes then
  begin
    // Find & delete matching row in Local Storage
    PSIP := NewCaptures.Cells[0,ARow];
    RecordStart := StrToDateTime(NewCaptures.Cells[1,ARow]);
    RecordEnd := StrToDateTime(NewCaptures.Cells[2,ARow]);
    Title := NewCaptures.Cells[3,ARow];
    ProgID := NewCaptures.Cells[6,ARow];
    NewCaptures.BeginUpdate;
    await(RefreshCSV(NewCaptures, 'cwr_newcaptures.csv','NewCaptures', id));
    Log('NewCaptures Rows: '+NewCaptures.RowCount.ToString);
    if NewCaptures.RowCount > 1 then // file exists, find matching row
      for i := 1 to Pred(NewCaptures.RowCount) do
      begin
        if not SameText(PSIP, NewCaptures.Cells[0,i]) then continue;
        if not SameText(Title, NewCaptures.Cells[3,i]) then continue;
        if not SameText(ProgID, NewCaptures.Cells[6,i]) then continue;
        if not SameDateTime(RecordStart, StrToDateTime(NewCaptures.Cells[1,i])) then continue;
        if not SameDateTime(RecordEnd, StrToDateTime(NewCaptures.Cells[2,i])) then continue;
        NewCaptures.RemoveRow(i);
        // Update file
        SaveNewCapturesFile(id);
        Break;
      end;
    NewCaptures.EndUpdate;
    pnlWaitPls.Hide;
  end;
end;

procedure TCWRmainFrm.NewCapturesGetCellData(Sender: TObject; ACol,
  ARow: Integer; AField: TField; var AValue: string);
begin
  if ARow > 0 then
    if ACol in [1,2] then AValue := FormatDateTime('mm/dd HH:nn', StrToDateTime(AValue));
end;

procedure TCWRmainFrm.LogDataRange;
begin
  WIDBCDS.First;
  FirstEndDate := WIDBCDS.FieldByName('EndTime').AsDateTime;
  Log('FirstEndDate (Rec. ' + WIDBCDS.RecNo.ToString + '): ' + DateToStr(FirstEndDate));
  WIDBCDS.Last;
  LastStartDate := WIDBCDS.FieldByName('StartTime').AsDateTime;
  Log('LastStartDate (Rec. ' + WIDBCDS.RecNo.ToString + '): ' + DateToStr(LastStartDate));
  Log('LastStartDate - Now: ' + Double(LastStartDate - Now).ToString);
end;

procedure TCWRmainFrm.SetupWIDBCDS;
var
  i: Integer;
const
  DBFIELDS: array[0..14] of string = ('PSIP', 'Time', 'Title', 'SubTitle',
  'Description', 'StartTime', 'EndTime', 'programID', 'originalAirDate', 'new',
  'audioProperties', 'videoProperties', 'movieYear', 'genres', 'Class');
begin
  Log('========== SetupWIDBCDS called');
  if WIDBCDS.FieldDefs.IndexOf('id') = -1 then
  begin
    if WIDBCDS.Active then WIDBCDS.Close;
    // don't re-add fields
    WIDBCDS.FieldDefs.Clear;
    WIDBCDS.FieldDefs.Add('id', ftInteger, 0, False);
    // add normal fields
    for i := 0 to Length(DBFIELDS) - 1 do
    begin
      if (DBFIELDS[i] = 'StartTime') or (DBFIELDS[i] = 'EndTime') then begin
        WIDBCDS.FieldDefs.Add(DBFIELDS[i], ftDateTime);
      end else begin
        WIDBCDS.FieldDefs.Add(DBFIELDS[i], ftString);
      end;
    end;
  end;
  TAwait.ExecP<Boolean>(WIDBCDS.OpenAsync);
  Log('WIDBCDS is ' + IfThen(not WIDBCDS.Active, 'not ')
    + 'Active and ' + IfThen(not WIDBCDS.IsEmpty, 'not ') + 'Empty');
  Log('SetupWIDBCDS: WIDBCDS.RecordCount: ' + WIDBCDS.RecordCount.ToString);
  LogDataRange;
  if Now > LastStartDate then
    TAwait.ExecP<TModalResult> (MessageDlgAsync('There are no current data!'#13'Please make sure that the HTPC'
      + #13' is connected to Google Drive',mtInformation, [mbOK]))
  else if Now - FirstEndDate > 3 then
    TAwait.ExecP<TModalResult> (MessageDlgAsync('The current dataset was fetched over 3 days ago'
      + #13'and there are only about ' + Round(LastStartDate - Now).ToString + ' days now available.'
      + #13#13'To update, please use Options | Refresh Data',mtInformation, [mbOK]));
  TOpen(WIDBCDS).NestedDataSetClass := TBaseJSONDataSet;
  CurrEpgDb := TWebClientDataSet(WIDBCDS.GetClonedDataSet(False));

  Log('========== SetupWIDBCDS finished');
end;

procedure TCWRmainFrm.SetupEpgDb;
  procedure ResetComboBox(cb: TWebComboBox);
  begin
    cb.ItemIndex := -1;
    cb.Items.Clear;
  end;
var
  FirstEndTime, LastStartTime:  TDateTime;
  i: Integer;

begin
  Log('====== SetupEpgDb called');
  ShowPlsWait('Resetting EpgDB.');
  {$IFDEF PAS2JS} asm await sleep(10) end; {$ENDIF}
  FirstEndTime := TTimeZone.Local.ToUniversalTime(Now);
  LastStartTime := TTimeZone.Local.ToUniversalTime(Now) + StrToInt(cbNumDisplayDays.Text);
  CurrEpgDb.DisableControls;
//  WIDBCDS.DisableControls;
  EpgDb.DisableControls;
  EpgDb.Filtered := False;
  if EpgDb.RecordCount > 0 then
    EpgDb.EmptyDataSet;
  EpgDb.FieldDefs := CurrEpgDb.FieldDefs;
  EpgDb.Active := True;
  CurrEpgDb.First;
  while not CurrEpgDb.Eof do
  begin
    if (CurrEpgDb.Fields[7].AsDateTime >= FirstEndTime) and
       (CurrEpgDb.Fields[6].AsDateTime <= LastStartTime) then
    begin
      EpgDb.Append;
      for i := 0 to Pred(CurrEpgDb.FieldCount) do
        EpgDb.Fields[i] := CurrEpgDb.Fields[i];
      EpgDb.Post;
    end;
    CurrEpgDb.Next;
  end;
  EpgDb.EnableControls;
  CurrEpgDb.EnableControls;
//  EpgDb.FieldDefs := WIDBCDS.FieldDefs;
//  EpgDb.Active := True;
//  WIDBCDS.First;
//  while not WIDBCDS.Eof do
//  begin
//    if (WIDBCDS.Fields[7].AsDateTime >= FirstEndTime) and
//       (WIDBCDS.Fields[6].AsDateTime <= LastStartTime) then
//    begin
//      EpgDb.Append;
//      for i := 0 to Pred(WIDBCDS.FieldCount) do
//        EpgDb.Fields[i] := WIDBCDS.Fields[i];
//      EpgDb.Post;
//    end;
//    WIDBCDS.Next;
//  end;
//  EpgDb.EnableControls;
//  WIDBCDS.EnableControls;
  Log('SetupEpgDb: EpgDb post-filter record count: ' + EpgDb.RecordCount.ToString);
  WebDataSource1.DataSet := EpgDb;
  EPG.DataSource := WebDataSource1;
  EPG.Columns[0].Alignment := taCenter;
  EPG.Columns[2].Alignment := taLeftJustify;
  ResetComboBox(WebComboBox1);
  ResetComboBox(WebComboBox2);
  ResetComboBox(WebComboBox3);
  pnlWaitPls.Hide;
  {$IFDEF PAS2JS} asm await sleep(10) end; {$ENDIF}
  Log('====== SetupEpgDb finished');
end;

procedure TCWRmainFrm.SetupFilterList(cb: TWebComboBox; fn: string);
var
  x, y, SavedFilterString: string;
  sl: TStringList;
  SavedFilterState: Boolean;
begin
  x := IfThen(fn='genres', 'Genre', IfThen(fn='PSIP', 'Channel', 'Title'));
  lblFilterSelect.Caption := 'Choose ' + x;
  if cb <> WebComboBox1 then WebComboBox1.Hide;
  if cb <> WebComboBox2 then WebComboBox2.Hide;
  if cb <> WebComboBox3 then WebComboBox3.Hide;
  ClearMenuChecks;
  if cb.Items.Count = 0 then
  begin
    ShowPlsWait('Preparing ' + x + ' list.');
    {$IFDEF PAS2JS} asm await sleep(10) end; {$ENDIF}
    SavedFilterState := EpgDb.Filtered;
    SavedFilterString := EpgDb.Filter;
    EpgDb.DisableControls;
    EpgDb.Filtered := False;
    sl := TStringList.Create;
    sl.Sorted := True;
    sl.Duplicates := dupIgnore;
    sl.BeginUpdate;
    EpgDb.First;
    Log('Looping over EpgDb "' + fn + '" field');
    while not EpgDb.Eof do
    begin
      x := EpgDb.FieldByName(fn).AsString;
      if fn='genres' then
      begin
        y := ReplaceStr(x, '\', ''); // Remove escape "\" char
        // Split the genres string 'xxx;yyy;zzz' into array xxx, yyy, zzz
        // ignoring JSON "punctuation" around items
        for x in y.Split([';','[',']','"',','], TStringSplitOptions.ExcludeEmpty) do
          sl.Add(x);
      end
      else sl.Add(x);
      EpgDb.Next;
    end;
    EpgDb.Filter := SavedFilterString;
    EpgDb.Filtered := SavedFilterState;
    sl.EndUpdate;
    cb.BeginUpdate;
    cb.Clear;
    Log('Adding first '+cb.Name+' Item: "All"');
    cb.Items.Add('All');
    cb.Items.AddStrings(sl);
    cb.EndUpdate;
    Log('Added ' + cb.Items.Count.ToString + ' to ' + cb.Name);
    sl.Free;
    cb.ItemIndex := -1;
    EpgDb.EnableControls;
    pnlWaitPls.Hide;
  end;
  pnlFilterComboBox.Show;
  cb.Show;
  {$IFDEF PAS2JS} asm await sleep(10) end; {$ENDIF}
  SetPage(0);
end;

procedure TCWRmainFrm.SetFilter(fltr: string);
begin
  ShowPlsWait('Preparing ' + IfThen(fltr='','Un') + 'Filtered List');
  {$IFDEF PAS2JS} asm await sleep(10) end; {$ENDIF}
  EPG.BeginUpdate;
  EpgDb.DisableControls;
  EpgDb.Filtered := False;
  Log('EpgDb.Filter: ' + fltr);
  EpgDb.Filter := fltr;
  if fltr > '' then EpgDb.Filtered := True;
  EpgDb.EnableControls;
  EPG.EndUpdate;
  EPG.Refresh;
  EpgDb.First;
  pnlWaitPls.Hide;
//  {$IFDEF PAS2JS} asm await sleep(10) end; {$ENDIF}
  // cannot position selection visibly?
//  EpgDb.selectedrows
end;

procedure TCWRmainFrm.ShowPlsWait(PlsWaitCap: string);
begin
  if VisiblePanelNum <> 3 then  // Show overlay
  begin
    WebLabel1.Caption := PlsWaitCap;
    pnlWaitPls.BringToFront;
    pnlWaitPls.Show;
//    {$IFDEF PAS2JS} asm await sleep(10) end; {$ENDIF}
  end
  else Log('####### ' + PlsWaitCap);   // Just make log entry
end;

procedure TCWRmainFrm.ReFreshListings;
begin
  Log(' ======== RefreshListings is called.');
  EPG.Visible := False;
  {$IFDEF PAS2JS} asm await sleep(10) end; {$ENDIF}
  Await(SetupEpgDb);
//  Log('EpgDb.RecordCount: ' + EpgDb.RecordCount.ToString);
  Log('Days to Display: ' + cbNumDisplayDays.Text);
//  EPG.BeginUpdate;
  ShowPlsWait('Preparing ' + cbNumDisplayDays.Text + '-day Listing.');
  {$IFDEF PAS2JS} asm await sleep(10) end; {$ENDIF}
//  EPG.EndUpdate;
  EPG.Refresh;
  EPG.Visible := True;
  pnlListings.BringToFront;
  {$IFDEF PAS2JS} asm await sleep(10) end; {$ENDIF}
  Log(' ======== RefreshListings finished');
end;

procedure TCWRmainFrm.ScheduledClick(Sender: TObject);
begin
  SetPage(1);
end;


procedure TCWRmainFrm.ReloadSG(SG: TWebStringGrid; LSName: string);
var i: Integer;
  sl: TStringList;
begin
  SG.RowCount := 1;
  if TWebLocalStorage.GetValue(LSName + '1') > '' then  // have stored value(s)
  begin
    sl := TStringList.Create;
    i := 0;
    while ReplaceStr(ReplaceStr(TWebLocalStorage.GetValue(LSName + i.ToString),'"',''),',','') > '' do
    begin
      sl.Add(TWebLocalStorage.GetValue(LSName + i.ToString));
      Inc(i);
    end;
    SG.LoadFromStrings(sl, ',', True);
    sl.Free;
  end;
  Log(SG.Name + ' Row Count: ' + SG.RowCount.ToString);
end;

procedure TCWRmainFrm.SetNewCapturesFixedRow;
const
  HEADINGS: array [0..6] of string = ('Ch Name','RecordStart','RecordEnd','Title','SubTitle','StartTime','ProgramID');
  WIDTHS: array [0..6] of Integer =  (       75,           95,         95,    150,       400,          0,         0 );
var i: Integer;
begin
  for i := 0 to NewCaptures.ColCount-1 do
  begin
    NewCaptures.Cells[i,0] := HEADINGS[i];
    NewCaptures.ColWidths[i] := WIDTHS[i];
  end;
end;

procedure TCWRmainFrm.tbCapturesShow;
var
  i: Integer;
  st, et: TDateTime;

begin
  ReloadSG(Captures, 'sl');
  if Captures.RowCount > 1 then  // have stored value(s)
  begin
    // Discard stale entries (End DateTime < now)
    for i := Captures.RowCount-1 downto 1 do
      if Captures.Cells[3,i] > '' then // not null row
      begin
        st := StrToDateTime(Captures.Cells[3,i] + ' ' + Captures.Cells[4,i]);
        et := StrToDateTime(Captures.Cells[3,i] + ' ' + Captures.Cells[5,i]);
        if et < st then et := et + 1;     // wraps midnight
        if et < now then
        begin
          console.log('Removing stale entry, endtime: ' + DateTimeToStr(et));
          Captures.RemoveRow(i);
        end;
      end;
  end;
  ReloadSG(NewCaptures, 'nc');
  SetNewCapturesFixedRow;
  if NewCaptures.RowCount > 1 then  // have stored value(s)
  begin
    // Discard stale entries (End DateTime < now)
    for i := NewCaptures.RowCount-1 downto 1 do
      if NewCaptures.Cells[0,i] > '' then // not null row
      begin
        st := StrToDateTime(NewCaptures.Cells[1,i]);
        et := StrToDateTime(NewCaptures.Cells[2,i]);
        if et < now then
        begin
          console.log('Removing stale entry, endtime: ' + DateTimeToStr(et));
          NewCaptures.RemoveRow(i);
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
      await (RefreshData(Self));
    end;
  end
  else if Captures.RowCount < 2 then // Invalid list
  begin
    Log('No fresh captures, prompting for EPG fetch');
    if TAwait.ExecP<TModalResult> (MessageDlgAsync('Scheduled list appears to be stale.'
      + #13#13'Do you want to refresh it?',mtConfirmation, [mbYes,mbNo]))
      = mrYes then
    begin
      await (RefreshData(Self));
    end;
  end  ;
end;

procedure TCWRmainFrm.FillHistoryDisplay;
var
  sl: TStrings;
  i: Integer;

begin
  Log('FillHistoryDisplay called');
  HistoryTable.OnGetCellClass := nil;
  sl := TStringList.Create;
  for i := 0 to Pred(StrToInt(cbNumHistList.Text)) do
    if TWebLocalStorage.GetValue('hl'+i.ToString) > '' then
      sl.Add(TWebLocalStorage.GetValue('hl'+i.ToString));
  Log('sl.Count: ' + sl.Count.ToString);
  Log('historyTable.BeginUpdate');

  historyTable.BeginUpdate;
  historyTable.RowCount := sl.Count;
  if sl.Count > 1 then begin
    Log('historyTable.LoadFromStrings');
    historyTable.LoadFromStrings(sl,',',True);
    Log('historyTable.RowCount: ' + historyTable.RowCount.ToString);
    HistoryTable.EndUpdate;
  end;
  Log('historyTable.ColCount: ' + historyTable.ColCount.ToString);
  HistoryTable.BeginUpdate;
  for i := historyTable.ColCount-1 downto 0 do
  begin
    if i in [8,10,12,13,14] then continue;
    historyTable.RemoveColumn(i);
  end;
  Log('historyTable.ColCount: ' + historyTable.ColCount.ToString);
  sl.Clear;
  HistoryTable.SaveToStrings(sl,',',True);
  HistoryTable.OnGetCellClass := HistoryTableGetCellClass;
  HistoryTable.LoadFromStrings(sl,',',True);
  sl.Free;
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

procedure TCWRmainFrm.HistoryTableGetCellClass(Sender: TObject; ACol,
  ARow: Integer; AField: TField; AValue: string; var AClassName: string);
begin
  if (ARow > 0) and (HistoryTable.Cells[0,ARow] > '') then
  begin
    case HistoryTable.Cells[1,ARow][1] of
      'E': AClassName := 'green';         // Regular Episode
      'S': AClassName := 'gray';          // Generic Show
      'M': AClassName := 'goldenRod';     // Movie
    else
      AClassName := 'white';              // Huh?
    end;
  end;
end;

procedure TCWRmainFrm.tbHistoryShow;
begin
  HistoryTable.Visible := False;
  await(FillHistoryDisplay);
  Log('HistoryTable.RowCount: ' + HistoryTable.RowCount.ToString);
  if HistoryTable.RowCount <> StrToInt(cbNumHistList.Text) {+ 1} then  // may need History data
  begin
    Log('The History list is empty/incomplete. Prompt for refresh');
    if TAwait.ExecP<TModalResult> (MessageDlgAsync('The History list '
     + IfThen(HistoryTable.RowCount < 2,'is empty','may be incomplete')
      + #13#13'Do you want to refresh it now?',mtConfirmation, [mbYes,mbNo]))
      = mrYes then await(UpdateHistory(Self));
  end;
  HistoryTable.Visible := True;
end;

procedure TCWRmainFrm.SetPage(PageNum: Integer);

begin
  case PageNum of
    0: begin          {Listings page}
      pnlListings.BringToFront;
      EPG.Show;
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
      // Reset Comboboxes in case Save Settings skipped
      if TWebLocalStorage.GetValue(NUMDAYS) <> '' then
        cbNumDisplayDays.ItemIndex := cbNumDisplayDays.Items.IndexOf(TWebLocalStorage.GetValue(NUMDAYS));
      if TWebLocalStorage.GetValue(NUMHIST) <> '' then
        cbNumHistList.ItemIndex := cbNumHistList.Items.IndexOf(TWebLocalStorage.GetValue(NUMHIST));
      pnlOptions.BringToFront;
    end;
  end;
  VisiblePanelNum := PageNum;
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

procedure TCWRmainFrm.EPGGetCellClass(Sender: TObject; ACol,
  ARow: Integer; AField: TField; AValue: string; var AClassName: string);
{ show listings row in color coded for type based on current IDB record }
begin
  if ARow = 0 then exit;
  if EPG.Cells[3,ARow] = EpgDb.Fields[0].AsString then
    AClassName := EPG.Cells[4,ARow] // EpgDb.Fields[15].AsString
  else AClassName := 'white'; // Should not occur!
end;

procedure TCWRmainFrm.EPGClickCell(Sender: TObject; ACol, ARow: Integer);
var
  DetailsFrm: TDetailsFrm;
  SchedFrm: TSchedForm;
  x: TArray<string>;

begin
  EPG.BeginUpdate;
  {$IFDEF PAS2JS} asm await sleep(10) end; {$ENDIF}
  Log('========== EPGClickCell() called from RC ' + ARow.ToString + ', ' + ACol.ToString);
  DetailsFrm := TDetailsFrm.Create(Self);
  // Speed up form opening
  EpgDb.DisableControls;
  // Wrap in try-except-end because of Locate bug with filtered data
  try
    if EpgDb.Locate('id', EPG.Cells[3,ARow],[]) then
    try
      DetailsFrm.Popup := True;
      DetailsFrm.Border := fbSingle;
      // load file HTML template + controls
      TAwait.ExecP<TDetailsFrm>(DetailsFrm.Load());
      // init controls after loading
      DetailsFrm.mmTitle.Text := EpgDb.Fields[3].AsString;
      DetailsFrm.mmSubTitle.Text := EpgDb.Fields[4].AsString;
      DetailsFrm.lb11Time.Caption := EpgDb.Fields[2].AsString;
      DetailsFrm.lb10Channel.Caption := EpgDb.Fields[1].AsString;
      x := EpgDb.Fields[9].AsString.Split(['-']);                 // Parse 1st-air date
      DetailsFrm.lb09OrigDate.Caption := IfThen(Length(x) = 3,      // Have 1st-air date
        '1st Aired ' + x[1] + '/' + x[2] + '/' + RightStr(x[0],2),  // Use 1st-air date
        IfThen(EpgDb.Fields[13].AsString > '',                    // Check Movie year
        'Movie Yr ' + EpgDb.Fields[13].AsString,''));             // Use Movie year or nil
      SetLabelStyle(DetailsFrm.lb02New, EpgDb.Fields[10].AsString <> '');
      SetLabelStyle(DetailsFrm.lb08CC, EpgDb.Fields[11].AsString.Contains('cc'));
      SetLabelStyle(DetailsFrm.lb03Stereo, EpgDb.Fields[11].AsString.Contains('stereo'));
      SetLabelStyle(DetailsFrm.lb07Dolby, EpgDb.Fields[11].AsString.Contains('DD'));
      DetailsFrm.lb04HD.Caption := 'SD';
      if EpgDb.Fields[12].AsString > '' then
        DetailsFrm.lb04HD.Caption := EpgDb.Fields[12].AsString.Split(['["HD ','"'])[1];
      SetLabelStyle(DetailsFrm.lb04HD, DetailsFrm.lb04HD.Caption <> 'SD');
      DetailsFrm.mmDescription.Text := EpgDb.Fields[5].AsString;
    // execute form and wait for close
      TAwait.ExecP<TModalResult>(DetailsFrm.Execute);
      if DetailsFrm.ModalResult = mrOk then
      begin
        SchedFrm := TSchedForm.Create(Self);
        SchedFrm.Caption := 'Schedule Capture Event';
        SchedFrm.Popup := True;
        SchedFrm.Border := fbSingle;

        try
          // load file HTML template + controls
          TAwait.ExecP<TSchedForm>(SchedFrm.Load());

        // init controls after loading
          SchedFrm.mmTitle.Text := DetailsFrm.mmTitle.Text;
          SchedFrm.mmSubTitle.Text := DetailsFrm.mmSubTitle.Text;
          SchedFrm.mmDescription.Text := DetailsFrm.mmDescription.Text;
          SchedFrm.lblChannelValue.Caption := DetailsFrm.lb10Channel.Caption;
          // N.B.:  EpgDb DateTimes are UTC, but we need to specify HTPC's TZ for capture!
          // So we decode the times from the "Time" field (format: mm/yy HH:nn--HH:nn)
          x := string(DetailsFrm.lb11Time.Caption).Split([' ','--']);
  //        console.log(x);
          SchedFrm.lblStartDateValue.Caption := x[0];
          SchedFrm.tpStartTime.DateTime := StrToDateTime(x[0] + ' ' + x[1]);
          SchedFrm.tpEndTime.DateTime := StrToDateTime(x[0] + ' ' + x[2]);
          if SchedFrm.tpEndTime.DateTime < SchedFrm.tpStartTime.DateTime then  // wrapped midnight
            SchedFrm.tpEndTime.DateTime := SchedFrm.tpEndTime.DateTime + 1;
          Log('Finished setting up new form');
          // execute form and wait for close
          TAwait.ExecP<TModalResult>(SchedFrm.Execute);
          if SchedFrm.ModalResult = mrOk then
          begin
            ShowPlsWait('Saving Capture Request.');
            {$IFDEF PAS2JS} asm await sleep(10) end; {$ENDIF}
            await (UpdateNewCaptures(SchedFrm.tpStartTime.DateTime, SchedFrm.tpEndTime.DateTime));
          end;
        finally
          Log('Finished with Schedule form');
          SchedFrm.Free;
        end;
      end;
    finally
      pnlWaitPls.Hide;
      DetailsFrm.Free;
      {$IFDEF PAS2JS} asm await sleep(100) end; {$ENDIF}
    end;
  except
    Log('Locate raised an improper Exception instead of "False"');
  end;
  EpgDb.EnableControls;
  EPG.EndUpdate;
end;

procedure TCWRmainFrm.WIDBCDSIDBError(DataSet: TDataSet;
  opCode: TIndexedDbOpCode; errorName, errorMsg: string);
begin
  TAwait.ExecP<TModalResult> (MessageDlgAsync(DataSet.Name + ' error: ' + errorName + ', msg: ' + errorMsg, mtInformation, [mbOK]));
end;

procedure SaveLocalStrings(SG: TWebStringGrid; LSName: string);
var
  sl: TStringList;
  i: Integer;
begin
  sl := TStringList.Create;
  SG.SaveToStrings(sl, ',', True);
  for i := 0 to sl.Count - 1 do
    TWebLocalStorage.SetValue(LSName + i.ToString, sl[i]);
  i := sl.Count;
  while TWebLocalStorage.GetValue(LSName + i.ToString) > '' do
  begin
    TWebLocalStorage.RemoveKey(LSName + sl.Count.ToString);  // dump old value
    Inc(i);
  end;
  sl.Free;
end;

procedure TCWRmainFrm.FetchCapReservations;  // Fetch CW_EPG-saved file

var
  id: string;
begin
  Log(' ====== FetchCapReservations called =========');
  // Turn off GetCellData (modifies Cols 1, 2 for display)
  Captures.OnGetCellData := nil;
  await(RefreshCSV(Captures, 'cwr_captures.csv', 'Scheduled', id));
  // Save unmodified capture data to Local Storage
  SaveLocalStrings(Captures, 'sl');
  // Turn GetCellData formatting back on
  Captures.OnGetCellData := AllCapsGridGetCellData;
  Log(' ====== FetchCapReservations finished =========');
end;

procedure TCWRmainFrm.FetchNewCapRequests;  // Fetch CW_EPG-saved file

var
  id: string;
begin
  Log(' ====== FetchNewCapRequests called =========');
  // Turn off GetCellData (modifies Cols 1, 2 for display)
  NewCaptures.OnGetCellData := nil;
  await(RefreshCSV(NewCaptures, 'cwr_newcaptures.csv', 'New Captures', id));
  // Save unmodified request data to Local Storage
  SaveLocalStrings(NewCaptures, 'nc');
  // Turn GetCellData formatting back on
  NewCaptures.OnGetCellData := NewCapturesGetCellData;
  Log(' ====== FetchNewCapRequests finished =========');
end;

procedure TCWRmainFrm.FetchHistory;

var
  i: Integer;
  id: string;
  sl: TStrings;
begin
  Log(' ====== FetchHistory called =========');
  HistoryGrid.BeginUpdate;
  HistoryGrid.ColCount := 32;
  await(RefreshCSV(HistoryGrid, 'cwr_history.csv','History', id));
  Log('History Rows: '+HistoryGrid.RowCount.ToString);
  for i := HistoryGrid.RowCount-1 downto 1 do // Remove blanks, add leading zeroes
  begin
    if HistoryGrid.Cells[0,i] = '' then HistoryGrid.RemoveRow(i)
    else HistoryGrid.Cells[0,i] := RightStr('000000' + HistoryGrid.Cells[0,i],6);
  end;
  // Sort Table by ID (field 0)
  HistoryGrid.Sort(0,siAscending);
  Log('History Rows: '+HistoryGrid.RowCount.ToString);
  // Save history data to Local Storage
  sl := TStringList.Create;
  HistoryGrid.SaveToStrings(sl, ',', True);
//  HistoryGrid.RowCount := 1;  // Free memory??
  Log('sl Count: '+sl.Count.ToString);
  // Save Headings in Fixed Row
  TWebLocalStorage.SetValue('hl0', sl[0]);
  // Save Num History Events in reverse order
  for i := 1 to sl.Count-1 do
    TWebLocalStorage.SetValue('hl' + i.ToString, sl[sl.Count - i]);
  sl.Free;
//  await(FillHistoryDisplay);
  HistoryGrid.EndUpdate;
  Log(' ====== FetchHistory finished =========');
end;

procedure TCWRmainFrm.UpdateNewCaptures(RecordStart, RecordEnd: TDateTime);

var
  i: Integer;
  id: string;
begin
  Log(' ====== UpdateNewCaptures called =========');
  await(RefreshCSV(NewCaptures, 'cwr_newcaptures.csv','NewCaptures', id));
  Log('NewCaptures Rows: '+NewCaptures.RowCount.ToString);
  if NewCaptures.RowCount = 0 then // fnf, create new one
  begin
    NewCaptures.RowCount := 1;
    NewCaptures.ColCount := 7;
    await(CreateGoogleFile('cwr_newcaptures.csv', id));
  end
  else
    for i := Pred(NewCaptures.RowCount) downto 1 do // Remove blank rows
      if NewCaptures.Cells[0,i] = '' then NewCaptures.RemoveRow(i);
  SetNewCapturesFixedRow;
// Add the new capture to the list
  NewCaptures.RowCount := NewCaptures.RowCount + 1;
  NewCaptures.Cells[0,NewCaptures.RowCount-1] := EpgDb.FieldByName('PSIP').AsString;
  NewCaptures.Cells[1,NewCaptures.RowCount-1] := FormatDateTime('mm/dd hh:nn',RecordStart);
  NewCaptures.Cells[2,NewCaptures.RowCount-1] := FormatDateTime('mm/dd hh:nn',RecordEnd);
  NewCaptures.Cells[3,NewCaptures.RowCount-1] := ReplaceStr(EpgDb.FieldByName('Title').AsString, '&', '&&');
  NewCaptures.Cells[4,NewCaptures.RowCount-1] := EpgDb.FieldByName('SubTitle').AsString;
  NewCaptures.Cells[5,NewCaptures.RowCount-1] := EpgDb.FieldByName('Time').AsString.Split(['--'])[0]; // EPG StartTime (HTPC TZ)
  NewCaptures.Cells[6,NewCaptures.RowCount-1] := EpgDb.FieldByName('ProgramID').AsString; // Episode No.
  SaveNewCapturesFile(id);

  // ==============================
  Log('Final NewCaptures Table Rows: '+NewCaptures.RowCount.ToString);
  Log(' ====== UpdateNewCaptures finished =========');
end;

procedure TCWRmainFrm.SaveNewCapturesFile(id: string);
var data: TStrings;
  res: TJSXMLHttpRequest;
begin
  // Update the local strings
  SaveLocalStrings(NewCaptures, 'nc');
  // Update the file
  data := TStringList.Create;
  data.LineBreak := #13#10;
  NewCaptures.SaveToStrings(data, ',', True);
  console.log('id: '+id);
  console.log('data.text: ', data.Text);
  res := TAwait.ExecP<TJSXMLHttpRequest>(WEBRESTClient1.HttpRequest('PATCH','https://www.googleapis.com/upload/drive/v3/files/'+id, data.Text));
  console.log(res);
  if res.Status = 200 then
    TAwait.ExecP<TModalResult> (MessageDlgAsync('Request successfully updated.'
      + #13#13'N.B.:  NOT scheduled until CW_EPG''s next run.', mtInformation, [mbOK]))
  else
    TAwait.ExecP<TModalResult> (MessageDlgAsync('Request submission FAILED.'
      + #13#13'If this is the first failure, please retry.', mtInformation, [mbOK]));

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
