object SchedForm: TSchedForm
  Width = 472
  Height = 480
  ElementFont = efCSS
  object lbChannelValue: TWebLabel
    Left = 172
    Top = 308
    Width = 217
    Height = 22
    Alignment = taCenter
    AutoSize = False
    Caption = 'Channel'
    Color = 16711422
    ElementFont = efCSS
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    HeightStyle = ssAuto
    HeightPercent = 100.000000000000000000
    ParentFont = False
    WidthPercent = 100.000000000000000000
  end
  object LblChannel: TWebLabel
    Left = 172
    Top = 286
    Width = 217
    Height = 22
    Alignment = taCenter
    AutoSize = False
    Caption = 'Channel'
    Color = 16711422
    ElementFont = efCSS
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    HeightPercent = 100.000000000000000000
    ParentFont = False
    WidthPercent = 100.000000000000000000
  end
  object lblEndTime: TWebLabel
    Left = 349
    Top = 344
    Width = 70
    Height = 24
    Margins.Left = 11
    Margins.Top = 11
    Margins.Right = 11
    Margins.Bottom = 11
    Alignment = taCenter
    AutoSize = False
    Caption = 'End'
    Color = clBtnFace
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
    WidthPercent = 100.000000000000000000
  end
  object lblStartDate: TWebLabel
    Left = 130
    Top = 344
    Width = 100
    Height = 23
    Margins.Left = 11
    Margins.Top = 11
    Margins.Right = 11
    Margins.Bottom = 11
    Alignment = taCenter
    AutoSize = False
    Caption = 'Date'
    Color = clBtnFace
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
    WidthPercent = 100.000000000000000000
  end
  object lblStartTime: TWebLabel
    Left = 234
    Top = 344
    Width = 70
    Height = 23
    Margins.Left = 11
    Margins.Top = 11
    Margins.Right = 11
    Margins.Bottom = 11
    Alignment = taCenter
    AutoSize = False
    Caption = 'Start'
    Color = clBtnFace
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
    WidthPercent = 100.000000000000000000
  end
  object lbStartDate: TWebLabel
    Left = 130
    Top = 367
    Width = 100
    Height = 31
    Margins.Left = 11
    Margins.Top = 11
    Margins.Right = 11
    Margins.Bottom = 11
    Alignment = taCenter
    AutoSize = False
    Caption = 'Date'
    Color = clBtnFace
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
    WidthPercent = 100.000000000000000000
  end
  object EventModeGroup: TWebRadioGroup
    Left = 22
    Top = 286
    Width = 67
    Height = 84
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Caption = 'Mode'
    ChildOrder = 6
    Columns = 1
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -10
    Font.Name = 'Segoe UI'
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      'Record'
      'Watch')
    ParentFont = False
    Role = ''
    TabOrder = 0
  end
  object optcanbutt: TWebButton
    Left = 28
    Top = 421
    Width = 166
    Height = 40
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Anchors = [akLeft, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ChildOrder = 10
    ElementFont = efCSS
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    HeightPercent = 100.000000000000000000
    ModalResult = 2
    ParentFont = False
    TabOrder = 3
    WidthPercent = 100.000000000000000000
  end
  object optokbutt: TWebButton
    Left = 262
    Top = 421
    Width = 166
    Height = 40
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Anchors = [akLeft, akBottom]
    Caption = 'OK'
    ChildOrder = 11
    ElementFont = efCSS
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    HeightPercent = 100.000000000000000000
    ModalResult = 1
    ParentFont = False
    TabOrder = 4
    WidthPercent = 100.000000000000000000
  end
  object pnlDetails: TWebPanel
    Left = 0
    Top = 0
    Width = 472
    Height = 275
    Center.Horizontal = True
    Align = alTop
    Alignment = taLeftJustify
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Panel1'
    ChildOrder = 12
    ElementFont = efCSS
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    ShowCaption = False
    TabOrder = 3
    object lbTitle: TWebLabel
      Left = 0
      Top = 0
      Width = 472
      Height = 15
      Align = alTop
      Caption = 'Program Title'
      ElementFont = efCSS
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      HeightStyle = ssAuto
      HeightPercent = 100.000000000000000000
      ParentFont = False
      WidthPercent = 100.000000000000000000
      ExplicitWidth = 71
    end
    object lbSubTitle: TWebLabel
      Left = 0
      Top = 70
      Width = 472
      Height = 15
      Align = alTop
      Caption = 'Program SubTitle'
      ElementFont = efCSS
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      HeightStyle = ssAuto
      HeightPercent = 100.000000000000000000
      ParentFont = False
      WidthPercent = 100.000000000000000000
      ExplicitWidth = 91
    end
    object lbDescription: TWebLabel
      Left = 0
      Top = 137
      Width = 472
      Height = 15
      Align = alTop
      Caption = 'Program Description'
      ElementFont = efCSS
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      HeightStyle = ssAuto
      HeightPercent = 100.000000000000000000
      ParentFont = False
      WidthPercent = 100.000000000000000000
      ExplicitWidth = 109
    end
    object mmTitle: TWebMemo
      Left = 0
      Top = 15
      Width = 472
      Height = 55
      Align = alTop
      ElementFont = efCSS
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      HeightPercent = 100.000000000000000000
      Lines.Strings = (
        'Program Title')
      ParentFont = False
      ReadOnly = True
      SelLength = 0
      SelStart = 15
      WidthPercent = 100.000000000000000000
    end
    object mmSubTitle: TWebMemo
      Left = 0
      Top = 85
      Width = 472
      Height = 52
      Align = alTop
      ElementFont = efCSS
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      HeightPercent = 100.000000000000000000
      Lines.Strings = (
        'Subtitle (Episode Name)')
      ParentFont = False
      ReadOnly = True
      SelLength = 0
      SelStart = 25
      WidthPercent = 100.000000000000000000
    end
    object mmDescrip: TWebMemo
      Left = 0
      Top = 152
      Width = 472
      Height = 123
      Align = alClient
      ElementFont = efCSS
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      HeightPercent = 100.000000000000000000
      Lines.Strings = (
        'Description')
      ParentFont = False
      ReadOnly = True
      SelLength = 0
      SelStart = 13
      WidthPercent = 100.000000000000000000
    end
  end
  object tpEndTime: TWebDateTimePicker
    Left = 234
    Top = 367
    Width = 110
    Height = 31
    HeightStyle = ssAuto
    BorderStyle = bsNone
    ChildOrder = 5
    Color = clWhite
    Date = 44546.000000000000000000
    ElementFont = efCSS
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Kind = dtkTime
    ParentFont = False
    Role = ''
    ShowSeconds = False
    TabOrder = 1
    Text = ''
    Time = 45503.862546296300000000
  end
  object tpStartTime: TWebDateTimePicker
    Left = 349
    Top = 367
    Width = 110
    Height = 31
    HeightStyle = ssAuto
    BorderStyle = bsNone
    ChildOrder = 13
    Color = clWhite
    Date = 44546.000000000000000000
    ElementFont = efCSS
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Kind = dtkTime
    ParentFont = False
    Role = ''
    ShowSeconds = False
    Text = ''
    Time = 0.862500000000000000
  end
end
