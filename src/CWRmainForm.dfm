object CWRmainFrm: TCWRmainFrm
  CSSLibrary = cssBootstrap
  Color = clWhite
  ElementClassName = 'container-fluid'
  ElementFont = efCSS
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Size = 8
  Font.Style = []
  FormStyle = fsNormal
  Height = 800
  Left = 0
  OnCreate = WebFormCreate
  ParentFont = False
  TabOrder = 0
  Top = 0
  Width = 400
  object pnlHistory: TWebPanel
    Align = alClient
    ChildOrder = 11
    Color = clBtnFace
    ElementBodyClassName = 'card-body'
    ElementClassName = 'card'
    ElementFont = efCSS
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Size = 8
    Font.Style = []
    Height = 800
    HeightStyle = ssPercent
    Left = 0
    ParentFont = False
    ShowCaption = False
    TabOrder = 1
    TabStop = False
    Top = 30
    Width = 400
    WidthStyle = ssPercent
    object HistoryTable: TWebStringGrid
      Align = alClient
      ColCount = 32
      DefaultColWidth = 61
      DefaultRowHeight = 23
      ElementFont = efCSS
      FixedCols = 0
      FixedFont.Charset = DEFAULT_CHARSET
      FixedFont.Color = clWindowText
      FixedFont.Height = -12
      FixedFont.Name = 'Segoe UI'
      FixedFont.Size = 9
      FixedFont.Style = []
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Size = 8
      Font.Style = []
      Height = 798
      HeightStyle = ssPercent
      Left = 0
      OnFixedCellClick = HistoryTableFixedCellClick
      Options = [goRowSelect, goFixedRowClick]
      RowCount = 5
      StyleElements = []
      TabOrder = 0
      Top = 0
      Width = 383
    end
  end
  object pnlLog: TWebPanel
    Align = alClient
    ChildOrder = 9
    Color = clBtnFace
    ElementBodyClassName = 'card-body'
    ElementClassName = 'card'
    ElementFont = efCSS
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Size = 8
    Font.Style = []
    Height = 800
    HeightStyle = ssPercent
    Left = 0
    TabOrder = 2
    TabStop = False
    Top = 30
    Width = 400
    object WebMemo2: TWebMemo
      Align = alClient
      AlignWithMargins = True
      AutoSize = False
      Color = clWindow
      ElementFont = efCSS
      ElementID = 'content'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Size = 8
      Font.Style = []
      Height = 798
      HeightStyle = ssPercent
      Left = 3
      ReadOnly = True
      SelLength = 0
      SelStart = 0
      ShowFocus = True
      TabOrder = 0
      Top = 3
      Width = 398
      WidthStyle = ssPercent
    end
  end
  object pnlCaptures: TWebPanel
    Align = alClient
    ChildOrder = 9
    Color = clBtnFace
    ElementBodyClassName = 'card-body'
    ElementClassName = 'card'
    ElementFont = efCSS
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Size = 8
    Font.Style = []
    Height = 800
    HeightStyle = ssPercent
    Left = 0
    ParentFont = False
    ShowCaption = False
    TabOrder = 3
    TabStop = False
    Top = 30
    Width = 400
    WidthStyle = ssPercent
    object AllCapsGrid: TWebStringGrid
      Align = alClient
      ColCount = 5
      DefaultRowHeight = 22
      FixedFont.Charset = ANSI_CHARSET
      FixedFont.Color = clBlack
      FixedFont.Height = -11
      FixedFont.Name = 'Arial'
      FixedFont.Size = 8
      FixedFont.Style = []
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Size = 8
      Font.Style = []
      Height = 798
      HeightStyle = ssPercent
      Left = 0
      Options = [goVertLine, goHorzLine, goRangeSelect]
      RowCount = 5
      StyleElements = []
      TabOrder = 0
      Top = 0
      Width = 383
    end
  end
  object WebPanel1: TWebPanel
    Align = alClient
    ChildOrder = 10
    Color = clBtnFace
    ElementBodyClassName = 'card-body'
    ElementClassName = 'container-fluid'
    ElementFont = efCSS
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Size = 8
    Font.Style = []
    Height = 800
    HeightStyle = ssPercent
    Left = 0
    TabOrder = 4
    TabStop = False
    Top = 30
    Width = 400
    object WebMemo1: TWebMemo
      Align = alClient
      AutoSize = False
      Color = clYellow
      ElementFont = efCSS
      ElementID = 'WebMemo1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
      Font.Name = 'Segoe UI'
      Font.Size = 24
      Font.Style = []
      Height = 762
      Left = 0
      Lines.Strings = (
        '   '
        '   Preparing EPG Display'
        '  '
        '   Please Wait . . .')
      Margins.Bottom = 228
      Margins.Left = 19
      Margins.Right = 19
      Margins.Top = 38
      ParentFont = False
      ReadOnly = True
      SelLength = 0
      SelStart = 52
      ShowFocus = True
      TabOrder = 0
      Top = 23
      Width = 400
    end
    object WebProgressBar1: TWebProgressBar
      Align = alTop
      ElementBarClassName = 'progress-bar'
      ElementClassName = 'progress'
      Height = 23
      Left = 0
      Max = 100
      Min = 0
      Position = 0
      Style = pbstNormal
      Top = 0
      Value = pbvAbsolute
      Width = 400
    end
  end
  object WebStringGrid1: TWebStringGrid
    Align = alClient
    AlignWithMargins = True
    ColCount = 5
    DefaultRowHeight = 22
    FixedFont.Charset = ANSI_CHARSET
    FixedFont.Color = clBlack
    FixedFont.Height = -11
    FixedFont.Name = 'Arial'
    FixedFont.Size = 8
    FixedFont.Style = []
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Size = 8
    Font.Style = []
    Height = 764
    Left = 5
    Margins.Left = 5
    Options = [goVertLine, goHorzLine, goRangeSelect]
    RowCount = 5
    StyleElements = []
    TabOrder = 6
    Top = 33
    Width = 392
  end
  object WebStringGrid2: TWebStringGrid
    Align = alClient
    BorderStyle = bsNone
    ColCount = 5
    DefaultRowHeight = 22
    FixedFont.Charset = ANSI_CHARSET
    FixedFont.Color = clBlack
    FixedFont.Height = -11
    FixedFont.Name = 'Arial'
    FixedFont.Size = 8
    FixedFont.Style = []
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Size = 8
    Font.Style = []
    Height = 770
    Left = 0
    Options = [goVertLine, goHorzLine, goRangeSelect]
    RowCount = 5
    StyleElements = []
    TabOrder = 8
    Top = 30
    Width = 400
  end
  object NewCapturesTable: TWebStringGrid
    ColCount = 7
    DefaultRowHeight = 22
    FixedCols = 0
    FixedFont.Charset = ANSI_CHARSET
    FixedFont.Color = clBlack
    FixedFont.Height = -11
    FixedFont.Name = 'Arial'
    FixedFont.Size = 8
    FixedFont.Style = []
    FixedRows = 0
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Size = 8
    Font.Style = []
    Height = 225
    Left = 32
    Options = [goVertLine, goHorzLine, goRangeSelect]
    RowCount = 5
    StyleElements = []
    TabOrder = 0
    Top = 440
    Visible = False
    Width = 553
  end
  object WebPanel3: TWebPanel
    Align = alTop
    Caption = 'WebPanel3'
    ChildOrder = 12
    Color = clBtnFace
    ElementClassName = 'container'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Size = 8
    Font.Style = []
    Height = 30
    Left = 0
    ShowCaption = False
    TabOrder = 10
    TabStop = False
    Top = 0
    Width = 400
    WidthStyle = ssPercent
    object AlertLabel: TWebButton
      Align = alClient
      Caption = 
        'Refreshing CW_EPG data <i class="fa-solid fa-spinner fa-spin"></' +
        '>'
      Color = clYellow
      ElementClassName = 'form-control'
      ElementFont = efCSS
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Size = 14
      Font.Style = []
      Height = 38
      HeightStyle = ssAuto
      Left = 0
      Margins.Bottom = 19
      Margins.Left = 19
      Margins.Right = 19
      Margins.Top = 24
      ParentFont = False
      Role = 'button'
      TabOrder = 0
      Top = 0
      Visible = False
      Width = 400
      WidthStyle = ssPercent
    end
    object WebRadioGroup1: TWebRadioGroup
      Align = alClient
      ChildOrder = 5
      Columns = 5
      ElementButtonClassName = 'custom-control-input'
      ElementClassName = 'custom-control custom-radio'
      ElementFont = efCSS
      ElementGroupClassName = 'modal-content'
      ElementLabelClassName = 'custom-control-label'
      ElementLegendClassName = 'h6'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Size = 8
      Font.Style = []
      Height = 30
      HeightStyle = ssPercent
      ItemIndex = 0
      Items.Strings = (
        'Listings'
        'Schedule'
        'History'
        'Log'
        'Options')
      Left = 0
      OnChange = WebRadioGroup1Change
      ParentFont = False
      TabOrder = 1
      Top = 0
      Width = 400
      WidthStyle = ssPercent
    end
  end
  object pnlListings: TWebPanel
    Align = alClient
    Caption = 'pnlListings'
    ChildOrder = 11
    Color = clBtnFace
    ElementBodyClassName = 'card-body'
    ElementClassName = 'card'
    ElementFont = efCSS
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Size = 9
    Font.Style = []
    Height = 800
    HeightStyle = ssPercent
    Left = 0
    ParentFont = False
    ShowCaption = False
    TabOrder = 7
    TabStop = False
    Top = 30
    Width = 400
    WidthStyle = ssPercent
    object Listings: TWebStringGrid
      Align = alClient
      ColCount = 14
      DefaultColWidth = 61
      DefaultRowHeight = 23
      ElementFont = efCSS
      FixedCols = 0
      FixedFont.Charset = DEFAULT_CHARSET
      FixedFont.Color = clWindowText
      FixedFont.Height = -12
      FixedFont.Name = 'Segoe UI'
      FixedFont.Size = 9
      FixedFont.Style = []
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Size = 9
      Font.Style = []
      Height = 798
      HeightStyle = ssPercent
      Left = 0
      OnClickCell = ListingsClickCell
      OnFixedCellClick = ListingsFixedCellClick
      Options = [goColSizing, goRowSelect]
      ParentFont = False
      RowCount = 20
      StyleElements = []
      TabOrder = 0
      Top = 0
      Width = 383
    end
  end
  object pnlOptions: TWebPanel
    Align = alClient
    ChildOrder = 9
    Color = clBtnFace
    ElementBodyClassName = 'card-body'
    ElementClassName = 'card'
    ElementFont = efCSS
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Size = 8
    Font.Style = []
    Height = 800
    HeightStyle = ssPercent
    Left = 0
    TabOrder = 5
    TabStop = False
    Top = 30
    Width = 400
    object WebButton1: TWebButton
      Align = alCustom
      Caption = 'Refresh EPG'
      ChildOrder = 1
      Color = clNone
      ElementClassName = 'btn btn-primary'
      ElementFont = efCSS
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Segoe UI'
      Font.Size = 7
      Font.Style = []
      Height = 38
      HeightPercent = 6
      HeightStyle = ssAuto
      Left = 32
      OnClick = WebButton1Click
      ParentFont = False
      Role = 'button'
      TabOrder = 0
      Top = 228
      Width = 190
    end
    object WebGroupBox1: TWebGroupBox
      Align = alCustom
      Caption = 'EPG Days Displayed'
      Color = clBtnFace
      ElementClassName = 'btn-group'
      ElementFont = efCSS
      ElementLegendClassName = 'h6'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Size = 8
      Font.Style = []
      Height = 87
      Left = 15
      Top = 22
      Width = 238
      WidthPercent = 25
      object seNumDisplayDays: TWebSpinEdit
        Align = alClient
        AlignWithMargins = True
        AutoSize = False
        BorderStyle = bsNone
        Color = clBtnFace
        ElementClassName = 'form-control'
        ElementFont = efCSS
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Height = 38
        HeightStyle = ssAuto
        Increment = 1
        Left = 57
        Margins.Bottom = 24
        Margins.Left = 57
        Margins.Right = 57
        Margins.Top = 24
        MaxValue = 20
        MinValue = 1
        OnChange = seNumDisplayDaysChange
        ShowFocus = True
        TabOrder = 0
        Top = 24
        Value = 1
        Width = 124
      end
    end
    object WebGroupBox3: TWebGroupBox
      Align = alCustom
      Caption = 'History Events Displayed'
      Color = clBtnFace
      ElementClassName = 'btn-group'
      ElementFont = efCSS
      ElementLegendClassName = 'h6'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Size = 8
      Font.Style = []
      Height = 86
      Left = 15
      Top = 115
      Width = 238
      WidthPercent = 25
      object seNumHistEvents: TWebSpinEdit
        Align = alClient
        AlignWithMargins = True
        AutoSize = True
        BorderStyle = bsNone
        Color = clBtnFace
        ElementClassName = 'form-control'
        ElementFont = efCSS
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Height = 38
        Increment = 100
        Left = 57
        Margins.Bottom = 24
        Margins.Left = 57
        Margins.Right = 57
        Margins.Top = 24
        MaxValue = 8000
        MinValue = 100
        OnChange = seNumHistEventsChange
        ShowFocus = True
        TabOrder = 0
        Top = 24
        Value = 100
        Width = 124
      end
    end
    object WebButton2: TWebButton
      Align = alCustom
      Caption = 'Refresh History'
      ChildOrder = 1
      Color = clNone
      ElementClassName = 'btn btn-secondary'
      ElementFont = efCSS
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Segoe UI'
      Font.Size = 7
      Font.Style = []
      Height = 38
      HeightPercent = 6
      HeightStyle = ssAuto
      Left = 32
      OnClick = WebButton2Click
      ParentFont = False
      Role = 'button'
      TabOrder = 0
      Top = 274
      Width = 190
    end
    object WebButton3: TWebButton
      Align = alCustom
      Caption = 'Change HTPC Account'
      ChildOrder = 1
      Color = clNone
      ElementClassName = 'btn btn-secondary'
      ElementFont = efCSS
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -9
      Font.Name = 'Segoe UI'
      Font.Size = 7
      Font.Style = []
      Height = 38
      HeightPercent = 6
      HeightStyle = ssAuto
      Left = 32
      OnClick = WebButton3Click
      ParentFont = False
      Role = 'button'
      TabOrder = 0
      Top = 319
      Width = 190
    end
  end
  object WebMessageDlg1: TWebMessageDlg
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
    ElementButtonClassName = 'btn'
    ElementContentClassName = 'text-body'
    ElementDialogClassName = 'shadow-lg p-3 mb-5 bg-white rounded'
    ElementTitleClassName = 'text-body'
    Height = 24
    Left = 304
    Opacity = 0.200000000000000000
    Top = 494
    Width = 24
    Left = 304
    Top = 494
  end
  object WIDBCDS: TWebIndexedDbClientDataset
    AfterOpen = WIDBCDSAfterOpen
    IDBAutoIncrement = True
    IDBDatabaseName = 'CWRDB'
    IDBKeyFieldName = 'id'
    IDBObjectStoreName = 'epg'
    OnIDBError = WIDBCDSIDBError
    Params = <>
    Left = 472
    Top = 88
  end
  object WebRESTClient1: TWebRESTClient
    LoginHeight = 480
    LoginWidth = 400
    PersistTokens.Enabled = True
    PersistTokens.Key = 'GoogleToken'
    Left = 472
    Top = 168
  end
end
