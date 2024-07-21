object SchedForm: TSchedForm
  Color = clWhite
  ElementFont = efCSS
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Size = 8
  Font.Style = []
  FormStyle = fsNormal
  Height = 480
  Left = 0
  OnShow = WebFormShow
  TabOrder = 0
  Top = 0
  Width = 472
  object lbChannelValue: TWebLabel
    Alignment = taCenter
    AutoSize = False
    Caption = 'Channel'
    Color = clWindow
    ElementFont = efCSS
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Size = 9
    Font.Style = []
    Height = 24
    HeightStyle = ssAuto
    Left = 172
    ParentFont = False
    Top = 308
    Transparent = False
    Width = 217
  end
  object LblChannel: TWebLabel
    Alignment = taCenter
    AutoSize = False
    Caption = 'Channel'
    Color = clWindow
    ElementFont = efCSS
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Size = 9
    Font.Style = []
    Height = 22
    Left = 172
    ParentFont = False
    Top = 286
    Transparent = False
    Width = 217
  end
  object lblEndTime: TWebLabel
    Alignment = taCenter
    AutoSize = False
    Caption = 'End'
    Color = clBtnFace
    ElementFont = efCSS
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Size = 9
    Font.Style = []
    Height = 24
    HeightStyle = ssAuto
    Layout = tlCenter
    Left = 349
    Margins.Bottom = 11
    Margins.Left = 11
    Margins.Right = 11
    Margins.Top = 11
    ParentFont = False
    Top = 344
    Transparent = False
    Width = 70
  end
  object lblStartDate: TWebLabel
    Alignment = taCenter
    AutoSize = False
    Caption = 'Date'
    Color = clBtnFace
    ElementFont = efCSS
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Size = 9
    Font.Style = []
    Height = 24
    HeightStyle = ssAuto
    Layout = tlCenter
    Left = 130
    Margins.Bottom = 11
    Margins.Left = 11
    Margins.Right = 11
    Margins.Top = 11
    ParentFont = False
    Top = 344
    Transparent = False
    Width = 100
  end
  object lblStartTime: TWebLabel
    Alignment = taCenter
    AutoSize = False
    Caption = 'Start'
    Color = clBtnFace
    ElementFont = efCSS
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Size = 9
    Font.Style = []
    Height = 24
    HeightStyle = ssAuto
    Layout = tlCenter
    Left = 234
    Margins.Bottom = 11
    Margins.Left = 11
    Margins.Right = 11
    Margins.Top = 11
    ParentFont = False
    Top = 344
    Transparent = False
    Width = 70
  end
  object lblStartDateValue: TWebLabel
    Alignment = taCenter
    AutoSize = False
    Caption = 'Date'
    Color = clBtnFace
    ElementFont = efCSS
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Size = 9
    Font.Style = []
    Height = 24
    HeightStyle = ssAuto
    Layout = tlCenter
    Left = 130
    Margins.Bottom = 11
    Margins.Left = 11
    Margins.Right = 11
    Margins.Top = 11
    ParentFont = False
    Top = 367
    Transparent = False
    Width = 100
  end
  object EventModeGroup: TWebRadioGroup
    Caption = 'Mode'
    ChildOrder = 6
    Columns = 1
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -10
    Font.Name = 'Segoe UI'
    Font.Size = 8
    Font.Style = []
    Height = 84
    ItemIndex = 0
    Items.Strings = (
      'Record'
      'Watch')
    Left = 22
    Margins.Bottom = 8
    Margins.Left = 8
    Margins.Right = 8
    Margins.Top = 8
    ParentFont = False
    Top = 286
    Width = 67
  end
  object optcanbutt: TWebButton
    Anchors = [akLeft, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ChildOrder = 10
    Color = clNone
    ElementFont = efCSS
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Size = 9
    Font.Style = []
    Height = 40
    Left = 28
    Margins.Bottom = 8
    Margins.Left = 8
    Margins.Right = 8
    Margins.Top = 8
    ModalResult = 2
    ParentFont = False
    Role = 'button'
    TabOrder = 3
    Top = 421
    Width = 166
  end
  object optokbutt: TWebButton
    Anchors = [akLeft, akBottom]
    Caption = 'OK'
    ChildOrder = 11
    Color = clNone
    ElementFont = efCSS
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Size = 9
    Font.Style = []
    Height = 40
    Left = 262
    Margins.Bottom = 8
    Margins.Left = 8
    Margins.Right = 8
    Margins.Top = 8
    ModalResult = 1
    ParentFont = False
    Role = 'button'
    TabOrder = 4
    Top = 421
    Width = 166
  end
  object pnlDetails: TWebPanel
    Color = clBtnFace
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Size = 8
    Font.Style = []
    Height = 275
    Left = 0
    TabOrder = 0
    TabStop = False
    Top = 0
    Width = 472
    object lbTitle: TWebLabel
      Align = alTop
      Caption = 'Program Title'
      ElementFont = efCSS
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Size = 9
      Font.Style = []
      Height = 16
      HeightStyle = ssAuto
      Left = 0
      ParentFont = False
      Top = 0
      Width = 470
    end
    object lbSubTitle: TWebLabel
      Align = alTop
      Caption = 'Program SubTitle'
      ElementFont = efCSS
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Size = 9
      Font.Style = []
      Height = 16
      HeightStyle = ssAuto
      Left = 0
      ParentFont = False
      Top = 71
      Width = 470
    end
    object lbDescription: TWebLabel
      Align = alTop
      Caption = 'Program Description'
      ElementFont = efCSS
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Size = 9
      Font.Style = []
      Height = 16
      HeightStyle = ssAuto
      Left = 0
      ParentFont = False
      Top = 139
      Width = 470
    end
    object mmTitle: TWebMemo
      Align = alTop
      AutoSize = False
      Color = clWindow
      ElementFont = efCSS
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Size = 9
      Font.Style = []
      Height = 55
      Left = 0
      Lines.Strings = (
        'Program Title')
      ParentFont = False
      ReadOnly = True
      SelLength = 0
      SelStart = 13
      ShowFocus = True
      TabOrder = 0
      Top = 16
      Width = 470
    end
    object mmSubTitle: TWebMemo
      Align = alTop
      AutoSize = False
      Color = clWindow
      ElementFont = efCSS
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Size = 9
      Font.Style = []
      Height = 52
      Left = 0
      Lines.Strings = (
        'Subtitle (Episode Name)')
      ParentFont = False
      ReadOnly = True
      SelLength = 0
      SelStart = 23
      ShowFocus = True
      TabOrder = 0
      Top = 87
      Width = 470
    end
    object mmDescrip: TWebMemo
      Align = alClient
      AutoSize = False
      Color = clWindow
      ElementFont = efCSS
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Size = 9
      Font.Style = []
      Height = 118
      Left = 0
      Lines.Strings = (
        'Description')
      ParentFont = False
      ReadOnly = True
      SelLength = 0
      SelStart = 11
      ShowFocus = True
      TabOrder = 0
      Top = 155
      Width = 470
    end
  end
  object tpStartTime: TWebDateTimePicker
    Color = clWindow
    Date = 0.667361111111111100
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Size = 8
    Font.Style = []
    Height = 24
    Kind = dtkTime
    Left = 234
    Max = 0
    Min = 0
    ShowFocus = True
    ShowSeconds = False
    TabOrder = 0
    Text = '16:01:00'
    Time = 0.667361111111111100
    Top = 367
    Width = 79
  end
  object tpEndTime: TWebDateTimePicker
    Color = clWindow
    Date = 0.708333333333333400
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Size = 8
    Font.Style = []
    Height = 24
    Kind = dtkTime
    Left = 349
    Max = 0
    Min = 0
    ShowFocus = True
    ShowSeconds = False
    TabOrder = 0
    Text = '17:00:00'
    Time = 0.708333333333333400
    Top = 367
    Width = 79
  end
end
