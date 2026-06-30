object CWRmainFrm: TCWRmainFrm
  Width = 428
  Height = 817
  Color = clTeal
  CSSLibrary = cssBootstrap
  ElementClassName = 'container-fluid'
  ElementFont = efCSS
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -19
  Font.Name = 'Arial'
  Font.Style = []
  Menu = WebMainMenu1
  ParentFont = False
  OnCreate = WebFormCreate
  object pnlMenu: TWebPanel
    Left = 0
    Top = 0
    Width = 428
    Height = 50
    ParentCustomHint = False
    ElementClassName = 'container yellowBGslate'
    WidthStyle = ssPercent
    Align = alTop
    Caption = 'pnlMenu'
    ChildOrder = 12
    Color = 16512
    ElementBodyClassName = 'whiteBGslate'
    ElementFont = efCSS
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ShowCaption = False
    TabOrder = 5
  end
  object pnlLog: TWebPanel
    Left = 0
    Top = 50
    Width = 428
    Height = 747
    ElementClassName = 'card'
    HeightStyle = ssPercent
    WidthStyle = ssPercent
    Align = alClient
    Caption = 'pnlLog'
    ChildOrder = 9
    ElementBodyClassName = 'card-body'
    ElementFont = efCSS
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ShowCaption = False
    TabOrder = 1
    object WebMemo2: TWebMemo
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 422
      Height = 761
      Align = alClient
      Color = clBlack
      ElementClassName = 'white'
      ElementID = 'content'
      ElementFont = efCSS
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = []
      HeightStyle = ssPercent
      HeightPercent = 100.000000000000000000
      ParentFont = False
      ReadOnly = True
      SelLength = 0
      SelStart = 0
      WidthStyle = ssPercent
      WidthPercent = 100.000000000000000000
    end
  end
  object pnlWaitPls: TWebPanel
    Left = 0
    Top = 50
    Width = 428
    Height = 747
    ElementClassName = 'container-fluid'
    HeightStyle = ssPercent
    WidthStyle = ssPercent
    Align = alClient
    Caption = 'pnlWaitPls'
    ChildOrder = 10
    ElementBodyClassName = 'card-body'
    ElementFont = efCSS
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ShowCaption = False
    TabOrder = 3
    object WebGridPanel1: TWebGridPanel
      Left = 0
      Top = 0
      Width = 428
      Height = 767
      WidthStyle = ssPercent
      Align = alClient
      ColumnCollection = <
        item
          Value = 100
        end>
      ControlCollection = <
        item
          Column = 0
          Row = 0
          Control = WebButton1
        end
        item
          Column = 0
          Row = 1
          Control = WebLabel1
        end
        item
          Column = 0
          Row = 2
          Control = WebLabel2
        end>
      Color = clYellow
      GridLineColor = clBlack
      RowCollection = <
        item
          Value = 25
        end
        item
          Value = 25
        end
        item
          Value = 25
        end
        item
          Value = 25
        end>
      object WebLabel2: TWebLabel
        Left = 2
        Top = 386
        Width = 424
        Height = 188
        Align = alClient
        Alignment = taCenter
        Caption = 'Please Wait...'
        ChildOrder = -1
        Color = clYellow
        ElementLabelClassName = 'h1'
        ElementFont = efCSS
        ElementPosition = epRelative
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = []
        HeightStyle = ssPercent
        HeightPercent = 100.000000000000000000
        ParentFont = False
        Transparent = False
        WidthStyle = ssPercent
        WidthPercent = 100.000000000000000000
      end
      object WebLabel1: TWebLabel
        Left = 2
        Top = 194
        Width = 424
        Height = 188
        Align = alClient
        Alignment = taCenter
        Caption = 'Preparing EPG Listings.'
        ChildOrder = -1
        Color = clYellow
        ElementLabelClassName = 'h1'
        ElementFont = efCSS
        ElementPosition = epRelative
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = []
        HeightStyle = ssPercent
        HeightPercent = 100.000000000000000000
        HTMLType = tH1
        ParentFont = False
        Transparent = False
        WidthStyle = ssPercent
        WidthPercent = 100.000000000000000000
      end
      object WebButton1: TWebButton
        Left = 2
        Top = 2
        Width = 424
        Height = 188
        Align = alClient
        Caption = '<i class="fa-solid fa-spinner fa-spin"></>'
        Color = clYellow
        ChildOrder = -1
        ElementClassName = 'btn btn-lg'
        ElementFont = efCSS
        ElementPosition = epRelative
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = []
        HeightStyle = ssPercent
        HeightPercent = 100.000000000000000000
        ParentFont = False
        Role = 'button'
        WidthStyle = ssPercent
        WidthPercent = 100.000000000000000000
      end
    end
  end
  object pnlHistory: TWebPanel
    Left = 0
    Top = 50
    Width = 428
    Height = 747
    ElementClassName = 'card'
    HeightStyle = ssPercent
    WidthStyle = ssPercent
    Align = alClient
    Caption = 'pnlHistory'
    ChildOrder = 11
    ElementBodyClassName = 'card-body'
    ElementFont = efCSS
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ShowCaption = False
    TabOrder = 0
    object HistoryWDG: TWebDataGrid
      Left = 0
      Top = 0
      Width = 428
      Height = 727
      Align = alClient
      ColumnDefs = <
        item
          Field = 'column1'
          SelectOptions = <>
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
        end
        item
          Field = 'column2'
          SelectOptions = <>
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
        end>
      DefaultColDef.Enabled = True
      DefaultColDef.SuppressMovable = True
      EditType = retFullRow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 18
      Font.Name = 'Segoe UI'
      Font.Style = []
      MultilevelHeaders = <>
      TabOrder = 0
      Theming.ThemeMode = agDarkMode
      Visible = False
      OnGetRowClass = HistoryWDGGetRowClass
      OnCellClickedEvent = HistoryWDGCellClickedEvent
    end
  end
  object pnlCaptures: TWebPanel
    Left = 0
    Top = 50
    Width = 428
    Height = 747
    ElementClassName = 'greenBGolive'
    HeightStyle = ssPercent
    WidthStyle = ssPercent
    Align = alClient
    Caption = 'pnlCaptures'
    ChildOrder = 9
    Color = clDarkslateblue
    ElementBodyClassName = 'card-body'
    ElementFont = efCSS
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ShowCaption = False
    TabOrder = 2
    object WebHTMLDiv1: TWebHTMLDiv
      Left = 0
      Top = 266
      Width = 428
      Height = 35
      ElementClassName = 'greenBGolive'
      Align = alTop
      ChildOrder = 1
      ElementFont = efCSS
      HTML.Strings = (
        
          '<P align="center">Programs to be Scheduled <B>on Next CW_EPG Run' +
          '</B></P')
      Role = ''
    end
    object WebHTMLDiv2: TWebHTMLDiv
      Left = 0
      Top = 301
      Width = 428
      Height = 231
      HeightStyle = ssPercent
      HeightPercent = 30.000000000000000000
      Align = alTop
      ChildOrder = 2
      ElementFont = efCSS
      Role = ''
      object NewCapturesWSG: TWebStringGrid
        Left = 0
        Top = 0
        Width = 428
        Height = 231
        Align = alClient
        Color = clDarkolivegreen
        ColCount = 7
        DefaultRowHeight = 22
        FixedColor = clGreen
        FixedCols = 0
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = []
        Options = [goFixedHorzLine, goHorzLine, goRowSelect]
        ParentFont = False
        TabOrder = 0
        StyleElements = []
        ElementClassName = 'yellowBGolive'
        ElementFont = efCSS
        FixedFont.Charset = ANSI_CHARSET
        FixedFont.Color = clBlack
        FixedFont.Height = -19
        FixedFont.Name = 'Arial'
        FixedFont.Style = []
        RangeEdit.Max = 100.000000000000000000
        RangeEdit.Step = 1.000000000000000000
        HeightPercent = 100.000000000000000000
        WidthPercent = 100.000000000000000000
        OnClickCell = NewCapturesWSGClickCell
        OnGetCellData = NewCapturesWSGGetCellData
      end
    end
    object WebHTMLDiv3: TWebHTMLDiv
      Left = 0
      Top = 35
      Width = 428
      Height = 231
      HeightStyle = ssPercent
      HeightPercent = 40.000000000000000000
      Align = alTop
      ChildOrder = 2
      ElementFont = efCSS
      Role = ''
      object CapturesWSG: TWebStringGrid
        Left = 0
        Top = 0
        Width = 428
        Height = 231
        Align = alClient
        Color = clDarkolivegreen
        DefaultRowHeight = 22
        FixedColor = clGreen
        FixedCols = 0
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = []
        Options = [goHorzLine, goRowSelect]
        ParentFont = False
        TabOrder = 0
        StyleElements = []
        ElementClassName = 'whiteBGolive'
        ElementFont = efCSS
        FixedFont.Charset = ANSI_CHARSET
        FixedFont.Color = clBlack
        FixedFont.Height = -19
        FixedFont.Name = 'Arial'
        FixedFont.Style = []
        RangeEdit.Max = 100.000000000000000000
        RangeEdit.Step = 1.000000000000000000
        HeightStyle = ssPercent
        HeightPercent = 100.000000000000000000
        WidthPercent = 100.000000000000000000
        OnClickCell = CapturesWSGClickCell
        OnGetCellData = CapturesWSGGetCellData
      end
    end
    object WebHTMLDiv4: TWebHTMLDiv
      Left = 0
      Top = 0
      Width = 428
      Height = 35
      ElementClassName = 'greenBGolive'
      Align = alTop
      ChildOrder = 3
      ElementFont = efCSS
      HTML.Strings = (
        '<P align="center">Programs currently Scheduled</P>')
      Role = ''
    end
    object btnSchdRefrsh: TWebButton
      AlignWithMargins = True
      Left = 120
      Top = 535
      Width = 140
      Height = 33
      Margins.Left = 200
      Margins.Right = 200
      Margins.Bottom = 50
      Caption = 'Refresh'
      ChildOrder = 4
      ElementClassName = 'btn btn-outline-secondary greenBGolive'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      HeightPercent = 100.000000000000000000
      ParentFont = False
      WidthPercent = 100.000000000000000000
      OnClick = btnSchdRefrshClick
    end
  end
  object pnlListings: TWebPanel
    Left = 0
    Top = 50
    Width = 428
    Height = 747
    ElementClassName = 'greenBGnavy'
    ElementID = 'pnlListings'
    HeightStyle = ssPercent
    WidthStyle = ssPercent
    Align = alClient
    Caption = 'pnlListings'
    ChildOrder = 11
    Color = clBlueviolet
    ElementBodyClassName = 'card-body '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ShowCaption = False
    TabOrder = 4
    DesignSize = (
      428
      747)
    object lblEmptyEPG: TWebLabel
      Left = 96
      Top = 58
      Width = 329
      Height = 44
      Alignment = taCenter
      Anchors = [akLeft, akTop, akRight]
      Caption = 
        'There are no current listings to see.(Try "Options|Refresh EPG" ' +
        'to update)'
      Color = clBlack
      ElementClassName = 'form-label'
      ElementFont = efCSS
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = []
      HeightStyle = ssAuto
      HeightPercent = 100.000000000000000000
      ParentFont = False
      Transparent = False
      Visible = False
      WordWrap = True
      WidthPercent = 100.000000000000000000
    end
    object EPG: TWebDBDataGrid
      Left = 0
      Top = 0
      Width = 428
      Height = 747
      ElementID = 'EPGWDBG'
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
      Align = alClient
      Banding.OddRowsColor = clNavy
      Banding.EvenRowsColor = clNavy
      ColumnDefs = <
        item
          Field = 'PSIP'
          HeaderName = 'Channel'
          Filter = True
          ViewModeType = crtText
          SelectOptions = <>
          SuppressMovable = True
          LockVisible = False
          OnGetCellStyle = EPGColumn_PSIPGetCellStyle
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
        end
        item
          Field = 'Time'
          HeaderName = 'HTPC Local Time'
          ViewModeType = crtText
          SelectOptions = <>
          SuppressMovable = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
        end
        item
          Field = 'Title'
          HeaderName = 'Program'
          Filter = True
          ViewModeType = crtText
          SelectOptions = <>
          SuppressMovable = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
        end
        item
          Field = 'Class'
          HeaderName = 'Class'
          Filter = True
          Visible = False
          SelectOptions = <>
          SuppressMovable = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
        end
        item
          Field = 'id'
          HeaderName = 'ID'
          Resizable = False
          Sortable = False
          Visible = False
          SelectOptions = <>
          SuppressMovable = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
        end
        item
          Field = 'SubTitle'
          HeaderName = 'Sub Title'
          Filter = True
          SelectOptions = <>
          SuppressMovable = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
        end
        item
          Field = 'genres'
          Filter = True
          Sortable = False
          Visible = False
          SelectOptions = <>
          SuppressMovable = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
        end>
      DefaultColDef.Enabled = True
      DefaultColDef.SuppressMovable = True
      EditType = retFullRow
      Font.Charset = ANSI_CHARSET
      Font.Color = clSaddlebrown
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      MultilevelHeaders = <>
      PaginationPageSize = 50
      PaginationPageSizeSelector = '20,50,100'
      RowHeight = 20
      TabOrder = 0
      Theming.ThemeMode = agDarkMode
      Visible = False
      DataSource = WebDataSource1
      ShowIndicator = False
      OnGetRowClass = EPGGetRowClass
      OnCellClickedEvent = EPGCellClickedEvent
    end
    object pnlFilterSelection: TWebPanel
      Left = 100
      Top = 153
      Width = 175
      Height = 75
      ElementClassName = 'card yellowBGslate'
      ChildOrder = 5
      ElementBodyClassName = 'card-body'
      ElementFont = efCSS
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowCaption = False
      TabOrder = 1
      Visible = False
      object lblFilterSelect: TWebLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 169
        Height = 22
        Align = alTop
        Alignment = taCenter
        Caption = 'Choose Item'
        ElementClassName = 'form-label'
        ElementFont = efCSS
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = []
        HeightStyle = ssAuto
        HeightPercent = 100.000000000000000000
        ParentFont = False
        WidthStyle = ssAuto
        WidthPercent = 100.000000000000000000
      end
      object wcbGenres: TWebComboBox
        AlignWithMargins = True
        Left = 5
        Top = 31
        Width = 165
        Height = 30
        Margins.Left = 5
        Margins.Right = 5
        Align = alClient
        Color = clDarkslateblue
        ElementClassName = 'form-select whiteBGslate'
        ElementFont = efCSS
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = []
        HeightStyle = ssAuto
        HeightPercent = 100.000000000000000000
        ParentFont = False
        Role = 'combobox'
        Visible = False
        WidthStyle = ssPercent
        WidthPercent = 95.000000000000000000
        OnChange = wcbGenresChange
        OnFocusOut = wcbGenresFocusOut
        ItemIndex = -1
      end
      object wcbChannels: TWebComboBox
        AlignWithMargins = True
        Left = 5
        Top = 31
        Width = 165
        Height = 41
        Margins.Left = 5
        Margins.Right = 5
        Align = alClient
        Color = clDarkslateblue
        ElementClassName = 'form-select whiteBGslate'
        ElementFont = efCSS
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = []
        HeightStyle = ssAuto
        HeightPercent = 100.000000000000000000
        ParentFont = False
        Role = 'combobox'
        Visible = False
        WidthStyle = ssPercent
        WidthPercent = 95.000000000000000000
        OnChange = wcbChannelsChange
        OnFocusOut = wcbChannelsFocusOut
        ItemIndex = -1
      end
      object wcbTypes: TWebComboBox
        AlignWithMargins = True
        Left = 5
        Top = 31
        Width = 165
        Height = 41
        Margins.Left = 5
        Margins.Right = 5
        Align = alClient
        Color = clDarkslateblue
        ElementClassName = 'form-select whiteBGslate'
        ElementFont = efCSS
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = []
        HeightStyle = ssAuto
        HeightPercent = 100.000000000000000000
        ParentFont = False
        Role = 'combobox'
        Visible = False
        WidthStyle = ssPercent
        WidthPercent = 95.000000000000000000
        OnChange = wcbTypesChange
        OnFocusOut = wcbTypesFocusOut
        ItemIndex = -1
        Items.Strings = (
          'New'
          'Rerun'
          'Movie'
          'Other')
      end
    end
    object btnRefreshData: TWebSpeedButton
      Left = 120
      Top = 150
      Width = 144
      Height = 52
      Caption = 'Refresh Data'
      Color = clNone
      ElementClassName = 'btn btn-warning'
      ElementFont = efCSS
      Font.Charset = ANSI_CHARSET
      Font.Color = clDarkorange
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = []
      HeightStyle = ssAuto
      HeightPercent = 100.000000000000000000
      MaterialGlyph = 'update'
      MaterialGlyphColor = clDarkorange
      MaterialGlyphSize = 25
      ParentFont = False
      TabOrder = 2
      Visible = False
      WidthPercent = 100.000000000000000000
      OnClick = btnRefreshDataClick
    end
  end
  object BufferWDG: TWebDataGrid
    Left = 16
    Top = 256
    Width = 400
    Height = 300
    ColumnDefs = <
      item
        Field = 'column1'
        SelectOptions = <>
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
      end
      item
        Field = 'column2'
        SelectOptions = <>
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
      end>
    MultilevelHeaders = <>
    TabOrder = 6
    Visible = False
  end
  object WebMainMenu1: TWebMainMenu
    Appearance.BackgroundColor = clDarkslateblue
    Appearance.HamburgerMenu.Caption = 'Menu'
    Appearance.HamburgerMenu.CaptionColor = clYellow
    Appearance.HamburgerMenu.BackgroundColor = clSlategray
    Appearance.HamburgerMenu.Visible = hmAlways
    Appearance.HamburgerMenu.ResponsiveMaxWidth = 300
    Appearance.HoverColor = clCornflowerblue
    Appearance.HoverFontColor = clYellow
    Appearance.ImageSize = 8
    Appearance.SubmenuIndicator = '&#9658;'
    Container = pnlMenu
    ElementFont = efCSS
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = []
    Visible = False
    Width = 404
    Height = 50
    object ByAll: TMenuItem
      Caption = 'All Listings'
      Checked = True
      RadioItem = True
      OnClick = ByAllClick
    end
    object ByGenre: TMenuItem
      Caption = 'Filter by Genre'
      OnClick = ByGenreClick
    end
    object ByChannel: TMenuItem
      Caption = 'Filter by Channel'
      OnClick = ByChannelClick
    end
    object byType: TMenuItem
      Caption = 'Filter by Type'
      OnClick = byTypeClick
    end
    object Scheduled: TMenuItem
      Caption = 'Scheduled'
      OnClick = ScheduledClick
    end
    object History: TMenuItem
      Caption = 'History'
      OnClick = HistoryClick
    end
    object Options: TMenuItem
      Caption = 'Options'
      object RefreshEPG: TMenuItem
        Caption = 'Refresh Data'
        OnClick = RefreshData
      end
      object ChangeHTPC1: TMenuItem
        Caption = 'Change GDrive acct'
        OnClick = ChangeTargetHTPC
      end
      object ViewLog1: TMenuItem
        Caption = 'View Log'
        OnClick = ViewLog1Click
      end
      object Settings1: TMenuItem
        Caption = 'Settings'
        Visible = False
        OnClick = Settings1Click
      end
    end
  end
  object WebRESTClient1: TWebRESTClient
    LoginHeight = 480
    LoginWidth = 400
    PersistTokens.Key = 'GoogleToken'
    PersistTokens.Enabled = True
    OnError = WebRESTClient1Error
    OnRequestResponse = WebRESTClient1RequestResponse
    Left = 296
    Top = 104
  end
  object WebDataSource1: TWebDataSource
    DataSet = WIDBCDS
    Left = 296
    Top = 216
  end
  object WIDBCDS: TWebIndexedDbClientDataset
    IDBDatabaseName = 'CWRDB-Manual-id'
    IDBObjectStoreName = 'epg'
    IDBKeyFieldName = 'id'
    IDBAutoIncrement = False
    Params = <>
    OnIDBError = WIDBCDSIDBError
    BeforeClose = WIDBCDSBeforeClose
    AfterClose = WIDBCDSAfterClose
    Left = 216
    Top = 408
  end
  object WebTimer1: TWebTimer
    Enabled = False
    Interval = 500
    OnTimer = WebTimer1Timer
    Left = 200
    Top = 392
  end
end
