object TestUnitForm: TTestUnitForm
  Left = 0
  Top = 0
  Caption = 'TestUnitForm'
  ClientHeight = 790
  ClientWidth = 304
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 0
    Top = 765
    Width = 304
    Height = 25
    Align = alBottom
    Caption = 'Button1'
    TabOrder = 0
    ExplicitTop = 554
    ExplicitWidth = 699
  end
  object JvThread1: TJvThread
    Exclusive = True
    MaxCount = 0
    RunOnCreate = True
    FreeOnTerminate = True
    Left = 24
    Top = 48
  end
end
