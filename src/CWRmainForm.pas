unit CWRmainForm;

                       { DONE : search function for Listings and History via Web(DB)DataGrids }
                       { DONE : Add item deletion to Scheduled list }
                       { DONE : Add one-off scheduling of Listing item }
interface

uses
//  JSONDataSet,
  System.SysUtils, System.Classes, WEBLib.Graphics, WEBLib.Forms, Vcl.StdCtrls,
  WEBLib.StdCtrls, Vcl.Controls, WEBLib.Dialogs, Vcl.Imaging.pngimage,
  WEBLib.ExtCtrls, WEBLib.Controls, Web, JS, WebLib.DB, WEBLib.IndexedDb,
  Vcl.Menus, WEBLib.Menus, WEBLib.ComCtrls, WEBLib.Grids, DB, Vcl.Grids,
  System.StrUtils, WEBLib.DBCtrls, WEBLib.FlexControls, WEBLib.WebCtrls,
  WEBLib.REST, Types, WEBLib.Storage, WEBLib.CDS, WEBLib.Auth, WEBLib.JSON,
  WEBLib.WebTools, WEBLib.Google, WEBLib.DataGrid.Common, libDataGrid, WEBLib.DB.DataGrid, WEBLib.DataGrid,
  WEBLib.Buttons, WEBLib.EditAutocomplete, WEBLib.DataGrid.Options, jsdelphisystem;

type
  TGridDrawState = set of (gdSelected, gdFocused, gdFixed, gdRowSelected, gdHotTrack, gdPressed);
  TCWRmainFrm = class(TWebForm)
  WebMemo2: TWebMemo;
  CapturesWSG: TWebStringGrid;
  pnlCaptures: TWebPanel;
  pnlHistory: TWebPanel;
  pnlLog: TWebPanel;
  pnlWaitPls: TWebPanel;
  WebRESTClient1: TWebRESTClient;
  pnlListings: TWebPanel;
  NewCapturesWSG: TWebStringGrid;
  pnlMenu: TWebPanel;        // Container for MainMenu
  WebMainMenu1: TWebMainMenu;
  Scheduled: TMenuItem;
  History: TMenuItem;
  Options: TMenuItem;
  RefreshEPG: TMenuItem;
  ChangeHTPC1: TMenuItem;
  ViewLog1: TMenuItem;
  Settings1: TMenuItem;
  EPG : TWebDBDataGrid;
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
  wcbChannels: TWebComboBox;
    WebHTMLDiv1: TWebHTMLDiv;
    WebHTMLDiv2: TWebHTMLDiv;
    WebHTMLDiv3: TWebHTMLDiv;
    pnlFilterSelection: TWebPanel;
    lblFilterSelect: TWebLabel;
    WebHTMLDiv4: TWebHTMLDiv;
    WIDBCDS: TWebIndexedDbClientDataset;
    btnSchdRefrsh: TWebButton;
    btnRefreshData: TWebSpeedButton;
    byType: TMenuItem;
    wcbTypes: TWebComboBox;
    WebTimer1: TWebTimer;
    HistoryWDG: TWebDataGrid;
    BufferWDG: TWebDataGrid;
  procedure SetCapturesFormats;
  procedure EPGGetCellClass(Sender: TObject; ACol, ARow: Integer;  // Lead with non-async proc to avoid mess-up on new comp add
    AField: TField; AValue: string; var AClassName: string);
  [async] procedure SaveNewCapturesFile(id: string);
  [async] procedure LoadWIDBCDS;
  [async] procedure RefreshData(Sender: TObject);
  [async] procedure WebFormCreate(Sender: TObject);
  [async] procedure CapturesShow;
  procedure AllCapsGridGetCellData(Sender: TObject; ACol, ARow: Integer;
    AField: TField; var AValue: string);
  [async] procedure HistoryClick(Sender: TObject);
  [async]
  procedure UpdateHistory(Sender: TObject);
  [async]
  procedure ChangeTargetHTPC(Sender: TObject);
  [async] procedure ScheduledClick(Sender: TObject);
  [async] procedure ViewLog1Click(Sender: TObject);
  [async] procedure Settings1Click(Sender: TObject);
  [async] procedure ByGenreClick(Sender: TObject);
  [async] procedure wcbGenresChange(Sender: TObject);
  [async] procedure HandleClick(MenuItem: TMenuItem; cbItems: TWebComboBox; ItemName:
      string);
  [async] procedure byTypeClick(Sender: TObject);
  [async] procedure ByAllClick(Sender: TObject);
  [async] procedure ByChannelClick(Sender: TObject);
  [async] procedure wcbChannelsChange(Sender: TObject);
  [async] procedure NewCapturesWSGClickCell(Sender: TObject; ACol, ARow: Integer);
  [async] procedure WIDBCDSIDBError(DataSet: TDataSet; opCode: TIndexedDbOpCode;
      errorName, errorMsg: string);
    procedure NewCapturesWSGGetCellData(Sender: TObject; ACol, ARow: Integer;
      AField: TField; var AValue: string);
    procedure wcbGenresFocusOut(Sender: TObject);
    procedure wcbChannelsFocusOut(Sender: TObject);
  [async] procedure btnSchdRefrshClick(Sender: TObject);
  [async] procedure btnRefreshDataClick(Sender: TObject);
    procedure wcbTypesChange(Sender: TObject);
    procedure wcbTypesFocusOut(Sender: TObject);
    procedure WebTimer1Timer(Sender: TObject);
    procedure CapturesWSGGetCellData(Sender: TObject; ACol, ARow: Integer;
      AField: TField; var AValue: string);
    [async] procedure CapturesWSGClickCell(Sender: TObject; ACol, ARow: Integer);
  procedure EPGCellClickedEvent(Event: TJSCellClickedEvent);
  procedure EPGCellDoubleClickedEvent(Event: TJSCellDoubleClickedEvent);
  function EPGGetRowClass(Params: TJSGetRowClassParams): TJSValue;
    procedure SwipeDownRefresh(Enabled: Boolean);
  function EPGColumn_PSIPGetCellStyle(Params: TJSCellClassParams): TJSValue;
  procedure HistoryWDGCellClickedEvent(Event: TJSCellClickedEvent);
  procedure HistoryWDGCellDoubleClickedEvent(Event: TJSCellDoubleClickedEvent);
  function WDGColumn_TDateTimeValueFormatter(Value: TJSValue): TJSValue;
  function HistoryWDGGetRowClass(Params: TJSGetRowClassParams): TJSValue;
  [async] procedure WebRESTClient1Error(Sender: TObject; ARequest:
      TJSXMLHttpRequestRecord; Event: TJSEventRecord; var Handled: Boolean);
  procedure WebRESTClient1RequestResponse(Sender: TObject; ARequest:
      TJSXMLHttpRequestRecord; AResponse: string);
  procedure WIDBCDSAfterClose(DataSet: TDataSet);
  procedure WIDBCDSBeforeClose(DataSet: TDataSet);
private
  { Private declarations }
  [async] procedure LogDataRange;
  [async] procedure LoadSG(var SG: TWebStringGrid; LSName: string);
  [async] procedure SetPage(PageNum: Integer);
  [async]
  procedure FetchCapReservations;
  [async]
  procedure FetchNewCapRequests;
  [async] procedure FillWSG(var WSG: TWebStringGrid; rs: string);
  procedure FillBufferWDG;
  procedure FillHistoryWDG(var WDG: TWebDataGrid; rs: string);
  [async]
  procedure RefreshCSV(TableFile, Title: string; var id: string);
  [async]
  procedure FetchHistory;
  [async]
  procedure ReFreshListings;
  [async]
  procedure HistoryShow;
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
  [async] procedure ShowItemDetails(ItemNo: Integer; DoCapture: Boolean = True);
  [async] procedure ShowHistoryWDGDetails(ItemNo: Integer);
