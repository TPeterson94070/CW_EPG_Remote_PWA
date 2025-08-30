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
  WEBLib.WebTools, WEBLib.Google, WEBLib.DataGrid.Common, WEBLib.DataGrid,
  WEBLib.Buttons, WEBLib.EditAutocomplete;

type
  TGridDrawState = set of (gdSelected, gdFocused, gdFixed, gdRowSelected, gdHotTrack, gdPressed);
  TCWRmainFrm = class(TWebForm)
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
  wcbGenres: TWebComboBox;
  lblEmptyEPG: TWebLabel;
  ByAll: TMenuItem;
  ByChannel: TMenuItem;
  ByGenre: TMenuItem;
  ByTitle: TMenuItem;
  wcbChannels: TWebComboBox;
    WebHTMLDiv1: TWebHTMLDiv;
    WebHTMLDiv2: TWebHTMLDiv;
    WebHTMLDiv3: TWebHTMLDiv;
    pnlFilterSelection: TWebPanel;
    lblFilterSelect: TWebLabel;
    WebHTMLDiv4: TWebHTMLDiv;
    HistoryGrid: TWebStringGrid;
    cbNumDisplayDays: TWebComboBox;
    cbNumHistList: TWebComboBox;
    btnOptOK: TWebButton;
    WIDBCDS: TWebIndexedDbClientDataset;
    btnSchdRefrsh: TWebButton;
    btnRefreshData: TWebSpeedButton;
    byType: TMenuItem;
    wcbTypes: TWebComboBox;
    weTitleSearch: TWebEdit;
    WebTimer1: TWebTimer;
    WebTimer2: TWebTimer;
    WebHTMLForm1: TWebHTMLForm;
  procedure ClearFilterLists;
  procedure SetNewCapturesFixedRow;
  procedure EPGGetCellClass(Sender: TObject; ACol, ARow: Integer;  // Lead with non-async proc to avoid mess-up on new comp add
    AField: TField; AValue: string; var AClassName: string);
  [async] procedure SaveNewCapturesFile(id: string);
  [async] procedure LoadWIDBCDS;
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
//  procedure ListingClick(Sender: TObject);
  [async] procedure HistoryClick(Sender: TObject);
  [async] procedure ScheduledClick(Sender: TObject);
  [async] procedure ViewLog1Click(Sender: TObject);
  [async] procedure Settings1Click(Sender: TObject);
  [async]
  procedure EPGClickCell(Sender: TObject; ACol, ARow: Integer);
  procedure HistoryTableGetCellClass(Sender: TObject; ACol, ARow: Integer;
    AField: TField; AValue: string; var AClassName: string);
  [async] procedure ByGenreClick(Sender: TObject);
  [async] procedure wcbGenresChange(Sender: TObject);
  [async] procedure ByTitleClick(Sender: TObject);
  [async] procedure byTypeClick(Sender: TObject);
  [async] procedure ByAllClick(Sender: TObject);
  [async] procedure ByChannelClick(Sender: TObject);
  [async] procedure wcbChannelsChange(Sender: TObject);
  [async] procedure cbNumDisplayDaysChange(Sender: TObject);
  [async] procedure NewCapturesClickCell(Sender: TObject; ACol, ARow: Integer);
  [async] procedure WIDBCDSIDBError(DataSet: TDataSet; opCode: TIndexedDbOpCode;
      errorName, errorMsg: string);
    procedure NewCapturesGetCellData(Sender: TObject; ACol, ARow: Integer;
      AField: TField; var AValue: string);
    procedure wcbGenresFocusOut(Sender: TObject);
    procedure wcbChannelsFocusOut(Sender: TObject);
  [async] procedure btnOptOKClick(Sender: TObject);
  [async] procedure btnSchdRefrshClick(Sender: TObject);
  [async] procedure btnRefreshDataClick(Sender: TObject);
    procedure wcbTypesChange(Sender: TObject);
    procedure wcbTypesFocusOut(Sender: TObject);
    procedure weTitleSearchChange(Sender: TObject);
    procedure WebTimer1Timer(Sender: TObject);
    [async] procedure WebTimer2Timer(Sender: TObject);
    procedure weTitleSearchClick(Sender: TObject);
private
  { Private declarations }
  [async] procedure LogDataRange;
  procedure ReloadSG(SG: TWebStringGrid; LSName: string);  [async]
  [async] procedure SetPage(PageNum: Integer);
  [async]
  procedure FetchCapReservations;
  [async]
  procedure FetchNewCapRequests;
  [async]
  procedure FillTable(WSG: TWebStringGrid; rs: string);
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
  [async] procedure SetupEpg;
  [async] procedure PopupFilterList(cb: TWebComboBox; fn: string);
  [async] procedure SetFilters;
  [async] procedure ShowPlsWait(PlsWaitCap: string);
  [async] procedure SetupFilterLists;
public
  { Public declarations }
end;

var
  CWRmainFrm: TCWRmainFrm;

implementation

uses
  TypInfo, System.Math, DateUtils, SchedUnit2, Details;

{$R *.dfm}

var
  ResetPrompt:      string = 'none' ;
  VisiblePanelNum:  Integer = 0;
  FirstEndDate,
  LastStartDate:    TDate;
  TotalAvailableDays: Integer;
  SearchFilter,
  BaseFilter:       string;

type ProgramTypes = (New,Rerun,Movie,Other);
const
  NUMDAYS = 'NumDisplayDays';
  NUMHIST = 'NumHistoryItems';
  EMAILADDR = 'emailAddress';
  TypeClass: array[ProgramTypes] of string = ('green','rose','goldenRod','gray');

procedure Log(const s: string); // {$IFDEF PAS2JS} async; {$ENDIF}
begin
  CWRmainFrm.WebMemo2.Lines.Add(DateTimeToStr(now) + '--' + s);
//  {$IFDEF PAS2JS} asm await sleep(10) end; {$ENDIF}
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

procedure TCWRmainFrm.wcbGenresChange(Sender: TObject);
begin
  Log('wcbGenres.Text: ' + wcbGenres.Text);
  ByGenre.Checked := wcbGenres.Text <> 'All';
  SetFilters;
end;

procedure TCWRmainFrm.wcbGenresFocusOut(Sender: TObject);
begin
  pnlFilterSelection.Hide;
  wcbGenres.Hide;
end;

procedure TCWRmainFrm.wcbTypesChange(Sender: TObject);
begin
  Log('wcbTypes.Text: ' + wcbTypes.Text);
  ByType.Checked := wcbTypes.Text <> 'All';
  SetFilters;
