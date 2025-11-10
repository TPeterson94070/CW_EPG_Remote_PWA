object SchedForm: TSchedForm
  Width = 350
  Height = 480
  Color = clBurlywood
  CSSLibrary = cssBootstrap
  ElementFont = efCSS
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  ParentFont = False
  object lblChannel: TWebLabel
    Left = 83
    Top = 293
    Width = 217
    Height = 15
    Alignment = taCenter
    AutoSize = False
    Caption = 'On Channel'
    Color = clBurlywood
    ElementLabelClassName = 'h6'
    ElementFont = efCSS
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
  end
  object lblChannelValue: TWebLabel
    Left = 83
    Top = 311
    Width = 217
    Height = 15
    Alignment = taCenter
    AutoSize = False
    Caption = 'PSIP'
    Color = clBurlywood
    ElementLabelClassName = 'h6'
    ElementFont = efCSS
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
  end
  object lblStartTime: TWebLabel
    Left = 145
    Top = 342
    Width = 70
    Height = 16
    Margins.Left = 11
    Margins.Top = 11
    Margins.Right = 11
    Margins.Bottom = 11
    Alignment = taCenter
    AutoSize = False
    Caption = 'Start'
    Color = clBurlywood
    ElementFont = efCSS
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    HeightStyle = ssAuto
    HeightPercent = 100.000000000000000000
    Layout = tlCenter
    ParentFont = False
    Transparent = False
    WidthPercent = 100.000000000000000000
  end
  object lblEndTime: TWebLabel
    Left = 239
    Top = 342
    Width = 70
    Height = 16
    Margins.Left = 11
    Margins.Top = 11
    Margins.Right = 11
    Margins.Bottom = 11
    Alignment = taCenter
    AutoSize = False
    Caption = 'End'
    Color = clBurlywood
    ElementFont = efCSS
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    HeightStyle = ssAuto
    HeightPercent = 100.000000000000000000
    Layout = tlCenter
    ParentFont = False
    Transparent = False
    WidthPercent = 100.000000000000000000
  end
  object lblStartDateValue: TWebLabel
    Left = 41
    Top = 364
    Width = 100
    Height = 16
    Margins.Left = 11
    Margins.Top = 11
    Margins.Right = 11
    Margins.Bottom = 11
    Alignment = taCenter
    AutoSize = False
    Caption = 'Date'
    Color = clBurlywood
    ElementFont = efCSS
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    HeightStyle = ssAuto
    HeightPercent = 100.000000000000000000
    Layout = tlCenter
    ParentFont = False
    Transparent = False
    WidthPercent = 100.000000000000000000
  end
  object EventModeGroup: TWebRadioGroup
    Left = 15
    Top = 284
    Width = 67
    Height = 55
    Caption = ''
    Columns = 1
    ItemIndex = 0
    Items.Strings = (
      'Record'
      'Watch')
    Role = ''
    TabOrder = 0
    Visible = False
  end
  object pnlDetails: TWebPanel
    Left = 0
    Top = 0
    Width = 350
    Height = 275
    Center.Horizontal = True
    WidthStyle = ssPercent
    Caption = 'pnlDetails'
    ChildOrder = 1
    Color = clDarkgreen
    ShowCaption = False
    TabOrder = 1
    object lblTitle: TWebLabel
      Left = 0
      Top = 0
      Width = 350
      Height = 14
      Align = alTop
      Caption = 'Program Title'
      Color = clNone
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      HeightStyle = ssAuto
      HeightPercent = 100.000000000000000000
      ParentFont = False
      WidthPercent = 100.000000000000000000
      ExplicitWidth = 62
    end
    object lblSubTitle: TWebLabel
      Left = 0
      Top = 72
      Width = 350
      Height = 14
      Align = alTop
      Caption = 'Program SubTitle'
      Color = clNone
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      HeightStyle = ssAuto
      HeightPercent = 100.000000000000000000
      ParentFont = False
      WidthPercent = 100.000000000000000000
      ExplicitWidth = 81
    end
    object lblDescription: TWebLabel
      Left = 0
      Top = 135
      Width = 350
      Height = 14
      Align = alTop
      Caption = 'Program Description'
      Color = clNone
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      HeightStyle = ssAuto
      HeightPercent = 100.000000000000000000
      ParentFont = False
      WidthPercent = 100.000000000000000000
      ExplicitWidth = 97
    end
    object mmTitle: TWebMemo
      Left = 0
      Top = 14
      Width = 350
      Height = 58
      Align = alTop
      Color = clBurlywood
      ElementClassName = 'h5'
      ElementFont = efCSS
      HeightPercent = 100.000000000000000000
      Lines.Strings = (
        'mmTitle')
      SelLength = 0
      SelStart = 0
      WidthPercent = 100.000000000000000000
    end
    object mmSubTitle: TWebMemo
      Left = 0
      Top = 86
      Width = 350
      Height = 49
      Align = alTop
      Color = clBurlywood
      ElementClassName = 'h6'
      ElementFont = efCSS
      HeightPercent = 100.000000000000000000
      Lines.Strings = (
        'mmSubTitle')
      SelLength = 0
      SelStart = 10
      WidthPercent = 100.000000000000000000
    end
    object mmDescription: TWebMemo
      Left = 0
      Top = 158
      Width = 350
      Height = 117
      Align = alBottom
      Color = clBurlywood
      HeightPercent = 100.000000000000000000
      Lines.Strings = (
        'Description')
      SelLength = 0
      SelStart = 11
      WidthPercent = 100.000000000000000000
    end
  end
  object btnCancel: TWebButton
    Left = 20
    Top = 421
    Width = 120
    Height = 40
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Anchors = [akLeft, akBottom]
    Caption = 'Cancel'
    ChildOrder = 10
    Default = True
    ElementClassName = 'btn btn-warning'
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
  end
  object btnOK: TWebButton
    Left = 208
    Top = 421
    Width = 120
    Height = 40
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Anchors = [akLeft, akBottom]
    Caption = 'Submit'
    ChildOrder = 11
    ElementClassName = 'btn btn-primary'
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
  end
  object tpStartTime: TWebDateTimePicker
    Left = 145
    Top = 364
    Width = 79
    Height = 24
    BorderStyle = bsSingle
    ChildOrder = 10
    Color = clWhite
    Date = 0.666666666666666600
    Kind = dtkTime
    Role = ''
    ShowSeconds = False
    Text = '4:00 PM'
    Time = 0.666666666666666600
  end
  object tpEndTime: TWebDateTimePicker
    Left = 239
    Top = 364
    Width = 79
    Height = 24
    BorderStyle = bsSingle
    ChildOrder = 10
    Color = clWhite
    Date = 0.708333333333333400
    Kind = dtkTime
    Role = ''
    ShowSeconds = False
    Text = '17:00'
    Time = 0.708333333333333400
  end
end