public
  { Public declarations }
end;
type
  TDataGridBaseHelper = class helper for TDataGridBase
  public
    procedure SetCell(ACol, ARow: Integer; const AValue: string);
    function GetCell(ACol, ARow: Integer): string;
  end;

var
  CWRmainFrm: TCWRmainFrm;

implementation

uses
  TypInfo, System.Math, System.Variants, DateUtils, SchedUnit2, Details;

{$R *.dfm}
{$I AppKey.inc}
var
  ResetPrompt:      string = 'none' ;
  BaseFilter:       string;
  VisiblePageNum:  Integer = 0;
  FirstEndDate,
  LastStartDate:    TDate;
  TotalAvailableDays: Integer;
  CSVString:        string;

type ProgramTypes = (New,Rerun,Movie,Other);
const
  EMAILADDR = 'emailAddress';
  CSV_EPG = 'cwr_epg.csv';
  CSV_CAPTURES = 'cwr_captures.csv';
  CSV_NEWCAPTURES = 'cwr_newcaptures.csv';
  CSV_HISTORY = 'cwr_history.csv';
  TypeClass: array[ProgramTypes] of string = ('green','rose','goldenRod','gray');

{ TDataGridBaseHelper }

procedure TDataGridBaseHelper.SetCell(ACol, ARow: Integer; const AValue: string);
begin
  Cells[ARow, ACol] := AValue;
end;

function TDataGridBaseHelper.GetCell(ACol, ARow: Integer): string;
begin
  Result := Cells[ARow, ACol];
end;

procedure Log(const s: string);
begin
  CWRmainFrm.WebMemo2.Lines.Add(DateTimeToStr(now) + '--' + s);
  console.log(DateTimeToStr(now) + '--' + s);
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
//  LastID := NUMIDS.ToString;  // Make sure it's not '' for filter
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
  {$IFDef PAS2JS} await {$ENDIF}(ShowPlsWait('Preparing Database'));
  // Log Version Information
  Log('Running version:  ' + AppVersion);
  Log('App is ' + IfThen(not Application.IsOnline, 'NOT ') + 'online');
  WebRESTClient1.ReadTokens; // retrieve previous access token
  WebMainMenu1.Appearance.HamburgerMenu.Caption := '['+TWebLocalStorage.GetValue(EMAILADDR)+']';
  Font.Height := -17;
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

procedure TCWRmainFrm.RefreshData(Sender: TObject);
var
  id: string; {param used only by UpdateNewcaptures}
  StartT: TDateTime;
  TotalEPGRecordCount: Integer;