end;

procedure TCWRmainFrm.wcbTypesFocusOut(Sender: TObject);
begin
  pnlFilterSelection.Hide;
  wcbTypes.Hide;
end;

procedure TCWRmainFrm.WebTimer2Timer(Sender: TObject);
begin
  WebTimer2.Enabled := False;
  if not ByTitle.Checked then Exit;
  ByTitle.Checked := weTitleSearch.Text > '';
  if ByTitle.Checked then
  begin
    Log('weTitleSearch.Text: ' + weTitleSearch.Text);
    SearchFilter := weTitleSearch.Text;
  end;
  {$IfDef PAS2JS}await{$EndIf}(SetFilters);
  weTitleSearch.SetFocus;
end;

procedure TCWRmainFrm.weTitleSearchChange(Sender: TObject);
begin
  WebTimer2.Interval := 1000;
  WebTimer2.Enabled := False; // Restart timeout
  WebTimer2.Enabled := True;
end;

procedure TCWRmainFrm.weTitleSearchClick(Sender: TObject);
begin
  WebTimer2.Interval := 10000;
  WebTimer2.Enabled := True;
end;

procedure TCWRmainFrm.wcbChannelsChange(Sender: TObject);
begin
  Log('wcbChannels.Text: ' + wcbChannels.Text);
  ByChannel.Checked := wcbChannels.Text <> 'All';
  SetFilters;
end;

procedure TCWRmainFrm.wcbChannelsFocusOut(Sender: TObject);
begin
  pnlFilterSelection.Hide;
  wcbChannels.Hide;
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
  EPG.Hide;
  {$IfDef PAS2JS}await{$EndIf}(SetupWIDBCDS);
  {$IfDef PAS2JS}await{$EndIf}(RefreshListings);
  Log('========== FormCreate is finished');
end;


procedure TCWRmainFrm.WebTimer1Timer(Sender: TObject);
// The point of this timer is to disable WIDBCDS controls before the EPG is clicked
// This should defeat the long delay in Android FF in "seeing" those clicks
begin
  WebTimer1.Enabled := False;
  WIDBCDS.DisableControls;
end;

procedure TCWRmainFrm.WIDBCDSIDBError(DataSet: TDataSet;
  opCode: TIndexedDbOpCode; errorName, errorMsg: string);
begin
  TAwait.ExecP<TModalResult> (MessageDlgAsync(DataSet.Name + ' error: ' + errorName + ', msg: ' + errorMsg
    ,mtInformation, [mbOK]))
end;

procedure TCWRmainFrm.ClearFilterLists;
begin
  TLocalStorage.RemoveKey('wcbGenresItems');
  TLocalStorage.RemoveKey('wcbTitlesItems');
  TLocalStorage.RemoveKey('wcbChannelsItems');
end;

procedure TCWRmainFrm.RefreshData(Sender: TObject);
var
  id: string; {param used only by UpdateNewcaptures}
  StartT: TDateTime;
