object CWRmainFrm: TCWRmainFrm
  Width = 493
  Height = 999
  CSSLibrary = cssBootstrap
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
    Width = 493
    Height = 969
    ElementClassName = 'card'
    Align = alClient
    ChildOrder = 11
    ElementBodyClassName = 'card-body'
    ElementFont = efCSS
    TabOrder = 1
    ExplicitWidth = 612
    object HistoryTable: TWebStringGrid
      Left = 0
      Top = 0
      Width = 493
      Height = 969
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
      ExplicitWidth = 612
    end
  end
  object pnlLog: TWebPanel
    Left = 0
    Top = 30
    Width = 493
    Height = 969
    ElementClassName = 'card'
    Align = alClient
    ChildOrder = 9
    ElementBodyClassName = 'card-body'
    ElementFont = efCSS
    TabOrder = 2
    ExplicitWidth = 612
    object WebMemo2: TWebMemo
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 487
      Height = 963
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
      ExplicitWidth = 606
    end
  end
  object pnlCaptures: TWebPanel
    Left = 0
    Top = 30
    Width = 493
    Height = 969
    ElementClassName = 'card'
    Align = alClient
    ChildOrder = 9
    ElementBodyClassName = 'card-body'
    ElementFont = efCSS
    TabOrder = 3
    ExplicitWidth = 612
    object AllCapsGrid: TWebStringGrid
      Left = 0
      Top = 0
      Width = 493
      Height = 969
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
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
      ExplicitWidth = 612
    end
  end
  object WebPanel1: TWebPanel
    Left = 0
    Top = 30
    Width = 493
    Height = 969
    ElementClassName = 'card'
    Align = alClient
    ChildOrder = 10
    ElementBodyClassName = 'card-body'
    ElementFont = efCSS
    TabOrder = 4
    ExplicitWidth = 612
    object WebMemo1: TWebMemo
      Left = 0
      Top = 23
      Width = 493
      Height = 946
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
      ExplicitWidth = 612
    end
    object WebProgressBar1: TWebProgressBar
      Left = 0
      Top = 0
      Width = 493
      Height = 23
      ElementClassName = 'progress'
      Align = alTop
      ElementBarClassName = 'progress-bar'
      Value = pbvAbsolute
      ExplicitWidth = 612
    end
  end
  object WebStringGrid1: TWebStringGrid
    AlignWithMargins = True
    Left = 5
    Top = 33
    Width = 485
    Height = 963
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
    ExplicitWidth = 604
  end
  object WebStringGrid2: TWebStringGrid
    Left = 0
    Top = 30
    Width = 493
    Height = 969
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
    ExplicitWidth = 612
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
    Width = 493
    Height = 969
    ElementClassName = 'card'
    Align = alClient
    ChildOrder = 9
    ElementBodyClassName = 'card-body'
    ElementFont = efCSS
    TabOrder = 5
    ExplicitWidth = 612
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
      ElementClassName = 'container'
      WidthPercent = 25.000000000000000000
      Align = alCustom
      BorderColor = clSilver
      Caption = '   EPG Days Displayed'
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
  object WebPanel3: TWebPanel
    Left = 0
    Top = 0
    Width = 493
    Height = 30
    ElementClassName = 'card'
    Align = alTop
    AutoSize = True
    Caption = 'WebPanel3'
    ChildOrder = 12
    ElementBodyClassName = 'card-body'
    ElementFont = efCSS
    ShowCaption = False
    TabOrder = 10
    ExplicitWidth = 612
    object AlertLabel: TWebButton
      Left = 0
      Top = 0
      Width = 493
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
      HeightPercent = 100.000000000000000000
      ParentFont = False
      Role = 'button'
      Visible = False
      WidthPercent = 100.000000000000000000
      ExplicitWidth = 612
    end
    object WebRadioGroup1: TWebRadioGroup
      Left = 0
      Top = 0
      Width = 493
      Height = 30
      WidthStyle = ssPercent
      Align = alClient
      Caption = ''
      ChildOrder = 5
      Columns = 5
      ElementFont = efCSS
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ItemIndex = 0
      Items.Strings = (
        'Listings'
        'Scheduled'
        'History'
        'Log'
        'Options')
      ParentFont = False
      Role = ''
      TabOrder = 0
      OnChange = WebRadioGroup1Change
      ExplicitWidth = 612
    end
  end
  object pnlListings: TWebPanel
    Left = 0
    Top = 30
    Width = 493
    Height = 969
    ElementClassName = 'card'
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
    ExplicitWidth = 612
    object pnlListingsGrid: TWebGridPanel
      Left = 0
      Top = 0
      Width = 493
      Height = 969
      Align = alClient
      ColumnCollection = <
        item
          Value = 100
        end>
      ControlCollection = <
        item
          Column = 0
          Row = 0
          Control = WebPanel2
        end
        item
          Column = 0
          Row = 1
          Control = WebGridPanel2
        end
        item
          Column = 0
          Row = 2
          Control = lb12Description
        end>
      Color = clWhite
      GridLineColor = clBlack
      RowCollection = <
        item
          Value = 80
        end
        item
          Value = 13
        end
        item
          Value = 7
        end>
      ExplicitWidth = 612
      object lb12Description: TWebLabel
        Left = 2
        Top = 903
        Width = 489
        Height = 64
        Align = alClient
        Anchors = []
        AutoSize = False
        Caption = 'Description'
        ChildOrder = -1
        ElementPosition = epRelative
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        HeightStyle = ssPercent
        HeightPercent = 100.000000000000000000
        HTMLType = tDIV
        ParentFont = False
        WordWrap = True
        WidthStyle = ssPercent
        WidthPercent = 100.000000000000000000
      end
      object WebGridPanel2: TWebGridPanel
        Left = 2
        Top = 777
        Width = 489
        Height = 166
        ElementID = 'WebGridPanel2'
        WidthStyle = ssPercent
        HeightPercent = 15.000000000000000000
        Align = alTop
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
            Row = 1
            Control = WebGridPanel4
          end>
        Color = clWhite
        ElementPosition = epRelative
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
        object WebGridPanel3: TWebGridPanel
          Left = 2
          Top = 2
          Width = 485
          Height = 74
          ElementID = 'WebGridPanel3'
          HeightStyle = ssAuto
          WidthStyle = ssPercent
          Align = alTop
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
              Column = 1
              Row = 0
              Control = lb02New
            end
            item
              Column = 2
              Row = 0
              Control = lb03Stereo
            end
            item
              Column = 3
              Row = 0
              Control = lb04HD
            end>
          Color = clWhite
          ElementPosition = epRelative
          GridLineColor = clBlack
          RowCollection = <
            item
              Value = 100
            end>
          object lb01Title: TWebLabel
            Left = 2
            Top = 2
            Width = 420
            Height = 70
            Align = alClient
            AutoSize = False
            Caption = 'Title'
            ChildOrder = -1
            ElementLabelClassName = 'text-body'
            ElementID = 'lb01Title'
            ElementPosition = epRelative
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = []
            HeightStyle = ssPercent
            HeightPercent = 100.000000000000000000
            HTMLType = tSPAN
            Layout = tlCenter
            ParentFont = False
            WordWrap = True
            WidthStyle = ssPercent
            WidthPercent = 100.000000000000000000
          end
          object lb02New: TWebLabel
            Left = 426
            Top = 2
            Width = 66
            Height = 70
            Align = alClient
            Alignment = taCenter
            AutoSize = False
            Caption = 'New'
            ChildOrder = -1
            ElementID = 'lb02New'
            ElementPosition = epRelative
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = []
            HeightStyle = ssPercent
            HeightPercent = 100.000000000000000000
            HTMLType = tSPAN
            Layout = tlCenter
            ParentFont = False
            WidthStyle = ssPercent
            WidthPercent = 100.000000000000000000
          end
          object lb03Stereo: TWebLabel
            Left = 496
            Top = 2
            Width = 66
            Height = 70
            Align = alClient
            Alignment = taCenter
            AutoSize = False
            Caption = 'Stereo'
            ChildOrder = -1
            ElementID = 'lb03Stereo'
            ElementPosition = epRelative
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = []
            HeightStyle = ssPercent
            HeightPercent = 100.000000000000000000
            HTMLType = tSPAN
            Layout = tlCenter
            ParentFont = False
            WidthStyle = ssPercent
            WidthPercent = 100.000000000000000000
          end
          object lb04HD: TWebLabel
            Left = 566
            Top = 2
            Width = 66
            Height = 70
            Align = alClient
            Alignment = taCenter
            AutoSize = False
            Caption = 'HD'
            ChildOrder = -1
            ElementID = 'lb04HD'
            ElementPosition = epRelative
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = []
            HeightStyle = ssPercent
            HeightPercent = 100.000000000000000000
            HTMLType = tSPAN
            Layout = tlCenter
            ParentFont = False
            WidthStyle = ssPercent
            WidthPercent = 100.000000000000000000
          end
        end
        object WebGridPanel4: TWebGridPanel
          Left = 2
          Top = 19
          Width = 485
          Height = 249
          ElementID = 'WebGridPanel4'
          HeightStyle = ssAuto
          WidthStyle = ssPercent
          Align = alTop
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
              Column = 1
              Row = 0
              Control = WebGridPanel1
            end>
          Color = clWhite
          ElementPosition = epRelative
          GridLineColor = clBlack
          RowCollection = <
            item
              Value = 100
            end>
          object lb06SubTitle: TWebLabel
            Left = 2
            Top = 2
            Width = 420
            Height = 245
            Align = alClient
            AutoSize = False
            Caption = 'SubTitle'
            ChildOrder = -1
            ElementID = 'lb06SubTitle'
            ElementPosition = epRelative
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = []
            HeightStyle = ssPercent
            HeightPercent = 100.000000000000000000
            HTMLType = tSPAN
            ParentFont = False
            WordWrap = True
            WidthStyle = ssPercent
            WidthPercent = 100.000000000000000000
          end
          object WebGridPanel1: TWebGridPanel
            Left = 426
            Top = 2
            Width = 206
            Height = 245
            ElementID = 'WebGridPanel1'
            HeightStyle = ssPercent
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
                Control = WebGridPanel7
              end
              item
                Column = 0
                Row = 1
                Control = WebGridPanel6
              end>
            Color = clWhite
            ElementPosition = epRelative
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
              Height = 118
              ElementID = 'WebGridPanel7'
              HeightStyle = ssPercent
              WidthStyle = ssPercent
              Align = alClient
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
                  Column = 1
                  Row = 0
                  Control = lb08CC
                end
                item
                  Column = 2
                  Row = 0
                  Control = lb09OrigDate
                end>
              Color = clWhite
              ElementPosition = epRelative
              GridLineColor = clBlack
              RowCollection = <
                item
                  Value = 100
                end>
              object lb07Dolby: TWebLabel
                Left = 2
                Top = 2
                Width = 86
                Height = 114
                Align = alClient
                Alignment = taCenter
                AutoSize = False
                Caption = 'Dolby'
                ChildOrder = -1
                ElementID = 'lb07Dolby'
                ElementPosition = epRelative
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Segoe UI'
                Font.Style = []
                HeightStyle = ssPercent
                HeightPercent = 100.000000000000000000
                HTMLType = tDIV
                Layout = tlCenter
                ParentFont = False
                WidthStyle = ssPercent
                WidthPercent = 100.000000000000000000
              end
              object lb08CC: TWebLabel
                Left = 92
                Top = 2
                Width = 46
                Height = 114
                Align = alClient
                Alignment = taCenter
                AutoSize = False
                Caption = 'CC'
                ChildOrder = -1
                ElementID = 'lb08CC'
                ElementPosition = epRelative
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Segoe UI'
                Font.Style = []
                HeightStyle = ssPercent
                HeightPercent = 100.000000000000000000
                HTMLType = tSPAN
                Layout = tlCenter
                ParentFont = False
                WidthStyle = ssPercent
                WidthPercent = 100.000000000000000000
              end
              object lb09OrigDate: TWebLabel
                Left = 142
                Top = 2
                Width = 66
                Height = 114
                Align = alClient
                Alignment = taCenter
                AutoSize = False
                Caption = 'OrigDate'
                ChildOrder = -1
                ElementID = 'lb09OrigDate'
                ElementPosition = epRelative
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Segoe UI'
                Font.Style = []
                HeightStyle = ssPercent
                HeightPercent = 100.000000000000000000
                HTMLType = tSPAN
                Layout = tlCenter
                ParentFont = False
                WordWrap = True
                WidthStyle = ssPercent
                WidthPercent = 100.000000000000000000
              end
            end
            object WebGridPanel6: TWebGridPanel
              Left = 2
              Top = 124
              Width = 202
              Height = 118
              ElementID = 'WebGridPanel6'
              HeightStyle = ssPercent
              WidthStyle = ssPercent
              Align = alClient
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
                  Column = 1
                  Row = 0
                  Control = lb11Time
                end>
              Color = clWhite
              ElementPosition = epRelative
              GridLineColor = clBlack
              RowCollection = <
                item
                  Value = 100
                end>
              object lb10Channel: TWebLabel
                Left = 2
                Top = 2
                Width = 97
                Height = 114
                Align = alClient
                Alignment = taCenter
                AutoSize = False
                Caption = 'Channel'
                ChildOrder = -1
                ElementID = 'lb10Channel'
                ElementPosition = epRelative
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Segoe UI'
                Font.Style = []
                HeightStyle = ssPercent
                HeightPercent = 100.000000000000000000
                HTMLType = tSPAN
                Layout = tlCenter
                ParentFont = False
                WidthStyle = ssPercent
                WidthPercent = 100.000000000000000000
              end
              object lb11Time: TWebLabel
                Left = 103
                Top = 2
                Width = 97
                Height = 114
                Align = alClient
                Alignment = taCenter
                AutoSize = False
                Caption = 'Time'
                ChildOrder = -1
                ElementID = 'lb11Time'
                ElementPosition = epRelative
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Segoe UI'
                Font.Style = []
                HeightStyle = ssPercent
                HeightPercent = 100.000000000000000000
                HTMLType = tSPAN
                Layout = tlCenter
                ParentFont = False
                WidthStyle = ssPercent
                WidthPercent = 100.000000000000000000
              end
            end
          end
        end
      end
      object WebPanel2: TWebPanel
        Left = 2
        Top = 2
        Width = 489
        Height = 771
        ElementClassName = 'card'
        HeightStyle = ssPercent
        WidthStyle = ssPercent
        Align = alClient
        Caption = 'WebPanel2'
        ChildOrder = -1
        ElementBodyClassName = 'card-body'
        ElementFont = efCSS
        ElementPosition = epRelative
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object Listings: TWebStringGrid
          Left = 0
          Top = 0
          Width = 489
          Height = 771
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
          OnSelectCell = ListingsSelectCell
          ElementFont = efCSS
          FixedFont.Charset = DEFAULT_CHARSET
          FixedFont.Color = clWindowText
          FixedFont.Height = -12
          FixedFont.Name = 'Segoe UI'
          FixedFont.Style = []
          GridLineColor = clRed
          RangeEdit.Max = 100.000000000000000000
          RangeEdit.Step = 1.000000000000000000
          HeightPercent = 100.000000000000000000
          WidthPercent = 100.000000000000000000
          OnClickCell = ListingsClickCell
          ExplicitWidth = 608
        end
      end
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
