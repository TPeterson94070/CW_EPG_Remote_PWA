object CWRmainFrm: TCWRmainFrm
  Width = 428
  Height = 817
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
  object BufferGrid: TWebStringGrid
    Left = 96
    Top = 632
    Width = 257
    Height = 50
    ColCount = 14
    DefaultColWidth = 61
    DefaultRowHeight = 23
    FixedCols = 0
    RowCount = 20
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Segoe UI'
    Font.Style = []
    Options = []
    ParentFont = False
    TabOrder = 8
    Visible = False
    StyleElements = []
    FixedFont.Charset = DEFAULT_CHARSET
    FixedFont.Color = clWindowText
    FixedFont.Height = -21
    FixedFont.Name = 'Segoe UI'
    FixedFont.Style = []
    RangeEdit.Max = 100.000000000000000000
    RangeEdit.Step = 1.000000000000000000
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
  end
  object pnlMenu: TWebPanel
    Left = 0
    Top = 0
    Width = 428
    Height = 50
    ElementClassName = 'container'
    WidthStyle = ssPercent
    Align = alTop
    BorderStyle = bsNone
    Caption = 'pnlMenu'
    ChildOrder = 12
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object pnlLog: TWebPanel
    Left = 0
    Top = 50
    Width = 428
    Height = 699
    ElementClassName = 'card'
    HeightStyle = ssPercent
    WidthStyle = ssPercent
    Align = alClient
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
      Height = 693
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
    Height = 699
    ElementClassName = 'container-fluid'
    HeightStyle = ssPercent
    WidthStyle = ssPercent
    Align = alClient
    ChildOrder = 10
    ElementBodyClassName = 'card-body'
    ElementFont = efCSS
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    object WebGridPanel1: TWebGridPanel
      Left = 0
      Top = 0
      Width = 428
      Height = 699
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
        Top = 352
        Width = 424
        Height = 171
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
        Top = 177
        Width = 424
        Height = 171
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
        Height = 171
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
    Height = 699
    ElementClassName = 'card'
    HeightStyle = ssPercent
    WidthStyle = ssPercent
    Align = alClient
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
    object HistoryTable: TWebStringGrid
      Left = 0
      Top = 0
      Width = 428
      Height = 699
      Align = alClient
      Color = 13479662
      ColCount = 32
      DefaultColWidth = 61
      DefaultRowHeight = 23
      FixedCols = 0
      Font.Charset = ANSI_CHARSET
      Font.Color = clGray
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = []
      Options = [goRowSelect, goFixedRowClick]
      ParentFont = False
      TabOrder = 0
      StyleElements = []
      OnFixedCellClick = HistoryTableFixedCellClick
      ElementFont = efCSS
      FixedFont.Charset = DEFAULT_CHARSET
      FixedFont.Color = clWindowText
      FixedFont.Height = -21
      FixedFont.Name = 'Segoe UI'
      FixedFont.Style = []
      RangeEdit.Max = 100.000000000000000000
      RangeEdit.Step = 1.000000000000000000
      HeightStyle = ssPercent
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
      OnGetCellClass = HistoryTableGetCellClass
    end
  end
  object pnlCaptures: TWebPanel
    Left = 0
    Top = 50
    Width = 428
    Height = 699
    ElementClassName = 'greenBG'
    HeightStyle = ssPercent
    WidthStyle = ssPercent
    Align = alClient
    ChildOrder = 9
    Color = clGray
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
      ElementClassName = 'greenBG'
      Align = alTop
      ChildOrder = 1
      ElementFont = efCSS
      HTML.Strings = (
        
          '<FONT color="#FFFFFF" ><P align="center">Programs to be Schedule' +
          'd </FONT><FONT color="#F00000" >on Next CW_EPG Run </P> </FONT>')
      Role = ''
    end
    object WebHTMLDiv2: TWebHTMLDiv
      Left = 0
      Top = 301
      Width = 428
      Height = 231
      Align = alTop
      ChildOrder = 2
      ElementFont = efCSS
      Role = ''
      object NewCaptures: TWebStringGrid
        Left = 0
        Top = 0
        Width = 428
        Height = 231
        Align = alClient
        Color = 212724686
        ColCount = 7
        DefaultRowHeight = 22
        FixedColor = clTeal
        FixedCols = 0
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = []
        Options = [goFixedHorzLine, goHorzLine, goRowSelect]
        ParentFont = False
        TabOrder = 0
        StyleElements = []
        ElementClassName = 'greenBG'
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
        OnClickCell = NewCapturesClickCell
        OnGetCellData = NewCapturesGetCellData
      end
    end
    object WebHTMLDiv3: TWebHTMLDiv
      Left = 0
      Top = 35
      Width = 428
      Height = 231
      Align = alTop
      ChildOrder = 2
      ElementFont = efCSS
      Role = ''
      object Captures: TWebStringGrid
        Left = 0
        Top = 0
        Width = 428
        Height = 231
        Align = alClient
        Color = 212724686
        DefaultRowHeight = 22
        FixedColor = clTeal
        FixedCols = 0
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = []
        Options = [goHorzLine, goRowSelect]
        ParentFont = False
        TabOrder = 0
        StyleElements = []
        ElementClassName = 'greenBG'
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
      end
    end
    object WebHTMLDiv4: TWebHTMLDiv
      Left = 0
      Top = 0
      Width = 428
      Height = 35
      ElementClassName = 'greenBG'
      Align = alTop
      ChildOrder = 3
      ElementFont = efCSS
      HTML.Strings = (
        
          '<FONT color="#FFFFFF" ><P align="center">Programs currently Sche' +
          'duled</P></FONT>')
      Role = ''
    end
  end
  object HistoryGrid: TWebStringGrid
    Left = 56
    Top = 352
    Width = 320
    Height = 120
    ColCount = 32
    DefaultRowHeight = 22
    FixedCols = 0
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = []
    Options = [goVertLine, goHorzLine, goRangeSelect]
    ParentFont = False
    TabOrder = 7
    Visible = False
    StyleElements = []
    ElementFont = efCSS
    FixedFont.Charset = DEFAULT_CHARSET
    FixedFont.Color = clWindowText
    FixedFont.Height = -37
    FixedFont.Name = 'Segoe UI'
    FixedFont.Style = []
    RangeEdit.Max = 100.000000000000000000
    RangeEdit.Step = 1.000000000000000000
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
  end
  object pnlOptions: TWebPanel
    Left = 0
    Top = 50
    Width = 428
    Height = 699
    ElementClassName = 'card'
    HeightStyle = ssPercent
    WidthStyle = ssPercent
    Align = alClient
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
    TabOrder = 4
    object WebGroupBox3: TWebGroupBox
      Left = 15
      Top = 115
      Width = 264
      Height = 104
      ElementClassName = 'btn-group'
      WidthPercent = 25.000000000000000000
      Align = alCustom
      BorderColor = clSilver
      Caption = 'History Events Displayed'
      Color = clAqua
      ElementFont = efCSS
      ElementLegendClassName = 'h6'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      object cbNumHistList: TWebComboBox
        Left = 81
        Top = 40
        Width = 100
        Height = 30
        ElementClassName = 'form-select'
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
        Text = '200'
        WidthPercent = 100.000000000000000000
        ItemIndex = 1
        Items.Strings = (
          '100'
          '200'
          '300'
          '400'
          '500'
          '600'
          '700'
          '800'
          '900'
          '1000')
      end
    end
    object WebGroupBox1: TWebGroupBox
      Left = 15
      Top = 0
      Width = 264
      Height = 100
      ElementClassName = 'btn-group'
      WidthPercent = 25.000000000000000000
      Align = alCustom
      BorderColor = clSilver
      Caption = 'EPG Days Displayed'
      Color = clAqua
      ElementFont = efCSS
      ElementLegendClassName = 'h6'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      object cbNumDisplayDays: TWebComboBox
        Left = 88
        Top = 41
        Width = 80
        Height = 30
        Align = alCustom
        ElementClassName = 'form-select'
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
        Text = '3'
        WidthPercent = 100.000000000000000000
        OnChange = cbNumDisplayDaysChange
        ItemIndex = 2
        Items.Strings = (
          '1'
          '2'
          '3'
          '4'
          '5'
          '6'
          '7'
          '8'
          '9'
          '10')
      end
    end
    object btnOptOK: TWebButton
      Left = 72
      Top = 235
      Width = 135
      Height = 37
      Caption = 'Save Settings'
      ChildOrder = 2
      ElementClassName = 'btn btn-outline-primary'
      ElementFont = efCSS
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = []
      HeightStyle = ssAuto
      HeightPercent = 100.000000000000000000
      ModalResult = 1
      ParentFont = False
      Role = 'button'
      WidthPercent = 100.000000000000000000
      OnClick = btnOptOKClick
    end
  end
  object pnlListings: TWebPanel
    Left = 0
    Top = 50
    Width = 428
    Height = 699
    ElementClassName = 'card'
    HeightStyle = ssPercent
    WidthStyle = ssPercent
    Align = alClient
    Caption = 'pnlListings'
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
    TabOrder = 5
    DesignSize = (
      428
      699)
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
    object EPG: TWebDBGrid
      Left = 0
      Top = 0
      Width = 428
      Height = 699
      Align = alClient
      BorderStyle = bsNone
      Color = clNavy
      Columns = <
        item
          Alignment = taCenter
          AutoFormatDateTime = False
          DataField = 'PSIP'
          Title = 'Channel'
          Width = 75
        end
        item
          Alignment = taCenter
          AutoFormatDateTime = False
          DataField = 'Time'
          Title = 'HTPC Local Time'
          TitleElementClassName = 'h6'
          Width = 155
        end
        item
          AutoFormatDateTime = False
          DataField = 'Title'
          Title = 'Title'
          Width = 300
        end
        item
          AutoFormatDateTime = False
          DataField = 'id'
          Editor = geNone
          Title = 'ID'
          Width = 0
        end
        item
          AutoFormatDateTime = False
          ElementClassName = 'white'
          DataField = 'Class'
          Title = 'Class'
          Width = 0
        end>
      DataSource = WebDataSource1
      ElementFont = efCSS
      FixedFont.Charset = ANSI_CHARSET
      FixedFont.Color = clBlack
      FixedFont.Height = -19
      FixedFont.Name = 'Arial'
      FixedFont.Style = []
      FixedCols = 0
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Segoe UI'
      Font.Style = []
      Options = [goRowSelect]
      ParentFont = False
      TabOrder = 0
      HeightPercent = 100.000000000000000000
      StyleElements = []
      WidthPercent = 100.000000000000000000
      OnClickCell = EPGClickCell
      OnGetCellClass = EPGGetCellClass
      ColWidths = (
        75
        155
        300
        0
        0)
    end
    object pnlFilterComboBox: TWebPanel
      Left = 88
      Top = 49
      Width = 150
      Height = 60
      ElementClassName = 'card'
      Caption = 'Choose Filter'
      ChildOrder = 5
      ElementBodyClassName = 'card-body'
      ElementFont = efCSS
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Visible = False
      object lblFilterSelect: TWebLabel
        Left = 0
        Top = 0
        Width = 150
        Height = 22
        Align = alTop
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
        WidthPercent = 100.000000000000000000
      end
      object WebComboBox1: TWebComboBox
        Left = 0
        Top = 30
        Width = 150
        Height = 30
        Align = alBottom
        ElementClassName = 'form-select'
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
        WidthPercent = 100.000000000000000000
        OnChange = WebComboBox1Change
        OnDblClick = WebComboBox1Change
        OnFocusOut = WebComboBox1FocusOut
        ItemIndex = -1
      end
      object WebComboBox2: TWebComboBox
        Left = 0
        Top = -30
        Width = 150
        Height = 30
        Align = alBottom
        ElementClassName = 'form-select'
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
        WidthPercent = 100.000000000000000000
        OnChange = WebComboBox2Change
        OnDblClick = WebComboBox2Change
        OnFocusOut = WebComboBox2FocusOut
        ItemIndex = -1
      end
      object WebComboBox3: TWebComboBox
        Left = 0
        Top = 0
        Width = 150
        Height = 30
        Align = alBottom
        ElementClassName = 'form-select'
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
        WidthPercent = 100.000000000000000000
        OnChange = WebComboBox3Change
        OnDblClick = WebComboBox3Change
        OnFocusOut = WebComboBox3FocusOut
        ItemIndex = -1
      end
    end
  end
  object WebMainMenu1: TWebMainMenu
    Appearance.BackgroundColor = clSilver
    Appearance.HamburgerMenu.Caption = 'Menu'
    Appearance.HamburgerMenu.Visible = hmAlways
    Appearance.HamburgerMenu.ResponsiveMaxWidth = 300
    Appearance.HoverFontColor = clWhite
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
      Caption = 'Complete Listing'
      Checked = True
      Default = True
      RadioItem = True
      OnClick = ByAllClick
    end
    object ByGenre: TMenuItem
      Caption = 'Filter by Genre'
      RadioItem = True
      OnClick = ByGenreClick
    end
    object ByTitle: TMenuItem
      Caption = 'Filter by Title'
      RadioItem = True
      OnClick = ByTitleClick
    end
    object ByChannel: TMenuItem
      Caption = 'Filter by Channel'
      RadioItem = True
      OnClick = ByChannelClick
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
        Caption = 'Change HTPC'
        OnClick = ChangeTargetHTPC
      end
      object ViewLog1: TMenuItem
        Caption = 'View Log'
        OnClick = ViewLog1Click
      end
      object Settings1: TMenuItem
        Caption = 'Settings'
        OnClick = Settings1Click
      end
    end
  end
  object WIDBCDS: TWebIndexedDbClientDataset
    IDBDatabaseName = 'CWRDB-Manual-id'
    IDBObjectStoreName = 'epg'
    IDBKeyFieldName = 'id'
    IDBAutoIncrement = False
    Params = <>
    OnIDBError = WIDBCDSIDBError
    Left = 296
    Top = 152
  end
  object WebRESTClient1: TWebRESTClient
    LoginHeight = 480
    LoginWidth = 400
    PersistTokens.Key = 'GoogleToken'
    PersistTokens.Enabled = True
    Left = 296
    Top = 104
  end
  object WebDataSource1: TWebDataSource
    DataSet = EpgDb
    Left = 296
    Top = 216
  end
  object EpgDb: TWebClientDataSet
    Params = <>
    Left = 200
    Top = 392
  end
  object CurrEpgDb: TWebClientDataSet
    Params = <>
    Left = 208
    Top = 400
  end
end
