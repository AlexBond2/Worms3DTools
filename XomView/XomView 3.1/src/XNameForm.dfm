object FormName: TFormName
  Left = 979
  Top = 652
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Add New XResource'
  ClientHeight = 42
  ClientWidth = 327
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
  object Label1: TLabel
    Left = 9
    Top = 16
    Width = 31
    Height = 13
    Caption = 'Name:'
  end
  object XName: TEdit
    Left = 43
    Top = 12
    Width = 201
    Height = 21
    TabOrder = 0
    Text = 'NewName'
  end
  object Button1: TButton
    Left = 248
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Ok'
    ModalResult = 1
    TabOrder = 1
  end
end
