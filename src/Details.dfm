object DetailsFrm: TDetailsFrm
  Width = 350
  Height = 281
  CSSLibrary = cssBootstrap
  ElementFont = efCSS
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  ParentFont = False
  ShowClose = False
  Visible = True
  object lb02New: TWebLabel
    Left = 200
    Top = 190
    Width = 40
    Height = 15
    Alignment = taCenter
    AutoSize = False
    Caption = 'New'
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
    ShowAccelChar = False
    WidthPercent = 100.000000000000000000
  end
  object lb03Stereo: TWebLabel
    Left = 146
    Top = 190
    Width = 50
    Height = 15
    Alignment = taCenter
    AutoSize = False
    Caption = 'Stereo'
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
    ShowAccelChar = False
    WidthPercent = 100.000000000000000000
  end
  object lb04HD: TWebLabel
    Left = 6
    Top = 190
    Width = 40
    Height = 15
    Alignment = taCenter
    AutoSize = False
    Caption = 'HD'
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
    ShowAccelChar = False
    WidthPercent = 100.000000000000000000
  end
  object lb10Channel: TWebLabel
    Left = 10
    Top = 157
    Width = 100
    Height = 15
    Alignment = taCenter
    AutoSize = False
    Caption = 'Channel'
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
    ShowAccelChar = False
    WidthPercent = 100.000000000000000000
  end
  object lb11Time: TWebLabel
    Left = 93
    Top = 157
    Width = 160
    Height = 15
    Alignment = taCenter
    AutoSize = False
    Caption = 'Time'
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
    ShowAccelChar = False
    WidthPercent = 100.000000000000000000
  end
  object lb07Dolby: TWebLabel
    Left = 84
    Top = 190
    Width = 50
    Height = 15
    Alignment = taCenter
    AutoSize = False
    Caption = 'Dolby'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    HeightStyle = ssAuto
    HeightPercent = 100.000000000000000000
    HTMLType = tDIV
    Layout = tlCenter
    ParentFont = False
    ShowAccelChar = False
    WidthPercent = 100.000000000000000000
  end
  object lb08CC: TWebLabel
    Left = 46
    Top = 190
    Width = 40
    Height = 15
    Alignment = taCenter
    AutoSize = False
    Caption = 'CC'
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
    ShowAccelChar = False
    WidthPercent = 100.000000000000000000
  end
  object lb09OrigDate: TWebLabel
    Left = 243
    Top = 190
    Width = 100
    Height = 15
    Alignment = taCenter
    AutoSize = False
    Caption = 'OrigDate'
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
    ShowAccelChar = False
    WidthPercent = 100.000000000000000000
  end
  object btnAddCap: TWebButton
    Left = 210
    Top = 229
    Width = 120
    Height = 40
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Anchors = [akLeft, akBottom]
    Caption = 'Add Capture'
    ChildOrder = 11
    ElementClassName = 'btn btn-outline-success'
    ElementFont = efCSS
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    HeightPercent = 100.000000000000000000
    ModalResult = 1
    ParentFont = False
    Role = 'button'
    TabOrder = 4
    WidthPercent = 100.000000000000000000
    ExplicitTop = 171
  end
  object btnReturn: TWebButton
    Left = 20
    Top = 229
    Width = 120
    Height = 40
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Anchors = [akLeft, akBottom]
    Cancel = True
    Caption = 'Return'
    ChildOrder = 10
    ElementClassName = 'btn btn-outline-success'
    ElementFont = efCSS
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    HeightPercent = 100.000000000000000000
    ModalResult = 2
    ParentFont = False
    Role = 'button'
    TabOrder = 3
    WidthPercent = 100.000000000000000000
    ExplicitTop = 171
  end
  object WebGridPanel1: TWebGridPanel
    Left = 0
    Top = 0
    Width = 350
    Height = 41
    HeightStyle = ssAuto
    Align = alTop
    ChildOrder = 13
    ColumnCollection = <
      item
        Value = 100
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
        Control = lb06SubTitle
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
        Value = 33
      end
      item
        Value = 33
      end
      item
        Value = 33
      end>
    ExplicitLeft = 120
    ExplicitTop = 88
    ExplicitWidth = 100
    object lb01Title: TWebLabel
      Left = 2
      Top = 2
      Width = 346
      Height = 15
      Align = alTop
      Anchors = []
      Caption = 'Title'
      Color = clSkyBlue
      ElementLabelClassName = 'h5'
      ElementFont = efCSS
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
      ShowAccelChar = False
      Transparent = False
      WordWrap = True
      WidthPercent = 100.000000000000000000
    end
    object lb06SubTitle: TWebLabel
      Left = 2
      Top = 16
      Width = 346
      Height = 15
      Align = alTop
      Anchors = []
      Caption = 'SubTitle'
      ElementLabelClassName = 'h6'
      ElementFont = efCSS
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      HeightStyle = ssAuto
      HeightPercent = 100.000000000000000000
      HTMLType = tSPAN
      ParentFont = False
      ShowAccelChar = False
      Transparent = False
      WordWrap = True
      WidthPercent = 100.000000000000000000
    end
    object lb12Description: TWebLabel
      Left = 2
      Top = 30
      Width = 346
      Height = 15
      Align = alTop
      Anchors = []
      Caption = 'Description'
      Color = clBeige
      ElementLabelClassName = 'small'
      ElementPosition = epRelative
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      HeightStyle = ssAuto
      HeightPercent = 100.000000000000000000
      HTMLType = tDIV
      ParentFont = False
      ShowAccelChar = False
      Transparent = False
      WordWrap = True
      WidthPercent = 100.000000000000000000
    end
  end
end
