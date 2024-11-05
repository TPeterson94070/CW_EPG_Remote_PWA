object CWRmainFrm: TCWRmainFrm
  Width = 400
  Height = 800
  CSSLibrary = cssBootstrap
  ElementClassName = 'container-fluid'
  ElementFont = efCSS
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -11
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
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Options = []
    ParentFont = False
    TabOrder = 9
    Visible = False
    StyleElements = []
    FixedFont.Charset = DEFAULT_CHARSET
    FixedFont.Color = clWindowText
    FixedFont.Height = -12
    FixedFont.Name = 'Segoe UI'
    FixedFont.Style = []
    RangeEdit.Max = 100.000000000000000000
    RangeEdit.Step = 1.000000000000000000
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
  end
  object pnlHistory: TWebPanel
    Left = 0
    Top = 80
    Width = 400
    Height = 700
    ElementClassName = 'card'
    HeightStyle = ssPercent
    WidthStyle = ssPercent
    Align = alClient
    ChildOrder = 11
    ElementBodyClassName = 'card-body'
    ElementFont = efCSS
    ShowCaption = False
    TabOrder = 1
    object HistoryTable: TWebStringGrid
      Left = 0
      Top = 0
      Width = 400
      Height = 700
      Align = alClient
      Color = clDarkslategray
      ColCount = 32
      DefaultColWidth = 61
      DefaultRowHeight = 23
      FixedCols = 0
      Font.Charset = ANSI_CHARSET
      Font.Color = clGray
      Font.Height = -11
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
      FixedFont.Height = -12
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
  object NewCaptures: TWebStringGrid
    Left = 32
    Top = 440
    Width = 553
    Height = 225
    ColCount = 7
    DefaultRowHeight = 22
    FixedCols = 0
    FixedRows = 0
    Options = [goVertLine, goHorzLine, goRangeSelect]
    TabOrder = 7
    Visible = False
    StyleElements = []
    FixedFont.Charset = ANSI_CHARSET
    FixedFont.Color = clBlack
    FixedFont.Height = -11
    FixedFont.Name = 'Arial'
    FixedFont.Style = []
    RangeEdit.Max = 100.000000000000000000
    RangeEdit.Step = 1.000000000000000000
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
  end
  object pnlMenu: TWebPanel
    Left = 0
    Top = 0
    Width = 400
    Height = 50
    ElementClassName = 'container'
    WidthStyle = ssPercent
    Align = alTop
    BorderStyle = bsNone
    Caption = 'pnlMenu'
    ChildOrder = 12
    TabOrder = 8
  end
  object pnlStatus: TWebPanel
    Left = 0
    Top = 50
    Width = 400
    Height = 30
    ElementClassName = 'container'
    WidthStyle = ssAuto
    Align = alTop
    BorderStyle = bsNone
    Caption = 'pnlStatus'
    ChildOrder = 12
    ElementBodyClassName = 'card-body'
    ElementFont = efCSS
    TabOrder = 0
    Visible = False
    object AlertLabel: TWebButton
      Left = 0
      Top = 0
      Width = 400
      Height = 30
      Margins.Left = 19
      Margins.Top = 24
      Margins.Right = 19
      Margins.Bottom = 19
      Align = alClient
      Color = clYellow
      ElementClassName = 'form-control'
      ElementFont = efCSS
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      HeightPercent = 100.000000000000000000
      ParentFont = False
      Role = 'button'
      WidthPercent = 100.000000000000000000
    end
  end
  object pnlCaptures: TWebPanel
    Left = 0
    Top = 80
    Width = 400
    Height = 700
    ElementClassName = 'card'
    HeightStyle = ssPercent
    WidthStyle = ssPercent
    Align = alClient
    ChildOrder = 9
    ElementBodyClassName = 'card-body'
    ElementFont = efCSS
    ShowCaption = False
    TabOrder = 3
    object Captures: TWebStringGrid
      Left = 0
      Top = 0
      Width = 400
      Height = 700
      Align = alClient
      Color = clCadetblue
      DefaultRowHeight = 22
      FixedColor = clCornflowerblue
      Options = [goHorzLine, goRowSelect]
      TabOrder = 0
      StyleElements = []
      ElementClassName = 'white'
      ElementFont = efCSS
      FixedFont.Charset = ANSI_CHARSET
      FixedFont.Color = clBlack
      FixedFont.Height = -11
      FixedFont.Name = 'Arial'
      FixedFont.Style = []
      RangeEdit.Max = 100.000000000000000000
      RangeEdit.Step = 1.000000000000000000
      HeightStyle = ssPercent
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
    end
  end
  object pnlOptions: TWebPanel
    Left = 0
    Top = 80
    Width = 400
    Height = 700
    ElementClassName = 'card'
    HeightStyle = ssPercent
    WidthStyle = ssPercent
    Align = alClient
    ChildOrder = 9
    ElementBodyClassName = 'card-body'
    ElementFont = efCSS
    ShowCaption = False
    TabOrder = 5
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
      object seNumHistEvents: TWebSpinEdit
        AlignWithMargins = True
        Left = 57
        Top = 35
        Width = 150
        Height = 45
        Margins.Left = 57
        Margins.Top = 35
        Margins.Right = 57
        Margins.Bottom = 24
        ElementClassName = 'form-control'
        HeightStyle = ssAuto
        Align = alClient
        AutoSize = True
        BorderStyle = bsNone
        Color = clBtnFace
        ElementFont = efCSS
        Increment = 100
        MaxValue = 8000
        MinValue = 100
        Role = ''
        Value = 100
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
      object seNumDisplayDays: TWebSpinEdit
        AlignWithMargins = True
        Left = 57
        Top = 35
        Width = 150
        Height = 41
        Margins.Left = 57
        Margins.Top = 35
        Margins.Right = 57
        Margins.Bottom = 24
        ElementClassName = 'form-control'
        HeightStyle = ssAuto
        Align = alClient
        AutoSize = False
        BorderStyle = bsNone
        Color = clBtnFace
        ElementFont = efCSS
        Increment = 1
        MaxValue = 10
        MinValue = 1
        Role = ''
        Value = 1
      end
    end
  end
  object pnlLog: TWebPanel
    Left = 0
    Top = 80
    Width = 400
    Height = 700
    ElementClassName = 'card'
    HeightStyle = ssPercent
    WidthStyle = ssPercent
    Align = alClient
    ChildOrder = 9
    ElementBodyClassName = 'card-body'
    ElementFont = efCSS
    ShowCaption = False
    TabOrder = 2
    object WebMemo2: TWebMemo
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 394
      Height = 694
      Align = alClient
      Color = clBlack
      ElementClassName = 'white'
      ElementID = 'content'
      ElementFont = efCSS
      HeightStyle = ssPercent
      HeightPercent = 100.000000000000000000
      ReadOnly = True
      SelLength = 0
      SelStart = 0
      WidthStyle = ssPercent
      WidthPercent = 100.000000000000000000
    end
  end
  object pnlWaitPls: TWebPanel
    Left = 0
    Top = 80
    Width = 400
    Height = 700
    ElementClassName = 'container-fluid'
    HeightStyle = ssPercent
    WidthStyle = ssPercent
    Align = alClient
    ChildOrder = 10
    ElementBodyClassName = 'card-body'
    ElementFont = efCSS
    TabOrder = 4
    object WebGridPanel1: TWebGridPanel
      Left = 0
      Top = 0
      Width = 400
      Height = 700
      WidthStyle = ssPercent
      Align = alClient
      ChildOrder = 2
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
          Row = 0
          Control = WebLabel1
        end
        item
          Column = 0
          Row = 0
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
        Width = 396
        Height = 171
        Align = alClient
        Alignment = taCenter
        Caption = 'Please Wait...'
        Color = clYellow
        ElementLabelClassName = 'h1'
        ElementFont = efCSS
        HeightStyle = ssAuto
        HeightPercent = 100.000000000000000000
        Transparent = False
        WidthPercent = 100.000000000000000000
      end
      object WebLabel1: TWebLabel
        Left = 2
        Top = 177
        Width = 396
        Height = 171
        Align = alClient
        Alignment = taCenter
        Caption = 'Preparing EPG Listings.'
        Color = clYellow
        ElementLabelClassName = 'h1'
        ElementFont = efCSS
        HeightStyle = ssAuto
        HeightPercent = 100.000000000000000000
        HTMLType = tH1
        Transparent = False
        WidthPercent = 100.000000000000000000
      end
      object WebButton1: TWebButton
        Left = 2
        Top = 2
        Width = 396
        Height = 171
        Align = alClient
        Caption = '<i class="fa-solid fa-spinner fa-spin"></>'
        Color = clYellow
        ChildOrder = 1
        ElementClassName = 'btn btn-lg'
        ElementFont = efCSS
        HeightPercent = 100.000000000000000000
        Role = 'button'
        WidthPercent = 100.000000000000000000
      end
    end
  end
  object pnlListings: TWebPanel
    Left = 0
    Top = 80
    Width = 400
    Height = 700
    ElementClassName = 'card'
    HeightStyle = ssPercent
    WidthStyle = ssPercent
    Align = alClient
    Caption = 'pnlListings'
    ChildOrder = 11
    ElementBodyClassName = 'card-body'
    ElementFont = efCSS
    ShowCaption = False
    TabOrder = 6
    DesignSize = (
      400
      700)
    object lblEmptyEPG: TWebLabel
      Left = 96
      Top = 58
      Width = 100
      Height = 70
      Alignment = taCenter
      Anchors = [akLeft, akTop, akRight]
      Caption = 
        'There are no current listings to see.'#13'(Try "Options|Refresh EPG"' +
        ' to update)'
      Color = clBlack
      ElementClassName = 'white'
      ElementFont = efCSS
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      HeightStyle = ssAuto
      HeightPercent = 100.000000000000000000
      ParentFont = False
      Visible = False
      WordWrap = True
      WidthPercent = 100.000000000000000000
    end
    object EPG: TWebDBGrid
      Left = 0
      Top = 0
      Width = 400
      Height = 700
      Align = alClient
      BorderStyle = bsNone
      Color = clDarkblue
      Columns = <
        item
          Alignment = taCenter
          AutoFormatDateTime = False
          DataField = 'PSIP'
          Title = 'Channel'
          Width = 70
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
      FixedFont.Height = -11
      FixedFont.Name = 'Arial'
      FixedFont.Style = []
      FixedCols = 0
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
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
        70
        155
        300
        0
        0)
    end
    object WebComboBox1: TWebComboBox
      Left = 152
      Top = 23
      Width = 145
      Height = 22
      ElementClassName = 'form-select'
      ElementFont = efCSS
      HeightStyle = ssAuto
      HeightPercent = 100.000000000000000000
      Text = 'Choose Genre Filter'
      Visible = False
      WidthPercent = 100.000000000000000000
      OnChange = WebComboBox1Change
      OnDblClick = WebComboBox1Change
      ItemIndex = -1
    end
    object WebComboBox2: TWebComboBox
      Left = 160
      Top = 23
      Width = 145
      Height = 22
      ElementClassName = 'form-select'
      ElementFont = efCSS
      HeightStyle = ssAuto
      HeightPercent = 100.000000000000000000
      Text = 'Choose Title Filter'
      Visible = False
      WidthPercent = 100.000000000000000000
      OnChange = WebComboBox2Change
      OnDblClick = WebComboBox2Change
      ItemIndex = -1
    end
    object WebComboBox3: TWebComboBox
      Left = 164
      Top = 23
      Width = 145
      Height = 22
      ElementClassName = 'form-select'
      ElementFont = efCSS
      HeightStyle = ssAuto
      HeightPercent = 100.000000000000000000
      Text = 'Choose Title Filter'
      Visible = False
      WidthPercent = 100.000000000000000000
      OnChange = WebComboBox3Change
      ItemIndex = -1
    end
  end
  object WebMainMenu1: TWebMainMenu
    OnChange = WebMainMenu1Change
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
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    Visible = False
    Width = 376
    Height = 50
    object Listing: TMenuItem
      Caption = 'Listings'
      Default = True
      RadioItem = True
      OnClick = ListingClick
      object ByAll: TMenuItem
        Caption = 'All'
        Checked = True
        Default = True
        RadioItem = True
        OnClick = ByAllClick
      end
      object ByGenre: TMenuItem
        Caption = 'By Genre'
        RadioItem = True
        OnClick = ByGenreClick
      end
      object ByTitle: TMenuItem
        Caption = 'By Title'
        RadioItem = True
        OnClick = ByTitleClick
      end
      object ByChannel: TMenuItem
        Caption = 'By Channel'
        RadioItem = True
        OnClick = ByChannelClick
      end
    end
    object Scheduled: TMenuItem
      Caption = 'Scheduled'
      RadioItem = True
      OnClick = ScheduledClick
    end
    object History: TMenuItem
      Caption = 'History'
      RadioItem = True
      OnClick = HistoryClick
    end
    object Options: TMenuItem
      Caption = 'Options'
      RadioItem = True
      object RefreshEPG: TMenuItem
        Caption = 'Refresh EPG'
        OnClick = UpdateEPG
      end
      object RefreshHistory1: TMenuItem
        Caption = 'Refresh History'
        OnClick = UpdateHistory
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
    DataSet = WIDBCDS
    Left = 296
    Top = 216
  end
end