begin
  Log('======== "Refresh Data" clicked');
  WIDBCDS.Close;
  ClearFilterLists;
  {$IfDef PAS2JS}await{$EndIf}(RefreshCSV(BufferGrid, 'cwr_epg.csv','EPG', id));
  if BufferGrid.RowCount > 0 then
  begin
    Log('********* Starting timer');
    StartT := Now;
    {$IfDef PAS2JS}await{$EndIf}(LoadWIDBCDS);
    {$IfDef PAS2JS}await{$EndIf}(FetchCapReservations);
    {$IfDef PAS2JS}await{$EndIf}(FetchNewCapRequests);
    {$IfDef PAS2JS}await{$EndIf}(FetchHistory);
  end
  else
  begin
    TAwait.ExecP<TModalResult> (MessageDlgAsync('The data update failed!'#13'Please make sure that the HTPC'
      + #13' is connected to Google Drive',mtInformation, [mbOK]))
  end;
  if VisiblePanelNum <> 3 then {$IfDef PAS2JS}await{$EndIf}(ReFreshListings)
  else {$IfDef PAS2JS}await{$EndIf}(SetupEpg);
  Log('*********** Delta t (sec): ' + SecondsBetween(Now, StartT).ToString);
  Log('*********** Rate (ms/rec): ' + (MilliSecondsBetween(Now, StartT)/WIDBCDS.RecordCount).ToString);
  if pnlWaitPls.Visible then pnlWaitPls.Hide;
end;

procedure TCWRmainFrm.UpdateHistory(Sender: TObject);
begin
  {$IfDef PAS2JS}await{$EndIf}(FetchHistory);
  {$IfDef PAS2JS}await{$EndIf}(SetPage(2));
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
    {$IfDef PAS2JS}await{$EndIf}(RefreshData(Sender));
  end;
end;

procedure TCWRmainFrm.btnOptOKClick(Sender: TObject);
begin
  Log('OptOK called');
  {$IfDef PAS2JS}await{$EndIf}(ShowPlsWait('Updating Settings'));
  TWebLocalStorage.SetValue(NUMHIST, cbNumHistList.Text);
  Log('New number History Display Days: ' + cbNumHistList.Text);
  if TWebLocalStorage.GetValue(NUMDAYS) <> cbNumDisplayDays.Text then
  begin
    TWebLocalStorage.SetValue(NUMDAYS, cbNumDisplayDays.Text);
    Log('New number EPG Display Days: ' + cbNumDisplayDays.Text);
//    WIDBCDS.Close; // Needed???
    ClearFilterLists;
    {$IfDef PAS2JS}await{$EndIf}(SetupWIDBCDS);
    {$IfDef PAS2JS}await{$EndIf}(ReFreshListings);
  end
  else ByAllClick(Self);
  Log('OptOK finished');
end;

procedure TCWRmainFrm.btnRefreshDataClick(Sender: TObject);
begin
  btnRefreshData.Hide;
  // In case of a hang, allow user to show Log here
//  if TAwait.ExecP<TModalResult> (MessageDlgAsync('Do you want to switch to viewing the Log'
//    + #13'during the Data Refresh?',mtConfirmation, [mbYes,mbNo])) = mrYes then
//    {$IfDef PAS2JS}await{$EndIf}(SetPage(3));
  RefreshData(Self);
end;

procedure TCWRmainFrm.btnSchdRefrshClick(Sender: TObject);
begin
  {$IfDef PAS2JS}await{$EndIf}(FetchCapReservations);
  {$IfDef PAS2JS}await{$EndIf}(FetchNewCapRequests);
  pnlWaitPls.Hide;
end;

procedure TCWRmainFrm.ByAllClick(Sender: TObject);
//var x: string;
begin
  Log('ByAllClick called');
  ByAll.OnClick := nil;
  try
    EPG.Columns[2].Title := 'Title';
    ByGenre.Checked := False;
    ByTitle.Checked := False;
    byType.Checked := False;
    ByChannel.Checked := False;
    pnlFilterSelection.Hide;
    ByAll.Checked := True;
    {$IfDef PAS2JS}await{$EndIf}(SetPage(0));
    if WIDBCDS.Filter <> BaseFilter then
      {$IfDef PAS2JS}await{$EndIf}(SetFilters)
    else
    begin
      {$IfDef PAS2JS}await{$EndIf}(WIDBCDS.EnableControls);
      WebTimer1.Enabled := True;  // Only keep WIDBCDS controls enabled briefly
      {$IfDef PAS2JS}EPG.Row := 1{$EndIf};
//      x := EPG.Cells[3,1];
      Log('++ ^Rec EPG.Row: ' + EPG.Cells[3,1]);
      Log('++ WIDBCDS.RecNo: ' + WIDBCDS.RecNo.ToString);
    end;
  finally
    ByAll.OnClick := ByAllClick;
    Log('ByAllClick finished');
  end;
end;

procedure TCWRmainFrm.ByChannelClick(Sender: TObject);
begin
  Log('ByChannelClick called');
  ByChannel.OnClick := nil;
  try
    if ByChannel.Checked then // Toggle off this filter
    begin
      ByChannel.Checked := False;
      wcbChannels.ItemIndex := -1;
      {$IfDef PAS2JS}await{$EndIf}(SetFilters);
    end else
      {$IfDef PAS2JS}await{$EndIf}(PopupFilterList(wcbChannels, 'PSIP'));
  finally
    Log('ByChannelClick finished');
    ByChannel.OnClick := ByChannelClick;
  end;
end;

procedure TCWRmainFrm.ByGenreClick(Sender: TObject);
begin
  Log('ByGenreClick called');
  ByGenre.OnClick := nil;
  try
    if ByGenre.Checked then // Toggle off this filter
    begin
      ByGenre.Checked := False;
      wcbGenres.ItemIndex := -1;
      {$IfDef PAS2JS}await{$EndIf}(SetFilters);
    end else
      {$IfDef PAS2JS}await{$EndIf}(PopupFilterList(wcbGenres, 'genres'));
  finally
    Log('ByGenreClick finished');
    ByGenre.OnClick := ByGenreClick;
  end;
end;

procedure TCWRmainFrm.ByTitleClick(Sender: TObject);
begin
  Log('byTitleClick called');
  ByTitle.OnClick := nil;
  try
    if ByTitle.Checked then // Toggle off this filter
    begin
      ByTitle.Checked := False;
      pnlFilterSelection.Hide;
      weTitleSearch.Hide;
      {$IfDef PAS2JS}await{$EndIf}(SetFilters);
    end else
    begin
      ByTitle.Checked := True;
      wcbGenres.Hide;
      wcbChannels.Hide;
      wcbTypes.Hide;
      lblFilterSelect.Caption := 'Show Titles with:';
      pnlFilterSelection.BringToFront;
      pnlFilterSelection.Show;
      weTitleSearch.Clear;
      weTitleSearch.BringToFront;
      weTitleSearch.Show;
    end;
  finally
    ByTitle.OnClick := ByTitleClick;
    Log('byTitleClick finished');
  end;
end;

procedure TCWRmainFrm.byTypeClick(Sender: TObject);
begin
  Log('byTypeClick called');
  byType.OnClick := nil;
  try
    if byType.Checked then // Toggle off this filter
    begin
      byType.Checked := False;
      wcbTypes.ItemIndex := -1;
      {$IfDef PAS2JS}await{$EndIf}(SetFilters);
    end else
      {$IfDef PAS2JS}await{$EndIf}(PopupFilterList(wcbTypes, 'Type'));
  finally
    byType.OnClick := byTypeClick;
    Log('byTypeClick finished');
  end;
end;

procedure TCWRmainFrm.cbNumDisplayDaysChange(Sender: TObject);
begin
  // Make sure that current dataset supports the requested number
  if Trunc(LastStartDate - TTimeZone.Local.ToUniversalTime(Now)) < StrToInt(cbNumDisplayDays.Text) then
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
      {$IFDef PAS2JS} await {$ENDIF}(ShowPlsWait('Select Login Credentials'));
      TAwait.ExecP<TJSPromiseResolver> (WebRESTClient1.Authenticate);
//      pnlWaitPls.Hide;
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
        Log('File[' + i.ToString + '] name: ' + jso.GetJSONValue('name'));
        if jso.GetJSONValue('name') = TableFile then
          id := string(jso.GetJSONValue('id'));
      end;
      jso.Free;
      ja.Free;
      console.log(id);
      if id = '' then exit('');
{$IFDef PAS2JS}
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

procedure TCWRmainFrm.FillTable(WSG: TWebStringGrid; rs: string);
var
  Line: string;
  sl: TStrings;
  ReplyArray: TArray<string>;
begin
  sl := TStringList.Create;
  rs := ReplaceStr(rs, #10, ''); // dump linefeeds
  rs := ReplaceStr(rs, #160, ''); // dump &nbsp too
  ReplyArray := rs.Split([#13],TStringSplitOptions.ExcludeEmpty);
  Log('Begin extract ' + IntToStr(Length(ReplyArray)) + ' strings');
  for Line in ReplyArray do sl.Add(Line);
  WSG.LoadFromStrings(sl, ',', True);
  Log(WSG.Name+'.RowCount: ' + WSG.RowCount.ToString);
  Log('Done loading '+WSG.Name);
  sl.Free; // := nil;

end;

procedure TCWRmainFrm.RefreshCSV(WSG: TWebStringGrid; TableFile, Title: string; var id: string);
var
  Reply: string;
begin
  Log('ReFreshCSV called for ' + TableFile);
  {$IfDef PAS2JS}await{$EndIf}(ShowPlsWait('Refreshing ' + Title));
  if application.IsOnline then
  begin
    WSG.BeginUpdate;
    try
      Log('Requesting: ' + TableFile);
      try
        Reply := TAwait.ExecP<string>(GetGoogleDriveFile(TableFile, id));

        if Reply <> '' then  // Got a response
        begin
          // Reshow message in case lost during OAuth
          {$IfDef PAS2JS}await{$EndIf}(ShowPlsWait('Refreshing ' + Title));
          Log(TableFile + ' starts: ' + copy(Reply,1,50));
          FillTable(WSG, Reply);
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
  {$IfDef PAS2JS}await{$EndIf}(ShowPlsWait('Loading EPG DB'));
  if not WIDBCDS.ControlsDisabled then WIDBCDS.DisableControls;
  WIDBCDS.Filtered := False;
  Log('WIDBCDS is ' + IfThen(not WIDBCDS.Filtered, 'UN') + 'filtered');
  WIDBCDS.Close;
  TAwait.ExecP<Boolean>(WIDBCDS.OpenAsync);
  try
    if WIDBCDS.Active and (BufferGrid.RowCount > 1) then
    begin
      Log('LoadWIDBCDS, WIDBCDS.RecordCount: ' + WIDBCDS.RecordCount.ToString);
      Log('LoadWIDBCDS, Buffer Row Count: ' + BufferGrid.RowCount.ToString);
      WIDBCDS.Edit;
      {$IfDef PAS2JS}await{$EndIf}(WIDBCDS.EmptyDataSet);
      Log('LoadWIDBCDS, After EmptyDataSet CDS.RecordCount: ' + WIDBCDS.RecordCount.ToString);
      for j := 1 to BufferGrid.RowCount - 1 do
      try
        // Lose superfluous <">
        BufferGrid.Cells[0,j] := ReplaceStr(BufferGrid.Cells[0,j],'"','');
        WIDBCDS.Append;
        WIDBCDS.Fields[0].Value := j;
        for i := 1 to BufferGrid.ColCount do
          if WIDBCDS.Fields[i].DataType = ftString then
            WIDBCDS.Fields[i].Value := BufferGrid.Cells[i-1,j]
          else  // Keep UTC StartTime/EndTime strings
            if TryStrToDateTime(BufferGrid.Cells[i-1,j],t) then
              WIDBCDS.Fields[i].Value := t;
        Text := WIDBCDS.Fields[8].AsString; // i.e. ProgramID
        if Text.StartsWith('MV') then  // Movie item
          AColor := {'goldenRod'}TypeClass[Movie]
        else if Text.StartsWith('SH') then  // Generic item
          AColor := IfThen(WIDBCDS.Fields[14].AsString.Contains('"News"'),
            {'green'}TypeClass[New],  // News genre assumed "new"
            {'gray'}TypeClass[Other])   // Otherwise generic episode is "unknown time"
        else
          AColor := IfThen(WIDBCDS.Fields[10].AsString <> '',
            {'green'}TypeClass[New],  // Non-generic episode declared "new"
            {'rose'}TypeClass[Rerun]);  // Otherwise "rerun"
        WIDBCDS.Fields[15].Value := AColor;
        TAwait.ExecP<Boolean>(WIDBCDS.PostAsync);
//        if t > Now + StrToInt(cbNumDisplayDays.Text) + 1 then Break;
      except
        on E:Exception do
        begin
          Log('WIDBCDS Append Exception: ' + E.Message);
          if TAwait.ExecP<TModalResult>(MessageDlgAsync('Error: ' + E.Message
            + #13'Trying to write WIDBCDS data for record ' + j.ToString
            + #13#13'Do you want to abort updating?', mtConfirmation, [mbYes,mbNo])) = mrYes then
            Break;
        end;
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
    WebDataSource1.DataSet := WIDBCDS;
    {$IfDef PAS2JS}await{$EndIf}(LogDataRange);
    if WIDBCDS.ControlsDisabled then {$IfDef PAS2JS}await{$EndIf}(WIDBCDS.EnableControls);
      WebTimer1.Enabled := True;  // Only keep WIDBCDS controls enabled briefly
    Log('WIDBCDS Controls are ' + IfThen(WIDBCDS.ControlsDisabled,'NOT ') + 'Enabled');
    Log('WIDBCDS RecordCount: ' + WIDBCDS.RecordCount.ToString);
    Log('========= Finished LoadWIDBCDS');

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
    {$IfDef PAS2JS}await{$EndIf}(RefreshCSV(NewCaptures, 'cwr_newcaptures.csv','New Captures', id));
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
  Log('WIDBCDS.RecordCount:  ' + WIDBCDS.RecordCount.ToString);
  if WIDBCDS.RecordCount > 0 then
  begin
    if not WIDBCDS.ControlsDisabled then WIDBCDS.DisableControls;
    WIDBCDS.Filtered := False;
    WIDBCDS.First;
    FirstEndDate := WIDBCDS.{FieldByName('EndTime')}Fields[7].AsDateTime;
    Log('FirstEndDate (UTC) (Rec. ' + WIDBCDS.RecNo.ToString + '): ' + DateToStr(FirstEndDate));
    WIDBCDS.Last;
    LastStartDate := WIDBCDS.{FieldByName('StartTime')}Fields[6].AsDateTime;
    Log('LastStartDate (UTC) (Rec. ' + WIDBCDS.RecNo.ToString + '): ' + DateToStr(LastStartDate));
    Log('LastStartDate - Now: ' + Double(LastStartDate - TTimeZone.Local.ToUniversalTime(Now)).ToString);
    TotalAvailableDays := Trunc(LastStartDate - TTimeZone.Local.ToUniversalTime(Now));
  //  Log('Avail days: ' + TotalAvailableDays.ToString);
//    if WIDBCDS.ControlsDisabled then WIDBCDS.EnableControls;
//      WebTimer1.Enabled := True;  // Only keep WIDBCDS controls enabled briefly
  end else TotalAvailableDays := 0;
end;

procedure TCWRmainFrm.SetupWIDBCDS;
var
  DbField: string;
const
  DBFIELDS: array[0..14] of string = ('PSIP', 'Time', 'Title', 'SubTitle',
  'Description', 'StartTime', 'EndTime', 'programID', 'originalAirDate', 'new',
  'audioProperties', 'videoProperties', 'movieYear', 'genres', 'Class');
begin
  Log('Setting up to (re)open WIDBCDS');
  if WIDBCDS.FieldCount = 0 then
  begin
    WIDBCDS.FieldDefs.Clear;
    // add key field
    WIDBCDS.FieldDefs.Add('id', ftInteger, 0, True);
    // add normal fields
    for DbField in DBFIELDS do
    begin
      if (DbField = 'StartTime') or (DbField = 'EndTime') then
        WIDBCDS.FieldDefs.Add(DbField, ftDateTime)
      else
        WIDBCDS.FieldDefs.Add(DbField, ftString);
    end;
    TAwait.ExecP<Boolean>(WIDBCDS.OpenAsync);
  end;
  Log('WIDBCDS is ' + IfThen(not WIDBCDS.Active, 'not ')
    + 'Active and ' + IfThen(not WIDBCDS.IsEmpty, 'not ') + 'Empty');
  {$IfDef PAS2JS}await{$EndIf}(LogDataRange);
  btnRefreshData.Show;
  if TTimeZone.Local.ToUniversalTime(Now) > LastStartDate then
    TAwait.ExecP<TModalResult> (MessageDlgAsync('There are no current data!'#13'Please make sure that the HTPC'
      + #13' is connected to Google Drive',mtInformation, [mbOK]))
  else if TTimeZone.Local.ToUniversalTime(Now) - FirstEndDate > 3 then
    TAwait.ExecP<TModalResult> (MessageDlgAsync('The current dataset was fetched over 3 days ago'
      + #13'and there are only about ' + Round(LastStartDate - TTimeZone.Local.ToUniversalTime(Now)).ToString + ' days now available.'
      + #13#13'To update, please use the Refresh Data button.',mtInformation, [mbOK]))
  else btnRefreshData.Hide;
end;

procedure TCWRmainFrm.SetupEpg;
var
  FirstEndTime, LastStartTime:  TDateTime;

begin
  Log('====== SetupEpg called');
  if (WIDBCDS.RecordCount = 0) or (TotalAvailableDays < 0) then Exit;
  {$IfDef PAS2JS}await{$EndIf}(ShowPlsWait('Preparing Stored Data'));
  Log(' Finished posting "Please Wait" panel');
  FirstEndTime := TTimeZone.Local.ToUniversalTime(Now);
  LastStartTime := FirstEndTime + StrToIntDef(cbNumDisplayDays.Text,1);
  BaseFilter := 'EndTime >= ' + Double(FirstEndTime).ToString
      + ' and StartTime <= ' + Double(LastStartTime).ToString;
  Log('BaseFilter(UTC): EndTime >= ' + DateTimeToStr(FirstEndTime)
      + ' and StartTime <= ' + DateTimeToStr(LastStartTime));
//  Log(' Finished calculating BaseFilter params');
  Log(' WIDBCDS.Filtered is ' + IfThen(WIDBCDS.Filtered, 'True', 'False'));
  if WIDBCDS.Filtered then WIDBCDS.Filtered := False;
  Log(' WIDBCDS is not filtered');
  WIDBCDS.Filter := BaseFilter;
  Log(' WIDBCDS BaseFilter assigned, but not active');
//  WIDBCDS.Filtered := True;   // Don't take the time here
  EPG.Columns[0].Alignment := taCenter;
  EPG.Columns[2].Alignment := taLeftJustify;
  {$IfDef PAS2JS}await{$EndIf}(SetupFilterLists);
  if not WIDBCDS.Filtered then WIDBCDS.Filtered := True;   // Take the hit now if not before
  Log('====== SetupEpg finished');
end;

procedure TCWRmainFrm.SetupFilterLists;

var
  fn, i: Integer;
  x, y: string;
  sl: TStringList;
  cb: TWebComboBox;
begin
  Log('====== SetupFilterLists started');
  sl := TStringList.Create;
  for i := 1 to 2 do
  begin
    case i of
      1:  begin
            fn := 14;
            cb := wcbGenres;
          end;
      2:  begin
            fn := 1;
            cb := wcbChannels;
          end;
    end;
    if TLocalStorage.GetValue(cb.Name + 'Items') > '' then // Reload saved list
    begin
      cb.Items.AddStrings(TLocalStorage.GetValue(cb.Name + 'Items').Split([#10], TStringSplitOptions.ExcludeEmpty));
      Continue;
    end;
    if not WIDBCDS.ControlsDisabled then WIDBCDS.DisableControls;
    if not WIDBCDS.Filtered then WIDBCDS.Filtered := True;   // Take the hit now
    cb.ItemIndex := -1;
    cb.Items.Clear;
    Log('Adding first '+cb.Name+' Item: "All"');
    cb.Items.Add('All');
    sl.Clear;
    sl.Sorted := True;
    sl.Duplicates := dupIgnore;
    sl.BeginUpdate;
    WIDBCDS.First;
    Log('Looping over Epg for ' + cb.Name + ' Items');
    while not WIDBCDS.Eof do
    begin
      x := WIDBCDS.Fields[fn].AsString;
      if cb = wcbGenres then
      begin
        y := ReplaceStr(x, '\', ''); // Remove escape "\" char
        // Split the genres string 'xxx;yyy;zzz' into array xxx, yyy, zzz
        // ignoring JSON "punctuation" around items
        for x in y.Split([';','[',']','"',','], TStringSplitOptions.ExcludeEmpty) do
          sl.Add(x);
      end
      else sl.Add(x);
      WIDBCDS.Next;
    end;
    Log('====== Finished Epg DB scan');
    sl.EndUpdate;
    cb.BeginUpdate;
    cb.Items.AddStrings(sl);
    cb.EndUpdate;
    Log('Added ' + cb.Items.Count.ToString + ' to ' + cb.Name);
    // Save list to speed restart
    TLocalStorage.SetValue(cb.Name + 'Items', cb.Items.Text);
  end;
  sl.Free;
//  if WIDBCDS.ControlsDisabled then WIDBCDS.EnableControls;
//      WebTimer1.Enabled := True;  // Only keep WIDBCDS controls enabled briefly
  Log('====== Exiting SetupFilterLists');
end;

procedure TCWRmainFrm.PopupFilterList(cb: TWebComboBox; fn: string);
begin
  Log('====== PopupFilterList started');
  lblFilterSelect.Caption := 'Choose '
    + IfThen(fn='genres', 'Genre',
      IfThen(fn='PSIP', 'Channel',
      IfThen(fn='Title', 'Title', 'Type')));
  ByAll.Checked := False;
  wcbGenres.Hide;
  wcbChannels.Hide;
  wcbTypes.Hide;
  weTitleSearch.Hide;
  EPG.ClearSelection;
  if cb.Items.Count = 0 then Exit;  // Can happen??
//    SetupFilterLists;
  Log('====== Showing ComboBox');
  pnlFilterSelection.BringToFront;
  pnlFilterSelection.Show;
  cb.ItemIndex := -1;
  cb.BringToFront;
  cb.Show;
  {$IFDEF PAS2JS} asm await sleep(100) end; {$ENDIF}
  if VisiblePanelNum <> 0 then {$IfDef PAS2JS}await{$EndIf}(SetPage(0));
  Log('====== Exiting PopupFilterList');
end;

procedure TCWRmainFrm.SetFilters;
var
  fltr: string;
begin
  Log('====== SetFilters called');
  ByAll.Checked := not (ByChannel.Checked or ByGenre.Checked or ByTitle.Checked or byType.Checked);
  {$IfDef PAS2JS}await{$EndIf}(ShowPlsWait('Preparing ' + IfThen(ByAll.Checked, 'Un') + 'Filtered List'));
  EPG.Hide;
  EPG.BeginUpdate;
  EPG.Columns[2].Title := IfThen(ByChannel.Checked, wcbChannels.Text + ' ')
    + IfThen(byType.Checked, wcbTypes.Text + ' ')
    + IfThen(ByGenre.Checked, wcbGenres.Text + ' ') + 'Programs'
    + IfThen(ByTitle.Checked, ' w/Titles:' + QuotedStr('*' + SearchFilter + '*'));
  EPG.ColWidths[0] := IfThen(ByChannel.Checked, 0, 75);
  if not WIDBCDS.ControlsDisabled then WIDBCDS.DisableControls;
  WIDBCDS.Filtered := False;
  Log('BaseFilter: ' + BaseFilter);
  fltr := '';
  if ByGenre.Checked then fltr := fltr + ' and genres like '
    + QuotedStr('%"'+ReplaceStr(wcbGenres.Text, '/', '_')+'"%');
  if ByTitle.Checked then fltr := fltr + ' and Title like ' + QuotedStr('%' + SearchFilter + '%');
  if ByChannel.Checked then fltr := fltr + ' and PSIP = ' + QuotedStr(wcbChannels.Text);
  if ByType.Checked then fltr := fltr + ' and Class = '
    + QuotedStr(TypeClass[ProgramTypes(GetEnumValue(TypeInfo(ProgramTypes),wcbTypes.Text))]);
  if fltr>'' then Log('Epg Filter: BaseFilter + ' + fltr);
  WIDBCDS.Filter := BaseFilter + fltr;
  WIDBCDS.Filtered := True;
  {$IfDef PAS2JS}EPG.Row := 1;{$EndIf}
//  if StrToIntDef(EPG.Cells[3,1],0) > 0 then
//    WIDBCDS.RecNo := EPG.Cells[3,1].ToInteger;
  {$IfDef PAS2JS}await{$EndIf}(WIDBCDS.EnableControls);
  WebTimer1.Enabled := True;  // Only keep WIDBCDS controls enabled briefly
  EPG.EndUpdate;
  EPG.Show;
  pnlWaitPls.Hide;
  EPG.BringToFront;
  if fltr>'' then pnlFilterSelection.BringToFront;
  Log('====== SetFilters finished');
end;

procedure TCWRmainFrm.ShowPlsWait(PlsWaitCap: string);

begin
  if VisiblePanelNum <> 3 then  // Show overlay
  begin
    WebLabel1.Caption := PlsWaitCap;
    pnlWaitPls.BringToFront;
    pnlWaitPls.Show;
    {$IFDEF PAS2JS} asm await sleep(100) end; {$ENDIF}
  end
  else Log('####### ' + PlsWaitCap);   // Just make log entry
end;

procedure TCWRmainFrm.ReFreshListings;
begin
  Log(' ======== RefreshListings is called.');
  EPG.Hide;
  {$IfDef PAS2JS}await{$EndIf}(SetupEpg);
  Log('Days to Display, Available: ' + cbNumDisplayDays.Text + ', ' + TotalAvailableDays.ToString);

  if (WIDBCDS.RecordCount > 0) and (TotalAvailableDays >= 0) then
  begin
    {$IfDef PAS2JS}await{$EndIf}(ShowPlsWait('Preparing ' + Min(StrToIntDef(cbNumDisplayDays.Text, 1), TotalAvailableDays).ToString + '-day Listing.'));
    {$IfDef PAS2JS}await{$EndIf}(ByAllClick(Self));
    if not EPG.Visible then EPG.Show;
  end
  else TAwait.ExecP<TModalResult> (MessageDlgAsync('There are no current data!'
      + #13#13'To update, use the Refresh Data button.'
      + #13#13'To watch the Log, first switch to'
      + #13'View Log and then use Refresh Data.'
      + #13'(Recommended _only_ in case of severe hang issue)',mtInformation, [mbOK]));
  pnlListings.BringToFront;
  Log(' ======== RefreshListings finished');
end;

procedure TCWRmainFrm.ScheduledClick(Sender: TObject);
begin
  Log('Scheduled called');
  {$IfDef PAS2JS}await{$EndIf}(SetPage(1));
  Log('Scheduled visible');
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
  UserMsg: string;

begin
//  btnSchdRefrsh.BringToFront;
  btnSchdRefrsh.Show;
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

  if (Captures.RowCount = 2) and (Captures.Cells[25,1] = '-1') then  // Valid list, no captures, reload??
  begin
    Log('No captures listed, prompting for refresh');
    UserMsg := 'There were no scheduled items at last fetch.';
  end
  else if Captures.RowCount < 2 then // Invalid list
  begin
    Log('No fresh captures, prompting for refresh');
    UserMsg := 'Scheduled list appears to be stale.';
  end else exit;
  if TAwait.ExecP<TModalResult> (MessageDlgAsync(UserMsg
    + #13#13'Do you want to refresh?',mtConfirmation, [mbYes,mbNo]))
    = mrYes then btnSchdRefrshClick(Self);
end;

procedure TCWRmainFrm.FillHistoryDisplay;
var
  sl: TStrings;
  i: Integer;

begin
  Log('FillHistoryDisplay called');
  HistoryTable.OnGetCellClass := nil;
  sl := TStringList.Create;
  for i := 0 to Pred(StrToIntDef(cbNumHistList.Text,0)) do
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
  Log('History called');
  {$IfDef PAS2JS}await{$EndIf}(SetPage(2));
  Log('History visible');
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
  {$IfDef PAS2JS}await{$EndIf}(FillHistoryDisplay);
  Log('HistoryTable.RowCount: ' + HistoryTable.RowCount.ToString);
  if HistoryTable.RowCount <> StrToInt(cbNumHistList.Text) {+ 1} then  // may need History data
  begin
    Log('The History list is empty/incomplete. Prompt for refresh');
    if TAwait.ExecP<TModalResult> (MessageDlgAsync('The History list '
     + IfThen(HistoryTable.RowCount < 2,'is empty','may be incomplete')
      + #13#13'Do you want to refresh it now?',mtConfirmation, [mbYes,mbNo]))
      = mrYes then {$IfDef PAS2JS}await{$EndIf}(UpdateHistory(Self));
  end;
  HistoryTable.Visible := True;
end;

procedure TCWRmainFrm.SetPage(PageNum: Integer);

begin
  case PageNum of
    0: begin          {Listings page}
      pnlListings.BringToFront;
      pnlListings.Show;
    end;
    1: begin          {Captures}
      pnlCaptures.BringToFront;
      pnlCaptures.Show;
      tbCapturesShow;
    end;
    2: begin {History}
      pnlHistory.BringToFront;
      pnlHistory.Show;
      tbHistoryShow;
    end;
    3: begin  {Log}
      pnlLog.BringToFront;
      pnlLog.Show;
    end;
    4: begin {Options}
      if TWebLocalStorage.GetValue(NUMDAYS) <> '' then
        cbNumDisplayDays.ItemIndex := cbNumDisplayDays.Items.IndexOf(TWebLocalStorage.GetValue(NUMDAYS));
      if TWebLocalStorage.GetValue(NUMHIST) <> '' then
        cbNumHistList.ItemIndex := cbNumHistList.Items.IndexOf(TWebLocalStorage.GetValue(NUMHIST));
      pnlOptions.BringToFront;
      pnlOptions.Show;
    end;
  end;
  VisiblePanelNum := PageNum;
end;

procedure TCWRmainFrm.Settings1Click(Sender: TObject);
begin
  Log('Settings called');
  {$IfDef PAS2JS}await{$EndIf}(SetPage(4));
  Log('Settings visible');
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

procedure TCWRmainFrm.EPGGetCellClass(Sender: TObject; ACol,
  ARow: Integer; AField: TField; AValue: string; var AClassName: string);
{ show listings row in color coded for type based on current IDB record }
begin
  if ARow = 0 then exit;
//  if EPG.Cells[3,ARow] = WIDBCDS.Fields[0].AsString then  {ids=}
//    AClassName := EPG.Cells[4,ARow] // WIDBCDS.Fields[15].AsString
//  else AClassName := 'white'; // Should not occur!
    AClassName := {EPG.Cells[4,ARow] //} WIDBCDS.Fields[15].AsString
end;

procedure TCWRmainFrm.EPGClickCell(Sender: TObject; ACol, ARow: Integer);
var
  DetailsFrm: TDetailsFrm;
  SchedFrm: TSchedForm;
  x: TArray<string>;
  CurrentID, WIDBCDSID: string;
  CurrentRec: Integer;

begin
  EPG.OnClickCell := nil;
  {$IFDEF PAS2JS} asm await sleep(10) end; {$ENDIF}
  try
    CurrentID := EPG.Cells[3,ARow];
    Log('========== EPGClickCell() called from Row ' + ARow.ToString);
    WIDBCDSID := WIDBCDS.Fields[0].AsString;
    CurrentRec := WIDBCDS.RecNo;
//    WIDBCDS.Locate('id',CurrentID,[]);
//    CurrentRec := WIDBCDS.RecNo;
    // Quit Combobox if still open
    if pnlFilterSelection.Visible then pnlFilterSelection.Hide;
    // Speed up form opening
    if not WIDBCDS.ControlsDisabled then {$IfDef PAS2JS}await{$EndIf}(WIDBCDS.DisableControls);
    Log('========== finished WIDBCDS.DisableControls ');
    WIDBCDS.RecNo := CurrentID.ToInteger;
    Log('========== Set WIDBCDS RecNo: ' + CurrentID);
    try
      EPG.Hide;
      DetailsFrm := TDetailsFrm.Create(Self);
      Log('========== finished TDetailsFrm.Create(nil) ');
      DetailsFrm.Popup := True;
      DetailsFrm.Border := fbSingle;
      Log('========== starting DetailsFrm.Load ');
      // load file HTML template + controls
      try
        TAwait.ExecP<TDetailsFrm>(DetailsFrm.Load);
        Log('========== finished DetailsFrm.Load ');
      except
        on E:Exception do
        Log('Exception from DetailsFrm.Load: ' + E.Message);
      end;
      // init controls after loading
      DetailsFrm.mmTitle.Text := WIDBCDS.Fields[3].AsString;
      DetailsFrm.mmSubTitle.Text := WIDBCDS.Fields[4].AsString;
      DetailsFrm.lb11Time.Caption := WIDBCDS.Fields[2].AsString;
      DetailsFrm.lb10Channel.Caption := WIDBCDS.Fields[1].AsString;
      x := WIDBCDS.Fields[9].AsString.Split(['-']);                 // Parse 1st-air date
      DetailsFrm.lb09OrigDate.Caption := IfThen(Length(x) = 3,      // Have 1st-air date
        '1st Aired ' + x[1] + '/' + x[2] + '/' + RightStr(x[0],2),  // Use 1st-air date
        IfThen(WIDBCDS.Fields[13].AsString > '',                    // Check Movie year
        'Movie Yr ' + WIDBCDS.Fields[13].AsString,''));             // Use Movie year or nil
      SetLabelStyle(DetailsFrm.lb02New, WIDBCDS.Fields[10].AsString <> '');
      SetLabelStyle(DetailsFrm.lb08CC, WIDBCDS.Fields[11].AsString.Contains('cc'));
      SetLabelStyle(DetailsFrm.lb03Stereo, WIDBCDS.Fields[11].AsString.Contains('stereo'));
      SetLabelStyle(DetailsFrm.lb07Dolby, WIDBCDS.Fields[11].AsString.Contains('DD'));
      DetailsFrm.lb04HD.Caption := 'SD';
      if WIDBCDS.Fields[12].AsString > '' then
        DetailsFrm.lb04HD.Caption := WIDBCDS.Fields[12].AsString.Split(['["HD ','"'])[1];
      SetLabelStyle(DetailsFrm.lb04HD, DetailsFrm.lb04HD.Caption <> 'SD');
      DetailsFrm.mmDescription.Text := WIDBCDS.Fields[5].AsString;
    // execute form and wait for close
      Log('========== starting DetailsFrm.Execute ');
      pnlWaitPls.Hide;
      TAwait.ExecP<TModalResult>(DetailsFrm.Execute);
      Log('========== finished DetailsFrm.Execute ');
      if DetailsFrm.ModalResult = mrOk then
      begin
        SchedFrm := TSchedForm.Create(Self);
        Log('========== finished TSchedForm.Create(nil)');
        SchedFrm.Caption := 'Schedule Capture Event';
        SchedFrm.Popup := True;
        SchedFrm.Border := fbSingle;
        try
          // load file HTML template + controls
          TAwait.ExecP<TSchedForm>(SchedFrm.Load());
          Log('========== finished SchedFrm.Load() ');
        // init controls after loading
          SchedFrm.mmTitle.Text := DetailsFrm.mmTitle.Text;
          SchedFrm.mmSubTitle.Text := DetailsFrm.mmSubTitle.Text;
          SchedFrm.mmDescription.Text := DetailsFrm.mmDescription.Text;
          SchedFrm.lblChannelValue.Caption := DetailsFrm.lb10Channel.Caption;
          // N.B.:  WIDBCDS DateTimes are UTC, but we need to specify HTPC's TZ for capture!
          // So we decode the times from the "Time" field (format: mm/yy HH:nn--HH:nn)
          x := string(DetailsFrm.lb11Time.Caption).Split([' ','--']);
          SchedFrm.lblStartDateValue.Caption := x[0];
          SchedFrm.tpStartTime.DateTime := StrToDateTime(x[0] + ' ' + x[1]);
          SchedFrm.tpEndTime.DateTime := StrToDateTime(x[0] + ' ' + x[2]);
          if SchedFrm.tpEndTime.DateTime < SchedFrm.tpStartTime.DateTime then  // wrapped midnight
            SchedFrm.tpEndTime.DateTime := SchedFrm.tpEndTime.DateTime + 1;
          Log('Finished setting up new form');
          // execute form and wait for close
          TAwait.ExecP<TModalResult>(SchedFrm.Execute);
          Log('========== finished SchedFrm.Execute ');
          if SchedFrm.ModalResult = mrOk then
          begin
            {$IfDef PAS2JS}await{$EndIf}(ShowPlsWait('Saving Capture Request.'));
            {$IfDef PAS2JS}await{$EndIf} (UpdateNewCaptures(SchedFrm.tpStartTime.DateTime, SchedFrm.tpEndTime.DateTime));
          end;
        finally
          Log('========== EPGClickCell() Finished with Schedule form');
          SchedFrm.Free;
        end;
      end;
    finally
      Log('========== EPGClickCell() Finished with Details form');
      DetailsFrm.Free;
    end;
    {$IfDef PAS2JS}await{$EndIf}(ShowPlsWait('Refreshing List'));
    Log('========== EPGClickCell() showing ''Refreshing List');
  //  {$IfDef PAS2JS}await{$EndIf}(WIDBCDS.EnableControls);
//      WebTimer1.Enabled := True;  // Only keep WIDBCDS controls enabled briefly
  //  {$IfDef PAS2JS}await{$EndIf}(EPG.Show);
  finally
    EPG.OnClickCell := EPGClickCell;
    Log('========== EPGClickCell() finished');
    pnlWaitPls.Hide;
  end;
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
  {$IfDef PAS2JS}await{$EndIf}(RefreshCSV(Captures, 'cwr_captures.csv', 'Scheduled', id));
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
  {$IfDef PAS2JS}await{$EndIf}(RefreshCSV(NewCaptures, 'cwr_newcaptures.csv', 'New Captures', id));
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
  {$IfDef PAS2JS}await{$EndIf}(RefreshCSV(HistoryGrid, 'cwr_history.csv','History', id));
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
//  {$IfDef PAS2JS}await{$EndIf}(FillHistoryDisplay);
  HistoryGrid.EndUpdate;
  Log(' ====== FetchHistory finished =========');
end;

procedure TCWRmainFrm.UpdateNewCaptures(RecordStart, RecordEnd: TDateTime);

var
  i: Integer;
  id: string;
begin
  Log(' ====== UpdateNewCaptures called =========');
  {$IfDef PAS2JS}await{$EndIf}(RefreshCSV(NewCaptures, 'cwr_newcaptures.csv','New Captures', id));
  Log('NewCaptures Rows: '+NewCaptures.RowCount.ToString);
  if NewCaptures.RowCount = 0 then // fnf, create new one
  begin
    NewCaptures.RowCount := 1;
    NewCaptures.ColCount := 7;
    {$IfDef PAS2JS}await{$EndIf}(CreateGoogleFile('cwr_newcaptures.csv', id));
  end
  else
    for i := Pred(NewCaptures.RowCount) downto 1 do // Remove blank rows
      if NewCaptures.Cells[0,i] = '' then NewCaptures.RemoveRow(i);
  SetNewCapturesFixedRow;
// Add the new capture to the list
  NewCaptures.RowCount := NewCaptures.RowCount + 1;
  NewCaptures.Cells[0,NewCaptures.RowCount-1] := WIDBCDS.FieldByName('PSIP').AsString;
  NewCaptures.Cells[1,NewCaptures.RowCount-1] := FormatDateTime('mm/dd hh:nn',RecordStart);
  NewCaptures.Cells[2,NewCaptures.RowCount-1] := FormatDateTime('mm/dd hh:nn',RecordEnd);
  NewCaptures.Cells[3,NewCaptures.RowCount-1] := ReplaceStr(WIDBCDS.FieldByName('Title').AsString, '&', '&&');
  NewCaptures.Cells[4,NewCaptures.RowCount-1] := WIDBCDS.FieldByName('SubTitle').AsString;
  NewCaptures.Cells[5,NewCaptures.RowCount-1] := WIDBCDS.FieldByName('Time').AsString.Split(['--'])[0]; // EPG StartTime (HTPC TZ)
  NewCaptures.Cells[6,NewCaptures.RowCount-1] := WIDBCDS.FieldByName('ProgramID').AsString; // Episode No.
  {$IfDef PAS2JS}await{$EndIf}(SaveNewCapturesFile(id));

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
  {$IfDef PAS2JS}console.log('data.text: ', data.Text);{$EndIf}
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
  Log('ViewLog called');
  {$IfDef PAS2JS}await{$EndIf}(SetPage(3));
  Log('Log visible');
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
