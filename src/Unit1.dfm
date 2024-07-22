object Form1: TForm1
  Top = 163
  Width = 734
  Height = 480
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  FormContainer = 'appcontent'
  ParentFont = False
  OnCreate = WebFormCreate
  object WebLabel1: TWebLabel
    Left = 40
    Top = 32
    Width = 90
    Height = 35
    Caption = 'Form 1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -29
    Font.Name = 'Tahoma'
    Font.Style = []
    HeightPercent = 100.000000000000000000
    ParentFont = False
    WidthPercent = 100.000000000000000000
  end
  object WebLabel2: TWebLabel
    Left = 40
    Top = 360
    Width = 97
    Height = 14
    Caption = 'Multiform application'
    ElementID = 'title'
    ElementPosition = epRelative
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    HeightPercent = 100.000000000000000000
    ParentFont = False
    WidthPercent = 100.000000000000000000
  end
  object WebLabel6: TWebLabel
    Left = 40
    Top = 392
    Width = 670
    Height = 28
    Caption = 
      'Demo showing a web application consisting of two form files and ' +
      'showing the form either on top of the main form or launching it ' +
      'as a new web page'
    ElementID = 'description'
    ElementPosition = epRelative
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    HeightPercent = 100.000000000000000000
    ParentFont = False
    WordWrap = True
    WidthStyle = ssPercent
    WidthPercent = 100.000000000000000000
  end
  object WebButton1: TWebButton
    Left = 40
    Top = 269
    Width = 265
    Height = 57
    Caption = 'Click here to open the second form'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    HeightPercent = 100.000000000000000000
    ParentFont = False
    Role = 'button'
    WidthPercent = 100.000000000000000000
    OnClick = WebButton1Click
  end
  object WebEdit1: TWebEdit
    Left = 40
    Top = 88
    Width = 265
    Height = 24
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    HeightPercent = 100.000000000000000000
    HideSelection = False
    ParentFont = False
    TabOrder = 1
    Text = 'Sample Title'
    WidthPercent = 100.000000000000000000
  end
end
