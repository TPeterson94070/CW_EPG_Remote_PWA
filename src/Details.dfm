object DetailsFrm: TDetailsFrm
  Width = 353
  Height = 447
  Color = clHoneydew
  CSSLibrary = cssBootstrap
  ElementFont = efCSS
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  ParentFont = False
  ShowClose = False
  object lb02New: TWebLabel
    Left = 200
    Top = 331
    Width = 40
    Height = 15
    Alignment = taCenter
    AutoSize = False
    Caption = 'New'
    Color = clHoneydew
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
    Top = 331
    Width = 50
    Height = 15
    Alignment = taCenter
    AutoSize = False
    Caption = 'Stereo'
    Color = clHoneydew
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
    Top = 331
    Width = 45
    Height = 15
    Alignment = taCenter
    AutoSize = False
    Caption = 'HD'
    Color = clHoneydew
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
    Top = 331
    Width = 50
    Height = 15
    Alignment = taCenter
    AutoSize = False
    Caption = 'Dolby'
    Color = clHoneydew
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
    Top = 331
    Width = 40
    Height = 15
    Alignment = taCenter
    AutoSize = False
    Caption = 'CC'
    Color = clHoneydew
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
    Top = 331
    Width = 100
    Height = 15
    Alignment = taCenter
    AutoSize = False
    Caption = 'OrigDate'
    Color = clHoneydew
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
    Top = 303
    Width = 100
    Height = 15
    Alignment = taCenter
    AutoSize = False
    Caption = 'Channel'
    Color = clHoneydew
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
    WidthPercent = 100.000000000000000000
  end
  object lb11Time: TWebLabel
    Left = 114
    Top = 304
    Width = 160
    Height = 15
    Alignment = taCenter
    AutoSize = False
    Caption = 'Time'
    Color = clHoneydew
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
    WidthPercent = 100.000000000000000000
  end
  object pnlDetails: TWebPanel
    Left = 1
    Top = 0
    Width = 350
    Height = 275
    Center.Horizontal = True
    ElementClassName = 'card'
    WidthStyle = ssPercent
    Anchors = [akLeft, akTop, akRight]
    BorderStyle = bsNone
    Caption = 'pnlDetails'
    ChildOrder = 1
    Color = clHoneydew
    ElementBodyClassName = 'card-body'
    ElementFont = efCSS
    ShowCaption = False
    TabOrder = 0
    object lblTitle: TWebLabel
      Left = 0
      Top = 0
      Width = 350
      Height = 10
      Align = alTop
      Caption = 'Program Title'
      Color = clNone
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -8
      Font.Name = 'Arial'
      Font.Style = []
      HeightStyle = ssAuto
      HeightPercent = 100.000000000000000000
      ParentFont = False
      WidthPercent = 100.000000000000000000
    end
    object lblSubTitle: TWebLabel
      Left = 0
      Top = 80
      Width = 350
      Height = 10
      Align = alTop
      Caption = 'Program SubTitle'
      Color = clNone
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -8
      Font.Name = 'Arial'
      Font.Style = []
      HeightStyle = ssAuto
      HeightPercent = 100.000000000000000000
      ParentFont = False
      WidthPercent = 100.000000000000000000
    end
    object lblDescription: TWebLabel
      Left = 0
      Top = 145
      Width = 350
      Height = 10
      Align = alTop
      Caption = 'Program Description'
      Color = clNone
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -8
      Font.Name = 'Arial'
      Font.Style = []
      HeightStyle = ssAuto
      HeightPercent = 100.000000000000000000
      ParentFont = False
      WidthPercent = 100.000000000000000000
    end
    object mmTitle: TWebMemo
      Left = 0
      Top = 10
      Width = 350
      Height = 70
      Align = alTop
      Color = clDarkseagreen
      ElementClassName = 'form-control-lg'
      ElementFont = efCSS
      HeightPercent = 100.000000000000000000
      Lines.Strings = (
        'mmTitle')
      ScrollBars = ssNone
      SelLength = 0
      SelStart = 0
      WidthPercent = 100.000000000000000000
    end
    object mmSubTitle: TWebMemo
      Left = 0
      Top = 90
      Width = 350
      Height = 55
      Align = alTop
      Color = clDarkseagreen
      ElementClassName = 'form-control'
      ElementFont = efCSS
      HeightPercent = 100.000000000000000000
      Lines.Strings = (
        'mmSubTitle')
      ScrollBars = ssNone
      SelLength = 0
      SelStart = 10
      WidthPercent = 100.000000000000000000
    end
    object mmDescription: TWebMemo
      Left = 0
      Top = 155
      Width = 350
      Height = 117
      Align = alTop
      Color = clDarkseagreen
      ElementClassName = 'form-control-sm'
      ElementFont = efCSS
      HeightPercent = 100.000000000000000000
      Lines.Strings = (
        'Description')
      ReadOnly = True
      SelLength = 0
      SelStart = 11
      WidthPercent = 100.000000000000000000
    end
  end
  object btnAddCap: TWebButton
    Left = 210
    Top = 376
    Width = 120
    Height = 40
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Caption = 'Add Capture'
    ChildOrder = 11
    ElementClassName = 'btn btn-outline-success'
    ElementFont = efCSS
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    HeightStyle = ssAuto
    HeightPercent = 100.000000000000000000
    ModalResult = 1
    ParentFont = False
    Role = 'button'
    TabOrder = 4
    WidthPercent = 100.000000000000000000
  end
  object btnReturn: TWebButton
    Left = 20
    Top = 376
    Width = 120
    Height = 40
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Cancel = True
    Caption = 'Return'
    ChildOrder = 10
    Default = True
    ElementClassName = 'btn btn-success'
    ElementFont = efCSS
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    HeightStyle = ssAuto
    HeightPercent = 100.000000000000000000
    ModalResult = 2
    ParentFont = False
    Role = 'button'
    TabOrder = 3
    WidthPercent = 100.000000000000000000
  end
end
