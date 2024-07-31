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
  ParentFont = False
  OnCreate = WebFormCreate
  object pnlHistory: TWebPanel
    Left = 0
    Top = 30
    Width = 400
    Height = 770
    ElementClassName = 'card'
    HeightStyle = ssPercent
    WidthStyle = ssPercent
    Align = alClient
    ChildOrder = 11
    ElementBodyClassName = 'card-body'
    ElementFont = efCSS
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ShowCaption = False
    TabOrder = 1
    ExplicitTop = 40
    ExplicitHeight = 760
    object HistoryTable: TWebStringGrid
      Left = 0
      Top = 0
      Width = 400
      Height = 770
      Align = alClient
      ColCount = 32
      DefaultColWidth = 61
      DefaultRowHeight = 23
      FixedCols = 0
      Options = [goRowSelect, goFixedRowClick]
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
      ExplicitHeight = 760
    end
  end
  object pnlLog: TWebPanel
    Left = 0
    Top = 30
    Width = 400
    Height = 770
    ElementClassName = 'card'
    HeightStyle = ssPercent
    Align = alClient
    ChildOrder = 9
    ElementBodyClassName = 'card-body'
    ElementFont = efCSS
    TabOrder = 2
    ExplicitTop = 40
    ExplicitHeight = 760
    object WebMemo2: TWebMemo
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 394
      Height = 764
      Align = alClient
      ElementID = 'content'
      ElementFont = efCSS
      HeightStyle = ssPercent
      HeightPercent = 100.000000000000000000
      ReadOnly = True
      SelLength = 0
      SelStart = 0
      WidthStyle = ssPercent
      WidthPercent = 100.000000000000000000
      ExplicitHeight = 754
    end
  end
  object pnlCaptures: TWebPanel
    Left = 0
    Top = 30
    Width = 400
    Height = 770
    ElementClassName = 'card'
    HeightStyle = ssPercent
    WidthStyle = ssPercent
    Align = alClient
    ChildOrder = 9
    ElementBodyClassName = 'card-body'
    ElementFont = efCSS
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ShowCaption = False
    TabOrder = 3
    ExplicitTop = 40
    ExplicitHeight = 760
    object AllCapsGrid: TWebStringGrid
      Left = 0
      Top = 0
      Width = 400
      Height = 770
      Align = alClient
      DefaultRowHeight = 22
      Options = [goVertLine, goHorzLine, goRangeSelect]
      TabOrder = 0
      StyleElements = []
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
      ExplicitHeight = 760
    end
  end
  object WebPanel1: TWebPanel
    Left = 0
    Top = 30
    Width = 400
    Height = 770
    ElementClassName = 'container-fluid'
    HeightStyle = ssPercent
    Align = alClient
    ChildOrder = 10
    ElementBodyClassName = 'card-body'
    ElementFont = efCSS
    TabOrder = 4
    ExplicitTop = 40
    ExplicitHeight = 760
    object WebMemo1: TWebMemo
      Left = 0
      Top = 23
      Width = 400
      Height = 747
      Margins.Left = 19
      Margins.Top = 38
      Margins.Right = 19
      Margins.Bottom = 228
      Align = alClient
      Color = clYellow
      ElementID = 'WebMemo1'
      ElementFont = efCSS
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
      Font.Name = 'Segoe UI'
      Font.Style = []
      HeightPercent = 100.000000000000000000
      Lines.Strings = (
        '   '
        '   Preparing EPG Display'
        '  '
        '   Please Wait . . .')
      ParentFont = False
      ReadOnly = True
      SelLength = 0
      SelStart = 52
      WidthPercent = 100.000000000000000000
      ExplicitHeight = 737
    end
    object WebProgressBar1: TWebProgressBar
      Left = 0
      Top = 0
      Width = 400
      Height = 23
      ElementClassName = 'progress'
      Align = alTop
      ElementBarClassName = 'progress-bar'
      Value = pbvAbsolute
    end
  end
  object WebStringGrid1: TWebStringGrid
    AlignWithMargins = True
    Left = 5
    Top = 33
    Width = 392
    Height = 764
    Margins.Left = 5
    Align = alClient
    DefaultRowHeight = 22
    Options = [goVertLine, goHorzLine, goRangeSelect]
    TabOrder = 6
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
    ExplicitTop = 43
    ExplicitHeight = 754
  end
  object WebStringGrid2: TWebStringGrid
    Left = 0
    Top = 30
    Width = 400
    Height = 770
    Align = alClient
    BorderStyle = bsNone
    DefaultRowHeight = 22
    Options = [goVertLine, goHorzLine, goRangeSelect]
    TabOrder = 8
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
    ExplicitTop = 40
    ExplicitHeight = 760
  end
  object NewCapturesTable: TWebStringGrid
    Left = 32
    Top = 440
    Width = 553
    Height = 225
    ColCount = 7
    DefaultRowHeight = 22
    FixedCols = 0
    FixedRows = 0
    Options = [goVertLine, goHorzLine, goRangeSelect]
    TabOrder = 0
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
  object WebPanel3: TWebPanel
    Left = 0
    Top = 0
    Width = 400
    Height = 30
    ElementClassName = 'container'
    WidthStyle = ssPercent
    Align = alTop
    Caption = 'WebPanel3'
    ChildOrder = 12
    ShowCaption = False
    TabOrder = 10
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
      Caption = 
        'Refreshing CW_EPG data <i class="fa-solid fa-spinner fa-spin"></' +
        '>'
      Color = clYellow
      ElementFont = efCSS
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = []
      HeightStyle = ssAuto
      HeightPercent = 100.000000000000000000
      ParentFont = False
      Role = 'button'
      Visible = False
      WidthStyle = ssPercent
      WidthPercent = 100.000000000000000000
      ExplicitHeight = 40
    end
    object WebRadioGroup1: TWebRadioGroup
      Left = 0
      Top = 0
      Width = 400
      Height = 30
      HeightStyle = ssPercent
      WidthStyle = ssPercent
      Align = alClient
      Caption = ''
      ChildOrder = 5
      Columns = 5
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        '<small>Listings</small>'
        '<small>Sched</small>'
        '<small>History</small>'
        '<small>Log</small>'
        '<small>Options</small>')
      ParentFont = False
      Role = ''
      TabOrder = 1
      OnChange = WebRadioGroup1Change
    end
  end
  object pnlListings: TWebPanel
    Left = 0
    Top = 30
    Width = 400
    Height = 770
    ElementClassName = 'card'
    HeightStyle = ssPercent
    WidthStyle = ssPercent
    Align = alClient
    Caption = 'pnlListings'
    ChildOrder = 11
    ElementBodyClassName = 'card-body'
    ElementFont = efCSS
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    ShowCaption = False
    TabOrder = 7
    ExplicitTop = 40
    ExplicitHeight = 760
    object Listings: TWebStringGrid
      Left = 0
      Top = 0
      Width = 400
      Height = 770
      Align = alClient
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
      Options = [goColSizing, goRowSelect]
      ParentFont = False
      TabOrder = 0
      StyleElements = []
      ElementFont = efCSS
      FixedFont.Charset = DEFAULT_CHARSET
      FixedFont.Color = clWindowText
      FixedFont.Height = -12
      FixedFont.Name = 'Segoe UI'
      FixedFont.Style = []
      GridLineColor = clRed
      RangeEdit.Max = 100.000000000000000000
      RangeEdit.Step = 1.000000000000000000
      HeightStyle = ssPercent
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
      OnClickCell = ListingsClickCell
      ExplicitHeight = 760
    end
  end
  object WebMessageDlg1: TWebMessageDlg
    Left = 304
    Top = 494
    Width = 24
    Height = 24
    Buttons = []
    CustomButtons = <>
    DialogText.Strings = (
      'Warning'
      'Error'
      'Information'
      'Confirm'
      'Custom'
      'OK'
      'Cancel'
      'Yes'
      'No'
      'Abort'
      'Retry'
      'Ignore'
      'All'
      'Yes to all'
      'No to all'
      'Help'
      'Close')
    Opacity = 0.200000000000000000
    ElementButtonClassName = 'btn'
    ElementDialogClassName = 'shadow-lg p-3 mb-5 bg-white rounded'
    ElementTitleClassName = 'text-body'
    ElementContentClassName = 'text-body'
  end
  object pnlOptions: TWebPanel
    Left = 0
    Top = 30
    Width = 400
    Height = 770
    ElementClassName = 'card'
    HeightStyle = ssPercent
    Align = alClient
    ChildOrder = 9
    ElementBodyClassName = 'card-body'
    ElementFont = efCSS
    TabOrder = 5
    ExplicitTop = 40
    ExplicitHeight = 760
    object WebButton1: TWebButton
      Left = 32
      Top = 228
      Width = 190
      Height = 38
      Align = alCustom
      Caption = 'Refresh EPG'
      ChildOrder = 1
      ElementClassName = 'btn btn-primary'
      ElementFont = efCSS
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Segoe UI'
      Font.Style = []
      HeightStyle = ssAuto
      HeightPercent = 6.000000000000000000
      ParentFont = False
      Role = 'button'
      WidthPercent = 100.000000000000000000
      OnClick = WebButton1Click
    end
    object WebGroupBox1: TWebGroupBox
      Left = 15
      Top = 22
      Width = 238
      Height = 76
      ElementClassName = 'btn-group'
      WidthPercent = 25.000000000000000000
      Align = alCustom
      BorderColor = clSilver
      Caption = '   <h6>EPG Days Displayed</h6>'
      ElementFont = efCSS
      object seNumDisplayDays: TWebSpinEdit
        AlignWithMargins = True
        Left = 57
        Top = 24
        Width = 124
        Height = 28
        Margins.Left = 57
        Margins.Top = 24
        Margins.Right = 57
        Margins.Bottom = 24
        ElementClassName = 'form-control'
        Align = alClient
        AutoSize = True
        BorderStyle = bsNone
        Color = clBtnFace
        Increment = 1
        MaxValue = 20
        MinValue = 1
        Role = ''
        Value = 1
        OnChange = seNumDisplayDaysChange
      end
    end
    object WebGroupBox3: TWebGroupBox
      Left = 15
      Top = 115
      Width = 238
      Height = 76
      ElementClassName = 'btn-group'
      WidthPercent = 25.000000000000000000
      Align = alCustom
      BorderColor = clSilver
      Caption = '   <h6>History Events Displayed</h6>'
      ElementFont = efCSS
      object seNumHistEvents: TWebSpinEdit
        AlignWithMargins = True
        Left = 57
        Top = 24
        Width = 124
        Height = 28
        Margins.Left = 57
        Margins.Top = 24
        Margins.Right = 57
        Margins.Bottom = 24
        ElementClassName = 'form-control'
        Align = alClient
        AutoSize = True
        BorderStyle = bsNone
        Color = clBtnFace
        Increment = 100
        MaxValue = 8000
        MinValue = 100
        Role = ''
        Value = 100
        OnChange = seNumHistEventsChange
      end
    end
    object WebButton2: TWebButton
      Left = 32
      Top = 274
      Width = 190
      Height = 38
      Align = alCustom
      Caption = 'Refresh History'
      ChildOrder = 1
      ElementClassName = 'btn btn-secondary'
      ElementFont = efCSS
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Segoe UI'
      Font.Style = []
      HeightStyle = ssAuto
      HeightPercent = 6.000000000000000000
      ParentFont = False
      Role = 'button'
      WidthPercent = 100.000000000000000000
      OnClick = WebButton2Click
    end
    object WebButton3: TWebButton
      Left = 32
      Top = 319
      Width = 190
      Height = 38
      Align = alCustom
      Caption = 'Change HTPC Account'
      ChildOrder = 1
      ElementClassName = 'btn btn-secondary'
      ElementFont = efCSS
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Segoe UI'
      Font.Style = []
      HeightStyle = ssAuto
      HeightPercent = 6.000000000000000000
      ParentFont = False
      Role = 'button'
      WidthPercent = 100.000000000000000000
      OnClick = WebButton3Click
    end
  end
  object WIDBCDS: TWebIndexedDbClientDataset
    IDBDatabaseName = 'CWRDB'
    IDBObjectStoreName = 'epg'
    IDBKeyFieldName = 'id'
    IDBAutoIncrement = True
    Params = <>
    OnIDBError = WIDBCDSIDBError
    AfterOpen = WIDBCDSAfterOpen
    Left = 472
    Top = 88
  end
  object WebRESTClient1: TWebRESTClient
    LoginHeight = 480
    LoginWidth = 400
    PersistTokens.Key = 'GoogleToken'
    PersistTokens.Enabled = True
    Left = 472
    Top = 168
  end
end
