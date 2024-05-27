object CWRmainFrm: TCWRmainFrm
  Width = 644
  Height = 1052
  CSSLibrary = cssBootstrap
  ElementFont = efCSS
  OnCreate = WebFormCreate
  object AlertLabel: TWebButton
    Left = 0
    Top = 0
    Width = 644
    Height = 28
    Margins.Left = 20
    Margins.Top = 25
    Margins.Right = 20
    Margins.Bottom = 20
    Align = alTop
    Caption = 
      'Refreshing CW_EPG data <i class="fa-solid fa-spinner fa-spin"></' +
      '>'
    Color = clYellow
    ElementFont = efCSS
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Segoe UI'
    Font.Style = []
    HeightPercent = 100.000000000000000000
    ParentFont = False
    Visible = False
    WidthPercent = 100.000000000000000000
  end
  object WebRadioGroup1: TWebRadioGroup
    Left = 0
    Top = 28
    Width = 644
    Height = 25
    WidthStyle = ssPercent
    Align = alTop
    Caption = ''
    ChildOrder = 5
    Columns = 5
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ItemIndex = 0
    Items.Strings = (
      'List'
      'Sched'
      'History'
      'Log'
      'Options')
    ParentFont = False
    Role = ''
    TabOrder = 1
    OnChange = WebRadioGroup1Change
  end
  object pnlListings: TWebPanel
    Left = 0
    Top = 53
    Width = 644
    Height = 999
    ElementClassName = 'card'
    Align = alClient
    ChildOrder = 9
    ElementBodyClassName = 'card-body'
    ElementFont = efCSS
    TabOrder = 2
    object WebGridPanel2: TWebGridPanel
      Left = 0
      Top = 824
      Width = 644
      Height = 175
      ElementID = 'WebGridPanel2'
      WidthStyle = ssPercent
      HeightPercent = 15.000000000000000000
      Align = alBottom
      ChildOrder = 3
      ColumnCollection = <
        item
          Value = 100
        end>
      ControlCollection = <
        item
          Column = 0
          Row = 0
          Control = WebGridPanel3
        end
        item
          Column = 0
          Row = 0
          Control = WebGridPanel4
        end
        item
          Column = 0
          Row = 0
          Control = lb12Description
        end>
      Color = clWhite
      GridLineColor = clBlack
      RowCollection = <
        item
          SizeStyle = ssAbsolute
          Value = 25
        end
        item
          SizeStyle = ssAbsolute
          Value = 55
        end
        item
          SizeStyle = ssAbsolute
          Value = 60
        end>
      object lb12Description: TWebLabel
        Left = 2
        Top = 82
        Width = 640
        Height = 56
        Align = alClient
        AutoSize = False
        Caption = 'Description'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        HeightPercent = 200.000000000000000000
        HTMLType = tDIV
        ParentFont = False
        WordWrap = True
        WidthPercent = 800.000000000000000000
      end
      object WebGridPanel3: TWebGridPanel
        Left = 2
        Top = 2
        Width = 640
        Height = 21
        ElementID = 'WebGridPanel3'
        Align = alClient
        ColumnCollection = <
          item
            SizeStyle = ssAbsolute
            Value = 424
          end
          item
            SizeStyle = ssAbsolute
            Value = 70
          end
          item
            SizeStyle = ssAbsolute
            Value = 70
          end
          item
            SizeStyle = ssAbsolute
            Value = 70
          end>
        ControlCollection = <
          item
            Column = 0
            Row = 0
            Control = lb01Title
          end
          item
            Column = 0
            Row = 0
            Control = lb02New
          end
          item
            Column = 0
            Row = 0
            Control = lb03Stereo
          end
          item
            Column = 0
            Row = 0
            Control = lb04HD
          end>
        Color = clWhite
        GridLineColor = clBlack
        RowCollection = <
          item
            Value = 100
          end>
        object lb01Title: TWebLabel
          Left = 2
          Top = 2
          Width = 420
          Height = 17
          Align = alClient
          AutoSize = False
          Caption = 'Title'
          ElementLabelClassName = 'text-body'
          ElementID = 'lb01Title'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          HeightPercent = 100.000000000000000000
          HTMLType = tSPAN
          Layout = tlCenter
          ParentFont = False
          WordWrap = True
          WidthPercent = 400.000000000000000000
        end
        object lb02New: TWebLabel
          Left = 426
          Top = 2
          Width = 66
          Height = 17
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'New'
          ElementID = 'lb02New'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          HeightPercent = 100.000000000000000000
          HTMLType = tSPAN
          Layout = tlCenter
          ParentFont = False
          WidthPercent = 100.000000000000000000
        end
        object lb03Stereo: TWebLabel
          Left = 496
          Top = 2
          Width = 66
          Height = 17
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Stereo'
          ElementID = 'lb03Stereo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          HeightPercent = 100.000000000000000000
          HTMLType = tSPAN
          Layout = tlCenter
          ParentFont = False
          WidthPercent = 100.000000000000000000
        end
        object lb04HD: TWebLabel
          Left = 566
          Top = 2
          Width = 66
          Height = 17
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'HD'
          ElementID = 'lb04HD'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          HeightPercent = 100.000000000000000000
          HTMLType = tSPAN
          Layout = tlCenter
          ParentFont = False
          WidthPercent = 100.000000000000000000
        end
      end
      object WebGridPanel4: TWebGridPanel
        Left = 2
        Top = 27
        Width = 640
        Height = 51
        ElementID = 'WebGridPanel4'
        HeightStyle = ssPercent
        Align = alClient
        ChildOrder = 1
        ColumnCollection = <
          item
            SizeStyle = ssAbsolute
            Value = 424
          end
          item
            SizeStyle = ssAbsolute
            Value = 210
          end>
        ControlCollection = <
          item
            Column = 0
            Row = 0
            Control = lb06SubTitle
          end
          item
            Column = 0
            Row = 0
            Control = WebGridPanel1
          end>
        Color = clWhite
        GridLineColor = clBlack
        RowCollection = <
          item
            Value = 100
          end>
        object lb06SubTitle: TWebLabel
          Left = 2
          Top = 2
          Width = 420
          Height = 47
          Align = alClient
          AutoSize = False
          Caption = 'SubTitle'
          ElementID = 'lb06SubTitle'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          HeightPercent = 200.000000000000000000
          HTMLType = tSPAN
          ParentFont = False
          WordWrap = True
          WidthPercent = 500.000000000000000000
        end
        object WebGridPanel1: TWebGridPanel
          Left = 426
          Top = 2
          Width = 206
          Height = 47
          ElementID = 'WebGridPanel1'
          Align = alClient
          ChildOrder = 3
          ColumnCollection = <
            item
              Value = 100
            end>
          ControlCollection = <
            item
              Column = 0
              Row = 0
              Control = WebGridPanel7
            end
            item
              Column = 0
              Row = 0
              Control = WebGridPanel6
            end>
          Color = clWhite
          GridLineColor = clBlack
          RowCollection = <
            item
              Value = 50
            end
            item
              Value = 50
            end>
          object WebGridPanel7: TWebGridPanel
            Left = 2
            Top = 2
            Width = 202
            Height = 20
            ElementID = 'WebGridPanel7'
            Align = alClient
            ChildOrder = 4
            ColumnCollection = <
              item
                SizeStyle = ssAbsolute
                Value = 90
              end
              item
                SizeStyle = ssAbsolute
                Value = 50
              end
              item
                Alignment = taRightJustify
                SizeStyle = ssAbsolute
                Value = 70
              end>
            ControlCollection = <
              item
                Column = 0
                Row = 0
                Control = lb07Dolby
              end
              item
                Column = 0
                Row = 0
                Control = lb08CC
              end
              item
                Column = 0
                Row = 0
                Control = lb09OrigDate
              end>
            Color = clWhite
            GridLineColor = clBlack
            RowCollection = <
              item
                Value = 100
              end>
            object lb07Dolby: TWebLabel
              Left = 2
              Top = 2
              Width = 86
              Height = 16
              Align = alClient
              Alignment = taCenter
              AutoSize = False
              Caption = 'Dolby'
              ElementID = 'lb07Dolby'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Segoe UI'
              Font.Style = []
              HeightPercent = 100.000000000000000000
              HTMLType = tDIV
              Layout = tlCenter
              ParentFont = False
              WidthPercent = 100.000000000000000000
            end
            object lb08CC: TWebLabel
              Left = 92
              Top = 2
              Width = 46
              Height = 16
              Align = alClient
              Alignment = taCenter
              AutoSize = False
              Caption = 'CC'
              ElementID = 'lb08CC'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Segoe UI'
              Font.Style = []
              HeightPercent = 100.000000000000000000
              HTMLType = tSPAN
              Layout = tlCenter
              ParentFont = False
              WidthPercent = 100.000000000000000000
            end
            object lb09OrigDate: TWebLabel
              Left = 142
              Top = 2
              Width = 66
              Height = 16
              Align = alClient
              Alignment = taCenter
              AutoSize = False
              Caption = 'OrigDate'
              ElementID = 'lb09OrigDate'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Segoe UI'
              Font.Style = []
              HeightPercent = 100.000000000000000000
              HTMLType = tSPAN
              Layout = tlCenter
              ParentFont = False
              WordWrap = True
              WidthPercent = 100.000000000000000000
            end
          end
          object WebGridPanel6: TWebGridPanel
            Left = 2
            Top = 26
            Width = 202
            Height = 20
            ElementID = 'WebGridPanel6'
            Align = alClient
            ChildOrder = 4
            ColumnCollection = <
              item
                Value = 50
              end
              item
                Value = 50
              end>
            ControlCollection = <
              item
                Column = 0
                Row = 0
                Control = lb10Channel
              end
              item
                Column = 0
                Row = 0
                Control = lb11Time
              end>
            Color = clWhite
            GridLineColor = clBlack
            RowCollection = <
              item
                Value = 100
              end>
            object lb10Channel: TWebLabel
              Left = 2
              Top = 2
              Width = 97
              Height = 16
              Align = alClient
              Alignment = taCenter
              AutoSize = False
              Caption = 'Channel'
              ElementID = 'lb10Channel'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Segoe UI'
              Font.Style = []
              HeightPercent = 100.000000000000000000
              HTMLType = tSPAN
              Layout = tlCenter
              ParentFont = False
              WidthPercent = 100.000000000000000000
            end
            object lb11Time: TWebLabel
              Left = 103
              Top = 2
              Width = 97
              Height = 16
              Align = alClient
              Alignment = taCenter
              AutoSize = False
              Caption = 'Time'
              ElementID = 'lb11Time'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Segoe UI'
              Font.Style = []
              HeightPercent = 100.000000000000000000
              HTMLType = tSPAN
              Layout = tlCenter
              ParentFont = False
              WidthPercent = 200.000000000000000000
            end
          end
        end
      end
    end
    object WebStringGrid1: TWebStringGrid
      AlignWithMargins = True
      Left = 5
      Top = 3
      Width = 636
      Height = 818
      Margins.Left = 5
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Color = clCream
      ColCount = 15
      DefaultColWidth = 60
      DefaultRowHeight = 18
      DrawingStyle = gdsClassic
      FixedCols = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      Options = [goFixedVertLine, goFixedHorzLine, goRangeSelect, goRowSelect, goFixedRowDefAlign]
      ParentFont = False
      TabOrder = 1
      Visible = False
      FixedFont.Charset = DEFAULT_CHARSET
      FixedFont.Color = clWindowText
      FixedFont.Height = -12
      FixedFont.Name = 'Segoe UI'
      FixedFont.Style = []
      RangeEdit.Max = 100.000000000000000000
      RangeEdit.Step = 1.000000000000000000
      SelectionTextColor = clRed
      HeightPercent = 85.000000000000000000
      WidthStyle = ssPercent
      WidthPercent = 100.000000000000000000
    end
    object WebStringGrid2: TWebStringGrid
      Left = 0
      Top = 0
      Width = 644
      Height = 824
      Align = alClient
      BorderStyle = bsNone
      Color = clCream
      FixedCols = 0
      Options = [goRowSelect, goFixedRowDefAlign]
      TabOrder = 2
      Visible = False
      OnDblClick = WebStringGrid2DblClick
      ElementFont = efCSS
      FixedFont.Charset = DEFAULT_CHARSET
      FixedFont.Color = clWindowText
      FixedFont.Height = -12
      FixedFont.Name = 'Segoe UI'
      FixedFont.Style = []
      RangeEdit.Max = 100.000000000000000000
      RangeEdit.Step = 1.000000000000000000
      HeightPercent = 100.000000000000000000
      WidthStyle = ssAuto
      WidthPercent = 100.000000000000000000
    end
    object Listings: TWebStringGrid
      Left = 0
      Top = 0
      Width = 644
      Height = 824
      Align = alClient
      ColCount = 14
      FixedCols = 0
      Options = [goColSizing, goRowSelect]
      TabOrder = 3
      OnDblClick = ListingsDblClick
      OnSelectCell = ListingsSelectCell
      ElementFont = efCSS
      FixedFont.Charset = DEFAULT_CHARSET
      FixedFont.Color = clWindowText
      FixedFont.Height = -12
      FixedFont.Name = 'Segoe UI'
      FixedFont.Style = []
      RangeEdit.Max = 100.000000000000000000
      RangeEdit.Step = 1.000000000000000000
      HeightPercent = 80.000000000000000000
      WidthStyle = ssPercent
      WidthPercent = 100.000000000000000000
      OnClickCell = ListingsClickCell
    end
  end
  object pnlHistory: TWebPanel
    Left = 0
    Top = 53
    Width = 644
    Height = 999
    ElementClassName = 'card'
    Align = alClient
    ChildOrder = 11
    ElementBodyClassName = 'card-body'
    ElementFont = efCSS
    TabOrder = 3
    object HistoryTable: TWebStringGrid
      Left = 0
      Top = 0
      Width = 644
      Height = 999
      Align = alClient
      ColCount = 32
      FixedCols = 0
      Options = [goRowSelect, goFixedRowClick]
      TabOrder = 0
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
    end
  end
  object pnlLog: TWebPanel
    Left = 0
    Top = 53
    Width = 644
    Height = 999
    ElementClassName = 'card'
    Align = alClient
    ChildOrder = 9
    ElementBodyClassName = 'card-body'
    ElementFont = efCSS
    TabOrder = 4
    object WebMemo2: TWebMemo
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 638
      Height = 993
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
      WordWrap = False
    end
  end
  object WebMessageDlg1: TWebMessageDlg
    Left = 320
    Top = 520
    Width = 24
    Height = 24
    Buttons = []
    CustomButtons = <>
    Opacity = 0.200000000000000000
    ElementButtonClassName = 'btn'
    ElementDialogClassName = 'shadow-lg p-3 mb-5 bg-white rounded'
    ElementTitleClassName = 'text-body'
    ElementContentClassName = 'text-body'
  end
  object pnlCaptures: TWebPanel
    Left = 0
    Top = 53
    Width = 644
    Height = 999
    ElementClassName = 'card'
    Align = alClient
    ChildOrder = 9
    ElementBodyClassName = 'card-body'
    ElementFont = efCSS
    TabOrder = 6
    object AllCapsGrid: TWebStringGrid
      Left = 0
      Top = 0
      Width = 644
      Height = 999
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      ColCount = 26
      FixedCols = 0
      RowCount = 2
      Options = [goRowSelect, goFixedRowDefAlign]
      TabOrder = 0
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
      WordWrap = True
      WidthPercent = 100.000000000000000000
      OnClickCell = AllCapsGridClickCell
      OnGetCellData = AllCapsGridGetCellData
    end
  end
  object WebPanel1: TWebPanel
    Left = 0
    Top = 53
    Width = 644
    Height = 999
    ElementClassName = 'card'
    Align = alClient
    ChildOrder = 10
    ElementBodyClassName = 'card-body'
    ElementFont = efCSS
    TabOrder = 7
    object WebMemo1: TWebMemo
      Left = 0
      Top = 24
      Width = 644
      Height = 975
      Margins.Left = 20
      Margins.Top = 40
      Margins.Right = 20
      Margins.Bottom = 240
      Align = alClient
      Color = clYellow
      ElementID = 'WebMemo1'
      ElementFont = efCSS
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -34
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
      SelStart = 57
      WidthPercent = 100.000000000000000000
    end
    object WebProgressBar1: TWebProgressBar
      Left = 0
      Top = 0
      Width = 644
      Height = 24
      ElementClassName = 'progress'
      Align = alTop
      ChildOrder = 2
      ElementBarClassName = 'progress-bar'
      Value = pbvAbsolute
    end
  end
  object pnlOptions: TWebPanel
    Left = 0
    Top = 53
    Width = 644
    Height = 999
    ElementClassName = 'card'
    Align = alClient
    ChildOrder = 9
    ElementBodyClassName = 'card-body'
    ElementFont = efCSS
    TabOrder = 8
    object WebButton1: TWebButton
      Left = 24
      Top = 416
      Width = 200
      Height = 20
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
      WidthPercent = 100.000000000000000000
      OnClick = WebButton1Click
    end
    object WebGroupBox1: TWebGroupBox
      Left = 16
      Top = 117
      Width = 250
      Height = 80
      ElementClassName = 'container'
      WidthPercent = 25.000000000000000000
      Align = alCustom
      BorderColor = clSilver
      Caption = '   EPG Days Displayed'
      ChildOrder = 1
      ElementFont = efCSS
      ElementLegendClassName = 'h6'
      object seNumDisplayDays: TWebSpinEdit
        AlignWithMargins = True
        Left = 60
        Top = 25
        Width = 130
        Height = 30
        Margins.Left = 60
        Margins.Top = 25
        Margins.Right = 60
        Margins.Bottom = 25
        ElementClassName = 'form-control'
        Align = alClient
        AutoSize = True
        BiDiMode = bdRightToLeft
        BorderStyle = bsNone
        Color = clBtnFace
        ElementFont = efCSS
        Increment = 1
        MaxValue = 20
        MinValue = 1
        Role = ''
        Value = 1
        OnChange = seNumDisplayDaysChange
      end
    end
    object WebGroupBox2: TWebGroupBox
      Left = 16
      Top = 313
      Width = 250
      Height = 80
      ElementClassName = 'container'
      WidthPercent = 25.000000000000000000
      Align = alCustom
      BorderColor = clSilver
      Caption = '   Http Timeout Seconds'
      ChildOrder = 1
      ElementFont = efCSS
      ElementLegendClassName = 'h6'
      object seHttpTimeoutSec: TWebSpinEdit
        AlignWithMargins = True
        Left = 60
        Top = 25
        Width = 130
        Height = 30
        Margins.Left = 60
        Margins.Top = 25
        Margins.Right = 60
        Margins.Bottom = 25
        ElementClassName = 'form-control'
        Align = alClient
        AutoSize = True
        BiDiMode = bdRightToLeft
        BorderStyle = bsNone
        Color = clBtnFace
        ElementFont = efCSS
        Increment = 1
        MaxValue = 20
        MinValue = 1
        Role = ''
        Value = 20
        OnChange = seHttpTimeoutSecChange
      end
    end
    object WebGroupBox3: TWebGroupBox
      Left = 16
      Top = 215
      Width = 250
      Height = 80
      ElementClassName = 'container'
      WidthPercent = 25.000000000000000000
      Align = alCustom
      BorderColor = clSilver
      Caption = '   History Events Displayed'
      ChildOrder = 1
      ElementFont = efCSS
      ElementLegendClassName = 'h6'
      object seNumHistEvents: TWebSpinEdit
        AlignWithMargins = True
        Left = 60
        Top = 25
        Width = 130
        Height = 30
        Margins.Left = 60
        Margins.Top = 25
        Margins.Right = 60
        Margins.Bottom = 25
        ElementClassName = 'form-control'
        Align = alClient
        AutoSize = True
        BiDiMode = bdRightToLeft
        BorderStyle = bsNone
        Color = clBtnFace
        ElementFont = efCSS
        Increment = 100
        MaxValue = 8000
        MinValue = 100
        Role = ''
        Value = 100
        OnChange = seNumHistEventsChange
      end
    end
    object WebButton2: TWebButton
      Left = 24
      Top = 464
      Width = 200
      Height = 20
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
      WidthPercent = 100.000000000000000000
      OnClick = WebButton2Click
    end
    object WebDBGrid1: TWebDBGrid
      Left = 0
      Top = 799
      Width = 644
      Height = 200
      Align = alBottom
      Columns = <>
      DataSource = WebDataSource1
      FixedFont.Charset = DEFAULT_CHARSET
      FixedFont.Color = clWindowText
      FixedFont.Height = -12
      FixedFont.Name = 'Segoe UI'
      FixedFont.Style = []
      FixedCols = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goFixedRowDefAlign]
      TabOrder = 5
      HeightStyle = ssPercent
      HeightPercent = 50.000000000000000000
      Visible = False
      WidthPercent = 100.000000000000000000
      ColWidths = (
        24)
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
  object WebHttpRequest1: TWebHttpRequest
    Timeout = 5000
    OnAbort = WebHttpRequest1Abort
    OnError = WebHttpRequest1Error
    OnTimeout = WebHttpRequest1Timeout
    Left = 304
    Top = 512
  end
  object WebLocalStorage1: TWebLocalStorage
    Left = 232
    Top = 480
  end
  object WebClientDataSet1: TWebClientDataSet
    Connection = WebClientConnection1
    AfterOpen = WebClientDataSet1AfterOpen
    Params = <>
    Left = 240
    Top = 640
  end
  object WebClientConnection1: TWebClientConnection
    Active = False
    Delimiter = ';'
    URI = 'http://localhost:8181/getdbfile?filename=cwr_epg.csv'
    Left = 356
    Top = 584
  end
  object WebDataSource1: TWebDataSource
    DataSet = WebClientDataSet1
    Left = 256
    Top = 568
  end
  object WebRESTClient1: TWebRESTClient
    App.ClientID = 
      '654508083810-kdj6ob7srm922egkvdmcj36hfa1hitav.apps.googleusercon' +
      'tent.com'
    App.Key = 'AIzaSyAtOV4eHHqYrr4E8qJ2pPhz0V-hSHZDKg0'
    App.CallbackURL = 'http://localhost:8000/Project1/Project1.html'
    LoginHeight = 480
    LoginWidth = 400
    PersistTokens.Key = 'GoogleToken'
    PersistTokens.Enabled = True
    Left = 472
    Top = 168
  end
end
