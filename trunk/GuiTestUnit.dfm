object TestUnitForm: TTestUnitForm
  Left = 0
  Top = 0
  Caption = 'TestUnitForm'
  ClientHeight = 579
  ClientWidth = 699
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 0
    Top = 554
    Width = 699
    Height = 25
    Align = alBottom
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Panel1: TPanel
    Left = 456
    Top = 440
    Width = 185
    Height = 41
    Caption = 'Panel1'
    TabOrder = 1
  end
end