begin
  Log('########### "Refresh Data" clicked ###########');
  WIDBCDS.Close;
  {$IfDef PAS2JS}await{$EndIf}(RefreshCSV(CSV_EPG,'EPG', id));
  if Length(CSVString) > 0 then
  begin
    Log('********* Starting timer');
    StartT := Now;
    {$IfDef PAS2JS}await{$EndIf}(LoadWIDBCDS);
    // Save unfiltered record count (now that TMS Web Core honors filtering)
    if WIDBCDS.Filtered then WIDBCDS.Filtered := False;
    TotalEPGRecordCount := WIDBCDS.RecordCount;
    {$IfDef PAS2JS}await{$EndIf}(FetchCapReservations);
    {$IfDef PAS2JS}await{$EndIf}(FetchNewCapRequests);
    {$IfDef PAS2JS}await{$EndIf}(FetchHistory);
  end
  else
  begin
    TAwait.ExecP<TModalResult> (MessageDlgAsync('The data update failed!'#13'Please make sure that the HTPC'
      + #13' is connected to Google Drive',mtInformation, [mbOK]))
  end;
  if VisiblePageNum <> 3 then {$IfDef PAS2JS}await{$EndIf}(ReFreshListings)
  else {$IfDef PAS2JS}await{$EndIf}(SetupEpg);
  Log('*********** Delta t (sec): ' + SecondsBetween(Now, StartT).ToString);
  Log('*********** Rate (ms/rec): ' + (MilliSecondsBetween(Now, StartT)/TotalEPGRecordCount).ToString);
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

procedure TCWRmainFrm.btnRefreshDataClick(Sender: TObject);
begin
  btnRefreshData.Hide;
  RefreshData(Self);
end;

procedure TCWRmainFrm.btnSchdRefrshClick(Sender: TObject);
begin
  {$IfDef PAS2JS}await{$EndIf}(FetchCapReservations);
  {$IfDef PAS2JS}await{$EndIf}(FetchNewCapRequests);
  {$IfDef PAS2JS}await{$EndIf}(LoadSG(CapturesWSG, CSV_CAPTURES));
  {$IfDef PAS2JS}await{$EndIf}(LoadSG(NewCapturesWSG, CSV_NEWCAPTURES));
  SetCapturesFormats;
  pnlWaitPls.Hide;
end;

procedure TCWRmainFrm.ByAllClick(Sender: TObject);
begin
  Log('ByAllClick called');
  ByAll.OnClick := nil;
  try
    ByGenre.Checked := False;
    byType.Checked := False;
    ByChannel.Checked := False;
    pnlFilterSelection.Hide;
    {$IfDef PAS2JS}await{$EndIf}(SetPage(0));
    {$IfDef PAS2JS}await{$EndIf}(SetFilters)
  finally
    ByAll.OnClick := ByAllClick;
    Log('ByAllClick finished');
  end;
end;

procedure TCWRmainFrm.HandleClick(MenuItem: TMenuItem; cbItems: TWebComboBox; ItemName: string);
begin
  Log(MenuItem.Name + ' called');
//  MenuItem.OnClick := nil;
  try
    if MenuItem.Checked and (VisiblePageNum = 0) then // Toggle off this filter
    begin
      MenuItem.Checked := False;
      cbItems.ItemIndex := -1;
      {$IfDef PAS2JS}await{$EndIf}
      (SetFilters);
    end
    else if not MenuItem.Checked then
      {$IfDef PAS2JS}await{$EndIf}
      (PopupFilterList(cbItems, ItemName))
    else SetPage(0);
  finally
    Log(MenuItem.Name + ' finished');
//    MenuItem.OnClick := MenuItemOnClickProcedure;
  end;
end;

procedure TCWRmainFrm.ByChannelClick(Sender: TObject);
begin
  HandleClick(ByChannel, wcbChannels, 'PSIP');
//    ByChannel.OnClick := ByChannelClick;
end;

procedure TCWRmainFrm.ByGenreClick(Sender: TObject);
begin
  HandleClick(ByGenre, wcbGenres, 'genres');
//    ByGenre.OnClick := ByGenreClick;
end;

procedure TCWRmainFrm.byTypeClick(Sender: TObject);
begin
  HandleClick(byType, wcbTypes, 'Type');
//    byType.OnClick := byTypeClick;
end;

procedure TCWRmainFrm.CapturesWSGClickCell(Sender: TObject; ACol, ARow: Integer);
var
  st: TDateTime;
  SaveFilter: string;
  SaveFilterState: Boolean;

begin
  CapturesWSG.OnClickCell := nil;
  {$IFDEF PAS2JS} asm await sleep(10) end; {$ENDIF}
  SaveFilter := WIDBCDS.Filter;
  SaveFilterState := WIDBCDS.Filtered;
  try
    Log('========== CapturesClickCell() called from Row ' + ARow.ToString);
    // Find Capture Item in EPG
    st := TTimeZone.Local.ToUniversalTime(StrToDateTimeDef(CapturesWSG.Cells[3,ARow] + ' ' + CapturesWSG.Cells[4,ARow],Now));
    WIDBCDS.Filtered := False;
    WIDBCDS.Filter := 'Title like ' + QuotedStr(CapturesWSG.Cells[8,ARow])
      + ' and StartTime > ' + Double(st-15*OneMinute).ToString   // Allow for generous padding
      + ' and StartTime < ' + Double(st+OneMinute).ToString;
    WIDBCDS.Filtered := True;
    WIDBCDS.FindFirst;
    {$IFDEF PAS2JS} await {$ENDIF}(ShowItemDetails(WIDBCDS.RecNo, False)); // Call w/invisible Add Capture button
  finally
    WIDBCDS.Filtered := False;
    WIDBCDS.Filter := SaveFilter;
    WIDBCDS.Filtered := SaveFilterState;
    CapturesWSG.OnClickCell := CapturesWSGClickCell;
    Log('========== EPGClickCell() finished');
  end;
end;

procedure TCWRmainFrm.CapturesWSGGetCellData(Sender: TObject; ACol, ARow: Integer;
  AField: TField; var AValue: string);
begin
  if ARow = 0 then Exit;
  if ACol = 2 then AValue := Copy(AValue,4,10);
  if ACol = 3 then AValue := IfThen(AValue > '', FormatDateTime('mm/dd', StrToDateDef(AValue, 0)));
end;

function TCWRmainFrm.GetGoogleDriveFile(TableFile: string; var id: string): string;
var
  q{, AResponse}: string;
  rq: TJSXMLHttpRequest;
  jso: TJSONObject;
  ja: TJSONArray;
  i: integer;

  [async]
  function TryLogIn: TJSXMLHttpRequest;
  begin
//    console.log('AccessToken: ' + WebRESTClient1.AccessToken);
    if WebRESTClient1.AccessToken = '' then ResetPrompt := 'select_account';
    Log('Trying login, ResetPrompt: ' + ResetPrompt);
    WebRESTClient1.App.Key := CLIENT_APP_KEY;
//    if window.location.href.Contains('?') then  // browser has "parameters" that need to be removed
    begin
      WebRESTClient1.App.CallbackURL := LeftStr(window.location.href, {Pred(}Pos({'?'}'.html',window.location.href)+5);
      Log('window.location.href: ' + window.location.href);
    end
//    else WEBRESTClient1.App.CallBackURL := window.location.href
    ;
    Log('WEBRESTClient1.App.CallBackURL: ' + WEBRESTClient1.App.CallbackURL);
    WEBRESTClient1.App.AuthURL := 'https://accounts.google.com/o/oauth2/v2/auth'
      + '?client_id=' + WebRESTCLient1.App.Key
      + '&include_granted_scopes'
      + '&scope=https://www.googleapis.com/auth/drive'
      + '&state=bf'
      + '&response_type=token'
      + '&redirect_uri=' + WEBRESTClient1.App.CallbackURL
      + '&prompt=' + ResetPrompt;
    if (WebRESTClient1.AccessToken = '') or (ResetPrompt <> 'none') then
    begin
      Log('Performing OAuth');
      {$IFDef PAS2JS} await {$ENDIF}(ShowPlsWait('Select Login Credentials'));
      try
//        TAwait.ExecP<TModalResult> (MessageDlgAsync('Set to call authenticate', mtInformation, [mbOK]));
        TAwait.ExecP<TJSPromiseResolver> (WebRESTClient1.Authenticate);
        Log('Returned from OAuth Authenticate');
        if WebRESTClient1.PersistTokens.Enabled then WebRESTClient1.WriteTokens;
        Log('PersistTokens.Enabled: ' + WebRESTClient1.PersistTokens.Enabled.ToString);
//        TAwait.ExecP<TModalResult> (MessageDlgAsync('Returned from authentication', mtInformation, [mbOK]));
      except
        on E:Exception do
        begin
          Log('******* Client.Authenticate exception: ' + E.Message);
          TAwait.ExecP<TModalResult> (MessageDlgAsync('Unexpected authentication error: ' + E.Message, mtInformation, [mbOK]));
        end;
      end;
      {$IFDef PAS2JS} await {$ENDIF}(ShowPlsWait('Refreshing Selected DB'));
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
      q :='name = ''' + TableFile + ''' and trashed = false';
      rq := TAwait.ExecP<TJSXMLHttpRequest> (WEBRESTClient1.HttpRequest('GET',
        'https://www.googleapis.com/drive/v3/files?q='+WEBRestClient1.URLEncode(q)));
    end;
    ResetPrompt := 'none';
    Result := rq;
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
      {console.}log('Bad Request Status: ' +  rq.Status.ToString);
      WebRESTClient1.ClearTokens;
      {console.}log('Retrying login');
      rq := TAwait.ExecP<TJSXMLHttpRequest> (TryLogIn);
      {console.}log('Retry Request Status: ' +  rq.Status.ToString);
      if rq.Status <> 200 then exit('');   // Return null string on failure
    end;
//    AResponse := rq.responseText;
    console.log(rq.responseText);

    jso := TJSONObject(TJSONObject.ParseJSONValue(rq.responseText));

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
      {console.}log('File ID: <' + id + '>');
      if id = '' then exit('');  // Return null string on no ID

      rq := TAwait.ExecP<TJSXMLHttpRequest> (WebRESTClient1.httprequest('GET',
        'https://www.googleapis.com/drive/v3/files/'+id+'?alt=media').catch(
        function(AValue: JSValue): JSValue
        begin
          {console.}log('error here' + toInteger(AValue).ToString);
        end));

      if Assigned(rq) then Result := rq.responseText;
    end;
  end;
end;

procedure TCWRmainFrm.FillBufferWDG;
begin
  Log('FillBufferWDG called');
  Log('CSVString length: ' + IntToStr(Length(CSVstring)));
  BufferWDG.Clear;
  if CSVstring > '' then
  begin
    BufferWDG.BeginUpdate;
    BufferWDG.ColumnDefs.Clear;
    BufferWDG.LoadFromCSVString(CSVString, ',', '"', True);
    BufferWDG.EndUpdate;
  end;
  Log('Done loading BufferWDG');

end;

procedure TCWRmainFrm.FillHistoryWDG(var WDG: TWebDataGrid; rs: string);
// Could be named FillWDG if broaden to Captures & NewCaptures. TBD
var
  HeaderRow: string;
  i, HeaderRowLength: Integer;
  HeaderItems: TArray<string>;
begin
  Log('FillHistoryWDG called for ' + WDG.Name);
  // Fetch string from local storage if not cwr_epg.csv
  if rs <> CSV_EPG then CSVstring := TLocalStorage.GetValue(rs);
  Log(rs + ' length: ' + IntToStr(Length(CSVstring)));
  WDG.Clear;
  if CSVstring > '' then
  begin
    WDG.BeginUpdate;
    WDG.ColumnDefs.Clear;
    // Need to treat Header row explicitly to define columns
    HeaderRowLength := Pos(#13, CSVString) - 1;
    HeaderRow := Copy(CSVString, 1, HeaderRowLength);
    HeaderItems := HeaderRow.Split([',']);
    for i := 0 to Pred(Length(HeaderItems)) do
    begin
      WDG.ColumnDefs.Insert(i);
      WDG.ColumnDefs[i].HeaderName := ReplaceStr(HeaderItems[i], '"', '');
      WDG.ColumnDefs[i].CellDataType := cdtText;
      WDG.ColumnDefs[i].Field := ReplaceStr(HeaderItems[i], '"', '');
      WDG.ColumnDefs[i].Visible := i in [7, 8, 12, 13]; // i.e., Channel, StartTime, Title, SubTitle
      WDG.ColumnDefs[i].Sortable := i in [7, 8, 12, 13];
      WDG.ColumnDefs[i].Filter := i in [7, 8, 12, 13];
      WDG.ColumnDefs[i].SuppressMovable := True;
      case i of
        7: WDG.ColumnDefs[i].Width := 120;
        8: WDG.ColumnDefs[i].Width := 150;
        12: WDG.ColumnDefs[i].Width := 200;
        13: WDG.ColumnDefs[i].Width := 300;
      end;
    end;

    // Could tell LoadFromCSVString to ignore first row, but since we've already parsed it....
    WDG.LoadFromCSVString(Copy(CSVString,HeaderRowLength + 1), ',', '"', False);
    // dump empty rows (add iff needed)
    WDG.RowHeight := 19;
    WDG.Font.Height := 18;

    // Convert Col 8 string (StartTime) to TDateTime double
    WDG.ColumnDefs[8].CellDataType := cdtNumber;
    for i := 0 to Pred(WDG.RowCount) do
      WDG.Floats[i,8] := StrToDateTimeDef(WDG.Cells[i,8],0);
    WDG.ColumnDefs[8].ValueFormatter := WDGColumn_TDateTimeValueFormatter;
    WDG.ColumnDefs[8].Filter := False;
    WDG.EndUpdate;
  end;
  Log(WDG.Name+'.RowCount: ' + WDG.RowCount.ToString);
  Log('Done loading ' + WDG.Name);

end;

procedure TCWRmainFrm.FillWSG(var WSG: TWebStringGrid; rs: string);
var
  Line: string;
  sl: TStrings;
  ReplyArray: TArray<string>;
begin
  Log('FillWSG called for ' + WSG.Name);
  // Fetch string from local storage if not cwr_epg.csv
  if rs <> CSV_EPG then CSVstring := TLocalStorage.GetValue(rs);
  Log(rs + ' length: ' + IntToStr(Length(CSVstring)));
  if CSVstring > '' then
  begin
    sl := TStringList.Create;
    ReplyArray := CSVstring.Split([#13#10],TStringSplitOptions.ExcludeEmpty);
    Log('Begin extract ' + IntToStr(Length(ReplyArray)) + ' strings');
    for Line in ReplyArray do sl.Add(Line);
    WSG.BeginUpdate;
    WSG.LoadFromStrings(sl, ',', True);
    // dump empty rows
    while WSG.Cells[0,Pred(WSG.RowCount)] = '' do WSG.RowCount := Pred(WSG.RowCount);
    WSG.EndUpdate;
  end
  else WSG.RowCount := 0;
  Log(WSG.Name+'.RowCount: ' + WSG.RowCount.ToString);
  Log('Done loading '+WSG.Name);
  sl.Free; // := nil;

end;

procedure TCWRmainFrm.RefreshCSV(TableFile, Title: string; var id: string);
var
  Reply: string;
begin
  Log('ReFreshCSV called for ' + TableFile);
  {$IfDef PAS2JS}await{$EndIf}(ShowPlsWait('Refreshing ' + Title));
  if application.IsOnline then
  begin
    Log('Requesting: ' + TableFile);
    try
      Reply := TAwait.ExecP<string>(GetGoogleDriveFile(TableFile, id));
      if Reply > '' then  // Got a response
      begin
        // Reshow message in case lost during OAuth
        {$IfDef PAS2JS}await{$EndIf}(ShowPlsWait('Refreshing ' + Title));
        Log(TableFile + ' starts: ' + copy(Reply,1,50));
      end
      else
        Log(TableFile + ' fetch failed.');
      // cw_epg.csv can be >2MB and Safari cannot tolerate that in LocalStorage
      if TableFile = CSV_EPG then // park result in global variable
        CSVString := Reply
      else // Save the csv (or '') as string in local storage
        TLocalStorage.SetValue(TableFile, Reply);
      Log('ReFreshCSV, ' + TableFile + ' Length: ' + IntToStr(Length(Reply)));
    except
      on E:Exception do
      begin
        Log('HttpRequest Exception: ' + E.Message);
        TAwait.ExecP<TModalResult> (MessageDlgAsync('Cannot refresh EPG data while CW_EPG_Remote is offline', mtInformation, [mbOK]));
      end;
    end;
  end
  else
  begin
    TAwait.ExecP<TModalResult> (MessageDlgAsync('Cannot refresh EPG data while CW_EPG_Remote is offline', mtInformation, [mbOK]));
    Log('No LAN connection');
  end;
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
//  if not WIDBCDS.ControlsDisabled then WIDBCDS.DisableControls;
//  WIDBCDS.Filtered := False;
//  Log('WIDBCDS is ' + IfThen(not WIDBCDS.Filtered, 'UN') + 'filtered');
  if WIDBCDS.Active then WIDBCDS.Close;
  TLocalStorage.RemoveKey('wcbGenresItems');  // Dump any saved values
  TLocalStorage.RemoveKey('wcbChannelsItems');
//  TAwait.ExecP<Boolean>(WIDBCDS.OpenAsync);
  try
    FillBufferWDG;
    Log('BufferWDG RowCount: ' + BufferWDG.RowCount.ToString);
    Log('BufferWDG ColCount: ' + BufferWDG.ColumnDefs.Count.ToString);
    if {WIDBCDS.Active and} (BufferWDG.RowCount > 1) then
    begin
      Log('LoadWIDBCDS, Opening WIDBCDS');
      TAwait.ExecP<Boolean>(WIDBCDS.OpenAsync);
      Log('LoadWIDBCDS, WIDBCDS.RecordCount: ' + WIDBCDS.RecordCount.ToString);
      Log('LoadWIDBCDS, Buffer Row Count: ' + BufferWDG.RowCount.ToString);
      if not WIDBCDS.ControlsDisabled then WIDBCDS.DisableControls;
      WIDBCDS.Filtered := False;
      Log('WIDBCDS is ' + IfThen(not WIDBCDS.Filtered, 'UN') + 'filtered');
      if WIDBCDS.RecordCount > 0 then
      begin
        WIDBCDS.Edit;
        {$IfDef PAS2JS}await{$EndIf}(WIDBCDS.EmptyDataSet);
        Log('LoadWIDBCDS, After EmptyDataSet CDS.RecordCount: ' + WIDBCDS.RecordCount.ToString);
        WebDataSource1.DataSet := WIDBCDS;
        Log('LoadWIDBCDS, Reconnected DataSource');
      end;
      for j := 1 to BufferWDG.RowCount - 1 do
      try
        WIDBCDS.Append;
        WIDBCDS.Fields[0].Value := j;
        for i := 1 to BufferWDG.ColumnDefs.Count do
          if WIDBCDS.Fields[i].DataType = ftString then
            WIDBCDS.Fields[i].Value := BufferWDG.Cells[j,i-1]
          else  // Keep UTC StartTime/EndTime strings
            if TryStrToDateTime(BufferWDG.Cells[j,i-1],t) then
              WIDBCDS.Fields[i].Value := t
            else WIDBCDS.Fields[i].Value := 0;
        Text := BufferWDG.Cells[j,7]; // i.e. ProgramID
        if Text.StartsWith('MV') then  // Movie item
          AColor := {'goldenRod'}TypeClass[Movie]
        else if Text.StartsWith('SH') then  // Generic item
          AColor := IfThen(BufferWDG.Cells[j,13].Contains('"News"'),
            {'green'}TypeClass[New],  // News genre assumed "new"
            {'gray'}TypeClass[Other])   // Otherwise generic episode is "unknown time"
        else
          AColor := IfThen(BufferWDG.Cells[j,9] <> '',
            {'green'}TypeClass[New],  // Non-generic episode declared "new"
            {'rose'}TypeClass[Rerun]);  // Otherwise "rerun"
        WIDBCDS.Fields[15].Value := AColor;
        TAwait.ExecP<Boolean>(WIDBCDS.PostAsync);
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
        + IfThen(BufferWDG.RowCount < 2, ' BufferWDG empty'));
    end;
  finally
    Log('WIDBCDS is ' + IfThen(WIDBCDS.Active, 'NOT ') + 'closed');
    {$IfDef PAS2JS}await{$EndIf}(LogDataRange);
    Log('WIDBCDS Controls are ' + IfThen(WIDBCDS.ControlsDisabled,'NOT ') + 'Enabled');
    Log('WIDBCDS RecordCount: ' + WIDBCDS.RecordCount.ToString);
    Log('========= Finished LoadWIDBCDS');

  end;
end;

procedure TCWRmainFrm.NewCapturesWSGClickCell(Sender: TObject; ACol,
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
    PSIP := NewCapturesWSG.Cells[0,ARow];
    RecordStart := StrToDateTimeDef(NewCapturesWSG.Cells[1,ARow],Now);
    RecordEnd := StrToDateTimeDef(NewCapturesWSG.Cells[2,ARow],Now);
    Title := NewCapturesWSG.Cells[3,ARow];
    ProgID := NewCapturesWSG.Cells[6,ARow];
    NewCapturesWSG.BeginUpdate;
    {$IfDef PAS2JS}await{$EndIf}(RefreshCSV(CSV_NEWCAPTURES,'New CapturesWSG', id));
    {$IfDef PAS2JS}await{$EndIf}(FillWSG(NewCapturesWSG, CSV_NEWCAPTURES));
    Log('NewCapturesWSG Rows: '+NewCapturesWSG.RowCount.ToString);
    if NewCapturesWSG.RowCount > 1 then // file exists, find matching row
      for i := 1 to Pred(NewCapturesWSG.RowCount) do
      begin
        if not SameText(PSIP, NewCapturesWSG.Cells[0,i]) then continue;
        if not SameText(Title, NewCapturesWSG.Cells[3,i]) then continue;
        if not SameText(ProgID, NewCapturesWSG.Cells[6,i]) then continue;
        if not SameDateTime(RecordStart, StrToDateTimeDef(NewCapturesWSG.Cells[1,i],Now)) then continue;
        if not SameDateTime(RecordEnd, StrToDateTimeDef(NewCapturesWSG.Cells[2,i],Now)) then continue;
        NewCapturesWSG.RemoveRow(i);
        // Update file
        SaveNewCapturesFile(id);
        Break;
      end;
    NewCapturesWSG.EndUpdate;
    pnlWaitPls.Hide;
  end;
end;

procedure TCWRmainFrm.NewCapturesWSGGetCellData(Sender: TObject; ACol,
  ARow: Integer; AField: TField; var AValue: string);
begin
  if ARow > 0 then
    if ACol in [1,2] then AValue := FormatDateTime('mm/dd HH:nn', StrToDateTimeDef(AValue, Now));
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
  Log('Notify user if refresh WIDBCDS needed');
  btnRefreshData.Show;
  if TTimeZone.Local.ToUniversalTime(Now) > LastStartDate then
    TAwait.ExecP<TModalResult> (MessageDlgAsync('There are no current data!'#13'Please make sure that the HTPC'
      + #13' is connected to Google Drive',mtInformation, [mbOK]))
  else if TTimeZone.Local.ToUniversalTime(Now) - FirstEndDate > 3 then
    TAwait.ExecP<TModalResult> (MessageDlgAsync('The current dataset was fetched over 3 days ago'
      + #13'and there are only about ' + Round(LastStartDate - TTimeZone.Local.ToUniversalTime(Now)).ToString + ' days now available.'
      + #13#13'To update, please use the Refresh Data button.',mtInformation, [mbOK]))
  else btnRefreshData.Hide;
  Log('Finished opening WIDBCDS');
end;

procedure TCWRmainFrm.SetupEpg;
var
  FirstEndTime: TDateTime;

begin
  Log('====== SetupEpg called');
  if (WIDBCDS.RecordCount = 0) or (TotalAvailableDays < 0) then Exit;
  {$IfDef PAS2JS}await{$EndIf}(ShowPlsWait('Preparing Stored Data'));
  if WIDBCDS.Filtered then WIDBCDS.Filtered := False;
  FirstEndTime := TTimeZone.Local.ToUniversalTime(Now);
  Log('First record EndTime (UTC) >= ' + DateTimeToStr(FirstEndTime));
  BaseFilter := 'EndTime >= ' + Double(FirstEndTime).ToString;
  WIDBCDS.Filter := BaseFilter;
  Log(' WIDBCDS BaseFilter [' + BaseFilter + '] assigned, but not active');
  {$IfDef PAS2JS}await{$EndIf}(SetupFilterLists);
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
      Continue;  // Skip looping
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
  if cb.Items.Count = 0 then Exit;  // Can happen??
//    SetupFilterLists;
  Log('====== Showing ComboBox');
  pnlFilterSelection.BringToFront;
  pnlFilterSelection.Show;
  cb.ItemIndex := -1;
  cb.BringToFront;
  cb.Show;
  {$IFDEF PAS2JS} asm await sleep(100) end; {$ENDIF}
  if VisiblePageNum <> 0 then {$IfDef PAS2JS}await{$EndIf}(SetPage(0));
  Log('====== Exiting PopupFilterList');
end;

procedure TCWRmainFrm.SetFilters;
var
  i: Integer;
  fltr: string;
begin
  Log('====== SetFilters called');
  ByAll.Checked := not (ByChannel.Checked or ByGenre.Checked or byType.Checked);
  if not pnlWaitPls.Visible then
    {$IfDef PAS2JS}await{$EndIf}(ShowPlsWait('Preparing ' + IfThen(ByAll.Checked, 'Un') + 'Filtered List'));
  EPG.BeginUpdate;
//  EPG.ColumnDefs.ClearFilters; {NOT WORKING}
  for i := 0 to Pred(EPG.ColumnDefs.Count) do
    EPG.ColumnDefs[i].ClearFilter;
  EPG.ColumnDefs[2].HeaderName := IfThen(ByChannel.Checked, wcbChannels.Text)
    + IfThen(byType.Checked, ' "' + wcbTypes.Text + '"')
    + IfThen(ByGenre.Checked, ' ' + wcbGenres.Text)
    + ' Programs';
  EPG.ColumnDefs[0].Visible := not ByChannel.Checked;
  EPG.ColumnDefs[0].Width := 100;
  EPG.ColumnDefs[1].Width := 140;
  EPG.ColumnDefs[2].Width := 300;
  EPG.RowHeight := 18;
  EPG.Font.Height := -17;
  if not WIDBCDS.ControlsDisabled then WIDBCDS.DisableControls;
  WIDBCDS.Filtered := False;
  Log('BaseFilter: ' + BaseFilter);
  fltr := '';
  if ByGenre.Checked then
//   fltr := fltr + ' and genres like ' + QuotedStr('%"'+ReplaceStr(wcbGenres.Text, '/', '_')+'"%');
    EPG.ColumnDefs.FindColumn('genres').ApplyFilter(TDGFilterType.gftText, TDGFilterOperation.foContains, ReplaceStr(wcbGenres.Text, '/', '_'));
//  if ByTitle.Checked then {Superseded by EPG UI filtering}
//    fltr := fltr + ' and Title like ' + QuotedStr('%' + SearchFilter + '%');
//   EPG.ColumnDefs.FindColumn('Title').ApplyFilter(TDGFilterType.gftText, TDGFilterOperation.foContains, SearchFilter);
  if ByChannel.Checked then
//    fltr := fltr + ' and PSIP = ' + QuotedStr(wcbChannels.Text);
    EPG.ColumnDefs[0]{.FindColumn('PSIP')}.ApplyFilter(TDGFilterType.gftText, TDGFilterOperation.foEqual, Trim(wcbChannels.Text));
  if ByType.Checked then
//    fltr := fltr + ' and Class = ' + QuotedStr(TypeClass[ProgramTypes(GetEnumValue(TypeInfo(ProgramTypes),wcbTypes.Text))]);
    EPG.ColumnDefs.FindColumn('Class').ApplyFilter(TDGFilterType.gftText, TDGFilterOperation.foContains, TypeClass[ProgramTypes(GetEnumValue(TypeInfo(ProgramTypes),wcbTypes.Text))]);

  Log('Epg Filter: BaseFilter + ' + fltr);
  WIDBCDS.Filter := BaseFilter + fltr;
  WIDBCDS.Filtered := True;
  {$IfDef PAS2JS}await{$EndIf}(WIDBCDS.EnableControls);
  WebTimer1.Enabled := True;  // Only keep WIDBCDS controls enabled briefly
  EPG.EndUpdate;
  WIDBCDS.First;
  pnlWaitPls.Hide;
  pnlFilterSelection.Hide;
  Log('====== SetFilters finished');
end;

procedure TCWRmainFrm.ShowPlsWait(PlsWaitCap: string);

begin
  if VisiblePageNum <> 3 then  // Show overlay
  begin
    WebLabel1.Caption := PlsWaitCap;
    pnlWaitPls.BringToFront;
    pnlWaitPls.Show;
    {$IFDEF PAS2JS} asm await sleep(100) end; {$ENDIF}
  end;
  {else }Log('### Showing panel ### ' + PlsWaitCap);   // make log entry
end;

procedure TCWRmainFrm.ReFreshListings;
begin
  Log(' ======== RefreshListings is called.');
  EPG.Hide;
  {$IfDef PAS2JS}await{$EndIf}(SetupEpg);
//  Log('Days to Display, Available: ' + cbNumDisplayDays.Text + ', ' + TotalAvailableDays.ToString);

  if (WIDBCDS.RecordCount > 0) and (TotalAvailableDays >= 0) then
  begin
//    {$IfDef PAS2JS}await{$EndIf}(ShowPlsWait('Preparing ' + Min(StrToIntDef(cbNumDisplayDays.Text, 1), TotalAvailableDays).ToString + '-day Listing.'));
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


procedure TCWRmainFrm.LoadSG(var SG: TWebStringGrid; LSName: string);
var i: Integer;
    st, et: TDateTime;
begin
  {$IfDef PAS2JS}await{$EndIf}(FillWSG(SG, LSName));
  if (SG.RowCount > 1) then  // have stored value(s)
  begin
    // Discard stale entries (End DateTime < now)
    for i := SG.RowCount-1 downto 1 do
      if SG.Cells[3,i] > '' then // not null row
      begin
        if SG = CapturesWSG then
        begin
          st := StrToDateTimeDef(SG.Cells[3,i] + ' ' + SG.Cells[4,i], 0);
          et := StrToDateTimeDef(SG.Cells[3,i] + ' ' + SG.Cells[5,i], 0);
        end
        else
        begin
          st := StrToDateTimeDef(SG.Cells[1,i], 0);
          et := StrToDateTimeDef(SG.Cells[2,i], 0);
        end;
        if et < st then et := et + 1;     // wraps midnight
        if et < now then
        begin
          Log('Removing stale entry, endtime: ' + DateTimeToStr(et));
          SG.RemoveRow(i);
        end;
      end;
  end;
end;

procedure TCWRmainFrm.SetCapturesFormats;
const
  HEADINGS: array [0..6] of string = ('Ch Name','RecordStart','RecordEnd','Title','SubTitle','StartTime','ProgramID');
  WIDTHS: array [0..6] of Integer =  (       75,           95,         95,    150,       400,          0,         0 );
var i: Integer;
begin
  for i := 0 to NewCapturesWSG.ColCount-1 do
  begin
    NewCapturesWSG.Cells[i,0] := HEADINGS[i];
    NewCapturesWSG.ColWidths[i] := WIDTHS[i];
  end;
  for i := 0 to CapturesWSG.ColCount-1 do CapturesWSG.ColWidths[i] := 0;
  if CapturesWSG.ColCount >= 9 then  // I.e., skip if FNF
  begin
    CapturesWSG.ColWidths[1] := 80;  // Computer
    CapturesWSG.ColWidths[2] := 100; // Tuner
    CapturesWSG.ColWidths[3] := 65; // Date
    CapturesWSG.ColWidths[4] := 45; // Start
    CapturesWSG.ColWidths[5] := 45; // End
    CapturesWSG.ColWidths[6] := 70; // Channel
    CapturesWSG.ColWidths[8] := CapturesWSG.ClientWidth; // Title
    for i := 1 to 6 do CapturesWSG.ColAlignments[i] := taCenter;
  end;
end;

procedure TCWRmainFrm.CapturesShow;
var
  UserMsg: string;

begin
  btnSchdRefrsh.Show;
  {$IfDef PAS2JS}await{$EndIf}(LoadSG(CapturesWSG, CSV_CAPTURES));
  {$IfDef PAS2JS}await{$EndIf}(LoadSG(NewCapturesWSG, CSV_NEWCAPTURES));
  SetCapturesFormats;
  Log('CapturesWSG.RowCount after stale check: ' + CapturesWSG.RowCount.ToString);

  if (CapturesWSG.RowCount = 2) and (CapturesWSG.Cells[25,1] = '-1') then  // Valid list w/no CapturesWSG, reload??
  begin
    Log('No CapturesWSG listed, prompting for refresh');
    UserMsg := 'There were no scheduled items at last fetch.';
  end
  else if CapturesWSG.RowCount < 2 then // Invalid list
  begin
    Log('No fresh CapturesWSG, prompting for refresh');
    UserMsg := 'Scheduled list appears to be stale.';
  end else exit;
  if TAwait.ExecP<TModalResult> (MessageDlgAsync(UserMsg
    + #13#13'Do you want to refresh?',mtConfirmation, [mbYes,mbNo]))
    = mrYes then btnSchdRefrshClick(Self);
end;

procedure TCWRmainFrm.HistoryClick(Sender: TObject);
begin
  Log('History called');
  {$IfDef PAS2JS}await{$EndIf}(SetPage(2));
  Log('History visible');
end;

procedure TCWRmainFrm.HistoryWDGCellClickedEvent(Event: TJSCellClickedEvent);
begin
  Log('========== HistoryWDGCellClickedEvent() called from Row ' + toInteger(Event.RowIndex).ToString);
  ShowHistoryWDGDetails(toInteger(Event.RowIndex));
  Log('========== HistoryWDGCellClickedEvent() finished');
end;

procedure TCWRmainFrm.HistoryWDGCellDoubleClickedEvent(Event: TJSCellDoubleClickedEvent);
begin
  Log('========== HistoryWDGCellDoubleClickedEvent() called from Row ' + toInteger(Event.RowIndex).ToString);
  ShowHistoryWDGDetails(toInteger(Event.RowIndex));
  Log('========== HistoryWDGCellDoubleClickedEvent() finished');
end;

function TCWRmainFrm.WDGColumn_TDateTimeValueFormatter(Value: TJSValue): TJSValue;
var ADateTime: string;
begin
  DateTimeToString(ADateTime, 'mm/dd/yy HH:nn', double(Value));
  Result := ADateTime;
end;

function TCWRmainFrm.HistoryWDGGetRowClass(Params: TJSGetRowClassParams): TJSValue;
begin
  case HistoryWDG.Cells[toInteger(Params.RowIndex),10][1] of
    'E': Result := 'greenBGolive';         // Regular Episode
    'S': Result := 'grayBGolive';          // Generic Show
    'M': Result := 'yellowBGolive';     // Movie
  else
    Result := 'white';              // Huh?
  end;
end;

procedure TCWRmainFrm.HistoryShow;
begin
  HistoryWDG.Hide;
  FillHistoryWDG(HistoryWDG, CSV_HISTORY);
  HistoryWDG.Show;
end;

procedure TCWRmainFrm.SetPage(PageNum: Integer);

begin
  EPG.Visible := PageNum = 0;
  HistoryWDG.Visible := PageNum = 2;
  case PageNum of
    0: begin          {Listings page}
      pnlListings.BringToFront;
      pnlListings.Show;
    end;
    1: begin          {CapturesWSG}
      pnlCaptures.BringToFront;
      pnlCaptures.Show;
      CapturesShow;
    end;
    2: begin {History}
      pnlHistory.BringToFront;
      pnlHistory.Show;
      HistoryShow;
    end;
    3: begin  {Log}
      pnlLog.BringToFront;
      pnlLog.Show;
    end;
  end;
  VisiblePageNum := PageNum;
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
  AClassName := WIDBCDS.Fields[15].AsString
end;

procedure TCWRmainFrm.ShowHistoryWDGDetails(ItemNo: Integer);
var
  DetailsFrm: TDetailsFrm;
  x: TArray<string>;
begin
  try
    DetailsFrm := TDetailsFrm.Create(Self);
    Log('========== finished TDetailsFrm.Create(Self) ');
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
    DetailsFrm.Color := clWebWheat;
    DetailsFrm.mmTitle.Color := clWebChocolate;
    DetailsFrm.mmSubTitle.Color := clWebChocolate;
    DetailsFrm.mmDescription.Color := clWebChocolate;
    DetailsFrm.lblTitle.Color := clWebWheat;
    DetailsFrm.lblSubTitle.Color := clWebWheat;
    DetailsFrm.lblDescription.Color := clWebWheat;
    // init controls after loading
    DetailsFrm.mmTitle.Text := HistoryWDG.GetCell(12,ItemNo);
    DetailsFrm.mmSubTitle.Text := HistoryWDG.GetCell(13,ItemNo);
    DetailsFrm.lb11Time.Caption := FormatDateTime('mm/dd/yy H:nn', StrToFloat(HistoryWDG.GetCell(8,ItemNo)))
       +  FormatDateTime(' -- H:nn', StrToDateTime(HistoryWDG.GetCell(9,ItemNo)));
    DetailsFrm.lb10Channel.Caption := HistoryWDG.GetCell(7,ItemNo);
    x := HistoryWDG.GetCell(15,ItemNo).Split(['/']);              // Parse 1st-air date
    DetailsFrm.lb09OrigDate.Caption := IfThen(Length(x) = 3,      // Have mm/dd/yyyy
      '1st Aired ' + x[1] + '/' + x[2] + '/' + RightStr(x[0],2),
      IfThen((Length(x) = 1) and (x[0] > ''),                                       // Have yyyymmdd format
      '1st Aired ' + copy(x[0],5,2) + '/' + copy(x[0],7,2) + '/' + copy(x[0],3,2),
      IfThen(HistoryWDG.GetCell(22,ItemNo) > '',                  // Check Movie year
      'Movie Yr ' + HistoryWDG.GetCell(22,ItemNo),'')));          // Use Movie year or nil
    DetailsFrm.lb02New.Caption := HistoryWDG.GetCell(19,ItemNo);
    SetLabelStyle(DetailsFrm.lb08CC, HistoryWDG.GetCell(18,ItemNo).Contains('T'));
    SetLabelStyle(DetailsFrm.lb03Stereo, HistoryWDG.GetCell(17,ItemNo).Contains('T'));
    SetLabelStyle(DetailsFrm.lb07Dolby, HistoryWDG.GetCell(20,ItemNo).Contains('T'));
    DetailsFrm.lb04HD.Caption := IfThen(HistoryWDG.GetCell(16,ItemNo).Contains('T'), 'HD', 'SD');
    SetLabelStyle(DetailsFrm.lb04HD, DetailsFrm.lb04HD.Caption <> 'SD');
    DetailsFrm.mmDescription.Text := HistoryWDG.GetCell(14,ItemNo)
      + IfThen(HistoryWDG.GetCell(28,ItemNo) > '', #13#13'Actors:  ' + ReplaceStr(
        {Copy(}HistoryWDG.GetCell(28,ItemNo){,1,Length(HistoryWDG.GetCell(28,ItemNo))-1)}
        ,';',', '));
    // No capture requests
    DetailsFrm.btnAddCap.Visible := False;
    // execute form and wait for close
    Log('========== starting DetailsFrm.Execute ');
    TAwait.ExecP<TModalResult>(DetailsFrm.Execute);
    Log('========== finished DetailsFrm.Execute ');
  finally
    Log('========== EPGClickCell() Finished with Details form');
    DetailsFrm.Free;
  end;
end;


procedure TCWRmainFrm.ShowItemDetails(ItemNo: Integer; DoCapture: Boolean = True);
var
  DetailsFrm: TDetailsFrm;
  SchedFrm: TSchedForm;
  x: TArray<string>;
begin
  // Speed up form opening
  if not WIDBCDS.ControlsDisabled then {$IfDef PAS2JS}await{$EndIf}(WIDBCDS.DisableControls);
  Log('========== finished WIDBCDS.DisableControls ');
  WIDBCDS.RecNo := ItemNo;
  Log('========== Set WIDBCDS RecNo: ' + ItemNo.ToString);
  try
    DetailsFrm := TDetailsFrm.Create(Self);
    Log('========== finished TDetailsFrm.Create(Self) ');
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
      IfThen(WIDBCDS.Fields[8].AsString.StartsWith('MV'),         // Check Movie year
      'Movie Yr ' + WIDBCDS.Fields[13].AsString,''));             // Use Movie year or nil
    DetailsFrm.lb02New.Show;
    SetLabelStyle(DetailsFrm.lb02New, WIDBCDS.Fields[10].AsString <> '');
    SetLabelStyle(DetailsFrm.lb08CC, WIDBCDS.Fields[11].AsString.Contains('cc'));
    SetLabelStyle(DetailsFrm.lb03Stereo, WIDBCDS.Fields[11].AsString.Contains('stereo'));
    SetLabelStyle(DetailsFrm.lb07Dolby, WIDBCDS.Fields[11].AsString.Contains('DD'));
    DetailsFrm.lb04HD.Caption := 'SD';
    if WIDBCDS.Fields[12].AsString > '' then
      DetailsFrm.lb04HD.Caption := WIDBCDS.Fields[12].AsString.Split(['["HD ','"'])[1];
    SetLabelStyle(DetailsFrm.lb04HD, DetailsFrm.lb04HD.Caption <> 'SD');
    DetailsFrm.mmDescription.Text := WIDBCDS.Fields[5].AsString;
    // Allow capture request only for EPG
    DetailsFrm.btnAddCap.Visible := DoCapture;
    // execute form and wait for close
    Log('========== starting DetailsFrm.Execute ');
    TAwait.ExecP<TModalResult>(DetailsFrm.Execute);
    Log('========== finished DetailsFrm.Execute ');
    if DetailsFrm.ModalResult = mrOk then  // Only poss if DoCapture=True
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
        SchedFrm.tpStartTime.DateTime := StrToDateTimeDef(x[0] + ' ' + x[1], 0);
        SchedFrm.tpEndTime.DateTime := StrToDateTimeDef(x[0] + ' ' + x[2], 0);
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
          pnlWaitPls.Hide;
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
end;

procedure TCWRmainFrm.FetchCapReservations;  // Fetch CW_EPG-saved file

var
  id: string;
begin
  Log(' ====== FetchCapReservations called =========');
    {$IfDef PAS2JS}await{$EndIf}(RefreshCSV(CSV_CAPTURES, 'Scheduled', id));
    Log(' ====== FetchCapReservations finished =========');
end;

procedure TCWRmainFrm.FetchNewCapRequests;  // Fetch CW_EPG-saved file

var
  id: string;
begin
  Log(' ====== FetchNewCapRequests called =========');
    {$IfDef PAS2JS}await{$EndIf}(RefreshCSV(CSV_NEWCAPTURES, 'New CapturesWSG', id));
    Log(' ====== FetchNewCapRequests finished =========');
end;

procedure TCWRmainFrm.FetchHistory;

var
  id: string;
begin
  Log(' ====== FetchHistory called =========');
    {$IfDef PAS2JS}await{$EndIf}(RefreshCSV(CSV_HISTORY,'History', id));
  Log(' ====== FetchHistory finished =========');
end;

procedure TCWRmainFrm.UpdateNewCaptures(RecordStart, RecordEnd: TDateTime);

var
  i: Integer;
  id: string;
begin
  Log(' ====== UpdateNewCaptures called =========');
  {$IfDef PAS2JS}await{$EndIf}(RefreshCSV(CSV_NEWCAPTURES,'New CapturesWSG', id));
  {$IfDef PAS2JS}await{$EndIf}(FillWSG(NewCapturesWSG, CSV_NEWCAPTURES));
  Log('NewCapturesWSG Rows: '+NewCapturesWSG.RowCount.ToString);
  if NewCapturesWSG.RowCount = 0 then // fnf, create new one
  begin
    NewCapturesWSG.RowCount := 1;
    NewCapturesWSG.ColCount := 7;
    {$IfDef PAS2JS}await{$EndIf}(CreateGoogleFile(CSV_NEWCAPTURES, id));
  end
  else
    for i := Pred(NewCapturesWSG.RowCount) downto 1 do // Remove blank rows
      if NewCapturesWSG.Cells[0,i] = '' then NewCapturesWSG.RemoveRow(i);
  SetCapturesFormats;
// Add the new capture to the list
  NewCapturesWSG.RowCount := NewCapturesWSG.RowCount + 1;
  NewCapturesWSG.Cells[0,NewCapturesWSG.RowCount-1] := WIDBCDS.FieldByName('PSIP').AsString;
  NewCapturesWSG.Cells[1,NewCapturesWSG.RowCount-1] := FormatDateTime('mm/dd hh:nn',RecordStart);
  NewCapturesWSG.Cells[2,NewCapturesWSG.RowCount-1] := FormatDateTime('mm/dd hh:nn',RecordEnd);
  NewCapturesWSG.Cells[3,NewCapturesWSG.RowCount-1] := WIDBCDS.FieldByName('Title').AsString;
  NewCapturesWSG.Cells[4,NewCapturesWSG.RowCount-1] := WIDBCDS.FieldByName('SubTitle').AsString;
  NewCapturesWSG.Cells[5,NewCapturesWSG.RowCount-1] := WIDBCDS.FieldByName('Time').AsString.Split(['--'])[0]; // EPG StartTime (HTPC TZ)
  NewCapturesWSG.Cells[6,NewCapturesWSG.RowCount-1] := WIDBCDS.FieldByName('ProgramID').AsString; // Episode No.
  {$IfDef PAS2JS}await{$EndIf}(SaveNewCapturesFile(id));

  // ==============================
  Log('Final NewCapturesWSG Table Rows: '+NewCapturesWSG.RowCount.ToString);
  Log(' ====== UpdateNewCaptures finished =========');
end;

procedure TCWRmainFrm.SaveNewCapturesFile(id: string);
var data: TStrings;
  res: TJSXMLHttpRequest;
begin
  // Update the file
  data := TStringList.Create;
  data.LineBreak := #13#10;
  NewCapturesWSG.SaveToStrings(data, ',', True);
  console.log('id: '+id);
  {$IfDef PAS2JS}console.log('data.text: ', data.Text);{$EndIf}
  res := TAwait.ExecP<TJSXMLHttpRequest>(WEBRESTClient1.HttpRequest('PATCH','https://www.googleapis.com/upload/drive/v3/files/'+id, data.Text));
  console.log(res);
  if res.Status = 200 then
  begin
    TAwait.ExecP<TModalResult> (MessageDlgAsync('Request successfully updated.'
      + #13#13'N.B.:  NOT scheduled until CW_EPG''s next run.', mtInformation, [mbOK]));
    TLocalStorage.SetValue(CSV_NEWCAPTURES, data.Text);
  end
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
      '{"name":"'+ FName + '", "description":"New CapturesWSG CSV list"}'));

  end;
end;

function TCWRmainFrm.EPGColumn_PSIPGetCellStyle(Params: TJSCellClassParams): TJSValue;
begin
  Result := JS.New(['textAlign', 'center']);
end;

function TCWRmainFrm.EPGGetRowClass(Params: TJSGetRowClassParams): TJSValue;
begin
    Result := EPG.Cells[toInteger(Params.RowIndex),3];
end;

procedure TCWRmainFrm.EPGCellClickedEvent(Event: TJSCellClickedEvent);
begin
  Log('========== EPGCellClickedEvent() called from Row ' + toInteger(Event.RowIndex).ToString);
  // Quit Combobox if still open
  if pnlFilterSelection.Visible then pnlFilterSelection.Hide;
  EPG.SetSelectedRow(toInteger(Event.RowIndex), True);
  ShowItemDetails(EPG.GetCell(4,toInteger(Event.RowIndex)).ToInteger);
  Log('========== EPGCellClickedEvent() finished');
end;

procedure TCWRmainFrm.EPGCellDoubleClickedEvent(Event: TJSCellDoubleClickedEvent);
begin
  Log('========== EPGCellDoubleClickedEvent() called from Row ' + toInteger(Event.RowIndex).ToString);
  // Quit Combobox if still open
  if pnlFilterSelection.Visible then pnlFilterSelection.Hide;
  ShowItemDetails(EPG.GetCell(4,toInteger(Event.RowIndex)).ToInteger);
  Log('========== EPGCellDoubleClickedEvent() finished');
end;

(*
Source - https://stackoverflow.com/a/78210803
Posted by Shaun Roselt
Retrieved 2025-11-08, License - CC BY-SA 4.0
*)
procedure TCWRmainFrm.SwipeDownRefresh(Enabled: Boolean);
begin
  if Enabled then
  begin
    TJSHTMLElement(document.body).style.removeProperty('overscroll-behavior-y');
    TJSHTMLElement(document.body.parentElement).style.removeProperty('overscroll-behavior-y');
  end else
  begin
    TJSHTMLElement(document.body).style.setProperty('overscroll-behavior-y','contain');
    TJSHTMLElement(document.body.parentElement).style.setProperty('overscroll-behavior-y','contain');
  end;
end;

procedure TCWRmainFrm.WebRESTClient1Error(Sender: TObject; ARequest:
    TJSXMLHttpRequestRecord; Event: TJSEventRecord; var Handled: Boolean);
begin
  TAwait.ExecP<TModalResult> (MessageDlgAsync('Caught RESTClient error: ' + Event.event.ToString
    + #13'Request: ' + ARequest.req.toString, mtInformation, [mbOK]));
end;

procedure TCWRmainFrm.WebRESTClient1RequestResponse(Sender: TObject; ARequest:
    TJSXMLHttpRequestRecord; AResponse: string);
begin
  {TAwait.ExecP<TModalResult> (MessageDlgAsync}Log('Caught RESTClient response: ' + AResponse
    + #13'Request: ' + ARequest.req.toString{, mtInformation, [mbOK])});
end;

procedure TCWRmainFrm.WIDBCDSAfterClose(DataSet: TDataSet);
begin
  Log('@@@@@@ WIDBS.Close was executed');
end;

procedure TCWRmainFrm.WIDBCDSBeforeClose(DataSet: TDataSet);
begin
  Log('@@@@@@ WIDBS.Close was called');
end;

end.
