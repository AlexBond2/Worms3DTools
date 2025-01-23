object AnimForm: TAnimForm
  Left = 1035
  Top = 246
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'AnimForm'
  ClientHeight = 340
  ClientWidth = 232
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object ListBox1: TListBox
    Left = 16
    Top = 16
    Width = 201
    Height = 273
    ItemHeight = 13
    TabOrder = 0
  end
  object Button1: TButton
    Left = 16
    Top = 304
    Width = 75
    Height = 25
    Caption = 'Ok'
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 144
    Top = 304
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
