object CWRmainFrm: TCWRmainFrm
  Width = 612
  Height = 999
  CSSLibrary = cssBootstrap
  ElementFont = efCSS
  OnCreate = WebFormCreate
  object AlertLabel: TWebButton
    Left = 0
    Top = 0
    Width = 612
    Height = 27
    Margins.Left = 19
    Margins.Top = 24
    Margins.Right = 19
    Margins.Bottom = 19
    Align = alTop
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
    HeightPercent = 100.000000000000000000
    ParentFont = False
    Visible = False
    WidthPercent = 100.000000000000000000
  end
  object WebRadioGroup1: TWebRadioGroup
    Left = 0
    Top = 27
    Width = 612
    Height = 23
    WidthStyle = ssPercent
    Align = alTop
    Caption = ''
    ChildOrder = 5
    Columns = 5
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
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
  object pnlHistory: TWebPanel
    Left = 0
    Top = 50
    Width = 612
    Height = 949
    ElementClassName = 'card'
    Align = alClient
    ChildOrder = 11
    ElementBodyClassName = 'card-body'
    ElementFont = efCSS
    TabOrder = 3
    object HistoryTable: TWebStringGrid
      Left = 0
      Top = 0
      Width = 612
      Height = 949
      Align = alClient
      ColCount = 32
      DefaultColWidth = 61
      DefaultRowHeight = 23
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
    Top = 50
    Width = 612
    Height = 949
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
      Width = 606
      Height = 943
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
    Left = 304
    Top = 494
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
    Top = 50
    Width = 612
    Height = 949
    ElementClassName = 'card'
    Align = alClient
    ChildOrder = 9
    ElementBodyClassName = 'card-body'
    ElementFont = efCSS
    TabOrder = 6
    object AllCapsGrid: TWebStringGrid
      Left = 0
      Top = 0
      Width = 612
      Height = 949
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      ColCount = 26
      DefaultColWidth = 61
      DefaultRowHeight = 23
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
      OnGetCellData = AllCapsGridGetCellData
    end
  end
  object WebPanel1: TWebPanel
    Left = 0
    Top = 50
    Width = 612
    Height = 949
    ElementClassName = 'card'
    Align = alClient
    ChildOrder = 10
    ElementBodyClassName = 'card-body'
    ElementFont = efCSS
    TabOrder = 7
    object WebMemo1: TWebMemo
      Left = 0
      Top = 23
      Width = 612
      Height = 926
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
      SelStart = 57
      WidthPercent = 100.000000000000000000
    end
    object WebProgressBar1: TWebProgressBar
      Left = 0
      Top = 0
      Width = 612
      Height = 23
      ElementClassName = 'progress'
      Align = alTop
      ChildOrder = 2
      ElementBarClassName = 'progress-bar'
      Value = pbvAbsolute
    end
  end
  object pnlListings: TWebPanel
    Left = 0
    Top = 50
    Width = 612
    Height = 949
    ElementClassName = 'card'
    Align = alClient
    ChildOrder = 9
    ElementBodyClassName = 'card-body'
    ElementFont = efCSS
    TabOrder = 2
    object WebGridPanel2: TWebGridPanel
      Left = 0
      Top = 783
      Width = 612
      Height = 166
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
          Value = 10
        end
        item
          Value = 20
        end
        item
          Value = 70
        end>
      object lb12Description: TWebLabel
        Left = 2
        Top = 52
        Width = 608
        Height = 112
        Align = alClient
        AutoSize = False
        Caption = 'Description'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        HeightStyle = ssAuto
        HeightPercent = 200.000000000000000000
        HTMLType = tDIV
        ParentFont = False
        WordWrap = True
        WidthPercent = 800.000000000000000000
      end
      object WebGridPanel3: TWebGridPanel
        Left = 2
        Top = 2
        Width = 608
        Height = 13
        ElementID = 'WebGridPanel3'
        HeightStyle = ssAuto
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
          Height = 9
          Align = alClient
          AutoSize = False
          Caption = 'Title'
          ElementLabelClassName = 'text-body'
          ElementID = 'lb01Title'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          HeightStyle = ssAuto
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
          Height = 9
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'New'
          ElementID = 'lb02New'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          HeightStyle = ssAuto
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
          Height = 9
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Stereo'
          ElementID = 'lb03Stereo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          HeightStyle = ssAuto
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
          Height = 9
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'HD'
          ElementID = 'lb04HD'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          HeightStyle = ssAuto
          HeightPercent = 100.000000000000000000
          HTMLType = tSPAN
          Layout = tlCenter
          ParentFont = False
          WidthPercent = 100.000000000000000000
        end
      end
      object WebGridPanel4: TWebGridPanel
        Left = 2
        Top = 19
        Width = 608
        Height = 29
        ElementID = 'WebGridPanel4'
        HeightStyle = ssAuto
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
          Height = 25
          Align = alClient
          AutoSize = False
          Caption = 'SubTitle'
          ElementID = 'lb06SubTitle'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
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
          Height = 25
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
            Height = 8
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
              Height = 4
              Align = alClient
              Alignment = taCenter
              AutoSize = False
              Caption = 'Dolby'
              ElementID = 'lb07Dolby'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
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
              Height = 4
              Align = alClient
              Alignment = taCenter
              AutoSize = False
              Caption = 'CC'
              ElementID = 'lb08CC'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
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
              Height = 4
              Align = alClient
              Alignment = taCenter
              AutoSize = False
              Caption = 'OrigDate'
              ElementID = 'lb09OrigDate'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
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
            Top = 14
            Width = 202
            Height = 8
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
              Height = 4
              Align = alClient
              Alignment = taCenter
              AutoSize = False
              Caption = 'Channel'
              ElementID = 'lb10Channel'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
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
              Height = 4
              Align = alClient
              Alignment = taCenter
              AutoSize = False
              Caption = 'Time'
              ElementID = 'lb11Time'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
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
      Width = 604
      Height = 777
      Margins.Left = 5
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Color = clCream
      ColCount = 15
      DefaultColWidth = 57
      DefaultRowHeight = 17
      DrawingStyle = gdsClassic
      FixedCols = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
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
      Width = 612
      Height = 783
      Align = alClient
      BorderStyle = bsNone
      Color = clCream
      DefaultColWidth = 61
      DefaultRowHeight = 23
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
      Width = 612
      Height = 783
      Align = alClient
      ColCount = 14
      DefaultColWidth = 61
      DefaultRowHeight = 23
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
  object pnlOptions: TWebPanel
    Left = 0
    Top = 50
    Width = 612
    Height = 949
    ElementClassName = 'card'
    Align = alClient
    ChildOrder = 9
    ElementBodyClassName = 'card-body'
    ElementFont = efCSS
    TabOrder = 8
    object WebButton1: TWebButton
      Left = 32
      Top = 228
      Width = 190
      Height = 19
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
      Left = 15
      Top = 22
      Width = 238
      Height = 76
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
    object WebGroupBox3: TWebGroupBox
      Left = 15
      Top = 115
      Width = 238
      Height = 76
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
      Left = 32
      Top = 274
      Width = 190
      Height = 19
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
