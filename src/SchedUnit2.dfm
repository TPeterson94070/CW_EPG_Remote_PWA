object SchedForm: TSchedForm
  Width = 350
  Height = 480
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  ParentFont = False
  object lblChannel: TWebLabel
    Left = 83
    Top = 286
    Width = 217
    Height = 15
    Alignment = taCenter
    AutoSize = False
    Caption = 'Channel'
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
  end
  object lblChannelValue: TWebLabel
    Left = 83
    Top = 304
    Width = 217
    Height = 15
    Alignment = taCenter
    AutoSize = False
    Caption = 'PSIP'
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
  end
  object lblStartDate: TWebLabel
    Left = 41
    Top = 344
    Width = 100
    Height = 16
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
    Transparent = False
    WidthPercent = 100.000000000000000000
  end
  object lblStartTime: TWebLabel
    Left = 145
    Top = 344
    Width = 70
    Height = 16
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
    Transparent = False
    WidthPercent = 100.000000000000000000
  end
  object lblEndTime: TWebLabel
    Left = 239
    Top = 344
    Width = 70
    Height = 16
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
    Transparent = False
    WidthPercent = 100.000000000000000000
  end
  object lblStartDateValue: TWebLabel
    Left = 41
    Top = 360
    Width = 100
    Height = 16
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
    Align = alTop
    Caption = 'pnlDetails'
    ChildOrder = 1
    ShowCaption = False
    TabOrder = 1
    ExplicitWidth = 400
    object lblTitle: TWebLabel
      Left = 0
      Top = 0
      Width = 350
      Height = 14
      Align = alTop
      Caption = 'Program Title'
      HeightPercent = 100.000000000000000000
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
      HeightPercent = 100.000000000000000000
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
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
      ExplicitWidth = 97
    end
    object mmTitle: TWebMemo
      Left = 0
      Top = 14
      Width = 350
      Height = 58
      Align = alTop
      HeightPercent = 100.000000000000000000
      Lines.Strings = (
        'mmTitle')
      SelLength = 0
      SelStart = 0
      WidthPercent = 100.000000000000000000
      ExplicitWidth = 400
    end
    object mmSubTitle: TWebMemo
      Left = 0
      Top = 86
      Width = 350
      Height = 49
      Align = alTop
      HeightPercent = 100.000000000000000000
      Lines.Strings = (
        'mmSubTitle')
      SelLength = 0
      SelStart = 10
      WidthPercent = 100.000000000000000000
      ExplicitWidth = 400
    end
    object mmDescription: TWebMemo
      Left = 0
      Top = 158
      Width = 350
      Height = 117
      Align = alBottom
      HeightPercent = 100.000000000000000000
      Lines.Strings = (
        'Description')
      SelLength = 0
      SelStart = 11
      WidthPercent = 100.000000000000000000
      ExplicitWidth = 400
    end
  end
  object optcanbutt: TWebButton
    Left = 20
    Top = 421
    Width = 120
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
    Role = 'button'
    TabOrder = 3
    WidthPercent = 100.000000000000000000
  end
  object optokbutt: TWebButton
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
    Top = 360
    Width = 79
    Height = 24
    BorderStyle = bsSingle
    ChildOrder = 10
    Color = clWhite
    Date = 0.666666666666666600
    Kind = dtkTime
    Role = ''
    ShowSeconds = False
    Text = '16:00'
    Time = 0.666666666666666600
  end
  object tpEndTime: TWebDateTimePicker
    Left = 239
    Top = 360
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
